Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612FFFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 07:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AE6846E7;
	Wed, 29 Apr 2026 09:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="UNYE3J/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6CD846EA; Wed, 29 Apr 2026 09:13:55 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F764846D2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 09:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvggKHq/Q9PYS3OZW1reHO0eJdjZrwsehHbOJUtoCk3cq3X7uAa5a4EGTcvzowvixcAiayvEnB7WFT8tThl9Bcs19ywoVYFVotKrqFjj4umV8m+7kc9FE0uv5qsOtp+tzZbksFwCRhXUJ5/lo1mDb0ziPGdcBJCiS+zf0WuA67tv7sddd7FaAm7A6YQyLT9mQwJGhC3X9CNVzcH7N1YJVXddc6rpJvvYdxK69KqOYN/YgPv6r0ztKkIe4velhLYyyJ9lQnKeP6oX8mzOqAH0oFKmaWNeKyEuI9R3fL1drUCrpaPBmLuBBWIXeSZTD/JxncHHwKiUQQ4ZIGdr9z+jBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amiymllu5eGKNWfwFOUAqX0uZ8JjO03Kcc3PmMfbFi4=;
 b=cx9Z4SovsglDxbZpE83Md+292Ae534OFmsNbBA+ywaPmkGG312X0adcC2y8lQx9Gof2ePBDx2wMpgPpemh8kEJ3EYrLE9IJvEGBLcKB1uU048OvzgkMH2Ofyc3iDGXJGF71AytN6n+v7CschiJEHDUTBPw271satPltTsk6snm/TpJhYIZQT/oGprmA6dYPQo8qt92x7xagN0hL4xXfG/1ZvCRdEezWBBlDc3C80ASo309+IxV1NdDiffUXUCAoxTHLWSE2Ak4DrD4DVdrlH+Y6PMJq+UuAxVKgj2GGiMUGVMLB38bXmqDxJR+LBWfbEIeSSDlRTqwot42EkcKKN+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amiymllu5eGKNWfwFOUAqX0uZ8JjO03Kcc3PmMfbFi4=;
 b=UNYE3J/YfoQxJKcXhgw0wt7/GIMo5PpHrViXr7Th9scc33wkMlOXlby5J2Sx02lR3p0Apx33YPIAcW9qqJ+Bm9+Mor7gUt8vuSzG6IMesBjkN3kzP8oxu6xWbABb6r68egM60ZB2tRHhK/Z1MOFZ1dfnIFFxi0CnoDwbt9PS3i4g9zsX2un9Ai1BkA/bmNtppzJxy4wf4CdundohAD7zEQm27UXGiHm1eZgdHj4G2SaESUuCI7oQZAjmQpxq07VofgtuS5khBuJa+RsJFhU6+MrYt1udBT86vkhl/Z605b40ZAiUxJphzsj0B4f1vmDF3d/G5pi8I6oxe7kGHMnlSA==
Received: from CWLP265CA0466.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d4::14)
 by DU4PR10MB9832.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:62f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:13:52 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:400:1d4:cafe::fd) by CWLP265CA0466.outlook.office365.com
 (2603:10a6:400:1d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 07:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:13:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 29 Apr
 2026 09:17:03 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 29 Apr
 2026 09:13:30 +0200
Message-ID: <0e70265a-43c5-46f2-a3d4-2a7240f5f91c@foss.st.com>
Date: Wed, 29 Apr 2026 09:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] board: st: stm32mp25: support dynamic A/B bank
 bootup
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
 <20260426154724.2042569-9-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260426154724.2042569-9-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|DU4PR10MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: 0564d71f-868b-44a9-176b-08dea5bedde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TjX2Nr65f0N5ZPTq5VDUZy3oWsNFQIb2Yav8Wumz5MxG6SAy1Uw6sp+EYSzOU5IIhIx7sPMZUY+MuzFmj1xx2AbGdAOKDz0583dkVfiHAttZI0cDLmSK/laCulrgQ1emAshecipkD+zi7LM6h2tUYPFWEBb+mxpJm65OReCkPIFzRaRwfyg9M9hcEMxX+gfungTKjmv6KWARFD79PZ900Ev+kNqohhYq8o3llmS2C3qj0G4pdqmBhaue43oF7iLB0wbogm28T79DoqSHrCeeYYm+9S33MqwnOt9t4iLI2U+PHVV8d0etJm7bvyVh9lybxv/GPJqjQS5nfmTcptlI84qlFvSf35sUU6+/nG0So2bePOJ/GTo2nCXo/R5PHJOnSlarAF6BQWz9JAx2TRYniJi6xZK231LyvNO92qzgJNHIgn1Kd0BkCoDUIldc0qbsKCVgQxxzbl4FerwF4E6O/MxVmwUSqUDPY/qZpaMJCX5Xo8UgkQ5sJi6WxtwE0sqBSDcmsB6CGj57s3aLRnr8l6SCRdkiPcLbpHUCbcvk+4GJf/pXGKPVzDWfvtGKCa79HfALVnNnyyiZef28qH356kEXklhu7cNMrIJZTZk07UALl2bEiAGYRIY91ptIMM62Mkceta9YJ6VsHCQogg7B3XPuGkPWfwqoeRifEOFVfFmy36xy//JMOasV8anWCEnkkaIZ8y1NAtnBiyGcJ72PmmSSAzRePQOXnU6ym8CMMJuEzdO0wT0PwEaXyli/5TAwA6xTad3N3d7gagTZ+C008g==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /ExV2+0PXOO6dlnGhMsnnCO5DR758p5veD3g17oh6YihxNYh66T/+Ol5WCxaaK5AG3KCYKzEl0hyfBWX3h4wPXljXDbhFd+1jBsAgKwZc5+ryK8x8sMBMejQzQhLVkiXWmnuvRq1cclTsPHfDhS3k5o63eGeXzdSZmvb8jMND1AXR26REhY2ynPAVKlOKLEX5H2/Q2WCpPpeT9Q7LNqi6aCukXEMTFytkPyGcqYe6nm55XynQCxIoyKmM2nMlP4GKRfSgKwbJvcRtSlXg16LFdFvTUgRXVtM4J2NRrlJTzrHYaHz27H0I8+IpMLzAgzL9S2IZGT/g5VE1yABwfIT5VZ55PVSR7KB+WBpA230MAbGiiYeUMygZCy/61RkjIo6zsJoEnMQRn2V5pTC+rt1uSAalwLbpoipkVI42fwtVvi8bQWhYAKL2q3sJN3XGYOu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:13:51.7631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0564d71f-868b-44a9-176b-08dea5bedde8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9832
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



