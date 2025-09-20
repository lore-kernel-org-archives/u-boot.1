Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7442ECAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074ED832DA;
	Sat, 20 Sep 2025 18:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9Dc5eDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64D383211; Sat, 20 Sep 2025 18:10:22 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B2A8003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45cb6428c46so28531615e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384620; x=1758989420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMJpbZOyy2R2mxcZwYzWe9V3IQfxEgOuO8WnjyGWXuM=;
 b=T9Dc5eDq1yedXCV4tQU9KpolWzvocZ9nGKG640pMLYenGxA524Pjz/PLkJux5elwDs
 oNMDFB93ec/W4yyFjnmPs+drEstu+WD7WMw/mBZ2bfmct6qLe732RMgKO8Pen+tWB8Ej
 2u6owi3RjIDKqnkBvVcx9snPzCAPu2OagB4tI9yBpk3/cCCx+eOiMxFelDCfg2AjmSYu
 eZzYK1LJExlMpnF1yhQSD2VYhv12BKvqQYyXE0S+wg2HQiIxHNDhxMHbHq5J8+1zPoZF
 7+ATjl+AAWJSpABGcc5+swgNSzHwGSb0HOjPJNmus9YFYj8Wzh9K3seeH6hQzxnbgVfy
 7p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384620; x=1758989420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jMJpbZOyy2R2mxcZwYzWe9V3IQfxEgOuO8WnjyGWXuM=;
 b=bxQuOiEWAW1iNuipr01Zi7Bqm6r6eOD4OHLTeE2Bu5vM3drx1ZfMtlWQliy4y7CEJk
 l9BmJ0LfhPsL4iwFJluUFonITFSpMMojW4I9GDzk2GmmIaj7eTxcJ5L+SwcQBp1Hs7J7
 3rN07ZV2PEYyyDA+63JAQkdRf/8mbqgvK9NBY1hNSOye9iYQqvHLYV5YT8NKVeoaWn53
 39QKWvyCVA6npRQKiefNv9pWXpPr1dCH5GGKJuOFBF8CkarQFDgvIjwJR1RE2J35WOM/
 p8XZpaBCRpF26iix8HFIO4qg12Jexmb5wc8H7Tej8EVD2hchYtNGXDWu6V9Rf4sKdRjE
 lcrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHojYQ7NzpLOebntEipzkLwswHn4p7WCHU6Oc5ZAXkPOdz/bnRqi+rAMgWxuzEx/uh13/hmco=@lists.denx.de
X-Gm-Message-State: AOJu0YzSWTufXien7MjxHeFktgNMIQToY6x3StxKt7goX4KbXzGNGH3q
 bcp+bREx+NAcIjZkTbVqdZkFLpOXkTNE8Kiw9mvxhxiXbRj19ZxprIeZ
X-Gm-Gg: ASbGncudxCjTS6aJULBa8mUzwYhR4pmv904JXgta2/oy4iKyuEb9Z5tENKWMlUjuSV4
 RRRYfgywPZVdWAyWgI9CJVIxWGZMtOxCD1aGsB7QytwVyZlvgC/ekrtjlvTeVJdqL2PTEuI7vni
 Aom9DTgxIaPjXz+L1qr47nmjly1tv7347AP2fS1nNIbfMVg92ZHeoi48efbWtrdAD0xNbKKZqa8
 7itB+lgPj1h9DYehwHv82gPHUJNSf4dL0ztHfMP29D/OQhWmvWDgzlQJoeJOAc5pyV/o58Trp6D
 hpdMIA0CNumM8JY/eSKSQNhg+kAcg2xPGL8I4eiBYk5ONtyfZbNDUqlr4/Jm4htlvb4bqyzM1/K
 ewTPdNCDcKPLooH66b+t6VZEaLG5+0oE5R6vcTnytEAt2yg1TER/OrJplryIFbG5C9rIS2UER63
 N7YJggAQ==
X-Google-Smtp-Source: AGHT+IHgMRDMrX2ycLUdob5NfqsVWEgjF+ZnI7GkO1wKzj5574DkRk9MfYepLX+lkR/dlDXWY3APEw==
X-Received: by 2002:a05:600c:8b21:b0:45d:d56c:4ab5 with SMTP id
 5b1f17b1804b1-467e63be56fmr72181975e9.5.1758384620028; 
 Sat, 20 Sep 2025 09:10:20 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/5] net: mediatek: mt7988: various fixup + MDIO detach
Date: Sat, 20 Sep 2025 18:09:40 +0200
Message-ID: <20250920161013.31799-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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

This series is really required for Airoha AN7581 to provide support
for the MMIO MDIO bus. But to accomplish this, rework is needed
to the current MT7531 driver to prevent additional code duplication.

While at it also multiple BUG were notice on the MT7988 driver.

The additional MDIO MMIO driver expose an internal variant
to access the function directly from a manually crafted mii_bus
but also provide DM support used by AN7581.

Changes v2:
- Replace patch 1 with actual fix

Christian Marangi (5):
  net: mediatek: mt7531/7988: fix broken PHY turn ON/OFF
  net: mediatek: mt7988: restore PHY page on PHY setting exit
  net: mediatek: mt7988: free allocated MDIO bus on cleanup
  net: mediatek: move MT7531 MMIO MDIO to dedicated driver
  net: airoha: bind MDIO controller on Ethernet load

 drivers/net/Kconfig            |   4 +
 drivers/net/Makefile           |   1 +
 drivers/net/airoha_eth.c       |  26 +++++
 drivers/net/mdio-mt7531-mmio.c | 168 +++++++++++++++++++++++++++++++++
 drivers/net/mdio-mt7531-mmio.h |   9 ++
 drivers/net/mtk_eth/Kconfig    |   1 +
 drivers/net/mtk_eth/mt7531.c   |  20 ++--
 drivers/net/mtk_eth/mt7988.c   |  92 +++++++++++++++---
 8 files changed, 294 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/mdio-mt7531-mmio.c
 create mode 100644 drivers/net/mdio-mt7531-mmio.h

-- 
2.51.0

