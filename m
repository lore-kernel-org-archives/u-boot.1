Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F607C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CE4837B0;
	Tue, 27 May 2025 15:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="4y/f2FMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8995C837EF; Tue, 27 May 2025 15:13:37 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EC3D830B6
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RAsRL7022832;
 Tue, 27 May 2025 15:13:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 aWElA+diVaYdis6Mfd1+Rn2whJFY63bi3l6tL2K/3E8=; b=4y/f2FMN9N4kBCc0
 ALesB40S3tN2VGOvFxRX3hhSUX1OdKqvipZhgrmIvLR6gNKunahteaGMc/jjFRiE
 zwAz/AT8DKbe1BWXUp2xFsUnZxx4b5crfmbyczZGdXKXESkC3kN7sPDa4aaa/ukF
 rRKGnWDRdRZOTkb/MC88j6JF7Kvv2WwjHvnuX6fiBrMflMpYXUez87GTde4cUG4P
 xvxBxMaUkqbfOt41jpdoJNP3EdJ7I2pVQ8gplAudbzfD5Iaxk57qk7boCgayqPK7
 exAyJYUXQHw54LUzfwmA6RGfZ2Ut40QUUDffWCIdhtglm0fUFIIUjUAWnSnLhTlV
 QoMZ4A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46w54hjnna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:13:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3BC8840058;
 Tue, 27 May 2025 15:12:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CCB1AAE2CBD;
 Tue, 27 May 2025 15:12:33 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:12:33 +0200
Message-ID: <d78816b4-9438-4751-ada8-bbc6b51dae61@foss.st.com>
Date: Tue, 27 May 2025 15:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] configs: add STM32H747 discovery board
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-7-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-7-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:24, Johannes Krottmayer wrote:
> Add initial support for the STM32H747 discovery board. The
> configuration is copied and modified from the STM32H743 discovery
> board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  configs/stm32h747-disco_defconfig | 35 +++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 configs/stm32h747-disco_defconfig
> 
> diff --git a/configs/stm32h747-disco_defconfig b/configs/stm32h747-disco_defconfig
> new file mode 100644
> index 00000000000..8a0c72450d1
> --- /dev/null
> +++ b/configs/stm32h747-disco_defconfig
> @@ -0,0 +1,35 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_STM32=y
> +CONFIG_TEXT_BASE=0x08000000
> +CONFIG_SYS_MALLOC_LEN=0x100000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x24040000
> +CONFIG_ENV_SIZE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="st/stm32h747i-disco"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_SYS_LOAD_ADDR=0xd0400000
> +CONFIG_STM32H7=y
> +CONFIG_TARGET_STM32H747_DISCO=y
> +CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTDELAY=3
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot.\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
> +CONFIG_DEFAULT_FDT_FILE="stm32h747i-disco"
> +CONFIG_SYS_CBSIZE=256
> +CONFIG_SYS_PBSIZE=282
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SYS_PROMPT="U-Boot > "
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_TIMER=y
> +CONFIG_CMD_EXT4_WRITE=y
> +# CONFIG_ISO_PARTITION is not set
> +CONFIG_OF_CONTROL=y
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NO_NET=y
> +CONFIG_STM32_SDMMC2=y
> +# CONFIG_PINCTRL_FULL is not set

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
