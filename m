Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FEDCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 05:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190BE838BB;
	Wed, 13 May 2026 07:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WblRGB8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A096183E36; Wed, 13 May 2026 07:31:45 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360978341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJOA3posiV9Wb36AtJ/CeJE4cELkoev9cteinPXH0nO+qDer1bTckrIhmWq6cXHTLIwNiIdPXrIr1HPs2II4PgZ+NuqKfBD1cGVCh3vQXf9MFKHqXp1oTKNKxc1XCqTBp/NU9KA35ZUKuw2A88TnHoxmO9jXHcHpLZTriIfdtgbuetHJ6YKjDaSFgudIKMR3DRgO7l3ueKcbs163vynhcDB/kIgttbPsnOVTWZwVX1cJL3AQAnqDZSG819N2zuX3N1IpR9ZfHP+ihZyv5wnG+Rw1JaWVOxSIlAf9OnUcxkG3lOJB0007omrQfbU+FdUX8C6VOvNx90svtx2b4WDAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g14SMegsmCwj0lWmcFKTIDbYOsPiH4tlyLefx0Ng9Zw=;
 b=DEiz5AxDB9/TuXnyGjf0iv3CVjqJkp0yFXyorkBvPqSVlfFrIXSL17T9rbzWq7Oad3dCveGLG61lGlYtG31amyZJuWXQMGWckml3xtouwEniiPpadL7H8JSBf8bbT4SRJVuH2FtQrmMo0ETmd08xSVXlO2BSuUP71/NJJCxlo2dh/mpO7cDLG2xI7moLKUAfjpuSm1c5IBZmG/IjpgxvoAljUlnNOMGvt46Nhd8D51Wbj3WUk7ZT5zU/uifQLyxpVuFyQYJru9RqecSBox097rzXISelJr7L5XxCIVarReB8DHwSi5+HctrLTxl+afS0sZ5kMoKk7HCgBbqyaOQ1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g14SMegsmCwj0lWmcFKTIDbYOsPiH4tlyLefx0Ng9Zw=;
 b=WblRGB8sFGbcJ9Yg2Q4Psr1KM4T6T/+isZQv56K8v2TEyRwFOxlHRmDLWzR5V8axbDHMgJjRRiVm+4IQByLNNHqfogQcTK4mJOmtaAh5H5fEt8g8cOxWa3PlleL7DfJu2uqzlkqyI1b4Qzr6nWNPgkaihFUdLMVf4wj7bb7MNTo=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 05:31:40 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::55) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:31:39 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 00:31:39 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 00:31:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 00:31:38 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D5Varc3383821;
 Wed, 13 May 2026 00:31:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
From: Neha Malcom Francis <n-francis@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernestvanhoecke@gmail.com>, <u-boot@lists.denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260512174438.GP1858239@bill-the-cat>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
 <177857908918.1655329.7242382998405759036.b4-review@b4>
 <20260512174438.GP1858239@bill-the-cat>
Date: Wed, 13 May 2026 11:01:35 +0530
Message-ID: <177865029535.2037938.14829007973486614845.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778650296; l=930;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=mBZfPrE/MOnZ5Hp3TpDd9isGW7AS/D6UjuzCP02Cp6o=;
 b=3cvcJVYxmWsfsSaOs/O0h/kSiXSC8kCSUmzGrkL8TRWjzC86sdvp9WlXIDA0K9CPilRr/pd48
 7NqsTvT9JzlAG5X4mm5eYXx5K2x/X+9LkhSLY+UHcWKni7Di1zwAO79
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e960aae-3146-4047-041b-08deb0b0e8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ghchcb4OJhqW+U92ecIF27cAda43yS955T5qTvb9uF5qB0gM3d0ahLSgGoj528H/54Q7eHB/wZUKcvGobnfr8yoaSWbSP/rnTtRoKHjm2NyauPBPl/gONkjFnjItQn3M6Dj1bg241acMX2SY00+vpmSHPmvII1EJ3YEbFVoDhgIrp6yz8GI+x6G6ClIDkeGMKd1wIClYyqCrvtsD16jGHMNv+9iLcBk63ykkCHD0FbaSyBbxYwkvdHofBAEcaUtoQRkijVshwy4p5u83vZxZW5yJ16sWsfV9a1OYDn/KtAtdLocTuTK8/xXOrQWRUre6AQBip/ohyGk+JvIoAQB4XVA2PRHFm+h5zoc1BXyHNVjiC3f66FlTs6n76vOM9mWKC/2jdoHZ2syewSRWMEG+L98ntfNrNHV0h6Y0GSr12YocL3p2bkMbyDNvqS0og4W3fY+ZGqnZRmP3YrZCXFY+o4yFBQux2SqrI9WLL1tCMydywVSa1nZtz79/9v9O44DaSlWsz2qnB37jcbGJNr4coMuPUd4MI1hnhUxXC90c4TCQFiqBzsYYEvI5CNsmwRRP/f/w1GJ07TM3qeOcuXC0C+C6muK7PSAoPFAcm5dIbRLTRpZ4fqFdFAH2iuK05fwYGmnv2gjSdDFhXFPIG4N36NZgrrMiQ4BWAaWKd5CovskXYVKPDdh1TU1PppLngyw99H1qfcBL1viujWKRMh7/XLwf4/k3jZDAm2GMDWrEei4=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4/9ED+L2YQJPelpTuUYXIPHI99NjlogCI4hTwI2jdJTC8mpOMscFcDh8fsmE4820AdOoVfPRffzEdp+dBlr9VMcs5MstxlVDuAE8O+TBje8cpHlCoEZ2OIQzR1uwcOnirwOM/WMSepJFtP8msaC6DGhV/leZRq+40Xb/mMJbBaCZ4FQcx3NQIzO3+mUWF7e10puwnuUboRHByD/JFRSvUYi4F2JpIerN/a3qTxUJxdT41DK7F94yoWFryUpQuibFyT3a+NfmVokTUAAzsez53EcviKYR5WYgjfGeqIcdtO4q8JVPryAgMj5sDLQIN4gGfiOqAu6WDMzGL1FGz6qZ3bspsYrkrIiq7zIOMfQSbOYvkFYxUFGryYUaSbLYaVz+oR7CmaiKCujl2qmqygzxCYnxz7EhOGdgfJ1Oe8Hd4PrFplThmRZYVWm1Zu4g2vyR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:31:39.6120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e960aae-3146-4047-041b-08deb0b0e8aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
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

On 2026-05-12 11:44:38-06:00, Tom Rini wrote:
> On Tue, May 12, 2026 at 03:14:49PM +0530, Neha Malcom Francis wrote:
> 
> > On Tue, 05 May 2026 18:36:24 +0200, Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> > 
> > Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> 
> Out of genuine curiosity, the Message-ID here implies "b4 review" was
> used here. Is that correct? And how useful did you find it for this
> case? Thanks.

Yes correct. I've recent started using b4 review to help me get on track with
upstream reviews. Personally it's been quite helpful. I can track only the
patches I'm reviewing, and quickly give A-bys or R-bys and look at followups.
And you can get checkpatch checks done instantly. So all in all, I will be
continuing to use this further. I'm trying to get used to using neomutt as well
so that I use both in my workflow since you can integrate b4 review with neomutt
as well.


