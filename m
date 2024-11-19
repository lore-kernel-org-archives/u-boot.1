Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40310D6C299
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 20:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1F188B6D;
	Tue, 19 Nov 2024 21:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="XChKmJK0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XChKmJK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169178957A; Tue, 19 Nov 2024 18:26:55 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4E6489390
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 18:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Ben.Horgan@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Syl1T93Je9ZAZvVUloLNsHND/3poop9SlBN2BFMkMZZocneZT3gQ3x7I02cb7N0Ml+JaEnDHaZpjG4Vch4aGUi00xqWIS+kM0RAF4mUxLsdJRxrzIoYq3KVqPRjrmUH+mNw9rxjBYc9f2ks3oTk5apTTWhjVA1cLHhARoXfU5fHYlCKLHDDkla9yB04deN2vvWBLaJ5eXHBme9EaD3SdRDfTOzuRh9blHe43DstfOtvELMS51lxbK+yMBTAnEnZxKvyJuTpJk3hRU8Z5o3/Y/m8tKPapA5OcjtUP//CP+GQuc674wDt3ZRs6xYVxm9dD30Mei3OLVDO/HezpQd7+bg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjtjp/1Ok7cnAnKfrVjkkcfBbxgxEjhrOh7ybLR2eU=;
 b=yzk7etWH0KyMvV4ZLTcm7pp1zE8tojSXNfvkF4nGlmfqfdoarPoMBkdiSJmDVUTtODZnJwlEApLSj7ROp+LP9BCL7y53TJNEUwN7sbblt0nxIVJVTMwDHoHRm/f8d5cvaO40QagjeDGtojAke52bo2me3Ns6bRf4R5DLVCKwhPvFxVxy0DaopshHewh+UGRkx3wR2gL3JzyzioVv2qrX8cz8zZVJGmByANGsndO1XYShBzFwUt/MFs4yxcjGQay9H+EWLF6wrXldzfHpFzK+F2qesADvGJGg/LiWxMsdr6iFk/+xrsqPQ2dXrU+jENmTkEu34OfD31s0qFNvnVKaMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYjtjp/1Ok7cnAnKfrVjkkcfBbxgxEjhrOh7ybLR2eU=;
 b=XChKmJK0kQ2dds6lLUjIAf7K9TbGW3Scll9AQ3ZwXSwIPdy/SKJ0lkitI7+MfLkfagHVta1gpztGJdM71oMWf/XWeihwLLCmdsq26dWShHtGmbRpNGggLh9vSTOL643cCiHJg+2SurHTww1rExrBQw9Zj91r05Eb0FRUvIa/6FU=
