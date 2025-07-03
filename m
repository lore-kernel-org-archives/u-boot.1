Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B6C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 12:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322DD82EA9;
	Thu,  3 Jul 2025 14:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="mS2Pl1th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DED88206E; Thu,  3 Jul 2025 14:55:06 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319F28091A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  3 Jul 2025 14:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDVPXzm1/I6U84skm3A/nU9nX9DtIOOgzoSwi4IG2zE184olm4IVGXPuqdGunRsb8clWe53pDXBBZwVEEL6DgeULXznZN51OeiJFll2xG6398pR6mkQoOdWy3xdzwGIc9t8VlhTgr0SBam2cT3ap0iPQaciC4rEFAzYhtASOvWwkKNOgOONJ0RBkaPSmv9TaIU1vJMLZnZw7fa8jl0pYQXpOQ7r7CoTHnYt6DFGqmZjVJddZzyNEbTufQMxo5GbydlPQg49Imlcdn5MazwVI2/4b3vlA4BRV6ZVl7nBOyoulXwFYE3firD++Rj3HWkx2IFY0riS2uDhhoJJmH2f5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2LI3G5yfWP+6KdN4zk+vkvCuV7eBQ30/5yB6h1xiWo=;
 b=YdH6kqxAUgiRV9TBLQHspSzMYuXj01/2W4pg0/IXvYc8344sRjiYaFhWiDvbkJKfpqBPaVG/E+SaWXEHVP1MY3V+SLnxH3YrzM8K9/yllO8py5woyMgZDncYxqEAc7hnik4ag55eRBSFutosDLL4CzaR6s3w+GcOB2L95abjpibqNnZctBB60vCrObSqrlWahBPk9mvZg4ToeA8zYm0GHsnVQUgEm+5bbs+91Bk4W8GqjQUpwVauo71tYv1r7Hn77yrkFlMgYhRfFWRn+imovZaz5tAmTY0h5BVIRYXuPxrzOMomRUS9hupTO+6CRtApJzW9COkmTCrFWW+qotjiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2LI3G5yfWP+6KdN4zk+vkvCuV7eBQ30/5yB6h1xiWo=;
 b=mS2Pl1thjTTNzHswKuYt6VRvIc7lQB/+prZQDn+p0XeTITUPija4vCZKwgCK0KR4G4kxd/JQqeXLiIkpcooDMKPjhd3av3AiiJ+StzcB/jGVfnz0cFKbCEzFLjJtUBhXbCjz/79jyx6nezWS8hivJ/+WDo5q3XTicK1PFT+tcgNEZWCirsMEDGCoshiEoBAIbEFWNzo4nEvnBJuPzmxtsn/lzhQxrvTd1jLY1JnfoHA+JJpb2C4UUSNYnO8hotavCM7YBW4S9s795UGOG75funxmGmOcPPCWQ76bXsgxxCnJe3CWWDE02B3azhHJa2kdA7uLc0DkMGxd5roSvQ8mxg==
