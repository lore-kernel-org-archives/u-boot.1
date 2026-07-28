Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B20C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 07:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77DA580EEF;
	Tue, 28 Jul 2026 07:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uIC78-lE7Rm; Tue, 28 Jul 2026 07:59:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90F5780C44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785225574;
	bh=uJUulWALc/8IKsrV1io5PPE1pw2Vd5NLIY1Y0H6h+vw=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DnxCy9Ffh0JNvKhIYwTuNF2XA4WYxn5Rr7qYrJHIVXzcG+En1hpUFOgsf4FPHS5N6
	 cIZtOysKEzrio29Xj8mDutCiiwDsSPK8wNNaDwDMxwI7pVfnNIs6a/JRBXL+4iZmYo
	 JlWDHD5cn43APsa15OnBi/dAJKoYaBwVSCNgpDdGQ2FmxF9UgNDklSLLIFq+YIm0Ur
	 vo05uK/MhomyJm68rV7TIEsJQCSdMmaAH8igiUGHYPCE8MmqHCyyT6RutwyJBIerVw
	 VH55A7o6ViNkcAj16e/oiBjKxL92ZovokOJHEigTWB4gfufoF4akX2FGU+E6ArwCMk
	 BJCUKETNwCYlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90F5780C44;
	Tue, 28 Jul 2026 07:59:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8003B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3212640265
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SP2gwkBushvu for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:59:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E3B5040042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3B5040042
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3B5040042
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:59:31 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b011edaf7dso3575632e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785225569; cv=none;
 d=google.com; s=arc-20260327;
 b=a1iZhieFQ88Lg/nugUuiLwdHvAuLEtGRNwIlhUvfmf5g8ywXAyKGJ/ie2PCFTC+VpC
 vBOM4gNkzO2JKDuhEg47yoS13bj7MTgNCF173Nk8uz60fthB3/vo0CCQpngDwwCVLTDV
 wjfwlv+nW/gnYO8LcSS7tdw/W/f18/E6vn6zNIfYlJzkQPnuc+mj2QktGg/wjot8zUMw
 5o6yeRMM9sxmQC3hr349CkfLsWY/pON7toEnagOqWxhE04ryfFyIB+aYTkoj6nQoD4jD
 YFecPNS7r5IdSFqJQBUZA316RSAth2eeLWW6EnLT0bmZfFXx/b+Q5xGVtbVJbylYPjog
 krXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uJUulWALc/8IKsrV1io5PPE1pw2Vd5NLIY1Y0H6h+vw=;
 fh=sNY6QEcKUeDKS6L4gPUDv5Xg3tdkb3d2NACSAWUpUIo=;
 b=escZ/qPDbQSi+VecelF1aLzCgFAtTQgU8pd5ueMad/2YyrL3FKCZkz6obb47K6RimX
 sPdS20UF+CpHYPP2WLXaRoP8V48RO5i6yWb3t2zFNmXkFUg4vOLyeWxe4hbGRBDOPcKd
 znecLbMC0aOIUaNOx3j5UoWQL31JFI5ZXOcWkKTc1i2i8rG4BdVnmpoZKMponbd7yHoj
 arTM3zoA2YfBKyX5mvjvfzkRuYuicRVVzGFeC6+PImyVvTtRuPzguM9wcFnqyVsrB9Cq
 NIgWlfMUe5jR6Ph5tNZo3jwfay+/jvOdWFdK3RvF5h2Wfiij/Od22rzw+rMcgvd7Vr+X
 I3OQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785225569; x=1785830369;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uJUulWALc/8IKsrV1io5PPE1pw2Vd5NLIY1Y0H6h+vw=;
 b=ABCYWMsukkATCzEQcALx9M2zPlYO/TiwjTIcp1IyNPL8Kdv3r7RrQCgMUKULJfV3fL
 5/peQQanLkEUSSs0YGV3sBYmzAC+Vc9ZkpF5RVhaf2L5HW5fQhcFaPN3dJnxXQf3fGLL
 xTr/SRkK3pTsWi23JjVP9g8vd/vL7Gz15kQ36PkCPCMEJIGpM2SPA+BDzqf3iziAZPTT
 3wF4Qv2COU/0Ss1Y4VjZfxMDYz7cmJwYYPMCaKGVMk5xcgLFmn97ErWpo1BbsMQJMh3e
 Yi2qSZBPvKJWHDivelJykeUdrGBs720UF4Dz3ADbbrteL+pbSnP+FX/o3+ZGwTtGaoo9
 T82A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtB8lWth31T72jibPaEb1weSQXQg0G1wAK78+hEnGX2UGBp/EUOwPlmilSOspgvzqhQl5ETuo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwsqJ0RHJO8ONJW3w8B9NcFelkN6hnp/d8JJOmC8cIi5Fl0Wuwd
 92746CQ0fsMRqEnRadIYKnTlbnG3OO24YRMmKbfyVvijkhYQVKAGjKe5rzjLyRUSr5UnX2JdOGv
 6LmEGbvz2rJKMECjQyV00ZuO+Y9/Q5hFyktNzmVfDWQ==
