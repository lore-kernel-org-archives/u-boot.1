Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE578021A;
	Wed, 18 Dec 2024 14:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xC1bgnQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432698021D; Wed, 18 Dec 2024 14:05:41 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE42080214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862b364538so430317f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734527138; x=1735131938;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joFAF9u4JgEKng3SUUFiCD2/CNMMIS2/NycxO46jZUI=;
 b=xC1bgnQxaM+88hBq4LB804KzmqeCzTIKgX6dTMDYa4dlUthhTyrNL8ARvQ45b2BX4L
 R1FGwVRNaoJfL4ikowk9MnhM4DqIBMEqmiqSpk1q7UudJQzG3t/3oiw2jjhafoNxn+aJ
 OF3xzzFNjYIJ0dZgVXFEVSLYo4B2b/N/ctMXOcVC/lBClRRhAZSjchEMwJ6HG84ce18F
 mhqkna33p85VsDAQC+uwEukCLe6II4u9WdrNhFShGsKvwo9nEWgXFG9bKVyVDqmSTXBB
 UGCaM7YVpO4/ogwOyceAs+367VcgzQIPlKEkpYF2J3XBtTv0AjUaHOd7kEpfrBmZWivu
 Amog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734527138; x=1735131938;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joFAF9u4JgEKng3SUUFiCD2/CNMMIS2/NycxO46jZUI=;
 b=OvPRKSrWzZ+RQkBbYdT9/T9VIkke6YJAmyFtmuxubRywkE2AVs3gURDBnw44JpS7Hm
 kXuqyEoJEE+MjUvuqNf1SuJaBcf/gJ3EKGgwuvWDkJai3p+WGLEUiSW77XeC/c8rsZn4
 I1lY6svCWjCzKCj3qoqypje5gpYNRqipeAvwdZBJPLnXoW3LlxJS/n+wIBr9nuEkKHJI
 gKLaPTKIkMaaBE/BUvVxxkHfm738/DJywcWEcYNNteZQ8dJ/+NpT+ZVIhvxjUMyho9nc
 nM+GbzRRhGC5NDauRX4JnshD4tHtZYMu1MwBmjukgtgIXJVEFwJLzZXfPx/8VyC9W4A3
 BcLQ==
X-Gm-Message-State: AOJu0YyBNi9/8E8z4yg5ck7JLjV5qpyznu60yGIiYM6Ai4OHWAu+Wbv3
 2MRaeaCJwgdUGdiiJXy2tlb8oeIerI2Yuc6lM06bdz5Fkmiuos/vKsRDatOlwaM=
X-Gm-Gg: ASbGncs22BVulow8OqcWr59F007fz2ks2Uf5bTvgRqwmDPPCh0Q4d/6ETZzAE/8Y7em
 Ymi+gVDtp7Vh+8amsrsUvgiO58xj18Yw4jMCwhcVRraa6rLr0tMrNH0tZJvlrOph4MtPyMD/Tkg
 uZbqdM9N6y+7HnJkjGK7AGaC/uwXY7RkfVHqgHL+XEmaSgbwxtSMcqjK7vC3I7aiBIW6yaHSyl8
 HGfvIuv4F+PQjLInk/6zOjrZgmCbo0qg+EJjIyFnYFK05rVFRF5YG9sUdPTxIg6Uss/PskK
X-Google-Smtp-Source: AGHT+IEoh7LSaAbCnDN14R9k33y9/qBKNzJC1M9zdz6QVI+3z+tnmOMbuVxolcrLRwFiVcNCqx5XRA==
X-Received: by 2002:a5d:6c66:0:b0:386:3672:73e4 with SMTP id
 ffacd0b85a97d-388db2939d9mr6624706f8f.26.1734527138359; 
 Wed, 18 Dec 2024 05:05:38 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b013a1sm20415845e9.11.2024.12.18.05.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:05:37 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Safae Ouajih <souajih@baylibre.com>, Ahmad Draidi <ar2000jp@gmail.com>, 
 Nicolas Belin <nbelin@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
References: <20241217-fix-bootargs-concatenation-v2-0-b2fd7cf4e130@baylibre.com>
Subject: Re: [PATCH v2 0/3] boot: android: rework the bootargs
 concatenation
Message-Id: <173452713770.1832219.4083670486821711343.b4-ty@baylibre.com>
Date: Wed, 18 Dec 2024 14:05:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
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

Hi,

On Tue, 17 Dec 2024 14:29:07 +0100, Nicolas Belin wrote:
> Rework the bootargs concatenation logic to make the logic clearer
> and address several issues such as:
> - checking the value at the address kcmdline_extra instead of
> checking the address value itself
> - freeing the string that was malloced for the concatenation
> - making sure to malloc the right amount of bytes for the concatenated
> string, not forgetting the byte for the NULL termination
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] boot: android: fix extra command line support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/53a0ddb6d3bed9f9607af79934a7625299c36793
[2/3] boot: android: free newbootargs when done
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/fd8b44a81be55b33c7defbe96a1ddd79ed286eb4
[3/3] boot: android: rework bootargs concatenation
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9e5fad0f792539ae4258bc116bf408bb6faf7e82

--
Mattijs
