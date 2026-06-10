Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA95CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 19:59:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479DA841C2;
	Wed, 10 Jun 2026 21:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/TFsadO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55698491C; Wed, 10 Jun 2026 21:59:35 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD93780087
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso5237125fac.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781121572; x=1781726372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpY8ZrH+fJSYqgF5pPQPcao5gWMlubrH6s17m5mJ6Fw=;
 b=f/TFsadOdEC3YdVUY1dOJ9vn9QOhLR7Q6561N7EuDkbgaiPkUtmhN3a9gILCmtmGWR
 veb812J1X1BBDvbUUCCmF4O7COami4q//X+Z+ItJHb+CnYcgBR31xH0eppi1WkdBn74r
 WELsON3W1vXrEgyqkdY2tTzCDikcusLnEfsBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781121572; x=1781726372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpY8ZrH+fJSYqgF5pPQPcao5gWMlubrH6s17m5mJ6Fw=;
 b=rLmSeh5gAF4EKGrX09iCj8m50e2F/n7DebS0yCmTilx4srHhScWwcbNZtynDJBIo1W
 4rMWQas2Oeh8Gq8CeXSjV1Ndm1jN9gMCfeNynazDclFxQa9M7wRM4q66J3KoW8b7Pgff
 3VRhUPf+xFmTeBI/IpncYl3pPrwDSFnPEPuR0pP4cPddMr2b43pEocyilZwC1JUhlWoh
 rggSo5tgZDRLfpx7Mz6V5NPAg625lqdZZdhAHRVqo6l0zrEzAargVeELOron8MTKFr1j
 YyyiASdQQhMBADQr5UJd7xjQSaPLVONjBym+/JfjtA57eULDtAfeUKUctbXzp+9c5Oio
 toKA==
X-Gm-Message-State: AOJu0YxtO6UlaJv+sOfyBURWu0XgfOkNeUbUhXrHIMWm3CZzDouUoxKF
 EvhIMMBL5jQTfxLX94ovGLYHVhwrsbPEohCWzZiHB1shjZBpWUurbSkN5UI/+Jqacso=
X-Gm-Gg: Acq92OFcdVZTejXmv+l/O12WiT0bckt5ebbgmWnuZfAZNQH/iRHOQdJ3COOcgEz8N0Y
 8rMXvMIq8xRqCR6lGBTv55J/nW82eO8kdKQGcW5ZxpzXiQbfpjTXanajtOF1A80pLrIMXIz/Ub7
 4wc3sCF9G4MIaMIegqLXFUbuSMrYnJdVQzPg2MOPUPA2EY6vzBD7zb6RU2+3Jhl4/+VKUIPy6gf
 jYzD1fHvkDIJ+dsb/fioOgs0XVgLRbYX+IJ6AleqLy1fasSkbLgT/coN4Ti7Ntd/igkNf6OIIYI
 NprqSgWjtiejXF4H47aeUocux3YU3HNbGZ77v5pafqjKnN5LG4/mimGXHaaJXH3VRj+oDZxkd/0
 umahaOGElNLU2h1ZApVt072D4l2uMJSULzKmpWQASIX154fymUpZEO0tSwi5qXlu/A+I6biPvl6
 yZZMKn0zK01/7ntohrW2aYw8K0xTC806pt8MqIAWtOyXXUlQ3m4UdQHoqM9heLzwCqNJ+FNMf+j
 d1qr8g7tXDnuQmj+1/XDTzsrDyrxjb1NVzu63fVoEI/jg5Kb76qPe8pW2BH
X-Received: by 2002:a05:6870:c28f:b0:43d:2e43:9e4b with SMTP id
 586e51a60fabf-4413d6cb8ecmr16543189fac.17.1781121572162; 
 Wed, 10 Jun 2026 12:59:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7263efcsm22911144fac.0.2026.06.10.12.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:59:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, vjardin@free.fr
In-Reply-To: <aijV_m5m39Bsbwrv@nxa18884-linux>
References: <aijV_m5m39Bsbwrv@nxa18884-linux>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2026-06-09
Message-Id: <178112157132.295957.6283612446023566560.b4-ty@konsulko.com>
Date: Wed, 10 Jun 2026 13:59:31 -0600
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

On Wed, 10 Jun 2026 11:11:58 +0800, Peng Fan wrote:

> Please pull tags/fsl-qoriq-next-2026-06-09
> 
> ---------------------------------
> Add JEDEC JC_42.4 thermal driver
> Add QorIQ/Layerscape TMU support
> Misc dts fix for fsl-lx2160a
> Misc i.MX9 SCMI updates
> ---------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


