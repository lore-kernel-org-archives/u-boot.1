Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE215E9D408
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 16:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C77839A8;
	Wed,  4 Feb 2026 17:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CB7dU8YH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62ACF839DF; Wed,  4 Feb 2026 17:12:56 +0100 (CET)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52BFA80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 17:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-948ee050c4cso64333241.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 08:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770221573; cv=none;
 d=google.com; s=arc-20240605;
 b=G52qO9fgP653/pSgPSeTkXGBtx2EyONEBF5ij4m+VIno3wol3P7v6f52BCZEbA76Ns
 e9WZ2muhNVHGlE6snCAbJiSGeid8FcHiOR1/StRS9XkgNsbRgUMjqH3WsHKtzmRD8LGH
 VqjOEjNXEJD7W1uyY1uhyq+eDLruTczOIpPPLGH+OQvFck9gjnpOXaVmAoeOPpQZUrgG
 ruoY/DMGDVcFSOErd34hJHglW1oZH1dQ3ZRlTWOQOkQ2nLbKm89PYvYcy0votUcsY+ir
 7oDTeogZkvQwH0ubaio5yPiQyhyXTBZldO9UFSyntWokfk/zt8FoHx6zHqg7m8s8dT1O
 PwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VJxzbFAu8rA8hKECHX6zncbVra6A0hobegcx7YkFiTo=;
 fh=0yotbGGJAWvy75npfxhYR7GYOsHOaY7FWDLj4QhFbwM=;
 b=NR0w/lBwnDQqEZSI4XtIqS/ERHiK2bBdvh+ZpyRC7fXfQI+qB23tKImXUUJNvti1P7
 UWnpDlob2W+yffypIa2zUNlu/yLbYsV549qeYLTxoeP2HPVBSBVvq3u4b9zrRGhLdqee
 nCmwsQu0rDVt1rsWrh9afcA7ZZr5x9NRSiRKGmfLuy19P842ds6Cbo4nNnhsHYpzj0jK
 zB3FWIkQH4db+NZqcSelmDkMNDTermBG2YCksXr3S3dKQc0g59PCxrVCunZ4W1X0U/vB
 X9I6kc8Yw9og4RgSV1uBj43Oes6Ddh+bz+W4YW3DaVb2ymxhUlzpCzTtmnCrN8eDiV/8
 Ggig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770221573; x=1770826373; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJxzbFAu8rA8hKECHX6zncbVra6A0hobegcx7YkFiTo=;
 b=CB7dU8YHdQb28T+GV2SRZ8I1SI6pUS5PfOtUuWQojOD11cf6TgPI6Mk1UByJcljt3v
 tpvzdBbghjsNorrwmNv9Tx9L0i5+HJJdqGQ3vUKG1UN7kigq/vRlJ5J9t0adswCaUYJw
 6bYK6L5UfId7AUubk0gUbAkS4b+1oJOOXS40+KbYH8KUXmwdiFddK3RSkPbP5pf0xq4D
 PnKdLtUVvfXGLtjgAWsxH9kdU2QM6hgp1t/Ikr7+XLNGZsX+QZ7Fqn8ED6MmboctYjLP
 XF/Cvwvg4KfDppjjJJd2VufMpnAQPPck2/nhhf4LJn3m9I4wLL52c2Gnb056gDQgCUia
 vlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770221573; x=1770826373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VJxzbFAu8rA8hKECHX6zncbVra6A0hobegcx7YkFiTo=;
 b=LV6f5VlonEIrnKMH06RR5frxS4UPnF9eMFCJaN4mZ8n8L6F3kaAklRQpyJln9jDHB5
 2be7Qug81lzd2NevOSeVFua+cOEMukJJgqop4PRfvu4d358oAdSj9TvXQVA+h6LiLB/d
 JcRrYhghMt/G7yf5ShT/vPvxdr8lqM8btTEqUXCKY8Ur/hkEevfG2xhPIclzM1SdPb1k
 4tgiVILJF3b3H3cgpccWh/uidN2c/zr3MU+wRsQAy6Cf78SUKW8K8hrQz8CYOWiNCcHm
 ob/crlCdPBb7MNftmxWje+BbqTsVgRC85qZKBulRg8DqgkJ7waqS2/gPNxUglO5fAgqh
 z8pA==