X-Gm-Gg: AR+sD13hbtBKtmrKrNIgfnOlGF+aZAszu77Gh0wiJwwI/Ad5lIVX7izW2h4hZesgq15
 VZvbX18ohISuhlTjpDB7KP0FQ2jUVHtBe6ZjAd9w962GoTgO5Do97rmUZW18RZakbMb+TW+VfBo
 lsLhoBkbFW3+NZ7F5ejsJxiWrPsxiSFSioDyTpxQ2zq6kmOLk0IIi/qpa6oRh4na3/Q//q0VOs8
 p4naqPZ6kZ6/ZYRQ3gcQqIo/Gp8Ww/421FlkN9G10wCmS2JOLmnkmI3eHQOSKK9
X-Received: by 2002:a05:6512:128a:b0:5b2:b941:ddae with SMTP id
 2adb3069b0e04-5b2d0225497mr284267e87.4.1785225569064; Tue, 28 Jul 2026
 00:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
 <20260722154602.3373184-4-jamie.gibbons@microchip.com>
 <CAC7DN2CW0VU3MBycsLzKoB0LztjC-DuVj1AbDYFFDPK4sMYxMA@mail.gmail.com>
 <5012bf190ba74c8467798efe7fd26bc53df19707.camel@microchip.com>
In-Reply-To: <5012bf190ba74c8467798efe7fd26bc53df19707.camel@microchip.com>
Date: Tue, 28 Jul 2026 15:59:17 +0800
X-Gm-Features: AUfX_myXD4VICYNHn-ga2FAkRnjZKWmdbTqkPYW-tyurBmTBUM7pi1IvEmdyZpU
Message-ID: <CAC7DN2DrcxshCvx42TEWzD721-B1p8Lud0Kj0TgmH8TZucw5ig@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rng: add Microchip PolarFire SoC hardware RNG
 driver
To: Jamie.Gibbons@microchip.com
Cc: Valentina.FernandezAlanis@microchip.com, xypron.glpk@gmx.de, 
 trini@konsulko.com, Conor.Dooley@microchip.com, sputnik@on-the-web.ch, 
 u-boot@lists.u-boot-project.org, michal.simek@amd.com, u-boot@lists.denx.de, 
 sughosh.ganu@arm.com, ycliang@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785225569; x=1785830369;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uJUulWALc/8IKsrV1io5PPE1pw2Vd5NLIY1Y0H6h+vw=;
 b=cg2E/yGYCwKB9xI9Is2YdGv5iFwFUSgrG6TvRwArmoGGCT8c6yCNKSWmyXj1LsjfNM
 PGi1VmybOqM3mLomptjurNx6i+ZbDnuS3i/y0bChQii6YqzGlLygII5hgyB0bu8pItEC
 KTKUP06mBOPvxiTapEoWQRaUrmL6NKalwfxnHncaEiouZIIBgu6us0Z2vzeUzRuAyBbo
 sr0CPy8MVPTmBAJoHwAx1Jsw4mPRq2bZfTWj1cKFKqZwoJ4ntfnEVNJBG9Oj0O7o5gUZ
 k7CHVQfFyEImUUrWwfNmI0Ho9APMcbRcQhZjXJtSrBst63LKLrm980TKPkP9RelH1yNx
 NMxA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=cg2E/yGY
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jamie,

On Mon, Jul 27, 2026 at 4:12=E2=80=AFPM <Jamie.Gibbons@microchip.com> wrote=
:
>
> Hi Leo,
>
> On Mon, 2026-07-27 at 15:14 +0800, Leo Liang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >
> > Hi Jamie,
> >
> > On Thu, Jul 23, 2026 at 8:52=E2=80=AFAM Jamie Gibbons
> > <jamie.gibbons@microchip.com> wrote:
> > >
> > > Add a U-Boot RNG driver for Microchip's PolarFire SoC (MPFS). The
> > > hardware RNG is accessed indirectly via the MPFS system controller
> > > using
> > > the mailbox interface.
> > >
> > > The driver implements the UCLASS_RNG interface, requesting random
> > > data
> > > from the system controller and returning it to the caller.
> > >
> > > This allows use of the PolarFire SoC hardware RNG via the
> > > standard 'rng' command and DM RNG API.
> > >
> > > Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> > > ---
> > >  drivers/rng/Kconfig    |   7 +++
> > >  drivers/rng/Makefile   |   1 +
> > >  drivers/rng/mpfs_rng.c | 101
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 109 insertions(+)
> > >  create mode 100644 drivers/rng/mpfs_rng.c
> > >
> > > diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> > > index 19b2b707677..856ffda2f5e 100644
> > > --- a/drivers/rng/Kconfig
> > > +++ b/drivers/rng/Kconfig
> > > @@ -23,6 +23,13 @@ config RNG_MESON
> > >           Enable support for hardware random number generator
> > >           of Amlogic Meson SoCs.
> > >
> > > +config RNG_MPFS
> > > +       tristate "Microchip PolarFire SoC Random Number Generator
> > > support"
> >
> > Is there a special reason to use 'tristate' instead of 'bool'?
> > If not, I could convert it to 'bool' when merging the patch,
> > so you don't have to respin the patchset.
>
> No, I don't believe there is a reason - this is a mistake. If you could
> fix this on merge, that would be great.
>

Got it! Thanks!

Best regards,
Leo

> Much appreciated,
> Jamie.
> >
> > Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
> >
> > Best regards,
> > Leo
> >
> > > +       depends on DM_RNG && MPFS_SYSCONTROLLER
> > > +       help
> > > +         Enable support for hardware random number generator
> > > +         of Microchip's PolarFire SoCs.
> > > +
>
