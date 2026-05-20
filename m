Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D433CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 10:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8AA846E6;
	Wed, 20 May 2026 12:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TXdkww52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB5A846F2; Wed, 20 May 2026 12:55:57 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDA23846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 12:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm9VlSobUOSoSE7bsx001YLSppWYQ4UAYWRtibXH96jG0lsctiEBeByEAyUuJtRKPRhoKP24cZC/YrNTy4Ya06/JFgFgDva0x0OhsW7LaIIJ396hUSarzPQapJIkvy4AliT7lk99u0L910tNVcbYq35jxazrqiS7t55dFwB3zicYqPoqvNbLw5oaxZcqiXNCAABYDPQaBeP9VvA/RtVqEBf6xLOzGdNIwZk/z6BtD5Amqfg9PLCeyWi0jmVqOV4l8C6d7BiAUCWNjvhxllrdZBqYDC5XKknoCBBDoZyapHQLZtjFj3YKT7SLkLP4PReHJzfagunu1Smi77gteZgTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYxCeFf6DHTJbyhNIkraKKRqQXKXUGkkxq/jGP9InV8=;
 b=PdCP2tBETWtypPb60mMe0NrRhrPmI4Ps+7xH13SxgyLtQc0pP1ehWHRF7n3vc70gVEfDmLnS0OJ+l0JlvnbV40MNPgsmJYxmIt/zgqZpK9ld52pqbjk4rAP3/oBkdLwwTg0WJD90tNxk92ZEhSOEbzu3xwBKSVXiX9niiZNQGIurPuru9Dxq/WLd208peMul1VyRYrRngP7E5tgQtLVuBNA/iXzyk1T8PeZqAI6Y/jQ/VXwuCCKpGTXfsnVTMGgUPOUDoU2Tg1Miw7PfczIlRHNITjoEvmxqEN+vImc6sXcQ4C8epp1jCEQgIRMfAKGWSsTY991qJm8Wkk9YnFCqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYxCeFf6DHTJbyhNIkraKKRqQXKXUGkkxq/jGP9InV8=;
 b=TXdkww52KlQCZqlQXB32JUqvCVQT0m0ImkTz4mI1+o4p/eMbb62861JAqA3fkMQrGvoG+z7YDTZChCwBCYR3wtkvH+qutz62Adp9Iqx7bQDIoeL2EDxcXXFA51FUQ0//LAk6/SiZyHKmJUc0BvsPhWAgRlT3/qTMFJQ9cZ4zdvY=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by LV3PR10MB8059.namprd10.prod.outlook.com (2603:10b6:408:290::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:55:53 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::1b) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 10:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 10:55:52 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 05:55:52 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 05:55:52 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 05:55:52 -0500
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64KAtntt1301666;
 Wed, 20 May 2026 05:55:50 -0500
