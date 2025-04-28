Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD99C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3360820EB;
	Mon, 28 Apr 2025 07:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745818150;
	bh=2PlPRF3LkhcpmaYz8/vZBMYlV/2zAERouS/iEkTUERw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=USpei3gdvlUhBCdzpyMz24P6+zZ/m2h2Udfp7fbmq3ocVmocx3HhlFnryL/cd6hFt
	 7DZPq0u0aD/g6j984X7XorYMv9fQtqLDH/Vu/YM/R+wKkGDF79GJPhhF1b9aIE/InT
	 Oiq9j1BnM/1HBdPy7iiQLobIQ2KxjjQpk9oLTmm66WN0M5vm8rOJY2KsOpft9iaWsZ
	 Z5+wjC8OolVz5lreaDvXc7rBlMbcCsiySDk9IfKSVyTBbDrGKKXyRkw03745QTkH3P
	 4keWVN5cWA8EyACOs8UbX8oJjAyRRtV9eTejVWR3VgfdCdNFuR8LSE95eKy5Oe1T9r
	 lmk8CKbjfkzJg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E64882105; Mon, 28 Apr 2025 07:29:09 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9B280BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZNTYPtqr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 534BE10298342; 
 Mon, 28 Apr 2025 07:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745818146; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=2PlPRF3LkhcpmaYz8/vZBMYlV/2zAERouS/iEkTUERw=;
 b=ZNTYPtqrvy9+cT2wi3X76LMeX5Uclv53yHeRAB8erSZGym/5qLYjXaRvGrD1VONJdjjLs2
 LBp2PLzWppNJmb9iwB296RFYPAjeVRAWGE/rRmkTvTCghq5j+9Q4enwtUeBtRYv9SsH0h5
 Mum9xIQ7WkDu5b8BGWQUKxKLTW9ZfbWP6tn0q+3MVW99X445hXkoK7NqR8dLF7Lobceirs
 jFmg+nkhTX3wps1bKu0lX2uUdpR3LXk0DJ+JCE/GITu3+FobWX8da3ocR68GO6BoFQY3zc
 fyt6ycl5R9319hugRcfYIVD7CYebYI95lY//O2L+2wo3hY9ORNrHfXUSwprYOQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v2 0/5] Updates for the siemens cxg3 for 2025.07
Date: Mon, 28 Apr 2025 07:28:52 +0200
Message-Id: <20250428052858.100083-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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


some small updates for the cxg3 board:

- collect common Kconfig options in an include file, which
  makes syncing downstream defconfig files easier
- Move the U-Boot Environment setttings in a txt file
- minor defconfig updates
- remove now unused file include/configs/giedi.h
- base is now
  62ea9c329a0 - (origin/master, origin/HEAD) board: starfive: visionfive2: Order board detection logic to match config


Changes in v2:
- simple spelling change recomended from Fabio
  s/siemens/Siemens
- removed ipaddr and serverip as suggested from Fabio
- respelled commit subject and message as suggested
  from Fabio
- new patch arm: imx8qxp: capricorn: move env offset settings
  in v2
- patch siemens: imx8qxp: remove unused config file
  new in v2

Heiko Schocher (3):
  imx8qxp: capricorn defconfig: collect common Kconfig options
  arm: imx8qxp: capricorn: move env offset settings
  siemens: imx8qxp: remove unused config file

Walter Schweizer (2):
  siemens: capricorn: enable text based default environment
  siemens: capricorn: defconfig updates

 board/siemens/capricorn/MAINTAINERS           |   1 +
 board/siemens/capricorn/capricorn_default.env |  49 +++++++
 configs/capricorn_cxg3_defconfig              | 135 +-----------------
 configs/imx8qxp_capricorn.config              | 134 +++++++++++++++++
 include/configs/capricorn-common.h            |  52 +------
 include/configs/giedi.h                       |  16 ---
 6 files changed, 192 insertions(+), 195 deletions(-)
 create mode 100644 board/siemens/capricorn/capricorn_default.env
 create mode 100644 configs/imx8qxp_capricorn.config
 delete mode 100644 include/configs/giedi.h

-- 
2.20.1

base-commit: 62ea9c329a0d013993bae538c55dfea06e4551bd
branch: feat/capricorn-upstream-hs
