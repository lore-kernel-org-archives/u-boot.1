Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBF1D1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267C8890BB;
	Sun, 27 Oct 2024 17:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="koZ4Xs/P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yN9Sgn5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D59A890B4; Sun, 27 Oct 2024 17:32:22 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B0788FFB
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Xc29S2cFXz9sby;
 Sun, 27 Oct 2024 17:32:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73/I8eR6ZLKmw5vqDfzCns9lIezGAkinS1RH7y7iv68=;
 b=koZ4Xs/PUXOkeH60y6oT9TDSQMxeO53NmMWNo2d3Z79JTFFN1sM4+OfIdP8RfRKm+3+0jP
 zM1IEal9yBYEpSOo8UxsxrcxNJ4dnHfclNCaL/FMOR/7mghQHCbAG9AdXat8K+DtRmPCSW
 UVijq97GsxTaA2ZjkWZ/fWAKnOyTRc4rM84H/An/9qCSX/bhJHWtnYaVqBB7hKRRUcwfaU
 00jSGTNrm16r1JuI6snTZa53QBjNhmeolKV4OnS02cUPQJ9UoVZqz583wjpDmmitPxJous
 NgqbjGOM5isni/x8iHJmZ/ObxYRhLU4nq2ZxhFeIz8yJ2XvO50Z2JN2L2ckZWA==
Message-ID: <5bd5fe3c-1077-4dc9-8305-b435c426d712@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73/I8eR6ZLKmw5vqDfzCns9lIezGAkinS1RH7y7iv68=;
 b=yN9Sgn5co3ZXGhB/kQglEIBWw45reKOOjdiB3MufOJphUMgiYL8pwDp1h7M2Ezb0/HhNV5
 D+WE5TN+PyskjAUn+32mntF7VN3fKWBJmp4wJDaWADrgvfKB6g63uZxWJDwx2/Ja4sTGLT
 EfU+weO2wMCj7DIzltcXFEnq30KRmrz3SSm0jFVgiAyXlkYNu3rZ8cgeFPIzRfg6pjKxuw
 aEl5Qe5YzjAd4By/IIBR+WO7fBXdJDOyLthsE7pTWAbYw+5yfaVogizJCgcJBR9oX62rrO
 Ek1Uvj0SNxh9JPP6wEveiRc4+ywOP+3DEZHQWIsLRdFbhmFEL2GFIJFJ95tbmg==
Date: Sun, 27 Oct 2024 17:29:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 11/14] net: ravb: Add RZ/G2L Support
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-12-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-12-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9iueawtxpg1bk6djtfsp1rqujm6fygkc
X-MBO-RS-ID: 8208c043ac1e31f7ab0
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> The Renesas R9A07G044L (RZ/G2L) SoC includes two Gigabit Ethernet
> interfaces which can be supported using the ravb driver. Some RZ/G2L
> specific steps need to be taken during initialization due to differences
> between this SoC and previously supported SoCs. We also need to ensure
> that the module reset is de-asserted after the module clock is enabled
> but before any Ethernet register reads/writes take place.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   arch/arm/mach-renesas/Kconfig |   1 +
>   drivers/net/Kconfig           |   2 +
>   drivers/net/ravb.c            | 183 ++++++++++++++++++++++++++++++++--
>   3 files changed, 176 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index aeb55da609bd..d373ab56ce91 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -76,6 +76,7 @@ config RZG2L
>   	imply MULTI_DTB_FIT
>   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>   	imply PINCTRL_RZG2L
> +	imply RENESAS_RAVB
>   	imply RENESAS_SDHI
>   	imply RZG2L_GPIO
>   	imply SCIF_CONSOLE
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 89f7411bdf33..d009acdcd94f 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -822,6 +822,8 @@ config RENESAS_RAVB
>   	depends on RCAR_64
>   	select PHYLIB
>   	select PHY_ETHERNET_ID
> +	select BITBANGMII
> +	select BITBANGMII_MULTI

Keep the list sorted.

>   	help
>   	  This driver implements support for the Ethernet AVB block in
>   	  Renesas M3 and H3 SoCs.
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index fb869cd0872e..e2ab929858c8 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c

[...]

> @@ -108,6 +122,16 @@
>   
>   #define RAVB_TX_TIMEOUT_MS		1000
>   
> +#define RAVB_RCV_BUFF_MAX		8192
> +
> +struct ravb_device_ops {
> +	int (*mac_init)(struct udevice *dev);
> +	int (*dmac_init)(struct udevice *dev);
> +	int (*config)(struct udevice *dev);
> +	int (*reset_deassert)(struct udevice *dev);
> +	void (*reset_assert)(struct udevice *dev);
> +};

[...]

> +static int ravb_reset_deassert_rcar(struct udevice *dev)
> +{

The callsites should check if a callback is assigned or NULL and only 
call the callback if it is assigned. Then you won't need empty callbacks 
like this.

Basically add if (ops->reset_deassert) ops->reset_deassert() and remove 
this empty function.

> +	return 0;
> +}
> +
> +static void ravb_reset_assert_rzg2l(struct udevice *dev)
> +{
> +	struct ravb_priv *eth = dev_get_priv(dev);
> +
> +	reset_assert(&eth->rst);
> +	reset_free(&eth->rst);
> +}

A bit of a design question -- would it make sense to have ravb-rcar.c 
and ravb-rzg2l.c to contain the differences between the ravb variants, 
and keep common code only in ravb.c ?

[...]

> @@ -684,9 +821,35 @@ int ravb_of_to_plat(struct udevice *dev)
>   	return 0;
>   }
>   
> +static const struct ravb_device_ops ravb_device_ops_rzg2l = {

Keep the list sorted, rzg is below rcar (Z is after C) .

> +	.mac_init = ravb_mac_init_rzg2l,
> +	.dmac_init = ravb_dmac_init_rzg2l,
> +	.config = ravb_config_rzg2l,
> +	.reset_deassert = ravb_reset_deassert_rzg2l,
> +	.reset_assert = ravb_reset_assert_rzg2l,
> +};
> +
> +static const struct ravb_device_ops ravb_device_ops_rcar = {
> +	.mac_init = ravb_mac_init_rcar,
> +	.dmac_init = ravb_dmac_init_rcar,
> +	.config = ravb_config_rcar,
> +	.reset_deassert = ravb_reset_deassert_rcar,
> +	.reset_assert = ravb_reset_assert_rcar,
> +};
[...]
