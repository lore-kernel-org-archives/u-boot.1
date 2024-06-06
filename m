Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E01C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21472883CE;
	Thu,  6 Jun 2024 17:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ce8K7s5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C4C8842C; Thu,  6 Jun 2024 17:04:29 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A575D8844E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ae1059a62fso6301716d6.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686266; x=1718291066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gA3YneqNXzrkdZu+O3/vTYbltBcI5XpCxOb5U7AkhYk=;
 b=ce8K7s5JIw5PVSakbtW5X2T4y9Y9O/6Rp5UOpbNbXCO683IZf2X8CIj52t8byInGoJ
 scdjPMoIQb4zyoiHG3k1llwJ1xZIulxVal9xQu5JVLaHiG78yHghH2L8V56h9sgbrrj+
 oNOcvzJ7lKI3UdigQ7JJDbcXpOUlucTeVfeT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686266; x=1718291066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gA3YneqNXzrkdZu+O3/vTYbltBcI5XpCxOb5U7AkhYk=;
 b=CXlKpN0IkWmi1u+GILGIgEeHevMbJcAEpAyIbpuZ4UUZqRduwudxHdPDIw+sclKsng
 z75H+LId+RGt4LSWsuLZGvof4BQPJ2OtnxbfFaaKmGqpiZ95MEcSkgNxGvj0rlt5Eb8P
 D17ePdlKffS7l27+D/CMzQHJk/zhI5WjSwhqTsb01lZJcLc6QI70uCcNFK1Nj6ogFThu
 jwMLFcaPDED/rWXYEjC0cMybvY5ae0DrfLIDDJv4kuJelSpoKS6vbmiWD0lgvNU7qgje
 YMZ+p9xWIiE2VJuRb6A0SZmb3AzjvPciW0m9kUbT6yCrJRleLp2IfSVCdIvtrMUUKxMe
 aIbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0m6BLu79IjZSWnkZwRZzslrxe4eQ/0wy/cZZd3PP37F+9kiDVERhdAnWsqAE2Vhp+EKD/CWWq6an/F3FZYfbbasusYQ==
X-Gm-Message-State: AOJu0YxuQOi8Q2bmcfKExWtBBiwmqtc8mbqdMwrkxs7lcQbSwjnGwvVJ
 4pt8BtfQskFoHN9Zbe320eVvR3BzjX7YeH2ommJGhrmber7nXMORCDj0EMqBZQNhYPjE1Lu6ja1
 HenZTkcqfnjugOXYCKaQaO6yI7xxjQikYNNxt
X-Google-Smtp-Source: AGHT+IGlyq41l1jmLO+IXmTB+537F876AUeMVsmj3WXlKnURzI2v5Q2aRPhVISNE1ZyjE8D3iQM76zoDVMV/5sjIE7M=
X-Received: by 2002:a05:6214:4b0f:b0:6ae:d326:a00a with SMTP id
 6a1803df08f44-6b0203213dcmr64672586d6.7.1717686266257; Thu, 06 Jun 2024
 08:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240605-pmic-rk8xx-v1-0-2349fdf68aa0@cherry.de>
 <20240605-pmic-rk8xx-v1-2-2349fdf68aa0@cherry.de>
In-Reply-To: <20240605-pmic-rk8xx-v1-2-2349fdf68aa0@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:15 -0600
Message-ID: <CAFLszTjBWjXSXgJNT_jikmPrQC9fJgZ7Un9LW91rPNxFV8eKEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] regulator: rk8xx: pass pmic udevice instead of
 regulator to all internal functions
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 5 Jun 2024 at 03:33, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> For the sake of consistency, make all internal (starting with _)
> functions expect a pmic udevice instead of a regulator udevice.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/power/regulator/rk8xx.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-bob
