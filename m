Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0422E77188
	for <u-boot@archiver.kernel.org>; Sun, 22 Dec 2024 14:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA918056B;
	Sun, 22 Dec 2024 15:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Sh6qSgte";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B5E8062B; Sun, 22 Dec 2024 15:07:31 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF058056A
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 15:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BME7KDJ430062
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 22 Dec 2024 08:07:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734876441;
 bh=AwmHC+O93DEQ4587ZSCfGsuoySCmGpQHyuLHQvO4IDs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Sh6qSgteECpIHNN0SF1Vm5p57o7+jieiBZM8//dC/keYyGRa659YbzoJEXeRMnVVs
 aCGefCr2nmdryMhkTqSC6N++UajXtk35EgO5Hx+SeX3YwbQBRzvqnZCTpqw4nC+7gU
 ec1+GL0+nu1YnIt8kNJvmmgRvRyUirekQMxSTAUY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BME7Kqn016716
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 22 Dec 2024 08:07:20 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 22
 Dec 2024 08:07:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 22 Dec 2024 08:07:20 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BME7FLN007596;
 Sun, 22 Dec 2024 08:07:16 -0600
Message-ID: <46b59d32-7016-4341-b0fd-a9a04add4b08@ti.com>
Date: Sun, 22 Dec 2024 19:37:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] soc: Add information to identify the J742S2 SoC
 family
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-4-13a6a127b344@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-4-13a6a127b344@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> J742S2 has the same part number as J784S4 but JTAG_DEVICE_ID has a
> PKG bit that tells about J742S2.
>
> Add support for reading JTAG_DEVICE_ID and set family as J742S2 based
> on that.
>
> Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/mach-k3/include/mach/hardware.h        |  2 ++
>   arch/arm/mach-k3/include/mach/j784s4_hardware.h |  4 ++++
>   drivers/soc/soc_ti_k3.c                         | 17 +++++++++++++++--
>   3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
> index b191d53a0f580aacd9283f06f057b47858864fe5..a26af0b6e3c95693ea6f144a3274ee193767c6c9 100644
> --- a/arch/arm/mach-k3/include/mach/hardware.h
> +++ b/arch/arm/mach-k3/include/mach/hardware.h
> @@ -62,6 +62,8 @@
>   #define JTAG_ID_PARTNO_J722S	0xbba0
>   #define JTAG_ID_PARTNO_J784S4	0xbb80
>   
> +#define JTAG_DEVICE_ID_PKG_J742S2 0x7
> +
>   #define K3_SOC_ID(id, ID) \
>   static inline bool soc_is_##id(void) \
>   { \
> diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> index 0ffe238cdaef99e3889abf8016427f54ce69b6ac..14eb739ba7301a56ef739602cc864ae1723cf637 100644
> --- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> +++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
> @@ -15,6 +15,10 @@
>   #define MCU_CTRL_MMR0_BASE				0x40f00000
>   #define CTRL_MMR0_BASE					0x00100000
>   
> +#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
> +#define JTAG_DEV_PKG_MASK			GENMASK(2, 0)
> +#define JTAG_DEV_PKG_SHIFT			0
> +
>   #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
>   #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
>   #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index a3acca4d394273aad53efd3eee200ecdda50c31b..f8e64395ae3f18513837a88cf91d340fc11bb346 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -18,9 +18,14 @@ struct soc_ti_k3_plat {
>   static const char *get_family_string(u32 idreg)
>   {
>   	const char *family;
> +	u32 jtag_dev_id;
> +	u32 pkg;
>   	u32 soc;
>   
> +	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);

Please check, if this register is available for all k3 devices.

if not then please move this logic under J784S4 SOC.

Second compilation will fail for few k3 devices , which does not define 
CTRLMMR_WKUP_JTAG_DEVICE_ID

eg J721E etc


> +
>   	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
> +	pkg = (jtag_dev_id & JTAG_DEV_PKG_MASK) >> JTAG_DEV_PKG_SHIFT;
>   
>   	switch (soc) {
>   	case JTAG_ID_PARTNO_AM62X:
> @@ -51,8 +56,16 @@ static const char *get_family_string(u32 idreg)
>   		family = "J722S";
>   		break;
>   	case JTAG_ID_PARTNO_J784S4:
> -		family = "J784S4";
> -		break;
> +		{
> +			/* Keep default family as J784S4 */
> +			family = "J784S4";
> +			switch (pkg) {
> +			case JTAG_DEVICE_ID_PKG_J742S2:
> +				family = "J742S2";
> +				break;
> +			}
> +			break;
> +		}
>   	default:
>   		family = "Unknown Silicon";
>   	};
>
