Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BE8CD8C8E
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 13:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2A783314;
	Sat,  6 Jun 2026 15:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShrXFM4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C142846C3; Sat,  6 Jun 2026 15:56:03 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FA48063E
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 15:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68e5f7c1131so5322160a12.2
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 06:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780754160; cv=none;
 d=google.com; s=arc-20240605;
 b=P5obClkuMvyLM94z6TT9PLrgC5DDr/k471qIfVPcUOCn4lLSgiNW8UcAdi3iqfBc74
 TUHGxwxrZO+4dnxGQBsurfrwx5bOrozZmXPzT4s674d+Fwc4maAWZoufEjU/20GeCWKS
 I+LUmls3l+lN1uLyKBnI4Wz0f9KpUwX818t973/cZTCUmo9NBz2CMaU+Tjc7hu+w025i
 q+SItGXV6xfPMxjF+shhlC5ArUoSrwJsSn9gxofe+t8l+jehppdN/YF7ZQK26OpgCO7X
 PEFI4illbzUYAx4SSGLJO905E4lTjgqB5kvDbZSoqUHwkfftNMPi7Q84gbZ5+h68lMtF
 xLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MfX27OesIVqomPuqgqw8cgswLzajmlJ33XYWSJ7g6TE=;
 fh=FElGipvXLM4UOuDU8JNgiFTVEuqJ5Aw59MN8uU752Lc=;
 b=UBN06megJ53au77MQoxQhs2S/lPQawZnLJsEy5c0oQ8CSypttSXmrK3qTyWlbjmPk6
 00tdvd4PSp0qQQfKIEUQBrb8F4fp79SHhT2IBSVnIZcuGr1zLaKq+2L/WzmQDGO4Ir4U
 HvbysVXKq3Arg1Uvro9gWl53WrAD04nkDFpLd5bhFG58nllU9R/+Ax0pWDX1Xy3G+ky2
 K6e2sRVL5I7S/fkn3QCucarUAwV6xtY/w4UeyzAgY6DxfZGZ4v8FbJpEj1axZGAlsgq5
 on8x6vV8oqtgE84bXoyDvYZs6DUsjZsogf2GH93MorTzZI6JBT2hZS9HNDgaAQ0psokg
 lnPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780754160; x=1781358960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MfX27OesIVqomPuqgqw8cgswLzajmlJ33XYWSJ7g6TE=;
 b=ShrXFM4UgxAT1KhudHTZbMuPgMWABLkAscX3DET6ktkrqiEX1WxyBTr7W0k7BIlRM8
 EomHsg5t3HEBrumLRauBVoM9y/We/KJAgUk/3CjfdtyTPjWrUxuSGC+USzikYl2qxPpG
 wTFTJOTTmuRfsy/Nr2ILhlYEdDwXgLyVzqmxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780754160; x=1781358960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfX27OesIVqomPuqgqw8cgswLzajmlJ33XYWSJ7g6TE=;
 b=b0q3fzjWkUgtY3YBcdnzgU86izBrcU9dBv2CAE+NjuNZHfyVaHb5MEZkc17x6DEx2e
 uoK/ooNhwJD37NOmWICpjTVAaHUojWMWKZWqCI9s0UiqJzd37D0uX28JnuZXeG/xW3JA
 Dsp4ZOhLJc3xHuPC5Y7atGyfPTK4YkLNhEKL6tiAj9ZGh4zG6Ni7peZSbYmbsBqUZXm3
 5hRKGdUXmxagya/oObUitKzPP1e83sfG1lKAgVWPDEvv29/Ltdwgin1dhfqSPCP46NKr
 hvEIM4xq69bt+MxiyicnK+aE08b+2d7HXO+L3TcDZAOGA5q68yiw1zB9bjGJNtvDpuSp
 8YNg==
X-Gm-Message-State: AOJu0YwRA9CMUpf05xPE8jP9f22rq9VgX+g9KthOlKb5uyQuQelmis9D
 rblq9IvaCW73awKq+bw/HfPWAAlJDlUae36FaMYU/b1CmxWL+eyzJkDOC3q3/51O4VmUwXoNbn6
 OkF1V2+8KxyevRK5bcTbGcDkHZVD5My81xwB/WcVnJdOzX3dds32PGg==
X-Gm-Gg: Acq92OFkA01DP2WZwG4rcCARIKlgKN17as7Gns4cOBty4cYYx3Fc3qWI+9xoQj6f2qF
 ldkrTDH+v6Vps+OpGGsUyQdhESR3JbNVeRc3wfKu8c4HCBv4M5RnWdPaxyffSV4FiFTIHwPf9Ph
 WfF+qcAlYZHnSVJExo4hjAE0mIVVFtEuJE+pkTHv5XtBcbIQfUpbgct9PIteIreFpPLqM0y+L68
 SVdqnXYBFeO+jRyHDrCBz2d42a09MIkjItu9CpZdlZFfmOAulWGdyMxBJGi5u2Vhvt1//TT4mJR
 koTuQdQxUTTf+TaZOg0U5tZoM/4=
X-Received: by 2002:a05:6402:3905:b0:68a:c316:34fc with SMTP id
 4fb4d7f45d1cf-68fa4e27b23mr3548181a12.9.1780754159743; Sat, 06 Jun 2026
 06:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
 <ah1cQApIrmWAa8TS@ashevche-desk.local>
In-Reply-To: <ah1cQApIrmWAa8TS@ashevche-desk.local>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 6 Jun 2026 07:55:48 -0600
X-Gm-Features: AVVi8Ceor-VX2VRHiRVt8AoCvWOfkf1Y4xUmAJLn0HQ3eKHWziOs5UJYKsTq_cc
Message-ID: <CAFLszTj7aQvqXDeBd91Du3i=0X+9ssrANXcNDqGxyxMR_-dh2w@mail.gmail.com>
Subject: Re: Flashing Edison
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Andy,

