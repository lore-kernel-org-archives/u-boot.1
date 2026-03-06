Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E39F513F4
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 05:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 856C383F75;
	Fri,  6 Mar 2026 06:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pD0vaNnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBB883F86; Fri,  6 Mar 2026 06:05:05 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D2283F2D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 06:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OotpSPFe4bihT8es4ljojAwmKeWV7uJhT87pWQWpMSmoVwhkUt3igzfyR7ssuLitkgxo1nd/JfJmaPyUivCOH3YCkm0NykeMdrI2TgE36HwDyuKknKPnx9jRoTRB1/6T817/n7203NltJfRD295defikqhoY6NGTV1AzHk32PFLLNkxCEHk257Gp3guNB/XR3nDz4P9jD/okHgYY6aSEmCncYSDzTpgVz815GEi/akZ7immNWQ1QVoPnRHhH/MyB80U0RyLRvN9/KuX3y8+x5a87IvwEAulre3HVguDZJYdVyymrloBJgBfNUTCvTOXa9VB+BNVuHeKJD7ayv0Qtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgGlpf8TnUu+Jic9ToTGXH38J9dAfjG7yu0nTejqgdw=;
 b=lmj14WSw2poj+TSmUOS3bgaW4Q8jR9i2/WKNnM5kjlgFy+P1u+0jq3adYdPAvYNAkk6FkkU2/cDzIR6ccR7fFLPMrmxedeyvSM6KjEiyFbePrg7WkL3yuYLYXBFo3FN4WrVmD79tfd4m9TtNzcTma+0S2mVoqOZWcjMWmHu7FX9bGR5ENL0FymBoq0k29lePFLXqIF44rpk/ofmGY5cy0uA957ZbTYCkUYMO2X00Cbp2FI+dJy84eb8cM6c1VWtop9T5SuK6e/oyloAqY1sO3FNB5u33QY4fRpc0dccqfZNL+shDuQmOwyhrDAkXki2UgwfxA2NgxC1KafvP0YUwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgGlpf8TnUu+Jic9ToTGXH38J9dAfjG7yu0nTejqgdw=;
 b=pD0vaNnv+k9xkKXOLmOSaGVTOg9246ZfK8gzBlPcCPPGe5k8saOY7hWrU/7B/rHNpyH7Y0JHAKvHd9vXcgwZ4GudcDRsTHeoIQJBlKjosgCBNue7dKjdr1/DAX9MAQTo8GmrL2RKLvJ9/zEEt5YFfmNwexrxbnjY9QGTnfYXpPo=
Received: from SA0PR11CA0111.namprd11.prod.outlook.com (2603:10b6:806:d1::26)
 by CO1PR10MB4788.namprd10.prod.outlook.com (2603:10b6:303:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 05:04:58 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::8c) by SA0PR11CA0111.outlook.office365.com
 (2603:10b6:806:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 05:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 05:04:56 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 23:04:19 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 23:04:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 23:04:19 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62654Hf03178570;
 Thu, 5 Mar 2026 23:04:18 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 6 Mar 2026 10:34:17 +0530
Message-ID: <DGVFQRGRKPW4.3LLLZIHTKSFG2@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] common: spl: spl_dfu.c: Fix warning associated with PCI
 subclass_code
From: Anshul Dalal <anshuld@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <lukma@denx.de>, <mkorpershoek@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260305103815.999886-1-s-vadapalli@ti.com>
In-Reply-To: <20260305103815.999886-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CO1PR10MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab0b26f-d6c6-4650-af2a-08de7b3de94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: tio1VznRR2Pp75OAMRwQBfEmvEKPhXmJeeLYnNXhHaT6yYl3rz0ZeCOeV9l06OnkYBEaP4Snum5YgW/Gf/KMOqqEKX5HEWqmLBhtP5xdFspzde3CVgX02ICYmBBJGYXtZJchedGw/Symttacahv4imWMvCRisNnKDCrG5IA2rh8+ql/UcbAI0luYX/fBZGujYv0BNXW8CSd6bmbfQaQkawOJ1hIGvwtnbwE+1AoTBgTy8xjs6EV+f047UfbGgUdqb8zOt4JnyuR/YVJ45H0Ls4wkIjFCJlZF0ca2EFnnz2uCuuL0dN+YkKeWnBuu+EGLA84oO6WlAKtmqSaE0Wcxmd7Pur5LbnK3IFNUvoZk8QRg4hpjLCceAkLILlX0ebtkJcciYP6ouncayaxbi+3WM1imwVHQhvDXulwEShnhBexx8BywA50uCEEalgNE12L2rrUKl47MdkswHXCVyFhTpDRQ1jrMzVMWVi63LCj4KCDDYMnyPEe9cKcXEjBx4ucI5IQlCWv+1S/33brp3gMsv21jQLC0uZdQxnkIIxR5E5e2UZkwkfuAON66EtpCmH7aB11AFyP3akiZO06Z+rJlZA6EdXXL/q3vMqD1ngt6W1RmIDd/4f1mBW7H0phWLmxk+YmYYWs4k+X1n+Gwk5kLee83uAe3g5uFVabWCT23SMwhBi5j0rLrx0HQ+MIGrFKcz3R5kiBpTfGor+VDXIjfOZj544YjCMoZGPFsLHcnOJf+lOqoVy0FZdAejMLgk2o3mM5595XY/HX7dUuXliP+Ag==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(82310400026)(36860700016)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T8COgr2tR6RQXZaEfcLQxFMwPWHO+yXPteNOtqEdHRGi9J+lmXb7fGehJfpljB8uLIyAgcEPRrmUVTQMUgxUIivoWsnxlE5WPxVaFg8Ayy+PSl9UO7vzFplOXk97uMTbmTDUoOWnGTP9dve0DqkQvfKAgKs1XE6Hum2RuqNmMyYXOpclY7AUGDwZvollimOschD5zNGnf5eFnWg2t05J5nh2qk372hBLgzgt8UgBaHoGLkIJh9ZTSvFe21AuC4lINvUhZN6k1YDqFGBnRm7yrCOzpGXpX1u/ddxW7UKG0uJu4AhHp1FT9788NL8dtC4ztEkmi5XzJKXXU4UHbqDVK7S+AlfbwuqxQ9N2CO5jOkEW1OdnTVvs7/kf6FDHSQGADF9oiPfVJXlCuhGft4JTFFmdGRcIOstzn/kDuMzPdOOdiai4/Bdg6dWDSHTUBb5T
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 05:04:56.9963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab0b26f-d6c6-4650-af2a-08de7b3de94e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4788
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

