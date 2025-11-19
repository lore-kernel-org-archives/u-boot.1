Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D23CF34A1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD1983D3C;
	Wed, 19 Nov 2025 14:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mM1usz0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86ED583DA6; Wed, 19 Nov 2025 14:08:21 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FFBA83700
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c52fa75cd3so5081307a34.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763557698; x=1764162498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=egoLxraSU++X5+XHPmc7/EQn0Eq4MRtQVgU+hNhtO1M=;
 b=mM1usz0bZH225OWv8htYQR5bh+GJbxwwkrlXaw5dDxb8UNAlYO/p2oeL73mYNjDK/m
 0F+S3JKAM1QZminwL4ohpg3tc3i1l0ueu6b6CNoE3X/IxD/4ELa3a7K8SAAiQaq4wSnm
 WMF8aIHPrXmMHBgkWwuZe7KM5iz54WP9K0V0RjqeQBAyVeMVtrzxZ5J76Dg8000YH3Dm
 XptVae9lCDxiOTKiKLwhrXNazO+ffA/AOdLvgXaukdU6OCotjUTihjIDOfRviF3jNOEz
 lNLyK9ICG/RSAksHPbixUssndI6qMKCBL5b3lFYuwErulazXkd5NI0xQvYH1fdmFbnHB
 PPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763557698; x=1764162498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egoLxraSU++X5+XHPmc7/EQn0Eq4MRtQVgU+hNhtO1M=;
 b=dwWnY5cF4Y2q4wfrJtQxB4Ul1fYRtPcpKylXzzf8zkzuH+rK8Ds04ijaK5uVU1PUzl
 U0XbavdgoxY1jsY6qlc/isqYG3T2m4PbIFYOpLji7tBqbetd9M/iiFZSDEF6S7aeweXQ
 SOD66HoQqyBxwDcHTYwCvasi48knQ/5Xrmxdbp91OAWNYVCqGkab6QDFX3Bl1xS+6iZ8
 WZ8aByJaWKCkBc4BU49Di3Y3DZgqQ80ZMSL/2tD24G45Q3KvtuGTpCStmLqST85s4nHR
 DaYEF/qTX3KQVYKZFmIX5tc23ftXJiZ0XQ4sXyMk3Fv1kQM4oUmppSfQB/mIMhkii23+
 PusA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGEJ5mu151fSF4SOwAIk+YY2TiY/6+NPUKu3zl+1rCC0M0U9dxaxGHvzKzV8Mrw5+AFZ/bEPk=@lists.denx.de
X-Gm-Message-State: AOJu0YwNZKCv+QlwCFp+lWUPX//PUYkccpF3aAkKSlNHP4QVMszHTtR0
 COUIVnDlXYmM/NYf9dPO7nM3uPYC2j738KHHv+L+qzRwAqmPGL/DiTsIyLB7EeiFW/f52Q54doP
 urPsYOOL4E14EWqmc+eYLoHhHXmjYnBF+ZP1OJIE=
X-Gm-Gg: ASbGncsYgvjzwMS7pNurWnKAxCQS9x5JzHQBFRRFMBAR61UL6jDZYfezNiVwGXWojoU
 2qWtuhLBjsbK1nDk/9qpbyTgKpo2ArlGWMDi5zzWHYjlpuQbMrdjkbtXD9+mOnz1a4evxCTDPvv
 Smzudswtc8HAOfofUVR/FdGNijkwb7zQlswF0vIOlmw1UvsTFzV9M2zZQDWQubx28EWqHZaG/B3
 oT2eox/0JtnWrTVFA4WZ5oGXrGbaf9YXjSnHKAQjM9km4A7cAbFp9G2lzxX5l3MdForoFgcOEK8
 zS2qeQ==
X-Google-Smtp-Source: AGHT+IH5vW0b/Wew0M3FvSpRhGsjMuid2ZVBE7NndnX3ELndZzBbuwgZTKuCfgpSMcMBMk28NCZ59AjoUVH9/pI2ktg=
X-Received: by 2002:a05:6830:349c:b0:7c7:61f1:6fd3 with SMTP id
 46e09a7af769-7c761f172cbmr6937944a34.9.1763557698028; Wed, 19 Nov 2025
 05:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20251104223023.1613-1-briansune@gmail.com>
 <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
In-Reply-To: <7e31b494-1ce1-4fb5-af49-d203830add7e@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 19 Nov 2025 21:08:06 +0800
X-Gm-Features: AWmQ_bnsn7pPwSm9wBNTYrSsyS0oiDEiDl_vdS-3j6-_lWt_Jewph4sjvt1L_1Q
Message-ID: <CAN7C2SCBqEajYv8v+meudRN439MeiEGnW5c+eUbMWFL0rcVoWg@mail.gmail.com>
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Arria 10 boards require the A10-specific filter script under:  arch/arm/mach-socfpga/qts-filter-a10.sh
>
> Invocation pattern: qts-filter-a10.sh <handoff-input-directory> <output-qts-dir>
>
> It processes a set of A10-specific XML and RBF inputs such as:
>
> pinmux.xml
> arria10_hps.xml
> pll.xml
> emif.xml
> core.rbf
> other Qsys-exported XML files

I had provided new patch and removed the A10.

Second because this is bash script and according to
what the new tools are supposed to look like.
Python script is new tools language and should be
followed accordingly.

As such I will not going to merge A10 to this build flow.
And any new family handoff should also put to
the same location as Tom suggestion and also
make things more clean and better on manage.
u-boot/tools/a10_bsp_generator.

Meantime, I think it is even better on generalizing
one folder for all Altera socfpga tools, with
requirements.txt as well.

Brian
