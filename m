Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E030C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC12C87987;
	Tue, 24 Oct 2023 21:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WeYAoUNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D96F879C6; Tue, 24 Oct 2023 21:34:58 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D032C87134
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so745305166b.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698176095; x=1698780895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rFzL+om+1Q2L+cFAORFScz2+YBKctMVbmZz0G7gVboQ=;
 b=WeYAoUNYK/lhuEqkF894B27IhG4u35gz+szmOOObypGOOhld44vjeZWPVqKk0Gd1MT
 4XI2qq0TFXUPISfnT9VULbfVcEt0tOTJ1/y3Or9wnOZ7mGwa71djw78j1FB++0nNtutZ
 mnH/CYTfN8WMUL7hFt/WC6wlc1VdzpyIMpzME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698176095; x=1698780895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFzL+om+1Q2L+cFAORFScz2+YBKctMVbmZz0G7gVboQ=;
 b=A78CoxqiSAZ2dwzkY+AHYdLiqdo4XQG4iFCuiN0RicUlYvpdiJ9Nm8dhGxcNzQt2ir
 CIxG8vD5c+yaUb517/2gQZx/JRVSXjOC+NU7KAHAdcFyCrRL9wkVoSLgt+tQfzkQvisG
 0A7oZKHRPHdW/DwNuzF8fuYMaXJ/fj/BJIW9N2hOjKFmRanh5ToAxQHPYaAYfHNF2eK6
 /0Yi/AGd0ahVfyoLA5WXqnF5u/RKY+PSoydsNXaIUJxQjMGdGoYPXWvTAupUuoYElD9L
 mBEU6qhUMmBbi+YkVdhcDd76WnbvQjndHQt1/I8b6DcBuhOWaxaD0Pt1WrU1lH1m15pA
 oozg==
X-Gm-Message-State: AOJu0YylRfhtC2CN0RKBDUwXxs5OD/w9QA4Dk0JhDoK8DZvDPramRW4t
 tKYoZ+4d2i0bF6Sku7DCargP1VPIv92VWW2OqYWuMw==
X-Google-Smtp-Source: AGHT+IHSEvZYUEj3fhBBP+f8c5RK87CVMgsJdjMOnnm7ZvIsikyocq2t4M4VpdoM+BOnURAuCiODhWX0jkStVD9unrQ=
X-Received: by 2002:a17:907:3688:b0:9c2:a072:78bf with SMTP id
 bi8-20020a170907368800b009c2a07278bfmr10295869ejc.26.1698176095119; Tue, 24
 Oct 2023 12:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <CAPnjgZ3mcyST+6dLk1r=cXwQDFT1CNAfOXXfbMaSFGt+HqCiCg@mail.gmail.com>
 <df7c8647-abfe-43a8-869d-6a570a109f9c@linaro.org>
In-Reply-To: <df7c8647-abfe-43a8-869d-6a570a109f9c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 12:34:39 -0700
Message-ID: <CAPnjgZ3HM-f_Af0uKEz+4vDT0f4-6AWhOOEaDNqYWko70f6rvA@mail.gmail.com>
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
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

On Tue, 24 Oct 2023 at 11:10, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 24/10/2023 19:03, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Tue, 24 Oct 2023 at 04:32, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Add a new config option to allow u-boot to reuse the FDT provided by the
> >
> > U-Boot (please fix throughout)
>
> Will do!
> >
> >> previous stage bootloader when available.
> >>
> >> On some boards the previous stage bootloader can populate
> >> platform-specific parts of the devicetree such as the memory node, this
> >> allows us to avoid hardcoding it in u-boot and instead determine it
> >> dynamically at runtime.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >> This patch will improve generic support for Qualcomm boards by enabling
> >> us to configure the memory map at runtime rather than having hardcoded
> >> maps on a per-device basis. I've gone for this approach initially to try
> >> and avoid introducing board specific code where possible, but I'm happy
> >> to rework this into mach-snapdragon if that's preferred.
> >
> > Do you think it could use bloblist instead? I did send a patch to use
> > the FDT in the bloblist:
>
> If it would require changes to the previous stage bootloader then
> unfortunately not. We're mostly stuck with the behaviour that we've got
> for now...

Yes it would. What is the previous-stage bootloader?

>
> This mechanism of retrieving the DTB is also used on the apple M1 I
> think, and any other board where we're booting U-Boot as a drop-in for
> the kernel on arm64.

I believe M1 is an open source project so perhaps they could adopt
firmware handoff when it is finalised.

Anyway, can this use OF_BOARD instead, perhaps? It already permits
board-specific actions and is used by some rpi boards.

> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20230926141514.2101787-40-sjg@chromium.org/
> >
> > Regards,
> > Simon
> >

Regards,
Simon
