Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19362C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4285405BF;
	Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ga3OR5pJezB; Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787150989;
	bh=8ln3Xv2GziFFYafvXdVtxBHJHJUBRvsZ+OvU0nmxRgM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ROgKTBhIWHFkWI3h2RwEVptEsV7qP2UCnTMzoBhK15lLxHfbByGgObPY/AwxvF96r
	 TlKFvv3xU0PZTAg4x5Gud94tfY0qrJEOhLQqcTf9bSozF0sapv/eHiuKHL8wo1um78
	 gJC/KrLw8VCDf5sMB0RNiZCNEO/H8VH+uqdAa5NkKbVN74Htv+dXn0Yqx4Tr0/UOd3
	 2Z4Kk6P/GA34YVOgexgeg3mbGeg+Cr/Q6hpix8nOC+zLnwRySFw+gMSj5fuCMckYMN
	 jSIs5Z5GZFSxIvlPvFrAaoh40T86iSsIISyNBJvKCfnik27cqM4FlJ7y4C6GGHceLk
	 adDm5YSvHWL9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 008214059B;
	Wed, 19 Aug 2026 14:49:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00E37334
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E67F360645
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nbj_d3fWxt1v for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:49:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ckxLDQ7b
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3648E605C9
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:49:47 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6ae9b721927so880962eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787150986; x=1787755786;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ln3Xv2GziFFYafvXdVtxBHJHJUBRvsZ+OvU0nmxRgM=;
 b=ckxLDQ7bOT/2P8uYw6KzHWz8+vqOutI8C6FeGSc2WhrxxgzrR9RTQaimC90uXfWmRD
 O0lwl9aHGvzhYqoNdBMsL6D2lqJFGU9KpuRgshadYx9nPuMUZrpJZoymQBiBVd4et2Wk
 3hLBvILy1FaJmJIPb+QJnFizIx9XSMmaKSKsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150986; x=1787755786;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ln3Xv2GziFFYafvXdVtxBHJHJUBRvsZ+OvU0nmxRgM=;
 b=VxKHTyKo2WNrp6fteeFA1SKLGrextiUM3eeiaJyVXG7PDKrQTD039hx/jKdu/dcv2s
 t8AtMfxYHIJJA4E9UofR/cR2j2Lkhj9TM+ao4oei02pIGFdpUHmJXmbZtWVLNXXfdXQ0
 23Ade4D6/ZVW5fiQV3UewD1v07zoUILVo5JmFmUW+ZYKpCqbsX0KrabTOICt72CUsu59
 L/6hnezkzpQvNLTm28D3/UcTGoIvOofR4kPmzXfzXKfSwt3QQ1Uef9wjv/y+cgqvGKnY
 Es66WOtPWEdJlMkmrxRSkbxn5rqknWjxqUO7CkCK/zdYHFF4YNpfJ08VTDqTVnDNnJPq
 K4Eg==
X-Gm-Message-State: AOJu0Yzp5JbUjxJkMcnOU116ylkTQ0NJoi8i0s5yUX+1q9TsQGIACJ06
 aXIsEndMU1Nu8dwOa9fwp7HicHrntyi/5DEX9LZ+TzGSUB3JAcLc9HD8jDljTmXDR4A=
X-Gm-Gg: AR+sD11P3iLGsosdqQ2tUvL0dsqc55AjpNlr5y4O2jz+Eng8pknmuucRnrdPGTToBa+
 Mwcz7RWicEBzRHUsEQjjaK259sSvay31hLi3ubQ/QkM5crQ4RxGcjP0EBI9y4zcvkNp2UEMxoJT
 dhM29qWL5cQeSFeiI0BxQk+chAn5PG0q7O7+gp3hbT7vaUEVWgeN5a5e/zt/umpQTv+WYptvsKe
 nyZn/LvLaU/ppjOdL8v9uU6Y8CL/vp74K6uGu+D3BPvJn9gqa715iNPYLNYQYFnPR7+BHudlzGY
 FkSHqMs6bwFcBjsa1FevoAtBAKZzUGI7LGnpR2iBJ0JoWaakfu5HapNwOCgAX70xbRYCgCwYo3V
 0mVWJo4ZP9ujblqW9avC3IZt3LENMkcdXIIOatttIV/zhSt8Jbij6VKaZjhupF1ZMcBlM1HEtvC
 toN5ZveA+UH0Y+ZC6mTjx4RXSKPQlfPMhXCYeluJCdyTLtIIBGFb8Byy9oA3U4GJMXHfWDqoowp
 nViLvwHcfIYH1m4xgRgrs6g1U2msY5+fC/aMfmiGsS8JtSggYfGh1woamEidUz/5uah7HgwXAfv
 +/7J5tDz
X-Received: by 2002:a05:6820:60f:b0:6b0:5233:f69a with SMTP id
 006d021491bc7-6b13c683544mr4439406eaf.30.1787150986061; 
 Wed, 19 Aug 2026 07:49:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-462e99f0f27sm2325984fac.13.2026.08.19.07.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:49:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Pranav Sanwal <pranav.sanwal@amd.com>
Cc: git@amd.com, michal.simek@amd.com
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
Subject: Re: [PATCH v3 0/6] gpio: improve claim diagnostics and fix
 gpio-delay offset handling
Message-Id: <178715098461.1496674.11078286640170859143.b4-ty@konsulko.com>
Date: Wed, 19 Aug 2026 08:49:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, 11 Aug 2026 16:23:08 +0530, Pranav Sanwal wrote:

> This series improves diagnosability of GPIO offset collisions and fixes
> four related bugs in the gpio-delay driver that were uncovered while
> debugging such a collision.
> 
> Patch 1 logs, at dev_dbg() level, which label already holds a GPIO
> offset when a new request collides with it, from within
> dm_gpio_request() itself, so a collision can be root-caused from the
> uclass layer when actively debugging.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] gpio: uclass: log when a gpio offset is already claimed
      commit: e3aa1ec1e3a319dd842486c2f933a0dd1958c1b4
[2/6] gpio: cmd: warn when a gpio offset is already claimed
      commit: 826d8b8b1771dba53fc799d312abfbd852728c04
[3/6] gpio: delay: set gpio_count and validate index against it
      commit: 04e3d07ebe6f4cf620754f828d4a7df6089a8277
[4/6] gpio: delay: fix offset propagation in gpio_delay_xlate()
      commit: 8df3881e173db02cb49306e2857d67c4502812aa
[5/6] gpio: delay: free wrapped real GPIOs on remove
      commit: 55752c23945b47fc68afa35102108e60108fc7d9
[6/6] gpio: delay: free already-requested GPIOs on probe failure
      commit: bb6283adea943068e4ef93f0bdc91c33a887f003
-- 
Tom