Message-ID: <5fd64007-11c7-4afa-bd1d-d8d006826ca7@ti.com>
Date: Wed, 20 May 2026 16:25:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] am57xx: restore bootm_size for ARMv7 HighMem constraint
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <gehariprasath@ti.com>
References: <20260520085814.2561216-1-m-shah@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260520085814.2561216-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|LV3PR10MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdecbd0-d823-49b6-77f0-08deb65e5c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|5023799004|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6tNtAAjklWyphLYkT9tLYpFJOdugyQTy0cXIbswmCTezQjDC1QuUTuMRNcBKUjmUs2fV+XvtAQq7s1nVm1r6ESRRiWjuWFW+f2avrmk4FX4d2FbyrTh1G/2jwY4/r1G/uv3RpvMVQOi9TVIC8nlCReixpEk2u6O+QrYtmLIlFqLWzRPRQ08xkMilHZGflCXbIOCi87cx47Vn6nKZ0d/r8VLVhAnMCRotWZavtRe0sCMd2gZObPrbRgtf2E4IgPuVtri5piAFJgsn6Tu+5VfbPrfsVqy2VMQ+nzOsKXLd/wrWy9m6j9aKaNNJpWxxUFvvlfy2/3DH4ds3RmkFzCKYTysyQ9iyUdZuOScEH1xAKlAw8y4Z5QebkTYteHyQw37DsHd87PQ2C4pGpLU7n9MZ/WV3FbfyA/NHHU0PPZnPSQpYnx1MOVsVs+uSfhTVcg9O5KQRGwm/ahGuB8Doa2aNIasH6oNN32bHgUAlmR0qhWJPIz2StODyQfms3+EtyDHbEPRXN+jENlNAd/WM8/mjD3m5yCmB2+2B5xfvvzvv1CvEkOEAYIMqHQlIM8ek3W3Z7f6c4Vz/xeM5xKkGrW2XbwLiLIUAA/UnhPXrtYxZ/0BQyoablsugGV7msSbw7P2ODUjqxZAkdcGRB9K9jBZFD1MRCiPT+hUyngy+3NsM5SiwxEDj44SOeE3REC2+0hN35SX5BYjcTrXq2JZgMtMtXPQ8aAciS1r711S+2H1MWVA=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(5023799004)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AUsC21lSHFs3MuEwJbuJQpgf5LY02n8r7HjFIRNRPZoLV3Y5VrdaNK3JzigHL0KBSFcLo4CvhXvdbQ9BOIC422scBEJa27ESqVb+Qrb7GC6dLzPvuFV93uGlezpGpo/UrGlmloo1z3ohO0XeFiEZ7UEDaobGy9nfXXqP0L7x1OnRrHjxeVt5NdNHLByBkviQc3kwFJujjCJDEkN9pjIyU0P7h/1ITcQLGwoeGVLOiqVgnlwqbaAg88/Lz6IcqSzu1812yYKu42l11fMK7g3hOwlmgWy7PU2vbC7WvAekxiBxGop2eg9FhWxplY1lzoqf8IS17ihjmN3DITWkd5/SJkzCbuaNaT05x6hjJzGr9K4JmJS00JdeAFWXZDxF+ZaBGROKj/eC3ICYYbtsr0EHOM7BLGzymfVH5c/XNXD54w5H+/YE3fcru8bSwqHXygGV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:55:52.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdecbd0-d823-49b6-77f0-08deb65e5c9f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8059
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

Hi Moteen

On 20/05/26 14:28, Moteen Shah wrote:
> babae80169d removed bootm_size from ti_common.env to allow K3 boards
> to process images larger than 256MB, but preserved it in
> ti_armv7_keystone2.env for ARMv7 Keystone2 boards. AM57xx (also ARMv7)
> was not covered by that preservation.
> 
> Without bootm_size, env_get_bootm_size() falls back to gd->ram_size,
> causing initrd_high to be computed as the top of all RAM. On ARM32
> boards with more RAM than the DMA zone (e.g. AM572x IDK with 2GiB),
> this places the ramdisk above 0xafe00000 (HighMem), which is not
> directly accessible by the kernel after MMU setup, causing a silent
> crash.
> 
> With bootm_size=0x10000000, initrd_high is constrained to
> 0x80000000 + 0x10000000 = 0x90000000, keeping the ramdisk in the
> DMA zone and allowing the kernel to access it correctly.
> 
> Fixes: babae80169dd ("include: env: ti_common: remove bootm_size")
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
> Changelog:
> - Fixed the prefix of the commit message subject line
> - Fixed the fixed tag to follow the guidelines
>  board/ti/am57xx/am57xx.env | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
> index a7cbbced099..74659279484 100644
> --- a/board/ti/am57xx/am57xx.env
> +++ b/board/ti/am57xx/am57xx.env
> @@ -1,6 +1,7 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/mmc.env>
>  #include <env/ti/dfu.env>
> +bootm_size=0x10000000
>  

Move the bootm_size below the empty line (nitpick)

>  bootpart=0:2
>  bootdir=/boot


With that,

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

