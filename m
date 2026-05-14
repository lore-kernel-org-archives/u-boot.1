Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE0BCD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 00:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD598341A;
	Thu, 14 May 2026 02:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hi/rL0un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B099583EF9; Thu, 14 May 2026 02:41:59 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967B0800AE
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 02:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso5873324a34.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 17:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778719315; cv=none;
 d=google.com; s=arc-20240605;
 b=V9Mm8txhNZ5AFaUkifqYgAs4RJrDLVa5E7n8uVH5JatyxmwKEXenHZV3sn0sfCL9O3
 za06L9VGA6edstxETRbatg/mHlQKJHg5nE0n385GwyRH4Me3PBfRgCseJ3nUWIuZUr1B
 NRz9J2A6B7xEmXtFn3DUtwH2cqsgK7GOUNlHUEfq/933++Jrf5cwIFzYp0UlI5Ha4J+5
 ZDazDemxkm7k0yZxL0UXSLzwf+U9zXJXKavK9YgVmxu0lY4K/NW0NVyguxcwyuE3+mBC
 d2/qECkPiFmK9D373LC1DaQyoLc6pb4vJ5vN3ybx2NgdO88g0jUXGlCsENuZ2ykX2wB6
 Kg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uerBmCjkGBOWoHxdKjPbNgt6BdkvHWz91S6tASNOR6s=;
 fh=gY8vf0MZ/WI6+etoEbv8Sy0jtSRnd/4dp1m+lysTAZo=;
 b=gDcELf9z9Kr1krofNlD2OSPF58g+HWMR0dyF5j4u/UyHhUd07odbVbB/Mtfk759zJr
 YSsx+QG/SKgRISoekcbRzU5XfCnDOJ8Zi9l9kFpbfEug8bJxenhenfwSd10LQyKrMlLR
 MYZTaIZhkO2bndvRPVXc7oJeHIGNFFBeFC+8JUTi6AvoiDWmvfUQvTVqqrS19eVIur5q
 0BwwsV1248zDUQxwgtwTjIRqYy8/T3x+iWhmuoNof1fll85hmjJAqijnSvMG8XlouL3c
 TBxuJNVWGWeyTUx1mvqzdfGGytJegd9OipANIejUgsp+j2DFhDThaTP5LO9DBLE8JV/o
 cdGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778719315; x=1779324115; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uerBmCjkGBOWoHxdKjPbNgt6BdkvHWz91S6tASNOR6s=;
 b=hi/rL0unffX+hy7xbW+7OYmD/dytYa0l/LmamAe1aoMQwubZR9+0KfUM9fF2Rc3FjM
 CTWwDkd03bi/iBfC9rSpDWlPf1GSn1ZZUSQ3W0M9T3/vHGkstcURiWE3uxZPxjwX10fP
 IehM5xiXmFj4qOeALxEslFe44hu+2hR1xZ8IN2VFc7GVaChS5mo3S5L2cdS6MieNjW0m
 cDf4+9acNFPkf8rAja3eYic9zWeVJOcJO6k8FNTIeHY5c1KUtv4ThfCLPv1GLZrgXZ1z
 A/OEdgRReqHf88CF+5hJkWplwLT8aMuqDzt+g9IF37bzRl2a4Z1M4KdH/Vr1lHtzClJc
 gV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778719315; x=1779324115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uerBmCjkGBOWoHxdKjPbNgt6BdkvHWz91S6tASNOR6s=;
 b=Bb5lIbtRFzM6zKrlIn/SSGkfDpieiMYlVFoLfJNsqhhGjjA4SfRzXuIjIV15mSkSwB
 rB3nsoS/I/KDNiG+NVXkXVGLc64MnkFulT4PotZ4+aKznYIuBfuS6K/ZAeE4TP6QWE/9
 Yvgj9CHR0MZ3v8Y8jruH/LoKwnQr0gUU9ZKBdE9ITev1DWle1sOhoOvA2/K2+1Lw76Pi
 XLoHCZf1fFZASgSHrP+3/ygbcnbFMQzwMo/4RPPVLSJzZ72o0wqBJjIJRBPXJN5ExNWR
 qkFsfOuT1H3QSZViPMjq0Eqxe9qLqmce3Hq0ddjARTjMOZfDRirxGjf7yooSr8iEhKHC
 s7eA==
X-Gm-Message-State: AOJu0YyE0eoN3GUqiNuSKGZd6PJoqeAwdxk2xwpO3YDx/QkpzRWmGyR0
 zbafGIZBrzJ587t9oOMUjZkv7uXgk5Toq3VfoxIsLLxA1KXV8G0vE9opwc6rzzydVLfuAyIFT61
 lCrR4xqKA9hBTMClv7HM7nEWbP1w4rko=
X-Gm-Gg: Acq92OEEIRwgUAy8DKwG/BXWEURoFF8M696hYC1M9awKb/Q+BDnXEiSwWThqIOOT3qu
 Izs5BtW531xSTrGoh9lWVHnkiiAPC7R4HY0Sgtc2j7eqiFbt/4G0LhhTy7iWCeivstGVkULGIAX
 yFIpCLkdn9Xy8AiH0iGWDukLIAM16lupJIsacZw2JQ3HdMqdPlAnTZge4K+txkaqxR/GzhypUrd
 cwRxx576t93YVDoE9tXHPwjLDX2Pj6CT6l/3SY+cLaBvFRP3mn5gzXLj+CTrF9DqCoYQD7W6Ulf
 Tdjlc+8Falz7MHA2umY=
X-Received: by 2002:a05:6830:264c:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e3da789f06mr3474513a34.24.1778719315395; Wed, 13 May 2026
 17:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260512064957.32497-3-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 08:41:46 +0800
X-Gm-Features: AVHnY4JlEVOMTb76zuLO2zo6Hyu_llkWALZZfjPZB2gz5twHwxNf5EoqmPKDw14
Message-ID: <CAN7C2SATruUN_BTaX3fv0+AVu7U1X1ET2WZU0E+7aABbEvgtcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ddr: altera: gen5: Add DRAM size checking
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
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardwar=
e.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> get_ram_size() uses size from device tree. So, it has consistency with
> other device families.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> CycloneV board as this will increase the SPL size which will exceed some
> Gen5 devices' SPL size limit.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Move the bdata declaration and gd->bd =3D &bdata assignment from spl_ge=
n5.c
>   in patch 3 into this patch, making this patch self-contained
>
> Changes in v2:
> - DRAM size checking is set as optional via Kconfig and defaulted on only
>   for the reference Arria10/CycloneV boards to avoid SPL overflows on
>   size-limited Gen5 defconfigs.
>
>  arch/arm/mach-socfpga/Kconfig    |  9 +++++++++
>  arch/arm/mach-socfpga/spl_gen5.c | 11 +++++++++++
>  drivers/ddr/altera/sdram_gen5.c  | 27 +++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)

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
