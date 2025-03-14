Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949F5C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:44:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68BC81DCD;
	Fri, 14 Mar 2025 15:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DYeo3wTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B7881DE9; Fri, 14 Mar 2025 15:44:49 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8711B81DCC
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2ed007aacso437581666b.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963487; x=1742568287; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E+mmioR0JlNqITuU0MHSCr02tRyusfA2SU12RVinQJE=;
 b=DYeo3wTweX8nNLreQGvU5lUnMMnevxtCL0skdvRbY8iniYlDuqvXBfXTuEL5zvdOty
 7eFROcABUXQl+YivZSMaqkJvAIX9eLB9G1/Tnuq+x+thq3ueTEswJz+KGbuXF2ja6e3G
 d9v6+HTd5MiepZ82vY6vL/Aau1C80da95Zg9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963487; x=1742568287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+mmioR0JlNqITuU0MHSCr02tRyusfA2SU12RVinQJE=;
 b=k++/L+JuVVsVZAa/ZQ5Fc5bTOwBKeM119mCc2XId21NrzgePok3J5+BQ6pHWpWwsuR
 DDgGMOdDtRx25+tZ5HZKIapkQsrnHhfhkiAvJhJtILCeZalHT5VpTILFPV19DhJFFDPb
 BfX32EeJKPxU55h4pF++qB4ra5AsRXWNb/z30sfq2kTktyAgqDqLdsP0BNdMIsKgrHOq
 BoiRPecb5jvZu1Kq/5uM/ZETUPEQgIE0SbK81Q5hkCINU3Y6oB+S65vHH4meO2bHnNxO
 TyqcZJoDQNfz0Sjz8fcWyot9XxYD1gScy4YfSsmMlhVbYJ5F8oopfwP48bMYp47UQJ15
 Q22w==
X-Gm-Message-State: AOJu0Yz1M5WIRO/fJIaIE3cBBgcjV/KzCZYz3UlPyls4XdWCZUiVpwEm
 vSxIyDhEwfGVpQu6otq58vvvZ2BY1ZvRL2XAbI1Ph/DNWSiCjpJl93ztuiD5XjBZpaLZ624Y5+k
 O21LLBp5ciWDrBaA+yP+x3AWk90UBeVlpTXin
X-Gm-Gg: ASbGnctzLTpSS760OjZNO4p2T0oEanxun5zlhGPfr302dRiYAj3Ask2EgeiObhu4m9j
 L73vNQDvZ/+Vudt5Z13VrvxvTqBv1zpHnm5jSi9KeZv3sqysQNyVE1nOb/AcHH7rodbFXsjQRqb
 UTrwoLkBJueQpT4n/LxUimPwKfFyx6
X-Google-Smtp-Source: AGHT+IFcB66P3WuSLfFUXPdWeMVuD9xRdhZhOB0EEFFUlsycmCKgx2K6QI/lGiEFiUOetV4myECiUCKqshSPlQSkoqs=
X-Received: by 2002:a17:907:d92:b0:ac2:d5e6:dea7 with SMTP id
 a640c23a62f3a-ac33017710cmr345011666b.13.1741963486995; Fri, 14 Mar 2025
 07:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
In-Reply-To: <20250307142255.GL2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:44:35 +0000
X-Gm-Features: AQ5f1Jp-MmYnjUxHsnfWVgj9hifY91XGM0HctUYfs31ZVaqYpc5_gyTiGM0EclQ
Message-ID: <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
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

Hi Tom,

On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
>
> > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> > is not perfect.
> >
> > With both builds, executing the VESA ROM causes an intermittent hang, at
> > least on some AMD CPUs.
> >
> > With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> > is done in a way that works on real hardware but not with QEMU. This
> > means that performance is 4-5x slower than it could be, at least on my
> > CPU.
> >
> > We can work around the first problem by using Bochs, which is anyway a
> > better choice than VESA for QEMU. The second can be addressed by using
> > the same descriptor across the jump to long mode.
> >
> > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> >
> > In v3 some e820 patches are included to make booting reliable and avoid
> > ACPI tables being dropped. Also, several MTTR problems are addressed, to
> > support memory sizes above 4GB reliably.
>
> Do you plan to rebase the prerequisite series' this requires so that it
> can be merged?

Here's my understanding of where things are:

1. You rejected the membuf series and my replies to try to resolve
that haven't gone anywhere yet. So your tree doesn't have any tests
for that code and still has the old naming.

2. I sent the first part of the PXE series so you could apply that.

3. You rejected the second part of this series because it didn't
include support for lwip without cmdline. I offered to handle that
case later but I'm pretty sure you rejected that too.

4. This series is now marked 'changes requested' but the only feedback
I see is in the RFC patch.

Regards,
Simon
