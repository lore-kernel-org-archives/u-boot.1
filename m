Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57534D5E373
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 16:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 669F588B9E;
	Sat,  9 Nov 2024 17:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qpx2MGi8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E208909F; Sat,  9 Nov 2024 17:38:43 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8494A889D2
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 17:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so3637703e87.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 08:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731170321; x=1731775121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jgdZo5vj67WriluwQnNBxArLT7uJTYxuFizW+j5iTEU=;
 b=Qpx2MGi8G+lKiUE2aS/9ERKKzF9VvyrNI4gGKRiF3ohdND2rnqK2/0XP7UCNhiDxzb
 oeYnGz5GtySqNMigUfF2xjWjdO6AYGuu1npynQT3nDPkNbiplYdQTWfDI23LL5+Hs8Yg
 6lqXhl+tV7a7rVqhF5gOpXHHCigz6Wr1lBAJFIrs2BCr3SRQqkOzNi4qgeWaXEoJoBFs
 OQp0ZPx1lJlbw2IuIzWoZ7qMfYmcaj3+cIUxmGCDQY1PVc47fgXe3ZHboZ0a0i2XedAI
 eYAwUpHgdtUDClcqUQJaEsIzKEslWuY5YoiFq1bLy2XIkH+VJUMl13lUzoZeBkm730IA
 u4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731170321; x=1731775121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgdZo5vj67WriluwQnNBxArLT7uJTYxuFizW+j5iTEU=;
 b=cWjlBvE9HnovIOYM+4iIjZ/3Qa50xxFKVcZiqMvr7Z1zwGaFBBWIvKiAFo7NYgG4Pr
 zjmWkTGa78x7opdSCvN3y7UNAQYNFqIWl4oEf3YoSF9il4oN5LNDy9HSfAHTOHpaVI/0
 X7GYs0iIOLLr2MZtmQ5crVgKutAxEZX0L9khUz5QQ5006ZIw4ivyCqqr4vNoq3zHrmBZ
 0TkwAPr7BeabbeHux4SWvOaaeaRtPS4mi1g6kDvbvJT9p6G7cLjVE7gVLvxkLj5uMQPR
 cpqmP6ytpVuCSCRAkOWL4Bf73LC1kID/TGw56GbO3wBSAJ8MdsUL3vvcpAstd4G7KynD
 XGaw==
X-Gm-Message-State: AOJu0YxEkGv09MSfpvZZDxW/mNfYTQiIkgVI09R9IY9zBbA2AluRsFR6
 azVx0Rr70HF1KpMOqJxRltEJwrv2Zlnw/SW/Rhkj6hOk9lsmTipWgtOsScPGlXkN4hBAtVma9Is
 HO4uZP79NCieOc9jRZ3DMnD0pRlQ=
X-Google-Smtp-Source: AGHT+IE2uu5stMkT8OHb2CZ62ZtyLEr4VzcN4ASomFFSiuRimgT09G0A35aHc27uoogUmvFtkZ63ZEqUtACJg0G2oZI=
X-Received: by 2002:a05:6512:23a0:b0:539:f7ba:c982 with SMTP id
 2adb3069b0e04-53d862cd6d6mr3386739e87.33.1731170320443; Sat, 09 Nov 2024
 08:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-17-hs@denx.de>
In-Reply-To: <20241108052143.26874-17-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 13:38:29 -0300
Message-ID: <CAOMZO5AY4pD124FV_GSRD9eLNzNdZztLj+jVudHtG2+UgPVq+g@mail.gmail.com>
Subject: Re: [PATCH v1 16/22] siemens: capricorn: board.c fixes
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Heiko,

Please use a more descriptive Subject line.

"board.c fixes" is not meaningful.
