Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09A8FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B37D84378;
	Sat, 25 Apr 2026 21:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KteriHwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12EF98439F; Sat, 25 Apr 2026 21:14:35 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9191184372
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4756e74f8edso6186300b6e.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777144471; cv=none;
 d=google.com; s=arc-20240605;
 b=N7Y9yLD8GyGvr3pLLwGDNYlNyzD/5wtil5lspslGQ8LR4mtx6kJq6WhLxwRJV8nu4W
 ghRufCUppu9nvyeOesiurLgw8js1qfWNs3b+dnp/Y+uNpJYmxGZmzBDVIW/LMqJNEk3m
 r/sRNfOguxEb/unLpi3NEFw4mGMaWkV8zDffcG8tVLYyY46P5pXCI6CsyloSlvJ5ljIl
 Io8TAThDDlve6ZxJ88RB2lGrSfhkQg6xY667BrKvj+ln7vebQSC+0S1rJbZEnK2Gx7o5
 hd7Q/gwMd85xDrMFOm1LFD6LMP4Vq86o2QdA2aHx6tJ/w4v47xJEmtsGI9T3scLT0YyR
 i1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=09Yas38Qme923pYV1SjsmSADAATg/roaMXNVyKvg+DE=;
 fh=F4pYLshVXEj0zLes2PKyWpSS/rnCRv3j8a6SI+UooAM=;
 b=BEnWLz8bomieNNRNjv8FwPuZFJIXDb66bY/bq5XIaN5dEXzfnIuwzCZM3u/1l4m26z
 XQCPL1NrQ+TdkYJ1QjTc57AxnjzcvR2R4NYv5s7KwSpfD5Vdph3Z5tSukzcnz7i1bYF4
 7WtfKIlrkIrtii4n4jAxl7JNWSy7P2vqbym57PnRXhC9aKM0dogMKJToGoPcU7gfdHva
 p/otP0CN6qoVopcFIy92rWFcw0WxRQnv0QG8cmH5Rxp2s9xiVAejV3Cj1x+92T6jsQzX
 kO+38pumDbt8APyXJX8XGFxu/6+xiY4P6o4SzAmXG40OlggS1HAXhbApXFHOKPPCinKD
 DKPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777144471; x=1777749271; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09Yas38Qme923pYV1SjsmSADAATg/roaMXNVyKvg+DE=;
 b=KteriHwQdxGsbefws7lYFaWxzPDO1IDiXOQza4nRjhvOSPjinTW9UNSqqZX9m/EeNF
 vnzpP0hL0ZEh3/KQ/pPjYdOtKbc76xncVy+Rj5hMBCCpT/ip9JkMZ9B1XpFQKX8PT9Ge
 jC+w299+MO2bgHQaXSNNtYmzxRlfsM29h7j+1eKbD2KD5TkyQGNdA5iY6RRox/YpuTqH
 Z4z8lnVFuIDQWSwm8tgERED+RUkuOqxp2F6d6L/gr+rFQ5jbBbLydw00NFABjJE1BAEb
 fBHrQCQsQH8usOH2V+IAoAt5oVtG/myJ/ZrMsObTNE8BYeLyfIVeQoZc/XJ6qq/nJDft
 Vllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144471; x=1777749271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09Yas38Qme923pYV1SjsmSADAATg/roaMXNVyKvg+DE=;
 b=dkID2FMeLjHB+dz9Zvo5cgXKeZY83VV4NGLQsY7PG1l6ZZ89zIdVBN5TFGsARRKwHU
 CQ/KUHbHmbaFo/qu9NGsaf+ci8/x0/4BPz0rii96cZigX13fqA6ldbMP+jSElziG7Uy6
 6YavQFnDIUchrd/TDEEmZYpACB5gIsbmJmuKqkIKaGc3vXnXa51vEpfbGvZmEbwMbqY7
 UDWwO62DE/Wzf2B4gVIOOojl48Tx+9iUU6e4tSTYm9AQf/EU3jpW80eQPIv3qiiBNr0I
 sVxi1M5iYTBe8N43o9szR47uAzZWvaLoJm00oB7zfOXvhWUsWlCAUZBWH7aA/Qzh4KW6
 ai8g==
X-Gm-Message-State: AOJu0Yz+BZDpfQgNTwhpcusAl15XAXYetdvSVedzSmJcQMMq1zf6rWz2
 gwXDTeqXDOXMZnqwByp/0FlWVoRs9/ISOVv9Q7eZ2sUQ0Hjsgxnm0ZFoTLXe5p8a6BTsM5mfghX
 f+UCv1DMTmxBswE4VwrSlxxiK8ojoayTvwYR03UUImFkW
