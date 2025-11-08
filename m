Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561D1CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 20:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEB283E8A;
	Sat,  8 Nov 2025 21:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R09l+J7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D4A83E8E; Sat,  8 Nov 2025 21:55:15 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940DA83E7F
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 21:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656cd6c1c5eso794737eaf.0
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762635311; x=1763240111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTW6SyY05JSaPiamqc8fA5dE2dfmd1gMFUMaAf3ki2c=;
 b=R09l+J7SQD0WAIfOyGWnpnwHuN+xg1+PAiPPGfC8Jtio9dia6g0hiinES8Ig7+UwsC
 rpj3XY7/v/eeG/ZMHCMKlGmnbZTxMlXncFfhlvHZgqxhmyf5HvB8BwB9B4WgyBBMCTvN
 3gU8zhG6S1B+wIlmDEwmnAKFO7cnRYmjiSlfdyP1eLKZjf/MtGsSlv3lxekEkRFz647b
 radtlZhlUYV17I/bRM8xgxwVy7tY8Jhrx+9hB/ufSF/yKwVThX86M6D+DPYxc6tc5cdi
 Ots9xgfRs+ev+RW28mXNmSjA15XhjoCXkmKBCmFpDDDHPVxDH7uibkcSwah7byQUDrF2
 36Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762635311; x=1763240111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WTW6SyY05JSaPiamqc8fA5dE2dfmd1gMFUMaAf3ki2c=;
 b=fukjYRF1ASQV0Xn2T9QBUcTVbdMXJzcMsSvuoFW0q/VsQTfiBD4W49dWNLP/OCWhI2
 g6JfI2HZB6L/WlwfP4XNZME2JH1JHijgCR+SExPrdI2jrLLNThQT6U1noLKzPCtllZa3
 3DbgxQlVFCERks46FJwU1JetVa9uVQ8Ln61JiFJDLBDls2Yevz7XbJaRoQT9Kaa73DsJ
 CmA5XDspGUxs44xGfWAs97BoWNuXFHZQx2oI/BrKQTb0eP0Paivr2QicBkNtJ4UfAU0H
 TNPycHXIRe+A/jXtXxsWfTKo8f14ydMXtfWDBvdqFa62DWKGgnOjrThSgUj9eecig/bg
 efJA==
X-Gm-Message-State: AOJu0Yxry0HmE95YRGrDq+IG1aCIp4dNeJNubE2NhDTp5H5wLbQXa7jK
 8Citeh1zez7Q+R07qLZPH0Unx8pVge124EsjX07+EZA8RMBEcaw4MSkyq6UKlaxP1knvrFlgdLG
 DRp068LxBhsRS5J3w21bk+azVOhdiJ0I=
X-Gm-Gg: ASbGncv8DRXQXdGG3eWbZutMhLkUp9YqjzntZDJBZ9qZ7EOwUaaQZ4AHUQd1+yBmoEq
 OEHP3vzsc8RKWwJETDz4KWY0jsbA8j+mZzkRlMUd6S3s0WIl/aThkF3BfC3XFdwr4DG4TtbW2TE
 Zz1qzYrahx7ksCdJJPauWW3uQjaSjp3VM9yPERAt8khb/p+N5jU50+1ZrF0aDz/GdliUzrkWkeS
 ey3An9oETNV5OVcAL1SRaxP5zvxtIKFM+EzSoBPOmV41DuFStbswdFecxeujA==
X-Google-Smtp-Source: AGHT+IEyKIiPb9oZ6k4N7mz4Z4/HyRWAQYU9BYlmLCF/yHYq0BWpfmD5oWUW2gVJpCTqM84gB4TmRuiaomk3j6dpxHU=
X-Received: by 2002:a05:6808:2f08:b0:450:3c7b:e7d0 with SMTP id
 5614622812f47-4503c7bfa17mr543337b6e.48.1762635311197; Sat, 08 Nov 2025
 12:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20251101-clang-fixes-v1-0-a8398475226e@gmail.com>
 <176246626861.3129497.14948596131312532180.b4-ty@konsulko.com>
 <20251106221355.GZ6688@bill-the-cat>
In-Reply-To: <20251106221355.GZ6688@bill-the-cat>
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Sat, 8 Nov 2025 21:55:00 +0100
X-Gm-Features: AWmQ_blqJS5vS134xUnVYeSvTQneDHDatyWsoI9jZU3diDXI1zV24UF-tBnOPSc
Message-ID: <CAChbrCYcFua=B9ZaS8_tbzugUh6MyLMJo3T9tEDZhA-Y6zdsOA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix AArch32 compilation with Clang
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Samuel Holland <samuel@sholland.org>
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

Thank you for your reply.

Please review a fix for the aforementioned issue[1] and let me know
whether this enables your
local and CI builds with Clang!

Thank you!

Best regards,
Dmitrii

[1] https://lore.kernel.org/u-boot/20251108-clang-cross-fixes-v1-1-ea6c4282=
844a@gmail.com/


On Thu, Nov 6, 2025 at 11:13=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Nov 06, 2025 at 03:57:48PM -0600, Tom Rini wrote:
>
> > On Sat, 01 Nov 2025 10:39:57 +0100, Dmitrii Sharshakov wrote:
> >
> > > I faced some minor compatibility issues when choosing Clang as the cr=
oss-compiler for my target.
> > >
> > > Please review these two fixes, aiming at enabling Clang-based builds =
(still using GNU binutils)
> > > for 32-bit ARM targets.
> > >
> > > Tested to fix build with (also run-tested on qemu arm and arm64 with =
clang):
> > >
> > > [...]
> >
> > Applied to u-boot/master, thanks!
> >
> > [1/2] arch: arm: build: only set -mgeneral-regs-only for AArch64
> >       commit: e8e3b38def93b5e5d53569961237ce215454e141
> > [2/2] build: fix building u-boot.lds with Clang as a cross-compiler
> >       commit: f7d177395d73f7747373dfd0ef7329834788106e
>
> So, I can replicate your success if I do:
> $ export PATH=3D${PATH}:/opt/gcc-14.2.0-nolibc/aarch64-linux/bin
> $ make O=3D/tmp/rpi4 CROSS_COMPILE=3Daarch64-linux- CC=3Dclang-18 HOSTCC=
=3Dclang-18 rpi_4_config all
>
> But if I instead use CROSS_COMPILE=3D/opt/gcc-.../bin/aarch64-linux-
> instead we get /usr/bin/as being used and fail. Any ideas where perhaps
> CROSS_COMPILE isn't being trimmed correctly and passed to clang maybe?
> Thanks!
>
> --
> Tom
