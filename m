Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F58E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F183C89544;
	Thu,  5 Dec 2024 20:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBeoKuPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A4389541; Thu,  5 Dec 2024 20:55:22 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1D98903B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso160416666b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428520; x=1734033320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sShuCtIsdz3oQ2zKsnWV3C8yobzCXoRtjhIZLe8eMLo=;
 b=FBeoKuPyRN6VEjmdt7W8yerWe/dBLbHpFXUPqvgk/eOtbm/SWvfvcuFsdjlWIZcsnl
 CiI9hypAxELPWRQv2x+3wxWTG82j5ZZKNJo98G2XQXr5F8WyfXfqHsr8jnxejbn5fEfy
 e2thBuGeAzG+VKI94cB24R4FdN82Dfu5jy5Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428520; x=1734033320;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sShuCtIsdz3oQ2zKsnWV3C8yobzCXoRtjhIZLe8eMLo=;
 b=XmrF9olw/dOexMlHUPKcKBWv+Mx23qlTv5BTpmGH9QkEERBaUYUyBlorHsHAX1zjuF
 TvArYO9xzOmmx//aNkLzz54ZPG6vD4XFruZaewBQF1KHo3WMCToLpIOQv+wtC11AvNcI
 sDmjt1hI4FPX8QDQ10fv0157nS2/n+PlilBZksBqF1x8e5I3t1Xf2CpU3fluz/PpuGYt
 k9muGM+mvL1z2U/5jZYPqph1VwqwqMWd4FI11Nlc1chESfVlKVeJLVF+1XeNsoWOS0aO
 +9JrezCsqt4ixC+7Sq4UdKGoJbsKZWKH05STeaemfvBxZD5oiDOHsHmAHU9vkVp/2O18
 rsOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjrjhf2JwYjaoy2lLJpFIe8MFfC1BMDtUbxlLi8MoW/zLN59rejr94yzIIUO4VWVVtWonaeDA=@lists.denx.de
X-Gm-Message-State: AOJu0YzlNVklAzd0enDHtkJC726KZswQ8yzUxicopY5dWbGIRCyiVkHy
 z3c9pH7Q2N8BwtOyh6u+oZYAB9BY9ix/5Qj6QayV+9QcGM3wi+AQgXASM0oNBsZyVU/8uKvA8yu
 hckRM3GHzWypXWT61kpPHMUP3WyWucKgGzpvj
X-Gm-Gg: ASbGnctdwnm43arM0/xu/ODT2xO0/hJcT0LUqM7IBjJXCS5bEZN2Qi9RVD/h5VmxsBR
 4lukhWh3byy+BNCrl2weUOYhTurlxqzR8
X-Google-Smtp-Source: AGHT+IGHx5xvOFT/OHKPh01M7NYsPXO5ODz3pNSvbOV3+WaeXwjcRWkekXoPVesutIDGZHcF5ymd2d3O8NDZF3P9w1A=
X-Received: by 2002:a17:907:7802:b0:aa5:1ef5:261f with SMTP id
 a640c23a62f3a-aa639ff6e4amr9858166b.15.1733428519887; Thu, 05 Dec 2024
 11:55:19 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:16 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241201144240.1664398-4-sjg@chromium.org>
References: <20241201144240.1664398-4-sjg@chromium.org>
 <20241201144240.1664398-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:16 -0600
X-Google-Sender-Auth: yobsh4wSUGNj--fRhUDdXKsQB5U
Message-ID: <CAFLszTg2Fhmx3z4uVFCs5ykqnKX6eP66tFOUfi=uSuL31MkPEA@mail.gmail.com>
Subject: Re: [PATCH 3/8] Revert "fdt: Correct condition for bloblist existing"
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This was a work-around and it isn't effective, since bob and kevin are
still broken. Drop it.

This reverts commit cafde93ec02d654a092ee5b3fd0ed706347a9744.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Applied to ci/master, thanks!
