Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4705C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 11:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1323286E5E;
	Wed,  6 Dec 2023 12:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wAAAWLeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32F1A86D10; Wed,  6 Dec 2023 12:39:37 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288B0876EA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 12:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c9f62fca3bso52938921fa.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 03:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862772; x=1702467572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rg0I037jDnHcGDGEIzGi3Mm4VwyIok5KhMoxFxDAr/0=;
 b=wAAAWLeAnTpcSmywQQ2mCpgBdDdiMED/og+szPziFg1xrPsYMGIzfo4Dzw5dG2MKf5
 kUzxSHWwBt6gXfyveLUROx7fbfFqoZbi6LQsmbn/jXUEI9IJEBnW8cszpmCRzophgDgF
 oQPZ+eytn73+dLO06PIjoL6SE97TwRkHSP1N6GT38cXpFpBL05I5uN/qBYXpAniSpVLI
 2SkOZYsuZqqRiJYcHQz+E62TO0XHw/QFCW7IeWMBSH7sTcj+HT48astJJkc7/W9rzXXp
 pZXMgwxpXouV/vlOG8efxK53rN9tZfbG2fTMbyAoIEPFJOetIGD+ImdavV/SG9X+QfVt
 1E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862772; x=1702467572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rg0I037jDnHcGDGEIzGi3Mm4VwyIok5KhMoxFxDAr/0=;
 b=m8gHA8Nt9YEEjndDrybiRN9SnwRETF8htgcLeJPXkFDVailJ2QW/E0ManmchuO7gl6
 9F2jQlpJqwJtK035WW86tFIuTtNhnolThWQzh38fCsMZY8+zVHfDXT90Rw1zCXLv5dQC
 6vggv9HKaGFqMebIlclxDqJrL22GMVydAVP5IHV13cjdY48lqqbiejPecqFA3SMQ16R2
 agCzTzgwIOf+wUXoAE7qQ4K546kFqWgV2VGpKvMwJVphfeQ+NJ/kE7i+UarzBV8OPKOB
 oR8+X28ZqgoNHgIL99h3M7nWWC/fBF7M3P3mKZtOEjUkFzjkbbB4hwEB8qubxZ01PnrV
 TMtQ==
X-Gm-Message-State: AOJu0YzO8kSvhaXHimjTEuT+NZP/M+9Sbt9AlN2vRyos5oFOwCinyFkV
 1w1SPpsmNmVP4zBrc0RedIZKrnUpEX7337FJG55cPQ==
X-Google-Smtp-Source: AGHT+IHm6AlFbpZg5sBxf6RHQ0UzD2Tu6orAs5/pbRzK0F6LMW9tAvMOL8So9aqnhm6xbNnmHhtkFY/XuUdgZSieR6Q=
X-Received: by 2002:a2e:8091:0:b0:2c9:f622:68e8 with SMTP id
 i17-20020a2e8091000000b002c9f62268e8mr516712ljg.89.1701862772408; Wed, 06 Dec
 2023 03:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAC_iWjKKjVQrt==U-CesqFq+xOCe736-kczaiA_cD-z=BEN+Sw@mail.gmail.com>
 <87a5qn8uju.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87a5qn8uju.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 13:38:56 +0200
Message-ID: <CAC_iWjKKwjpD1VAbXJaB=UDQPWMS+k65tv-qL=JnewzSEhGEow@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@linaro.org, rfried.dev@gmail.com, dsankouski@gmail.com, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rayagonda.kokatanur@broadcom.com, 
 lukma@denx.de, seanga2@gmail.com, jorge.ramirez.ortiz@gmail.com, 
 stephan@gerhold.net, marex@denx.de, u-boot@lists.denx.de, sjg@chromium.org
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

Hi Mark,

On Wed, 6 Dec 2023 at 13:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Date: Wed, 6 Dec 2023 12:31:15 +0200
> >
> > Hi Caleb,
> >
> > Late to the party, but I'll respond to as much as I can
> >
> > On Tue, 21 Nov 2023 at 19:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > >
> > > Historically, Qualcomm boards in U-Boot have all had their own
> > > board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> > > own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> > > devicetree with little/no compatibility with upstream DT.
> > >
> > > This series makes a few final prepatory changes, and then replaces
> > > almost all of the board specific code with generic alternatives. The end
> > > result is that all Qualcomm boards both current and future (with the
> > > exception of the db410c and db820c) can be supported by a single U-Boot
> > > binary by just providing the correct DT. New boards can be added without
> > > introducing any addition mach/ or board/ code or config options.
> > >
> > > Due to the nature of this change, the patch ("mach-snapdragon:
> > > generalise board support") has become pretty big, I tried a few
> > > different ways to represent this in git history, but the other methods
> > > (e.g. adding a stub "generic" target and removing it again) were more
> > > confusing and made for much messier git history. The current patch is
> > > mostly atomic, but requires regenerating the config.
> > >
> > > The QCS404 EVB board had some code to enable the USB VBUS regulator,
> > > this is dropped in favour of a adding a new vbus-supply property to the
> > > dwc3-generic driver. This will also be used by the dragonboard845c in a
> > > future patch. This handles the common case of a board requiring some
> > > regulator be enabled for USB host mode.
> > >
> > > A more detailed description of the changes is below.
> > >
> > > == Memory map ==
> > >
> > > The memory map was historically hardcoded into U-Boot, this meant that
> > > U-Boot had to be built for a specific variant of a device. This is
> > > changed to instead read the memory map from the DT /memory node.
> > >
> > > Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> > > null pointer access happens then it will cause a bus stall (and board
> > > hang). This is fixed so that null pointer accesses will now correctly
> > > throw an exception.
> > >
> > > == DT loading ==
> > >
> > > Previously, boards used the FDT blob embedded into U-Boot (via
> > > OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> > > bootloader, so we can instead rely on the first-stage bootloader to
> > > populate some useful FDT properties for us (notably the /memory node and
> > > KASLR seed)
> >
> > Note that the kaslr-seed is not so useful when booting with EFI.  The
> > kernel's EFI-stub ignores that and instead tries to randomize the
> > physical placement of the kernel if it finds an EFI_RNG protocol.
>
> OpenBSD will use it though.  And other OSes might as well.

Yea, I remember that, but efi_try_purge_kaslr_seed() purges it anyway
if there's an EFI_RNG protocol installed.
U-Boot also has other ways of injecting it. Perhaps we could keep it
and combine rng-seeds in the future I guess.

Thanks
/Ilias
>
> > >  and fetch the DTB that it provides. Combined with the memory
> > > map changes above, this let's us entirely avoid configuring the memory
> > > map explicitly.
