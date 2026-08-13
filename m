Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ADCC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 475CC811D5;
	Thu, 13 Aug 2026 13:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohnspkjGa4JI; Thu, 13 Aug 2026 13:50:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44434811F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786629043;
	bh=m0j57rh2QnQurez1nmPU5VwxH9GaaFn/85vMmFdsgwE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HkW45gTxx7S/q5H5m1pTCAN5Al9HZl/p4YOc95HhAkpjkRT42ytt1OTqL8hrnyoqp
	 NO4VtbqXbq3NAfPE2AOz7YqiDIM8j8edLzSOsBIHObADmiC/9QGsyNfqUf1DyFf0wm
	 /KWdDdJYLd0R+0f7UKLISW2zQmfnxVD2sdh9Imeh+sIYkbBgFgJ2coV5YRihyw53zG
	 vI4sZLBVwCkK1Gb21ojAYZ4UFQ3Xpsyg8f3dghFfAImK5CUmwsKaUfbnz/DAfeDvs0
	 l7YHgAO9/ec0dqFeNEeYmo6VD7ahaT3ZHHkJTwkH7hlXPCApJHaaHO689zOLchrqbK
	 nu+CmPvvYDz6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44434811F1;
	Thu, 13 Aug 2026 13:50:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 746A6198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66CC9811F1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r-JcFo2CYtnL for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:50:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 28AD0811D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28AD0811D5
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28AD0811D5
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:50:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HGd2u3JuLEH4QLFRPUvpET0dMrtDD014fnPGgmCB5JEtts++zFD9t9mPMMUEG8Xec7lupJj+hXAcX+zBfOZx64G9IeUPLRWd5QuX4TEXkI9/TZNduK0fy9BpC20mD+OVvBec7Q1UdtgRYR4nJ1wf6j3JPDOryfJ/vQnxj54siWxRX2O7D7WrOyFK12Y0OyqIuv6e4whxwZQrt8xXN0rKrrcFSICLQOB9pPNFPM/MtQoC60N4ytcca15bky2ChRshatPFSiAKU+IW3+r/qcvPwcKXN+l/g/xDoG/JjcW7ln3+jerYjlNpmAzRCY25xu5TpAH2ez6MZeHJ2PXJ3lqDbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0j57rh2QnQurez1nmPU5VwxH9GaaFn/85vMmFdsgwE=;
 b=oixrniYMFmAIGLR9yaE//uJjKJXP/WFekfjpz5z92QacmZGGIuP+NbJPDOofwCMWJ0FQ5l3pLh+mWhrW9/4Mq6Oss0eOZo1ctl5HCP552fDxfnuJKgQ32J5XCvI7g5RxJHKHWN+xT1OLZoJI2K6Zy5nHxY1sAjUyANfb5ANJoQIjOw6bqU9b3yOxTTeWCE9oM9FkDSv+E/MjNr5H3qS0QRkd+wgo4DzYit8vU5JFSIqpfXyrPA62G1D+dMtXAo3BodHZIpFrBHxOFDr8h5E01pBgBebEfCeASKxVyKaM25CTcP7WR2+J3fHy8zPboyp09m49ekpvRncQK4iUBRpGmA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS4P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::16)
 by PAVPR08MB9507.eurprd08.prod.outlook.com (2603:10a6:102:313::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 13:50:28 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:20b:5db:cafe::5a) by AS4P189CA0027.outlook.office365.com
 (2603:10a6:20b:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 13 Aug 2026 13:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA/+OjzScf0aqREhaWI2r5DU9fz0dUA/aZxDxDdxFXfWO9jQUUbvAyDw/TmJ+p1l+Eps+PjKhMrJd0+S1rG/MwHL0ggYHEP4i4jYH4sidSySFM573V4Y7qshwlehJKtocvyB4RoYw0FZw4y1FSu13S9lVMuqlUY/GLII2+IpKY/raBUJ7A/mtCyHeeaBuhmnRfVNNWZtmcTO/8XJLyiTJ8OxfMcBX9ceccfOmXNU9ZplkmZfwpvnrwwZM/gI4v+LKVLrl6jLCbdMzxjzrVtyV33R1jdF3+PyIgbUA7PsS9HY2LLxZlJCk98mjmqQRLF+jdKHKPzaC4rrgwxw5ScYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0j57rh2QnQurez1nmPU5VwxH9GaaFn/85vMmFdsgwE=;
 b=bHoYeAjaPHoNq5tKGtKFecBBcw4ycJ0cH0RFM7zHOAmVgHvD1Emv7tENnOIMkdMSPAVdMN8tgcS5vELVVB8ZCJIHB7OSlVHGnreDYTpf5MUfQPtL4OQGNu37YVHnvxfo1mzBRs5ii1Ktm4hHROZlLd7dj2qn5q5qab65j1LFRpgvcCd33m/QQ2jv8OmD4JLWx7MqCrK2LEc5i1safrWo85B8KmX7LNubQqjT9hfH8xp6aCgbrG2ycKcGvMKjQkZNMhsQHaNdn3v1S2XrH9m7gtJg1a/ueOJ8P24E9sz/6G6MYDsPMXqEWzU5oa/KytLThEYKFG1Tz94bwm1k5P4VcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA4PR08MB6063.eurprd08.prod.outlook.com
 (2603:10a6:102:ed::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:49:56 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:49:56 +0000
Message-ID: <a1ff3456-ba21-476c-a2ba-8bc68b14691e@arm.com>
Date: Thu, 13 Aug 2026 15:49:55 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260813
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA4PR08MB6063:EE_|DB3PEPF00008860:EE_|PAVPR08MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7bcf7e-d698-4932-7221-08def941d5a2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: NdGNCSHl6VCmRcSaIiUD8gMv3HF0AGTFcmbE69IWZT2LtJSi9viU5x6CcHkdjrxS3Bnj9E/7a3eE3LRI+moo+tzR6i+EXqj0szbzIzLNK+iIzeHBxNRDvMt0FEryPJkkG1qlaqoH/i1n+dXmGxJPPAMZMsDf4+MgnZ0ccO2O841iJOTTZNqwUAG9TrqG//qsaPqGLd3uv4EqnpLjSdeXpVNU2th1fTgAzDKb8DFFcsqHXqV2c/keni1Xc8qHJsqAirD4ctxEuUxzO4pbpUgS5RqeKNBvN+i8qsK/TZU07s620EiXpKgQJuD/39dH0XwCDyGTEsU82aGTisT+rzcCJEemSf6f7triSfWDYnaoY7T5XtC2+JJ+yLJAbpFvokjGIxchd7mSSc67SljUlbet20cZ1hBrsh1EY+GNmGbI0RXbDfelejQ5PP0ZriKAWqr6QC8oh2zDoNzPCfkMKz6SPiMN18XQ0HI063S0c003HXS/YvUT2mLhbGswVZlfWQYsrBVXVqDOrYs+dEK0axVkNniGlWqGAQFrK+78tMKfGE5Pukw7qG1+M2QY3VLLqXJTAocYoCVsmUow/wGJ1G2PaTLdemNniO4kpsc1ffnHi0I=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BAilqcPVP84NGA9MiGzK1Lti7ERN76/sWOdBzovz8GXfI4gldP/LyAAE1Fk7yNQUbU2vVvvMwkVYZmqMXZC6xcYeGthLE0X7+e4XuNtCjtibI6GaFGLR+M4GuEhVBBODav/mNWpZ7gIe5YTJrZt6yZ44KsKxqRDefp6IJwJwmv0IAlmOU6wUqZrf7BBU2A2sXo1vAgvJad7vGWhm9sIxkpO5XY14GMahD51jy467f/UmGGf5/JmXK54TQoJU10qM20LH3qalJiqsYJYfaa57HL5sT/JjZthlaeL/JXp1jeTkmFQC3wV/pTvkCfXjImX63Tk2vdsS7CBF2eUDoTsaCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6063
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 195f49e2-8d53-4302-8835-08def941c265
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|23010399003|35042699022|82310400026|376014|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Arofc0/AhI+5R96T16bfPylkOKcdnxpet8CfHx9g5Ww74fSruIpZMGW3Gh94EmI1xdTuUhkHOGeHewXBv4Y8cofIYHJORbZVB0QaJ304esdzLAAFqXCFsF2+EErHSBXoowP0MlJbMFRYxKLaflIIPVDEjjZvTHKRpLpizawExXUXc1mX2bzbHFWbj5n99hWvveSRFilTz6m/LXcvkW/jH4UcACaJRkdnR/LRe7hhzgQkyU/5TWy30vEkc96/0apLwmVuWJPex4NaLsKsZLVllRl1a0MY0G+AZgNgt6SQmDGBfczOZr3kCGle0VkTXEvYBVzcP4FkRqhVGEd3CSdOFsQge4rfAio19JYXKfotTbBi3ZXHxLJmNUMyXxmyU70XO55XWyNxwnbb1W5KcRPLm/ZczEX8SYL9meDYwNpScy6eq1Y8L96+pRcYMMeHiHg1zPd7x9yk69lXhEN1wxUJWwd8XnUyxLtjgFZ298c1bMZOf7cOh3wIxUeVR9IzFfYdzM9YcWalmAUJfCwUbtM81LnSHxkH8OO672RZl6j5ekAK9FH2osssRBM7o3CffH/HIi9zjaBfXINqiZ/lTOH3naShGuUDgDxt5zWDCnQn3Aj13yuE7IwQrFjhi8zsZ35ejMOPfSoAEI7/zXgPimB8ug==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(23010399003)(35042699022)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w/o9kwGFw1wvKd7m/LnGbTq+TUhBNhlkE/e2+PSy5BhyKC0oy4TTcY/6BGiM8PCDODkhkwwEH8kXrNCwc6O9zrPnIr02LXLfaaD4edee1oYrSUAgiN/vi23e1NLBWPZzIprwibjz5PjwZhlJZ3Zdw7IJjJ0JCrdVd6bFH65x0wpIbG6o8yT9Td4a+IDRZvRL5G1aTUl47W9WBN1vui+NJZn4UTsCrG02zA7LJkr0EHe+026sCK/NrCDdkvBIu4+H2oVi4gyUbSzVAEH0GTU0VVL606D3DXRjCxis+LwHe3ixDDhA54xEH5eiZi+6cwIm84pZUFc3K04jQ6SVGcRFPXi1sB8+O2Izwea2wl3XCaTjbatkYWqD2Ch1xjZh4R/Hc5lTILcPIzk/sCg4s9Uw4wF+dyYkmSoWeY3O5/eTwca5DTtCPHh0x++Iz8PSq+oD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:50:28.5094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7bcf7e-d698-4932-7221-08def941d5a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9507
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0j57rh2QnQurez1nmPU5VwxH9GaaFn/85vMmFdsgwE=;
 b=CvylaAMyLwDKKRlPj9ddIELY8Zz8AzZxRIgQ574sAFauydtC8TZLWNXbd9RDOOoP8xN2DBq7JynO0Ao85v1qypnNq4ZerxC1p+m5kn2wlIXyy5eA+awTZjS6VpVUZeDERiYICkk2k9lMVzDREKyk0/yWoXwPgHeFDZJ4X0q7Yek=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0j57rh2QnQurez1nmPU5VwxH9GaaFn/85vMmFdsgwE=;
 b=CvylaAMyLwDKKRlPj9ddIELY8Zz8AzZxRIgQ574sAFauydtC8TZLWNXbd9RDOOoP8xN2DBq7JynO0Ao85v1qypnNq4ZerxC1p+m5kn2wlIXyy5eA+awTZjS6VpVUZeDERiYICkk2k9lMVzDREKyk0/yWoXwPgHeFDZJ4X0q7Yek=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CvylaAMy; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=CvylaAMy
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

The following changes since commit de02bc0eccb76aec8272abed651c35ab120f4844:

  Merge patch series "i3c: dw: fix slave device setup and probe issues" (2026-07-22 13:10:22 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20260813

for you to fetch changes up to b752e4417900ae51d4d8fda879a5594db7025698:

  net: srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG (2026-08-12 17:02:50 +0200)

----------------------------------------------------------------
Pull request net-20260813.

net:
- phy: dp83867: enable extended read / write for driver
- phy: fix duplicate eth_phy binding
- Drop unnecessary device_set_name
- dwc_eth_xgmac: Return -ENODEV when phy_connect() fails
- nfs: clean up bounds checks in nfs_readlink_reply()
- rtl8169: add support for RTL8126A and RTL8127A
- srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG

net-legacy:
- Fix out-of-bounds write in IP fragment reassembly
- test: net: add regression test for IP reassembly overflow

net-lwip:
- Add tftpsrv command
- Handle chained pbufs in transmit path
- sntp: fix netif leak when ntpserverip is unset
- wget: free mbedtls x509 cert context to avoid memory leak
- Fix DHCP fine timer interval

----------------------------------------------------------------
Boon Khai Ng (1):
      net: dwc_eth_xgmac: Return -ENODEV when phy_connect() fails

Graeme Smecher (1):
      net: srand_mac(): fix -ENODEV crash with CONFIG_DM_RNG

James Hilliard (1):
      net: lwip: add tftpsrv command

Javen Xu (1):
      net: rtl8169: add support for RTL8126A and RTL8127A

Luca Jones (1):
      net: lwip: dhcp: fix DHCP fine timer interval

Markus Niebel (1):
      net: phy: dp83867: enable extended read / write for driver

Murtaza Munaim (1):
      net: nfs: clean up bounds checks in nfs_readlink_reply()

Naveen Kumar Chaudhary (2):
      cmd: lwip: sntp: fix netif leak when ntpserverip is unset
      cmd: lwip: wget: free mbedtls x509 cert context to avoid memory leak

Peng Fan (1):
      net: Drop unnecessary device_set_name

Pranav Tilak (1):
      net: phy: fix duplicate eth_phy binding

Shahriyar Jalayeri (2):
      net: fix out-of-bounds write in IP fragment reassembly
      test: net: add regression test for IP reassembly overflow

Weijie Gao (1):
      net: lwip: handle chained pbufs in transmit path

 cmd/Kconfig                       |  14 +--
 cmd/lwip/Makefile                 |   1 +
 cmd/lwip/sntp.c                   |   1 +
 cmd/lwip/tftpsrv.c                |  11 +++
 cmd/lwip/wget.c                   |   3 +
 cmd/net.c                         |   4 +-
 configs/qemu_arm64_lwip_defconfig |   1 +
 doc/usage/cmd/tftpsrv.rst         |  73 +++++++++++++++
 drivers/net/dm9000x.c             |   6 --
 drivers/net/dwc_eth_xgmac.c       |   1 +
 drivers/net/ftmac100.c            |   6 --
 drivers/net/ks8851_mll.c          |   6 --
 drivers/net/phy/dp83867.c         |  18 ++++
 drivers/net/phy/phy.c             |  29 +++++-
 drivers/net/rtl8169.c             | 103 +++++++++++++++++++--
 drivers/net/smc911x.c             |   6 --
 include/net-lwip.h                |   1 +
 lib/lwip/u-boot/lwipopts.h        |  11 +++
 net/lwip/dhcp.c                   |   2 +-
 net/lwip/net-lwip.c               |  45 ++++++---
 net/lwip/tftp.c                   | 188 +++++++++++++++++++++++++++++++++++++-
 net/net.c                         |   4 +
 net/net_rand.h                    |   2 +-
 net/nfs-common.c                  |  12 ++-
 test/dm/net_defrag.c              |  36 ++++++++
 test/py/tests/test_net.py         |  94 +++++++++++++++++++
 26 files changed, 613 insertions(+), 65 deletions(-)
 create mode 100644 cmd/lwip/tftpsrv.c
 create mode 100644 doc/usage/cmd/tftpsrv.rst

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/973

Thanks,
-- 
Jerome

