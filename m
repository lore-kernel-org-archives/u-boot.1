Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322ECFD65D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 16:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6860F83A26;
	Wed,  7 Jan 2026 17:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2IP7CjqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3B78405F; Wed,  7 Jan 2026 17:22:31 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167218398C
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 17:22:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c7533dbd87so1622231a34.2
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 08:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767802947; x=1768407747;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pHAvMOWySelAiVkwsFoiLIDkPOwxBevCHtG8rX6zxdA=;
 b=2IP7CjqNz4uoxoYnRxcWPRVEEOjP6/AR1b0rKoDxSX7D2xt5PIvlQCzhZFe+oQCVI8
 fAwjCymTSGgu40Y3ysJKD3eOj0lR/CYGE0GatMXij/IJzv7okAtlcZZA59wDF+7H3qVj
 /RHq4rDTYddUKdiMTNgQ9vmQGqdFP/FmXqWa9P6SqHyx9SaqH6kiGhX5Ypkj9bZvCowz
 N1zZ2mGav50wbaIC2fPgYTpTB8sBYKEEvSuBzDmZWx2qPB9NIcRbJpoyPU41qg75ua+e
 yKfdgjHFBWH5zM7c0CUdwNSgul0rAK3L31ac6R9sGG8UKb9KJspqEobMap+aHEV8ILCt
 LTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767802947; x=1768407747;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHAvMOWySelAiVkwsFoiLIDkPOwxBevCHtG8rX6zxdA=;
 b=PEkHs7pJinlwNZJxy/Ohrh9m4XkIbcFY5XrIxEC0gc7/DT4uIj5kcE2nKRVECYzM+G
 T30SIf4p3A/GlZyMpUauLlBfnc8o7c0YIE/su7aRcZaUkSyTPb/fU5ygq0qG5MetD+yk
 zPAMS2CWV5XdHrjGpZ4cCVJqUBZ7eEwo2pDhtd84Es9zZn7nLS0zGmOcGJBkTrh7arRB
 2PhFaI89xTteEsYR97obLIK00dzq+teaXhc2DmMGqQE2F6mZnvFDM5xiAh9glACrS/hl
 OufLAUJNwFAJOUix2Jns1l8YZkcdPyrjNfk2QyjtPUAWjcmtVz5xSWngha7eSzEAHGku
 l2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTeHSXsE0AAebmK5af8JogDWIwuhlmW/wu0Lpl9EDzJ5WZTBhm/TeH5QRJwR+hFBObNkzge0k=@lists.denx.de
X-Gm-Message-State: AOJu0YwS4Mr5m6YMu5fSnIKK9hUHbCEvJTf7YCHmdx2oUkGdo+JBYxf+
 9fASUjDyax+JNG/I3BNDcBkVWl2iWmpjM0sikjqpRBiaOrYfPqr1M1EmZwPggfd9PCI=
X-Gm-Gg: AY/fxX6pAr0GaUys/OBLAM0DB3zViiYcrO3x8qUGaVXndMT/9o7x+NuSwlJqrSi0QjP
 2itFTDLu8n3r3YO+lFH4E9q7+yeH7Aob2L5mW/5N5x7It/cwtiwxS9fEXdpBOHUXTcfvDwRPenF
 zATgH51Np65z6eOXMuR1swLwgMRDYoZyDrt+yJx0fwSJMhhbR1O0biBiH4UZuunTF/i3Qdhkj6U
 JFbzSw9yukld/ys1/MWpxYsblrCay8Q3C+wL6nZ6natQhpDKCLX1qgwQS0tkjQ4Ay1SPjiLs+cc
 58H/jNg4OkAoSpsEsjJn/YqGIruSeeFtAdR4EHJY6gAV8TIljHnhdaEX73kXgBSszOXCLwrI9O2
 T6HD4FHWdby0/B6pFzBhokmGIqXpQK7t3oAw5GO18DPLIMrv5qpTK56Nx5arBRuRDw22nnFI4KF
 7hTgpRLnLecTHQ7QI=
