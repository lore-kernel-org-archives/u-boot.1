Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B36CC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 18:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27A906067B;
	Tue,  4 Aug 2026 18:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1Rr_6Kue_0I; Tue,  4 Aug 2026 18:13:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DDFF605CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785867201;
	bh=SN1H+TLyz6e7H25Tdyyc5plFSdMLHs84y8+gbMHn8aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qoBBXPRbuVrM4TQKLLNUoah7dzxh9swX9EZKpde/+P3hXkeL0xg7eppYrHoPZAzPA
	 bS+L+6coeuM49AUfewP+xIKUGcsF3GaqsttH9QQ+141lmOfepiwt9I/lfXqQaZbV5a
	 DfSVpG3kLa2OkHL4IH/uoUkRAWvBYWrm9lQuRnQKclVektNddtrIHumcjV8zUL84gU
	 RjmUs1F/tv3eQ5oHvGhYj1y9dxP1s3fdcoZUiXDxyhTXDXN0Z5njQ37h8uesqbFHbG
	 akkrqaFWrIgB7y+1GpFdt41HtxcbB6QEhr+bEGYrzBZjyAx05zUkNTaBtmXF7POViS
	 GWA10/G9XGGMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DDFF605CA;
	Tue,  4 Aug 2026 18:13:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37A0F296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D3576065E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSaEE0Xln7cK for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:09:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9007560627
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9007560627
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9007560627
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:09:13 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso5547356b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852553; cv=none;
 d=google.com; s=arc-20260327;
 b=YcbEliWE6TFeW4klD0eAHFoDSEKRgTbLw3WjSTp8hCkzx+1fiMlkSVmLvSVt+54Mbl
 3NkkVERnK4t9fSvu2SpJEbYpeJUzX200q6NJm/LSE7zx6gvA8T4PIDEv1yz5jkuskhwP
 MHBuSjb8nvxJDtK/tRdTV98D6/TJ23lV/UBv9ymgwlqFizjcP42Pdnq6dBo0QbgXFbq/
 jUnjHNZjGGsL/MqXn6w4W/q7kVcCBSOXnLwuf9SpA3fQEleVnT64r1s5TEQsy4xXdlbD
 /kSqYf0+0fUrsiHNZdU0uxh69DUfBWXTSmkKBaXNnd9loMLXEWfvynWD7maKTzfHeYOJ
 Dq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SN1H+TLyz6e7H25Tdyyc5plFSdMLHs84y8+gbMHn8aE=;
 fh=mVR9Y/rQZk34FU/ncVJcP5o4w0wahIppgQrEM7okHPo=;
 b=rEVoa6oMQel03Ysty+rdjPElGGNBDMeutaJ7tjMjM1hgVrlTi+agEulFBwTqUb3u9h
 sjILvS9qh2IKgZisCA2dLuEo/90Jie/4IAKu5r2aL0wsSFarsmC5tlSeyjmUDuS8FWd0
 QAGl9bnMe1a+d8Dt8ETLQH2eUnRmal5LlCeGq9mUa0xIYYtfcZEnn8LCJwUiLFdtn2mf
 KkZtA3OmWXs4m7qkNXKUHCEtFiKfQ7za9WanRHf+w7/iRkPj5DpMbmg3djlBfxQkg9xK
 ZTZ9xDdvQ8rfkUxtnKQIyLxsVZuNs1kEc895vDXmdPx2CICgXy4Zys2amCRJ/OJchvyh
 INjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852553; x=1786457353;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SN1H+TLyz6e7H25Tdyyc5plFSdMLHs84y8+gbMHn8aE=;
 b=QG2pH6Je2ERa8DizbXyo5SflqJ75BtIx67JbfbKwMPSRl+FArk0/aWXo7nbETJc/Z0
 yEWO9aw1zbmUm8J3tSyqRIYCC02Zf3vz4wvil87fnkOZR7zviaT7XrgEGlpdXZN0/iS2
 02mEJozMGfzLX30nrSwGBAnw7DLyvL1w8mU/pgHYksZJcPaUaFHoS21TEyAuJiilkaUh
 vkpTxhUZXCf4pG7cV+89h4npGof/hiWwybVTc23mlXwbejgSEiTQyOsS2by9Kffev6KN
 oCSWIoc/D2Wm6kIk4NS8AuhCZqmjzDmdVuUoko2jYAsvdNhUuYdNw4Mwo2RTXWCHX5/V
 RaEg==
