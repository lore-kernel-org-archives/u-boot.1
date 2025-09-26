Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4273CCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 15:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD7BD835B9;
	Fri, 26 Sep 2025 17:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ENWeyyY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A100283855; Fri, 26 Sep 2025 17:57:13 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 758D383839
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 17:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-425757c5f84so11865765ab.0
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758902230; x=1759507030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObaNxvZvmdlZJpm1QLjnjKgarkFJvnpJnd2Jb6ww7rY=;
 b=ENWeyyY+SvFAmoimLpvVcQp22RhIvMGiKEC4Mf15O53OgRlztOq1kYj6qq79Z+UFiG
 mEhmkzvZLVskvhvwsKvEVZowtFuaEl/G61d9peNU2GmxpyQXp25c/g4xQJNhGM08CfKz
 T/mDtPV1y6ZxluPyfzKJY62Exza2MNI+U07xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902230; x=1759507030;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObaNxvZvmdlZJpm1QLjnjKgarkFJvnpJnd2Jb6ww7rY=;
 b=DEeWuCH4mKA4WbvpjrtHLRVLEbk33yIPRZhtw80Lf1buL+fgzOIiJgJkImhEwI2+83
 P87OSYTJ/ddtRnuvMdFWdkIUKwOZ76GHpsDx5AzhYyxOc2yx/ZteaReDow5XjTOr19vw
 4P0nOyLNb32ZQ8rYigpiGUAljoDjtoPie/CLb3qhHoM7+d6g9AY7LkR2YF5BAxw9Q2b1
 sAlVIN8+EZkBuwJ8aTZCXM2sUn989GJuh21CyGLJfY9BP6rRcE+CmueJs+sXYLc4XHrw
 ON7qn+IqPbnKy4U+jtgfo1wl0UBAFlrNTCHtPQ05dyh3QBEDpsrZK3T8kO52uqmBIdBk
 owSQ==
X-Gm-Message-State: AOJu0YxEXGkhKi76r5O6gjoPapo76DkbU4AU+wCUz/BY7+T7YEVYYyxd
 w39qiboemaDs23xUmWbxXtQNzG0nikxn5NHC+Lzaw27OipNxfUPy1s+vVaatijaKjpBgN10lZPG
 8t83s4pU=
X-Gm-Gg: ASbGncvCmYID96MgwpLFBomrxwgpl7O1y/a2DJsMdig3gx0jYLHk4PECTpmJzQJ+BBK
 jF7TlkcENt3FK1No/mKFvacJXVy36cVartUZX9fkr9/wLP7BPrufH419u5lbp+tVsq8uSKcskxa
 Ko+LkS5Otbt2/HrxMMfK1N0oVep0eKYZ1ZTWGgo50etvkKFlzAFrg0mnPaI3HOd+AMeIc0VLbQk
 JTw5xhIuPGQzHMrwhp1+6U3PwF7ZMXdghyX2lpiGiPZ/j/lydE6V+rYsN3vuNgDJnWIG8oBkDWX
 yJdlFA1jVxfON7L2fl5wypcEJbGhrvsoen1HQC4p+sVL7byNFh432ZlXbFcwKq6w40vVnXmKrQt
 PeTWPLPzVze4F4Srn+442SLMkJMSMyH4BghNTa8Hl1Ycia3aKqr62DYsG8e3slOgUN+w/gvOw3m
 YK
X-Google-Smtp-Source: AGHT+IHnSyQZtcDd6z/a2Rcc5ZVeuOGkME9KYYR6/56zoxIeGxfCBbPhZaOE+tgJ9/VhBzgmTTwW4g==
X-Received: by 2002:a05:6e02:12eb:b0:426:9b32:d156 with SMTP id
 e9e14a558f8ab-4269b32d198mr72842215ab.26.1758902230060; 
 Fri, 26 Sep 2025 08:57:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-425bff81253sm23502615ab.34.2025.09.26.08.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:57:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Yao Zi <ziyao@disroot.org>
In-Reply-To: <20250925153819.3282808-1-jerome.forissier@linaro.org>
References: <20250925153819.3282808-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: update NETWORK and NETWORK (LWIP)
Message-Id: <175890222861.3683518.13217684613493850355.b4-ty@konsulko.com>
Date: Fri, 26 Sep 2025 09:57:08 -0600
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

On Thu, 25 Sep 2025 17:38:16 +0200, Jerome Forissier wrote:

> Add myself as a maintainer of the NETWORK subsystem since:
> - I have effectively been handling net patches in my patchwork queue and
> sending pull requests to Tom,
> - I do have push access to the u-boot-net custodian tree.
> 
> Also, add u-boot-net as the SCM tree for NETWORK (LWIP) since it is where
> lwIP-related patches end up too.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update NETWORK and NETWORK (LWIP)
      commit: 5074fd5f722079dfccd92df854400e7dbb045464
-- 
Tom


