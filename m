Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2582AC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 17:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C1F82B3F;
	Thu, 17 Apr 2025 19:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kmZQQ0Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026558304C; Thu, 17 Apr 2025 19:06:43 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE17E81E18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-603f54a6cb5so501624eaf.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744909599; x=1745514399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dwZyvLi/dWe/KteSOLDv+jAKjUpWajh/BiOZife3HM=;
 b=kmZQQ0AjK3zvq+ErNdIEQQ8bB8ExeUHICxxEWBei+iGhkkGP67GP7YpApMMBt8217D
 l3kDnzUFtv2VNDoSWTrR83LxbWnkYmVvUP2jiydg6e0oY/QmIb8ypr0b08Y9kTwubzeD
 K5TmM0LGGPUgGGZUBgl/gNgggf3GbPFuYRqes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744909599; x=1745514399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dwZyvLi/dWe/KteSOLDv+jAKjUpWajh/BiOZife3HM=;
 b=rAuE21Tj9gaW6GPTvOuS8vZAY1IVGZotM11ZSENlsn43PN2bZqyEj1hP9WT93SBPMW
 Gas9mbSceGvaaVDbFNkeKIp1USJySzSCo3hA5inefSwAIgPq527AcQv/ScWkpFr9yi9o
 OIuG/Brl9NsmJjynEVUDUZefSGi6815XVREegq+g8vKeMO6Gu/NUwMOUiDWXIhFcoFwQ
 sf7BiYZ6BDIt9XHJzhpPCo6fwFKK4hSWN1VANjOgXJExmSZSavUkjE1NwsT7CDhtGA1N
 0+bMWqXvEU8G651531PWI/WVoqRvoCJZpmO5acHHPUca0l/q4Mn8oI9nHyKsIUV6zWB0
 dhng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHvn7BN2Wj/PtM7Vxzn9U81l5dfE4KfCes7pg5+0Bkg+hKnxVDRQDcfo0FnjQOQyDE/AoFPYk=@lists.denx.de
X-Gm-Message-State: AOJu0YwwBCQX3V381ySyjqkcM9L/pPi3A7hgpH6PQzD4AZNoZN0Ubjqx
 OrQR6ILwV6rEKP3A+a9mviblUCmr3FSsi0Ab4Rau0cR+ii7gTw75QFzJgRYLCO0=
X-Gm-Gg: ASbGnctAl3fmoJVPfJm4FNq/mcBWhIyFgX46oGqGB65V6NNZHnYhzwAV0k6MmJCOlyF
 rdpscKOuVkjg400U4lAWlVHuQlJkMlGp7U7LT3foI2WbcdHDAdJuHhmncLXzChfMe7Nctr9V1XF
 4R52D6q6C7GAt68HKVCsecEOO+Rw/LXZkXgrdm1AsjkdyEEcNcvoOe88bzniqQ8NyVl5p6/YM+z
 AYmDXLsvVHdskuSEcAUlX6P7q3OsqzATXTctEVlo8bmtERtrWupaoOmsEzwqJZJUZW4R83WQIle
 5NrfmPrO0/LyVouAMdv9PoMKos6Cml9L5/12xkxwqj6BcFMYEtXBY2uhnOgpZrbz7Tk5LVUt3jG
 M
X-Google-Smtp-Source: AGHT+IFTh+nsZzNRg9BwXXx7uBcS0lq7E9nc9NTKBVdyzV5UsMuRCCXIGWQTvHXHsW2yvbJaLi+kHA==
X-Received: by 2002:a05:6820:2288:b0:602:2bd5:121c with SMTP id
 006d021491bc7-605ffde11femr78831eaf.3.1744909599637; 
 Thu, 17 Apr 2025 10:06:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6aacf5sm28411eaf.39.2025.04.17.10.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 10:06:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org, 
 marek.vasut+renesas@mailbox.org, paul.barker.ct@bp.renesas.com, 
 pbrobinson@gmail.com, u-boot@lists.denx.de, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, 
 lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org, 
 ericwouds@gmail.com
In-Reply-To: <20250406130244.19496-1-lucienzx159@gmail.com>
References: <20250406130244.19496-1-lucienzx159@gmail.com>
Subject: Re: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
Message-Id: <174490959839.2996754.6527102139416317681.b4-ty@konsulko.com>
Date: Thu, 17 Apr 2025 11:06:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 06 Apr 2025 21:02:44 +0800, Lucien.Jheng wrote:

> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Based on the Linux upstream 8811 driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] net: phy: Add the Airoha EN8811H PHY driver
      commit: c9c8df2c377e512553f2e9ad5d19c4b85efbf07d
-- 
Tom


