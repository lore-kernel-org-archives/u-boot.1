Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048CC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E19F812CC;
	Thu, 13 Aug 2026 13:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLnWwbl853e7; Thu, 13 Aug 2026 13:23:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEAB4812BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786627382;
	bh=/npdzGgsNQgHt0L5vK+EDJA6xqb0N9HZUg4qTtyNInY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fo/i9WDZMqlQNl8hpJkAFtolBwPInsVweB+OfKr7uhl7wUD/SgwZUUeF4YPtuDcvm
	 d92XWA6gg4WSQHGkDceOA8nnRWFOOK2Krg72FO+2BYhhETSHPTo/lgl4oTLIryO4me
	 Wxzcoq/U7aptUW3iwXn46sGyuzdaPqjuW3VobKV8N0GAJocBRKGMPSeMgzkpX3Lmtu
	 4pzoZuRwl2cZZxLGvBD2mc4pSPaCi1qfohvqAYP1yOgkB+nKwfrnA7yTK3l8s9otQx
	 W0Ht6kYRP09doWIxIuGvGn9yTFz8L3GlKXTg9u1JdWln8y7bKs9zC//DJKk/o7OvAB
	 w1tSefn6F/1iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEAB4812BF;
	Thu, 13 Aug 2026 13:23:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5273E3A0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3950E40059
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pad3QFvbFjDH for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:23:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DFB80400AC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFB80400AC
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFB80400AC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:22:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u881GErwIlkEwQMlsccPW/tLP3PosF+EdVnyo9zk+5yJ3DcMj5f5gg5c3P2ORjiqfgEF461rlgL4m/WT2Rpl+CCPJwQCenkIZ5AOIPUWM/pXs+vpXb2fBTNmXBRCbQU4rcn167IxqZ/Do/z1ZvL7fSOjUOndCPuAMhpDsthB26nrq0iw5LVITcFAmratF8l3zDo+5Inluja2GPZDy3UzsPcJ4VnlDva4wcE6rNcPT99WGy21nwhs0SU3SZnooycEcOV9ir4SsjYkRRZN5UnHKkjT94re6WoUrzPV10Gk/M9YNoEKbvmKOc3LbOMniRkrydkVhGs8qicJ1MJR9C7ETg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/npdzGgsNQgHt0L5vK+EDJA6xqb0N9HZUg4qTtyNInY=;
 b=F9PfgHlA3fUln7ekoeOcyrCxsGg6DFPxxi6ahoDdcamdanr8PqIlOkMp7zGQ32++E7L5fy7XeJSs78xb19ew3beK2QrcuJTWGFxYMpRYpAvLjHw5yRYdB0JnkgoKgfEjgCKM+2dG4gjI4J6Sx+NCueHbzBkf0AuLWA1endJv4xXBuL9dsOxDSluVdg+0mA5oPeN4D22MkUM8yOtayk+EIGijuQPo+ja8pnQNotK45iBli14DrA++wxV3shhxAXUdigvedQQeNAknHauidknkCUvsoe1WaGKwQUBqfSZnLgmR0QLoxaUywvHqCGDWZSj5Pv6fgPDUfhE8rXwO4DSJAQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