X-Gm-Message-State: AOJu0YyriLAlpDjeFJ0pryGfAfi+xu/p5TYBmpr/mdVij2dU9aGyrrng
 YLHzAMYd3tFu8QkTABzzpj23uAfU31Zb2dvUPc/llHBXsnlP9rj6n5CVf9yLFjP2f/KrPb6VZYm
 I7DhrcthN8U+dsmonSN8ImK4MmITLFPMsHgntrzDqpg==
X-Gm-Gg: AR+sD13Z2eB4QU58AmJYd0BvVN7HAZIV3sfcfxJBuT2HhvXdCBZaDQ2lii1KLe3QGX4
 z2BIl0B1PbKslDwfZY3/8LIThtl5w7m/tCgwkKZ1ugFFfocWDz2eDlDxmYkF2YkcygerZ2PWOsb
 3ecZb9VkFyk1C/Gi3GoXxLNAuaEYvL+MpkiopuJF3QnsUXPvNZ5lJ1wUlwA1cxmY//oxtL0+knw
 MLA/VEFMkP1rIMzhwOy1aTfyDvXDnMxQRuWE8Zrv9wfVY9/nFl14dtiW4alZ7CwTlWlVLcQyLRz
 /LcZtG5JHjmGnd+qY58WCuFzOfIMVBFdR9ULCPVD5UZhZx8d04VRO1MlEePA4FHracAY4oyn+O6
 l
X-Received: by 2002:a05:6a21:700c:b0:3bc:5284:4859 with SMTP id
 adf61e73a8af0-3c92a4d745cmr16281889637.13.1785852552701; Tue, 04 Aug 2026
 07:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-3-acb97c172993@flipper.net>
 <CAFLszTh0F-GsKVKuEVJ2NjEjjm+KOg375oV8+OwbUu1DBrAMZw@mail.gmail.com>
In-Reply-To: <CAFLszTh0F-GsKVKuEVJ2NjEjjm+KOg375oV8+OwbUu1DBrAMZw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 4 Aug 2026 18:09:03 +0400
X-Gm-Features: AUfX_mzFKz9SAUG4kgEUxA3R-oD5sB9sJ5COqGQH3gep6i_W2saFUNpj_53YveQ
Message-ID: <CAKTNdwHH1tJ3yuRDEA0BZy1mMeqkAK4958ix144_hjEgb--+sg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] spl: ufs: add Falcon mode load path
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 18:13:17 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785852553; x=1786457353;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SN1H+TLyz6e7H25Tdyyc5plFSdMLHs84y8+gbMHn8aE=;
 b=l3WoCeHerXT50QdSXxgPK4VzgDSleb6FUeeY23YmhyeI16KxG4pGmfwCXxkUY7g1G5
 8UZ3FliAAUTZ3Vy95I/zuBnHYuwfb16mv5COur9adh7jZORUuhUIgdir3MjIMS1bIXam
 90XZiocIRFQWZbhTtV4wF5e3P4FolutoLRDmu+3VflYU9MzBQ1wd5wXkgs4JEqhKnrdT
 stwEUDpL4zqboYLy5dbdyOCjvqJ/Gl2zAgHzcO5ZEIYA5exob2TSAvXj6nlk44WHmXVf
 MM2yERaePyyrsSZ1JP2K/Z/YAWRV1lm0NwjzOBVvV5kDBK+RYjtXgd6AnyILGqa9Q5V2
 uaPw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=l3WoCeHe
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

Hi Simon,

