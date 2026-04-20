Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F266EA71BC
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C73283B99;
	Mon, 20 Apr 2026 06:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6p8F0gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C3083BC8; Mon, 20 Apr 2026 06:56:19 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD4883693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b936331786dso320636766b.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776660977; cv=none;
 d=google.com; s=arc-20240605;
 b=W9p2sXXBTSWxoCuRCBLKWTvJCEgCLLur4bPiKAxIRmoA02T2lrn/S7v/urewEFgRGJ
 PJ7QJihyOGjigp7KUa9aQL6KO6ZgZo6dOSwwTOOh/La2iiaajU7saWwFisvFH2lTYjEE
 wcIHgF1dxnaeNaZz2lZQm7IunTVJXEX7CVCiNPSLmt4e6CxRGBSee/IPXGUCTPUJY9GK
 QrdWTrT+FVBvslkbcGuf+rycI2fypEEZZJMlZiGlut68JKIMnH2nnX34KiexDwVvJK1U
 8TjLGfr09QQcbDFD+HhrxH1zfgdRSNwNbvtEKwaXpSRa9M7xeF2OoZhY3amuPGKTwdtC
 +oUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sr9hNCt1+ltTARbtsmpneXekMatSk6ciARBrzyJoKQo=;
 fh=BzNny66zVUeNeqRlM9a/rqRWUqgkGcPCEVSByT3bkxY=;
 b=g+Z4GDVpUHACeokRKmsVxrAk9HGjnpfdpqJdwRLrkjf5D+8NGivZQ3XUgElJDUnj53
 7V46pfMOqCNkc/M1KEN6CtcEf8+LHTTrUPCjBSEGCqEQiaeKymfAYKNaLRPF5BG0lu5h
 6wejvcFNUrt3tv1eOsuND3/g1Fxds3rVZVWl7jzubfIXJc5gPgoIaq5Wax5sRnKjZoNZ
 32RpJR1ztQ+fU+ke7EZiAHb/5kmuHpyqfZR3XSRc64VF4QF0z09SfL/1Q1C/ZoQLYLXd
 fQ+/DHmOQRDGOrTKBhh1eo62uhKpAtsUHYbTBkaU2ohcqv2ntK6RlNKyAXml0OVH59tc
 ZwsQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776660977; x=1777265777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sr9hNCt1+ltTARbtsmpneXekMatSk6ciARBrzyJoKQo=;
 b=c6p8F0gPpnIGY8vSGZEpvzVMoyHdT5a3DKdZSg8T5jrjaA0zIKhhSfG1u50fEb3wpu
 IgZj9v2hvtYCFoj7grXSDsLYZEAoyi8N4LNp9e9S19RnooP9bFikfG0RZkTT3/s0J3Dt
 irqgxN7z718CBzkBauMn77Yh1Maij5AMv7wzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776660977; x=1777265777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sr9hNCt1+ltTARbtsmpneXekMatSk6ciARBrzyJoKQo=;
 b=D7lBcDrjwBDkQIoBXzEjkrTwBIddWzajd+6PSbQd+TtnA28gyGA1+KXe6ILZKcl0Z7
 FG6m4YjMVifhLtlaM5GXTirqYAkNmzc+QP8HELo55dQIEkX5R/MLEF/DKv6cc9S1ipHM
 odXpNpDBXEDn1AvfvlLjnK8WZ20n5TxEB4V5CVhSYsX06OqmafG7DfvMKC3yk0nkt5j1
 3HGdYaXmDNJdepB4cALrNLLsxgttApuT8XKeWuBv5+Lf84EzcVm6/pMjlCtd5ArsBHMN
 WIpYeJ7JJTetRxyA1br/jwCTaLFzWhL/AMeLLuecbSWCK7DcIrmWatFbvCGpSI5Ow21H
 ttGw==
X-Gm-Message-State: AOJu0YzPWbd1rh5eDthp7J/RP7t0FLQDND520gpIH5NSvI8VZW3XS3Ir
 maFo5UeN5Eo2e/oKbB84D3A30Qm22Fjdr4gzr2FoPWWbVtsVRVqptgURzOpTLz9fqqW9O+cAT/C
 PEJeivb1kzsoniZjPJvDjIVp40hIuYgNd3npNbC4AJEWbGkj9pHC7ZQ==
X-Gm-Gg: AeBDiesoDcmSMgK1wJXb5Drfp3QmdnZ87peesoG8VQgPnohz0kA03BiqcrfcrBRXv+z
 n4O/n1n9R2biWkG1AxKXu2jC9OJThqfvERz04J7HeAISvvew7+FQsotaSN/gfpHh+jRD4dDsMvG
 sqhfBVeUJzf08Uk/JVnBnjKaOc3E/ieAM+ZX3kJ5SwzVKjjKX1FIEb2U7oJ3i8QQk3rPuU8kll+
 By3YX7EQrV3DMwdlLtb6KrnSiya6izlwWOh1AEFf8XSeZlmsPqsg7yjvrNUM5s/ywVX34LG5JU3
 cRCZAhtzxrqtxs7c43C5
X-Received: by 2002:a17:907:a0e:b0:ba7:d65f:3b2c with SMTP id
 a640c23a62f3a-ba7d65f4834mr87515866b.11.1776660976739; Sun, 19 Apr 2026
 21:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <732a4d19-0e19-47ed-9f8e-0f28b8c50f73@elder-tomes.com>
In-Reply-To: <732a4d19-0e19-47ed-9f8e-0f28b8c50f73@elder-tomes.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:56:04 +1200
X-Gm-Features: AQROBzC4L4RvDA-Qol3gLX4XoNFnc_7-dwOsH5Yp-hS6aL8uCdG44YhA3C5TUnI
Message-ID: <CAFLszThgqQ8yaMk=HZhQZLm05u3WnVKD0ZUOsKRjqtN+jiHpwg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix host CPP pollution in cmd_gen_envp
To: levi.shafter@elder-tomes.com
Cc: u-boot@lists.denx.de, heinrich.schuchardt@canonical.com, sjg@chromium.org
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

On 2026-04-17T22:45:09, Levi Shafter <levi.shafter@elder-tomes.com> wrote:
> Makefile: fix host CPP pollution in cmd_gen_envp
>
> Commit 2956a84 ("Makefile: don't use CFLAGS for environment text file")
> switched cmd_gen_envp to use $(cpp_flags) so that KCPPFLAGS would be
> honored when preprocessing the environment text file. However,
> cpp_flags also includes $(PLATFORM_CPPFLAGS), which carries
> architecture-specific flags such as -march=armv8-a+crc set by
> arch/arm/Makefile for CONFIG_ARM64_CRC32=y targets. These flags are
> appropriate for cross-compiled object files but cause the host CPP
> invocation to fail on x86 build machines:
>
>   cc1: error: bad value ('armv8-a+crc') for '-march=' switch
>
> KBUILD_CPPFLAGS already accumulates the user-supplied KCPPFLAGS via
> "KBUILD_CPPFLAGS += $(KCPPFLAGS)", providing the behaviour 2956a84
> intended without pulling in target architecture flags. Use it directly.
>
> Fixes: 2956a84 ("Makefile: don't use CFLAGS for environment text file")
> Reported-by: Levi Shafter <levi.shafter@elder-tomes.com>
> Signed-off-by: Levi Shafter <levi.shafter@elder-tomes.com>
>
> Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
