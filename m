Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D3CC61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 991B183936;
	Sat, 21 Feb 2026 18:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9/wfQY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E25483A41; Sat, 21 Feb 2026 17:32:20 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E59801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so14669065ad.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771691536; x=1772296336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l0SQiacJNbdb99UaFNzMwrmR4xmK4eIDvyKbsygI374=;
 b=G9/wfQY3I0Y0/CEqNElUXipD59zI+z5vY7wnrD4brQJgm6CkPrZ/2ZKCkzSRXcWlLj
 xXoH4MaE6HJS6gl3CVJn2nrzyKDfvGbFJACu60/rqKnLI1+qCA6WbkxhQSmYnZm9z7Bx
 9tVE5bsbNLJA4ha5iaeCCtJZAepGnfvq0Y82D+rEtEbATTuayDyEW+E7BEeSVMTc/O63
 93KH+TRlexqDecMCtTV4aICOJFxu7gRACB77wp2PGq30NWAg7Pt0hki+L3fL/dzMZ2Aa
 /mMFpOmatOlLEbOQnMpE1mnswUUFpOyqW3exYexaF19/hDuhVwI76SuCgFzfGrD3M95B
 t1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691536; x=1772296336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0SQiacJNbdb99UaFNzMwrmR4xmK4eIDvyKbsygI374=;
 b=jvlI+RbRsb7nq4EAnVfscQU1DtPzDEvInDzkQLJ0wz0mMAVBIE/g569dg+dbTUHoV2
 BNcHXUaS7eQFTv0f0t0CDPZX1L1TFSA32zSr0IDojFEsSRER/PORYordN/MlFvhD3KJp
 O7gsky+8ABU/c+MILuyHqlzX44ajeo0QC2hAtiug2ry2093b3cJBmjG/OxrsEzMlxM+N
 DWh4QHhUCptCFfbBowOzIl7TNJAtTCD32Rf7bFxSkvudgXMHOd0/S1iMsmWg9XnWLI65
 f3gbkE8bpn6fk8TL1zka1VqZtquVA/mEMr/FkkynkiQi+DrEWvIXI3kBMuOBxCpIlk39
 tKUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIBVOo4nZ07J7bz7hAQ9zSAIwTUgZAuvNnst3BbuhFIcWbmbmlAS5OO1/ulR8fGTIuwHmLGHc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdm6Gmes7OfuvKR7LumghOJhncKfcYTNjz8oQnvd19DAFgNTku
 eFMMsnQI7bx1FdyaovNy9zGG2Y/MywxZfhp6V4DSTLF5YlzcDXGOL3EQ
X-Gm-Gg: AZuq6aIMm/6+ZOXJz9rDWKy2zooOA/Ln8/RupIxMPrdCMyrrOd3xKiOu+BRr9wzDQS9
 9KBJYceIVZhQgC6oFp1VCslfTs7cZsIQYGz58sRFCDC7CpqPNeXQFLEj4nMXjWt88O4/kZzqpSS
 60mfSq7GbMJPbxJWn5QDbLJwjkfdpHJmbmaR5LPwry2aLR9qRGbX8Z+3WcpMHOyXosSfhqYFdBK
 l6wb8lV9doT9zy+ISxD35Fmbe+EWH0aSDUsOo+L1+d+bppDmE2uoc2xW+OFlIm4bfBlX+zWEi9c
 WluCvhd56ICTC5oRc8HHY8BWiuly+Y5cCokL85EWfIQjXvpKc4fQlPgKtljgNz8YTisc05ovyvE
 bGifDSSsDF4G7pr0+K2A9leMhpJkNpP9ciwtOGM4eXvfbGpK0G61cgdcSWV4z/b7RHau6cWJ+7x
 1NDD2dBFGRDEZjZbNPeepXw/cT3dKE8yY0OfCMj4Lekme2xS9RaKUCqvFCZfNjYldrpC55woEjA
 FjV8pE96x/l1wvJuroGYQ==
X-Received: by 2002:a17:902:fc85:b0:2aa:e23c:2697 with SMTP id
 d9443c01a7336-2ad745984bamr29884825ad.57.1771691536413; 
 Sat, 21 Feb 2026 08:32:16 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e062sm36868365ad.48.2026.02.21.08.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:32:16 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 0/4] phy: add common PHY polarity properties support
Date: Sun, 22 Feb 2026 00:31:10 +0800
Message-Id: <20260221163114.87553-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Feb 2026 18:32:49 +0100
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

This series ports PHY polarity inversion support via generic device tree
properties from Linux kernel, synchronizing with Merge tag 'phy-for-7.0'
of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.

Patch 1 renames the existing transmit-amplitude.yaml DT binding to the
broader phy-common-props.yaml, and extends it with two new standard
properties: rx-polarity and tx-polarity. These allow per-mode polarity
configuration with a "default" fallback.

Patch 2 introduces a new PHY_COMMON_PROPS library providing helper
functions (phy_get_rx_polarity, phy_get_tx_polarity, and their
"manual" variants) for PHY drivers to read these properties from the
device tree. Also adds include/dt-bindings/phy/phy.h with the
PHY_POL_NORMAL, PHY_POL_INVERT, and PHY_POL_AUTO constants.

Patch 3 deprecates the proprietary airoha,pnswap-rx and airoha,pnswap-tx
boolean properties in the EN8811H bindings, and updates the example to
use the standard rx-polarity property instead.

Patch 4 updates the Airoha EN8811H PHY driver to use the new standard
rx-polarity and tx-polarity properties, with backward compatibility
fallback to the now-deprecated airoha,pnswap-rx and airoha,pnswap-tx
boolean properties.

Lucien.Jheng (4):
  dt-bindings: phy: rename transmit-amplitude to phy-common-props and
    add polarity
  phy: add common PHY properties support
  dt-bindings: net: airoha,en8811h: deprecate pnswap-rx and pnswap-tx
  net: phy: air_en8811h: use standard rx-polarity/tx-polarity properties

 drivers/net/phy/airoha/Kconfig                |   1 +
 drivers/net/phy/airoha/air_en8811.c           |  91 +++++-
 drivers/phy/Kconfig                           |   8 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-common-props.c                | 286 ++++++++++++++++++
 dts/upstream/Bindings/net/airoha,en8811h.yaml |  11 +-
 ...t-amplitude.yaml => phy-common-props.yaml} |  92 ++++--
 include/dt-bindings/phy/phy.h                 |  32 ++
 include/linux/phy/phy-common-props.h          |  70 +++++
 9 files changed, 557 insertions(+), 35 deletions(-)
 create mode 100644 drivers/phy/phy-common-props.c
 rename dts/upstream/Bindings/phy/{transmit-amplitude.yaml => phy-common-props.yaml} (44%)
 create mode 100644 include/dt-bindings/phy/phy.h
 create mode 100644 include/linux/phy/phy-common-props.h

-- 
2.34.1