On Mon, 1 Jun 2026 at 04:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, May 31, 2026 at 08:31:38PM -0600, Simon Glass wrote:
> > Hi Andy,
> >
> > I've dusted off the Edison and have confirmed that it starts up:
> >
> > # ub-int -T edison
> >
> >
> > ******************************
> > PSH KERNEL VERSION: b0182b2b
> > WR: 20104000
> > ******************************
> >
> > SCU IPC: 0x800000d0  0xfffce92c
> >
> > PSH miaHOB version: TNG.B0.VVBD.0000000c
> >
> > microkernel built 11:24:08 Feb  5 2015
> >
> > ******* PSH loader *******
> > PCM page cache size = 192 KB
> > Cache Constraint = 0 Pages
> > Arming IPC driver ..
> > Adding page store pool ..
> > PagestoreAddr(IMR Start Address) = 0x04899000
> > pageStoreSize(IMR Size)          = 0x00080000
> >
> > *** Ready to receive application ***
> >
> >
> > U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)
> >
> > CPU:   Genuine Intel(R) CPU   4000  @  500MHz
> > DRAM:  980.6 MiB
> > WDT:   Started with servicing (60s timeout)
> > MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
> > Loading Environment from MMC... OK
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   No ethernet found.
> > Hit any key to stop autoboot:  0
> > Target:blank
> > Partitioning already done...
> > Flashing already done...
> >
> >
> > ******************************
> > PSH KERNEL VERSION: b0182b2b
> > WR: 20104000
> > ******************************
> >
> > SCU IPC: 0x800000d0  0xfffce92c
> >
> > PSH miaHOB version: TNG.B0.VVBD.0000000c
> >
> > microkernel built 11:24:08 Feb  5 2015
> >
> > ******* PSH loader *******
> > PCM page cache size = 192 KB
> > Cache Constraint = 0 Pages
> > Arming IPC driver ..
> > Adding page store pool ..
> > PagestoreAddr(IMR Start Address) = 0x04899000
> > pageStoreSize(IMR Size)          = 0x00080000
> >
> > *** Ready to receive application ***
> >
> >
> > U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)
> >
> > CPU:   Genuine Intel(R) CPU   4000  @  500MHz
> > DRAM:  980.6 MiB
> > WDT:   Started with servicing (60s timeout)
> > MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
> > Loading Environment from MMC... OK
> > In:    serial
> > Out:   serial
> > Err:   serial
> > Net:   No ethernet found.
> > Hit any key to stop autoboot:  0
> > =>
> >
> >
> > Now I can see the instructions in doc/board/intel/edison.rst but I am
> > not sure how to translate that into a lab. Basically I have:
> >
> > - UART
> > - Relay hooked up to the RESET button (SW1 U15)
> > - power control
> >
> > The instructions in edison.rst are quite complex. I can run the
> > xfstk-dldr-solo tool but I don't want to have to download and install
> > a recovery image even time I want to try a new U-Boot
> >
> > Basically what I want is to be able to send U-Boot to the board over
> > USB and then have it boot into that U-Boot. It seems that once U-Boot
> > is installed the board behaves differently, but there must be a way
> > around that.
>
> If you need just U-Boot and you don't care about its default environment
> the `dfu-util` is the only what you need.
>
> Note, I have a helper script to setup U-Boot environment here:
> https://gist.github.com/andy-shev/2c388310f2773ead647d9c1a3f1c813f
>
> It has comments and examples how to do in different scenarios (working DFU
> and recovery).
>
> Based on your experience, please, feel free to update documentation to make
> it easier, because the process is not so complex. The current one most likely
> describes more steps that are needed for the old U-Boot (which came on a stock
> image in 2014) to replace.

OK, so after a considerable amount of effort this is what I have found:

I have Edison OTG/DFU on a Coolgear per-power power hub, plugged
straight into the lab machine (no hub). The 1-hub depth (board -> hub
-> host) seems to be required for reliable xfstk DnX transfers.

The board seems happy drawing power through the OTG VBUS (the
Coolgear), so does not need the power connector to be powered (at
least until it uses too many watts). In any case both must be off for
the board to actually power off.

There are two cases:
1. A bricked board auto-enters DnX (8086:e005) on power-up - no straps needed.
2. FM/RM straps are only to force a HEALTHY board into recovery.

However, from the point of view of my lab, I can't assume the board is
healthy and handling case (2) adds complexity.

So I run:

    sudo xfstk-dldr-solo --gpflags 0x80000007 --osimage u-boot-edison.img \
      --fwdnx edison_dnx_fwr.bin --fwimage edison_ifwi-dbg-00.bin \
      --osdnx edison_dnx_osr.bin --verbose

then power-cycle via the Coolgear; it flashes IFWI + U-Boot and the
board comes up as 8087:0a99 with a full dfu-util alt list, including
u-boot0

I also need a udev rule, of course.

I ended up with some rather complex Labgrid logic (no chance of
upstreaming it, but I suppose that's OK). I also created a Binman
etype. Building the image with binman, I found the OSIP sector also
needs a valid GPT-protective MBR (a 0xee entry) or the ROM won't boot
it.

Finally I found that the board doesn't actually boot on mainline for
me. I suspect I am doing something wrong, but in any case I am going
to send a small series for your review.

Here's the successful job:

https://concept.u-boot.org/u-boot/u-boot/-/jobs/524065

[..]

Regards,
Simon
