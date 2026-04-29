Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAE1FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5CC846DF;
	Wed, 29 Apr 2026 09:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JIDEoOvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94428846E7; Wed, 29 Apr 2026 09:21:50 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D14F846D8
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H71hKKCLwRwQAaQuOx2feGAN5bGfMnHa2PSIL3GZy3XhxzskqD6Z7P1oT9hiuWCsr6VQxiO5KDczD9wZcuvDQPIHy0MfiLCqiyyoUFVQRHA94ghcsLIr1kTNGShPdOiwrloq4Av5EvlwOjF3ljKB4J1umxmC43IkmYZjKpTZG3Q5CtQKUTJk9ZPusrvqD329vYu7doVTtI5GdUCP2czGSIu09UEBiq0F53FmBQgQaADyblGGYnxzI3v/oXkK+75tuC2EvD950wQbSK9im8B6LPFP5WFz+djn9Dej9cjrCUuFJ6wWO1qUcoLifnnv8J3vFinNhroZhCLPIOSipUjKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIwJey3bo7vTz3S8e1h3ZJqpITjvLw111H/LZYz/OOw=;
 b=Fs4IEcADD0NqEgqnoy/A/Gv73iAoV85Nq/0AwhSbR6Oo2Le5XmTIi9qbQ2eUHrvJa/6A9eZxOY8ObRleTjHMSBQ/fkuxQr/pNMhNPQ4zoZDWTaQbC1T1n8R+kr0Np9M2H5f8+qhl1+TE0ZmaMvHOX7y1Vh9fwhCUVyB1l7xvVkMH1qbwomx6OJ1XWbuYEE5lxGTlcYHB5LeRoN0AnR5e3d6VcMRCEwgp2lsv3oFQpjTJqOWVcZPXauq6E2VCCbE8Oo3uLcTVPUJFbeljf9ODzf76MHjoEcWvUwD5ay7/pn2LG1RQ4fIaA+JSmmhTKb2UXXya4A4nminpW415GcGnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=infineon.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIwJey3bo7vTz3S8e1h3ZJqpITjvLw111H/LZYz/OOw=;
 b=JIDEoOvV7cGuJkKlIKtetNM1QLJJQG9N2kT2eB15k9HKO/IaYQsfspb32xJYdXKT/d6Qc8WPgzaD9UydaWoQRb8Des2uKUdQ8KtJF4QqfwGkrJ9xFoWzmqHlyjW9ptoPB6NPjGpO5eLYKPL+BcSvNqjzTiQUduRa+pqTgaY1ur4=
Received: from PH7PR10CA0015.namprd10.prod.outlook.com (2603:10b6:510:23d::17)
 by SJ5PPFD9B14F409.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 07:21:44 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::63) by PH7PR10CA0015.outlook.office365.com
 (2603:10b6:510:23d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:21:43 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 02:21:43 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 02:21:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 02:21:43 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63T7LftM2625053;
 Wed, 29 Apr 2026 02:21:42 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Apr 2026 12:51:41 +0530
Message-ID: <DI5GHDQSZVJL.2WY7OPMAER9IA@ti.com>
To: Ssunk <ssunkkan@gmail.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
CC: <takahiro.kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spi-nor: Update XM25QH512C to XM25QH512D
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260424102343.1087-1-ssunkkan@gmail.com>
In-Reply-To: <20260424102343.1087-1-ssunkkan@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SJ5PPFD9B14F409:EE_
X-MS-Office365-Filtering-Correlation-Id: 051b739b-4895-4298-1723-08dea5bff722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bVw+Wze00KmHfHaiB0EI3vWNLDD/rgdA2uS9Ozh8jU+iEv/wdgI9ybvbwRZZtuGPjJmKw4bYTfBf5HEzCt4Jzyuqwve05EqWjiWJHzeIrdtqTYC6Uyou36aFPZmlcS1VPwtZW2dj4g6K09q8TdOAlORFQ2i3lTGMSP7o/EjS+6nbWGLdEfTjBMWZtlA8HxgQ0DaRYrfaZvrecGbu1+z2miLtc3tAIaVSf0ne4g7BHvi7QpyP+y+rMPySouvmm6y3NgNYiHKQQ9zO8CLhY8z38Tkqy+jlHEbU7tILl1J4dw8Aihy2cySBrPN4+vYnj5+Nc/57DQFFVaQAyBjKb0UtaJ+/bIY55UU2BNibEnOaS26nsuUETFwqjgAAEFzNUG2GK0RDQU2atxYMLRnGpRNvV1tJH76bbnYMgTN4SsMPwtICDmmk/8LX+crcbUxVWnIfMuluFpN4is0jVlJT7kC9QFsvbWni/bo1xxaVMxq/V9MObCKJwqJ0mSFjajFk9pK7zXo7rX501TjtNbFJzvoCDnNygcKJlnJkg8z0EiRKMGhRMtDnBQcAgL7MOS5TLMCZQ8DmmAGVH777T/cWiy63ss0zkN3lhnNJ87n1oHgs88PF1MrpSZ45OrP8zqrD8aL8aUv28F4Dlt7ad+awGMtKIY8cK6MXUg9Cz+OUg/q7iGV6/zjXB92AIkhI4A4Zhn1Q4XSNdYob/CMwJexg3wcNvvnWRbN06w4Ce7b0kx2ZulU+a7hqSq+6y6zZDRxDuNqV5WbM2Rzz3dRpJKD7O/B2JA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1Ui3x7SAFuBLWO2Ng8DjD/ZBirya+L6sKKNIRqMktTONvejEUysbQKrwZIbJdqmrN7kG28CPDH4qK4J49eyjmBTFmk0uNTBxK0rUTqQMJ9iBS1g5LASWzNqrkC9eU92LAdoHfYQT89QBc1UkSF+TDgRB3jDOacjKvk84ItYJFL8zEtklPSxfRP36xjUknnlf9pjle2lyFZ1bIv6QnzzqjSi1HlSZybo86vNZ5rCK4lv6cMSUjigo8/+aq/0nyw4vydQcfEMThnXpSaSjyA8Qk8UzVl3PfIlXoIsE9Yu6BYtc4wNd3NB8xzP1FxTPvyWPwQeWSRN3TdDUYDFKbyIszJ2DnwK4A0p7hKFBZakvmdXtYV0Q3SpmLVjCbzotZLE3hlQK3nqCFU+V4We9lqqCQlXFfrcccolwn3FruiMkUfEzEzmqlUT5rtCQeE5qpnLr
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:21:43.5929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051b739b-4895-4298-1723-08dea5bff722
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD9B14F409
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

Hi Ssunk,

On Fri Apr 24, 2026 at 3:53 PM IST, Ssunk wrote:
> The XM25QH512C has been replaced by XM25QH512D. Both share the same
> JEDEC ID (0x204020) and have identical parameters. Update the flash
> name to reflect the current part in use.

Please provide a Signed-off-by here along with datasheet or the product
page referencing the change to the product's name. As I see now, both
the parts are listed on XMCWH's website[1] with unique names.

[1]:	https://www.xmcwh.com/en/site/product_con/960
	https://www.xmcwh.com/en/site/product_con/671

Regards,
Anshul

> ---
>  drivers/mtd/spi/spi-nor-ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index c0fa98424aa..3b8e309e0f2 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -672,7 +672,7 @@ const struct flash_info spi_nor_ids[] =3D {
>  	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ) },
>  	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DU=
AL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ INFO("XM25QH512D", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DU=
AL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DU=
AL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  #endif