Received: from AS9PR06CA0357.eurprd06.prod.outlook.com (2603:10a6:20b:466::25)
 by GV1PR08MB7330.eurprd08.prod.outlook.com (2603:10a6:150:1d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:22:53 +0000
Received: from DU6PEPF0000A7E0.eurprd02.prod.outlook.com
 (2603:10a6:20b:466:cafe::2d) by AS9PR06CA0357.outlook.office365.com
 (2603:10a6:20b:466::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 13:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7E0.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via
 Frontend Transport; Thu, 13 Aug 2026 13:22:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkvAqB10ArVG/rOQVd/C86YDVVpOGVqf/Q+uM7ZXHRzrCxh9mimmler/MRRw7DJUf1ww3359FOSO4u24vwTLLZaJoxzTnlw7TYSWsHh1lofENDzaXSOXrCHHidPCZTPoVD8C5pye76cHNkRXeexAp3I8V+fY3rlgNmnNYnrF6Uzduf+7enSxvkYozPWV+3N7acsG1LX8hgAIQ+RuFEfRQ6exZT0D3SRhFqwuNws4+Cel2qAG+qjfH0M5nC2R3O5sRaiasv+To/2xnB7+kdBkgwthsAch2YPz9QERd89W/4pofss/20wLw1uMwuaFa9XTtiOPqDZd78uLDGXRJOknWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/npdzGgsNQgHt0L5vK+EDJA6xqb0N9HZUg4qTtyNInY=;
 b=r/sW/W4xyl2YiKKDVms8LmN8nTjUzsqUCc3NaQAcCPb7x69Whj/dgw0pf1Nnzx2rBlwoawDLpPq0ZmvrzA6unvnUmaSCavTVfGrAtTF6NyvJLzxMarpQ1Hf2FWDb3WLVLH0mGmMOUSwcCENKKBwyeRfpR4FI6PWFnpygEpGFBIQ4qtZ3puIj/Pxo91QvhjC64NwMWIvo9/sEPZJmW1WVmLT25Tqi3b+qLmey5r9ZY4c619gLDcvFcnw24AhvjQMD5Z07fmh0GSFwFNM6nkWSvQqsS6yZOar1d0jkPdOnZNczrHLac25pQW7bioRACmLIy6poXpWMnaDLGt1Teo4Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB10970.eurprd08.prod.outlook.com
 (2603:10a6:800:256::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:22:20 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:22:20 +0000
Message-ID: <681e16be-ffd5-4dd0-8b18-3bd92f560a8d@arm.com>
Date: Thu, 13 Aug 2026 15:22:19 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/2] net: dhcp6: prevent an infinite loop parsing IA
 options
To: u-boot@lists.u-boot-project.org,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sean Edmond <seanedmond@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>,
 Francois Berder <fberder@outlook.fr>, Argus <argus@byteray.co.uk>,
 nd <nd@arm.com>
References: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
 <20260807-poc-dhcp6-ia-loop-v1-1-9d3fd3171c59@byteray.co.uk>
Content-Language: en-US
In-Reply-To: <20260807-poc-dhcp6-ia-loop-v1-1-9d3fd3171c59@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0543.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB10970:EE_|DU6PEPF0000A7E0:EE_|GV1PR08MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4fdc37-2a7b-4f2a-2eb6-08def93dfac1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: JGkgcqWEByeCGpdFwRyAQhSwU/Dl7ifXjLJ6r2qXRGu5JE3/NIhzX/hcL4BZ2JpvHKFHGmhl9kT762oPjzQWFDJj/ILluvw0EaRcvsWTaPW1/UpCBDd02hlK7S+O4iOFHCfjHR6Yo5BDbJHORfEk/lFm8hzA3LnGdg7gBqvERVGkE23/aflokD05trJhcN3+0xp8OHptbVM4an0+NqZ7G2y7vNMnmgQWmCenV19ZTOammghVN5NG5gjkNLG96E19OA1CyQiwJyVym0LK/3gzlcbRO1mtj4jTrv8um1nDYAuIOxCVvq29ZFsI2kPToCHzFloE3Fa+lA5VJsEFHgSqx0grKyU8mvv6MMz4nnYm3tVBPzjwmeKsaHzjrcFXG1/ZEdyrVDIzi3Xok/peOHYVhIpBKYnxgDRFexCzFxOLzELGTUQQz4SpwKnR2D5kpv00DM69PuKn1VUTtCPEIPC6ZhCMpbK9ApyNyIIrgkavQJ6RCMjgIpSBYdzA5EeMu9k132Uut+YZJu/UD/LS1k8FQIBowmQjbCy/cmPc1otqy3c6wDe9D6uEWumM1WbV6S+IWr2TbSIsZeKYqhY4QhKCKgR5M/elh/Li4edHkZhsgAku82MR10CReX8R5e+zGv2ANiclgPMXEngK//adKixxGA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QqTTWekGL+R6il5MI9Id+TqR2Veqj2pmuzDIC39d1a6FhJEzSPZByTKQWMh3jMsUM2X8fvS5j+ezVVGVWl0MOfgZV2eHQGrJeClKRnjccbmB6XGMWN1aqjfcfV+opXFL5Q8EKhBrv6V5lNvizqXUGuqZem0Pz5P2Y92A58MdSI1+G0OT13kIRhnAqYOrocC4sOlwHfo/eCE1gXMAEN5vClmOcjLwuXjVwQzyc125Kh3epkDYYOCCaGFCdrE7QisrRTiHr1JhkJNaeQHN59bU/k9h2/mGBsz8Tq4AnVRsNnvVyci9Jqxx6SwheKbPOLTQ7d4lwN+gtT4NbCSIoU3Z4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e6efb5b1-7a1a-4489-eb27-08def93de740
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|82310400026|35042699022|36860700016|32650700020|23010399003|376014|22082099003|18002099003|56012099006|3023799007|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: IO+8XIcIA5DjocGcU6nG+2KMBMR4iBMkFYIuok9HiVGcZ87EnYsfOcfkdTl7ktQW5iw0YFoasZ9aIksU0QnB1cvWN9jdDCmNIhJr4l/QEa1fTL6zj0E3TobRpy6MkhGlQCofucEk43MVljgmI5bYJDrRBI0KWUXmWHvALXg+4gbODA/kDVpP9zrW2UR3MLxVtND7hJRDjR1wzc4VVZS4Uvot9PRYJ9Ro/WHhgTYlRFUVGTqQezY/HtB96HBr/xF7OYi1sSpkqbX5uF1e1toD1qcIU2qqU5kYJmTWmNHVJiXSq0roK/V3x7Rwj41Pp3fqSvUcGBrPBiSwQwx8WqzY9PH2MI1tX+3OS9dZaLxjWaYYrjb8w54PVRUoq5tO3ARefQ2IWdcH2NO/2YHvv4oI22ZHZNA2NrVlTBq+ZmzB6/3Kqu80LM08zHp+ys+pTsMoZjLmb5RROl4gDd/b4z4SPFSdzOMel4srFFkmkX+NrHzrObEMPKEpSksTmT3sWFyh6jgp/kn72ObKN0ilgQPCJCF58IK5fmm0kseC4rqR/p3mqKXNYooPTbkgUTj9UveQEUZaLl4vb+3BbN/J/8wqwJSDnHeSsLBT5W32rzERQ5cpRbUriOIK1IM/NJdLv/FvdbrHNa71MQhKPLKUbmETddZggJ2hoWtl1BaqG+mc/1/KdCpm3gTWdCDI0yuk1rEP
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(82310400026)(35042699022)(36860700016)(32650700020)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h5zmBvpYk0skFJW0tIcho3elDHq5K6ttpyE/ILKw/KGX7bKINtzTo9TWaX4VaVcEUKATRFgadSc0Crr5MfN4S3Ev+x3qH/fiW9D2oJ/dtGYRmAk4MRFpC0s1YU0WvqCao2gL3h96W2ZtJRqHZP8Jw711eTO9od0t+Z3XO6JKUuR6MdkEBsSXNbpjDHNrbVTx6fm5T0/NN5JSHFdDKZh4r/c41eNbNt/YmU33hNZM44ydZ24FVGKX9q7TPNEhXbfs4tQBscO5GYuGbdLoDqOUkkZEyDUDzWInqDEzDhw0DaOs6JX/HiVXV+zC6I329hJahTnPEl7qX6srxcdIR45I9qM5xhXFyBK2RYHWkOkpv8qGYByc/lNX6BDPJeLEHQItUNlMv/cx9Mxz9SeZ2yvGLXKZcnqL7Q+q9zBLYjRC5YXRKKSSHYzaacYgbvrBB+at
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:22:52.7504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4fdc37-2a7b-4f2a-2eb6-08def93dfac1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E0.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7330
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/npdzGgsNQgHt0L5vK+EDJA6xqb0N9HZUg4qTtyNInY=;
 b=HusfhG8FeQbTGwEH/2VEqX4UxEa6PlGU7jN4KP/K5HvWi/TFfhgashMiHhBTjxIs9I0lW+G4v7ch6clv8vKbybhtZLvJ4ReMOqhGWk5eGCBVFSb6ZwgdVU0ItMGCQhNjTCTTaJnEiosQggnO+TJwVLb+pxqjPXg88JxfLSxSUIs=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/npdzGgsNQgHt0L5vK+EDJA6xqb0N9HZUg4qTtyNInY=;
 b=HusfhG8FeQbTGwEH/2VEqX4UxEa6PlGU7jN4KP/K5HvWi/TFfhgashMiHhBTjxIs9I0lW+G4v7ch6clv8vKbybhtZLvJ4ReMOqhGWk5eGCBVFSb6ZwgdVU0ItMGCQhNjTCTTaJnEiosQggnO+TJwVLb+pxqjPXg88JxfLSxSUIs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HusfhG8F; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HusfhG8F
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

On Fri, 07 Aug 2026 16:52:21 +0200, Shahriyar Jalayeri wrote:
> dhcp6_parse_ia_options() walks the sub-options encapsulated in a received
> IA_NA / IA_TA option and advances its cursor by the sub-option's declared
> length alone. A sub-option with a length of zero never advances the
> cursor, so the while loop spins forever and the DHCPv6 client hangs. The
> advance also omits the sub-option header, so it is short even for
> well-formed options.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/2] net: dhcp6: prevent an infinite loop parsing IA options
      (no commit info)

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

