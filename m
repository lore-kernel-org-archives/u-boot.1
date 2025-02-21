Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA46AC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 22:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061CE807C4;
	Fri, 21 Feb 2025 23:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O4SqaxHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C97780F5C; Fri, 21 Feb 2025 23:55:07 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E478056B
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 23:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abadccdfe5aso452446066b.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740178504; x=1740783304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F+IA/ccQy0kA2kQhPJhf//ZP4t641NUw6avwThQdFTQ=;
 b=O4SqaxHooynpRKXkf0kPDcAzjRSRQHhzRIeU0MfFsQieV3kV+14zsHZH1lmkDDty3y
 obEdMbWEefWYpFWf81o7GsQsyhvk/33GEsPAxqfMiAHH966pYC4Rd2fmSih+53uDrF2U
 bgvk0dVf9MzOItW/kyNMhmtpZwUxFBd1Ns3yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740178504; x=1740783304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+IA/ccQy0kA2kQhPJhf//ZP4t641NUw6avwThQdFTQ=;
 b=lFPuqP/6l9OmmxmOMGfsNcw4D43FgoTp5+KBzX5sNIKzETXogJc+VbaW6IdZzz4j3v
 dH8J3u47/qsPdPYfqaszM/dQ3EpbIne9zJJyaQ/VzBDDgVopsiy4P1UId8k3dygbDyuc
 YhIShLEU/ZBKA8fwoWYIqTPcDI4TsMLuw2/RwVlzkKcWM00IuC29qfj7Jy9pvJYbnps+
 cYG4fwVAUeTseX4s7efWg5uYyqKqBUsgNoBylKZKzLYcmjUzqP718ty/vpcz0wHm7q6E
 CLUW6g2/Bo6bfORE+BugwQ4G+iyp8NdzveLr4BWuMzdSURvmi/pdIB9Gm1M9li2JDhHI
 Bpww==
X-Gm-Message-State: AOJu0YwUSYi+TI/U7HTYbfKSSSgicq0vB2JbaJ6QPM23rQD+vIqCDLj8
 VQrSygrcIj5sgzZyKVQnzNs7nl/7gOlYBLgZYOLTCpxCkCsQcCfNysw4zq3xPhm2tpcwJZmiN4h
 Toy+haMhYop+pVjEfBGSYTpruARmZOGyK4Q3E
X-Gm-Gg: ASbGncvSuH4rQq/9K9yE4fwHFr5Az9LXOluIwyGypXhgCL6lT2Jthv49E50+0nA4VHF
 jk8htdkdg8QDhVhJn5buP0r5tWUcM1AWaOQkynokMMC3CvdFEtk2gv8QKEcrHC14w6AWBBc8Jfb
 LEKzgMuZAV
X-Google-Smtp-Source: AGHT+IFkIoboewW+vZ283qw5yRHH5J4b0A1qHMgZvjTGMAOApwmG/Q+lNSqK29QYNMZEZcojabh7vIBAGpozxIIOQ2U=
X-Received: by 2002:a17:907:970c:b0:ab9:63bf:8105 with SMTP id
 a640c23a62f3a-abc0d99463emr458523366b.1.1740178504312; Fri, 21 Feb 2025
 14:55:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
 <20250219203406.GV1233568@bill-the-cat>
 <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
In-Reply-To: <20250221192556.GP1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 15:54:52 -0700
X-Gm-Features: AWEUYZnNKvodOjS3hTKvx-Yqu3rbEAFQHB8TIPYI43uL2GjTewHeuUgzTUC4kyU
Message-ID: <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi  Tom,

On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> [snip]
> > > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > > look at it, and refrain from otherwise assuming how it solves the
> > > > problems I had seen previously.
> > >
> > > I pushed an updated version to dm/splg-working but it is not very
> > > updated. Still needs more work.
> >
> > Thanks.
>
> So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> changes, here's another example of the problem with your approach. What
> stops xilinx_zynqmp_kria from building in splg-working is that
> BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> since I always use O=, rm -rf) is needed for changes there to be picked
> up, but that's maybe just a missing Makefile dependency line. But that
> just makes it easier to see the next problem, which I don't see the
> answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> For SPL however:
>   CC      spl/drivers/spi/zynqmp_gqspi.o
> /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   203 |         plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
>       |                      ^
> /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   205 |         plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
>       |                          ^
>
> And I don't see, really, what's even getting us down this error path.

It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
across all phases.

I pushed a new tree which builds without the warning. Note that
SPL_SPI is enabled.

Regards,
SImon
