Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32166F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB655843DC;
	Mon, 20 Apr 2026 21:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2y/l8O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB7F843F5; Mon, 20 Apr 2026 21:32:58 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6BD843E0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so418517466b.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713576; cv=none;
 d=google.com; s=arc-20240605;
 b=A0oPFXXkTd0dpCD/DsDk9OF/Wye0mfJzOOyY9W86W3Z/hWianyfqm+vh6pKV9GDTeL
 qPrDZg0uOmObTfuoGEIQETmhZMXVFuNY52ZPX4w3qGAVe8Ar+gdmcXTWO8jLXD82l1uA
 nW04u+uR0spZybeD+O/u1AKjYAPz281NWK5nykKmCZSKnI16Dokhp71KwR6ByL0amxfX
 RUVRkUOOCnD0zTbsH4B8mC+5mgywvcCAZFqJRgq6kl0idAEHvlpM44qwaqZZQBUXjH4k
 EI6pozKfUO40tH4NJ5+OygTIagMDTM9tjGgbrvq/tjtteBBjszYJJ/cJ9gIdvbMnMF4I
 sh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u6yjFd6CcPfuuy0ynAvLAN7oDVZke3Gu5PjqKsDlQuo=;
 fh=TL2Th1PXbQmTygp4zdHc2dPft0ExKDuqIBJjEY3UVdE=;
 b=Vs7F2qC1jgs2DwFJUV2fgf09zB9OMoJlvTh7Ev7+956vv+O/JntTlWdspo+vkfO1Sh
 5YFOzuW5WOF1K8ZbOl41eUobzSvplzo8uhzkw8kCE0Ec3N48BKBldL5jG6s+F7YI6tBh
 8tBOoXUquPCarujIUsb2jV9dh8g0JQwsyHv+XGuDl0tQhJ6463LNhDEh4gXUKusmhBnZ
 1smM8/1ivFY0J71v1ZsNP/C7zKpcw0gcsQDNjiPf/a8ipL51rnIXuXKEAqC51bs9wN0W
 xXZALliugAvJFF2p1IFsuaYaDa/bQhuNhFsbwMeHVVG4vaybklhsvfg/BObxIbsgFp3D
 ps2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713576; x=1777318376; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u6yjFd6CcPfuuy0ynAvLAN7oDVZke3Gu5PjqKsDlQuo=;
 b=D2y/l8O5ATEA1cCi4TBLssxkd++DF+frrWwZ9oRi3kbmi0uSrBZF7QsVXhIMaxyUU4
 mQh60ZxR6ESJZaMFXDWXlWEmBv950JPXrC14NFqJpfAor8WrUF1fbwVliONL+3VTzObb
 lgPmMRMW9iBqogn4S+NEC1nW/VUthQwMWAkGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713576; x=1777318376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6yjFd6CcPfuuy0ynAvLAN7oDVZke3Gu5PjqKsDlQuo=;
 b=MayceM/dwda+owrzbj4tBBwzazBJvt8wdyNvk8NmOsaW2hR0kXa7hAyanyx/s1rrJX
 7jVjxjZMxE2oLftCN8Fm3MPIjvUjo4ikh9/oGJipwHsKM1Okesh7FET2+mS2MbqnOfwN
 vmNXrJJyxQBYa3uNjekxbElw5uIvYi5dGNHhsAEnjXBofSZ6a0e3Ke/bXcvDyal3jvfx
 6XZV/CpiWfa+U+/k7jgzhgwcWGixzzeU0x2Kq5lhaZNvW7T+k1Wa86ocQ3GybxEkL1Ls
 /UnQotxAaQhdMDp97DPUaSB7jEdfRs/ocifpEffL18YCUfgOszZF/WRC7KoQxsJ0emMi
 DWyQ==
X-Gm-Message-State: AOJu0Yy5ypaK2Uadh6mjq9jbht1WgakTKPmt6mLXUERGypaEkVegRaY6
 n5RBs1PpIeJhpfO/V0diVgMnxY8YLfEXTKzspUx2IG2B04W0C/EWSpIBDICsD5LF/hf8p/M/tHY
 2OVL9QS6Czcizsz871HcHFX0zFRY0Z4arrlMmlzuzO6p0q5igjkg5Zg==
X-Gm-Gg: AeBDievcRnSdYQFPK+wYl+2CYNp1xSIqGqQU0+3SZFnMjRj1XX/qeu8/ZcBdhq1Ph/3
 xt1c12R1zoUqaoqwLqwmVpWPPgaKVOFmlzNJURvE2mUAyGDFSEgw0gkqd10/p+a5fuDzx8CxacG
 4NEsgXEI0Q1hb1GKnJ93L3SMvJqtDLfvqd3zOu0FdqIr5NpXQgYxiVXPf0cdaHO+77ZeHDja2FI
 b+EqqiDhSRLr6NFhX41Yj2h7aeQ/2y94gbCHlIXN4lNoFrylbFoZXCws77XEMrED+FrlKmfrm2l
 JlQpd2z6ZsXg0ggRTG0s
X-Received: by 2002:a17:907:72cd:b0:ba8:ca25:e6ab with SMTP id
 a640c23a62f3a-ba8ca25f0aemr160391366b.11.1776713576002; Mon, 20 Apr 2026
 12:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074601.24988-1-briansune@gmail.com>
In-Reply-To: <20260420074601.24988-1-briansune@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:32:43 +1200
X-Gm-Features: AQROBzBmVY07zP0APNgD_SARF6UU_fPFbIHaVTWHERZcIHViKEL6GxeFarTkRss
Message-ID: <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve handosff prepare on SoCFPGA
To: briansune@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Brian,

On 2026-04-20T07:46:01, Brian Sune <briansune@gmail.com> wrote:
> Improve handosff prepare on SoCFPGA
>
> There are some cases that the Python scripts
> are run and the qts files are not replaced.
> Make sure qts folder h files are removed before
> handoff script runs.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
>
> arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)

Typo in commit message: "handosff" should be "handoff".

> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> @@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
> +HANDOFF_KEEP ?= 0

> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> +             if [ -n "$$HANDOFF_KEEP" ]; then \

HANDOFF_KEEP defaults to "0", so -n "0" is always true. I suspect you want:

    if [ "$$HANDOFF_KEEP" != "0" ]; then \

Otherwise the 'preserve' path is always taken and the 'clean' path is dead code.

You could also have an empty variable meaning don't keep.

> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/config.mk
> @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> +             trap 'rm -rf "$$TEMP_DIR"' EXIT;

The trap is set after TEMP_DIR has already been used. If the python
script or mv fails partway through, the temporary directory won't be
cleaned up. You could move the trap to immediately after mktemp

Regards,
Simon
