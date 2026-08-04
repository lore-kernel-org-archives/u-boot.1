Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0527C55838
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AAC780C8D;
	Tue,  4 Aug 2026 13:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hd8NVEgH2NNk; Tue,  4 Aug 2026 13:11:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 06B2180C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849072;
	bh=QtURLZPw/s4YlPRl3PJM8xzkMd3UL1+OeUG0ZjY1EcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FyeKe/ibtGSqFp9Ob9t/N0Ov0OG8uyUTMNGbsoxpwuwIIEVIxiydm3jwkMAbVbVY2
	 Qxe2z6OcBNZwPmNRvxB1pFQty8LCarNgQLHjR3VaMe+Nx+Zcp0ZQlQQpiLSJee8oim
	 eBbGx7JPDiufucjeJ/EN9ocyY3bnEp8LuXDp8KUG44yGeKpwIoKX97k2qcqDPOOOaE
	 hU+U+VrmaHsaGKgKW7B/N/Asaempd5BtZjvSPVzznepl6LN6IpRj+AqMWaBRojXMy8
	 Nn0rUOABpQHPXWYA/NEzed7ZXndAZ92NumI175qIqfr89Y6S5Igv8mkV1QPnzvC+YX
	 KZh3f2FfjLZIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06B2180C6F;
	Tue,  4 Aug 2026 13:11:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EBF62AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 203D54053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 74Ou-BV7rgB1 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:02:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1FBDE40189
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FBDE40189
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FBDE40189
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:02:53 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso3166377a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848572; cv=none;
 d=google.com; s=arc-20260327;
 b=mBBPpky/Yuv5Px+vKGRdJlVm6KMnoRhlniVXcXxjyHBNLpsU4Lz7TM5jF8fhIl34PU
 4l2S6tWMcwgZBEqJZsuOuHnto5hLhNq0HTuCTNONenDIOHUieaCUoGj9maDdc/ph/czL
 p7w51j3Vtn+uO1dDsCynEvou+qWFgQrAGWKQE82CqTjG/T5u3Y1D4JfMNyoqgn89UPfV
 ng5erCK0/pOv4HbC4XKiocsbkzCDbad43+vPh9lDLXrwtpU1OTa+XC183ta3RVtP9dAk
 6e8cvJPtELxHMbaMkyKCTY1JknU4iRh/BHs/JMX46Z1hoDb2TUZLlxszAg6pMHpSjiqE
 4k4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QtURLZPw/s4YlPRl3PJM8xzkMd3UL1+OeUG0ZjY1EcM=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=GTLrZgPy5xjzkYZ+IfqzCQO4zyeJ7RsYKG0KDjwavwpimj+/ExzX6DZiKDYe76BTyp
 kBBXJQaB3wju1Sj2PE4/osf88RQ6ikPRGcHLJrIYTjLoYQPpR2EVAtnOqeNIAdwEXW3f
 lZll+IYjuwnsu3rN8th+uXcpq5PiRlsdt0xfByB//jyw11rJlHmJ2CrWgXvY8qin/T5c
 5doamzI9aj3C4eODineMZTCkh12+WJyQe6XEsuPkmLM7uPP0SWN/E9+Z7AJ1uZFICaTK
 gOHHZw/hKg/aMCSaY905B/uzWrIziXUJ7SVq7MACprhWwBOrrPgTrvUhOkkp4pIrIuKJ
 wMnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848572; x=1786453372;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QtURLZPw/s4YlPRl3PJM8xzkMd3UL1+OeUG0ZjY1EcM=;
 b=rhxQRTkUC3fPtau6MDZ6PUQrO9NVyDDcheYLPXyAQcGsl/kbHsMWjHzoGNSxaBBg+W
 9Zjt3yrbfWbyd5Rey06HQPhIcO9a51eakasCywphc5bJnz45EVxhBuNhJ0eNKNI62pNs
 9GL051mLG9ggzdRZlgT035D8dnM3VyYy+LDw4zUO2pEny9985FLzlOXsi9ZbAuJX3MOR
 c8Nmk+YiD0yoke1yswMbaKX3T2A/u1c0ImYcn+uCd0UyAcXvp1Uc1IaermWtRR58sKNH
 7JnZgsDqVjXx3PPXGw+KDt5CS0LNZnwhY7mogQLi63X9ILkqMzuPzzeBXOUKx4yd7sNL
 0Z7w==
X-Gm-Message-State: AOJu0Yzg24fiAQd3LJnY06JrRV5EMuGjlAMzUbRah5gon8fnrR/7t9L1
 CUOvXJY192g2Gse4/4+1To/LKjIL9KGOtE29XGzfYba8grBDBmw4q9NsgBs6Q8esKqyympL4uJX
 JoYtoa/Im/iWVZ4kmJP08pVKJ0ypN+eqWnqvJGQce
