Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB8BF436B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695B983FC0;
	Fri, 17 Apr 2026 17:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MWv0lIcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AAE7842E7; Fri, 17 Apr 2026 17:52:36 +0200 (CEST)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34621842C7
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-41c4d660b19so240026fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441153; x=1777045953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9D/+59rZ1qq1+gfHDRmX/g5xBBfAt9Ip/dB8g55BcXI=;
 b=MWv0lIcrqBnYqvN390X5kiz017J8NU0knalkoUD1aa0E5cJHEcBdmGQmytYjR8hAYh
 MTG6LOMrVcj0NDywPZTvk55/X9hg0FEpV6hC+MsbL+ktgmd6RRB8ikU5WBPKSfIw+tMk
 nAYYXoQExvqDnSU7wj1dYq/pDewkP1CqEvTlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441153; x=1777045953;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9D/+59rZ1qq1+gfHDRmX/g5xBBfAt9Ip/dB8g55BcXI=;
 b=gdciV+UY8RYFBXY21n1WOO/rUSUYsMQN4B6KjLSqSttMMkoK14ShlX1tYwjS7YFBAU
 Fv2SKVWE1K75hPBLec2Vw11PvaQBul99IJukfM5TAYreNQvLAmbFlSU+EEEBKNyBb7dx
 /rc8jkYK8c+6ifjXrLa4quhNGeFAXELRXF/6+cYAaRoB7YFOgsjxZiVcDb54DGC239fB
 qoQzgAGEQ6w9W6M9AUhgE4obNIyoaCtVmi34XqMrIhCUZ3o3AAm/y2diAcPJKwOV/AJt
 pK0Q4mTCwm1BHawkkHY2b2m92F6xYyyXzlVKJfe0IF7PUKAzFCvzYDwKnOBCZyOtaufu
 TZlA==
X-Gm-Message-State: AOJu0YxzAuIZ4FYaCKGyOChHb8n5RafclY7nYEz4lWWuVwjGGeuNNzOM
 IJn4MPqvdcs41Tx9b32w3uLHp9pzlOiKcGCq0Wj63UgUf6rSzoLXCcrAeZjYzBEuoRo=
X-Gm-Gg: AeBDieuu8bxFkCO0iE183+lJ3+q2q+20DmeQQSuUYtPoXOtU0spUFEitW9xamML3vBK
 LiIkHRezM10KGJE0FVN6XIv9OzhIX28uDhzfcTykDkIb4N3BzBVG402hsBrvRTWVx0CroEyPXhN
 2ZU3PxtdkpZ9w6/bAIFBUajQ6o4vF3NPIH1KPzFhJ/UuqkSNg/Mgs9P4cravCjNtawPUbICdWPh
 gYul7aHFXpUahQyUI1FpQ9XO3DxNI0KPp+NdgR2BGUrKq3HZhrURqOyGLuKxvQJFhx1agQ6fT82
 6HHNlLd1PDNW3M7WnMVUsmCO8W1d8cnZy78XayIDszdivXKb/zRy+WWMOqMVWijr0mMKJ+ltDIu
 Xb9iysvY1dNVGEbiX7UTP9vgnOWCP9oRn29zzx/dvdNJTE81Bzs6m5d71vYHCFLUYJkVgXnYSp2
 SsW8QY8riS9vtYASNb33FfKrzAjb/wlfB+acwgN/OJ/f43fDw7t9Mlp+t5aBHergvYjv2R7qXft
 wZlXCQ5enKVc8K4BR8jlh4HywbQ7PNE/fDQ9Y28QoaWYOPHi6ZxBfnAr1bY
X-Received: by 2002:a4a:e906:0:b0:688:93a0:85f0 with SMTP id
 006d021491bc7-69462ee8928mr1807610eaf.36.1776441152846; 
 Fri, 17 Apr 2026 08:52:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chen Huei Lok <chen.huei.lok@altera.com>
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Kok Kiang Hea <kok.kiang.hea@altera.com>
In-Reply-To: <20260318025905.13304-1-chen.huei.lok@altera.com>
References: <20260318025905.13304-1-chen.huei.lok@altera.com>
Subject: Re: [PATCH v1] mtd: spi-nor-ids: Add support for IS25WP01GG SPI
 NOR flash
Message-Id: <177644115176.690930.5172377201427332303.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 18 Mar 2026 10:59:05 +0800, Chen Huei Lok wrote:

> Add a new entry for the IS25WP01GG SPI NOR flash (ID 0x9d7021,
> 64KB sectors, 2KB page size) with 4K sectors, dual and quad read
> support. This flash is used and tested on N5X boards.
> 
> Datasheet :
> https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor-ids: Add support for IS25WP01GG SPI NOR flash
      commit: 3e33474a0c60502d96c6eb215b635e2397110a74
-- 
Tom


