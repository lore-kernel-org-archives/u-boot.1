Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A1EC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 10:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63D486DD2;
	Wed,  6 Dec 2023 11:31:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AJvU15a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5F786487; Wed,  6 Dec 2023 11:31:55 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4A886DD2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 11:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bf32c0140so4205944e87.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 02:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701858711; x=1702463511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/0wBW30uIKj4wuEyClQj+zoEpUVLBd4NnMjmKG3Kzs=;
 b=AJvU15a4NyToazTPCK8KEei1FhIjVDqNIeFhLTzSobT3R78xG8csvIWkUtGSTHrIGJ
 xbgHhq/fMb9FYviZPhWMZYb+ooXR6btQcZWQkSP3fvvCAl2/fHZ1GWemzp53ZwkKwcP2
 d4+a5G6OZcIKu/WEyW4SztGDWRbDSCdKdlhNrr3tPa0nu8iTeP+wSs9igzJ0IqZuuFUr
 ra3w+C2lXgKcKUYPPj9UQPCgcsMtcZF5vTn+TTxx/6/3tpHrL/6JHpfg5woyNSu5RGbu
 KZCXeLKyiQLn4gT+P88kQ8fpe6Wka2U4JIbDcaV+ZZUHQzzAjsDG/sUCiTvo09PYos/V
 ACJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701858711; x=1702463511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/0wBW30uIKj4wuEyClQj+zoEpUVLBd4NnMjmKG3Kzs=;
 b=spUf1vdq0q0yJIw4yvh2TLdgzX2Sw4/gv1o8SmrlUuTBJMYyeMs6JSzgkib8tSaRaL
 isXDSmRluOxyf+M/q9zeZQQJN2EQsLpWLwv/OIiM9wd54fiv3no298p174S5SLmCiYEC
 YzInBinSnOsw/oDcRrxBJ0P9eUPAzDxOfYUWhZWMASPAHzkQsxpzEqpIahg9VHr9SX79
 49ZXaOZHO0hGV6LnwCCKgZJx8jboPu2qBnjt0j5G1y5mK0L7ny09tTewi5KYSSrCRgGj
 Iggq5XNOOlwZENZh2aafqe3r+p8JG2gGNY4ikJ73OXjUbiZogGCKwkxLxhz45wWaYIBo
 HoxA==
X-Gm-Message-State: AOJu0YwUe37Aeg0bGNDJzWkftZbeF1MamHIOzVEnHCMFrYqhAEyodH7h
 /o9dZAEqmSzyQevzAkNPKnMG4q6L0T4DHIX4aJFdYw==
X-Google-Smtp-Source: AGHT+IE6AnuKMHwKGBq49U8XHEnhWchH1xUGVOoM3kVHC15J3b+XydMUS9397/sa7Ov27yEZhlbrkcjugWOOGy593rU=
X-Received: by 2002:ac2:5f8a:0:b0:50b:fcee:8d4c with SMTP id
 r10-20020ac25f8a000000b0050bfcee8d4cmr379650lfe.100.1701858711496; Wed, 06
 Dec 2023 02:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 6 Dec 2023 12:31:15 +0200
Message-ID: <CAC_iWjKKjVQrt==U-CesqFq+xOCe736-kczaiA_cD-z=BEN+Sw@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Caleb,

Late to the party, but I'll respond to as much as I can

On Tue, 21 Nov 2023 at 19:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Historically, Qualcomm boards in U-Boot have all had their own
> board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> devicetree with little/no compatibility with upstream DT.
>
> This series makes a few final prepatory changes, and then replaces
> almost all of the board specific code with generic alternatives. The end
> result is that all Qualcomm boards both current and future (with the
> exception of the db410c and db820c) can be supported by a single U-Boot
> binary by just providing the correct DT. New boards can be added without
> introducing any addition mach/ or board/ code or config options.
>
> Due to the nature of this change, the patch ("mach-snapdragon:
> generalise board support") has become pretty big, I tried a few
> different ways to represent this in git history, but the other methods
> (e.g. adding a stub "generic" target and removing it again) were more
> confusing and made for much messier git history. The current patch is
> mostly atomic, but requires regenerating the config.
>
> The QCS404 EVB board had some code to enable the USB VBUS regulator,
> this is dropped in favour of a adding a new vbus-supply property to the
> dwc3-generic driver. This will also be used by the dragonboard845c in a
> future patch. This handles the common case of a board requiring some
> regulator be enabled for USB host mode.
>
> A more detailed description of the changes is below.
>
> == Memory map ==
>
> The memory map was historically hardcoded into U-Boot, this meant that
> U-Boot had to be built for a specific variant of a device. This is
> changed to instead read the memory map from the DT /memory node.
>
> Additionally, most boards mapped addresss 0x0 as valid, as a result if a
> null pointer access happens then it will cause a bus stall (and board
> hang). This is fixed so that null pointer accesses will now correctly
> throw an exception.
>
> == DT loading ==
>
> Previously, boards used the FDT blob embedded into U-Boot (via
> OF_SEPARATE). However, most Qualcomm boards run U-Boot as a secondary
> bootloader, so we can instead rely on the first-stage bootloader to
> populate some useful FDT properties for us (notably the /memory node and
> KASLR seed)

Note that the kaslr-seed is not so useful when booting with EFI.  The
kernel's EFI-stub ignores that and instead tries to randomize the
physical placement of the kernel if it finds an EFI_RNG protocol.

>  and fetch the DTB that it provides. Combined with the memory
> map changes above, this let's us entirely avoid configuring the memory
> map explicitly.

[...]

Cheers
/Ilias