On Thu Mar 5, 2026 at 4:08 PM IST, Siddharth Vadapalli wrote:
> The subclass_code member of the pci_ep_header structure is a 1-byte
> field. The macro PCI_CLASS_MEMORY_RAM is a concetation of baseclass_code
> and subclass_code as follows:
> 	PCI_BASE_CLASS_MEMORY: 0x05
> 	Subclass Code for RAM: 0x00
> 	PCI_CLASS_MEMORY_RAM:  0x0500
> Hence, instead of extracting it via an implicity type conversion from int
> to u8 which throws a warning, explicitly mask the bits to extract the
> subclass_code.
>
> Fixes: cde77583cf0b ("spl: Add support for Device Firmware Upgrade (DFU) =
over PCIe")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

I was able to reproduce the issue on am62x_evm_a53_defconfig with the
following diff:

	diff --git a/arch/arm/mach-k3/include/mach/am62_spl.h b/arch/arm/mach-k3/i=
nclude/mach/am62_spl.h
	index 2c9139d2cc0..07ae5e99e49 100644
	--- a/arch/arm/mach-k3/include/mach/am62_spl.h
	+++ b/arch/arm/mach-k3/include/mach/am62_spl.h
	@@ -12,6 +12,7 @@
	 #define BOOT_DEVICE_OSPI		0x01
	 #define BOOT_DEVICE_QSPI		0x02
	 #define BOOT_DEVICE_SPI			0x03
	+#define BOOT_DEVICE_PCIE			0x03
	 #define BOOT_DEVICE_CPGMAC		0x04
	 #define BOOT_DEVICE_ETHERNET_RGMII	0x04
	 #define BOOT_DEVICE_ETHERNET_RMII	0x05
	diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defco=
nfig
	index 281fa3fea15..a828ad164f1 100644
	--- a/configs/am62x_evm_a53_defconfig
	+++ b/configs/am62x_evm_a53_defconfig
	@@ -1,4 +1,9 @@
	 CONFIG_ARM=3Dy
	+CONFIG_SPL_PCI_DFU=3Dy
	+CONFIG_SPL_PCI_ENDPOINT=3Dy
	+CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS=3D0x0
	+CONFIG_SPL_PCI_DFU_VENDOR_ID=3D0x0
	+CONFIG_SPL_PCI_DFU_DEVICE_ID=3D0x0
	 CONFIG_ARCH_K3=3Dy
	 CONFIG_SYS_MALLOC_F_LEN=3D0x8000
	 CONFIG_TI_COMMON_CMD_OPTIONS=3Dy

The patch looks good to me and fixes the build warning :)

Tested-by: Anshul Dalal <anshuld@ti.com>

> ---
>
> Hello,
>
> This patch is based on commit
> f473a453b0c kbuild: Drop phandle from diff between base DT and U-Boot aug=
mented DT if DEVICE_TREE_DEBUG=3D1of the master branch of U-Boot.
>
> Regards,
> Siddharth.
>
>  common/spl/spl_dfu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/spl_dfu.c b/common/spl/spl_dfu.c
> index b09f82790c9..7d21bb4d16a 100644
> --- a/common/spl/spl_dfu.c
> +++ b/common/spl/spl_dfu.c
> @@ -64,7 +64,7 @@ static int dfu_over_pcie(void)
>  	hdr.deviceid =3D CONFIG_SPL_PCI_DFU_DEVICE_ID;
>  	hdr.vendorid =3D CONFIG_SPL_PCI_DFU_VENDOR_ID;
>  	hdr.baseclass_code =3D PCI_BASE_CLASS_MEMORY;
> -	hdr.subclass_code =3D PCI_CLASS_MEMORY_RAM;
> +	hdr.subclass_code =3D PCI_CLASS_MEMORY_RAM & 0xff;
> =20
>  	ret =3D pci_ep_write_header(dev, fn, &hdr);
>  	if (ret) {

