Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA790C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 15:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10F9280962;
	Wed,  5 Aug 2026 15:29:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vfPqdgvDO4JU; Wed,  5 Aug 2026 15:29:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61F96808C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785943777;
	bh=c91LgRJYStfrfIdB+8dbKqY8Uz9ers7mPjtiNz+KVrE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Atq234FcBk2CnSSdTCPo98C8n2MuPLVKMpQJbmX8w7l9Sqb/p11YmWtuLU0AVQ54N
	 bEvapmXgDAMQ/wC29sG3YOLQy3OIwLyGSqeho6gp2hb5HfqBDQMWRT6uz6fh2dleKW
	 wWqJnoQ+OzxHuy/xH2VQD4Ii/7RYkBAuBD0XcbW6rWQ2aRFT3goOrvHHyvM2Jjro7x
	 0hod+7NJadZ4ECMF8hiLSHJxrKCzfJ3pjPjYMpgTotJi8mm6majlSXqeL5XRAFMyc3
	 kLhMGwP/5Azz66Ok4omNk6A0iajjLIJlnAmJ4ZBcusYDy+VMQNVFaNoaG4eziWFzLn
	 k4APZXqaBdPMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61F96808C4;
	Wed,  5 Aug 2026 15:29:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DCCE218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F8FE808C4
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PjOXauIk1dtj for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 15:29:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 888D5808C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 888D5808C1
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 888D5808C1
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 15:29:35 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso10772305ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 08:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785943775; x=1786548575;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c91LgRJYStfrfIdB+8dbKqY8Uz9ers7mPjtiNz+KVrE=;
 b=pZGQbgJxwNyTHpYtF9yWrdCHBGZWYthfSz2zzHWEHjBogRYyw9+0YUPcJZ7R2FxzcF
 1gIcvkkJHY/xJan2daNm7RZXZS+asw4KMU/lCjMNkmurYin9ZJe329eLH91hK8nWTWS2
 pBJhI+L9bcgjvoQ36W5WPjv21xtkwmQacjOhxRAhmjPzcR9gx7v2Zf3pP0gKSixSTqbh
 ChMQqBuLIVE++0OoCEnA6IP8gyh/gG0GDI9wxd79qh1AdlLu/2NHd6Bd86+x0DsCSCdN
 EAAa0RZFnan4vx/q454C5I2SvH5osL8D3wl/5AaqtOy9S1nG6itq95zrXQJmBYTXOwZw
 bV4w==
X-Gm-Message-State: AOJu0YwDO6z8JsSH18lls2+pUa3gxAIwHOfKQ7PI+hI3mdLe2V+a6ew9
 5JOCOsdlxKAfXZLm/9ySQXbDZBy0Hn98mfZAQy15Fy2ZrgDx0kgMolypdbqJeubxBAw=
X-Gm-Gg: AR+sD11T7nNoj8Ly2pLX3k+NkxLq7spDQqI4jJMeqx6kZfiU/Wzk385kezBtedTqQM6
 uA/8umohy+ZvZiHMs/+gUZJy/oWuwf8YL5TVQixtjxQ/tqvrm52hgYkCVITHczSRL3okvutPvX4
 7TTHDM0qDpLIVy/hN3MwkO3QZG4NcEmNhFwsU/X/xsgdth1J1OxFQDWV8mE54CBPoGFhbJXO6ej
 t82mOGBfYjWEhwp5g5S3QgX9lop2oW1/n2AKihulNBwro3I0NH76QXmYa7IhdH26Tw5IkIp42wR
 hvV8Vcz+JyIppBTjhV+ZNe2f+r+fJuXzIgYroENUALrbRI8KPR77TCtO7sShxtc4nn7Qy8zdGJw
 I4ZsA8GOX8ST7ntBcF8jdeqlaqfehfFAiHt7Q42WY87zZS7SI8FrGXiuLFCjnduoy/L3DSLzZWt
 2zkflf8ZXHyU5JbMSn+NBpcRZ36rJYjBwEUtMo8erSavZTgRKR2EFWMX0FCFPyXAYabBLKGUHFf
 2AOxQ==
X-Received: by 2002:a17:903:324b:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2d0ca7fa969mr97465155ad.14.1785943774719; 
 Wed, 05 Aug 2026 08:29:34 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9f93726sm19645845ad.4.2026.08.05.08.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:29:33 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:29:25 +0800
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yao Zi <me@ziyao.cc>, Andreas Schwab <schwab@suse.de>,
 Michal Simek <michal.simek@amd.com>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] board: sophgo: move ethernet driver to common
 directory
Message-ID: <anNW1bh92tFnaFzm@lliang-1876.localdomain>
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260723-add-milkv-duo256m-v2-1-2e1373dbcb8d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-add-milkv-duo256m-v2-1-2e1373dbcb8d@baylibre.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1785943775; x=1786548575;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c91LgRJYStfrfIdB+8dbKqY8Uz9ers7mPjtiNz+KVrE=;
 b=HUJF3zgf63K89kLBoMhVCtOE0HH0iXzhKpIS3m736GIUypS3AD2AFIAObp48stL0Z7
 xScPA1qepx7WCLFrgKj9gKc8QOO6ZUQvrgOsJqGbssp+t5vdY9/e1LL2lRJjHm5OZdZO
 ztGZB6B92oNeJzr69blgEISSJCBW2AH0ZiENSeZEZv63l1vs3kUybq8/bNsTnYsJXd9e
 gnDY3QxhnkYmcZHGyVbFFgDbQqmUdLcw9Ijm8PJLqjOtWPKDcJtKhNRU+nNlGmD4zvs4
 YBPBHl2wXwe4DPmIFNo8E3fSsq58tdLVpPB5ubAkrxGG2XT7yD6OolLpufCOFmMK2Onz
 Pl7g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=HUJF3zgf
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 11:44:34AM -0300, Hiago De Franco wrote:
> This will make easier for future boards to reuse the same driver (e.g.
> Milk-V Duo 256MB).
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  board/sophgo/{milkv_duo => common}/ethernet.c | 0
>  board/sophgo/{milkv_duo => common}/ethernet.h | 0
>  board/sophgo/milkv_duo/MAINTAINERS            | 1 +
>  board/sophgo/milkv_duo/Makefile               | 2 +-
>  board/sophgo/milkv_duo/board.c                | 2 +-
>  5 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
