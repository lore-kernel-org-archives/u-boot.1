Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CA4C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB9D86B2E;
	Mon, 13 Nov 2023 15:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Px+ceGGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F9F86A4B; Mon, 13 Nov 2023 15:00:55 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D0487026
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so684483866b.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699884053; x=1700488853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gc23FeNYp6rVuFnlGcI7zHlZolN+C7r9N1PNDJuTQI=;
 b=Px+ceGGRamk7+1Nx/j3LcvAXVjixW6P4092XCDWfoH0ZiduFw1ahHAJa+wwFZeKHot
 GRuAjQDscuEHTVe9cLfvLqhHLBqwNZ3Di6zStV7zbbBjHIerKuihHsEaWrAdv6nSiZrr
 wr5TcBFOsOy+r46A2oJG+TiavOwC7qzzpYUCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699884053; x=1700488853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8gc23FeNYp6rVuFnlGcI7zHlZolN+C7r9N1PNDJuTQI=;
 b=BZpkOp8kT9My/+rZXt1u7Gdxdx9Ekzu03124T/WgnmHnQkGaINbC1jSl7PRJUxFYp2
 C3olt8602H5y5makcMVCh0LnAHBAzx1C3Kc6Do+2QuZlBqIhMQD/O/ATOXLnlLDCalVq
 5MIHkeZQFQNohcO+VtmXAdtPtePp0oERUNpnyvABX02TX3R32quNU+F7H7zXI89+2Tlk
 elTTP1qTqDyXKoWyY7nc7Tlf5EbPcUP/Uh9I63IGik9n/Fu75V5Xu9ZhifCQfsxozn5S
 HU3HtM/mECdoET8wsdbsInjH4EIHZQ6Jh4YKKFm0nxDWbGbTwruLMEthK60R16jbUjLq
 1jNg==
X-Gm-Message-State: AOJu0Yw54a1ScuxVMgwD5Q98SpCD56vjiPbWSBnv8Y+4N/430qFS+WKg
 zVaqiLqlXwK0dAhVEFQe7/sP3l5dtGwCwI0bprSvRQ==
X-Google-Smtp-Source: AGHT+IHhx67NgNcRKVy5uQ2xawPLZZVpAsYBdYA1e+I/TCp3KY2rP9pi3WOb3dOPcjVDkYDbTWGaRo3lQ4hed2aZFyw=
X-Received: by 2002:a17:906:710c:b0:9dd:7536:2b0 with SMTP id
 x12-20020a170906710c00b009dd753602b0mr4431873ejj.50.1699884052457; Mon, 13
 Nov 2023 06:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
 <20231106153631.GI496310@bill-the-cat>
 <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
 <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
In-Reply-To: <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 07:00:34 -0700
Message-ID: <CAPnjgZ1KFjELxT=7rUSSK8knAjZVeo0GYut2iJfohgWCEXVZpg@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Bin,

On Mon, 13 Nov 2023 at 06:01, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Mon, Nov 13, 2023 at 4:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Bin,
> >
> > On Mon, 6 Nov 2023 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> > > > + Tom,
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > >
> > > > > Hi Bin,
> > > > >
> > > > > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > > >
> > > > > > > This is needed to support Truetype fonts. In any case, the co=
mpiler
> > > > > > > expects SSE to be available in 64-bit mode. Enable it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  arch/x86/config.mk        |  1 -
> > > > > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > > > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > >
> > > > > > I didn't suggest we enable SSE for x86. This is the wrong appro=
ach.
> > > > > >
> > > > > > We should rewrite the Truetype support codes to avoid using flo=
at/double types.
> > > > > >
> > > > > > This way the Truetype codes can be used on any other architectu=
res
> > > > > > without the need for the compiler to emit explicit floating
> > > > > > instructions.
> > > > >
> > > > > I am not aware of any such library. At present, enabling truetype=
 on
> > > > > coreboot64 causes a hang.
> > > > >
> > > >
> > > > If that's the case, we will have to either:
> > > >
> > > > - Switch all U-Boot builds' to use software float (e.g. -msoft-floa=
t)
> > > > which unfortunately depends on the compiler runtime intrinsics.
> > > > - Introduce a Kconfig option for hard float enabling and let each
> > > > architecture to decide whether it implements it or not, and update
> > > > Truetype to depend on the hard float.
> > >
> > > We generally do -msoft-float already, so introducing that for x86, an=
d
> > > some Kconfig logic to ensure that no one else steps on this particula=
r
> > > bug sounds reasonable.
> >
> > Yes soft float seems to be not-much-used on x86. For 64-bit chips the
> > compiler seems to assume that hardfp is available.
>
> We have compiler flags to ensure the compiler does not generate SSE
> instructions. Yes, I know SSE is in almost every x86 processor we see
> nowadays.
>
> >
> > So perhaps the best thing is to introduce a HARDFP option to x86 only.
>
> This option should be global as some other arches also don't have
> hardware fp, like RISC-V whose fp extension is optional.

Here is the patch I have:

https://patchwork.ozlabs.org/project/uboot/patch/20231112200255.172351-5-sj=
g@chromium.org/

So perhaps move it to arch/Kconfig , rename it to HARDFP and update
the help to be more generic?

Regards,
Simon
