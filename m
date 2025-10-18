Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6FCCCD195
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 13:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D2AF83741;
	Sat, 18 Oct 2025 15:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IAJk9j5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96DC183796; Sat, 18 Oct 2025 08:08:09 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE439836D1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 08:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gchan9527@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-580a1f1f187so1084896137.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760767685; x=1761372485; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6IoaR7k1DflcDj7llbT2QDQpy9t0JwXCtgzBgHGcng0=;
 b=IAJk9j5O0z8HduOw3HdnXgrLS+5MRgO/wO+7ihKiywb4nMw2P/O078e+vDWEYL0ZBJ
 GJnhKITjBvzzosVIygPwOu6h49EhkH1mAsaoYzHBXg8m85hqEHG6Ro37y5axLwtN5zDK
 rWAJ1PcxxqSqH9tNeeClCk0GgMa+ZM+v5jIDC9EaO8WzNYmTgWO/y9WQyd5pJPZHt70g
 NDC5MdeCTt1r4mjIUW1xQ7w8CZVhYtHD7RIOmMe4Ytyz/hI+yGfq4LWjtHS4qc0ZPoqv
 TBDQ5Jr8/3VMWP7k8aNz/VJEkTKNoX89mUEbw6vLKr/V9kTOh3bXT/aCO5lsu/wDLNvJ
 wLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760767685; x=1761372485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6IoaR7k1DflcDj7llbT2QDQpy9t0JwXCtgzBgHGcng0=;
 b=lrxnnT2TK0H3IG/bXs2fi3mssAwBcfrHrI82Cb6Rr8WMNZgAZHRC3PYeK0CZG+MfkW
 ufCGB290KkhP6orhExup462VA4ccnaS6pVIYjF5oThyitlIy1lXmDaHOSJza+E18wE+u
 CdTMycBB3pEq1GAshbcg5gaY0u3RWPAgc4D/jneBRzTssnq59dBCvOrKwMBBZLcRT5Lc
 lz0AX3nLP1c3XP8I27YNGJMuK38D0iKipGlLSVNducwrcOl6K6mvXER6wU3O9Odqwp7Q
 +lp5gTCxeXMJkPOKj3OEj7F4cVulNmUEmMJFKqG6v5oXGILdRbVs/bXC27OEeE1go+h/
 YpLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIHG6KPZSPFeHYWQC6gpsDmyMWkM+4esLYzM1VofAqBKwPc8MO1LXQTsygl4nSZMru/IEszvk=@lists.denx.de
X-Gm-Message-State: AOJu0YyD8JF5LuJbkGrZW9Z/NMRZzWKdyxlLjR1Puc61gGiG4+8+otXK
 HW/Mq7urSpDpbYasq1/nnmcHIiqJd1FbNCihI/bKwpWowxMizeJguvYwNR7fS/J2Nsfzlm8Fg2y
 7gCC9hWQLUXZLgB9dDOvHQsQUrNYGtM8=
X-Gm-Gg: ASbGncsJupwQf7dIKwypSKjzQVmyW3JAONFLsTHAywNAwoJStIY3kir05Oe9ZFqxJTC
 xWeCjGZ0yRz6Za9eXkV/VcHpzZeoQ4qoBmrdZxMBxYUbrh1xh42TJRGR6iaDuJ0DdoS51hpNJyY
 nbxTbYnxRyyMxOqoNalOKY70H+RRG4tmBJFhzAuQIixz+u7wyBZG3aJfIz4u41AWPA9i0x11dL8
 z38804LbI2R445Sn6/MccTXiEHt1waW1pDwcotNFcVT5IauXik57+3SNNd2E8A4KQ0fi3PX
X-Google-Smtp-Source: AGHT+IEwp9dvTDf1w9tda5H78Rim3rOAVNtqbgdcTMG0VlEaecAkJgykaC8AX0b/t9OadlgquoZEzRWUiuV8M8FZhdY=
X-Received: by 2002:a05:6102:c53:b0:538:9b66:7655 with SMTP id
 ada2fe7eead31-5d7dd59b5b5mr2185488137.18.1760767685440; Fri, 17 Oct 2025
 23:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
In-Reply-To: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
From: george chan <gchan9527@gmail.com>
Date: Sat, 18 Oct 2025 14:07:51 +0800
X-Gm-Features: AS18NWArOtnRMTtINnh4K3jHZx40uoPiTbZL0Z0Z-wYlBwboOmbl9LAV8iVv7Gw
Message-ID: <CADgMGSsxkrqZ3Dirq9KPoP0aaHew0A9DZEuoTotvqcHsfkEw6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] android: add bootconfig support
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>
X-Mailman-Approved-At: Sat, 18 Oct 2025 15:53:45 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Dear Guillaume,

Thx for your patch.

=E5=9C=A8 2025=E5=B9=B410=E6=9C=8817=E6=97=A5=E9=80=B1=E4=BA=94 21:19=EF=BC=
=8CGuillaume La Roque (TI.com) <glaroque@baylibre.com>
=E5=AF=AB=E9=81=93=EF=BC=9A

> This patchset add support of android bootconfig partition[1] in u-boot.
> With Android boot image v4, all androidboot.* arguments must be
> passed via bootconfig instead of using the kernel commandline.
>

it looks like the above add logic handled bootargs well.

is this logic support the use case of appending existing bootargs from env
and handle the one mentioned in
[1] for simulation of vendor bootloader behavior to append some
androidboot.* bootcmd to formulate a new bootargs? Or is this series
complementary to [1] so as aimed to "move" androidboot.* only to
bootconfig? If this [1] user case is covered then I am very happy to stop
[1] if this series can have same result.

Btw, I am wondering if this series assumed Androidboot v4 only, so kernel
ver must >=3D 5.4 and enabled with bootconfig. Since then bootconfig can be
unlimited to it's length. So all predefined androidboot.* from bootloader,
can now move out, and no need of default bootargs in env file any more.

And how about those Androidboot v2 case?

[1] https://lists.denx.de/pipermail/u-boot/2025-October/599708.html

Regards
George

>
> [1]
> https://source.android.com/docs/core/architecture/bootloader/implementing=
-bootconfig
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
> Changes in v2:
> - Add test
> - Add new command to be able to load and read bootconfig before booting
> - Somes fixes to works with sandbox test
> - Link to v1:
> https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylibr=
e.com/
>
> ---
> Guillaume La Roque (TI.com) (4):
>       boot: android: Add sandbox memory mapping support
>       boot: android: Add bootconfig support
>       cmd: abootimg: Add 'get ramdisk' command
>       test: abootimg: Add test for bootconfig handling
>
> Mattijs Korpershoek (TI.com) (1):
>       boot: android: import addBootConfigParameters() from AOSP
>
>  boot/image-android.c                        | 180
> ++++++++++++++++++++++++----
>  cmd/abootimg.c                              |  35 +++++-
>  test/py/tests/test_android/test_abootimg.py | 108 +++++++++++++++--
>  3 files changed, 292 insertions(+), 31 deletions(-)
> ---
> base-commit: 2ba64e303b2706e5c42a6bf982326d632342ca66
> change-id: 20241128-bootconfig-276e247be992
>
> Best regards,
> --
> Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>
>
