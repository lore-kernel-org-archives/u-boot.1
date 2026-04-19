Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F822F588C2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0EC48436C;
	Mon, 20 Apr 2026 14:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="Ptco12uk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDB284258; Mon, 20 Apr 2026 13:11:47 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B956083E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso17048315ad.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776683503; x=1777288303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BKPANb4Y6tlK2Q7MzpG1eG34t+zJQoZykZZUarBaJK4=;
 b=Ptco12ukRq9QoBmzXpOS8Q0WUBQ/iZ3hbACd3TNHGXpliD+XyyIH8i/i/XSN2vud/J
 K4tqPjbQH/GEPE0rxIdq6bdsvmKhas9jHN8CLUBs++YG7JEkJpruWYJzOjox0B7nkgXY
 /YGRo4unfZsJL99MG2xRHfXpF5JZ5LvKPiJEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776683503; x=1777288303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKPANb4Y6tlK2Q7MzpG1eG34t+zJQoZykZZUarBaJK4=;
 b=geohF8liDLP5530fFPLWrleMhgFoCdfRt/4XMm1d+hnf/uInJes+y49eEpubMx9LDK
 70ym1HDIJ7KkTtLZ3mPqlw+b+yJibnHLw1aDVYkkaOdRR5vTEf4K78R3Lgs4mz551F2v
 LLXA//YZ+TC53tHliMNYKEDu2hXlRLWl9l3l248+PVwupRplxrvQ3x+7jCUZ2/II4a/E
 qpmPKQciYsDipMY83ICTtlGJ4Qu84CeN/skojUu0C3KPMHmI6fbj788ah9oSxbRGDEb9
 tZyuKnadXJRZjgK3bhR73sP4Bg7cgWdS6xGg7fkYYehEeH8fzaxH4vg/aQDyB4ipGZIZ
 Yu4A==
X-Gm-Message-State: AOJu0YxTj4MD55gZb1KzUReyWkUWzGjGuhy/6+51SDleirXVeb529dib
 72Wbw5OaTPj4dnE+JKNvZ1jYerOABDRgNAYwv9JVjUYE9cexcM0TusSp04/O2rVe5t6p3ETWuNq
 J08ebsdw=
X-Gm-Gg: AeBDies1ppZpQ48n7QMhMZXBrkqYfrCpc2bDBwbafQHQ8rdt0aoYyUctpTbpqyk+/9M
 CWCvuYbLAf7pCnKdL1I9muAgMdIvI2nnDpEPwckUVLB6OC8cBhx+2Hy3HOC1t4x5ob1uiujCFFE
 Fz1EyYVBnOjXpC9OdBEsWsyNpBA/ygKNPXuy7BmOt8BfshAUBOtc+PWhqt8ZcKxY8GioXod2GB5
 xMZ+eCouiCN/htOqvZFbA4ik3TwSE/y+lAZ/qvaN7d+21fdusAo/LkstEDgK4lIro2ZsqoySdR0
 XB85WA3Tnn1JGlv//b9wgTtOtLvt8zKfnksllODoh382otKLVpKJr+DGYP3j9LsTE2hEvWW0MQ9
 I5x6fi7+gnZ1K+Dnn/VhTFY486c95EEF5DzsruixjfQrw9W6VjK8EnM0/PSiKh5EB5XrO2/Xsvi
 OFRT393j++ZRqZ/NfPJwqRWa7nm1iytlH6BT+3YOPLVcQ6HjsgxnnJFKDzcfJ744hNBf5t2sJ1X
 SgBPi9UhGgxdLTZUvL7olUVJRUvBbad
X-Received: by 2002:a17:903:1112:b0:2ae:6192:8d78 with SMTP id
 d9443c01a7336-2b5f9e7824amr148337515ad.1.1776683502671; 
 Mon, 20 Apr 2026 04:11:42 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab30f29sm98792685ad.68.2026.04.20.04.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 04:11:42 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@denx.de, tl@denx.de, trini@konsulko.com, sjg@chromium.org,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v2 0/2] video: bridge: add ITE IT66121 DPI-to-HDMI bridge and
 enable on BeaglePlay
Date: Sun, 19 Apr 2026 23:05:38 +0530
Message-ID: <20260419173541.31592-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:39 +0200
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

This series adds a U-Boot video bridge driver for the ITE IT66121
DPI-to-HDMI encoder and enables it on the BeaglePlay, where the TI
AM625 SoC's DPI output is routed to the HDMI connector through this
chip. With this series HDMI output works under U-Boot via the TI TIDSS.

Changes in v2 (driver, addressing review from Simon Glass):
 - Use lowercase hex literals consistently.
 - Include <linux/bitops.h> explicitly for BIT().
 - Replace bare AFE mask/value magic numbers with named
   IT66121_AFE_{XP,IP,XP_EC1}_PCLK_{MASK,HIGH,LOW} defines and add a
   block comment referencing the Programmer Guide "AFE Setting" section.
 - Switch EDID pixel-clock extraction from hand-rolled byte 54/55
   parsing to edid_get_timing().
 - Add a comment explaining that video_bridge_set_active() is a no-op
   on BeaglePlay (no reset/enable GPIOs in DT); the chip relies on its
   internal POR plus the software reset sequence in it66121_hw_init().
 - Propagate it66121_setup_video() failure instead of swallowing it.

Patch 2 (BeaglePlay working) is unchanged from v1.

Shaurya Rane (2):
  video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
  BeaglePlay: enable IT66121 HDMI bridge and video stack

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  42 ++
 configs/am62x_beagleplay_a53_defconfig       |  13 +
 drivers/video/bridge/Kconfig                 |  10 +
 drivers/video/bridge/Makefile                |   1 +
 drivers/video/bridge/it66121.c               | 580 +++++++++++++++++++
 5 files changed, 646 insertions(+)
 create mode 100644 drivers/video/bridge/it66121.c

-- 
2.34.1