Received: from AS9PR06CA0317.eurprd06.prod.outlook.com (2603:10a6:20b:45b::27)
 by AS8PR08MB7372.eurprd08.prod.outlook.com (2603:10a6:20b:448::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:26:45 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:45b:cafe::de) by AS9PR06CA0317.outlook.office365.com
 (2603:10a6:20b:45b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Tue,
 19 Nov 2024 17:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.0 via
 Frontend Transport; Tue, 19 Nov 2024 17:26:45 +0000
Received: ("Tessian outbound bf1c175f6cbb:v490");
 Tue, 19 Nov 2024 17:26:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 794269e0606436bc
X-TessianGatewayMetadata: VuhrTeXmDgvd6IUgTHC+lbgduJTFqOpP+K/xYRtNK6xEXEJAWCeQZCPUIjHUC67x+orCV1PQ3jIbNLWF5mq3lKilkOl38f+2eT6AZB41EUiYSN2ipG3VgtcibmqesDPLS9LPliRv3VLP35Q0Zb/VnlaXxx9Clr9F/ETQrQQvodo=
X-CR-MTA-TID: 64aa7808
Received: from Le17876db6c2f.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 A5A531C7-78FF-4757-8163-B84A046E3D00.1; 
 Tue, 19 Nov 2024 17:26:34 +0000
Received: from DU2PR03CU002.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 Le17876db6c2f.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 19 Nov 2024 17:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2ppbYJbu27nSM9JnetYFryj6u8Rnmu+Ldbl0eIEhCIGQPkrooKhnX85AoPZ2ABbtp2zu4XyrOmzVOat3QaIMkZj9khyYKPV/Q8X2GxCxuAL/znO/CLtNfG1KhR5FdXUqAfs3IzcEVkF7kTYlyiljfy2Z/MIcTTrWLgz9eQ/VuyqeJpnv1b2WCp1On+y2YFQj8uORpK798RuG+7aucJ3MvH42ipBaULTCjLa0qiHn3FxK4WboP1MOHkkopviwlwhIzGvKslBYLPUm4lat1ZxgGsxIQHfa+h2T2LK3ouhSs3kcG2DoXxsQNGj2FPg7mL3fePpGW4DLHJuQt6NdebtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYjtjp/1Ok7cnAnKfrVjkkcfBbxgxEjhrOh7ybLR2eU=;
 b=XNR+2M1tVM16H68sHD2//YC+sYXCKgTlkopP5c+Bm2OHJqOyLIFyPm7nMPG2l9Tdlvyz4/dD6YARQCpNVDnudtUq9aBB7cnlxhQK2ci8onZRqjrRFRDAG/TQ1P2sUbVvhsDNSkx3EKyo4AawTPBtO8yaaO0XBzZ6+5S6hAclatI3BD1ZeAkT49X4DmiF2imOlCnlaSCb/Ow7Fl65AeOFE2NIVlJpZ20ryuwhQlFmwXtySzDLIHO8oB/wnEi8TY+kHyGZABSCFqJNxDjGUDi4DOXlQDtLNu4Vr9EaEROX+m18SaYU0/PeZ6p2EpX7/W3XDJK0OcrfaWPycO6XpD3Sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYjtjp/1Ok7cnAnKfrVjkkcfBbxgxEjhrOh7ybLR2eU=;
 b=XChKmJK0kQ2dds6lLUjIAf7K9TbGW3Scll9AQ3ZwXSwIPdy/SKJ0lkitI7+MfLkfagHVta1gpztGJdM71oMWf/XWeihwLLCmdsq26dWShHtGmbRpNGggLh9vSTOL643cCiHJg+2SurHTww1rExrBQw9Zj91r05Eb0FRUvIa/6FU=
Received: from AM8P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::7)
 by DB4PR08MB8176.eurprd08.prod.outlook.com (2603:10a6:10:380::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 17:26:32 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::93) by AM8P190CA0002.outlook.office365.com
 (2603:10a6:20b:219::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 17:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 17:26:32 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 17:26:31 +0000
Received: from benhor01-p360-tower.cambridge.arm.com (10.1.196.41) by
 mail.arm.com (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 19 Nov 2024 17:26:31 +0000
From: <ben.horgan@arm.com>
To: <u-boot@lists.denx.de>
CC: <leo.yan@arm.com>, Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH] board: armltd: Make myself maintainer for total compute
Date: Tue, 19 Nov 2024 17:25:58 +0000
Message-ID: <20241119172558.438470-1-ben.horgan@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|DB4PR08MB8176:EE_|AM4PEPF00025F99:EE_|AS8PR08MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac13856-bd5a-4e70-c6c8-08dd08bf5752
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?UYj4uByBzjJ9V7E/d6OFGJV17lSjE63+tT9LzIne+HCm24R2RpXWk5q7uEko?=
 =?us-ascii?Q?TZM89UwypvP4RbYftyes1YBr+yKTcvbvxUMBRZJx5aPZe/Rvn5HEnK6Mtf4Q?=
 =?us-ascii?Q?e0TYFLOEDWaFMOclwX1e4U3idaTZfVemGDduJk2qRfs6NYxD10vrj4fNJFAA?=
 =?us-ascii?Q?4Jgt3R2Bx1Fie/9YYmi/YSQlSkIYOP1SP/2p5rM1n7VKZHMx2xEx0QuWwyYa?=
 =?us-ascii?Q?2/r3474QXL9G0lX0hxR6DjlwnXV/u9bWiX5Ed8OiZEw0ToAG8eNEgXD8DIYG?=
 =?us-ascii?Q?NhKfVedyvAybfe2BW/WpszwSllZ39QGNeVqspb83dFtBrBHyNu70SX263R6A?=
 =?us-ascii?Q?O98enDh/YtT5ZJzEhwte+pfAxnfCmcYscjnJGPw78QHNIrXj2MkvQVEGTmmc?=
 =?us-ascii?Q?DojVVWbnFmEGUtNFdbqF0QAbgzS9ceZN+XzdsnON433Sss6l+b7LFvXhV8eW?=
 =?us-ascii?Q?79J/+KosnmDhWSw/TkuBnzgtEwwKDHo8gdJXbH8eIpLm3Ha16YaPrDNmnJlL?=
 =?us-ascii?Q?V74h45e6XpZ8XlegjTVvDJ2Ngm6J/Tuz6V2Y4pcTUI4hGDvwyEW1gcD6ygPY?=
 =?us-ascii?Q?80XLHq/mn5Behl0ZXBf41tCNtbkOFxPfcHey5xVniiPyHvZWPveeuFBkf76U?=
 =?us-ascii?Q?ysOhqWZuVg3jbk6vAEzZv9czvz9IN/S+mZ+tSpwpWKWZU6EQ6bufoW6sJ1LT?=
 =?us-ascii?Q?bmSPM01TC4CqSmI2kBXVlM7djyowxu556iBeA8swP+qzqFCSgv94cvWIsKch?=
 =?us-ascii?Q?KpgD7NWVXEROaUX388rfffh3WoZAxLVppfnFJ1pVGKiGHI7pg2RbwCeQeKXD?=
 =?us-ascii?Q?3DajJhXGdY5nXypjtO1IHU8Ziy9mhUiVafwRTTDD0QMn6gxnO55vWGV/Hn8T?=
 =?us-ascii?Q?6V7ExFEXbChisxVA6nQk57j1oIvro+ymZzxNtpvDaRz+ts5jBQjWtdoiQPhd?=
 =?us-ascii?Q?Lf8MAWScyL7m1n505Jtv6l124aimQC38LJMGVwLZGf7NNAxmsXs3OS1zKKxz?=
 =?us-ascii?Q?IfOckLQY6pBzG20rbjKMUufQvlGMJADKKLMj9TxuQ+1HrcuveilJtbXoyFmf?=
 =?us-ascii?Q?bAUb/p/EFZgc9NwOCQBmybLoPgzyjPNP/xg3itSjc8J5oSjqOOPsL73dWfrx?=
 =?us-ascii?Q?qPaSVT5qg5qxXPHCs4v3FVNRGqJft5W8ccGiOA+vtjpRX0zXXwpOTV9eccvg?=
 =?us-ascii?Q?4RIg9n6Fag5GKgFYofbP3NFLy85sxe3rY1DVgS3jmqLJOJpGnufpZVMbXuhP?=
 =?us-ascii?Q?XsmZ/ZpujUw8n9+qbCiLUX3/+B8wnnjc9wdZEHv44g754+WnOBw2C3ZQzrs4?=
 =?us-ascii?Q?SLRb5lqizINNWnIJw7CLiK992d9aa3VwpXQiY4xC1pQ3yNTASa/z/Sgu9orL?=
 =?us-ascii?Q?LjDAn7MipWDDn6c1HPiRSic4jn4Yc8NhnkAXYwtjOuOAji4Lvw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8176
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:20b:219::7];
 domain=AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa43c58c-e5e9-4217-90be-08dd08bf4f6c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|36860700013|376014|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i1UnrysV+9b6dgXPddKekeMrjkqBmPnudZpI4UsZ6p8wGUJjpx2H/4rNyj5h?=
 =?us-ascii?Q?5PCWBP3Q5alYpfpt7e0Hz0cTR5sfy1KM+EqU00UFESJKr/EgSqNIdHNw2Wbj?=
 =?us-ascii?Q?7tsn1Ubcv3mXku3s/Csm634b26o48l4aVty5XQjml9E+sQzcbTvmHZrVNWeU?=
 =?us-ascii?Q?ArvuWXL27FoTWpNT7XhKHSMlUNHcA7VASyeT4oYYlzA239DLG2DDJETwo4UI?=
 =?us-ascii?Q?i4xuTZDoDhpzYu42B3ISlQJz/k4MiYAdPpUqu3xyRp75GHR8sD0iqyhes1zg?=
 =?us-ascii?Q?AJnrt3P1vthS13ggfssRo40uZMrJl14UwYni8NxZsKuIr0Wwt8/43q9poBi8?=
 =?us-ascii?Q?dvHnL5kpwdP3vG981+XMGBZmYb0Q6tXGpxodObcUn1+zSs/rIpf6neyEWg96?=
 =?us-ascii?Q?Mr2MluJcVEc+8fvfCZc601bjp7iNl7dSRQljnL803EjPioyCbz+pzE71Ayg0?=
 =?us-ascii?Q?q05lcUzsQOFnjOJzxwRp94hAHS6JamcDr/FyyfIdogp8MV/+qrcVWwrtMLdq?=
 =?us-ascii?Q?X4PEL6uKzplQTWFdJDjGbxRNY2omSmtlLIlwqE6L5K+TDkO/z0niEUU19tHk?=
 =?us-ascii?Q?WBDGy6tCIexBbORlgY0v64gMBzUMtUZuP55N2BBgyaeseiiAjClVbTLg6LgN?=
 =?us-ascii?Q?+KI2ioQaFFEpCVV6LYOMQyAfOObVfdfhnIllPRU0B3KmnY+Zj2O4hGVKJ+24?=
 =?us-ascii?Q?mncK3MElHE7PC1oeH4DiWhbrdDqLhfr0KkuWVbtK7+3H3Iwn8UEeilCIOTEf?=
 =?us-ascii?Q?u5cvFirFK/mVPgU5QC/STlJW4Du+o6IoQuKTzuVxYK21R0jU/xuwg6DSBOZ/?=
 =?us-ascii?Q?gVcf02LFC4RaweOs+1Lutgzu2rTFiVAqEl/+O4Zt0p+y41QLG8qqHJzKJaKK?=
 =?us-ascii?Q?Zt811PRGD2vRQSg2WgZG40w5bIri5rxodMK8dFZqkz1ZejFlRtYRBVZy0kjl?=
 =?us-ascii?Q?wtlbyx4JpI7nkJYcfepjc9Bw7xUQmpUFM0B9pdTLDBppa2lkmeUXI8ChyEjZ?=
 =?us-ascii?Q?/qK4vMS12m0OOroIKkaIfkkWdwi0fAIYYN4qf4TC2oj4M6ET0IDJeNvZ7jcB?=
 =?us-ascii?Q?ywNRE+F/q9quJga+TiqhMR/WFQlLNJYoQZaZx9E8ODY0WgLU1EuE6cPAti9d?=
 =?us-ascii?Q?OQfE2T69pBkBmh6BeRa5UDXjmer5owrFiKg57Ag1su3La2/V7UNUOlY7XPjA?=
 =?us-ascii?Q?MWhKbvk4Eichb7c/2rn3H6Ma58F07eVMxVEEmPF1+SV/ndFeF48U6Io27ta4?=
 =?us-ascii?Q?ASdSMZbR3bGFsl83M/dz+GlQRR6rgnTaLsW6MR6srWO3uN9JDGh3l5gx7uMZ?=
 =?us-ascii?Q?q8r6sR9LlVvwobIfrbTbWMvqbymOrwtxv8REkw6K0h4iIc3gWU6R7ACbs7Aj?=
 =?us-ascii?Q?g5Db+mPCO6gEkf+gR1IIk1T0Dr0D4yIwKBQKALvq191Tt8ULzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(36860700013)(376014)(35042699022)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 17:26:45.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac13856-bd5a-4e70-c6c8-08dd08bf5752
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7372
X-Mailman-Approved-At: Tue, 19 Nov 2024 21:54:26 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Ben Horgan <ben.horgan@arm.com>

The previous maintainer is no longer involved in total compute.

Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 board/armltd/total_compute/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/armltd/total_compute/MAINTAINERS b/board/armltd/total_co=
mpute/MAINTAINERS
index 3dc1cd188a..92486f4193 100644
--- a/board/armltd/total_compute/MAINTAINERS
+++ b/board/armltd/total_compute/MAINTAINERS
@@ -1,5 +1,5 @@
 TOTAL_COMPUTE BOARD
-M:     Usama Arif <usama.arif@arm.com>
+M:     Ben Horgan <ben.horgan@arm.com>
 S:     Maintained
 F:     board/armltd/total_compute/
 F:     include/configs/total_compute.h
--
2.25.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
