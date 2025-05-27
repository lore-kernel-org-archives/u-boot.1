Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB1BC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 17:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2D380F0E;
	Tue, 27 May 2025 19:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQE248DZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09648313B; Tue, 27 May 2025 19:15:25 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C9C80050
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 19:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso142027a12.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748366123; x=1748970923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hfrblWur69G/GDFNQOzflTrW3GT/HK0T99rM2Qu0pa8=;
 b=PQE248DZVnhJmpC790aFm/RniP1gYtK7+WJ5JfmM/ipsDJ7PyzMUrmCb9RPnfAD0Lw
 WoIyn1nquxnl38VZXb7G5ehMSqZlmzruyPaX3GMnASycK/nzvs7kOiftoT/jkO9s4Sxz
 69GJqsgNJsuWQizQX6O6MFFA7d7jPM7eMUbMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748366123; x=1748970923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfrblWur69G/GDFNQOzflTrW3GT/HK0T99rM2Qu0pa8=;
 b=Q+4tf/d4tgmDmrCJCW+XGx94kSznkwfTl7B++36cocEyPL/WvldnuBG4fquiN+r1Nm
 x7pmsxNhHiO3jkZOYyUmTV7ryGaaAu7jwUQgc7IJML30jG60VkiTEjJ789hYOZjKrvoX
 HrQqpZngihJGR8xF8xFi9UFijqlJ1IBv63IC+TTn+/rXe2iI3QFR7zKrkVqJQa+sInXt
 g/PcjH1Xw4E4Ugeu4UBxt8Q0ipz31xCFZzZ4WGgW2UFdHYkywSyqlWTeEhzcdmsSdr9F
 yBhExFRXOXyUqYkmGpiRjp/3FExpWTjYdiwYLA0OGDbbYj0iz05mzh/hVlT2E0nJ8/wn
 Kr5w==
X-Gm-Message-State: AOJu0YwzsUejC5uCiegM2bzF7iurl6sY29Liqoy4UtR6IBDpYf+pVae2
 8KWAnF85XL2M/ayg/RWsHlj946uiZL6mxnjRwMQPGB8d+6jtSrWvoJuKPi+dVcqR5s6OFw7Uk2p
 XYAWX2DgbjSoWIRtVzFEJJwEAXc+KPH4ZCR7tcVj/
X-Gm-Gg: ASbGncuw+wkeTt1HvrWu7glYPIyAeDlgyoRwJI1+SEBmsssgPlOx7RBHQTnsPDS309b
 VlB9hGZxEBQ638ZW4tDOPIOX4vQH93PlXnG+I7lKE3QPoyj5Z0wllTdlzk6N4py3n7MhWkNE51q
 uJ+w/Mvbs9crkjDxnY8j5VeZmAFraHKZw=
X-Google-Smtp-Source: AGHT+IH34b5/34LZmMoZTHMuOud00N9wrj+/TvCK9dx8EXNAj9bbdwXPru06vP2VHygNgCxduweAoTMMmYLIsHRU9JU=
X-Received: by 2002:a05:6402:1e95:b0:5f6:d403:fb20 with SMTP id
 4fb4d7f45d1cf-6050e442659mr1244743a12.8.1748366122980; Tue, 27 May 2025
 10:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
 <CAFLszTgC4Z2EUNgy8Ya6joUk3HV6+d2qoiqEq6taf9Wvuhdy2Q@mail.gmail.com>
In-Reply-To: <CAFLszTgC4Z2EUNgy8Ya6joUk3HV6+d2qoiqEq6taf9Wvuhdy2Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 May 2025 18:15:11 +0100
X-Gm-Features: AX0GCFt7Hv5I7npLdsU-0cYYC38MZ6QZee_kUP-MDzlT-JkiGbyMpET_qjnH1J8
Message-ID: <CAFLszTjeq0u9NHXPQkP9somm0wRaEdd4HHNuFgvYGOKCqsYkgQ@mail.gmail.com>
Subject: Re: QEMU & KVM broken for arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Mark Kettenis <kettenis@openbsd.org>
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

Hi Ilias,

On Sun, 25 May 2025 at 19:09, Simon Glass <sjg@chromium.org> wrote:
>
> HI Ilias,
>
> On Wed, 21 May 2025 at 10:08, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> > tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> > The command line to reproduce it is:
> > qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> > -bios u-boot.bin -machine virt,secure=off
> >
> > commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> > OF_HAS_PRIOR_STAGE") boots fine.
> >
> > Simon do you have an arm64 host to reproduce this?
>
> Yes I can use the runner to try it out.

It's a bit strange. When BLOBLIST is enabled I can't even get it to
the debug UART, in crt0_64.S

So it doesn't seem to be doing anything with bloblist. Yet obviously
something is provoking it.

Regards,
Simon
