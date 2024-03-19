Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A463BC54E68
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 19:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D08CA88091;
	Tue, 19 Mar 2024 20:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MiRSu0KM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6033688079; Tue, 19 Mar 2024 20:18:45 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4438887B2A
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 20:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56b93b45779so1546352a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710875923; x=1711480723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsPodPrS4atwkOoP8m3HKvElEXH4xc89sCFFzCdpfHo=;
 b=MiRSu0KMCrPfZSWbd57zXzlced9RjLzGBGbZJm9GRJDWNGUu/ooASMIj4IP8iGxaKl
 WFHNNTKnnaVroBxmbx7MbxMcG31lqnb+CvC7Gr68w48f7Z3923T45HXG+c6/fHOAWpIG
 JtjPlIKMlC0v0R9qXo6CFnoojCfBAKtuIjbPkzeDB3KO5lv0y0Qkf6zUl9hh3QSmT4QV
 t0PNUfHAi35EE8P9IeeAVPpyJ7evXI+L1+3gDcEYHDrbbcehSNr+Vll7d7PxEbozdwIk
 Cha7Ds7TMFRd90qqyj2SIltllLhuTwSRUTON/Vi7I6iAk7wy2ZGyX21dpNUKCOn9iQgL
 D+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875923; x=1711480723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsPodPrS4atwkOoP8m3HKvElEXH4xc89sCFFzCdpfHo=;
 b=asc6/nt00HwzYa1TXPkRhAOk+QtIibQsNI+FJcZtt9rDZuGcjxghpRAva/xT4zby3o
 7mbS1amBqhoZJ/j09+T46TPrNhOBgwXEmH4N0juRK/EG91Uy6ocqTk8FJvmn8SKToGzy
 AxD86FoGUF6i89bvdb3ZjD3kKoLAhgB+1zeTprcdOPybO1uPXr1s6YpPZ9EkHQhfaUP3
 BnSjMzqUja1MoEh+VfTDPE/7MO2LS1ZL32WwK30UMsAnurB6XwLLnYS0mYAFbceVORKf
 8Fwlj04ObGF9V0zGnLIWDrTlHMNZab0zBYNsCH8MYMTq6v0WSh97771AQDswwwtI2k5I
 UHag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtbAE7AwdfW+tinpJrUzT4V39d6OcyU16j3xOH2k4TH8JY9eLPhptb2cSCVWFl8HkEpGMUkK1doL6hacYXhIirHCTijg==
X-Gm-Message-State: AOJu0YyaaFr0ve05V569C5vUjDeot0CVSLRo/dXu/F22bSbMV0HnBp36
 nn+1d5ihnuvcZSSMo5zAmoLPdLkuXvsPbJ7/KwuPjPyK4xnNUsOoodMGvdptf9VR2tUhhwbZkBx
 zKcI+dYy1ON8bLvXubq4f3fN049w=
X-Google-Smtp-Source: AGHT+IEkVrlmNcqHRdEGZ1Ecgh+6gRz/uFLiTK+/CgVCeaIbLEb3xAjOE2+hvPBo0JiJWUGa2Na4XsMqm9kjYsW58o8=
X-Received: by 2002:a50:c04a:0:b0:567:45e2:c4db with SMTP id
 u10-20020a50c04a000000b0056745e2c4dbmr11363138edd.39.1710875922543; Tue, 19
 Mar 2024 12:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
 <CAHCN7xJi0K-fXjR2SVU7MX7hbZs618ciCjBCjSBqtNoNkTNSoQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJi0K-fXjR2SVU7MX7hbZs618ciCjBCjSBqtNoNkTNSoQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 19 Mar 2024 12:18:06 -0700
Message-ID: <CAJaLiFwJAn0y=eXAGe6LrWayM44kT8w_38KM+_MT01EyV_rtpA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add missing OF_UPSTREAM Makefile for 32bit ARM
To: Adam Ford <aford173@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
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

Thanks, Sumit!

On Tue, Mar 19, 2024 at 6:02=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Mar 18, 2024 at 10:03=E2=80=AFAM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
> >
> > Copy dts/upstream/src/arm64/Makefile into dts/upstream/src/arm/Makefile
> > and create a commit. This makes 32bit ARM buildable with OF_UPSTREAM .
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Tested-by: Adam Ford <aford173@gmail.com> #am3517-evm

Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

>
> > ---
> > Cc: Adam Ford <aford173@gmail.com>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> > Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  dts/upstream/src/arm/Makefile | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 dts/upstream/src/arm/Makefile
> >
> > diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makef=
ile
> > new file mode 100644
> > index 00000000000..9a8f6aa3584
> > --- /dev/null
> > +++ b/dts/upstream/src/arm/Makefile
> > @@ -0,0 +1,14 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +include $(srctree)/scripts/Makefile.dts
> > +
> > +targets +=3D $(dtb-y)
> > +
> > +# Add any required device tree compiler flags here
> > +DTC_FLAGS +=3D -a 0x8
> > +
> > +PHONY +=3D dtbs
> > +dtbs: $(addprefix $(obj)/, $(dtb-y))
> > +       @:
> > +
> > +clean-files :=3D */*.dtb */*.dtbo
> > --
> > 2.43.0
> >