Received: from MR2P264CA0074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:32::14)
 by MR1P264MB3618.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 12:55:00 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32:cafe::89) by MR2P264CA0074.outlook.office365.com
 (2603:10a6:500:32::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 12:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 12:55:00 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2FF3E20DD8;
 Thu,  3 Jul 2025 14:55:00 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de, yan wang <yan.wang@softathome.com>
Subject: [PATCH 0/3] Binman: fix signing an encrypted FIT with a preload key 
Date: Thu,  3 Jul 2025 14:54:51 +0200
Message-Id: <20250703125454.61174-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|MR1P264MB3618:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8e5ec060-0dc2-428b-a858-08ddba30d23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w8qcfkIxiXeqzYTZpr4aUkCwSLDOvBPrHrkUAENmj2u7FOpPIrdXpz5fShxp?=
 =?us-ascii?Q?HG22YY/zgy0vb6rXoIOrYBXURHXDNxMRE0XBqNN0p+F5+XK+XVF/Oy5QYult?=
 =?us-ascii?Q?BOZnvUebuB02WyNacHNDPPxAjTD0pDXV75P38p2T09MAFOHjLntHMJATFfSo?=
 =?us-ascii?Q?9JopXVpIsgQHinxNOz00BUrmoybz9R69yUf20RGbyicEYFUuJAf1OqqI6Tgq?=
 =?us-ascii?Q?auVpAiiCX3DskZw2Lc+u/VDOdzaROZA3z5JK9NCg0qqVw9JF2TxYw2HCkdG9?=
 =?us-ascii?Q?qS6gp4W7jwWvu3yDeC3cNyF72YTRfmtnmSDx4MVtMbiqSnWmWCxakBUEeLva?=
 =?us-ascii?Q?qO0jdy8fhS1E94j6uxGuwoekxdgh1Co0xytx2YOsdWsVq2tdpKTk7yIpcuH1?=
 =?us-ascii?Q?nij7voUVT/uCC8sN7g/11NMBTzXirHOr7xtB4v61Zb9s4BVEq+te73O5EZOg?=
 =?us-ascii?Q?V6eEK87mWpeSmkWOdN4ZzxzVI77zWgVb+KD+U4YMvvfm8WsNVc0kPwlWpSsX?=
 =?us-ascii?Q?406nk6+w9kl8f+jjT+q8l95D+Ek/I4F/VQyVqyXAJfZx9tOg/YK9mooRN5Z7?=
 =?us-ascii?Q?3KmiX+CEDCCO8aps0jz2zYCGN56qc+Duf52LDt7ihChRGp4fVmYpgwU0Tick?=
 =?us-ascii?Q?Qz+Q6LG5L/p3QM5ntIKptJJHmPtdmrvqI5a1nhbUeo8IbYfiW1tLvWzvrm16?=
 =?us-ascii?Q?cYidrq0S3viuu65SK92cZCZowIyERptVX/GPoadtCx4aCEHcbnnCJQOwjC4B?=
 =?us-ascii?Q?GOeQOJ6wUmX9Ek1Pxt0Ml4ui75sZ9JmgglTahynOx6wTa3UTySccjzZYpv7G?=
 =?us-ascii?Q?ppWqOcyYWQVsQi+7JHGDx0a63pNGnBCnvZq3IdgAb/w+yF8+1DPfh2KwOYNx?=
 =?us-ascii?Q?ufp02nAo2D3s7LDjiUBbKUTG7Srd6mISRLhvpmLIkKk0wIflDrm9h6vqIjEx?=
 =?us-ascii?Q?xRVEM+kUNel9cGGRihC0FK10bCgjyXY/oTE0Wg+JS/cDBXEIpHSxawcXpjkU?=
 =?us-ascii?Q?rQF4cRx1GZm6zpzhvi02N7Rehe7Nsjxz9T+pf+agAanbidT0lq+O4ctZtq8r?=
 =?us-ascii?Q?WJLSfsxtXYH785y07jAMvall31XOzbJosL4cGTSCbPbeuuPlRLyLCm1YXwPC?=
 =?us-ascii?Q?zhoc7V5/G/4ybPZ7KnczOraGL/46BINzkBj1bOf52po7vVGvQxBnUxpgf7fs?=
 =?us-ascii?Q?IQf8VXYNXv7qWC01nZj0IHMTM5eIAXaBdWxE0wAO/piiJ+JyL5MBVlcRDjqc?=
 =?us-ascii?Q?GmuOMAQGFJDm2cN7sKccB6uR/5+dcsenIixY/D2bdBV1YFVLNDLj80pa2Jha?=
 =?us-ascii?Q?0JrabITjzzfSXlUjg1xFYijEcWi0Azm7O51ocBQx9iuZir7LYUhFpoYQDkmP?=
 =?us-ascii?Q?qhxJr951PbH6egnrnoBac6sbi+N/SrLoKq2i+cVTADikZHtdKt7dpvdfS+iP?=
 =?us-ascii?Q?iLbwsrC15jkawYKce2MGZbY/co/IaFvBAHMFX71fFEvj+2mDWxTgcYRHfHuw?=
 =?us-ascii?Q?qdCVHrFj05moWbmQyNlHDWJ/xuywsJISUiZ6?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:55:00.4400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5ec060-0dc2-428b-a858-08ddba30d23f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3618
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

When running the test case testPreLoadEncryptedFit, mkimage has been called
multiple times. Each call to Entry_fit's GetData falls into Entry_fit's 
BuildSectionData then mkimage is called. The last mkimage is called after
the image has been signed with the preload key. As mkimage uses a random
IV for encryption and the timestamps may differ, There is a 
mismatch between the previously calculated signature and the 
final fit included in the image.

During ProcessImage, how can one tell when exactly a fit is well generated,
and stop the useless mkimage afterwards?

Paul HENRYS (2):
  binman: Generate the preload header and sign the data only once
  tools: binman: Test signing an encrypted FIT with a preload header

yan wang (1):
  binman: Fix signing an encryted FIT with a preload key

 tools/binman/etype/pre_load.py                | 12 ++--
 tools/binman/ftest.py                         | 17 +++++
 tools/binman/image.py                         | 10 +++
 .../test/336_pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
 4 files changed, 96 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/336_pre_load_fit_encrypted.dts

-- 
2.25.1

