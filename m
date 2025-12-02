Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751A8D116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 07:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3CD83E16;
	Tue,  2 Dec 2025 08:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y6VO09aQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E37383E1B; Tue,  2 Dec 2025 08:56:21 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB2183DE0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 08:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-787df0d729dso49734257b3.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 23:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764662178; x=1765266978; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqxFBM+Tb59btEeoe01LhwZANMNtbPaqqPtZx+DLyjE=;
 b=y6VO09aQxqRICPjIha7X+fhrKehPdL8GWnVEyBYFI0l8uaf4Zpx0LNaMRi+3htGgTI
 J0j21KGLDwmSrNyxhDRmBCK7h1t63fIVRMvCKHnpuiBOmsEkoeitKEXhesOk2Jym6NwJ
 1vt2u/4GSUCK+n23rwzltksrI4WVRaHH2riKhCFOsbODpV/tbmGpbFh9tGAbssQf8sa6
 FDIX8nq5iywgdL4jZGPSimQdEoJ1VvugwrNEYgOSe4fYtiZzYbk0bfK5YtrO8BWScwzI
 M24dqsq7msh1U6vpKOUvryTRtezbtW6dShHW50M5mKHWBsDff0IMA5mQ1D6NUFnF1ftn
 qtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764662178; x=1765266978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KqxFBM+Tb59btEeoe01LhwZANMNtbPaqqPtZx+DLyjE=;
 b=S0kx8nuBlE7pSiHfvKJx0iTXiSD+SShsxwNJAQnWuw0+uMkg5gCQ40CGaPcJLtcram
 o5Jb1BZ0HWkz5Km2idNZJmvb8SwiAtiEvnpLG9PaXdeawKgltlNcQo1ERWQQUXpBe71S
 9js8C6zX1jGU5crRTDZdXQ/zH4zKzNLdMHYN3u/JAsfJ/tBh4SOMeMt66Q+lgpZtaWk1
 DKnWgYKFtL2vVmePuk/hAwC8Zk2MEdggdbRf9I2pc6RvnFcPgceeSf+J3OOaLgNlwokG
 SwHHQ/IrDitZwgIRCvUcV+Q+qLfq5wQiaMlAQX75soKzkzrlSNH3DNJ8X2JWhkxC8LOK
 hOcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOB1tFjdBcNiRdl5JyqlrsEz0xuBcze+FsDFhXKjCDwOnk4Ml9eBBCfz/cti+EIzGwRKsWzbs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3Pm+POgaz2E+IxWlAS+gWEiXP9/5KNssoqg0mOeht+0oF2vkt
 96/IUZtQwC5J3AEmlhP3FJv7/op9WIonTgPjuaqsKgxLAJSYolNM7HgAuSKqQybjjpw7aXB+Ey3
 DUK3R6O6UzQsx7QozO6EURA5TRcp0DNP6TNK/h/tAKXTi2QX/0RDK1Yo=
X-Gm-Gg: ASbGncvRTqrcfHE+Ozh2YppfS2bDWtBm+YLaHQ9HSza5mhlyOoEe1/z7/xYeKV+kWo6
 E59JaSq4f1EayQdjOpaBxsKC7Fk4aMmiD78UbHYf6xrNh9cfgLhjrmPSsWmissB3sba3/EYxO8S
 61OEBKaXb4PHZE+Hj6uIYifIzib3JPFYkoli6c5VgmcE3fsTAb7CN0pprOVuG1k/cyKp8/xcnH6
 kCOLEKRl9jFybVegu4PAobK/w1UdoP2wpo/07yx7kNo/I5NPIhwP6+5AtOeOyqNnKC4vrC3zECd
 iCaah68glT7vgViAewpt0ZYHcrOmvq/OE3PWQeBawlSTcQSOMu3kEx8dz/8F9JUJoYM1g57cDYt
 nWimkQ2ansEpHQ+egag==
X-Google-Smtp-Source: AGHT+IH8ByvZZ6b1+2QtqYPtA2L8M0RR1QoKpDgyeLrhSE1z7ZNL/aXEddodPnU13UEDmC5bwyaj3eQZt2sp8JbU/rU=
X-Received: by 2002:a05:690c:6892:b0:788:14a2:8bda with SMTP id
 00721157ae682-78a8b527aedmr380758527b3.38.1764662177787; Mon, 01 Dec 2025
 23:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
 <20251128153130.GC2125796@bill-the-cat>
 <CAC_iWjKp1ztEW23e7rujk-oFuYS_qfMi+CF+VEdwcCHmXrtgkg@mail.gmail.com>
 <20251128164957.GD2125796@bill-the-cat>
In-Reply-To: <20251128164957.GD2125796@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 09:55:41 +0200
X-Gm-Features: AWmQ_bn6-UcnYwjeCG9r5tHLmJuzLaYM96fCxjIVwn2UvGI4xFGHXd00irpeDQg
Message-ID: <CAC_iWjLYvzHHJ+KYj68KWa=E+V3wc360HRf_dWCh7ny5bdEU9A@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: Tom Rini <trini@konsulko.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 u-boot@lists.denx.de, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
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

On Fri, 28 Nov 2025 at 18:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 28, 2025 at 06:44:12PM +0200, Ilias Apalodimas wrote:
> > On Fri, 28 Nov 2025 at 17:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote=
:
> > > >
> > > >
> > > > On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > > > > [CAUTION: This email is from outside your organization. Unless yo=
u trust
> > > > > the sender, do not click on links or open attachments as it may b=
e a
> > > > > fraudulent email attempting to steal your information and/or comp=
romise
> > > > > your computer.]
> > > > >
> > > > > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > > I already have the referenced commit in my test branch, and I c=
an
> > > > > > confirm that the same compilation error still appears on Cyclon=
eV when
> > > > > > certain directories produce no SPL objects.
> > > > > >
> > > > > > The existing fix ensures that built-in.o is always present, but=
 it does
> > > > > > not prevent ar from generating empty built-in.a archives, which=
 older
> > > > > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=
=80=9Cfile
> > > > > > truncated=E2=80=9D.
> > > > >
> > > > > Which toolchain is this ?
> > > > >
> > > >
> > > > I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC3=
2 devices
> > > > - CycloneV and Arria10
> > >
> > > Ilias, do you recall the solution to this problem from when it came u=
p
> > > on IRC a few weeks ago?
> >
> > Nop unfortunately not.
> > Was this caused by the Kbuild bump? I remember the logic around
> > builtin changing significantly.
>
> Yes, and I kinda thought we narrowed it down to something being missing
> from the update, since the kernel does support this old of a toolchain
> (or at least the 10.x? someone else this on).

Ok, let me go through my irc logs in case I find it.
Reading the email thread we should compile with anything > 8.1 right?

Cheers
/Ilias
>
> --
> Tom
