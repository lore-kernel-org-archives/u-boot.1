Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC25CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 12:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5393383741;
	Mon, 13 Oct 2025 14:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="ex/ogsAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4832183768; Mon, 13 Oct 2025 14:02:52 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5726083734
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 14:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-59054fc6a45so886040e87.3
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760356969; x=1760961769; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=q6dbK2vZMVZmEIeONfcgpswLfT4t2TRVrdOshQ12MRA=;
 b=ex/ogsACCYlGnGKx2scjkbaxHNWGPfyXKL8i1exA7wjIufwPMSw68VI9bTE0FXcgKp
 /PIYUrqvJ6GhT3EOOgHmBChkOLvkOmkEifS8NLMhARPHjzculSVXk0q1XhVEvDDjLlZY
 c2k6QEIrwK5ggvIMwTckAB+0pmpCMEG1N4/rvBYGyEsSbNGzBEQYZDPyzYwGj1+eMoGg
 PDhkM6+tGHVrtWNyhm15J996psfpygbiE2p/6njsnnQuskVl1LlczEFgHXdAigzKnndP
 Q9Z0TifZWfJinYEs+odU92Xev8wbeEJh0uV7udArO89l7aOAP0ilyNvT8BE+ec8AcWqZ
 MfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760356969; x=1760961769;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q6dbK2vZMVZmEIeONfcgpswLfT4t2TRVrdOshQ12MRA=;
 b=MvbIwQdHlAe2QC0JXT/TqbDTvhkd18C1lHeaPzg+c91nljX2jl0Rkk19GkYRtTKggm
 qHPUMlSNIdG079qnZoBVu9C8vTZ2/CKTPLpUaSWUjjpAs42EZH1wJUw4HfPOZ35l7Q9R
 arSls5FFlMvtexm+mr4m6g34gGX1VcXTh/hBve/TtJ27EZ4mQuCBV0CyzplPWlCDsxTd
 5uQA673J46Ei0ixV7w6pOJzN69Z9SqOA9HgFA7nLyqJ4dAH/1PFXOOOqxQDjAc+rNmJq
 y6BG5Qorz5UE6LWntw8baFQfQzIn6eU8eVByF2Lejdk3spsHf4wCH95Zknc8Kkg4hDZ2
 EfPQ==
X-Gm-Message-State: AOJu0YwZzNta+tFWQB8MlCMTn6OXSQklHkRYk04q2yHqKAc6Z/Dl74dY
 udRQZf2EDrcamUubUfTbD8EBYmhLjR6LGNrSBdl8ZBBqXoFVRxuSEtgaHIYldqMh0rK1QopV602
 fYhrVom80j0KBlbjTLLeNgyj+/2XVfA4iTGgA
X-Gm-Gg: ASbGncsLslWob6YVdVEQ3cLMNsM6Xc9JZWUxrLc5gLkCav/pHBuRtAID3OAx7/ZDkCr
 dMWrInzUpDdUuHJXG65U6jy5UukgcqAGX7ph/ypwCSsd6oYIbWWFfO6ajgMjygOA+bH4xtfuQN1
 yN+qXw2JWk0agjgaLRetLAU7nnNEOch5lndh5rJM28UftCBe+dJOE4771zcZ1S1S+qa9QJYnZy0
 Xc2YmIlSfz+SC3OD4q1DM7h8HU=
X-Google-Smtp-Source: AGHT+IGMV9n/SlM9LU9BWdX6h011uzRX8ShgVpZAgO76j0/oRwFFc//zqjIe6SGudJ61kefaUITsp0voVZELCX8Jym8=
X-Received: by 2002:a05:6512:3b98:b0:577:5ea7:1484 with SMTP id
 2adb3069b0e04-5906db04033mr5719092e87.6.1760356968554; Mon, 13 Oct 2025
 05:02:48 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Mon, 13 Oct 2025 14:02:36 +0200
X-Gm-Features: AS18NWAbKNi-nEH0J3tKcJ3cUwFzMQYawuOwZHk0xkZsWAQRSZnB8MVRGu6tRe8
Message-ID: <CAGm1_kvA1GohbO-=+oC6q0p3bnEznvSZ+ubFGmWz_c5prMSWPg@mail.gmail.com>
Subject: gitignore for mkimage files
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi All,

after building an image via stm32mp15_dhcom_basic_defconfig, I got two
files that were not covered by .gitignore:

mkimage-out.spl-stm32.mkimage
mkimage.spl-stm32.mkimage

So far, I found only the following entry in the .gitignore file:

/mkimage-in-simple-bin*

What about adding such an entry?

/mkimage*mkimage

Regards,
Yegor
