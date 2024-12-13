Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3E7E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 05:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06AE8020C;
	Fri, 13 Dec 2024 06:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nk4W1Vxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F58801BF; Fri, 13 Dec 2024 04:24:20 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055348018E
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a977d6cc7so154261266b.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 19:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734060257; x=1734665057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hdv7vnWmqvvZvVYpuG+pmBU9WD22H2EHs7e3V/YBLZg=;
 b=Nk4W1Vxfmrym9ynnfszQBb8fZ0Q/RtrtYYRBXLC4vymxHJzUrJDS2LU6qqbFZ9H+1m
 pDwDUYKqaLhgyVUc+R7oVra8HtZ8uEYV1OfUiNWV/co96UpPFoaAx6Cg4pxDPdp1fMtR
 n2UmjxdFtJm7vV1XLIFLzdwIfhERXxOAVYH+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734060257; x=1734665057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hdv7vnWmqvvZvVYpuG+pmBU9WD22H2EHs7e3V/YBLZg=;
 b=rDynNgwDsK3jYNPirVp71+oJ+8/N3HsMaSwGWaSqHd8YOQzt3bBWtFxK5zLOsZiRps
 5GcFrFqp2T32v/aokNpM2O/0QnT5ALbJc2t8ItGwgpi+iJb4rwYE9S+H6u1wtS+b5PrG
 ivkmcWkynB3+gQc3uu4tlYJvSMkf2PV3oJLRUpK/JeOJIl4EoJKKdoBDxPXKGYsJdMhz
 ljQ8Td9jGmfpwUffND0je5lH9FoaRiASkl5au7WQEokOxy0N56boDW7EGo60bLhmtsES
 JVm8Wsaf32bZalGN4JuEa9rXWqn+XxQfOKe4OariPxTLq/fp4qKe7GxybERxzhz1uFxX
 uhQw==
X-Gm-Message-State: AOJu0YxeZIplxt2Iy7nS6CSO6BA6UFocgUAoidDndI+J5FizO9NkkUFI
 qf1LLiuWTCrzVoMbEAcOpHUsZIY9swFcdgT41NtsvoLa1Fo9v9I/x7gW8H6UGATQSewgDvkrvmi
 Rm8YlpUaCwOCQg5Db0MfFpd0N/eivebuM0bed
X-Gm-Gg: ASbGnctHigXy+P48sDsw5GG0k3Z4BNHHjEpLLsXMlsiihPNoKpuUIp8kZ7FdRz7kPBL
 RktlWlks89TijEMNHGlvS+vMI7cp1bOfnTEmDFvo=
X-Google-Smtp-Source: AGHT+IH+czLzjPwVAfsurG05NPJ/RqBePfPtSeDXov2yh4LvR+yKWEEyosgxiCKUD9/8VfiF9Zw/GG3QjPau7sPp4/M=
X-Received: by 2002:a05:6402:5214:b0:5d0:ed92:cdf6 with SMTP id
 4fb4d7f45d1cf-5d63c3421f4mr1741062a12.19.1734060257463; Thu, 12 Dec 2024
 19:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20241207172412.1124558-1-sjg@chromium.org>
 <173405231528.1635625.10928592597091154587.b4-ty@konsulko.com>
 <20241213030940.GO1505244@bill-the-cat>
In-Reply-To: <20241213030940.GO1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 20:24:06 -0700
Message-ID: <CAFLszTj2av9Cj4x5k7wYcxEZXNQt6O=0_5oXUKMSw4RGbnDAfg@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] vbe: Series part E
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anand Moon <linux.amoon@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Devarsh Thakkar <devarsht@ti.com>, 
 Dragan Simic <dsimic@manjaro.org>, Gary Bisson <bisson.gary@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Nam Cao <namcao@linutronix.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 13 Dec 2024 06:46:56 +0100
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

On Thu, 12 Dec 2024 at 20:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 12, 2024 at 07:11:55PM -0600, Tom Rini wrote:
> > On Sat, 07 Dec 2024 10:23:53 -0700, Simon Glass wrote:
> >
> > > This includes various patches towards implementing the VBE abrec
> > > bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> > > fatures are available in VPL.
> > >
> > > Changes in v3:
> > > - Add new patch to avoid size growth in spl_mmc_find_device() debug
> > > - Use strlcpy() instead of strncpy()
> > > - Rebase to master
> > >
> > > [...]
> >
> > Applied to u-boot/next, thanks!
>
> And, ugh, I missed that CI was failing for real. This causes
> rcar3_salvator-x to fail to link due to size growth, so I'm reverting
> this for now, sorry. I thought the CI failure I saw was due to something
> else at the time.

Hmm, sorry about that...it passed CI when I sent it!

The growth is quite alarming and I am not sure how to make sense of
it. Here is the last patch:

21: hash: Plumb crc8 into the hash functions
   aarch64:  +   rcar3_salvator-x
   aarch64: (for 1/1 boards) all +2109.0 bss -48.0 data +56.0 rodata
+5.0 text +2096.0
            rcar3_salvator-x: all +2109 bss -48 data +56 rodata +5 text +2096
               u-boot: add: 1/0, grow: 1/0 bytes: 136/0 (136)
                 function                                   old     new   delta
                 crc8_wd_buf                                  -      80     +80
                 hash_algo                                  280     336     +56

So perhaps apply all but the final patch? Then I can sort out things from there.

Regards,
Simon
