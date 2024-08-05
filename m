Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A2C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 23:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9460488901;
	Tue,  6 Aug 2024 01:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T1TEUk8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B6A87E96; Tue,  6 Aug 2024 01:01:17 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E1D887B4
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 01:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5c667b28c82so121648eaf.1
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722898874; x=1723503674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=syATQRBnaxbtSSaR7nG9i2icxtKr4S7m0oLiUdntX00=;
 b=T1TEUk8hGsxGlJMYxooSDKvlt9uRdjR42J+vqwS/AbPcY5qRDhIiz/C3qR6tce4Ki1
 YUSKQHUf3ie7dM0c68O0aD2tYO1dslIl7ki3C8VwoYLvVXeAOOXSJVUxR0QDDom4mYF1
 w6pZQbQDsSAdzzVKkh2xmtkchw36mmVKt6jPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722898874; x=1723503674;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=syATQRBnaxbtSSaR7nG9i2icxtKr4S7m0oLiUdntX00=;
 b=P+3avQZ6rLjb4DUMGV+Pw6oG7atIpKn7ejcXpdVIhTwS4BHcai+F8QKMuxEVPdyeDM
 l4A6eScVUxQJ+Lb+BEvRhEWrWh6Tvx3FOUBFnl6ZO+F3nPdRY6YsDU9x+x2Ecl0bXLfq
 11AZKzv/MIhHfzKD+jh07Bha9YNISaxKd08E3AsP4gSPeM1mJlVH8xnLShCpJknS8joh
 ztooVVVy5ItOIhl28k3zH2KolMIpwB/8sz960pqKWyXmToHNGaCWWB8lq6xcxV7XFJfz
 +9Tq3B3e3F/ykQ5HSPVQxbrevYHjvtO8hLSeLs75N03CmAoauOGfp2yFLsyMYNUQnc2j
 UEOA==
X-Gm-Message-State: AOJu0YxvYP7bLzKBRquOGyX4hH9GySrDhCxT6YILFd336wJVQXGm+qBZ
 NgUdUP21Z2BOoVd0Pm49Bf8EEy2hMhw+tYp5jaQ0OYSQeZmyzXRucO4VqMfjahXWK8SOodDPQfa
 Xjvc=
X-Google-Smtp-Source: AGHT+IFQBx7uF/hPJBA114cON3numnR9P+V4PsTK6cnHeCmoy6zMr/oBqcnB4KMgRdtrgp0IIackrA==
X-Received: by 2002:a05:6820:2281:b0:5d6:510:6acd with SMTP id
 006d021491bc7-5d6c8143f93mr6595743eaf.2.1722898873906; 
 Mon, 05 Aug 2024 16:01:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d762052af1sm2246436eaf.28.2024.08.05.16.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 16:01:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
In-Reply-To: <20240801124723.770213-8-sjg@chromium.org>
References: <20240801124723.770213-8-sjg@chromium.org>
Subject: Re: [PATCH v9 7/8] rockchip: Ensure memory size is available in
 RK3399 SPL
Message-Id: <172289887312.1534766.1592007483972042174.b4-ty@konsulko.com>
Date: Mon, 05 Aug 2024 17:01:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 01 Aug 2024 06:47:22 -0600, Simon Glass wrote:

> At present gd->ram_size is 0 in SPL, meaning that it is not possible to
> enable the cache. Correct this by always populating the RAM size
> correctly.
> 
> This increases code size by about 500 bytes in SPL, since it must call
> the rather large rockchip_sdram_size() function.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


