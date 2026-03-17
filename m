Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F8CF506CF
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 06:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6053D84020;
	Tue, 17 Mar 2026 07:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qasrzopo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA5884090; Tue, 17 Mar 2026 07:06:21 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8B383BC8
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsI90nTPoBZHzPShDY1MrHTFVEiwxjXFBtXA8I1ouehQDMPIRuA/oRaCuhFy4Tr/oMf+bjfE37fVCWzFQJQ9tRzeIQLpdpEWUeIILeK1Cm8b369wZO6HVWYuYnCeHTCpL7+OuqHfQf0vg06yEoPjDiv/8DE89iyVDouH3WhDfbhXZl7fW7TW3xoozRCkGKkq44N1lmiHJfLoGaHBEFd+mSE5U1xO/Y+pi6eLGXsl5YcPWxcaxqf98Hs5tBETAwr16ld9pCdaUzr1xrt9JvEqWX6LqGCf2V7iC9b+c5F7uMXb/nZOFC0DuT0ob4fB9WfOdzuWnTMUS6v5qWcNIyh0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a63gUk5dyff6BUodnNn7QXRcLc3HhV3aPy9u1VOjC4U=;
 b=JpIsB6zZoPGz+6PDMkqoUAAJiirQ7EfVSWEdEvAalt83C9gSJf5tjTQBekidRdvJ4P+rv+seB6qypAMelGxeedrsYztqX8Cp/6Y839FklcdB7L9iiWsB2s/A1McSakP61xfXMX+rJKvLtl5p8kJaet9qpi92DPVK6KiEncTOwmyV5hWuSTIDW8H2Ok/D28h0p5turNala3ddUDnuptwAbKmLudcJhumNis1kqwBrfOhe/Z5QXdJVlB0jwlrM3kAqLEvC/9mnbHgLZf6OOHpgcTgkyq7epZUXeT9xXviHUSIRRPTq2yukg6XxFuTyn8807mPP1wXMQTvvq8XkPNOl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a63gUk5dyff6BUodnNn7QXRcLc3HhV3aPy9u1VOjC4U=;
 b=qasrzopoO+Iz6rgxK3H1/J2QLkILrPFZNx3IzsmyrhdD1z+4xD+Dh/jkD2ce692Gtlo4pBjRjNw5QcknwPUyPSoMPr1UwAuhv8hBiyvt0r9bAQy4pcjOhqN8RBwy+PRwKCkf+akpJADFrnZkeGK46m024sfB+G/TYbCZH1kTXcw=
