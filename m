Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE0BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0C484A0B;
	Thu,  2 Jul 2026 12:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PdJBb8Ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D7184A20; Thu,  2 Jul 2026 12:31:23 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21CE784994
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so2547793a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988280; cv=none;
 d=google.com; s=arc-20260327;
 b=rcQk9YORkG4uOxRNhFrWBREBNxHeOxY/lCGEq0xO0FbBe3tjVqIPI3pOYAwroInklF
 fC9wv7okpN1kH47CrYofJrmpNjSYz96pPf36PfWT2eg348t8hBCsQNhygfqKOPbvrj4+
 gC6LqFRz1KjPx4uKxQmCEbO/tXMAzTqnftQU01xNDsJ2LHuJCrKsOsw3xOmpkCKH/pOy
 2EGxNHV1HJ/+IbFq6fo1ScmOmbrZKNZxfpkly+R3/LWooo2a7TF95fI52WtVed2ZD2gr
 XcJrSCK0ObI+T3HDTbUeMui+bazLORSzidYayaqrKixhhgp4d5q+8htAC0nU1nY4vEQA
 6sHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+k0ayumZy1zbdkfFIxfHpmH3tRUZigwylXVqcXToqow=;
 fh=NOAXHiOiI+QI4rB3QD0vps9PRvEGDZEmA/hocH122Z4=;
 b=gtUgsrSgfVSFfpO1pirCuNOOhFrzZuzPiraaiQZZrTsb0cK0LhkLn8Hjf5B4WV3uLT
 C0SjwnvFcjViIhFEqs/m/a+JrrmpP/WGzBZtKwWitK+HlYmt1DyYikWHJL8zYvNYB3r0
 SdDTSE56/jTBfzBwsqu/NBbnCWk3MtEZkSY3C+CRmqHLxKtBbIlp1Btnz/O3R/cUuUAq
 5n2Lqo1xjqostPumCCc3kj2qU6Gr64ZON40nYxjmaC4fBAFpbNVX1Zt4lqtUPWYVNs8+
 3RlDJwn7/dBD6V9yveh/kxG8VjTXSs7LrUQCUQlM7FwgW7F/aq5O4eMU/1Hwt/Mi8xLz
 Og4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988280; x=1783593080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+k0ayumZy1zbdkfFIxfHpmH3tRUZigwylXVqcXToqow=;
 b=PdJBb8UxTvJYt8ZRHYKcSn8HXcw3/p1+xaRb4IkdGqQxYq6qsT3reRjhRJSLyeROml
 tG2p7EAAtcidQbaQ61IR58fcLq61X7ElyryC7H8okNAXUwYJDExNRdjliPY7g1TzGyJe
 53BhJOMLPPuo+nUe+JexCxmtYxLurFU13+PCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988280; x=1783593080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+k0ayumZy1zbdkfFIxfHpmH3tRUZigwylXVqcXToqow=;
 b=GeuJ8tspvRl55z9aKCHZBTHxM7ZSk7K6da1oPVDI+LzcBENTGJQb8r0mmCXtUDJRVJ
 /Thl0AtOj1jZALTQICFpyNzgE8dmGBzTCbyJYlpi9ywWFx18anPGVhG7ONs9iEAh4ALl
 1/ZIGSr5BcXWsd0hj+rw2UAWx+RH5/6jPQF2iCJskfR7VcL12CcvgZM1YSowZqHMZOhH
 jNaED4rx887MHs0nHl7q297JYTjEzh0lciyJmIcrc6mKF3puz3Z+kwOWtkAFEZmjBiLU
 H239ZTyxXhLNlyTwCfkUTuDGTUBABDFN4Ug1IKqiyngOgCmAH94FviTY62ffCGFr5GPp
 NJbw==
X-Gm-Message-State: AOJu0YzQQtRGeZ2K0V6JZo+XchUwiiKCeN2Ever7Xhr2HENQoowI9yQP
 MAWAxSnIRRPUGZ2u3pwlRdf2f3qumPHlD1SkCRtLD2ElaqfJ7DAKh+jJR3xgtCCUcfTTkQs1Woi
 OOETdYsnlXbe2bGxVQODBfUk4R+4fgMoOUUShlCH9Zy4adRo+NUJqrJdSaUU=
X-Gm-Gg: AfdE7clxsCn4wCXl9yqPKHFGnPZqf8AWUqvjjNlFRxO7MgCQzEMAM3q1D02knaXKyHm
 Z2CXek3bxFxKgbh4ZvZzbkNH/7N91LOZTzvyahPduQR9/xIlT1eov3SVRgcJKg0W4AQmwf6iEbc
 trLiVovoUUQirXWn5U+aLgAJ5CF9On210uDJ2vDJ0iwvCUhMsc+2/qErixwHG8EeP9Cl0FgFPiq
 LUcK8i+kToPOjJ1zqUhCSrFkxD7T1iRK0zzcxk3RqnPY4kxaZN8NRQXaIpdzf3lJNelIDBpYg==
X-Received: by 2002:a05:6402:e0a:b0:698:3b7c:7e2b with SMTP id
 4fb4d7f45d1cf-6989f385c91mr2582848a12.35.1782988280542; Thu, 02 Jul 2026
 03:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-1-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:31:07 +0100
X-Gm-Features: AVVi8CeKnD1Iu6gJjjHx-vYR_ZWyc8Ua3n7sv5lFoz1ph1pEwngHqQiZyEJe5P4
Message-ID: <CAFLszThCoSOqG=7j3A8jDfVkzKj=m3GBG_NnKBbZHQ0-uq_WFg@mail.gmail.com>
Subject: Re: [v2,00/16] LoongArch initial support
To: me@ziyao.cc
Cc: u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:

> So far this series has implemented general support for initializing CPU,
> exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> machine support and UEFI standard compliant EFI booting support.

Thanks for picking this up. The split between generic and arch-specific
changes makes review much easier.

I think Tom mentions this but please add doc/arch/loongarch.rst and
doc/board/emulation/qemu-loongarch.rst

> board/emulation/qemu-loongarch/MAINTAINERS

The board has its own MAINTAINERS stanza but there is no top-level
entry for arch/loongarch/. Please add one covering arch/loongarch/,
drivers/cpu/loongarch_cpu.c and drivers/timer/loongarch_timer.c

Regards,
Simon
