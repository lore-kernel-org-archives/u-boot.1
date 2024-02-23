Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158D0C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 08:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D97875AF;
	Fri, 23 Feb 2024 09:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="AXWcS1Jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955C687663; Fri, 23 Feb 2024 09:07:58 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2842887572
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 09:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 573141F8DC;
 Fri, 23 Feb 2024 09:07:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708675675;
 bh=L86itETyxA6LMrl20E5rp2DghJanyoO0AfU2bhK1VKM=; h=From:To:Subject;
 b=AXWcS1JgSRLprB+1HsOq5JUd4Y9CiZEBhoS1iCJwqi822trfpd25BMHQ2YkHMTsRr
 PghGCIAT+pYLQiTVh3n923zmDD7mIMT6NWluQOOA6pS75L10bXPf1dMDj3H/xgZ94L
 ErnWHj6Wm5DdkiHoKsFyP8oEOCRaaDFZmQCyFy5lCgoKroKjYV/Sl7fl1Lb9MMJEui
 D4As3gdvhCqj+hglA1de9i8CBBT1Wed0Ys8j9dhssT6Vedx2osiswExPFB4JxkQ7i2
 pGB81MDp+pu2cv2ghIReuUPy2QTYKitNR8t6DbM2z9I+WpFsLbiHaFkC8ywpwr81qx
 IQQP9KfZIsDyg==
Date: Fri, 23 Feb 2024 09:07:51 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v1 6/7] toradex: common: Use random mac address if
 toradex config block is missing
Message-ID: <20240223080751.GA4408@francesco-nb>
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-7-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220182926.101161-7-francesco@dolcini.it>
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

On Tue, Feb 20, 2024 at 07:29:25PM +0100, Francesco Dolcini wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Set CONFIG_NET_RANDOM_ETHADDR=y, which sets random eth address in
> case there is no toradex config block programmed.
> In case of missing toradex config block the generated mac address was
> always the same, linked to serial number 0.
> Use random generated mac address instead.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  board/toradex/common/tdx-common.c      | 1 -
>  configs/apalis-imx8_defconfig          | 1 +
>  configs/apalis-tk1_defconfig           | 1 +
>  configs/apalis_imx6_defconfig          | 1 +
>  configs/apalis_t30_defconfig           | 1 +
>  configs/colibri-imx6ull-emmc_defconfig | 1 +
>  configs/colibri-imx6ull_defconfig      | 1 +
>  configs/colibri-imx8x_defconfig        | 1 +
>  configs/colibri_imx6_defconfig         | 1 +
>  configs/colibri_imx7_defconfig         | 1 +
>  configs/colibri_imx7_emmc_defconfig    | 1 +
>  configs/colibri_t20_defconfig          | 1 +
>  configs/colibri_t30_defconfig          | 1 +
>  configs/colibri_vf_defconfig           | 1 +
>  configs/verdin-am62_a53_defconfig      | 1 +
>  configs/verdin-am62_r5_defconfig       | 1 +
>  configs/verdin-imx8mm_defconfig        | 1 +
>  configs/verdin-imx8mp_defconfig        | 1 +
>  18 files changed, 17 insertions(+), 1 deletion(-)

...

> diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
> index a3febdcb6941..910340ea5a41 100644
> --- a/configs/verdin-am62_r5_defconfig
> +++ b/configs/verdin-am62_r5_defconfig
> @@ -65,6 +65,7 @@ CONFIG_SPL_OF_CONTROL=y
>  CONFIG_SPL_MULTI_DTB_FIT=y
>  CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_REGMAP=y

This change here is not required, it has no effect since there is no
network available on the verdin am62 r5, however it is just confusing to
have it enabled.

I will send a v2 with this removed.

Francesco

