Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FE7C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 21:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B1E87ADA;
	Thu, 14 Dec 2023 22:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lTL6cDnU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CF987B1C; Thu, 14 Dec 2023 22:15:38 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130EB87ADA
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a1f8510883aso2435266b.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702588535; x=1703193335; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGf6gOE21LBQIdL7nl1i60OApL+MgQdPENCb5TjgK9c=;
 b=lTL6cDnUyFbEHodUK5a/sPbQUaMucvVY88sRiUOD1jFV1pWiFwDpk3c0y0EUK3KZLK
 VkmCjohHxJ+j1UHDbkN8uYzjXVxtSR4dsP5NWgqFfxvX75pPtnIlfDgp1taGLDbg+t9V
 Xqtb9J2+IEcAFEZ8nBoHXN+Km9yU0Gf/VR1bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702588535; x=1703193335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGf6gOE21LBQIdL7nl1i60OApL+MgQdPENCb5TjgK9c=;
 b=ZjosV4HnOjDIOt5g2CA5JaTKXlcqDCcjqHfP1R1su46Ax8jEjjxlJLAMEP+a76pU3V
 ACK4NL4dZYS+3HB2IVnxQDpSFuHFb6xCKxxN1b09lwmHsg7H6hE7+qrO7Bzn9UMZZeHs
 VZu4BHapeTrxrf8LP3XIrYmtQgUAmFrpIeUalDEkX5K3gvGoBlFIeFodOHrj+BFhzEfQ
 rhV3OshK76SBnAqVdGj+HVtNzH8/+gfcgH7RNolx1z9oZY2f9i8wMKpkO+x9F3pwxRvF
 1/XZOlMtmD1MK/aafxvv1KtQktNXYS07qLgJ5Q+SXs6jDxr2nOKjVZ73lMYgLF2M5iDL
 ur5g==
X-Gm-Message-State: AOJu0YxrPnojeGPXtgbO2INIyekoMvf85aZyu/KEvHh+iRnnL2OWIEgq
 bfAab3orJZjc2M0OfRtYW1P0cy6rciuXGcUPIzy2fA==
X-Google-Smtp-Source: AGHT+IGaCSZZ6X9yUHhNzbnHfZ5PhrjAGA5J9pRdfrPEXbdj+d2BWkjnCECMBN7IL5sbkifdc4rfHlq2zciQjLeM5uQ=
X-Received: by 2002:a17:906:60f:b0:a1d:756b:383b with SMTP id
 s15-20020a170906060f00b00a1d756b383bmr2675111ejb.10.1702588535055; Thu, 14
 Dec 2023 13:15:35 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
 <ae0675e2-940a-439e-9557-e5a4f745f1b0@ti.com>
 <CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex6wvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex6wvQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 14 Dec 2023 14:15:16 -0700
Message-ID: <CAPnjgZ1JjSKKaxcWU+CaHLS_g=HG=3q_XoscgxnGa3+sA3p7aQ@mail.gmail.com>
Subject: Re: Proposal: FIT support for extension boards / overlays
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Davis <afd@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

+Masahiro Yamada too

On Wed, 13 Dec 2023 at 01:22, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi,
>
> On Tue, Dec 12, 2023 at 4:52=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> > On 12/12/23 8:05 AM, Simon Glass wrote:
> > > The devicetree files for a board can be quite large, perhaps around
> > > 60KB. To boot on any supported board, many of them need to be
> > > provided, typically hundreds.
> > >
> > > All boards for a particular SoC share common parts.  It would be
> > > helpful to use overlays for common pieces, to reduce the overall size=
.
> > >
> >
> > For this to save much size we would need to have the SoC split
> > from each board that uses it. We don't have that in DT today.
> > There are some efforts in progress to help on this but until
> > then we will not get much here.
>
> Indeed.
>
> E.g. The Kingfisher board[1] is an extension for (various) ULCB
> boards[2], but we cannot use an overlay for the former, as the
> combinations need to have different top-level compatible (and model)
> values.  Hence currently we use a .dtsi file and lots of extra .dts
> files[3].
>
> The other issue is the need for parameterization, due to slight
> differences in pins/signals on various base boards, or because the
> same connector is present multiple times (e.g. for multi-camera
> setups[4][5]).
>
> [1] arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> [2] arch/arm64/boot/dts/renesas/*-ulcb.dts
> [3] arch/arm64/boot/dts/renesas/*-ulcb-kf.dts
> [4] arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi
> [5] arch/arm/boot/dts/renesas/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
