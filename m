Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562BBCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AA084A12;
	Fri, 19 Jun 2026 14:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4a5EZQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CFC8005D; Fri, 19 Jun 2026 14:46:27 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B65E78005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6976c215e7aso141809a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781873185; cv=none;
 d=google.com; s=arc-20240605;
 b=WYjNDieATlDuCLTjZlCBt1DvxtzqofP3hJF4XRVk26os8XHJOawio8VtiRo0cXmA7Q
 VhsPHb8+AxK/KmpVJf5HFbRmLH7k0xbQnU+zvyo01MJ3ON27WtV/BeLeb16RTccsLMB0
 6aOqliocTVG5M0rnx2Pdf5OAbjuGPYi7I6UT3DEEqqF6Fa5AEOKLYuVP4mt8hnt4Gu7S
 GC1aTZzZMe/rS+Xq/r4oviBVt7liT3AQAOnWalRs8FhocRUcgtX1oObYj3OiQ8xKrHRp
 13MNggdVWz3ulSSr2xyxxB5ngaUa3flTGke2eJTZk7UI0k/jNKyrry79JgBN/3WgoBzI
 KaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uKQGxk/lj6g8WCV0yPB22WWfCUo86fpNZkqz17zHdOQ=;
 fh=+3/f7KQNTqx8teaKoM9SnDS468SP20XJ9ivCrD0fOFw=;
 b=LPJKj78xKct92nt38Eqng5jnOWWU+e6tz3hJTILOgiTVC3rfAdIHgq+TDu3Nt9z6hX
 jVDPU6yhl8QAmyUrUgbCIKRgJInnuULufZeuC1EVuPjYL5fqlvW5LMPkL6nTXXBr50Tz
 bTdMvvkTexANpzBVK9sGlCMHpIOLld/efX2MrVv+jpVAFxPWPsVrS8El8ysy5uyoEkwC
 OjYZA9TWGWI31XWNQnbYEjEDvLcGb1uYWBKp+M7x4d61BFIu0ee0Vi5Rn7eJFw90KAF0
 67qbcumz8jECBiQW5IVLW8/UkwoCRCrt/46r8eaJ3Vr1iVdEkQL0SAUfB4cmxmWbQXPD
 sgTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781873185; x=1782477985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKQGxk/lj6g8WCV0yPB22WWfCUo86fpNZkqz17zHdOQ=;
 b=S4a5EZQSzvVhMOajE9vvTIA2j/wOFrrQ05vl2egAypufRPSC71/u3HemWIQA20I/8M
 snx97YQt5Nzeauz9i5PMVfcJ8aTpf1M3OOxCQ0zdpjmJ1T0r9yHPisLFGmqlY+J01zRB
 Rd9whB3TF3G6Wsa0g/ZaOXs+AgmOmeAa5Fh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781873185; x=1782477985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKQGxk/lj6g8WCV0yPB22WWfCUo86fpNZkqz17zHdOQ=;
 b=lK5fiJZ/J7TcrxIGbKc6eR0WJaylCAVwxoJc0aM7851M+4zAUmhukuNxDl9Htqp3iU
 Bt4EPkgtkJ285TShni9K2gDeSKfUJAZyXEsJFh+++na1FiNuFkVZAyosFzlhFHgwz2sQ
 2sAHNKdd9LBesCftspQBX0+4ZFpKaIQiJUGEduLQAvobZczvXqGl22noGUz/4YJwwXSr
 1R4pToNZnSeROwkb9+0isZ6W6wdirSdnt9hNvhxjxGZQihYe1D3xOv7e5uIyS3p3vf80
 5q5s2dPh+trM+6lC4Bqg+vhzftAbxfapB5QQrclJKlMT80nRF4ng1/p85dbZcu3qsPvG
 AXFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XIRO+WRjj2hz9eRqnq9xun/Z/ZCznfOXHOZlqrEGlBmaM1UBkku9PzIJ5GB1iNclR2s4sb7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxD9gPCB4DnZgvgZuHIjHJEfobCjb2inxvde4VOBmPFGcg5iaAZ
 S8OVG4V5pwYH/HlNs6CHsQweRBHIJJ9riSF2a8O4nGXZ/Co79kuyP8bbm9R4ClIZHGXkGhyimUK
 7x11IoFSrAfTN8TYxkWvbll0N+Xv61t87Tlxqj+cc
X-Gm-Gg: AfdE7clEbenE0v+Lv1J3AETjVvXMvkKwRvbbfnnVlXEBkiouFRDS77ujZJa7jwr1Ey2
 krTUWlft3AWKblLAkvpk0GrX1p7+klAGRKiUVDf0Zd4LTLyp6vJ4v5Z6ehSCtUT4hoY7pdjEQ9W
 9DPfXNw4SapjOVuAnlp/cHYlsQt7t6Iwm4N0u3OMUbOfKP4Tsm/7KX9iNm2jYKpCqcNmH5XrDKg
 d/rm4EklZ2GKFr6tPK/riAmiTWeobaqHbUTOH24+DIWD4KBmg6WXMb22aP41MhEE4cNC82rPw==
X-Received: by 2002:a05:6402:5309:b0:696:9973:5cdb with SMTP id
 4fb4d7f45d1cf-697569b97d2mr1010665a12.28.1781873185235; Fri, 19 Jun 2026
 05:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-5-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:46:07 +0100
X-Gm-Features: AVVi8CeD9NquUBFIL_SsTyi39Q37N2oQuaKNV2DDxJrqh93mI8Z5VnGTulCbOA0
Message-ID: <CAFLszThrapYe9O7=x3DRqrYUPFKqhYgnKZ=0fXL1maethPNzqQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] misc: fw_loader: implement request_firmware_size()
 OP
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement request_firmware_size() OP
>
> It might be useful to get the firmware size before reading it to allocate
> the correct size. This is needed for case where the firmware size change
> across different firmware version and is not always the same. In such case
> the only way to handle this scenario is to allocate a big-enough buffer to
> read the firmware.
>
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated
> and dynamic firmware size can be better supported.
>
> FS loader is updated to handle the new .get_size() handler.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/fw_loader/fs_loader.c        | 68 +++++++++++++++++++++++++------
>  drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++
>  drivers/misc/fw_loader/internal.h         |  7 ++++
>  include/fw_loader.h                       |  9 ++++
>  4 files changed, 91 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
