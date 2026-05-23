Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A32CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94D4846AD;
	Sat, 23 May 2026 11:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZLAsw614";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41928846FD; Sat, 23 May 2026 11:39:11 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CCA84659
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so1186453466b.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779529148; cv=none;
 d=google.com; s=arc-20240605;
 b=eVhjpe1KUSGNIEdoUnMHUfOZBiPOPzlHdQ76PRe+QR5hIOmdPD+ZM/z3/Y/BOG66+v
 dWleTGp6zFDpfIcpLJzp2n6m0Fpt0Xd+CTM8etUkz09bQ++1aSUruh72Z8cxf8CfhndG
 AkVc3Me7N7GD4Xuq1YfTkWseso526dSRq6gkpjNV7RfzEwnn7vKBTTrf6rkwV9mUWxsi
 VrswgNAeXn4Yvg2PHxdrgxkpT52r2a3Zj4VbIzpttKsMkTcJmMOu961ZT8H64nmaIGNw
 5tilDUVnnV2pvEKX304/lvY0prX+eyZ8/qLm91jGWjFKFIpGjRIBd9YeqsLixIAQt8yM
 BUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oLpyAT0PIsPXXwTMIKGR49d5DA44DjsYOSxydP7AYl0=;
 fh=KG4xgT0iSq01qkk8xqPb73byZ1iUTqraBOjqvaTh+Bc=;
 b=A251lbgyMM1pH/O0VJpICwJOluZYlHrVjU5cTE8MZ+77N/mg4SnqMQ9owVWm0TVQSk
 cQyJ/pvdECEMgSeNWoRClP4kCRGSEb/TVMSkPZrHn/qyOX+e03IObyihbPENfHwTp9tK
 hB3vMhwfWoB3PfAS9loMao3JK0jNnvTlVhgJJI+YNUm1HIEmVsx3172q8PGivE546cBm
 yhzu8Xk+yPF+ExwfJLrjND9ar4UidA5xVkAVZTxM+gQmpP50MhWNXTZK4yNdNDPaR8rj
 pvEsiUl5dqYUju4hgoXr8gH4NEZ8APRy035Sjuon1immFVD0rCjGnN6+B2SFWiaaUWZU
 L4WA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779529148; x=1780133948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLpyAT0PIsPXXwTMIKGR49d5DA44DjsYOSxydP7AYl0=;
 b=ZLAsw614onTmWfMbIdr/KpmAA2qO7RINNzLMzxk0eXgPC7tHVH6FJW7UOCokIWTHKi
 7ATXNuqxLvL2jmbPvtdf7G+tXwUPf/PCDwqv0s7ZWPIjrtShuwTFYbX5Omh+YkcEfoMp
 3xqALNbXULoNnTCxP2hnkjoV5pPou6VhPaDYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779529148; x=1780133948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLpyAT0PIsPXXwTMIKGR49d5DA44DjsYOSxydP7AYl0=;
 b=mW61Hx/PPkymsDACDKP4aWSZ1gyUukqiyyFZCSkd0Up/Zd5AfwVA8QrA69IRrYLdmA
 R7vfWenSZBbqC3DbM6cRKsjdpS1hQAOoOoJIBzqYfVZfX9K2z+aBxyvCuLeD1KMjwH3y
 0CzpqueXCM5wWjbBtKMgjZublza9vHUJHn50wGPFPTjjdPacMlw+nsmnddC7FxkMK5hU
 iyLZHCVotzgri6eC5n6MI3t0WPiQ6xUfMzeJ6NKUMbEJ+PwqbJerRMlju4j1wrShXi6N
 hp9P0T9d/PssCVaTVKCdGOiJV1tGuiB3Hu+CuenJ2sTNHJrKuP421CMGwoEVK/4JKvRg
 G8nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/J1ZpORntzyxeOMIMpVFbYKEW/XlI8x5BXst3zKPWOKAnjO0ugMFkSNd8VaMsDUxT2QQgv+lQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx96ROqch6G8XpoBDrfcNnr5Gtxtc4ZPLAmdeuHglfLHjIOBIRI
 Kk/44aSwaXdcykXEM639b2jIdsRIgxIJ9YWGb3w/yv6urK9cSHknpKnp74OKLq/SlNxHeTplW3U
 f9xajKWFakq4MYHesF656KKC4qpNqApeNCgANFZOD
X-Gm-Gg: Acq92OHZ89beJdaXlMX+Mv6i4g0UMCswoi0/vUhVaOMwm9qc+yWU1AKbwP57KMK39Zo
 Lk+GlhFPMSnOH7sd66Y+hsHsGtvaiwUnx/LHUSYRQLpCvTjJmW4QTmnwILP8RN7n+MynjNRC+1u
 a7MT8fqt1Wr3C0bYNHQyO9i7sbWxHRMn0jlf/GcY6KFCVsuwZT+9tGD9sf+KNOjlGFwUtTn+IK7
 lzRxYJLumJm0coW6i3rE8jF4o5XWRF2duDVLfA8auNB9QhRbidrlEGEEff6ds+uYiUntqBaR+tx
 jVdksAWqKbp6YyZv
X-Received: by 2002:a17:907:d0b:b0:ba1:1181:b773 with SMTP id
 a640c23a62f3a-bdd2839b9cdmr426817566b.10.1779529147914; Sat, 23 May 2026
 02:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
 <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260521185025.30857-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:38:56 -0600
X-Gm-Features: AVHnY4KlKRZV3cUI53hBOraOIjKADpazIK6u0b_bL00iWr6UQ-G-aZlyNCYSaT8
Message-ID: <CAFLszTibYbHunqBHaVNZUkx3mo2nQfWq_S5sqPBog03bp90s2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: use pointers in efi_acpi_register()
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-05-21T18:50:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: use pointers in efi_acpi_register()
>
> Both efi_add_memory_map() and efi_install_configuration_table() expect
> pointers and not virtual sandbox addresses.
>
> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> pointers in memory before using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/efi_acpi.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)

> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> @@ -25,7 +25,7 @@ static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
>   */
>  efi_status_t efi_acpi_register(void)
>  {
> -     ulong addr, start, end;
> +     void *addr, *start, *end;

Making start/end pointers doesn't buy anything - they only feed a
length calculation and efi_add_memory_map(), which takes a u64 - every
later use then needs a (uintptr_t) cast, plus (void *) casts on the
ALIGN_DOWN()/ALIGN() results. Please leave start/end as ulong and only
convert addr, which is the one that genuinely wants pointer type for
efi_install_configuration_table()

> diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
> @@ -37,39 +37,49 @@ efi_status_t efi_acpi_register(void)
> +             start = (void *)ALIGN_DOWN(
> +                     (uintptr_t)map_sysmem(gd->arch.table_start, 0),
> +                     (uintptr_t)EFI_PAGE_MASK);
> +             end = (void *)ALIGN((uintptr_t)map_sysmem(gd->arch.table_end,
> +                                                       0),
> +                                 (uintptr_t)EFI_PAGE_MASK);

Do you need the (uintptr_t) cast on EFI_PAGE_MASK ?

BTW the use of EFI_PAGE_MASK as the alignment argument is
pre-existing, but looks wrong: ALIGN(x, a) treats a as the alignment
and internally computes a-1 as the mask, so this becomes ALIGN(x,
EFI_PAGE_SIZE-1). Worth a separate fix?

Regards,
Simon
