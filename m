Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C431C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC6F586E40;
	Sun, 12 Nov 2023 21:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gDgSKtmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D85786BF7; Sun, 12 Nov 2023 21:02:32 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB45B86BF7
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dae7cc31151so3661645276.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819348; x=1700424148; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNTTUcY7Q+6ebMHRtG4IjxEfB4FdOYfAPwej6e6AOG0=;
 b=gDgSKtmEjQpUwR3xw4AHkTvqvkPFdzGKngTOJ9Bo40diHz7paK2MId2f7LiUgimrK2
 Zkvfocz5jZyfssVpSdDJ0n8FZp5tcs3BTmeX8wSwqn6SPGGZUYCoXnjN9Wlv1V5Nf89H
 tGcINq+s9FscpCeY4ki0iGheiJkId6unbTpoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819348; x=1700424148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNTTUcY7Q+6ebMHRtG4IjxEfB4FdOYfAPwej6e6AOG0=;
 b=vbtWQTwVtaA/M4zhzjSnKS+kywYGYQZ2krMLJTRCbeqJfuvhytIYopEHOcWKURz9xr
 O32NzrOj4a4SQmlAyLCajuGitRbdqbgUjjrqNkvt0K2ouoO/8EDIXJmB04/fGSD0VxrS
 g8vC2iyrjGoIh5bqXM2W+RmbWZNp/IIoKIaYuim0APSokc9xaAbc/wdysqEsfttziDsq
 VVD787s12U8vKxRwIJyX0Recs1Ujs1OXRk8ouAp3gojprkIi3L/JMxuPhsTyWkrpV2Qx
 mYcA6UhwClPTGTZu4tSZJ9+it2s3lB5agDUBx1XgZL0ujYOoC/4A9cxrJMlcTY6KcTLo
 jZYg==
X-Gm-Message-State: AOJu0Yy4AJf0+G+yzuF/tkJSihpi+9646L+C5mC9GCrgTw0VyBumcZOv
 oiVQGP62PNeVXvEt3owbBXRiDYND+Is05m8UMeD3GQ==
X-Google-Smtp-Source: AGHT+IHu4OBZITP2fR0gSdJdemlIxfB+CLLSZLJoE6YoU+rD+JzjM8lEKAG7UWTNvz2wjOM9pA7K+vAMA0qPYNRhZ9g=
X-Received: by 2002:a25:728b:0:b0:da0:cbff:4e20 with SMTP id
 n133-20020a25728b000000b00da0cbff4e20mr3986075ybc.56.1699819348383; Sun, 12
 Nov 2023 12:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
 <20231106153631.GI496310@bill-the-cat>
In-Reply-To: <20231106153631.GI496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:10 -0700
Message-ID: <CAPnjgZ1Zp0kjW4zUunopGrUEhbWAtkZ3xwuHYxgo50K9GdFtSA@mail.gmail.com>
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

Hi Bin,

On Mon, 6 Nov 2023 at 08:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> > + Tom,
> >
> > Hi Simon,
> >
> > On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Bin,
> > >
> > > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > >
> > > > > This is needed to support Truetype fonts. In any case, the compil=
er
> > > > > expects SSE to be available in 64-bit mode. Enable it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  arch/x86/config.mk        |  1 -
> > > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > > >
> > > >
> > > > I didn't suggest we enable SSE for x86. This is the wrong approach.
> > > >
> > > > We should rewrite the Truetype support codes to avoid using float/d=
ouble types.
> > > >
> > > > This way the Truetype codes can be used on any other architectures
> > > > without the need for the compiler to emit explicit floating
> > > > instructions.
> > >
> > > I am not aware of any such library. At present, enabling truetype on
> > > coreboot64 causes a hang.
> > >
> >
> > If that's the case, we will have to either:
> >
> > - Switch all U-Boot builds' to use software float (e.g. -msoft-float)
> > which unfortunately depends on the compiler runtime intrinsics.
> > - Introduce a Kconfig option for hard float enabling and let each
> > architecture to decide whether it implements it or not, and update
> > Truetype to depend on the hard float.
>
> We generally do -msoft-float already, so introducing that for x86, and
> some Kconfig logic to ensure that no one else steps on this particular
> bug sounds reasonable.

Yes soft float seems to be not-much-used on x86. For 64-bit chips the
compiler seems to assume that hardfp is available.

So perhaps the best thing is to introduce a HARDFP option to x86 only.

Regards,
Simon
