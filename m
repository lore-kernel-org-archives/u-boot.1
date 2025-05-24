Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AEEC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 18:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D368C82E28;
	Sat, 24 May 2025 20:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vWM/LwAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D871882E76; Sat, 24 May 2025 20:13:29 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D21782D2B
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 20:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-708b31650ffso8110197b3.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748110406; x=1748715206; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MM/MOY8JB4yfwbq9rmUfxS7l7OKDDweGA0sp99ttIuQ=;
 b=vWM/LwAn2w3z4LqyaDNiBB+2l6q8VufcEg1+d935UwvMeWujcbIQwSj8On24LJ9gJC
 +fyaULzzT1w1HSyWa9NmAaezwE5FijSkbwfR+I7isc+gBoSuFQ3vAHYIBhRjCP0Duv2/
 3Vidnsg4hRh2gfbXCh1LWnmsq0ZKhzpDNLFQxefBpkaFk8MGV1LrKr1RdjfPO9ANeteM
 LQbs+IFXZnyF7qwoQc3ZUx4k1XNuN7w0Re8ZDp5dE8MZp0CsgCLA55ZyXbae5K1/L5eO
 j5OK9pevJzc38OOyXZc6BGP/O+dGwhMg+PydFfiDLqdyNFLQHVvQ0AngL51IKXFZdlRa
 Rg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748110406; x=1748715206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MM/MOY8JB4yfwbq9rmUfxS7l7OKDDweGA0sp99ttIuQ=;
 b=ogQEbaLXlcSaEoO45L2j8sdflhyRB1nclTOw5b9oznyqIkPv7eaqqodRdDHkMkd+oJ
 wDZ+4VYATZdjOJWv+8gAcN/fB1TnAEwLOf0E6oyi8hwOCiQFlK+aqHG/mpJaJ8WkyuAi
 6RsZbM6JWJXAjv6TJgWxrX/rae8CBqT8CvkyRNlBMSYy07VItcRgMn/B+6CH+r9sn/de
 Q14pYQJAE+KbToCvcvSgRcMRnP9UQTADqsI4nDb7ry6WhX1ltw7CGtMB9E0TNGMHYSXt
 1MsFoo9Uc16NB1/s4FsbaKKhk1mqpulXzxtPUe3yV3E/kfU8l69isyOJtgFV437QtAVt
 Lutg==
X-Gm-Message-State: AOJu0YyV6Ojz/lUHmnBaoV8a5zQaxZum3CCifCCxE+H+SbOdssR2Y20G
 xsmYj8GWbY9txQfGKKsk6FYKnjCdyTjUVZuPFnD16NpU0dNBpbU4HSuErc1SWpYHQsHXL45+udG
 PMzd9Qrq/8jw61IhJxTm1UcAbbf+RIXM4JgMMkPExFJEYYxo1xr1R
X-Gm-Gg: ASbGncsQR3sdJrADIPANqlooM/2uQpUNPbcBrI+wKZJka/sR6WM8SApxSoXO9l4MAwy
 ZXMB3OQqZOOOwnb4Me1shE2RZ6KLUgkXdE5F3ZxYwvwncWA05XcpJ61TIcv+e1yux81BWq7wa3w
 fkctZOXVO89gJnMP10reZmY2QicUq7hvKVEvrgehSelrtZ
X-Google-Smtp-Source: AGHT+IEO6RC8pn3L4Y5qw+GWKg9cXjZ4NEqKJJpzqwLIKvV7zlUVz1qIr0W8qBYGdECwu9BZVU1plMDAY45wLwub1dQ=
X-Received: by 2002:a05:690c:f91:b0:702:627c:94ec with SMTP id
 00721157ae682-70e2daaea46mr38356867b3.35.1748110406431; Sat, 24 May 2025
 11:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
In-Reply-To: <20250524120904.684977-1-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 24 May 2025 21:12:50 +0300
X-Gm-Features: AX0GCFvPqiigVwAikJAGgDMI5Dt0yyuemEUwXnN9sEzx_LcxfwFX_SwU2TTuZXE
Message-ID: <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, 
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
>
> A previously rejected patch to move the EFI public cerificate out of the
> devicetree has recently been applied. This series reverts the change,
> pending further discussion as to why it was accepted.

I spent a good amount of time, writing the commit message an
explaining why this patch was sent(which btw wasn't 'rejected', you
forcefully reverted it back then with no agreements from anyone) and
why we prefer to do it this way. tl;dr early boot loaders that pass as
a DT is a problem now.
If there's a good reason to revert it, please explain it on the commit message

Thanks
/Ilias

>
>
> Simon Glass (3):
>   Revert "efi_loader: Moved the generated ESL file to objtree"
>   Revert "efi_loader: Move public cert for capsules to .rodata"
>   Revert "doc: Update authenticated capsules documentation"
>
>  .gitignore                         |  1 -
>  doc/develop/uefi/uefi.rst          | 15 ++++++++++++
>  include/asm-generic/sections.h     |  2 --
>  lib/efi_loader/Makefile            | 18 ---------------
>  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++
>  lib/efi_loader/efi_capsule.c       | 37 ++++++++++++++++++++++--------
>  lib/efi_loader/efi_capsule_key.S   | 17 --------------
>  scripts/Makefile.lib               | 27 ++++++++++++++++++++++
>  8 files changed, 81 insertions(+), 47 deletions(-)
>  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
>  delete mode 100644 lib/efi_loader/efi_capsule_key.S
>
> --
> 2.34.1
>
> base-commit: bab54f5942c428be698216224fd10b91d974d4da
> branch: efis-us
