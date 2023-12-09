Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8EAC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 19:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9670870FF;
	Sat,  9 Dec 2023 20:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="R96Fb8K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80CF8717E; Sat,  9 Dec 2023 20:49:18 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86CA87078
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 20:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4b2f3539089so1765589e0c.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 11:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702151355; x=1702756155;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fx7EItXgEHhk4qpgV80zstiIE2Te3GcM1AD5Z6SPrQc=;
 b=R96Fb8K5odIz+5SQickYFu+wjr74uNvw6fJ3wlgMGhTixiPOmcJmI95YvNsdyXuEuH
 BpLCCtrH93Kq4o8ugvQJnBbr+lswbeunByrPb4uLMPwFg5HSU3Xy/UG6Bsdul7H2ZVNH
 EnWOXAxY9g7TJ4IMkEMOQURz4b2dv336GK/MFNmwOGoMnjsn2jttjAuS65/GrOFwnyGk
 zXnN5U11M71CO9YoqMRDWUQpyhSFoSfhfMqCD9BSvPyeeCiBUxYtWzPhQQLh7xjqAe3G
 NuEqvrKFPfssPXIsh/JzxQgQA0rhC5e1a54NvrM7pziGa/pIeCzb76m2rleUdTjDJ53R
 Ytuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702151355; x=1702756155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fx7EItXgEHhk4qpgV80zstiIE2Te3GcM1AD5Z6SPrQc=;
 b=WzbqRvMHlbgCui+cY058SZc2HXFKDDP03u0KnlnSjJQKztVvB5r2LYNNVFOra2pGlc
 oIF5WNjUTSwqrmT3wOlAtUsaAxMUHI2k/L4OX28Ltp3usjtLWHgLMEv+BCU6aBsrW2qv
 7DRnfMt4bf5de3mputazDGcBcUtOk2MfqigNUTRw2yHC18ccmN0XLBij74bUnmXLzu74
 q1hlzkrFus213j2jez0rk50I9TgOQujt3477dP6f69DhGlsuinjJS21rRJ5hoG0p6HzE
 Ldg0UAC1SrM1b95KhwgaQfl6W/X5N3vJV4nT67vO5j1gizNPkpXQS/SEGcVuKlvnngX2
 lq/A==
X-Gm-Message-State: AOJu0YwhFoXzpLonZUBwuIelwDHde31ZK3TNsBRaXFYVdormDeXH2SRR
 c1kUevNuChxHZ8UoBbEQYc0apBObyMM1hPW4jBINKP4E4UFgawk8
X-Google-Smtp-Source: AGHT+IFhhBZA4vfgZYfYTEiEdMZOOXGxjpalRV7zo8kbSBs8dTwFxbmPPFB6lrK/7A4Icn7cUO3lTxwK/JPadh6LhDE=
X-Received: by 2002:a1f:df02:0:b0:4b2:c554:cd02 with SMTP id
 w2-20020a1fdf02000000b004b2c554cd02mr1632970vkg.14.1702151355356; Sat, 09 Dec
 2023 11:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
 <20231209191853.GA2513409@bill-the-cat>
In-Reply-To: <20231209191853.GA2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 19:49:04 +0000
Message-ID: <CABEcMwU4C75Xsq9AYdugyPqjPYbrTf3C01gnE+sTM0WDyoMkQg@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Dec 9, 2023 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 08, 2023 at 10:52:02AM +0000, Shantur Rathore wrote:
>
> > Hi Tom / Kever
> >
> > On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.com>=
 wrote:
> > >
> > > Rockchip SoCs can support wide range of bootflows.
> > > Without full bootflow commands, it can be difficult to
> > > figure out issues if any, hence enable by default.
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  arch/arm/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index d812685c98..fca6ef6d7e 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > >         imply CMD_DM
> > >         imply DEBUG_UART_BOARD_INIT
> > >         imply BOOTSTD_DEFAULTS
> > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> > >         imply FAT_WRITE
> > >         imply SARADC_ROCKCHIP
> > >         imply SPL_SYSRESET
> >
> > Can this please be merged in ?
>
> I wonder if we shouldn't really globally default to BOOTSTD_FULL if
> BOOTSTD_DEFAULTS for everyone.
>

Its matter of ~21KB in size, unless any platform is really to its
limits it should be alright.

Regards,
Shantur
