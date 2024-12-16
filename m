Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E8E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 15:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD468021D;
	Mon, 16 Dec 2024 16:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f4mefFNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C738D80269; Mon, 16 Dec 2024 16:17:19 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844008003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 16:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa662795ca3so1015485066b.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734362237; x=1734967037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbWWb6VMwo1idTE97kuG8vsdjCpQHTo4Z0235Nnb8uU=;
 b=f4mefFNWDoz04L3G/QdbGr75W9mQ1iJbjH1Y3jKjAZQ4M5Ol4TyShkHsjJe1IYyL2j
 g+3QheW9JjDOkd7UIrzuZIzfpPwAVg2dHGYaQKnjYbxpjSkxh+cvIxDHcGLKehA4iQ8U
 Xtc3Akh+DnHe0/JrNUcCVGSCrN7iqkPPn5/kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734362237; x=1734967037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IbWWb6VMwo1idTE97kuG8vsdjCpQHTo4Z0235Nnb8uU=;
 b=QTSh7TIp/XTF0O9R+4GI6pEFho1QmIWyTBuILyWe0CvVPIhIVaz9zpko4oo68EMooh
 TacfiF33+y+JuS+9eovPCkQC7gJunpxnTLq1E1By2vArlAQ5kYyqnME54p2XbSDy6W9r
 YlL3uCYCCz1VPflrW0EqCHxRjUBUQJp6j0x5L+ztVwBBGdULf0q71ZGN9+twqBnPUJIg
 DtpSOTvgZFseB2Px4kvkkqj8Y+MDYeXEsDLWquwYPUAW0LbNNWyxEfdDUNOXNR7MVRv8
 oCkM6i9j3W3J4E8GRztS+gzKSm84NpdtAZ5rPGIPQszMqPQMf4IMuJTagEe8JLfnPA8O
 40xg==
X-Gm-Message-State: AOJu0YxDlyo8hsAcgroyxJyv95zxZ7H/t0+R9Ltjp5CsTeQ4XsNCxikF
 ks8gz+XFKzGga9H29QC0NX17LTGC2wYr2oVD29TY9uQxBmytTk6vRBRBSV/EHYVF5/qSgSIxay7
 zwH9pkUt1iht29tzCT/AIyieGXKwy3qTB01eVn9/cDGHMQEc=
X-Gm-Gg: ASbGnctBCn9jhKBP6yRn5fRbWBmC+SmIqe/eDZoxMaWhulCxf+e2A5nTg1iVTaBRuSS
 z+WBm8ydI146C0Q1YoECve5webEhgVrTotwRLlE4=
X-Google-Smtp-Source: AGHT+IEcCjZ+wOHMidOxmsPl/Xka/t+tO/Hv1nwX7cazNRnFkDKGudSM+NI07BYisHiZCG4TkoFBzFicQ9RBL3BmlN0=
X-Received: by 2002:a17:906:ca92:b0:aab:9258:488 with SMTP id
 a640c23a62f3a-aab925804f4mr866664766b.10.1734362236929; Mon, 16 Dec 2024
 07:17:16 -0800 (PST)
MIME-Version: 1.0
References: <CAJvHTNwvmDH8L3x8ujcbJLR4=dXsGb97VmZ37Jm2ZMWLaC67rw@mail.gmail.com>
In-Reply-To: <CAJvHTNwvmDH8L3x8ujcbJLR4=dXsGb97VmZ37Jm2ZMWLaC67rw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Dec 2024 08:17:05 -0700
Message-ID: <CAFLszTjDXUJ6V17v6QwnjmG0DjgnBL=BTdx_5EVEt3hT2r5RUA@mail.gmail.com>
Subject: Re: running u-boot in qemu-system-arm64
To: Jack Andrews <effbiae@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

+Peter Robinson
+Matthias Brugger

Hi Jack,

On Sun, 15 Dec 2024 at 21:36, Jack Andrews <effbiae@gmail.com> wrote:
>
> thanks for u-boot.
>
> does u-boot run in qemu when emulating a raspberry pi 3 (or 4)?
>
> i'm running
>  $ qemu-system-arm64 -M raspi3b -kernel u-boot
>
> and i just get a blank screen
>
> i built u-boot with
> export ARCH=arm64
> export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
> export CC=gcc
> make rpi_3_defconfig
> make
>
> i also tried variations on qemu like:
>  $ qemu-system-arm64 -smp 4,cores=1 -serial null -serial stdio -M raspi3b
> -kernel u-boot
>  $ qemu-system-arm64 -smp 4,cores=1 -serial null -serial stdio -M raspi3ap
> -kernel u-boot

Here you are telling QEMU that the kernel is U-Boot, but U-Boot is
firmware, not LInux. Also, 'u-boot' is an ELF file. At least in the
instructions today[2] we use the flat binary produced from that ELF:

qemu-system-arm64 -M raspi3b -kernel u-boot.bin

But that doesn't work either. So I'm not sure how to make it work. If
you do figure it out, a documentation patch for U-Boot

Regards,
Simon

>
> best,
> jack

[1] https://www.qemu.org/docs/master/system/arm/raspi.html
[2] https://docs.u-boot.org/en/latest/board/emulation/qemu-arm.html#running-u-boot