X-Gm-Gg: AR+sD12zBQU/tIBHTw4NmZBfN+c0Ae6sNxBnex17Jmbl1yMxz4JUviU+P0mGaOzX3dy
 PbpktOBGLhPiigFwZniT/m5WeBnh/N/DcTirN4i2G5PkUteAOFN/TpB9W4B1TZZW95dJDWl0DdP
 e4AzeC0Ilao7fwB/cEZs/aPEAd0vYqWeCvHn+oWVPbp5hAxsNL4rOHXzsw6/MknCVESUyImd/4H
 dK88IzTKhSLe9aTIsmiv6RJf4qd2laIwD+R8Cuaw1YDm4NTs+W66TME/RKdXivP4THqjXSc9F70
 ubw+luf1chgexdnHn7kI2MhCAs61Dl7gqS59pGlmsFk=
X-Received: by 2002:a05:6402:21ca:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a0a7c72678mr11471302a12.10.1785848570978; Tue, 04 Aug 2026
 06:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-3-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-3-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:02:36 -0600
X-Gm-Features: AUfX_mzeleGmH2-K8ok1p7qs7F7xoQpc2j9iHg3W7ouhpc6rLo-S6jdH1QLJ0RQ
Message-ID: <CAFLszTh0F-GsKVKuEVJ2NjEjjm+KOg375oV8+OwbUu1DBrAMZw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] spl: ufs: add Falcon mode load path
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848572; x=1786453372;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QtURLZPw/s4YlPRl3PJM8xzkMd3UL1+OeUG0ZjY1EcM=;
 b=ZqGHilKK5RMqO7quZo2uOMgDmcL93vhpbr36TElTDRqwrfvzCCSjdnrF6Yjn0zMw+n
 3Xy0z9zfsspKjThjhhuf2obiNJPOQ67oVz4heB2EB7KAc8yaL95diRDsYTq1zWqCupdF
 DjxoyrarHE4/AdP3cy5LBmzmPfJIhYPx6nwFk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZqGHilKK
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> spl: ufs: add Falcon mode load path
>
> In Falcon mode, the SPL loads a FIT image containing a Linux kernel
> instead of U-boot proper, and it may need to fall back to loading U-boot
> if Linux is unavailable.
>
> Add support for images containing a Linux kernel, optionally on a
> different UFS LUN and/or offset vs. U-boot proper to enable fallback.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> common/spl/Kconfig   | 23 +++++++++++++++++++++
>  common/spl/spl_ufs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 2 deletions(-)

>     In Falcon mode, the SPL loads a FIT image containing a Linux kernel
>     instead of U-boot proper, and it may need to fall back to loading U-boot
>     if Linux is unavailable.

Please spell it 'U-Boot' (both occurrences). Since this patch actually
accepts TF-A and TEE payloads too, please mention that here - the
current wording suggests only a Linux kernel is expected.

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -20,13 +20,38 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
> +     if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE &&
> +         spl_image->os != IH_OS_ARM_TRUSTED_FIRMWARE) {
> +             puts("Expected OS image is not found\n");
> +             return -ENOENT;
> +     }

The equivalent check in mmc_load_image_raw_os() only accepts LINUX and
TEE - the ARM_TRUSTED_FIRMWARE addition is new and specific to this
series. Please mention that in the commit message so it is not
mistaken for a copy/paste divergence, and consider whether the
mmc/nand/spi paths should have the same relaxation in a follow-up.

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -20,13 +20,38 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
> +static int spl_ufs_load_image_raw_os(struct spl_image_info *spl_image,
> +                                  struct spl_boot_device *bootdev,
> +                                  struct spl_load_info *load,
> +                                  struct blk_desc *bd)
> +{
> +     ulong sector = config_opt_enabled(CONFIG_SPL_OS_BOOT,
> +                                       CONFIG_SPL_UFS_RAW_OS_SECTOR,
> +                                       CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);

bd here is just load->priv - please drop the extra parameter and fetch
log2blksz from load->priv, matching how spl_ufs_load_read() already
does it. Also, config_opt_enabled() is redundant: this helper is only
reachable from the OS_BOOT branch below, so
CONFIG_SPL_UFS_RAW_OS_SECTOR is always defined - just use it directly.

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -36,6 +61,35 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +             if (os_devnum == devnum) {
> +                     os_bd = bd;
> +                     os_load = load;
> +             } else {

The struct copy of load into os_load is unusual - spl_load_info is
meant to be initialised through spl_load_init(). Since the two
branches only diverge when the device differs, please just pass &load,
bd to the helper in the equal case and drop os_load entirely; only the
!= branch needs a second spl_load_info.

> diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> @@ -36,6 +61,35 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
> +             puts("spl_ufs_load_image: Failed to load falcon payload\n");
> +             log_debug("(error=%d)\n", err);
> +             if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
> +                     return err;
> +     }
> +
> +load_uboot:

The other backends (spl_mmc, spl_nor, ...) print 'Fallback to U-Boot'
before dropping through - please do the same here for consistency,
otherwise the boot log just shows the failure with no indication that
fallback is happening.

Regards,
Simon
