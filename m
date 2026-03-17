Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E19F33804
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3274D84056;
	Tue, 17 Mar 2026 07:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c7jR9axY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7888405F; Tue, 17 Mar 2026 07:54:55 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA9484035
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlXDExwNYipWnc1D+dQsHU7Kg6PswQekX3KLE1X+xNHD2SodD2ytyXWjo+X0bgFXij7RsOoykLXQctth5zul4rSGIfWO+g6vRLe0P4jaEjL8vUuhREcGhkl9NNqCKM9dtq0SkdiRpDbXxIF17bkpvuFp9KsyEfC6H+KA2HbkesyrFUMc5dZYOjrnskzVvBsOIM627m+pHpHUiNGZz95juULHhKWeTjgkFt89Oi9kjaQFI29eEzQWxsQMBmwTcAPiGXd64A/wwVVTiXTJh+PGn06nh4DkLlM7RMs3/CPZobDwvMTQyYck2dBmvd3v//vPrFPdXcejQvyDffttqImvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeoO3Ypi9A65jHiZmNTJwtbbVocwX9rk3PSVQky8alw=;
 b=CuldK9WnbAFPXXQKnNgTOGTGq075i4/QaPy6qC4hPFUrkSoj1cbd9H7n8Zy9oFsKQ6OLjZnKI0uUTEsIPhN9vPFUdnw6BK9cdQsPBc1oiU62HCLJNt9T/3Itlx2DFCKNxYQsA+9sXfsDRsiEIf2NOy5YrjArM6QKigsoqARD7S57lalskJATYFU7Y3mSDIcilp2CbvF0HQffmbITJvY6bnsopRqxhNGrVe4HJMcN2rJyuoQfI2xZe8zqRda7ReORMSnINz30151CHl0DCZruXIGLz5LG1Cs/Q12gb4xjeiXfHbIyIYS8eQROrTwxuP19TugBkZ2mLKU5VOLRqI0QaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeoO3Ypi9A65jHiZmNTJwtbbVocwX9rk3PSVQky8alw=;
 b=c7jR9axYPLOumakIhoWSL6bOtDAoQ0NUO2dEz1zUUcCnztVYkMcWENHlCjWCqTAEcunFQ+uFzju6kSUdXQ4DVtLhviGyVAODHhgt2tvt56FeR5zOZ7s47BFHXwE4eFdaH5/76ruvkftxdX0HdvOGJqJR5jNS7TOBUyz4YOnWdu4=
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 06:54:49 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::c5) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 06:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 06:54:49 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:54:31 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:54:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 01:54:30 -0500
Received: from [172.24.25.125] (ltpw0g6znt.dhcp.ti.com [172.24.25.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H6sPOW2222371;
 Tue, 17 Mar 2026 01:54:25 -0500
Message-ID: <783179d6-c324-48b2-be8f-bad84c054d75@ti.com>
Date: Tue, 17 Mar 2026 12:24:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Francis, Neha" <n-francis@ti.com>
Subject: Re: [PATCH v2 4/5] misc: fw_loader: introduce FIP loader driver
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 "Paul Kocialkowski" <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>,
 "Justin Klaassen" <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 "Jamie Gibbons" <jamie.gibbons@microchip.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Weijie Gao <weijie.gao@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Lucien.Jheng <lucienzx159@gmail.com>,
 "Alif Zakuan Yuslaimi" <alif.zakuan.yuslaimi@altera.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>, <u-boot@lists.denx.de>
References: <20260306190542.22920-1-ansuelsmth@gmail.com>
 <20260306190542.22920-5-ansuelsmth@gmail.com>
Content-Language: en-US
In-Reply-To: <20260306190542.22920-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|BLAPR10MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0f912f-ee3c-4779-61a3-08de83f21565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: h8LbwUsJqAtAPzIEalhpr85MiyGz5uPSPMdcFSpZWIVwjEosUMS9BEoZg0YadOJnrNHuvp3k9uTwLsIEhdrZ118n3zAVd0aKhN7z2IbGRJMQQPugHnLcCnV24pwfYxqR/dOCB7vLqdkCUnIi53XTkh7gCZn2yUZlns2udoqBsjI71ZXlC78hQogs0eIdt0VgLwTY7ltpOkPEirpDVahEKbzu2vikhHLP3FxYC6PIJVd6zbKfRfV4c10h8FUvQGVhW3mZqdOhxFbVBmsBMbGa+0MhWLZ8JX6B1B289udfQoh5UoVnKTVrPoN5SKkGqs3uYiMJbtfJHlNCaKfR4lYcCFegblLCeCxawcnodIwSa/jYyxKnjTI2KiULK1Zq+mrRihN58zr8PbZ54EOaNY816dcekfUrNaVKUGW2DQmSepUTI0ypWHVcDNwSDwqhcirNw1z2SabAnF5RyvyWbJBpIIK0cGZRkH3u4xggRncsNtuLwELl1A8pefr6Iqa7J1NQGd22IaafdZqAX4/alwS5reH55ViBKW+XidNHJUMo0e5gynZvcY7uL2/0gcVkEBc492sB7GHj4fXvjnCkGQsMb+gXnRZXiHIO+zJXzyVODpUtvCESO7igDKUcYKz1h1ORe+kBFz0kI5XvBV+lqTixdoXb1VB6kQnwr7ZzPCoF/EMkA/qqd1Q193WMOknpMx/hUXMNJ7W0ydjNGgiR1vehNpA4OQHTz6LxTKE1HsLLtZ9c43EQG9HDmQeAgPPlNd1q/DVtKQAwTTGfI4MkxdBMpx0LWpaFzxIGyl3xnYN8PnB6ufVLHXeCiJwJINqHztvR
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XBrA0kbV8a1jB6Ypbi5KRMSabnyz/8Nm6wqf9ffEnZ8Vq6axIOa7ZB2d2NJ7YsNItm5SFbeQ/jpzvYe31RLezCq+TC/avP4qSw0uptO+8h0XJQAvQXDfqkc0LCdDLVyqYHwilYtkcGKNjqhrGMOj5p/sNm3T+KrepAlgqwhJ/1OWC0R7W66ayJZP4cY7gCwEFv/75ifn18L4aLaM/rsCAeDQuGVqSdzk1l6LE9/GGIYaZqVtO69JU5dCIFX/UGjUbZgFpOlfVVE0cezSXCinAN4CK+pkYQXx/hZdHyvrKRQkatpVYD0D4Z8zJJTgcPAfsQQRNOw9HNTJ41LjYh0Gsu6pfoq3vVQ37QbrMAxqGXDvLHmtQOWar48yK/UxW5Nu60VudvmiWJdcf1KjyLkMONETe/D/bInsTAjYT6cNluWo0FFJN7ZTBx51X2mPWB8C
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:54:49.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0f912f-ee3c-4779-61a3-08de83f21565
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
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

On 3/7/2026 12:35 AM, Christian Marangi wrote:
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accellerator or PHY firmware blob.
> 
> The way FIP handle image type is with the usage of UUID.
> 
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
> 
> Similar to FS loader, this driver also support both UBI and Block
> devices.
> 
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
> 
> An example usage of this driver is the following:
> 
> Entry in DTS:
> 
> 	fs_loader0: fip-loader {
> 		bootph-all;
> 		compatible = "u-boot,fip-loader";
> 		phandlepart = <&mmc0 0>;
> 		partoffset = <0x100>;
> 	};
> 
> 	ethernet@1fb50000 {
> 		firmware-loader = <&fs_loader0>;
> 	}
> 
> FIP loader user:
> 
> 	/* get the FW loader from the ethernet node */
> 	get_fw_loader_from_node(dev_ofnode(dev), &fw_loader);
> 
> 	/* read the blob identified by "58704aef-389f-3e52-b475-e0bf2234a6a2" UUID */
> 	request_firmware_into_buf(fw_loader, "58704aef-389f-3e52-b475-e0bf2234a6a2",
> 				  buf, 261400, 0);
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/Kconfig                |  11 +
>  drivers/misc/fw_loader/Makefile     |   1 +
>  drivers/misc/fw_loader/fip_loader.c | 575 ++++++++++++++++++++++++++++
>  drivers/misc/fw_loader/fw_loader.c  |   3 +
>  drivers/misc/fw_loader/internal.h   |   2 +
>  include/dm/uclass-id.h              |   3 +-
>  6 files changed, 594 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/misc/fw_loader/fip_loader.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 9d332230b1f9..8d2f11de0fe7 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -613,6 +613,17 @@ config MPC83XX_SERDES
>  config FW_LOADER
>  	bool
>  
> +config FIP_LOADER
> +	bool "Enable loader driver from FIP partition"
> +	select LIB_UUID
> +	select FW_LOADER
> +	help
> +	  This is FIP partition generic loader which can be used to load
> +	  the file image from the FIP image into target such as memory.
> +
> +	  The consumer driver would then use this loader to program whatever,
> +	  ie. the FPGA device/PHY firmware.
> +
>  config FS_LOADER
>  	bool "Enable loader driver for file system"
>  	select FW_LOADER
> diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
> index 96baebede788..7854b64148e6 100644
> --- a/drivers/misc/fw_loader/Makefile
> +++ b/drivers/misc/fw_loader/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
>  obj-y += fw_loader.o
> +obj-$(CONFIG_FIP_LOADER) += fip_loader.o
>  obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> new file mode 100644
> index 000000000000..376e1d2a59d8
> --- /dev/null
> +++ b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
> + *
> + */
> +
> +#define LOG_CATEGORY UCLASS_FIP_FIRMWARE_LOADER
> +
> +#include <dm.h>
> +#include <div64.h>
> +#include <env.h>
> +#include <errno.h>
> +#include <blk.h>
> +#include <fs.h>
> +#include <fs_loader.h>
> +#include <log.h>
> +#include <mapmem.h>
> +#include <malloc.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <u-boot/uuid.h>
> +
> +#ifdef CONFIG_CMD_UBIFS
> +#include <ubi_uboot.h>
> +#endif
> +
> +#include "internal.h"
> +
> +#define MIN(a, b) ((a) < (b) ? (a) : (b))
> +
> +#define TOC_HEADER_NAME	0xaa640001
> +
> +struct fip_toc_header {
> +	u32 name;
> +	u32 serial_number;
> +	u64 flags;
> +};
> +
> +struct fip_toc_entry {
> +	struct uuid uuid;
> +	u64 offset_address;
> +	u64 size;
> +	u64 flags;
> +};
> +
> +enum fip_storage_interface {
> +	FIP_STORAGE_INTERFACE_BLK,
> +	FIP_STORAGE_INTERFACE_UBI,
> +};
> +
> +struct fip_storage_info {
> +	enum fip_storage_interface storage_interface;
> +
> +	/* BLK info */
> +	struct disk_partition part_info;
> +	struct blk_desc *desc;
> +	unsigned int part_offset;
> +
> +	/* UBI info */
> +	char *ubi_volume;
> +};
> +
> +#ifdef CONFIG_CMD_UBIFS
> +static int mount_ubifs(char *mtdpart, char *ubivol)
> +{
> +	int ret;
> +
> +	ret = ubi_part(mtdpart, NULL);
> +	if (ret)
> +		log_err("Cannot find mtd partition %s\n", mtdpart);
> +

You seem to not be calling cmd_ubifs_mount to actually mount UBIFS.

Can we move out the common code between *_loader.c such as these as well?

> +	return ret;
> +}
> +
> +static void umount_ubifs(void)
> +{
> +	cmd_ubifs_umount();
> +}
> +#else
> +static int mount_ubifs(char *mtdpart, char *ubivol)
> +{
> +	log_err("Cannot load image: no UBIFS support.\n");
> +	return -ENOSYS;
> +}
> +
> +static void umount_ubifs(void)
> +{
> +}
> +#endif
> +
> +static bool validate_fip_toc_header(struct fip_toc_header *hdr)
> +{
> +	if (hdr->name != TOC_HEADER_NAME) {
> +		log_err("Invalid FIP header\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int firmware_name_to_uuid(struct firmware *firmwarep,
> +				 struct uuid *uuid)
> +{
> +	const char *uuid_str = firmwarep->name;
> +	int ret;
> +
> +	ret = uuid_str_to_bin(uuid_str, (unsigned char *)uuid,
> +			      UUID_STR_FORMAT_STD);
> +	if (ret)
> +		log_err("Invalid UUID str: %s\n", uuid_str);
> +
> +	return ret;
> +}
> +
> +static int check_fip_toc_entry(struct fip_toc_entry *ent,
> +			       struct uuid *uuid,
> +			       struct fip_toc_entry *dent)
> +{
> +	struct uuid uuid_null = { };
> +
> +	/* NULL uuid. We parsed every entry */
> +	if (!memcmp(&ent->uuid, &uuid_null, sizeof(uuid_null)))
> +		return -ENOENT;
> +
> +	/* We found the related uuid */
> +	if (!memcmp(&ent->uuid, uuid, sizeof(*uuid))) {
> +		log_debug("Found matching FIP entry. offset: 0x%llx size: %lld\n",
> +			  ent->offset_address, ent->size);
> +		memcpy(dent, ent, sizeof(*ent));
> +		return 0;
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static int blk_read_fip_toc_header(struct blk_desc *desc, u32 offset,
> +				   char *buf, struct fip_toc_header *hdr)
> +{
> +	unsigned int blkcnt = BLOCK_CNT(sizeof(*hdr), desc);
> +	size_t read = 0;
> +	int i;
> +
> +	for (i = 0; i < blkcnt && read < sizeof(*hdr); i++) {
> +		unsigned int to_read = MIN(desc->blksz,
> +					   sizeof(*hdr) - read);
> +
> +		blk_dread(desc, offset + i, 1, buf);

blk_dread returns the number of blocks read, we should have a check if it
returns 1 or not.

> +
> +		memcpy((u8 *)hdr + read, buf, to_read);
> +		read += to_read;
> +	}
> +
> +	return read;
> +}
> +
> +static int blk_read_fip_toc_entry(struct blk_desc *desc, u32 offset,
> +				  int pos, char *buf,
> +				  struct fip_toc_entry *ent)
> +{
> +	unsigned int left, consumed, to_read, read = 0;
> +	unsigned int blkstart, blkcnt;
> +	int i;
> +
> +	consumed = pos % desc->blksz;
> +	left = desc->blksz - consumed;
> +	to_read = MIN(left, sizeof(*ent));
> +
> +	blkstart = BLOCK_CNT(pos, desc);
> +	blkcnt = BLOCK_CNT(sizeof(*ent) - to_read, desc);
> +
> +	/* Read data from previous cached block if present */
> +	if (left) {
> +		memcpy(ent, buf + consumed, to_read);
> +		read += to_read;
> +	}
> +
> +	for (i = 0; i < blkcnt && read < sizeof(*ent); i++) {
> +		to_read = MIN(desc->blksz, sizeof(*ent) - read);
> +
> +		blk_dread(desc, offset + blkstart + i, 1, buf);

Same here and below

> +
> +		memcpy((u8 *)ent + read, buf, to_read);
> +		read += to_read;
> +	}
> +
> +	return read;
> +}
> +
> +static int blk_parse_fip_firmware(struct firmware *firmwarep,
> +				  struct blk_desc *desc,
> +				  struct disk_partition *part_info,
> +				  unsigned int part_offset,
> +				  struct fip_toc_entry *dent)
> +{
> +	unsigned int offset = part_info->start + part_offset;
> +	struct fip_toc_header hdr;
> +	struct fip_toc_entry ent;
> +	struct uuid uuid;
> +	unsigned int pos;
> +	char *read_buf;
> +	int ret;
> +
> +	/* Allocate a Scratch Buffer for FIP parsing */
> +	read_buf = malloc(desc->blksz);
> +	if (!read_buf)
> +		return -ENOMEM;
> +
> +	pos = blk_read_fip_toc_header(desc, offset, read_buf, &hdr);
> +
> +	if (!validate_fip_toc_header(&hdr)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = firmware_name_to_uuid(firmwarep, &uuid);
> +	if (ret)
> +		goto out;
> +
> +	/* Loop for every FIP entry searching for uuid */
> +	while (true) {
> +		pos += blk_read_fip_toc_entry(desc, offset, pos,
> +					      read_buf, &ent);
> +
> +		ret = check_fip_toc_entry(&ent, &uuid, dent);
> +		if (ret != -EAGAIN)
> +			break;
> +	}
> +
> +out:
> +	free(read_buf);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_CMD_UBIFS
> +static int ubi_parse_fip_firmware(struct firmware *firmwarep,
> +				  char *ubi_vol,
> +				  struct fip_toc_entry *dent)
> +{
> +	struct fip_toc_header hdr;
> +	struct fip_toc_entry ent;
> +	struct uuid uuid;
> +	unsigned int pos;
> +	int ret;
> +
> +	ret = ubi_volume_read(ubi_vol, (char *)&hdr, 0, sizeof(hdr));
> +	if (ret)
> +		return ret;
> +
> +	pos = sizeof(hdr);
> +
> +	if (!validate_fip_toc_header(&hdr))
> +		return -EINVAL;
> +
> +	ret = firmware_name_to_uuid(firmwarep, &uuid);
> +	if (ret)
> +		return ret;
> +
> +	/* Loop for every FIP entry searching for uuid */
> +	while (true) {
> +		ret = ubi_volume_read(ubi_vol, (char *)&ent, pos,
> +				      sizeof(ent));
> +		if (ret)
> +			return ret;
> +
> +		ret = check_fip_toc_entry(&ent, &uuid, dent);
> +		if (ret != -EAGAIN)
> +			break;
> +
> +		pos += sizeof(ent);
> +	}
> +
> +	return ret;
> +}
> +#endif
> +
> +static int parse_fip_firmware(struct firmware *firmwarep,
> +			      struct fip_storage_info *info,
> +			      struct fip_toc_entry *dent)
> +{
> +	switch (info->storage_interface) {
> +	case FIP_STORAGE_INTERFACE_BLK:
> +		return blk_parse_fip_firmware(firmwarep, info->desc,
> +					      &info->part_info,
> +					      info->part_offset,
> +					      dent);
> +#ifdef CONFIG_CMD_UBIFS
> +	case FIP_STORAGE_INTERFACE_UBI:
> +		return ubi_parse_fip_firmware(firmwarep,
> +					      info->ubi_volume,
> +					      dent);
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int blk_read_fip_firmware(struct firmware *firmwarep,
> +				 struct blk_desc *desc,
> +				 struct disk_partition *part_info,
> +				 unsigned int part_offset,
> +				 const struct fip_toc_entry *ent)
> +{
> +	unsigned int offset = part_info->start + part_offset;
> +	unsigned int pos, to_read, read = 0;
> +	unsigned long long blkstart;
> +	size_t size = ent->size;
> +	unsigned int blkcnt;
> +	char *read_buf;
> +	int i, ret;
> +
> +	read_buf = malloc(desc->blksz);
> +	if (!read_buf)
> +		return -ENOMEM;
> +
> +	blkcnt = BLOCK_CNT(size + firmwarep->offset, desc);
> +	blkstart = ent->offset_address + firmwarep->offset;
> +	pos = do_div(blkstart, desc->blksz);
> +
> +	/* Read data in the middle of a block */
> +	if (pos) {
> +		to_read = MIN(desc->blksz - pos, size);
> +		blk_dread(desc, offset + blkstart, 1, read_buf);
> +
> +		memcpy((u8 *)firmwarep->data, read_buf + pos, to_read);
> +		read += to_read;
> +		blkstart++;
> +	}
> +
> +	/* Consume all the remaining block */
> +	for (i = 0; i < blkcnt && read < size; i++) {
> +		to_read = MIN(desc->blksz, size - read);
> +		blk_dread(desc, offset + blkstart + i, 1, read_buf);
> +
> +		memcpy((u8 *)firmwarep->data + read, read_buf, to_read);
> +		read += to_read;
> +	}
> +
> +	ret = read;
> +
> +	free(read_buf);
> +	return ret;
> +}
> +
> +#ifdef CONFIG_CMD_UBIFS
> +static int ubi_read_fip_firmware(struct firmware *firmwarep,
> +				 char *ubi_vol,
> +				 const struct fip_toc_entry *ent)
> +{
> +	unsigned int offset = firmwarep->offset;
> +	size_t size = ent->size;
> +	int ret;
> +
> +	ret = ubi_volume_read(ubi_vol,
> +			      (u8 *)firmwarep->data,
> +			      ent->offset_address + offset,
> +			      size - offset);
> +	if (ret)
> +		return ret;
> +
> +	return size - firmwarep->offset;
> +}
> +#endif
> +
> +static int read_fip_firmware(struct firmware *firmwarep,
> +			     struct fip_storage_info *info,
> +			     const struct fip_toc_entry *dent)
> +{
> +	switch (info->storage_interface) {
> +	case FIP_STORAGE_INTERFACE_BLK:
> +		return blk_read_fip_firmware(firmwarep, info->desc,
> +					     &info->part_info,
> +					     info->part_offset,
> +					     dent);
> +#ifdef CONFIG_CMD_UBIFS
> +	case FIP_STORAGE_INTERFACE_UBI:
> +		return ubi_read_fip_firmware(firmwarep,
> +					     info->ubi_volume,
> +					     dent);
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int fw_parse_storage_info(struct udevice *dev,
> +				 struct fip_storage_info *info)
> +{
> +	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
> +	struct device_plat *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	storage_interface = env_get("storage_interface");
> +	dev_part = env_get("fw_dev_part");
> +	ubi_mtdpart = env_get("fw_ubi_mtdpart");
> +	ubi_volume = env_get("fw_ubi_volume");
> +	info->part_offset = env_get_hex("fw_partoffset", 0);
> +
> +	if (storage_interface && dev_part) {
> +		int part;
> +
> +		part = part_get_info_by_dev_and_name_or_num(storage_interface,
> +							    dev_part,
> +							    &info->desc,
> +							    &info->part_info, 1);
> +		if (part < 0)
> +			return part;
> +
> +		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
> +
> +		return 0;
> +	}
> +
> +	if (storage_interface && ubi_mtdpart && ubi_volume) {
> +		if (strcmp("ubi", storage_interface))
> +			return -ENODEV;
> +
> +		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
> +		if (ret)
> +			return ret;
> +
> +		info->ubi_volume = ubi_volume;
> +		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
> +
> +		return 0;
> +	}
> +
> +	info->part_offset = plat->partoffset;
> +
> +	if (plat->phandlepart.phandle) {
> +		struct udevice *disk_dev;
> +		ofnode node;
> +		int part;
> +
> +		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
> +
> +		ret = device_get_global_by_ofnode(node, &disk_dev);
> +		if (ret)
> +			return ret;
> +
> +		info->desc = blk_get_by_device(disk_dev);
> +		if (!info->desc)
> +			return -ENODEV;
> +
> +		part = plat->phandlepart.partition;
> +		if (part >= 1)
> +			ret = part_get_info(info->desc, part,
> +					    &info->part_info);
> +		else
> +			ret = part_get_info_whole_disk(info->desc,
> +						       &info->part_info);
> +
> +		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
> +
> +		return ret;
> +	}
> +
> +	if (plat->mtdpart && plat->ubivol) {
> +		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
> +		if (ret)
> +			return ret;
> +
> +		info->ubi_volume = plat->ubivol;
> +		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void fw_storage_info_release(struct udevice *dev,
> +				    const struct fip_storage_info *info)
> +{
> +	switch (info->storage_interface) {
> +	case FIP_STORAGE_INTERFACE_UBI:
> +		umount_ubifs();
> +		return;
> +	default:
> +		return;
> +	}
> +}
> +
> +/**
> + * fw_get_fip_firmware - load firmware into an allocated buffer.
> + * @dev: An instance of a driver.
> + *
> + * Return: Size of total read, negative value when error.
> + */
> +static int fw_get_fip_firmware(struct udevice *dev)
> +{
> +	struct fip_toc_entry ent;
> +	struct fip_storage_info info = { };
> +	int ret;
> +
> +	ret = fw_parse_storage_info(dev, &info);
> +	if (ret)
> +		goto out;
> +
> +	struct firmware *firmwarep = dev_get_priv(dev);
> +
> +	if (!firmwarep) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = parse_fip_firmware(firmwarep, &info, &ent);
> +	if (ret)
> +		goto out;
> +
> +	if (ent.size + firmwarep->offset > firmwarep->size) {
> +		log_err("Not enough space to read firmware\n");
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = read_fip_firmware(firmwarep, &info, &ent);
> +	if (ret < 0)
> +		log_err("Failed to read %s from FIP: %d.\n",
> +			firmwarep->name, ret);
> +
> +out:
> +	fw_storage_info_release(dev, &info);
> +	return ret;
> +}
> +
> +static int fip_loader_probe(struct udevice *dev)
> +{
> +	struct device_plat *plat = dev_get_plat(dev);
> +	int ret;
> +
> +	ret = generic_fw_loader_probe(dev);
> +	if (ret)
> +		return ret;
> +
> +	plat->get_firmware = fw_get_fip_firmware;
> +
> +	return 0;
> +};
> +
> +static int fip_loader_of_to_plat(struct udevice *dev)
> +{
> +	struct device_plat *plat = dev_get_plat(dev);
> +	ofnode fip_loader_node = dev_ofnode(dev);
> +	int ret;
> +
> +	ret = generic_fw_loader_of_to_plat(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Node validation is already done by the generic function */
> +	ofnode_read_u32(fip_loader_node, "partoffset",
> +			&plat->partoffset);
> +
> +	return 0;
> +}
> +
> +static const struct udevice_id fip_loader_ids[] = {
> +	{ .compatible = "u-boot,fip-loader"},
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(fip_loader) = {
> +	.name		= "fip-loader",
> +	.id		= UCLASS_FIP_FIRMWARE_LOADER,
> +	.of_match	= fip_loader_ids,
> +	.probe		= fip_loader_probe,
> +	.of_to_plat	= fip_loader_of_to_plat,
> +	.plat_auto	= sizeof(struct device_plat),
> +	.priv_auto	= sizeof(struct firmware),
> +};
> +
> +UCLASS_DRIVER(fip_loader) = {
> +	.id		= UCLASS_FIP_FIRMWARE_LOADER,
> +	.name		= "fip-loader",
> +};
> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> index e477a631fae3..d2446fdc07da 100644
> --- a/drivers/misc/fw_loader/fw_loader.c
> +++ b/drivers/misc/fw_loader/fw_loader.c
> @@ -72,6 +72,9 @@ static int fw_loaders[] = {
>  #if CONFIG_IS_ENABLED(FS_LOADER)
>  	UCLASS_FS_FIRMWARE_LOADER,
>  #endif
> +#if CONFIG_IS_ENABLED(FIP_LOADER)
> +	UCLASS_FIP_FIRMWARE_LOADER,
> +#endif
>  };
>  
>  /**
> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> index fc78a4add59d..5513e043925f 100644
> --- a/drivers/misc/fw_loader/internal.h
> +++ b/drivers/misc/fw_loader/internal.h
> @@ -25,11 +25,13 @@ struct phandle_part {
>   * This holds information about all supported storage devices for driver use.
>   *
>   * @phandlepart: Attribute data for block device.
> + * @partoffset: Global offset for BLK partition.
>   * @mtdpart: MTD partition for ubi partition.
>   * @ubivol: UBI volume-name for ubifsmount.
>   */
>  struct device_plat {
>  	struct phandle_part phandlepart;
> +	int partoffset;
>  	char *mtdpart;
>  	char *ubivol;
>  
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 36b5d87c304f..641d8e1e42fa 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -69,7 +69,8 @@ enum uclass_id {
>  	UCLASS_FIRMWARE,	/* Firmware */
>  	UCLASS_FPGA,		/* FPGA device */
>  	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
> -	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
> +	UCLASS_FIP_FIRMWARE_LOADER, /* FIP image loader */
> +	UCLASS_FS_FIRMWARE_LOADER, /* Generic loader */
>  	UCLASS_FWU_MDATA,	/* FWU Metadata Access */
>  	UCLASS_GPIO,		/* Bank of general-purpose I/O pins */
>  	UCLASS_HASH,		/* Hash device */

-- 
Thanking You
Neha Malcom Francis

