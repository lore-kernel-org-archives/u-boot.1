Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32ABCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB908460E;
	Wed, 20 May 2026 10:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gReYqYP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD948469F; Wed, 20 May 2026 10:52:30 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DCB844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lplfxqxiBOwKAPXRxz/goFvatqIGspMT7hd+ri8LqEwcfE/yadJqpBzCYeUuWqt7LuttX1QheU7NzLB2dd8pl6gvUfCecfSMm7biC7gJ9MPuHvdhYkDvkBSX7wpVuC4WVpo3258KbkrmklF/2ywbvyF+5pTzkIJxaRJ6drAkiH1XB/SwXW7sTOaiER9I0yfe0XJnEx+qr3NCNgXjSunpBcd/QPv1GiEFGKZ4/9pTCr7svO6kfMrkBRVnmhhieX2DwHkGfU6evJNnNeNuMDmjvs3AX5qdleC2MMa5vLyYm/cTi5z0QGNEXWVmQNlE/qzgYHL8oaupYS5PPxHNJB1TBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7aAveHS4Z3ATWlFLSDTJjNyIuoSLfUsOwpgGlyJn8E=;
 b=Jttf8voZLTs391I8Jv4CwfCvVKUs4KWdFrcDOJMZ4wslU/6dbzDvplHlvoE4dlqNrg5Bsm9nBMXMzHuUdiWW8BO6b/Jo//F8XHnZVgpZeDdBx1mpvUkLuUmLWOfdArIuWDT3bKj2xMov9hRmj4LP6q5TLNCjBGY4hsv+F/ARcDa3ER56xq9LEmY2+uhnzOnPDg/qcflm6Qv9tPiDUbxDaF5QQqz0smlvH1bhO3UZs2QkWViMPZIqUTRRjEZixk3wKvXo4TvBWyXY2G5JGa0eYPLxuyJ+Y1+cYTWPBV+FOEvkUH00mG5AFzkczsuCIxXRewkVfJ2ZAWsdbH15DvEfiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7aAveHS4Z3ATWlFLSDTJjNyIuoSLfUsOwpgGlyJn8E=;
 b=gReYqYP8MiffZagJi4/csfzlDQIZxZNsvgTWqHALyVy35ujVqMLnjErBPIN6vriN0qkqGe6zZGn3ew/Dtm3vDIXuzDVCTo+9GMJs5Ww2dAGaIaZorauhuUNcbyPGv7hZO/SSjSpG/yKDgtTrVA9W8dhfrWY6yRKHOUowzxxFYNg=
Received: from MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 08:52:24 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::52) by MN2PR03CA0004.outlook.office365.com
 (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 08:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:52:22 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:52:14 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:52:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 03:52:14 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K8qB071637955;
 Wed, 20 May 2026 03:52:12 -0500
Message-ID: <a7a91160-d8c0-46d2-9c7e-e1414b155b46@ti.com>
Date: Wed, 20 May 2026 14:22:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [uU PATCH 1/1] am57xx: restore bootm_size for ARMv7 HighMem
 constraint
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>
References: <20260520083007.2557081-1-m-shah@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260520083007.2557081-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0313a6e7-0b33-4f23-8e46-08deb64d1bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3VWYfTmBZpRW4IF19H2psKrTfCkdC7ztiI30pT88Ul6J0O1pi7qK90HajXKWJON2i1o5rrp0z/A6UQx4YyzN7jY7uH37RpbmeWnMHyCIric+Oh1WUH+i6HaTiXgVA1O7rAIPEpxQM1np0yMBfS4HXTlrvSnNqKXUZCXZTfdR6NHpY2dvj9eBwLe6YW64MJc8DYgkQakGPKafNIC3naGCI6hjAhAhd4huLwWP5jcKw7xa6xxEzoByLR2xpYsoCZeg2WetoGXJn55+RX/ajKToMOrRi59SZRCBu4pT1KFb6jQzFvSgxK+yG5tpPCwJWXA1CC/oGOOqsStQNWXCGJlEBS/TMxzao41NDuz8JHzty/PMtXl/yMEAm+NO4K82Mzfkn1uHzvYdA/1ch6BEL1PtQ4DsQmFA9HX2aO4VkzBpWB671SrU7es52kgrELpBoO0yKewKMLYhcZ6d5n/q5yvoaMSpzy/2K4APc5KUT1gF8idGP40vZ476KP/Wr2xk7Z97BIOt6JQfQVHSZ9O+lab7+3RcfSc9DX973oROso2xyZ2VFsYUMOiqkDQR83Ay45i5a0zEoUzEx6V3H7PEQZOcQTYasU5JhhpNAYWYZVV7T9vgsK3UYUt2fOOPMKatBIZwss7xfQVUEmITC/4V/QoJj5Mwwph8p69qpU/OpiowNkPCWlGKQDkNZjBH1R9h4tXD
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6zPofgYq63niCWWZbhNGNfDjVK8/grfQd+AbKItXANb3y6coYqKJGlM4oStSPqcKnSGM0MXV5E4XOLUqUMtuYeN9AG6i5o5u6kSH9aHOGcoGAKI+58FdbACPgXwSCLeoYf4K8Ww8EYD9QuLpAWbW0Jpp+5lVvRztUweqMEwtkaI/AFKuvLrnF1C95ykENpCbBdx/Nxr+YXny8ue9efy40w69xpS13uUmmBA4woauaY2VT2P6oH2B+MjBy536PTKnk1N55pNib1gGoLwiUQ077FVffVDU/y29YB5ETk0FMRBpptspvdmgnIVpSE5Y702XYLugPaDYLHTrVWxiecWGt3N3BJ4+ABKFlThfV6HDZ16o+StopXHIld3rGiLruDBJjLARu9WU3XkwEGDO1LGq9w0i4fHWlVsrYzvLs0ZL4Ld4/qivCzqdFGHlVpjiJ5iu
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:52:22.9231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0313a6e7-0b33-4f23-8e46-08deb64d1bec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
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

Please ignore this patch, I will send a v2, with the right subject, 
sorry for the inconvenience.

Regards,
Moteen

On 20/05/26 14:00, Moteen Shah wrote:
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
> Fixes: babae80169d ("include: env: ti_common: remove bootm_size")
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
> Logs: https://gist.github.com/Jamm02/4dc37a837eded0490d7f16b457807dc3
>
>   board/ti/am57xx/am57xx.env | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
> index a7cbbced099..74659279484 100644
> --- a/board/ti/am57xx/am57xx.env
> +++ b/board/ti/am57xx/am57xx.env
> @@ -1,6 +1,7 @@
>   #include <env/ti/ti_common.env>
>   #include <env/ti/mmc.env>
>   #include <env/ti/dfu.env>
> +bootm_size=0x10000000
>   
>   bootpart=0:2
>   bootdir=/boot
