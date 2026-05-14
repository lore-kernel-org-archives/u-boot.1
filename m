Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADEDCD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 00:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5846E8341A;
	Thu, 14 May 2026 02:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XU/0AxfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A75844BF; Thu, 14 May 2026 02:43:10 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AEA800AE
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 02:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea20cf21aso6741166a34.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 17:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778719385; cv=none;
 d=google.com; s=arc-20240605;
 b=dciTvAV7sR4wQY8R3FyBVEBUY/qsGKTb3AIk9Vym1eGkQZL/T/kSyw2TGBshDkpSGh
 XdMMsc5tcFkjYYRvH2GHRGbKS30NReZ3CMz6C2FfHd0Wqg/G+ifcTEkuyeYs7qo1H2mx
 1wBVydqozw8oux8YS4lQwFNv+bzLhn8PphfajkIv5lFANNf6H7CLiGlNOvTDWmImQ6ab
 2fyeZrszyVwxWNqT7nLJGrcj9jcY0ygJzPNSgZsCDcCa2l3uPnAxf3mcnVWVv91359ji
 uG4TJUdMsaxAMZF0zpX8C3mhUlC5yiP38IuwqDYavCfrFjN/qY6rARX3J//gQoqZhqQI
 FI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QnkMexhOzGFMQx34V5c/ZHCaiiYNYuOjpyZJPd7tLzo=;
 fh=gY8vf0MZ/WI6+etoEbv8Sy0jtSRnd/4dp1m+lysTAZo=;
 b=KP0iWX+a5TNgmUFK8c5js9ewHIGgZnuQiHVm0upuMAPzBKci7U/EFSXNI/msW9HA3Q
 2hOHG26AE5BTUoDqzwadMe5GxTCDoY0biAwhUghNmkXSpgwWnef9iAhdTUPicg22hWqa
 MugbD6e0oQYCOcr6/2M44Jop5sGsqsfgLusoYb7s1bDqBHmXCABTI9AO/5i5/tvnewqG
 9CX8Kq0iCASS53Sp8BcBKx1lp7z4jDXJPIfyjz1G4AMULMWCEgbxvKKUfQYIJR7lPbue
 jP6qasTKR0yFMyDiAhRQH9Cr3cGu17BcRknRsgSKeXEA24709QiEzHqM8NfbBVxBnhCZ
 5rkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778719385; x=1779324185; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnkMexhOzGFMQx34V5c/ZHCaiiYNYuOjpyZJPd7tLzo=;
 b=XU/0AxfVwUnNTo4l0pbmE32bHCuu8XOhR2gnEZ2z+qPGuPsPozw+Sr0bP/D63zVgrn
 SzYGBQB0MnhNWnAiJ60+evEpn1tu4638ZNzrYHrLg2AC3WzJYyQoNdVLVq+6RAUZDlmn
 FOBVB6Go8NL6nrgKLvdzqqHE9eV5O89VguI+0D4V4ZJLWcMFOk+FLouacddCYyMS04hr
 7f2zs7XmbUto3y+ThWUtbB3SKFcyYcOAbvfuwedIq37MC4cbVAlgqN2x/3JIexlj89wu
 ERIJk63zejtjw21iNRsxijVMvPvxZywaotLYmC54nCI8//Q60gSoCVUdLQZrs9597Nsd
 vKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778719385; x=1779324185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QnkMexhOzGFMQx34V5c/ZHCaiiYNYuOjpyZJPd7tLzo=;
 b=ln1et6kcAp1rwC9q9QJYlrfkmE8ud7cb7WHSbN5KDWrYiFi8X26GOqIVQ7ZRJ0RKKW
 h9fjgm6DRO5E3O4FdSka9sHvU1KJQSEDN0xENcmryj23/yJp9hsNqxW5YldONaYqWeZN
 3VA/xR88Bre4shU6xCOsxFK5w4TFuKZzUOdkRwC5oGturyW4rFe5SKL3ddcoY0U8VTh8
 N35gloBBUd3M8zxExRBa6B8xWXsnEc4B9k9oCBQttTe9e80C5jnaoHiDbCL53J7kTSYL
 jmG2kXt+uBu/GrhhnZgArjPkaInblgYJxzkWwFOX2PK8+5SyDi189cxDGjnUOi+62zno
 c6+w==
