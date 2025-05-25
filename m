Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E17C54ED0
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 18:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0736482B37;
	Sun, 25 May 2025 20:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SA78TV2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADEC82B48; Sun, 25 May 2025 20:06:01 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204A082B34
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 20:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso3022614a12.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748196358; x=1748801158; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cdp6KyWyhu8GEaPnWnjDv8QtPBMRL0csY3TKOjIXbeA=;
 b=SA78TV2zqOLIS97LBe6QSutzgKrVM1bHoCl6InBvei5b4uBaodHfVb1m0WpTYkoeFN
 BPeygCfVW/3odP6WFnHmuhovvVprFMNFz6GJSzwfBrViQqzsBrl3SGrwVwC6diXYQguU
 OnWfN4KPmuPRVIH4Pp4a4SrEkFutabsZgp524=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748196358; x=1748801158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cdp6KyWyhu8GEaPnWnjDv8QtPBMRL0csY3TKOjIXbeA=;
 b=m+yNsuWzFsUTtgWn4KP44lxtDr1V42rnfG+/UIV3BpBL96U4SypxPaSCUrsIIrwtYe
 fkFzL5nbFmi+zSYG/Ffa6Z+qKbiRroVxWYEkcJ/Ps+tr5key0qDtmxOJniUsmO9ykv4q
 4Kr6yitt3KiTQHsgWubP/8408+hpN87EE33xhdlMH0K6o4Ggcd3d2gYekIwZHqbmFjY8
 sYP7GKVIsIbx/oFTFRIhqHcFVBL9MyP/cjD7ElrC56RhN4+1Ucf78jVDw5oT5dUovNW7
 DIdAWGeras8pucX6g0RMFjEy+wkT5FMBo4O/gWRDyCmEHjz9rQqhirEjaiMDxW4u0/we
 /lTQ==
X-Gm-Message-State: AOJu0YyLXVoWnaRKFN3TG8ZP5fk7F7BbkGFtXxKXLB9bhMOfRE925ZMc
 ohQJ2EYEsW2TW/f+CS1ZanGRik4hhJ1/J9mrHXtgp3AI2kSDjhQJRyyW+6pL4tY08gsa5xugZpJ
 VRah51zkY+MhKYw33CicbMvIPBjftL7MhHNq9xvLA
X-Gm-Gg: ASbGnct81S5ngrC+wiiHGkdimw/KHykxM2ZGOxKgHQ6F5xB1g0SNRzuWZkXWD9LWJs7
 q3R95W0W2XVo/LKeFHqAzJZImrF6tPdY/tRpVqodRC/g7gq+xrcCZ70EUSIUBjeXhy4KVp1KrJE
 VWcw2hvjUwwkLkkkysUdUkCchpEBp6iYxPjdWDNHJogA==
X-Google-Smtp-Source: AGHT+IEBGjRXH/1eTfNUp+lAMtcBn+uVpb5XFd5ZI/T1FTu9XBoO0nNfNhGwmr3VgMOwc4qB7MXqJDhUQzHDgHs36zo=
X-Received: by 2002:a05:6402:2746:b0:5f6:d403:fb20 with SMTP id
 4fb4d7f45d1cf-602cd36091fmr5207238a12.8.1748196358494; Sun, 25 May 2025
 11:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 19:05:46 +0100
X-Gm-Features: AX0GCFviwnAb_W9Dh79BalkS4dF_-wU9FTaB25tXJ6SXwQ7c5wCyyBF91vhdYPc
Message-ID: <CAFLszTjiRpYaG=Hx2fo5gGowpfkww1t4=W7iaEpgbU3OgWKbuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Create FPGA Partial Reconfiguration (fpga pr)
 command
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Naresh,

On Sat, 24 May 2025 at 21:37, Naresh Kumar Ravulapalli
<nareshkumar.ravulapalli@altera.com> wrote:
>
> Partial Reconfiguration (pr) FPGA command is added to U-Boot console.
> The "fpga pr" command supports multiple regions for partial
> reconfiguration by specifying the region number. The implementation
> of the command is specific to the underlying FPGA device.
>
> In case of Altera, it is used to freeze the specified partial
> reconfiguration region, then user loading the reconfiguration image
> followed by unfreezing of the region.
>
> Test set currently can't be added as the command is implementation
> specific. It involves opening of FPGA bridges and loading of external
> images during run time. Currently, existing FPGA commands don't
> have any tests/sandbox environment. The design is being worked on,
> but would take some more time to share and get the community
> feedback.
>
> Changes in v2:
> - Change the command implementation to generic FPGA command
> - Add usage documentation for the command
> - Correct "_" with "-" in alias name in Altera dts files
> - Add FPGA partial reconfiguration support for Altera devices
> - Address minor comments in v1
>
> Naresh Kumar Ravulapalli (5):
>   drivers: fpga: Add generic partial reconfiguration support
>   cmd: Add partial reconfiguration command
>   doc: usage: cmd: Add documentation for fpga pr command
>   arch: arm: dts: Correct alias name for Altera SoCs
>   drivers: fpga: Add partial reconfig support for Altera SoCs
>
>  .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |   2 +-
>  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   3 +-
>  .../dts/socfpga_stratix10_socdk-u-boot.dtsi   |   3 +-
>  cmd/Kconfig                                   |   8 +
>  cmd/fpga.c                                    |  38 ++++
>  doc/usage/cmd/fpga.rst                        |  65 +++++++
>  drivers/fpga/Kconfig                          |   7 +
>  drivers/fpga/altera.c                         | 163 ++++++++++++++++++
>  drivers/fpga/fpga.c                           |  37 ++++
>  include/altera.h                              |   7 +
>  include/fpga.h                                |   3 +
>  11 files changed, 333 insertions(+), 3 deletions(-)
>  create mode 100644 doc/usage/cmd/fpga.rst
>
> --
> 2.35.3
>

How about creating a uclass for FPGA, with an API? I think it would
help to make things more uniform.

Regards,
Simon
