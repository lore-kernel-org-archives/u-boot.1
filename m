Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E8ECA0EE8
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 17:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7900D80B9B;
	Sun, 14 Sep 2025 19:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EQ8xAq5d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tmLWUz0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FFB81E13; Sun, 14 Sep 2025 19:49:36 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3055A80422
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 19:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cPwf50bwPz9skH;
 Sun, 14 Sep 2025 19:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757872173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDcDW6H1j4d/uoMXh9cUiHNWuSnhorRFF4Ods3G5TmY=;
 b=EQ8xAq5dJC6Ty1jNNa26eOJOmhzGlBBzMMEikBx4s9HpBjszVlOV9C5TlfrVl2GQXQJVNI
 fKukDxfULSenZs6/UPClGoBPV8t1bgpmJsPa/bHi+uuA0llXoCPLoWnzDZVXSbB1xQRJKo
 5YdTMafPjkJxgtyd0x5Dxcu0HTfWB8veJAIZAuq/4r4IkHPj3e4oLTsgR/EKAK4bTJNU47
 JfTwZQNC3Pjvd1c7BOIZ9oHnmFZVMDUDyEi1DXcurKiCPjX/Dz2PCxmhBbqUmEfr7DMRVK
 Blcjl16VXSW+ltd7SiiDQByk54DU7W2Cpwdz1ZXBgyNciSQv/15UqU7Vchffgw==
Message-ID: <464e0429-ac06-49fc-831d-b9e86946446d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757872170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDcDW6H1j4d/uoMXh9cUiHNWuSnhorRFF4Ods3G5TmY=;
 b=tmLWUz0zml3HI8KHbFcaNvGZqGZzV1yr3gTjE0WmOJ9TRtQ9pwsg3W4xVuyje+yKxf2LEX
 UowWFn7tXc4h/ZsEs2be8qInJTRU3HCwyHOVzgBYC3DMwXtx7efHKKsk6NTIE7PzOjixSF
 cC+RX0RH8WU92OQmiGhdqEJs9/5V2ulS2mRuP146EGe2nDxK2Uqb/qrpmV0MLBIW3PrtA/
 5sNnej9YHLDZbSiRsTG7cH4Qz/uim+p+pGUVG94eCrFbfsCRtRNcBl8qQumwc9DnIBpqYG
 lqjKlGvAQDPTX8x7YpSPp8VprlAJ38c2Xlo6zR7HkWx29bNXId+zOCW0gdoOsg==
Date: Sun, 14 Sep 2025 19:49:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [U-Boot, v4, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250914044115.18391-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250914044115.18391-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f2d64f40cc2eb6f088d
X-MBO-RS-META: c3ameqw4e7jagyiuq7jwjjcx3oxwckse
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

On 9/14/25 6:41 AM, Lucien.Jheng wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via MDIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture level.
> 
> Linux upstream AIROHA EN8811H driver commit:
> 71e79430117d56c409c5ea485a263bc0d8083390
> 
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
> Change in PATCH v4:
> air_en8811.c:
>   * Create the airoha folder

directory

> to store all future airoha phy drivers.
>   * Use `request_firmware_into_buf_via_script` for firmware loading.


[...]

> +++ b/drivers/net/phy/airoha/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig PHY_AIROHA
> +	bool "Airoha Ethernet PHYs support"
> +
> +config PHY_AIROHA_EN8811
> +	bool "Airoha Ethernet EN8811H support"
> +	depends on PHY_AIROHA
> +        select FS_LOADER

It seems tabs/spaces are mixed here, please fix.

> +	help
> +	  AIROHA EN8811H supported.

[...]

> +#define EN8811H_MD32_DM_SIZE	0x4000
> +#define EN8811H_MD32_DSP_SIZE	0x20000
> +
> + #define EN8811H_FW_CTRL_1		0x0f0018
> + #define EN8811H_FW_CTRL_1_START	0x0
> + #define EN8811H_FW_CTRL_1_FINISH	0x1
> + #define EN8811H_FW_CTRL_2		0x800000
> + #define EN8811H_FW_CTRL_2_LOADING	BIT(11)

Same here, avoid leading space.

[...]

> +__weak int en8811h_read_fw(void **addr)

Does this still have to be a __weak function, now that it uses generic 
fw loader ?

> +{
> +	void *buffer;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_FS_LOADER))
> +		return -EOPNOTSUPP;
> +
> +	buffer = malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
> +	if (!buffer) {
> +		printf("Failed to allocate memory for firmware\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = request_firmware_into_buf_via_script(&buffer,

I think 'buffer' without the & should be used here.

> +						   EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE,
> +						   "en8811h_load_firmware");
[...]
