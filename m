Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97783C48291
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 09:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9CB88771B;
	Mon,  5 Feb 2024 10:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHpPkJyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C488771B; Mon,  5 Feb 2024 10:35:22 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C978770F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 10:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-59caf51d4bcso411276eaf.1
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 01:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707125718; x=1707730518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4/hubrcJ0ffKjPwhNp2qftw8xlf+fylvsk9a1t0TTG4=;
 b=QHpPkJyY3cGZAt+mAbC7RHYoxDEvjgQDxkdpvA6Hpq+kP2jYbS8+dP6l8CbABOmVs8
 egl6UxGnGBIKcRfVu9MZcVm8CpcZL+/9ubk5HUpnAKKEwsv6KmQzALEKduExmDsR9++e
 4NDlP5YxVBLP5XeUmkY/7M6OQMXZSyuzwzIgq0wnUNwRdnyiOdSJOE1m+QzVfciQY040
 VwS9jUq7ncRgisfrD69GFl/A1Bb2XGExUfMA6LnbGicUQfne1xVgU/rlh4kcc01qBfn8
 nLXFzk+SZd0Ug5xV7dGYHSKaubVEYVC9q7+bFCfaeNTA3OjB5FakRD6WHJs/qmBrWqBD
 9MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707125718; x=1707730518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4/hubrcJ0ffKjPwhNp2qftw8xlf+fylvsk9a1t0TTG4=;
 b=TZW47rMwLWFHNq1e2LCBHZnGB4UeJJ49Tbk5GiWfZUwQMp52yGVLW8T68tzrOFIFUf
 VW7r29JWnot5Rcwur/J5cS/jtc6VQYU+1DdOgA10d61g+mubuC5Dffcf1OYbbCsNiWsY
 je/NNk4iKAY6qZEzwhDVqdRD1eWX9C8igP1NVFuO/pa0duRPCLNrHRbvb/+/2MVeyPme
 vONap779Gz3z3vPBdIdOMKkt3vnt5TashK9MvUvOvsWFN8r8oJxtTf9x1kaaP8cYEfyY
 XXCobcaUDlfJUrOE8WHYvUuHwwFjUeogS4kuryTnF3jM+oitocOTmm2Ol1jfD76+CEc8
 HHHg==
X-Gm-Message-State: AOJu0YxlxV6oh72ZxPiOoGs8J9b3ukOvcRl9a+X+5/OHb1AQVuD8oVEq
 6RTAgJAWWMfJYx9FFzFhJTK9HeE8KdQs0rodGIX0YYS85/vRhnaZTaefrfu+IzlJcdFPrl1P631
 6j8m3LRCqKAjMONGDdL3fExaFoV4=
X-Google-Smtp-Source: AGHT+IG8lvbr4WuigBouPrKk7MqrdKdm5ZhrvHpCfrYsEodnEjEfwCVJvZvL5Ay6owMjaWTPu97dK7ezElCf5u+BpWM=
X-Received: by 2002:a05:6820:415:b0:59a:1a05:3c9a with SMTP id
 o21-20020a056820041500b0059a1a053c9amr2605575oou.3.1707125718555; Mon, 05 Feb
 2024 01:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20240126125056.16439-1-stefan_b@posteo.net>
In-Reply-To: <20240126125056.16439-1-stefan_b@posteo.net>
From: Minkyu Kang <promsoft@gmail.com>
Date: Mon, 5 Feb 2024 18:35:07 +0900
Message-ID: <CALrBrZ2k5ZyK7C27gnq+SfaLAo=VfyR4XVm-7PaBfeOFnf2j5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm: s5p4418: fix relocation
To: Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi, Tom.

Could you please pick this patchset up?

2024=EB=85=84 1=EC=9B=94 27=EC=9D=BC (=ED=86=A0) 05:03, Stefan Bosch <stefa=
n_b@posteo.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Fix relocation of u-boot for s5p4418-SoC. I.e. use __image_copy_start
> instead of _start to calculate the monitor length. Furthermore use an
> adapted version of relocate_vectors for the s5p4418-SoC. Background:
> The header (NSIH) used by the 2nd-bootloader (included at the begin of
> u-boot.bin) is not loaded into RAM. Therefore _start has to be after
> the header and therefore is not equal to __image_copy_start which is
> at the begin of the header.
>
> Changes in v3:
> - MICROBLAZE has not built anymore. Therefore do change calculation of
>   gd->mon_len for ARCH_NEXELL only. This makes sure that MICROBLAZE and
>   other ARM-boards are not affected.
>
> Changes in v2:
> - Cosmetic: Fix spelling mistake in commit message
>
> Stefan Bosch (2):
>   common: board_f: change calculation of gd->mon_len to fix s5p4418
>     reloc
>   arm: s5p4418: fix relocation of vectors
>
>  arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
>  arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
>  common/board_f.c                      |  4 +++-
>  3 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S
>
> --
> 2.17.1
>

Thanks.
Minkyu Kang.