X-Gm-Message-State: AOJu0Yx+Hzqd86dlnzLDzj6/i+5vqmVP3T99zYCvHgJvyHgVuJa3B3t4
 Xu1EwaOrvn/wG4oI6qn8/J8X/tS/m6jBbhmMtX17RmAfbjsE/+c342RbOSFs+drf48pqkKmIdzL
 3GcwSjpT6GKlBtnT0ToLuBZBTvH13He8=
X-Gm-Gg: Acq92OF+xSHQIRcdzE2mCSlvIFRzF1Dtaul6IOKDDlTgnK/mUGcfe7BZzGWvtZFto2c
 2Zfd8iSDu3B6r/EGF02uGBpXEA9PkdhbtEyckzvgfqLqWaDDtbednjQd4OtMhEi08ZW8Sh6I5xT
 4/WniTIiuD1wvc/HtNO/aGPeQAOKWb4oZkRb9xk0py3z0I7XRkXt6oj39bpR8lCaqg3jb1RHmuR
 ZiTMP1w83E0Yua4pWzOPt4qi+cdpUui3Xl13eoZWxsvEqthAKHDFNW+JpPYMhaaTpyeT9Aygdj1
 McW7/Fle
X-Received: by 2002:a05:6830:630a:b0:7d7:4002:1f21 with SMTP id
 46e09a7af769-7e3da4a0b91mr3762184a34.20.1778719385334; Wed, 13 May 2026
 17:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260512064957.32497-4-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 08:42:56 +0800
X-Gm-Features: AVHnY4IBgh79T0_uai8xHZGQafYnmRvfxpIGj0U7jlxuzDKRuFXJlyhTn6iOrZA
Message-ID: <CAN7C2SBb939Ux-k1=9A6T4aZCjKijGLcFnQpUSVciyXwii3eWQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ddr: socfpga: Implement ECC DRAM scrubbing support
 for both Gen5/Arria10
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, May 12, 2026 at 2:50=E2=80=AFPM <alif.zakuan.yuslaimi@altera.com> w=
rote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable ECC scrubbing support for Gen5 by moving sdram_init_ecc_bits() fro=
m
> sdram_arria10.c to a new common file, sdram_soc32.c which is shared by bo=
th
> Arria10 and Gen5 devices. This makes ECC scrubbing support no longer
> exclusive only to Arria10.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Updated commit message
> - Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Ar=
ria10
> - Dead code cleanups, indentation fixes
>
> Changes in v2:
> - ECC scrubbing is set as optional via Kconfig and defaulted on only for
>   the reference Arria10/CycloneV boards to avoid SPL overflows on
>   size-limited Gen5 defconfigs.
>
>  arch/arm/mach-socfpga/Kconfig      | 12 +++++
>  arch/arm/mach-socfpga/spl_a10.c    | 11 ++--
>  arch/arm/mach-socfpga/spl_gen5.c   | 10 +++-
>  drivers/ddr/altera/Makefile        |  4 +-
>  drivers/ddr/altera/sdram_arria10.c | 31 ++++-------
>  drivers/ddr/altera/sdram_gen5.c    | 39 ++++++++++++--
>  drivers/ddr/altera/sdram_soc32.c   | 85 ++++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h   | 15 ++++++
>  8 files changed, 172 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/ddr/altera/sdram_soc32.c
>  create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfi=
g
> index b814e034ecd..dd71691b724 100644

Tested-by: Brian Sune <briansune@gmail.com>

Testing environment:
- Latest repository
- Custom board 2G max capacity SoCFPGA Cyclone V can handle.
- SDMMC Boot

Both cold warm reset shows no issue:

Boot log:
U-Boot SPL 2026.07-rc2-00016-g36d4c6535808-dirty (May 14 2026 - 08:24:01 +0=
800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1053 ms
Trying to boot from MMC1


U-Boot 2026.07-rc2-00016-g36d4c6535808-dirty (May 14 2026 - 08:24:01 +0800)

Thanks,
Brian
