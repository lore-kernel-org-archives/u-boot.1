Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D973CC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D162988D1F;
	Wed,  7 Aug 2024 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQfNP/1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AEA886E92; Wed,  7 Aug 2024 16:20:25 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC5A88D1C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-264545214efso1044503fac.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723040421; x=1723645221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1uy+sergu8aMR8RVtxtXW2T3XaDaiLsv3aS3FnYTNA=;
 b=rQfNP/1cSR9wb8FJkixa5eLB5KQa5qEXnDOLQ1QNxEUlYvXSCBPylv+JuvKQGefQ3B
 d6aeS1ET4AN8ib5DPgsiXcdcA5Hrd8w6jSm91fLv57yY/93XtxXZ9HZ4rygw9SusjySp
 alfFyO+hxiaM4+jbOR9DbPsMBVZkHSQ0O+Zis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723040421; x=1723645221;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1uy+sergu8aMR8RVtxtXW2T3XaDaiLsv3aS3FnYTNA=;
 b=JxtSbhanIXzSL/udEdZw7E0vZk9OrxXU8Ja1YMrwSNZp4TT/CHwIYNVAkuZn/3J8CN
 Oa3p/R4G1inUSXIV+mcODB61kDbrqAq7HWHhKZm4h5EH5CmpZdJ/NmBmrBgUV8niVRfF
 RZVNY3MlZB0h81Y5ggFcMZqAZZe1sDWYwrCFaA+m9XixZ+NOrJuKbGzh8boZ2OyeSogx
 CXzXDCPBlXg8MSgOSDAFzmtPFjS+BQYr+bLwO6tJdNnp7rO6zRtq5rmmjDboWSu8RTGk
 +83br3E5YPB9yDnEpWGMxzUn5HlBFKNXil0lXXwJe7Y6ODT54uQJo8/yOxGacNsXfzY3
 8T6Q==
X-Gm-Message-State: AOJu0YyH5Qwh5guI6K5DX7wLOCmls0JpJwkQdc3sjLunaXO3c2xhlfQu
 UlxcEBbDC1/sbi+Vl+lEZqng+B531XchG6JvdYulwNRA3loiuQq3cGGo2G4ZSMw=
X-Google-Smtp-Source: AGHT+IEbNdyA/09ns+5vDI2/iMqCPuCbNiVOBlh09ZSn4cAZkhWWUYTO+sezMjaDzeFfISrUR2ZEFw==
X-Received: by 2002:a05:6870:2dc6:b0:25e:bded:3607 with SMTP id
 586e51a60fabf-26891af16a8mr18445315fac.14.1723040421327; 
 Wed, 07 Aug 2024 07:20:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-236.totalplay.net. [187.191.8.236])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a6274b8sm3959146fac.42.2024.08.07.07.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 07:20:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>, 
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, 
 Heiko Schocher <hs@denx.de>, Felix Brack <fb@ltec.ch>, 
 Marcin Niestroj <m.niestroj@grinn-global.com>, 
 Enric Balletbo i Serra <enric.balletbo@collabora.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>
In-Reply-To: <20240729204439.429900-1-paulk@sys-base.io>
References: <20240729204439.429900-1-paulk@sys-base.io>
Subject: Re: [PATCH 1/3] omap: Use spl_soc_init instead of spl_board_init
Message-Id: <172304042025.1708865.17919229886027276374.b4-ty@konsulko.com>
Date: Wed, 07 Aug 2024 08:20:20 -0600
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

On Mon, 29 Jul 2024 22:44:37 +0200, Paul Kocialkowski wrote:

> Both spl_board_init and spl_soc_init are available as ways to run
> specific code in the SPL's board_init_r. Use the former for init
> code that is specific to the SoC and leave spl_board_init available
> for boards to use.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


