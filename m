Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46007E784B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 01:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC9084308;
	Thu, 25 Dec 2025 02:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ce+iK79+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C52258430F; Thu, 25 Dec 2025 02:32:33 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AD6842F2
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 02:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6446c1a7a1cso5355366d50.3
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 17:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766626350; x=1767231150; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlIzFVToue/4ycRy+5qZPXOVgtbFmsNxblOVU8Pj0vQ=;
 b=ce+iK79+GsUzo0sLIeevKbD/6RLWNPCsf9JdYfCrLdj1S7ee4XulnllxmAEiVL/mEW
 e+jz/RElHUcgnXP9tmuo7KgKe2bQlOS17Y3RYRDVufGx2wILVK1x+qVA5bRhbP8h2sAw
 I3MzprHuANFwMn7UNzzuBxWwS69l+rsbIQyOJbq9+7/U23qXeIm3rOr4+r1A9/MkIANa
 bKNveTv3kHtYB5qDGYQQd+mW73iVoD2DsqasKSkeB4zkgsNalkiXRZJxHZ+OkR5rtP3h
 FJEFtOUEA8FarwZi4ZMw7GkZCs/vXKZUeTcqwO35DehNMP1m9QDHEoK+6ZEX+EouiutW
 Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766626350; x=1767231150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WlIzFVToue/4ycRy+5qZPXOVgtbFmsNxblOVU8Pj0vQ=;
 b=eptizuvN2VjcBYxZXO1zRQ7XeOYPTk7pA0A2GFYaaov4XLj4QKWCUvHL5+O5ydvXwy
 1afOW/ALSRGrnd3fTDutXw+J34z2+CIUDZEsRvof46TR++irtLdnpSvPpCzM61WEC+Iq
 S/bqO3QJSNwHJbCVd3ehIBnjk6VZt5eygxy2Aq4JwK4t1zHeDXwME4ZBw32eK+QHj4If
 EFQTD+Y2EnIwVn0ArH0KVoqDg+Bvz/z3iHEfXKpF1ns1defypYICDZhFvpbpWKoKoKUi
 qtceLDBD5p19eVemOIBHFbIHNtVZ2GCyCmCKNH58sP/vXmdTYJe2vxMYA+GNEBUsKHqJ
 DwAA==
X-Gm-Message-State: AOJu0YyeF9KjTZFjKxd4pe3s37gXt0b0qTtRMD79scU+8NtjD5zkjlpJ
 f+3Xm6UPyceag4toSjZdvBww0yEL3OwmVrtRIOOL6oojVcE4eKAGQ8pf7V4iIO7wro4SHnOMHm1
 L+eJL4j7oBdpD900FVfm0DkrS7iqH/Vg=
X-Gm-Gg: AY/fxX6KF1pxkSLie/VINydoLydHXQ59pXmnPMx1xSI6AlyayM7ZJVDthKu2ZJWnwoy
 dAoSB0hJAiCgchwChiq0MOSC90A4gxBH3Sky3E5ICs+7NcMWzkI86NhcS5jAAM9j5wQXhM58l/z
 GKRx10Z6zWQYEuJN0OhgaKCdmGbgdBhiIvk6VlREpf9/UDas++AhqyMJbra8w+2yqFkaxQ/5Wcf
 AlyS96sEK8Pk0DPLTuV0ucQs8B7b/Rs3TZ8FvUd3vvZf3rvIeTJXJx5NcZzSM4OBh+i+dU=
X-Google-Smtp-Source: AGHT+IEh7UcYy6iP2d3lkw25XvRHZGnpq4SpRLMu+apREJown1zqFT/1VMcHEOUxIsaeKqlXp82LkxM7QhwAKPzu7v0=
X-Received: by 2002:a53:b082:0:b0:645:5a2f:7d1c with SMTP id
 956f58d0204a3-6466a8dd4b4mr13418271d50.74.1766626350240; Wed, 24 Dec 2025
 17:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-3-trini@konsulko.com>
In-Reply-To: <20251219202121.4180810-3-trini@konsulko.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 25 Dec 2025 09:32:19 +0800
X-Gm-Features: AQt7F2ptoDzxJYtxE3PXR6aEbWYPgmNN6ci8pMNbsM9hXsfDfOsONFJodIUzmaY
Message-ID: <CAEUhbmUooNw4=0KHTUik1w=7ZtgQwdvOP1zWhqqm0y9VY5u+yQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Increase SYS_MALLOC_F_LEN to 0x1000
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

On Sat, Dec 20, 2025 at 4:21=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> A few x86 platforms use a SYS_MALLOC_F_LEN value of 0x1000 or higher.
> With the impending move to having DEVRES enabled by default, we will
> need a little more room here. Raise the default value.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  Kconfig                    | 4 ++--
>  arch/x86/Kconfig           | 3 ---
>  configs/qemu-x86_defconfig | 1 -
>  3 files changed, 2 insertions(+), 6 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
