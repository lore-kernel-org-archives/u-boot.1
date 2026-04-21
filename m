Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961EDF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9285F8422D;
	Tue, 21 Apr 2026 17:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="BIGtVqwc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36861840D8; Tue, 21 Apr 2026 15:21:19 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FFE83BC8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ee.vjti.ac.in
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=ssrane_b23@ee.vjti.ac.in
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so2515258a91.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vjti.ac.in; s=google; t=1776777674; x=1777382474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5twtEUoqqF7FdkHJBIXqDYaOZk7RuX7Gq1CEVw76hZ8=;
 b=BIGtVqwcWDcloiiT6j3Kij8GyX8Gz9hfZQXEgL6dRhYG9X//RXcq5oNNe9X5brRBv9
 AW47EHFsI926iJn+EwukqSFpYWwbFzDZs+vkiH19QDE+YaB4qJKF5MNG34vKuGOQaDZD
 bNgh9RI4y0RJYt8dsAjY/zHuVju/5G2/TSFmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776777674; x=1777382474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5twtEUoqqF7FdkHJBIXqDYaOZk7RuX7Gq1CEVw76hZ8=;
 b=Egda4HQ4VXZl4qbIzjCeFJW1TA7JzfsmHXR6CQGz6m2m4LgLEe5iAW3Z978kgDOcvv
 wgwwhx/7exyGlyP6cV7x6fyPqY2uMo+TttF3/sWKtlX59isUCFAi5rStiECR4l27ID7u
 6R6SVvmEIu4Ep/0xC6vfRd40UJ5HwzotLefuFxPeNpknsfLZasu1Kp+TPXrKAjx3vx1a
 M9rAwpmGJLKtOGTmCqDsbdCHRH1m9t0g/zRGWEPdXm1L14OjvZuScHWEWyQZ4cd0U5i/
 5EP4/09ZxfXX4xuJ/+agvJDufczkJbmRIU463KVJK0rhztVGRxLAGT2AXtwQn2LmV7W7
 CDbA==
X-Gm-Message-State: AOJu0YxSPjeOIEBvsj+llJBTXM/5etreLGTPvb8iBk5DyYRjaJELPQkn
 mHm782rdA60IFCoGCOiByHMXNR1FaIg8H+8E58H7cVhnekgp/FmcVYPRARc3m0RXb+VSuznnCV4
 N4kWDQ00=
X-Gm-Gg: AeBDiethOHlKyy8fw1qShI32tUusddWth8DWLbEYDdFuyXoz+5gfjJ4LnzsY9VWx9oC
 0eMpkZ/x37efu/a9u6w+KIGFSIU6oOSigjWrwBe51OT0zWJX3iyNuSZz9zzFZMUd9ubn7hlTnLv
 6xKeawE0ui8S/8yBraDE3DX7UfIKbHdlxN6S/TCPzhI6W8MZwW5KeOLvPbTXiYsp+VIWxPa3hL7
 4tsCDFaqiwbzIiHlATVXCs7ypbyFHacztMjP24Db5n6pJeEZ+F/3ECPh7yFdJzfbHdKpygGtOpV
 7p/kfENw7h+4GyhluJ/P2SA18QhaKwmo6ayL34Nfk+7LY1TZE9zx56UXCuzBTYC4aurb8Cvy8OD
 WwqbEtope8urEH9xokA4+VBA31IL31LsyzycZq+AB2dtzXctYnoDQlInv4fa/ZI8vTAeZp9dvhA
 vfqwbNDs/8fIo/8bllRv9r4wxZVYGVQIZG+BAidH0QMJo1muIp/9e0wCPHSaKkrC609rmLM1fLx
 UayfSRXfSV23TyktRlRMrDD/7072/pY
X-Received: by 2002:a17:90b:350f:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-3614049358emr19088822a91.22.1776777674316; 
 Tue, 21 Apr 2026 06:21:14 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com
 ([14.139.108.62]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fb42e25sm6688376a91.3.2026.04.21.06.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:21:13 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: u-boot@lists.denx.de
Cc: jd@ti.com, tl@ti.com, trini@konsulko.com, sjg@chromium.org,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [PATCH v3 0/2] BeaglePlay: add ITE IT66121 HDMI bridge driver and
 enable splash
Date: Tue, 21 Apr 2026 18:51:00 +0530
Message-ID: <20260421132103.30033-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

This series adds a U-Boot driver for the ITE IT66121 DPI-to-HDMI bridge
and wires it up on the BeaglePlay so the board can drive an HDMI output
from U-Boot (used for the splash screen via TIDSS).

Patch 1 adds the new video bridge driver. Patch 2 enables the DSS,
I2C2 and HDMI-bridge DT nodes for U-Boot (bootph-all) and turns on the
required Kconfig options (TIDSS, VIDEO_BRIDGE_ITE_IT66121, BMP,
SPLASH_SCREEN, etc.) in am62x_beagleplay_a53_defconfig.

Tested on BeaglePlay hardware: U-Boot renders the BMP splash over HDMI
via the IT66121 bridge.

v3 addresses Simon's v2 review comments on the driver: the remaining
bare BIT() constants in it66121_hw_init() now use named defines with a
comment describing the AFE power-on sequence, and the unused-looking
bpp local in it66121_attach() has a comment clarifying it is a
required edid_get_timing() out-parameter.


Shaurya Rane (2):
  video: bridge: add ITE IT66121 DPI-to-HDMI bridge driver
  BeaglePlay: enable IT66121 HDMI bridge and video stack

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |  42 ++
 configs/am62x_beagleplay_a53_defconfig       |  13 +
 drivers/video/bridge/Kconfig                 |  10 +
 drivers/video/bridge/Makefile                |   1 +
 drivers/video/bridge/it66121.c               | 609 +++++++++++++++++++
 5 files changed, 675 insertions(+)
 create mode 100644 drivers/video/bridge/it66121.c

-- 
2.43.0

