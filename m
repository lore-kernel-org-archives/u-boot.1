Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771C3CD98D4
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 068F38401F;
	Thu, 13 Nov 2025 20:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eX8b+iJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B53DC8400F; Thu, 13 Nov 2025 20:34:12 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB078401A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3418ac74bffso928341a91.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062449; x=1763667249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kvUDaIEUh1D62UvwaCrlfFhEjdbhUKoCFK/+Zs4PCDw=;
 b=eX8b+iJqs+TNdj/IITNVUlR/hhFgcNMG9paWS/TzjfoNexdRQQSzGWIvJqHZiYazHn
 AqasaC3l+5tZDFRRlULGI8H1hdprJwI4k0LwihOFVbtPFrlcM4Mq1olbYw8N9/7HytdJ
 Tl87Y1+mObkqbX864a+/unokyKPXv5HtplqLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062449; x=1763667249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvUDaIEUh1D62UvwaCrlfFhEjdbhUKoCFK/+Zs4PCDw=;
 b=NoXgzOzaHw27ydNW8llegqteYcidrNhBX9yAYSQ5fXpOfXkS7JdB/n/Ba8D17WnAZA
 RE81S9aB06wNhFIXAFlVdkU+e19nojfxtB+gAckAejG1SPOHCoCagFGDDj9BTM7T4FSp
 vKeeOT/xKv0zkIj6zbj4GunFSH02rE1AO2twH89r9rw3OsLmb599H6fP/DzmXyJpIC4h
 /6DOkDlHnzB8s8eFClbpbMvYwBzA1pQw9lkA6pboSvUzBUxCeTuSjKr8ryjoeUvU/8N8
 VW7q3JIjxbNE6qMBhmcbyKlE/Whav8WBlv64k/kFA4PB7JX1aEi1H6i3Vfch36MNQIHg
 ZrWA==
X-Gm-Message-State: AOJu0Yzrr3IZFULR6ZVrOzoo3pb1o3d7WuKwX1KAConjcZcIuyXmQH62
 XI5vPF2mUYxDz5K3QJg25QSOJwxaHupE4OddsxNn4yh3ca16vIlrMgbw2oWShOnyCecjRXSdqHs
 Khu4NB5hreTIG5N7zaiEakNBa07HQvtbyO1hkfqRI
X-Gm-Gg: ASbGncsRBk0BlSXtdVVvOh8bu08czXOfVSRFNnvUzEJ46DCDtrB35+8U+Hvtnb5Bvka
 LxWbJEu6SC8LCgmTuMTL+VZ7Mc1Mf6xVGGP+gaLVjTiukTbvYi8XdChOkKsmnyJVR7deOZzy35z
 fDxU2GnT1Tb2Dti0aQHzl0Vvyxf9DtcU37R/XjzYRi57vWg01btNv9pfjwJ9piyyGXeCMRg/YAb
 6o4oKy2qOq0UqlA9V34xRGTfmsbOZ/K1XrFFyes9fG/SBFLdrz6ABe1lZXr59/FxSTe2Q==
X-Google-Smtp-Source: AGHT+IELg3d+VA8qaWa1SWw4vHJEBTCQvdyBTbmif8IvD3ndQGRTTMlpW4KyBqUJkDO5S4oLn8VpyHvm0mDDxFMjQ2o=
X-Received: by 2002:a17:90b:4f92:b0:32e:d599:1f66 with SMTP id
 98e67ed59e1d1-343fa7412d4mr385382a91.30.1763062448965; Thu, 13 Nov 2025
 11:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:33:24 -0700
X-Gm-Features: AWmQ_bkaUuJlJLrAzg6T1QhCfjqPGcmVE2dXZIU3CZbJoYm9nMZIlsYicgIwjuo
Message-ID: <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Aaron Kling <webgeek1234@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, George Chan <gchan9527@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>,
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

Hi Marek,

On Tue, 11 Nov 2025 at 18:17, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Newer versions of libfdt strictly check whether the FDT blob
> passed to them is at 8-byte aligned offset, if it is not, then
> the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> android_image_print_dtb_contents() passed FDT directly mapped
> from abootimg to libfdt, and this FDT is not always aligned to
> 8-byte offset. Specifically, the FDTs are somewhat packed in
> the abootimg, therefore if the first FDT blob is e.g. 0xfd bytes
> long, then the next FDT blob ends up at 0xfd offset, which is
> not 8-byte aligned.
>
> Fix this by first extracting the header into 8-byte aligned buffer,
> checking only the header for validity, and then by copying the
> entire FDT into newly allocated 8-byte aligned buffer. While this
> is not efficient, it is the correct way to handle DTs, which must
> be at 8-byte aligned offsets. Mitigate the inefficiency for the
> common case by checking whether the DT might be 8-byte aligned and
> if it is, map it directly.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Aaron Kling <webgeek1234@gmail.com>
> Cc: Eddie Kovsky <ekovsky@redhat.com>
> Cc: George Chan <gchan9527@gmail.com>
> Cc: Julien Masson <jmasson@baylibre.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Nicolas Belin <nbelin@baylibre.com>
> Cc: Sam Day <me@samcday.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  boot/image-android.c | 46 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>

OK, we need to adjust mkimage etc. to handle this. Until then I think
we should have a way to disable the 8-byte-alignment check as it seems
to have an enormous blast radius :-)

Regards,
Simon
