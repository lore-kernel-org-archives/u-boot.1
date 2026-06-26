Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826C3CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 05:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9865E8460E;
	Fri, 26 Jun 2026 07:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FDTFe596";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2E2A84704; Fri, 26 Jun 2026 07:44:50 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE53E805D7
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662c360aa73so638761d50.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 22:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782452687; cv=none;
 d=google.com; s=arc-20260327;
 b=Edo67TUopvc6WVIuxJJ0rTGTm1wAWC+EzARGA8pJRK+60HLYogsyJJmChpptTL4Atn
 RfifwMAZXb9kZrUouliuZlJLDMMctgqMkLlaXO6LO7JugPX7bNwltQzg4VhmQ/wSBCkx
 ZR7PR+ASqj4S2pg+q/5rDFAjvtgCQqlWRfFwj9cCaxpvVlnmfaMOdGgIlesEL/2jTuk/
 d+VY/vvt3XHBdj16FahtEG2pw16UkGZdvQr4HWlMLcIRSzcwfOzRFijDBoTGROe2ULmg
 IvdT6+TnAdZUXa6JoRdOTGCaVHDIfeVCz92lmiobq3flIjl3QdrEhoNoOQHvS3rZ7FAK
 xJaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vl9QaidoWVtEcPNE67uAvqi03P0zNBAeF8m4fhxfpKw=;
 fh=ENdvZHR9MUZ2Vy5+c1PYyd/+74ufYm4ybD/rimHwrkA=;
 b=Q+P6C6nsp1x8xNEvlabdCe84EoPY/y5ZlXizLPNikH4GKaSqVNNBcQQVSz2XF6LVfY
 wWbzzuxxikW4h1FDaJ/MNRddaC9Tn5gHdRBbXPtVoOzmBwRJcFimWvqPLxEwymjvdG6l
 SchxdIUhOjwae75fiKdbhNn3iDKUCbDx+tOBm84g079YO//rJ1qxxxO5exSjx/x/KMo+
 Ko2O14c7f14dn/ostQsd78vFzwM+u+STWBd0yoOnCB5fgkE2eg3JjWrpyYlL2Or31/fI
 u4xVtXsKoBNzYePoQOKTSq52o9t5s0yWatLKK85vATiZOt/3E0mI/LGx0p2BmAhW8S17
 IrhA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782452687; x=1783057487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vl9QaidoWVtEcPNE67uAvqi03P0zNBAeF8m4fhxfpKw=;
 b=FDTFe596eBMsfCP2yN2QddNcjBZN6PP0DLiuoLb3Y7RxvYF5KUaT0pp1AlyP0d8TD/
 9gYSI/SDfhuV/Qm37QY2yueXf4WoDzxdNfrPjQTycjKO/3nrHBXgFfAAAXAj8VsvkqGR
 QAswPLLINbmQ/jGk7cJpM2ODVE12Egqruc2fUa1unWVgarwGGqGXKYp08E4F4V9BScrD
 SZiglE58KQOrKiVFG9SLeYHD8AOlqb7L36+m1gprtaF8dcmkAvCe9WthDMT6oTczj1I8
 6D0QeRCyFaK3aqF1WA1TPa9MQn8bT8+xsQoJyIJRIpJ+2kAgaotis1VGqEoTGX9w40QM
 lSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782452687; x=1783057487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vl9QaidoWVtEcPNE67uAvqi03P0zNBAeF8m4fhxfpKw=;
 b=HQ4af453AueFwaxCLSfLb7HDCvIzjIjWNLmQuNTfhxNabr4MyOvoOfYOV2M9F/s2t/
 u+nI6m56Q6OKeF8Qm1SrwuE0/G9aDjUEvfi4ASmubLipVHh1cmUYgpFNjrM7x/s4YKlf
 5YVASAtB6VCvwBHn2QKJrfg7dG9I7bPBS7DnZ6Y16I3zV3Q5GSVluHMILknxrchzE2pL
 1/nrYGc8s/jKY9z1sigy0lXUC9KgradPINoFWDlNS9GnOlwal/+NRl0zR/XUzxwJbNEb
 9pqRpppn6rVE2wne1hlIGJAFoauJq5S8Hku7zxru5rTWfBMbhWPLF2yVMIi2ayzV0b6N
 4KCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTnoqJewO4AZ1hfSxFoXASpOlJCBvXbp6sVxHlE9Am/gUgmp8FRGaR+9Js2XtJXcq46ha4kCk=@lists.denx.de
X-Gm-Message-State: AOJu0YwQJYR5F/pLI+f0/m+SdqWivtOg6AIM/vIocGbY9kG4+zG/lsQ6
 b3fkhVvrf1xtK7VZrUINp/OQbXIaadcIrKBYXo80MzxUa+xThsCjuueDLQxmWakN5vYIomFidMH
 qHD8Zqe670Cmnjwufc8lAqVMu1aWzpAJf8AvLYQraEw==