Received: from DM6PR07CA0052.namprd07.prod.outlook.com (2603:10b6:5:74::29) by
 SJ2PR10MB7617.namprd10.prod.outlook.com (2603:10b6:a03:545::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Tue, 17 Mar 2026 06:06:15 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:5:74:cafe::36) by DM6PR07CA0052.outlook.office365.com
 (2603:10b6:5:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 06:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 06:06:13 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:06:10 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 01:06:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 01:06:09 -0500
Received: from [172.24.25.125] (ltpw0g6znt.dhcp.ti.com [172.24.25.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62H664S52634588;
 Tue, 17 Mar 2026 01:06:04 -0500
Message-ID: <c8845577-d0aa-4c90-931e-290c2f7161f5@ti.com>
Date: Tue, 17 Mar 2026 11:36:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] misc: fs_loader: reorganize and split to FS and FW
 loader
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
 <20260306190542.22920-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260306190542.22920-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SJ2PR10MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 13989f12-885e-4799-d833-08de83eb4b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|921020|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qijXarnHAX15K1RfqYwiDtJa3/g31gpS7Usn0YioPIAjh+YJlfcHkg2zOYfzNToecNGcd1W71s7njUtfBY3H91gPIpnNk9gs1tf4msd+GZKyn1hOoetn2EOVNUhJT8Jyz1nuqBd+8rZf+FpG8YGb4RV4npo70oLy5eRqtxTYLS6qXPqDkSfjLWRIWNkG9lHK1k1CK+Mm807ItG9/6iNrjfjqq7wehM6Z9/d6ZDncRcPAuAHsEeeso0EPzp4lfnGLeLcFXQ764/Xq3+zZvZ0rFAL6B4c043JASURYunIrSnGYr/YAq/1YjCLiKMg9U2rPkyOrCaUVZywLa9Vb8blLBKkr41B6dc1TSfL3Pw120fqrvWrkRVlTh1mtYx+w90zAh16fJ0aYSgKsbOMOVMsFZLFRY7VpVIBFfndtwFSnbJNUyJ3blQhXcl0ouxPVxsATd5Rnydn5axZRHCCqkilmfnMDgpmLHaeiAy2C8oqqROSSX1YRPLzDOoDHMr0XoKOgV8ipa6gsGTMEcd8IfQy9++rmYL8G+lY/oxyssS90DLBVsakvv+K1/fp8+ZgtJChuG5+7mvqaOF7JgL1y8NJ6yqqKrxmhT4nm/hiQI4Nyyz5eaWtlpAeO054Abl1XbtZFCf3BqElvGRgAOadtnaeNNdy7fdlGrzNZWZz8TW7yKkU7XfvRJ1UpD2E39ZBX+V5CYj8qtCPtxz4s3+EvKjyY9+sY4nhRN7I1a5CGMx8OUBKofWVnxiTZJutZs6ABYssVB5F1vEzDti77dy9RgrXnuA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(921020)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7DaZ3jsNZ6tSetcnFZFBby9Yx4TK3K41BX/hyOf93NXlZhhl/ozf3PHqhB9W77sEYEBBqDdGEGlVE78YR8K75eRL/wOxbad3RG6u+XU4RRMgiZEq3F6NLe9eEc1UELvfoA1hJreezGbJ11glFjJ33yfFOjmspSO4c9zbZvfiyozEnmmisZwFQquO7nlb7B7dDdMwX421sMfmkq2K2qBUNnH7As5yX4tiD3fvbrNNn2v7beSRbirve58TsGivdEIvvUzcniqTyRs3vwKhLA4jBhO63NaC1shzAxCA6raD7id+yixwAi4vphbLUjs8xYtowsu3VYtSh3DZpt26HDgPVBeZk+tfJ7hju6uQXDqlei512809Gihd8+cNiS9FlPU1bTms8xTBmtPxSzkK9PMfajZYF8FGP4VeucFHMy8bEtxDoToyThsTR4BPiQJSbpnU
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:06:13.2328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13989f12-885e-4799-d833-08de83eb4b13
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7617
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
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader function and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
> 
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/misc/Kconfig                     |   5 +
>  drivers/misc/Makefile                    |   2 +-
>  drivers/misc/fw_loader/Makefile          |   4 +
>  drivers/misc/{ => fw_loader}/fs_loader.c | 134 ++---------------------
>  drivers/misc/fw_loader/fw_loader.c       | 121 ++++++++++++++++++++
>  drivers/misc/fw_loader/internal.h        |  60 ++++++++++
>  include/fs_loader.h                      |  47 +-------
>  include/fw_loader.h                      |  19 ++++
>  8 files changed, 220 insertions(+), 172 deletions(-)
>  create mode 100644 drivers/misc/fw_loader/Makefile
>  rename drivers/misc/{ => fw_loader}/fs_loader.c (60%)
>  create mode 100644 drivers/misc/fw_loader/fw_loader.c
>  create mode 100644 drivers/misc/fw_loader/internal.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index a0aa290480eb..9d332230b1f9 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -610,8 +610,12 @@ config MPC83XX_SERDES
>  	help
>  	  Support for serdes found on MPC83xx SoCs.
>  
> +config FW_LOADER
> +	bool
> +
>  config FS_LOADER
>  	bool "Enable loader driver for file system"
> +	select FW_LOADER
>  	help
>  	  This is file system generic loader which can be used to load
>  	  the file image from the storage into target such as memory.
> @@ -621,6 +625,7 @@ config FS_LOADER
>  
>  config SPL_FS_LOADER
>  	bool "Enable loader driver for file system in SPL"
> +	select FW_LOADER
>  	depends on SPL
>  	help
>  	  This is file system generic loader which can be used to load
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 1d950f7a0ab2..c1b83d576bbb 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
>  obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
>  obj-$(CONFIG_FSL_IIM) += fsl_iim.o
>  obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
> -obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
> +obj-$(CONFIG_FW_LOADER) += fw_loader/
>  obj-$(CONFIG_GATEWORKS_SC) += gsc.o
>  obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
>  obj-$(CONFIG_GDSYS_RXAUI_CTRL) += gdsys_rxaui_ctrl.o
> diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
> new file mode 100644
> index 000000000000..96baebede788
> --- /dev/null
> +++ b/drivers/misc/fw_loader/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-y += fw_loader.o
> +obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
> similarity index 60%
> rename from drivers/misc/fs_loader.c
> rename to drivers/misc/fw_loader/fs_loader.c
> index 7e432a7ebd62..4ae01b9c8f0d 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fw_loader/fs_loader.c
> @@ -25,25 +25,9 @@
>  #include <ubi_uboot.h>
>  #endif
>  
> -DECLARE_GLOBAL_DATA_PTR;
> +#include "internal.h"
>  
> -/**
> - * struct firmware - A place for storing firmware and its attribute data.
> - *
> - * This holds information about a firmware and its content.
> - *
> - * @size: Size of a file
> - * @data: Buffer for file
> - * @priv: Firmware loader private fields
> - * @name: Filename
> - * @offset: Offset of reading a file
> - */
> -struct firmware {
> -	size_t size;
> -	const u8 *data;
> -	const char *name;
> -	u32 offset;
> -};
> +DECLARE_GLOBAL_DATA_PTR;
>  
>  #ifdef CONFIG_CMD_UBIFS
>  static int mount_ubifs(char *mtdpart, char *ubivol)
> @@ -109,37 +93,6 @@ static int select_fs_dev(struct device_plat *plat)
>  	return ret;
>  }
>  
> -/**
> - * _request_firmware_prepare - Prepare firmware struct.
> - *
> - * @dev: An instance of a driver.
> - * @name: Name of firmware file.
> - * @dbuf: Address of buffer to load firmware into.
> - * @size: Size of buffer.
> - * @offset: Offset of a file for start reading into buffer.
> - *
> - * Return: Negative value if fail, 0 for successful.
> - */
> -static int _request_firmware_prepare(struct udevice *dev,
> -				    const char *name, void *dbuf,
> -				    size_t size, u32 offset)
> -{
> -	if (!name || name[0] == '\0')
> -		return -EINVAL;
> -
> -	struct firmware *firmwarep = dev_get_priv(dev);
> -
> -	if (!firmwarep)
> -		return -ENOMEM;
> -
> -	firmwarep->name = name;
> -	firmwarep->offset = offset;
> -	firmwarep->data = dbuf;
> -	firmwarep->size = size;
> -
> -	return 0;
> -}
> -
>  /**
>   * fw_get_filesystem_firmware - load firmware into an allocated buffer.
>   * @dev: An instance of a driver.
> @@ -200,87 +153,16 @@ out:
>  	return ret;
>  }
>  
> -/**
> - * request_firmware_into_buf - Load firmware into a previously allocated buffer.
> - * @dev: An instance of a driver.
> - * @name: Name of firmware file.
> - * @buf: Address of buffer to load firmware into.
> - * @size: Size of buffer.
> - * @offset: Offset of a file for start reading into buffer.
> - *
> - * The firmware is loaded directly into the buffer pointed to by @buf.
> - *
> - * Return: Size of total read, negative value when error.
> - */
> -int request_firmware_into_buf(struct udevice *dev,
> -			      const char *name,
> -			      void *buf, size_t size, u32 offset)
> -{
> -	int ret;
> -
> -	if (!dev)
> -		return -EINVAL;
> -
> -	ret = _request_firmware_prepare(dev, name, buf, size, offset);
> -	if (ret < 0) /* error */
> -		return ret;
> -
> -	ret = fw_get_filesystem_firmware(dev);
> -
> -	return ret;
> -}
> -
> -static int fs_loader_of_to_plat(struct udevice *dev)
> -{
> -	u32 phandlepart[2];
> -
> -	ofnode fs_loader_node = dev_ofnode(dev);
> -
> -	if (ofnode_valid(fs_loader_node)) {
> -		struct device_plat *plat;
> -
> -		plat = dev_get_plat(dev);
> -		if (!ofnode_read_u32_array(fs_loader_node,
> -					  "phandlepart",
> -					  phandlepart, 2)) {
> -			plat->phandlepart.phandle = phandlepart[0];
> -			plat->phandlepart.partition = phandlepart[1];
> -		}
> -
> -		plat->mtdpart = (char *)ofnode_read_string(
> -				 fs_loader_node, "mtdpart");
> -
> -		plat->ubivol = (char *)ofnode_read_string(
> -				 fs_loader_node, "ubivol");
> -	}
> -
> -	return 0;
> -}
> -
>  static int fs_loader_probe(struct udevice *dev)
>  {
> -#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
> -	int ret;
>  	struct device_plat *plat = dev_get_plat(dev);
> +	int ret;
>  
> -	if (plat->phandlepart.phandle) {
> -		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
> -		struct udevice *parent_dev = NULL;
> -
> -		ret = device_get_global_by_ofnode(node, &parent_dev);
> -		if (!ret) {
> -			struct udevice *dev;
> -
> -			ret = blk_get_from_parent(parent_dev, &dev);
> -			if (ret) {
> -				debug("fs_loader: No block device: %d\n",
> -					ret);
> +	ret = generic_fw_loader_probe(dev);
> +	if (ret)
> +		return ret;
>  
> -				return ret;
> -			}
> -		}
> -	}
> -#endif
> +	plat->get_firmware = fw_get_filesystem_firmware;
>  
>  	return 0;
>  };
> @@ -295,7 +177,7 @@ U_BOOT_DRIVER(fs_loader) = {
>  	.id			= UCLASS_FS_FIRMWARE_LOADER,
>  	.of_match		= fs_loader_ids,
>  	.probe			= fs_loader_probe,
> -	.of_to_plat	= fs_loader_of_to_plat,
> +	.of_to_plat	= generic_fw_loader_of_to_plat,
>  	.plat_auto	= sizeof(struct device_plat),
>  	.priv_auto	= sizeof(struct firmware),
>  };
> diff --git a/drivers/misc/fw_loader/fw_loader.c b/drivers/misc/fw_loader/fw_loader.c
> new file mode 100644
> index 000000000000..6459ba23a15b
> --- /dev/null
> +++ b/drivers/misc/fw_loader/fw_loader.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
> + *
> + */
> +
> +#include <errno.h>
> +#include <blk.h>
> +#include <linux/types.h>
> +#include <dm/device.h>
> +#include <fw_loader.h>
> +
> +#include "internal.h"
> +
> +int generic_fw_loader_of_to_plat(struct udevice *dev)
> +{
> +	u32 phandlepart[2];
> +
> +	ofnode fw_loader_node = dev_ofnode(dev);
> +
> +	if (ofnode_valid(fw_loader_node)) {
> +		struct device_plat *plat;
> +
> +		plat = dev_get_plat(dev);
> +		if (!ofnode_read_u32_array(fw_loader_node,
> +					   "phandlepart",
> +					   phandlepart, 2)) {
> +			plat->phandlepart.phandle = phandlepart[0];
> +			plat->phandlepart.partition = phandlepart[1];
> +		}
> +
> +		plat->mtdpart = (char *)ofnode_read_string(fw_loader_node,
> +							   "mtdpart");
> +
> +		plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
> +							  "ubivol");
> +	}
> +
> +	return 0;
> +}
> +
> +int generic_fw_loader_probe(struct udevice *dev)
> +{
> +#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
> +	int ret;
> +	struct device_plat *plat = dev_get_plat(dev);
> +
> +	if (plat->phandlepart.phandle) {
> +		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
> +		struct udevice *parent_dev = NULL;
> +
> +		ret = device_get_global_by_ofnode(node, &parent_dev);
> +		if (!ret) {
> +			struct udevice *dev;

Minor correction of readability since we are reorganizing anyway: s/dev/blk_dev?
instead of shadowing

> +
> +			ret = blk_get_from_parent(parent_dev, &dev);
> +			if (ret) {
> +				debug("fw_loader: No block device: %d\n",
> +				      ret);
> +
> +				return ret;
> +			}
> +		}
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +/**
> + * _request_firmware_prepare - Prepare firmware struct.
> + *
> + * @dev: An instance of a driver.
> + * @name: Name of firmware file.
> + * @dbuf: Address of buffer to load firmware into.
> + * @size: Size of buffer.
> + * @offset: Offset of a file for start reading into buffer.
> + *
> + * Return: Negative value if fail, 0 for successful.
> + */
> +static int _request_firmware_prepare(struct udevice *dev,
> +				     const char *name, void *dbuf,
> +				     size_t size, u32 offset)
> +{
> +	if (!name || name[0] == '\0')
> +		return -EINVAL;
> +
> +	struct firmware *firmwarep = dev_get_priv(dev);
> +
> +	if (!firmwarep)
> +		return -ENOMEM;
> +
> +	firmwarep->name = name;
> +	firmwarep->offset = offset;
> +	firmwarep->data = dbuf;
> +	firmwarep->size = size;
> +
> +	return 0;
> +}
> +
> +int request_firmware_into_buf(struct udevice *dev,
> +			      const char *name,
> +			      void *buf, size_t size, u32 offset)
> +{
> +	struct device_plat *plat;
> +	int ret;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	ret = _request_firmware_prepare(dev, name, buf, size, offset);
> +	if (ret < 0) /* error */
> +		return ret;
> +
> +	plat = dev_get_plat(dev);
> +
> +	if (!plat->get_firmware)
> +		return -EOPNOTSUPP;
> +
> +	return plat->get_firmware(dev);
> +}
> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> new file mode 100644
> index 000000000000..fc78a4add59d
> --- /dev/null
> +++ b/drivers/misc/fw_loader/internal.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
> + */
> +#ifndef _FW_LOADER_INTERNAL_H_
> +#define _FW_LOADER_INTERNAL_H_
> +
> +/**
> + * struct phandle_part - A place for storing phandle of node and its partition
> + *
> + * This holds information about a phandle of the block device, and its
> + * partition where the firmware would be loaded from.
> + *
> + * @phandle: Phandle of storage device node
> + * @partition: Partition of block device
> + */
> +struct phandle_part {
> +	u32 phandle;
> +	u32 partition;
> +};
> +
> +/**
> + * struct phandle_part - A place for storing all supported storage devices

Again nitpick s/phandle_part/device_plat

> + *
> + * This holds information about all supported storage devices for driver use.
> + *
> + * @phandlepart: Attribute data for block device.
> + * @mtdpart: MTD partition for ubi partition.
> + * @ubivol: UBI volume-name for ubifsmount.
> + */
> +struct device_plat {
> +	struct phandle_part phandlepart;
> +	char *mtdpart;
> +	char *ubivol;
> +
> +	int (*get_firmware)(struct udevice *dev);
> +};
> +
> +/**
> + * struct firmware - A place for storing firmware and its attribute data.
> + *
> + * This holds information about a firmware and its content.
> + *
> + * @size: Size of a file
> + * @data: Buffer for file
> + * @priv: Firmware loader private fields
> + * @name: Filename
> + * @offset: Offset of reading a file
> + */
> +struct firmware {
> +	size_t size;
> +	const u8 *data;
> +	const char *name;
> +	u32 offset;
> +};
> +
> +int generic_fw_loader_probe(struct udevice *dev);
> +int generic_fw_loader_of_to_plat(struct udevice *dev);
> +
> +#endif
> diff --git a/include/fs_loader.h b/include/fs_loader.h
> index 7e16e0f70309..3c64efe1b439 100644
> --- a/include/fs_loader.h
> +++ b/include/fs_loader.h
> @@ -6,52 +6,9 @@
>  #ifndef _FS_LOADER_H_
>  #define _FS_LOADER_H_
>  
> -struct udevice;
> -
> -/**
> - * struct phandle_part - A place for storing phandle of node and its partition
> - *
> - * This holds information about a phandle of the block device, and its
> - * partition where the firmware would be loaded from.
> - *
> - * @phandle: Phandle of storage device node
> - * @partition: Partition of block device
> - */
> -struct phandle_part {
> -	u32 phandle;
> -	u32 partition;
> -};
> -
> -/**
> - * struct phandle_part - A place for storing all supported storage devices
> - *
> - * This holds information about all supported storage devices for driver use.
> - *
> - * @phandlepart: Attribute data for block device.
> - * @mtdpart: MTD partition for ubi partition.
> - * @ubivol: UBI volume-name for ubifsmount.
> - */
> -struct device_plat {
> -	struct phandle_part phandlepart;
> -	char *mtdpart;
> -	char *ubivol;
> -};
> +#include <fw_loader.h>
>  
> -/**
> - * request_firmware_into_buf - Load firmware into a previously allocated buffer.
> - * @dev: An instance of a driver.
> - * @name: Name of firmware file.
> - * @buf: Address of buffer to load firmware into.
> - * @size: Size of buffer.
> - * @offset: Offset of a file for start reading into buffer.
> - *
> - * The firmware is loaded directly into the buffer pointed to by @buf.
> - *
> - * Return: Size of total read, negative value when error.
> - */
> -int request_firmware_into_buf(struct udevice *dev,
> -			      const char *name,
> -			      void *buf, size_t size, u32 offset);
> +struct udevice;
>  
>  /**
>   * get_fs_loader() - Get the chosen filesystem loader
> diff --git a/include/fw_loader.h b/include/fw_loader.h
> index 35574482b2b9..56f5e3be6195 100644
> --- a/include/fw_loader.h
> +++ b/include/fw_loader.h
> @@ -1,10 +1,29 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> + * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
>   * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
>   */
>  #ifndef _FW_LOADER_H_
>  #define _FW_LOADER_H_
>  
> +struct udevice;
> +
> +/**
> + * request_firmware_into_buf - Load firmware into a previously allocated buffer.
> + * @dev: An instance of a driver.
> + * @name: Name of firmware file.
> + * @buf: Address of buffer to load firmware into.
> + * @size: Size of buffer.
> + * @offset: Offset of a file for start reading into buffer.
> + *
> + * The firmware is loaded directly into the buffer pointed to by @buf.
> + *
> + * Return: Size of total read, negative value when error.
> + */
> +int request_firmware_into_buf(struct udevice *dev,
> +			      const char *name,
> +			      void *buf, size_t size, u32 offset);
> +
>  /**
>   * request_firmware_into_buf_via_script() -
>   * Load firmware using a U-Boot script and copy to buffer

With that:

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

