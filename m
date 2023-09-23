Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2082CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E89586A38;
	Sat, 23 Sep 2023 20:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BpMDraIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6480B86ABC; Sat, 23 Sep 2023 20:42:45 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E7F8641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-503056c8195so6447563e87.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695494563; x=1696099363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5rb9Udyf3XbHZwCTN6RBhAumhbG52m7jFZVcwitPvrA=;
 b=BpMDraIM/3Gd8ANNIJEOygQuvpTFMIhgNovl8VadKjPDoZxRmS6BHTpCm40rXAI0XN
 g8hpbUiZQop4dSSUexP1RSLRk5qgw75DPFVsKGYa/eKjqf7V3daB2jH1J34KyfxEn9CC
 aAsmiUxWJeXLpknhnkSVgV7btQAylcNu9akQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695494563; x=1696099363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rb9Udyf3XbHZwCTN6RBhAumhbG52m7jFZVcwitPvrA=;
 b=ZyNDaGffC/xmjdtoecw1a8bmBC7xGeDZ+HhuBMfdXODT1M1myXqhTFGUlqfFexFrkL
 TrIazv1fHnZi4SDAHxffYXqVgy/xdfqliIb9mGmeQOGolV2x4ZTU065XUl8wXU5hBBOq
 uyoQiG0D/x1PGYabVAn7YOIA5wfHOVCyHaQ6/WZ/a992qQ63UUYAvkay6wwcOF7acauJ
 S3v9u/amWU4gYQdTO2yAZhoO4rb9jBDeZXtZ0SHqi2Y4lEncTJU1Hgbw7Cq9z64eqkZY
 FynTQ5rBq70CpncJ+JdnAM+qQXkM4Jta7Fr/PJf7/cuKFg83gNB4sB/O0kiMDvJvnk7j
 /+rg==
X-Gm-Message-State: AOJu0Yw1CXH7xx+9NNrpiU/9KsTsA/9r9Yr5k2gwXVj8V6tv+M1C73l7
 C5soNZ4MffJ5D83+hCH2mvkI/CSj7fDO/Ja+7pLEWg==
X-Google-Smtp-Source: AGHT+IFvCJQdItKNYranRv6zGxM3lyTtSDW8Sh22CZsoigR7Iy9gGgbHOcxD7hwCD15qkxOG81xjjj3CqnmUvRUzP/Y=
X-Received: by 2002:a05:6512:3ca2:b0:503:1c07:f7f9 with SMTP id
 h34-20020a0565123ca200b005031c07f7f9mr2908181lfv.29.1695494562485; Sat, 23
 Sep 2023 11:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
 <e43c5b16-e626-4c7a-9bef-44f192d2a703@gmx.de>
 <CAPnjgZ1CEBbeQzKNJBYtQx=rVZayJyZVwo1CPW-ZgFiKNbT6hQ@mail.gmail.com>
 <D5CA48E9-78C1-4E92-979A-E9C346A42AAE@gmx.de>
In-Reply-To: <D5CA48E9-78C1-4E92-979A-E9C346A42AAE@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:42:31 -0600
Message-ID: <CAPnjgZ3bn8j=EJxHKUJ+_jzMbwWE=_1wa8b-stX4z8HKRhG1=A@mail.gmail.com>
Subject: Re: Reading from ISO9660 in U-Boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Heinrich,

On Sat, 23 Sept 2023 at 12:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 23. September 2023 16:36:32 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Heinrich,
> >
> >On Fri, 22 Sept 2023 at 19:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 9/23/23 00:13, Simon Glass wrote:
> >> > Hi Heinrich & Bin,
> >> >
> >> > I'd like to be able to figure out in U-Boot what OS is on a USB stick.
> >> > For example, with the Ubuntu installer, I can boot it (through grub),
> >> > but I cannot see how to read anything useful from the USB stick that
> >> > would indicate that it is Ubuntu, what version it is, etc.
> >> >
> >> > Does U-Boot need an ISO9660-filesystem driver for that? Is there any other way?
> >> >
> >> > With Debian I can see the actual files (linux and initrd) , so it is a
> >> > bit easier.
> >> >
> >> > Regards,
> >> > SImon
> >>
> >> U-Boot only needs to support reading the ESP to boot. GRUB comes with a
> >> 9660 driver.
> >
> >Yes, but this is not about booting, it is about visibility into what
> >is being booted. Perhaps Ubuntu could put some information in
> >partition 2?
> >
> >>
> >> On Ubuntu server installer images linux and initrd are in directory
> >> casper/ in the ISO9660 file-system.
> >>
> >> There is also a file dists/mantic/Release
> >>
> >> $ cat dists/mantic/Release
> >> Origin: Ubuntu
> >> Label: Ubuntu
> >> Suite: mantic
> >> Version: 23.10
> >> Codename: mantic
> >> Date: Tue, 19 Sep 2023 23:07:01 UTC
> >> Architectures: amd64 i386
> >> Components: main restricted
> >> Description: Ubuntu Mantic 23.10
> >> Acquire-By-Hash: yes
> >>
> >
> >That would be useful info. Ideally we would have a standard format for
> >this file across all distros, perhaps something that VBE can help
> >with.
>
> What problem do you want to solve? During installation you should know what you have downloaded.
>
> Afterwards UEFI boot options should receive reasonable labels.

I want to show it in the U-Boot boot menu.

Regards,
Simon

>
> Best regards
>
> Heinrich
>
>
> >
> >Regards,
> >Simon