On 4/26/26 17:47, Dario Binacchi wrote:
> Enable automatic detection of the active A/B bank by retrieving
> partition GUIDs from FWU metadata.
> 
> This ensures the system correctly identifies the bootable partitions
> even in multi-bank scenarios, falling back to a standard bootable flag
> scan if the UUIDs are missing.
> 
> To enable A/B bank bootup on stm32mp25 boards, add the following Kconfig
> options to the stm32mp25_defconfig:
> 
>  CONFIG_FWU_MULTI_BANK_UPDATE=y
>  CONFIG_FWU_MDATA=y
>  CONFIG_FWU_NUM_BANKS=2
>  CONFIG_FWU_NUM_IMAGES_PER_BANK=3
>  CONFIG_CMD_FWU_METADATA=y
>  CONFIG_FWU_MDATA_V2=y
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> ---
> 
> (no changes since v5)
> 
> Changes in v5:
> - Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
>   image GUID by type and bank index"
> 
> Changes in v4:
> - Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> 
> Changes in v3:
> - Wrap lines exceeding 80 columns in test/cmd/part.c file.
> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
> - Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
>   in fwu.h.
> - Add log_warning() messages to fwu_platform_hook() to catch inconsistent
>   FWU metadata (boot GUID found but root GUID missing or viceversa), as
>   suggested by Simon Glass.
> - Add Reviewed-by tag of Simon Glass.
> 
> Changes in v2:
> - Add links to the XBOOTLDR specification in the commit message of patch
>    1/7 lib: uuid: add partition type GUID for extended bootloader.
> - Update help for 'part start', 'part size' to mention UUID.
> - Add kerneldoc comment for fwu_mdata_get_image_guid().
> - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
> - Add patches:
>    5/7 test: cmd: part: add UUID lookup tests
>    3/7 test: cmd: add unit tests for part command
>    2/7 test: dm: part: add test for part_get_info_by_uuid
> - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid() calls.
> 
>  board/st/stm32mp2/stm32mp2.c          | 32 +++++++++++++++++++++++++++
>  include/configs/stm32mp25_st_common.h | 15 +++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index 43bc583378e6..5cbbbc322a3a 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -208,4 +208,36 @@ void fwu_plat_get_bootidx(uint *boot_idx)
>  	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
>  		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
>  }
> +
> +int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +	uint boot_idx;
> +	efi_guid_t boot_uuid, root_uuid;
> +	const efi_guid_t boot_type_guid = PARTITION_XBOOTLDR;
> +	const efi_guid_t root_type_guid =
> +		PARTITION_LINUX_FILE_SYSTEM_DATA_GUID;
> +	char uuidbuf[UUID_STR_LEN + 1];
> +	int retb, retr;
> +
> +	fwu_plat_get_bootidx(&boot_idx);
> +
> +	retb = fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid, boot_idx);
> +	retr = fwu_mdata_get_image_guid(&root_uuid, &root_type_guid, boot_idx);
> +
> +	if (!retb && !retr) {
> +		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
> +		env_set("boot_partuuid", uuidbuf);
> +
> +		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
> +		env_set("root_partuuid", uuidbuf);
> +	} else if (!retb && retr) {
> +		log_warning("%s: found boot GUID but missing root GUID (%d)\n",
> +			    __func__, retr);
> +	} else if (!retr && retb) {
> +		log_warning("%s: found root GUID but missing boot GUID (%d)\n",
> +			    __func__, retb);
> +	}
> +
> +	return 0;
> +}
>  #endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
> diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
> index cb679eb1be22..0b0267ae99b0 100644
> --- a/include/configs/stm32mp25_st_common.h
> +++ b/include/configs/stm32mp25_st_common.h
> @@ -8,7 +8,22 @@
>  #ifndef __CONFIG_STM32MP25_ST_COMMON_H__
>  #define __CONFIG_STM32MP25_ST_COMMON_H__
>  
> +#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> +#define SCAN_DEV_FOR_BOOT_PARTS \
> +	"setenv devplist; " \
> +	"env exists boot_partuuid && " \
> +		"part number ${devtype} ${devnum} ${boot_partuuid} devplist; " \
> +	"env exists devplist || " \
> +		"part list ${devtype} ${devnum} -bootable devplist; "
> +
> +#define ST_STM32MP25_FWU_ENV \
> +	"altbootcmd=${bootcmd}\0"
> +#else
> +#define ST_STM32MP25_FWU_ENV
> +#endif
> +
>  #define STM32MP_BOARD_EXTRA_ENV \
> +	ST_STM32MP25_FWU_ENV \
>  	"usb_pgood_delay=2000\0" \
>  	"console=ttySTM0\0"
>  
Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
