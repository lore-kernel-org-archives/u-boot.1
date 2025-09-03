Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E52CA1010
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 23:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D706F83621;
	Thu,  4 Sep 2025 01:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BrOTEmyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CC88368E; Thu,  4 Sep 2025 01:43:32 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D02835C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 01:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-724b9ba77d5so5754957b3.3
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756943008; x=1757547808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2C9aPhM7NcocUq6THJXq9zhxG10icCS4NAy2xKQc1WQ=;
 b=BrOTEmyDoO2LnB1VFOfAeZzp4a5TsnYYwaTkLfR0cVD018SXzwpPABuQ6d4XoC1b4J
 2n4qsNrD+j3yezpOAwdG5Jyf8rEQgBGrHkzBr2BCQ4FRcVOhMn0s754c2fNvvI9VHhs/
 Oqn3gCl4Gdqh6nzUvMRU1Fjn++r/Pn2EkW95h22YrrmmCxXDehWCMFw/lNrpcRPlHF0z
 cDorCrDiK1fRclRaRDAh+KFlzoFpe1+WDTyPstM4m6AG+4w3DcHPmxLp2rKINwjIwSQ9
 FGPhmyYboa0LgkEqQARRbtIwyrbWMer4hcWpnfta8+CMRQoy8nPBamzFrYWj5OqfVk/v
 8eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756943008; x=1757547808;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2C9aPhM7NcocUq6THJXq9zhxG10icCS4NAy2xKQc1WQ=;
 b=Q9QKAHimEPMqQyNugxMP5QHMrOLjskhN3tqaCQ+tn60As4E3F3sO2lCMRO/ajFy0Ea
 0aScH1nzgB1AboeLYLhXmNFiLPecq54ZqwrITvaiEjK+BpJvwMMl8p30S+TrtwJ/492v
 s7w3xFmxKdYH5mFtuJglbG5Eb77p2ylKg0gNn7P1Xb1xCCdhw7AubXDri6+QfTt5GfdP
 kPDWqMNbcMJ+fc21nKufBfEHIF9gcC4lAGoLYI+aIo8jhuBmo60Z/5TC80hn2f2oyUC6
 4xohH43oKwmqbpDRFRwZS9UQk0XMyAMnHP4cuyIa4bsgooniEpo3O9k6PBv9qrOCFLie
 5NFA==
X-Gm-Message-State: AOJu0YxgqOfz02Vc5oH2/suAxwEdlXLUR6cKM2bxtGrSdQ1nkPa+J5Zx
 IAC7louWAwvowaTQ+P6+F9Jt3cRpliSujqgT8UxQ2bGtY3c3xx4ZYnUq9m6H
X-Gm-Gg: ASbGncuq/gnwu/wGBzG/dyEd48qrt96onjrETQ0hNy5bYbHZ1KJyh05+UZ0oKZj96Io
 8aB4iQofgPu7x1w9xH0Cwe/1PWC0kSkBc9rlWOA33Z8gPUkI8DwjwHRsVlPUzAseCMe7MFhx5cw
 1uJVrb0g4XmHEh6txzfYVqgeXc4zSJUerihnAkL4RS05NGKO6s5XB1vAtllnG/CDimWJvfVNPB/
 BZWHlNdl701fKoXtlfQrPPMfdurO+FC+jxK/sEhlOyZlCMH4NyygOlTsaxcmNExT5pwgUB+EQRi
 unOUtA6Gs3weMH7tRyQ7vWqU0xEu/vIQ6FAcMjiZFUIR524rjIfgvRbWu+hsdzmF7gO5Z/kGzHY
 atVXuIPSeHvWFshftj5fFCAIPQXB8ajKIKwUadpKiONnQ3NtK
X-Google-Smtp-Source: AGHT+IFdcF73AjCCBqZAh9OPlQjo+MFUTJkF6REBYfXP4XdIO4ghdu4BSBMIj/LgHdqbmHzUlx/gHA==
X-Received: by 2002:a05:690c:892:b0:71f:b944:ffd with SMTP id
 00721157ae682-722765844a4mr202917057b3.48.1756943007686; 
 Wed, 03 Sep 2025 16:43:27 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-723a8503a61sm17044997b3.38.2025.09.03.16.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 16:43:27 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: philip.molloy@analog.com, adsp-linux@analog.com,
 Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH 0/2] Fix ADI driver header dependencies
Date: Wed,  3 Sep 2025 19:42:00 -0400
Message-ID: <20250903234205.26787-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Between 2025.07 and 2025.10 many header dependency chains were improved,
but this exposed implicit header usage in several of our drivers. This
wasn't discovered before or included in the original fixes because our
drivers are not yet used by any mainline-supported boards, so build
tests did not find them. This series addresses the two build failures
I've encountered while rebasing our work onto 2025.10 and continuing to
prepare the next submission of our board files.


Greg Malysa (2):
  net: dwc_eth_qos_adi: Add missing header
  mmc: adi_sdhci: Update headers

 drivers/mmc/adi_sdhci.c       | 1 +
 drivers/net/dwc_eth_qos_adi.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.45.2

base-commit: 76b8edbc732e327d1e56f08c641f51fdefdbff06
branch: dev/uboot2025.10-fixes