On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Alexey,
>
> On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> > spl: ufs: add Falcon mode load path
> >
> > In Falcon mode, the SPL loads a FIT image containing a Linux kernel
> > instead of U-boot proper, and it may need to fall back to loading U-boo=
t
> > if Linux is unavailable.
> >
> > Add support for images containing a Linux kernel, optionally on a
> > different UFS LUN and/or offset vs. U-boot proper to enable fallback.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > common/spl/Kconfig   | 23 +++++++++++++++++++++
> >  common/spl/spl_ufs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  2 files changed, 79 insertions(+), 2 deletions(-)
>
> >     In Falcon mode, the SPL loads a FIT image containing a Linux kernel
> >     instead of U-boot proper, and it may need to fall back to loading U=
-boot
> >     if Linux is unavailable.
>
> Please spell it 'U-Boot' (both occurrences). Since this patch actually
> accepts TF-A and TEE payloads too, please mention that here - the
> current wording suggests only a Linux kernel is expected.

Ack

> > diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> > @@ -20,13 +20,38 @@ static ulong spl_ufs_load_read(struct spl_load_info=
 *load, ulong off, ulong size
> > +     if (spl_image->os !=3D IH_OS_LINUX && spl_image->os !=3D IH_OS_TE=
E &&
> > +         spl_image->os !=3D IH_OS_ARM_TRUSTED_FIRMWARE) {
> > +             puts("Expected OS image is not found\n");
> > +             return -ENOENT;
> > +     }
>
> The equivalent check in mmc_load_image_raw_os() only accepts LINUX and
> TEE - the ARM_TRUSTED_FIRMWARE addition is new and specific to this
> series. Please mention that in the commit message so it is not
> mistaken for a copy/paste divergence, and consider whether the
> mmc/nand/spi paths should have the same relaxation in a follow-up.

Will do. I only tested the UFS and RAM boot paths, so I haven't
touched the others. I'll see if I can test MMC/SPI too (I don't have
any NAND-equipped board).

> > diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> > @@ -20,13 +20,38 @@ static ulong spl_ufs_load_read(struct spl_load_info=
 *load, ulong off, ulong size
> > +static int spl_ufs_load_image_raw_os(struct spl_image_info *spl_image,
> > +                                  struct spl_boot_device *bootdev,
> > +                                  struct spl_load_info *load,
> > +                                  struct blk_desc *bd)
> > +{
> > +     ulong sector =3D config_opt_enabled(CONFIG_SPL_OS_BOOT,
> > +                                       CONFIG_SPL_UFS_RAW_OS_SECTOR,
> > +                                       CONFIG_SPL_UFS_RAW_U_BOOT_SECTO=
R);
>
> bd here is just load->priv - please drop the extra parameter and fetch
> log2blksz from load->priv, matching how spl_ufs_load_read() already
> does it. Also, config_opt_enabled() is redundant: this helper is only
> reachable from the OS_BOOT branch below, so
> CONFIG_SPL_UFS_RAW_OS_SECTOR is always defined - just use it directly.

I believe dropping the guard caused compilation errors for the
non-Falcon case, as apparently GCC 15 didn't dead-code-eliminate it.
Will re-test.

> > diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> > @@ -36,6 +61,35 @@ static int spl_ufs_load_image(struct spl_image_info =
*spl_image,
> > +             if (os_devnum =3D=3D devnum) {
> > +                     os_bd =3D bd;
> > +                     os_load =3D load;
> > +             } else {
>
> The struct copy of load into os_load is unusual - spl_load_info is
> meant to be initialised through spl_load_init(). Since the two
> branches only diverge when the device differs, please just pass &load,
> bd to the helper in the equal case and drop os_load entirely; only the
> !=3D branch needs a second spl_load_info.

Ack

> > diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
> > @@ -36,6 +61,35 @@ static int spl_ufs_load_image(struct spl_image_info =
*spl_image,
> > +             puts("spl_ufs_load_image: Failed to load falcon payload\n=
");
> > +             log_debug("(error=3D%d)\n", err);
> > +             if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
> > +                     return err;
> > +     }
> > +
> > +load_uboot:
>
> The other backends (spl_mmc, spl_nor, ...) print 'Fallback to U-Boot'
> before dropping through - please do the same here for consistency,
> otherwise the boot log just shows the failure with no indication that
> fallback is happening.

Ack

Thanks a lot for looking into this!

Best regards,
Alexey
