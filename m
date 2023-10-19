Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E365C001DF
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 23:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C823871DD;
	Fri, 20 Oct 2023 01:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="ZQdscyQr";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMgj10/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5D8871E4; Fri, 20 Oct 2023 01:53:37 +0200 (CEST)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D570871CD
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 01:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 5AEFE5C03A5;
 Thu, 19 Oct 2023 19:53:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 19 Oct 2023 19:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697759614; x=1697846014; bh=whRLZN9NIWC9CWcUtLXyKGKnjrAT/fmOofU
 LGGq8BbI=; b=ZQdscyQrOBfZSxBHFhko0FxbSEqLr/3B6RF+owf7/EkF+aZiUoY
 ifD5iza6N13X+HG8cG9eSfl2gTEk5ZMh8GDUGKew7Yfcv3W3u9PoZMk4co25hcVk
 eohIaqg7GKUKxvNBl/9Ae3jCZVW5L44vIVgmfaKKjRzdAf+KH9wgUC4WFdtGN98R
 ou91R0Ki6j674LFRdLj0LXpv8hgDk7dcDGX/kh4tj06OcXw8QxncAA46jaOP5X9+
 yf+Oh55ASZ4TXl8EHnWtV2oWQA9MP8F/hf7DxLI2yK8CTMEdjpAN7AOoUznfVR76
 siG8pGB9JNk1dbb7q8mLSLQVLh8gjAhXEcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697759614; x=1697846014; bh=whRLZN9NIWC9CWcUtLXyKGKnjrAT/fmOofU
 LGGq8BbI=; b=AMgj10/8GMLg0rNbH7OobrY4dv2kaF9q9WC0BMi7MWHDuAFw1TM
 Y7/tD+JVTxs21nU5zZUOgDfWbE8x58pvG9VLYxMriV5Nwx7erLWAVN6YVG9Y8X0F
 0ROKGI85VoCX6oxv6peIStPzPaYktKCXsDwTrNJw9YlANY2pgGM3veIVxorVl8/Y
 TAAP0vxyvxJnOlBOwgfiwsESmFiYQsyiH6pKAeuCi2auZTi4Q2Ng+fRrVeS955wp
 iFCoOCrTZ8WDD+Adf2q2yepAXKfAN/V9Nto2S6y8ufuGAmUbDxy0NFLu1OwwcXG4
 4w/UndhBo5X3CEQsfzDT/sYZnl3/JikTbZQ==
X-ME-Sender: <xms:fsExZeyDM_0swB56cE-7RfXRXAZgrpbdjJA-lZxjfdJkOIxTPAW_yA>
 <xme:fsExZaRP-6QFQd1LeSmCIuyrd5KjhL_0Kz1mzAKGcR2okGEQAzrU4xugBOuwDJW1E
 Ywz1I1xPBb7NkG-DQ>
X-ME-Received: <xmr:fsExZQWZHqN5Pn3q0OtvAFMmsWPxJZP3p-P2imKVN5qawNZTQK8OtXHjw5xxIpEpIllzdWG8Bm7zXWzjxVCCiK9XCseFhow7UrVzZv78wzmRKUYVfMpl2RJw5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeejgddvjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
 tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:fsExZUgRAZ0japhbmZlAE2d1q7XMhagwRnq3cNGcgBwV9vGoeZczSA>
 <xmx:fsExZQDQnmli8AmTRLP_n31QhGphI13XqKN7h_USJyR4Y8sAtwpFpA>
 <xmx:fsExZVIsZehZzgtVETcQU8wf1jHqk2lfN31-ihburqymlTq4YcnzuA>
 <xmx:fsExZc3M6RVTVtweonvT3XYoNrDghHn9DdLVydxlk_byEQV_UvZV5Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Oct 2023 19:53:33 -0400 (EDT)
Message-ID: <50e85418-3503-d9c5-89bd-dc04992328f6@sholland.org>
Date: Thu, 19 Oct 2023 18:53:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 12/22] clk: sunxi: Add support for the D1 CCU
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-13-andre.przywara@arm.com>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230928215455.28094-13-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/23 16:54, Andre Przywara wrote:
> From: Samuel Holland <samuel@sholland.org>
> 
> Since the D1 CCU binding is defined, we can add support for its
> gates/resets, following the pattern of the existing drivers.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi/Kconfig                 |   6 +
>  drivers/clk/sunxi/Makefile                |   1 +
>  drivers/clk/sunxi/clk_d1.c                |  84 ++++++++++++
>  drivers/clk/sunxi/clk_sunxi.c             |   5 +
>  include/dt-bindings/clock/sun20i-d1-ccu.h | 158 ++++++++++++++++++++++
>  include/dt-bindings/reset/sun20i-d1-ccu.h |  79 +++++++++++
>  6 files changed, 333 insertions(+)
>  create mode 100644 drivers/clk/sunxi/clk_d1.c
>  create mode 100644 include/dt-bindings/clock/sun20i-d1-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun20i-d1-ccu.h
> 
> [...]
> diff --git a/drivers/clk/sunxi/clk_sunxi.c b/drivers/clk/sunxi/clk_sunxi.c
> index ec02a2d0370..a0011a35d91 100644
> --- a/drivers/clk/sunxi/clk_sunxi.c
> +++ b/drivers/clk/sunxi/clk_sunxi.c
> @@ -118,6 +118,7 @@ extern const struct ccu_desc a64_ccu_desc;
>  extern const struct ccu_desc a80_ccu_desc;
>  extern const struct ccu_desc a80_mmc_clk_desc;
>  extern const struct ccu_desc a83t_ccu_desc;
> +extern const struct ccu_desc d1_ccu_desc;
>  extern const struct ccu_desc f1c100s_ccu_desc;
>  extern const struct ccu_desc h3_ccu_desc;
>  extern const struct ccu_desc h6_ccu_desc;
> @@ -214,6 +215,10 @@ static const struct udevice_id sunxi_clk_ids[] = {
>  #ifdef CONFIG_CLK_SUNIV_F1C100S
>  	{ .compatible = "allwinner,suniv-f1c100s-ccu",
>  	  .data = (ulong)&f1c100s_ccu_desc },
> +#endif
> +#ifdef CONFIG_CLK_SUN20I_D1
> +	{ .compatible = "allwinner,sun20i-d1-ccu",
> +	  .data = (ulong)&d1_ccu_desc },

Please keep these entries sorted numerically. Otherwise, your changes
look good to me.

Regards,
Samuel