X-Gm-Gg: AfdE7cnxPJb9nJIZmgEZsIopjFD/DYfN+5ZYcuGSLvGjkVBZiNSkM6hQNlp9S6uZpmx
 5Q922ACh+yRVbGh7lPiKrycMeObHBhs3oGSwd6QIx0dS45ib5mhAIqWtGqSUK188r89XkCe+qhM
 Gm/vrSBZaqbPaAYr2aY7nHW/dwv/+B3lEDOqj67J8Xo4biXSHuQ50/Qx5yDYBe1lY6aREhSihGg
 30NZhqv1qDnYP/eSNAohMwaGQ6cNM06OvV37o1GUWfRvaDNqUqAURqkd15P8dmETT+d7Tb4X1WO
 VLZpXkRPLFgig7ElSGOI8QubSgMZxWE0MQspxZWUAuLtRiQNHNdFtmsl6m5umYKFKVsBo2jp58X
 fpj6kPGosRJBRTKy+J7dv0kwCBAHih73Jtzt65urKPAsW824vxHPAsIXRX93P2m2h6SwrH/hcMP
 5MLqTeiO8GLmdis2tjfrAizZTEyMHP+jlgYLyWcWR1EPkso3o5lJs/wXccYE4p47tIzemWEI0qk
 tkEeLGR61gMP+O2XPSOpuAbF4dfUzZPeUFDxDQLNQojkwd4APNSOJtknX8Ymthetcon30sjqqHu
 c14m066nG+cJ2IaYNXrUVvQRH99lRDxkjrkSS7Vg1jG91T0Sfa1ZO5SKPKhUGyCjhD34QX2wspx
 1tVGrjA==
X-Received: by 2002:a05:690e:1487:b0:664:8e4e:66fe with SMTP id
 956f58d0204a3-6648e4e69b3mr3812017d50.12.1782452686620; Thu, 25 Jun 2026
 22:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
 <178240070996.3860609.12716856774955880596.b4-ty@konsulko.com>
 <a4e4e3c3-0236-4764-abba-cb34e7fd0200@kwiboo.se>
In-Reply-To: <a4e4e3c3-0236-4764-abba-cb34e7fd0200@kwiboo.se>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Jun 2026 08:44:10 +0300
X-Gm-Features: AVVi8Cdr9KamvrAC-LzPflmzT4LcullSV9rsoJorPZVeaTwpigmvioUIoOx8a6g
Message-ID: <CAC_iWjKq0P5P2LkB+f1EmGQ71oWHJQYwL28=n1-2yivyTYdYng@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Relocate U-Boot in the last bank
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, quentin.schulz@cherry.de, 
 marek.vasut+renesas@mailbox.org, anshuld@ti.com, sjg@chromium.org, 
 christophe.leroy@csgroup.eu, u-boot@lists.denx.de
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

Thanks Jonas

On Fri, 26 Jun 2026 at 03:32, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi,
>
> On 6/25/2026 5:18 PM, Tom Rini wrote:
> > On Wed, 17 Jun 2026 10:48:18 +0300, Ilias Apalodimas wrote:
> >
> >> There was a discussion recently on the mailing lists regarding our
> >> management of memory above ram_top [0]. The tl;dr is that we have two problems.
> >>
> >> The first one is that U-Boot always relocates to the top of the first available
> >> bank unless there's special board code to sidestep that. The second is we don't
> >> successfully deal with devices that can only do 32-bit DMA.
> >>
> >> [...]
> >
> > Applied to u-boot/next, thanks!
> >
> > [1/7] treewide: move bi_dram[] from bd to gd
> >       commit: 1174c99ab421168221be372bd83a4143bf5f167d
> > [2/7] common: move ram_base calculation to independent INITCALL()
> >       commit: 15b35e4289e11f1ab201701dfb6dc0232b30be48
> > [3/7] common: Clean up setup_dest_addr()
> >       commit: 0943f107ce4adb47d4b01c06e046dce130a1de50
> > [4/7] rpi: Add a local get_effective_memsize()
> >       commit: d19d9e1c064b6c782959d1da7bddf1e9da1c55d4
> > [5/7] common: Add an option to relocate on ram top
> >       commit: 55a34217698491cc0bb8d53d630644dc8756629c
>
> Ilias pointed out on IRC that Rockchip boards may have been affected by
> this series now being merged, and where correct.

Yep, dunno how I missed it before. I checked dram_init_banksize(),
get_effective_memsize() and board_get_usable_ram_top().

The 'good' news is that rockchip is the only affected architecture.
>
> The move of dram_init_banksize() before setup_ram_config() currently
> breaks Rockchip boards in next, due to gd->ram_top now being 0 when
> Rockchip variant of dram_init_banksize() is called.
>
> DRAM banks on a RK3568 8 GiB board (RK ATAGS not used) using next:
>
>   DRAM bank   = 0x0000000000000000
>   -> start    = 0x0000000000200000
>   -> size     = 0xffffffffffe00000
>   DRAM bank   = 0x0000000000000001
>   -> start    = 0x0000000100000000
>   -> size     = 0x0000000100000000
>
> expected banks prior to this merge:
>
>   DRAM bank   = 0x0000000000000000
>   -> start    = 0x0000000000200000
>   -> size     = 0x00000000efe00000
>   DRAM bank   = 0x0000000000000001
>   -> start    = 0x0000000100000000
>   -> size     = 0x0000000100000000
>
> 'out of memory' errors are also reported because of the bad bank size:
>
>   Core:  632 devices, 33 uclasses, devicetree: separate
>   out of memory
>   ERROR: Out of memory
>   MMC:   mmc@fe2b0000: 1, mmc@fe310000: 0
>
> I am also seeing following, not sure it is related or a different issue:
>
>   ERROR: reserving fdt memory region failed (addr=10f000 size=100 flags=2): -22
>
> Current logic in dram_init_banksize() require the final gd->ram_top to
> fully function, hopefully we can find a workaround or try to rework the
> affected code instead of having to do a partial revert.

We could call dram_init_banksize() late, as we used to, if the Kconfig
option for relocating to higher addresses is not selected. However,
I'd like to find a better solution.

Thanks
/Ilias
>
> Regards,
> Jonas
>
> > [6/7] configs: Enable RELOC_ADDR_TOP on arm64 QEMU
> >       commit: aefd4a769bb6727978c408ff24b93ba9047d535d
> > [7/7] doc: Add a warning about using RELOC_ADDR_TOP
> >       commit: fb537c85bca0e3d29a62fe119181bf1744b8c91a
>
