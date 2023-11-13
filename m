Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C87AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F773870E6;
	Mon, 13 Nov 2023 15:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izcI5vMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD1686BA4; Mon, 13 Nov 2023 15:11:43 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E95486B1D
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5afbdbf3a19so51300727b3.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699884700; x=1700489500; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+/aeu4cK92Vv3WaKG2PWLKS8kntdQtsaZBah59XUTw=;
 b=izcI5vMaxmKpMebmEmauv/YwnhgA4uKdkEIhbCUEMVJlOVDn6wqUwECLivTl7fNFeM
 l6ZCf7d2tsQgkpiGikLIiWhGZ/+RM72myqLYem57wdoi++6//G4HLHZNwnDDmJzfnUTJ
 heaIgUOW+0BzdcvKZ2Dx0dgS/S3uTiLwYLOxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699884700; x=1700489500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+/aeu4cK92Vv3WaKG2PWLKS8kntdQtsaZBah59XUTw=;
 b=wZV0Xpmu+xswtpxRBmEsCTtgAxh9S+h6GdANcULiqNKnpwX3xs4XPbIMfOYmmGseMx
 C6Wk/1KckRG2z52XI4MUanbX8iqK3cw/ExkkZjvE8IDYA+MRgp1ioKJ3SzkzPHHwhnq9
 erax6pLGqOmIf+l9Hf6b/UKYLXGigwlkUkOZiAs1PIazTkdzhw/GyuUo8xyOswS9FASs
 jgrnH0p/YIGB4YztJszaibVV3DVKm//SzkMecha7GuYQYwKvZOBN1dfbZZdNBwDRxE6N
 VLLLMfKweHUQXmKS0QPSCnxwk0uRq5YW1U1L0IY3k747gXjupwjq19nuTtiZLO92EeZw
 Sx9A==
X-Gm-Message-State: AOJu0YzVYMPSlnokKdsQFf/+hUnVjhD4s9e5z4ZJDBetiB5De4zAwNgq
 18u+l/s542xVKSmVyzYd/eXTA5cAm3dW5H0psph2aA==
X-Google-Smtp-Source: AGHT+IFn3SwZHQ3E4TA58WqhPpGaFEI0e6KoYxVc7l2usQrG5yFJMvCysf6mPgxtsPv6PUqEIBcizH5JY+lxvflSG6w=
X-Received: by 2002:a25:2d1e:0:b0:d9a:4a5f:415d with SMTP id
 t30-20020a252d1e000000b00d9a4a5f415dmr6371600ybt.0.1699884698380; Mon, 13 Nov
 2023 06:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
 <20231106153631.GI496310@bill-the-cat>
 <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
 <CAEUhbmUvfD5AOouDXivzrzMQFgirgicsJwBJKW_zMOPL+k7PMw@mail.gmail.com>
 <20231113140647.GI6601@bill-the-cat>
In-Reply-To: <20231113140647.GI6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 07:11:22 -0700
Message-ID: <CAPnjgZ3D0wUXU2_5bN9LbUQeLQ8O=HuZrtrORa7UrfwACt_NPA@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Mon, 13 Nov 2023 at 07:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 13, 2023 at 09:01:02PM +0800, Bin Meng wrote:
> > Hi Simon,
> >
> > On Mon, Nov 13, 2023 at 4:02=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Bin,
> > >
> > > On Mon, 6 Nov 2023 at 08:36, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> > > > > + Tom,
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi Bin,
> > > > > >
> > > > > > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrot=
e:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > > >
> > > > > > > > This is needed to support Truetype fonts. In any case, the =
compiler
> > > > > > > > expects SSE to be available in 64-bit mode. Enable it.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > (no changes since v1)
> > > > > > > >
> > > > > > > >  arch/x86/config.mk        |  1 -
> > > > > > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > > > > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > >
> > > > > > > I didn't suggest we enable SSE for x86. This is the wrong app=
roach.
> > > > > > >
> > > > > > > We should rewrite the Truetype support codes to avoid using f=
loat/double types.
> > > > > > >
> > > > > > > This way the Truetype codes can be used on any other architec=
tures
> > > > > > > without the need for the compiler to emit explicit floating
> > > > > > > instructions.
> > > > > >
> > > > > > I am not aware of any such library. At present, enabling truety=
pe on
> > > > > > coreboot64 causes a hang.
> > > > > >
> > > > >
> > > > > If that's the case, we will have to either:
> > > > >
> > > > > - Switch all U-Boot builds' to use software float (e.g. -msoft-fl=
oat)
> > > > > which unfortunately depends on the compiler runtime intrinsics.
> > > > > - Introduce a Kconfig option for hard float enabling and let each
> > > > > architecture to decide whether it implements it or not, and updat=
e
> > > > > Truetype to depend on the hard float.
> > > >
> > > > We generally do -msoft-float already, so introducing that for x86, =
and
> > > > some Kconfig logic to ensure that no one else steps on this particu=
lar
> > > > bug sounds reasonable.
> > >
> > > Yes soft float seems to be not-much-used on x86. For 64-bit chips the
> > > compiler seems to assume that hardfp is available.
> >
> > We have compiler flags to ensure the compiler does not generate SSE
> > instructions. Yes, I know SSE is in almost every x86 processor we see
> > nowadays.
> >
> > >
> > > So perhaps the best thing is to introduce a HARDFP option to x86 only=
.
> >
> > This option should be global as some other arches also don't have
> > hardware fp, like RISC-V whose fp extension is optional.
>
> RISC-V should take the ARM approach (and what I was suggesting for x86)
> and enforce soft-float for everyone.

But see my comment above...I'm just not sure softfp is widely used on
x86. It also is a bit silly, since 64-bit CPUs have hardfp and it is
trivial to enable (in fact we have to disable it if we don;t want it).

Bin, please let me know what you think.

Regards,
Simon