X-Gm-Gg: AeBDiesLPULNe+yxJg7NnJOD66tfLkBnoOeEuxjykPSNRBBJOnArxHM346DWrxz4/6x
 AH5fu4xUGoENZq2nTL7HAp3PYR2UQLSRmhRKTu4GeicAkN72InbvQ/VSFcilvbamiw45rEcXQ+s
 SsXuWLSPxNnideva9V5fyh+wUfhyX1TefwnBxh4kOK9XhRAsnjPcf/AyS0WzFsy644GmjA+Pj6n
 iRwFh4g5TWeEfelfYCVJAYF8kJBeLw1dm4O8LQUvmP/r3W2SztrHMtWwwT2OawHaZlklDs8d1l7
 +lSHUa7iTIj2HaO/6Q==
X-Received: by 2002:a05:6830:8496:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7dcc301e1a6mr10998440a34.28.1776995189819; Thu, 23 Apr 2026
 18:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SAyU4nFoBNdO1S2NzX==CvzQja5h3NQGEjWwNZ3aUYO6Q@mail.gmail.com>
 <6afe421c-8377-4849-b6d4-1d4b48d4c29a@altera.com>
In-Reply-To: <6afe421c-8377-4849-b6d4-1d4b48d4c29a@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 24 Apr 2026 09:46:17 +0800
X-Gm-Features: AQROBzD1RRnuGU5_JxresjVVyJJs6H5_erGVdJXsLwKDuhS9jyQy6xc5BZ2Zzrs
Message-ID: <CAN7C2SAxStbCiLv8zW_QaJ3DEb_mFrgAbvdj0Fe4b_Ssui7gSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 24, 2026 at 9:22=E2=80=AFAM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hi Brian,
>
> On 23/4/2026 8:18 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Thu, Apr 23, 2026 at 4:06=E2=80=AFPM <alif.zakuan.yuslaimi@altera.co=
m> wrote:
> >>
> >> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>
> >> This patch set updates the boot support for the Altera SoCFPGA Gen5/Ar=
ria10 platform in U-Boot. The changes include:
> >>          1. Update MMU/dcache setup across Gen5/Arria10 using common d=
river
> >>          2. Add ECC scrubbing support for Gen5/Arria10
> >>          3. Add DRAM size checking for Gen5/Arria10
> >>
> >> This patch set has been tested on CycloneV devkit with SDMMC boot and =
RAM boot (TFTP & ARM DS debugger).
> >> Tested on Arria10 devkit with RAM boot as well
> >>
> >> v1->v2:
> >> --------
> >> - ECC scrubbing, Gen5 DRAM size checking, and shared dram_bank_mmu_set=
up() is set as optional via Kconfig and
> >>    defaulted on only for the reference Arria10/CycloneV boards to avoi=
d SPL overflows on size-limited Gen5
> >>    defconfigs.
> >>
> >> History:
> >> --------
> >> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.=
19589-1-alif.zakuan.yuslaimi@altera.com/
> >>
> >> Alif Zakuan Yuslaimi (3):
> >>    arm: socfpga: Consolidate dram_bank_mmu_setup()
> >>    ddr: altera: gen5: Add DRAM size checking
> >>    ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
> >>
> >>   arch/arm/mach-socfpga/Kconfig        | 21 +++++++
> >>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
> >>   arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
> >>   arch/arm/mach-socfpga/spl_a10.c      |  4 ++
> >>   arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
> >>   drivers/ddr/altera/Makefile          |  4 +-
> >>   drivers/ddr/altera/sdram_arria10.c   | 34 +++++------
> >>   drivers/ddr/altera/sdram_gen5.c      | 64 ++++++++++++++++++++-
> >>   drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++=
++
> >>   drivers/ddr/altera/sdram_soc32.h     | 15 +++++
> >>   10 files changed, 252 insertions(+), 49 deletions(-)
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
> >>
> >> --
> >> 2.43.7
> >>
> >
> > Hi Alif,
> >
> > Just a small question.
> > The size issue for the failed board in the last pipeline test is unsolv=
able?
> >
> > Thanks,
> > Brian
>
> Our approach to this SPL size limit to these Gen5 variants is to disable

So simply speaking this is unsolvable in the first place.
Those boards that failed from first place have used most of the ram size.

> the new features on these boards via Kconfig. From my experiment,

So I think the new features mean this patch only if not wrongly understood.

> enabling any one of these features on these boards will result in SPL
> size limit error during compilation. With the Kconfig guard set in
> place, only the standard reference CycloneV will enable all these
> features by default, these Gen5 variants are excluded.

Well at least the working ones are able to use ECC now.
HW stability improves a lot with ECC.

Thanks again,
Brian

>
> As a result, these patches can now pass the pipeline test. Refer -
> https://github.com/u-boot/u-boot/pull/932

Hi Alif,


>
> Best regards,
> Alif
