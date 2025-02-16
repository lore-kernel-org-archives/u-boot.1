Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0753BC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 12:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6595380F4A;
	Sun, 16 Feb 2025 13:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nQ+7jtxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1A480F53; Sun, 16 Feb 2025 13:56:41 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD54280F64
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 13:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e04cb346eeso1161253a12.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739710598; x=1740315398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pj0x1iCvA1BDG3F0OBprii7lpLo3TtaH69ReXOv8wSE=;
 b=nQ+7jtxdiBQ7IQU61bWoIWxt7CYhYLgD4Seqber+CE/82uQ4ZX5weNwAfhMqKoAIz9
 yLKLR9pEkAxG01jkp6H1taAm9hkwpLGG3JrHSvyNQUEV5eK6j5dImjBpNW/CnnYkR6qK
 LJqlLoP9fZnRdHtAM6bHGCId+rKr0Sd2dhzYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739710598; x=1740315398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pj0x1iCvA1BDG3F0OBprii7lpLo3TtaH69ReXOv8wSE=;
 b=PUYEjkzToQWxpXIm/2iPNR83RfIypCBFFrqdVZtmJ61FFZfHKG1HZvaYar85M1krnm
 aWSDl1jYvaF71uPJ7zzOvGT5bCgB/06WqbTCWQ6OFK2BIuV2HXx5Y1/XpWtqxFZ1w2ds
 Q/PCdmFN4m5DtJsXJ1kGXiy6PN09tbtt1O/2ehcGy3EW1RglmB8Rk/2UO2hAqucMcgYR
 26Us1duuCkzsECfqBlLLZcvfnT8jpB9tdKFFZuI5UqcoWlrnZ8VDveul3XiTxQvshwCC
 knktfHSNJe0M0di1KwhPYEiIWdCYgPkeOGCiJDmLkO+tT56ZSLZZHjxFfaKr9z7Lip/1
 PRAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlttt5GXU15RNCDfYNkHx5S/bzsoQYQHuFWBtjq2hctytDuBjQ6llNeDD/klUVDi3v6TIntFc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ+n05GPsXlppTZuXus+EzDYV2a/GiG8CcCXclhLK8p1LsFlwZ
 iDi/25iIa7z8HbJGKc8XkpXWfx7lswjj0Sg6VdNT0a81lZQKSQ5AxnA7tKLKFA0ru7yHaC8T0RO
 WkwBk5uqkDAaKsYqRgPAH31huhLeBT5pIsrdY
X-Gm-Gg: ASbGncsI49zRuRi2Ed1Ql2vYiry8UBruK3WpItUmay9umWpVocx8zQ2dx/csdYvqf2g
 PHN53e4bspEyah46QPLZCM5YmWAzP+VDF0AFCbAXgtpWu+5EO4mnMGaaD3y0u3CJ98kmLShj65w
 ==
X-Google-Smtp-Source: AGHT+IF9jkYT9eQFlcNhft4g/nSy/ea7+3GKuOLuIKJQk/4wE77fzv+YaeV6amdVv20ZJIyHfz9wTQOJ8izNXwh7/j4=
X-Received: by 2002:a17:907:9494:b0:ab7:ec84:10af with SMTP id
 a640c23a62f3a-abb70b1d813mr652710466b.16.1739710598142; Sun, 16 Feb 2025
 04:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20250215175534.203539-1-clamor95@gmail.com>
 <20250215175534.203539-2-clamor95@gmail.com>
 <CAFLszTjqDJdDUYVHchnrYn1e1_PTqCPusNCUWX_gBdncLJvMKA@mail.gmail.com>
 <CAPVz0n1O59cj_r0jDK59e+Q_YD1yTz9UASai+BtCz2AhVGr01w@mail.gmail.com>
In-Reply-To: <CAPVz0n1O59cj_r0jDK59e+Q_YD1yTz9UASai+BtCz2AhVGr01w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 05:56:26 -0700
X-Gm-Features: AWEUYZn13941M9D67DJZy8P3-qnrGJKwvEgBmvet1Paan80VDjSSnDWke0S8KLs
Message-ID: <CAFLszTimQBXGBqfG2BW8PYCXidQ+Rtr35Gh1jZVTXbC58Ujhcw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core: ofnode: add of_graph parsing helpers
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Sat, 15 Feb 2025 at 11:10, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> =D1=81=D0=B1, 15 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 20:08 Si=
mon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > Hi Svyatoslav,
> >
> > On Sat, 15 Feb 2025 at 10:55, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > >
> > > Add a mostly complete list of ofnode analogs of of_graph
> > > parsing helpers.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/core/Makefile       |   2 +-
> > >  drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++=
++
> > >  include/dm/ofnode_graph.h   |  90 +++++++++++++++
> > >  3 files changed, 308 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/core/ofnode_graph.c
> > >  create mode 100644 include/dm/ofnode_graph.h
> >
> > Can you add a test to test/dm/ofnode please?
> >
>
> Sure, is there anything else besides tests?

The other other thing is that you could mention in the comment for
get_display_timing() that it is an optional method.

Regards,
SImon