X-Gm-Message-State: AOJu0YzFWlTx4k0Nukxxej4Q5Vprx9MfbzjoMketLAwbWpESyMUS4P/9
 p4tD1JrvlBKsqLK7djhbLE243tZMXL+fCz7oAW4h274v8MroEtucF9kMr8/vujrj2GSztJZ/Mho
 PVD/S6MuV43LNyDM6LY6ZZ9eYsBQ+SJ+wIw==
X-Gm-Gg: AZuq6aI/ZcjdgDXrgavqDEoo1uHhUEOZrIx+qZm2z2mc0w/pRdIFYr/vE7shHAV/itg
 7gVuTiXk99pw2/wPsUuF7fanCUDnSVwWyoXwVqCjFQ06CPw9cDw6TpL97rTQwGdC4Xs+ecNNoAY
 dztPPIFIfRn6agJUJjIX/b3TNvNWJ0nkPSJBZBhdQDXEk/RvXQ4oQzhC0O651elPhciJhHrZ4K5
 DgNoZ/uNqZFRI6M5hG6w77w+O/j+u7L24nOpFWH51lQRrUfAiGdA5N9DmTTYjtPFbGz0xHU
X-Received: by 2002:a05:6102:6d3:b0:5db:3c3b:7767 with SMTP id
 ada2fe7eead31-5f93a351927mr1172299137.16.1770221572883; Wed, 04 Feb 2026
 08:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
In-Reply-To: <20251128163535.2301653-1-raymondmaoca@gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 4 Feb 2026 11:12:42 -0500
X-Gm-Features: AZwV_QhibwidjiUEpNTVF0UBEGzT1MzdP_S5Y_Q24Hs63Nar4xCse5Gvp21DO2k
Message-ID: <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mark Kettenis <kettenis@openbsd.org>, Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Peng Fan <peng.fan@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Samuel Holland <samuel.holland@sifive.com>
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

Hi,

Anyone have a chance to review this patch set? It is the last piece of
work to support all required SMBIOS types in U-Boot.

Regards,
Raymond

On Fri, Nov 28, 2025 at 11:35=E2=80=AFAM Raymond Mao <raymondmaoca@gmail.co=
m> wrote:
>
> This series finish the last missing puzzle of required SMBIOS types by:
> 1) Fixing duplicated handles when multiple instances exist in one type;
> 2) Implementing the rest of required types 9/16/17/19;
> 3) Adding version control when printing properties for all types.
>
> Type 9/16/17/19 are generally DT-based, the idea is to write these tables
> using a hybrid approach:
> Explicit DT definitions under existing '/smbios/smbios' take precedence,
> with fallback to scan and interpret values from the entire DT.
>
> Moreover, all below APIs:
> smbios_get_val_si()
> smbios_get_u64_si()
> smbios_add_prop_si()
> are on top of sysinfo, thus allow vendors to get values from other
> subsystems by implementing their own sysinfo driver if needed.
>
> Raymond Mao (6):
>   smbios: Fix duplicated smbios handles
>   smbios: add support for dynamic generation of Type 9 system slot
>     tables
>   smbios: add support for dynamic generation of Type 16 table
>   smbios: add support for dynamic generation of Type 17 table
>   smbios: add support for dynamic generation of Type 19 table
>   smbios: print the properties only when they exist in a specified
>     version of spec
>
>  arch/arm/dts/smbios_generic.dtsi |   12 +
>  cmd/smbios.c                     |  365 +++++++++-
>  drivers/sysinfo/smbios.c         |    5 +
>  include/smbios.h                 |  151 ++++
>  include/smbios_def.h             |  250 +++++++
>  include/sysinfo.h                |    4 +
>  lib/smbios.c                     | 1152 +++++++++++++++++++++++++++++-
>  7 files changed, 1906 insertions(+), 33 deletions(-)
>
> --
> 2.25.1
>
