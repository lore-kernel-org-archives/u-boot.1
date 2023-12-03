Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0568C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE6687603;
	Sun,  3 Dec 2023 18:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hz7XmF+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158B387616; Sun,  3 Dec 2023 18:44:19 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A5B1875EB
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54cb4fa667bso562724a12.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625456; x=1702230256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sbeCAOmmw5eBgTMZiwWYj7GrFNNh8jONTorR+6TNpkw=;
 b=Hz7XmF+OqYnIN/ffkcdZNZqswsjXMAP28ZXI8eDwkku3D6dKalAPPImFkBPLlHtzHM
 t39kDyZ04wZYA+v6TFrV/9XDuIkg6ukogSi5YHolJcdbikkvNr0kHAD3dyGcTE57K9Wb
 qpcLfG6ojastFb7VRyKo7+Tr1Xmp7/zjnccLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625456; x=1702230256;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbeCAOmmw5eBgTMZiwWYj7GrFNNh8jONTorR+6TNpkw=;
 b=PgLrM+CiABnI9zkV006cfp6JCTsMaVVEMa7zgKvelupPrfDDQieTOCvckanDehUhwb
 e5zbaG2T0jPX2EPhBSudT0X2AX3nhBZ5fuy/yP48XOyZmJ3qFq7Rc3vZcZNfuCYR7GLc
 bP3Kns+YTPJxi4NfWxResQSbp1BPI4wo0wNLImd2UkluuWa0m95JPIKk1R0pRZkBLy9h
 Vw2VsoOov/OLY/CIkLI5RW7yB53O5h6fNEYKRTyAXdwbvpzbQhM6M2fUE7kyKnXNOZ7Q
 W9lE0psjTF2wTcrIdmhXAo2LfXK8o7Uxhkt8NEzibulEQmXCWjtnz/XyXXjBOqraxM8f
 VMAA==
X-Gm-Message-State: AOJu0Yw14+vb/FVXrg6TePq1gbmwpYPjMRfWOQn0LnRG1Hm2gxisQ7cd
 cgb2GsvkPsy3obURTTyzIN8y4YKb8nTEnXHkmLOgzx27wT/3o7gPIrvc6w==
X-Google-Smtp-Source: AGHT+IHZf+B01IWb9geZS/h6Io1wN8Ll3O4r0aJaYHKwVtwX4DQx7Um5CdMr8x/VPSU1ov0dcOyR842+LiLPwBhlGZU=
X-Received: by 2002:a17:906:74cf:b0:a19:a19b:78d5 with SMTP id
 z15-20020a17090674cf00b00a19a19b78d5mr3264621ejl.152.1701625456334; Sun, 03
 Dec 2023 09:44:16 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:05 -0700
Message-ID: <CAPnjgZ2Os+zLWnwc03AZc69p3FCiUuJ4thncvMy8wrOeEh52_A@mail.gmail.com>
Subject: EFI memory allocation
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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

Hi Heinrich, Ilias,

I had a bit of a look at how memory is allocated in EFI.

I see that efi_memory_init() is called quite early in U-Boot. It
sometimes allocates memory for a bounce buffer, placing it somewhere
in memory. How do we know that that memory is free and not being used
by U-Boot?

To answer my own question, it excludes U-Boot's malloc() region from
the map, so that it cannot overwrite that.

But then, what if we use lmb and start loading images into memory.
Won't that conflict with EFI?

I also see that efi_allocate_pages() is called to allocate memory in
the EFI code. But this just grabs memory from 'anywhere'...it doesn't
respect the U-Boot malloc region.

It seems to me that most of the memory allocation in EFI should be
done using malloc(). Of course the boot services need to
efi_allocate_pages(), etc., but I am not sure that the internal tables
should be skipping malloc()?

What do you think?

Regards,
Simon