X-Google-Smtp-Source: AGHT+IERsq+bS8iONki/Ct1YyFQEeDhXDCGKdDPjoLpT+g4tWUYKlRIFwSDCLGsj6l0W4bqDY972Vg==
X-Received: by 2002:a05:6830:2648:b0:7cb:1309:5b76 with SMTP id
 46e09a7af769-7ce50a861d0mr1543808a34.9.1767802947549; 
 Wed, 07 Jan 2026 08:22:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f278:961a:494a:41af])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4762eefbsm3958245a34.0.2026.01.07.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 08:22:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/9] clk: mediatek: mt8365: fix clocks
Date: Wed, 07 Jan 2026 10:21:06 -0600
Message-Id: <20260107-clk-mtk-mt8365-fixes-v2-0-3294a5d2f239@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PwW7DIAyGXyXiPLYYlorltPeYeoBgWmsltIahV
 VXefSSRttsOPvy2/H32Q2RkwizG7iEYK2VKcwvqqRPT2c4nlORbFqpXAygwcrp8yljWMvowyED
 fmKUBq0GhsUEZ0VavjNugbX4c98x4+2r0sjf/4M21o4dfNMUrp4oR55Kld7178+A1gB6rWunOZ
 pRTipHK2CWmE80v0eaCLFbZmXJJfN9eqrDZ/r++guzlazAh9B61Oph3Z+8XcozPzSKOy7L8ADd
 wqFsoAQAA
X-Change-ID: 20251218-clk-mtk-mt8365-fixes-81a312e8af28
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3814; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qZjNA7NCHPW+WffWDM50Z1T0c0d9jkqvIWq7rrWijuo=; 
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDLjOhj3Pztp0hhg/TbyqmVoq+UFlzNRFvVfuy7fsp/QJ
 ZK9e1psJ6MXCwMjF4OJmCLLG4mb85L4mq/NuZExA2YQKxPIFDGZlJzU5Iy81CKHpMTKnMykolS9
 5PxcBi5OAZhC52D2fyZcttVTjEzPm3PmVzbNCz7y/LTRvE3P6jWiMjK/LFDUtzV5efzmHkWOg38
 co+8IbSizX8+Ty9VdbP6VUaWrt9Tn/g6vFdcLkx4kL79q2jq5zk7jq4SCctbeE0b5f1O9jDNvXw
 uJqbqS92Hl9tVRKXs/Wrs0OPGlGHKbiGzQ/HR1e/czG359Ca+I1tJKidO/+5/sKWli1b0vrSW0M
 1cg4mpn0JaUDhXZlujGtQ9XL054ujfygeK7A/6vsw0/HI6f7CL5fF+DmctUswXsgqyLjnGHWrM8
 lBTgvqlQER/+aI2T9MU1NQkJGSpP+ph4+XZsEl74KTrru7P5P6WGS/MCVToMi6uKf065pKX3zR4 A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 07 Jan 2026 17:23:20 +0100
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

There were a number of bugs in the clock definitions for the mt8365
clock drivers. This series aims to fix the obvious issues.

This builds on [1] that implements the clk dump command to inspect the
clock trees at runtime. Using that revealed quite a few mistakes in
the clock definitions.

Additionally, the topckgen-cg hack is removed for mt8365 since it would
require an extra devicetree node using the same address space as the
topckgen node. This would not be accepted upstream in Linux, so we
shouldn't do it in U-Boot either. mt85{12,16,18} also have this hack.
I didn't attempt to remove it from those platforms since I don't have
hardware to test on.

