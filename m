Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A778C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1A4560B07;
	Thu, 13 Aug 2026 13:22:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kOB4evTnh3ZH; Thu, 13 Aug 2026 13:22:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A573960A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786627371;
	bh=JpDRrRhhXNbQeOrKPGi3LPSYYJ1eGSe/2Y8YrtknNkw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aG3J94n8ny/pW1EHfKxNEBsJ9vk8a8B59apcu+XMWgy59TcFNarjWs59noMNB4rp+
	 YKzt3s9D+wx+51PEc00yCxvg8P+uUVSQaTae82O2JcD7WaxtzC988fczffPOVxppYq
	 0F7eHPHiEFpojRzkzHAXc46lNMVf0q4jOBU06P8kP2vEGMvzV/3Q0nqyPu5TxDRbSs
	 5xUjU5gqtV/qPXcd+WRaOGSSXnZRLPRAkoilTpG0tV9s6A2N5iuLkQ4eXIJ8gOTtgi
	 6QJDhdh2CR9/waKAxgNPUWj5Z5xfZP2uhJOHz5W3GHSmjgaa4tLUcxokm3e4PDE4Ls
	 3lLFmyl2tGKpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A573960A4C;
	Thu, 13 Aug 2026 13:22:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D774EC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BE960A4C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:22:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hFe-YpyxfY2c for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:22:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 65DC0606E9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65DC0606E9
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65DC0606E9
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:22:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=X+tuZ2RnR/x3SQfNXnDy9bwHjEmDthOySrmCEsxi+8jnI4aWHu8pR7C/G/NZ+Wj6kZsUm6MN1XJcma95bAt6OGL1Y6Hl55+ddKeo+YhID4zyGbDtQn1s4MEtvD4z33H5+Qe1+t9OAfR7X9DVb08jcL/kRHawZlazZz4lQiRIs76umMI3erFLgILLW0uU3YBDBof5bCHfTimLeUdEOjli5bg9CiiiFkTt0v4vnf3/kxhiEOl4L6r+w+7s0rcdStJbkEfZhzVRGF8VyuHuISInmCvc5GeTIW6qUXhD6/No608Pq5LMJAsXkQvp4vpZVJKPBFZNbeO8cUwdMa4P3XXKJA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDRrRhhXNbQeOrKPGi3LPSYYJ1eGSe/2Y8YrtknNkw=;
 b=cRF5vjHKFd20JY66ccJbDvXnCrB6Mdf4y402EtRgsy7yMacR8q1Dp1YlWPy7PBO6d2OCh4e8bURCJOnC7dSgYM77uiQAKBOz8+O3vz/h/xgMJvJ2mK7qFNB+q/JIisQBHq9n1u1FHUdiJtP8qDq70DWLJselfv5nbC5vOsEsAg/AMym6NZLjIvt1box+B8M40BtT9Od3VN3QzX9zlArUpY7EnuIlQgG3bIca7lZZ6+crDPl5QQoyD31vZumMLmtRqGw5mASf3tVtpU7QwWvJhU96VecpRziMWjj6/UsaFLHoNzN7/975FM70MFIl0GogzTUt60uAXykPHfD8vJNktg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from DU2PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:10:234::12)
 by AMDPR08MB11336.eurprd08.prod.outlook.com (2603:10a6:20b:716::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 13:22:43 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::4) by DU2PR04CA0037.outlook.office365.com
 (2603:10a6:10:234::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 13:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via
 Frontend Transport; Thu, 13 Aug 2026 13:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMd1j+Nuhv/uVa7ABmZtQQn7YPMY2qkN9ljDY01x0lWLpiz+62FqpvtC3H2rwcqJAVXTmJZq6uWJCoRczXIFvv6QXb82Us2cmEa+UkTyvrAzQ4MwbRqzRor7aZ/Z2AZnv2uTsr0Ow8Pzeeqfahnn5KDjFNsFdI78iznXS2+j+cUN5gcm2O8ZOMCJnhG0H2Y7Gav0chblDuvmUXRW5dC4ZJUAkMsCbBH7alvvmxibM67MvwB4WnPvkrrpkTNsRGjGCXsiV+hMCDhIdfxDWnjV/2wsrYTvwmdaEdAfC6lbfcrycxOHPK/WjesEuGsIHBmK5RhiudDEMYrxqUFjQa79sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpDRrRhhXNbQeOrKPGi3LPSYYJ1eGSe/2Y8YrtknNkw=;
 b=rbdO/LFKSyRBIjEWZWxHG5xOSqmTraCHmHzCwNva+cEpH3bxvf+6dtDJx37ZWOPAzCIdh+R0vx2tkZ4aBKecP9QhEzM7EAFQZEv3nSxO4tPTFrkZYq40wkMyTD+azfNfYsZ5t3K4IE+ukNkuwWc57sAtN3lUamoezpqWu6OWjtqhNexKtMQ464YRfC0PhTBmzjBA8RNol5cHAP62ERRiLFRNBLuaee8Sxp3FBoix8oVPc8+cxJBQ24ZP4QASRLc/6Ak6yyj9y0FqYpcfLeadcV8KTIxaIzkqfG0VQftedIqjU1G7HwssFTV4Wv71JIiFkSx7rdeGRNMY866UGljxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB10970.eurprd08.prod.outlook.com
 (2603:10a6:800:256::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:21:47 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:21:47 +0000
Message-ID: <b9e0f77d-ef28-4a20-a0fb-ff35ee51fefe@arm.com>
Date: Thu, 13 Aug 2026 15:21:46 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 2/2] test: dm: eth: add DHCPv6 oversized option regression
 tests
To: Sean Edmond <seanedmond@microsoft.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.u-boot-project.org,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Argus <argus@byteray.co.uk>, Tom Rini <trini@konsulko.com>,
 Francois Berder <fberder@outlook.fr>, nd <nd@arm.com>
References: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
 <20260806-b4-dhcp6-serverid-oob-v1-2-4ec6857682e1@byteray.co.uk>
Content-Language: en-US
In-Reply-To: <20260806-b4-dhcp6-serverid-oob-v1-2-4ec6857682e1@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB10970:EE_|DU6PEPF00009528:EE_|AMDPR08MB11336:EE_
X-MS-Office365-Filtering-Correlation-Id: fc533460-9506-41f0-b9bf-08def93de88e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: IIyKWzMui/cHWiyHf4R1p/BBD+dYLbhxAMnnW0nYp7899HA510wTEF86D1JJ2wbI6cBprdcptzWe4xOgQjch+v0QbVdBluOCEulHTezeTaoGV4rvqjhCHSOt5cg+IThuk6eElgtxCmosCfPuarkwYwtfL/eQRo04Vj4QYF8ED1M/NJdtFM8I2bGByB1o0jE48Q09knrXMwsgLCh6E6t1mvoYIIFphZ+tCo6+9cqU7oSSHMzCJK2Aq5nXiz0CXdk2gMDzVlB7BgY5swOvAEuoaOTnnPI6qOwooVh5Alg+3udskb2P6G66XuuNGOHZ36WI/uFXJuS/jajcFLpccKfvcqpT3qH6FfWA6upzLH4mJB7rbzxMHWNQNDZ8BqCrqAc24w6kWRe7i1j4dHdTWytioZu1t+KLclzgcX43BKmZnkIEhp9RfRr7ZqiQdjtwa26R62Ir1eAebXZJyjTTEFDlxsniXUEvnrG/S/YN9oj3RfQhXHIsgX1FdxqrRvB4y9SQhKWrAn6oYdbwfdyfBXh+ooHGRPo4fU7yEhaXwUXitJCJI2/xLUUSu8ug+CQa5uy933NJEbsE64Krlf55KPicBywISPZL9L+cfc3sizDEg7/d6JNqFzt51+FpAsmYipCP6jGtqZ7T+Uqh8VCTNv3oMA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nFGB0irNc4ARDXTG9XgtCHkkGOMNUECN15x+URk4nwJjcFCwCepCY9eCtUmC2kyWYK7qYj9LKXDbLnDuJJ2EpzlZXSq3LvFx5Ic59UYDxVluz+3gYxeaxOaOmXnIICDLnrajOHB0lCwGzOG/ZwrhCdWlqSPhKzu8HJu94hX1CsxHXfCzYP7PeodwPAMvU7N2cG5nQ4f/XouIJjRhEfnvI1tzrcCwgR/dwboZLrn0zC9zazYqpSEizeXC/qoHetdljqFcVvHwaEAOvfr7I8A9d23n6KHEaaT1+F/ZgjxFUZqbLao4iQRqsAXFhaAbm5IZ4gyShelBkieWgnjMclypxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9b2b2c2f-1ed0-4a1a-86bb-08def93dd3fd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|32650700020|14060799003|1800799024|35042699022|23010399003|376014|82310400026|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ElpJZBpmRz2NO6Sk/Tp6mMMRUY5eyulyG2KpoJMK/bc4v7hU3DAPg7ZhbSU5o4WiiOPiQZRwCWGw1qBmJe4e4srP/qHa9SMdmrxVMfkwdrG4R7zI3IxO/RaEf07q/aFcocCTpU40Fdjn0KVYyEtO75+AMAfQ+pREcWTC7rL06vyyJeGFbXX8N9UJAaD2sKfACqFds2WAnZh04HKInWgSh2+FiBW/ZzP/ChvIWE4uPVc27pjNW9lIkTfunQhD+jHoYS0wQCTUwoduqRAOqnM9NX2+TPvYsOAiNdHK8QjNhkUtkO3Lh4ue+AWWBnzWe4FMGKDQlC6spReW3haDwCYlnRI8qPMrfCN31MNJEOWTHKUdh77RvgbPLHB27sRPeFf23xn2MixfdM+Z6q4t3kie2N+gT9Sxu8DsBgSDjIpM/cxzZupfLW47lxidthtDAkrqvn4qsjqL3JYc7owcK9K6gUPYRpKdL0vO+utE+DF8K6AmUoakp17nwtsHP99NHrhii9WZEPH4woFjkTYoWpwsEapmPxoieeFd0tzesYqJYty81p+zvyt/SI6OVF3i8ZanetW/z6/W/AWcMy3JealnLu99BIPJW8Ai7xpsJwkPURhrNfCiDz2Vtb2FJ8PcedqznWfE/XOuCxCodpB/Zi6MjsHKi5xykpYenK/mUuWzxLI5mqlZBe74BONpre5K5GbX
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(32650700020)(14060799003)(1800799024)(35042699022)(23010399003)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BQWAyHf7+8yGG8XgVDJvLpF3Pnj4BmTvqYUlGDP3cGDJE8TdBI6npVkfkA7/F/0GFd4qp/1UqExObZogGg7vSeUNfYEwdvR136liC3axAuL8bwwswuxaCZw5Ruj97s+bqYDLBKmdUbKxLMeQvRzspeRBDImHUpXfnstMWzpe4fsvD6MD8YYt8uWXNHxL2WksSKRzTaugtyFFVfYUXann6jZNf7GH6JDNtHq5ZZ2bHWwSKW8SV0vtmj/rKAFIx6rpiMA5UMUS5kagnI0xlHXSMN7kWgk8Keel8lDC8ietEjXd6dSkhR/Z9skbfNQWlfaK3bAk+VWvshhrjv6yJIFdpoX6veneDj4oNJM9eMis568vmlZi6Xfrl7Xxq/f0hhM5DZ/fBa1+jnMxGVYAFzXM7Hgz5lQd4hKd2BVlPSxXwd6pTQqxNl434l6dCvEdsLtJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:22:22.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc533460-9506-41f0-b9bf-08def93de88e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11336
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpDRrRhhXNbQeOrKPGi3LPSYYJ1eGSe/2Y8YrtknNkw=;
 b=ebVAYQw8VR/FOeTU+ndCrrtZhdBSiKWX0B1ABZDKtM0DXvAXqj52qSosU73EZVIDjlr44Sx2lXz/nDSsuMrljAushYzo6ybIadQXmqMYXbaROqkKm8MJ09H6fbCwGyNzqkCYdrC9SkWL7IyvMjF3JXbr94x5KbV30RPWpdAxBQo=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpDRrRhhXNbQeOrKPGi3LPSYYJ1eGSe/2Y8YrtknNkw=;
 b=ebVAYQw8VR/FOeTU+ndCrrtZhdBSiKWX0B1ABZDKtM0DXvAXqj52qSosU73EZVIDjlr44Sx2lXz/nDSsuMrljAushYzo6ybIadQXmqMYXbaROqkKm8MJ09H6fbCwGyNzqkCYdrC9SkWL7IyvMjF3JXbr94x5KbV30RPWpdAxBQo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ebVAYQw8; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=ebVAYQw8
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

On Thu, 06 Aug 2026 20:37:51 +0200, Shahriyar Jalayeri wrote:
> Answer a DHCPv6 SOLICIT from the sandbox eth tx handler with an
> ADVERTISE that carries an option longer than a valid DUID, and check
> the client rejects it rather than sending a REQUEST.
> 
> Two cases cover the option parser: an over-long SERVERID, which a client
> that trusts the length copies out of bounds while building the REQUEST,
> and an over-long CLIENTID, which drives a memcmp past the client DUID
> buffer.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[2/2] test: dm: eth: add DHCPv6 oversized option regression tests
      (no commit info)

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