Patches have been runtime tested on mt8365_evk hardware and compile-
tested on other platforms using:

    ./tools/buildman/buildman --boards=mt7986a_bpir3_sd,mt7620_rfb,mt7986_rfb,mt7987_emmc_rfb,mt7987_rfb,mt7622_rfb,mt7987_sd_rfb,mt7623a_unielec_u7623_02,mt7988_rfb,mt7623n_bpir2,mt7988_sd_rfb,mt7628_rfb,mt8183_pumpkin,mt7629_rfb,mt8365_evk,mt7981_emmc_rfb,mt8512_bm1_emmc,mt7981_rfb,mt8516_pumpkin,mt7981_sd_rfb,mt8518_ap1_emmc -b HEAD -c 9

[1]: https://lore.kernel.org/u-boot/20251218-clk-mtk-improvements-v1-0-72db131ba148@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Picked up review tag.
- Fixed typo in a couple macros.
- Added changes for mt8188 (new driver that was picked up since v1).
- Actually compile-tested all drivers this time (I learned about buildman).
- Link to v1: https://lore.kernel.org/r/20251218-clk-mtk-mt8365-fixes-v1-0-4f8ff0de3268@baylibre.com

---
David Lechner (9):
      mt8365_evk_defconfig: enable clk command
      clk: mediatek: mt8365: fix missing and out of order clocks
      clk: mediatek: add separate gates_offs for cg gates
      clk: mediatek: fix fixed clock parents
      clk: mediatek: mt8365: fix some clock parents
      clk: mediatek: mt8365: split struct mtk_clk_tree
      clk: mediatek: allow gates in topckgen drivers
      clk: mediatek: mt8365: remove separate topckgen-cg driver
      clk: mediatek: mt8365: fix missing topckgen IDs

 configs/mt8365_evk_defconfig      |   1 +
 drivers/clk/mediatek/clk-mt7622.c |  31 ++--
 drivers/clk/mediatek/clk-mt7623.c |  41 +++---
 drivers/clk/mediatek/clk-mt7629.c |  34 +++--
 drivers/clk/mediatek/clk-mt7981.c |  27 ++--
 drivers/clk/mediatek/clk-mt7986.c |  23 +--
 drivers/clk/mediatek/clk-mt7987.c |  21 +--
 drivers/clk/mediatek/clk-mt7988.c |  37 ++---
 drivers/clk/mediatek/clk-mt8183.c |  14 +-
 drivers/clk/mediatek/clk-mt8188.c |  41 +++---
 drivers/clk/mediatek/clk-mt8365.c | 297 ++++++++++++++++++++++++++++----------
 drivers/clk/mediatek/clk-mt8512.c |  11 +-
 drivers/clk/mediatek/clk-mt8516.c |  14 +-
 drivers/clk/mediatek/clk-mt8518.c |  16 +-
 drivers/clk/mediatek/clk-mtk.c    |  88 ++++++++---
 drivers/clk/mediatek/clk-mtk.h    |   8 +-
 16 files changed, 472 insertions(+), 232 deletions(-)
---
base-commit: 53c0d5b387956bb4070a943b61991898373a20e2
change-id: 20251218-clk-mtk-mt8365-fixes-81a312e8af28
prerequisite-change-id: 20251215-clk-mtk-improvements-db0b9d1d3113:v2
prerequisite-patch-id: d8ebdfa01cceb83513361f876553f66eabe2986e
prerequisite-patch-id: 2f272f681a04828ce44ea4010d1d613ca554c321
prerequisite-patch-id: b4d03b405596876fd02b30cf335b677e6c630cee
prerequisite-patch-id: 44f6f31cac0c5361cfd8b23ee7aa4f1d49c7d4b2
prerequisite-patch-id: 539af724f889b136a758a6833dbe4d3eaa986a8b
prerequisite-patch-id: 3330313a7c4178da97b50159ca627aafadfb0049
prerequisite-patch-id: 96f170f2b16aeacc404270b8444dfe5a928f8a93
prerequisite-patch-id: 7379668c38c251dbcd81c4d5b72ba5fdaad91a0d
prerequisite-patch-id: fbe17c1c0d5f18e2a33a8208e63e73292a6b4a5c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

