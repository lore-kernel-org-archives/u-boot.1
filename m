Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79117C87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507438397B;
	Thu, 31 Jul 2025 23:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="vopGgZCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D678393E; Thu, 31 Jul 2025 21:37:14 +0200 (CEST)
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB698349B
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4btK9327q2zB0R4;
 Thu, 31 Jul 2025 21:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753990631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hRbyumiXfdUXFyCDGdsuLDq2hUlH/u+czIXfW9ta66A=;
 b=vopGgZCFflrQob6x6jEmFEWUy7rF5z7jbCc4LQYhlGS39tT3OIA+ME3axV7YJ7RdgrTKbH
 6BrLt9QU8s+exIgWSNNZnLrxscLSYb9hrIRSqna6WwO/3RNVHtx5bn6pAha2tyPLTHLNZy
 J8HjrmtQfUP1k1iX81kyLUdW/ToRCh2f29sVthEk3zDhNQDOo2kQJsqjWl32MUxnnm74Pj
 3b6mLpVVNLFZ1NzYXyUEgDUdESXcb9If5kSZAXvuqwHELRNMYcQ3Rw3+HG9+A0YAleh/Pj
 YARlgg5ApL6bYFaC4obnNLIBM8Vt+UP/9NT0gunFh+bRA/DGYhyetAV8WMiQ6w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] video: Add drivers for Samsung's Tegra phones
Date: Thu, 31 Jul 2025 21:36:51 +0200
Message-ID: <20250731193656.286806-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btK9327q2zB0R4
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

This patchset adds support for panels and bridge used in
samsung-n1 and samsung-bose devices powered by Tegra 2.

Ion Agorria (4):
  video: panel: add Sony L4F00430T01 panel driver
  video: panel: add Samsung S6E63M0 panel driver
  video: bridge: add Samsung CMC623 image converter driver
  video: backlight: add Samsung CMC623 backlight PWM driver

Svyatoslav Ryhel (1):
  video: tegra: parametrize PCLK and DE polarity

 arch/arm/include/asm/arch-tegra/dc.h |   3 +
 drivers/video/Kconfig                |  24 ++
 drivers/video/Makefile               |   3 +
 drivers/video/bridge/Kconfig         |   8 +
 drivers/video/bridge/Makefile        |   1 +
 drivers/video/bridge/cmc623.c        | 234 ++++++++++++++++
 drivers/video/cmc623_backlight.c     | 124 +++++++++
 drivers/video/samsung-s6e63m0.c      | 393 +++++++++++++++++++++++++++
 drivers/video/sony-l4f00430t01.c     | 210 ++++++++++++++
 drivers/video/tegra/dc.c             |  16 ++
 10 files changed, 1016 insertions(+)
 create mode 100644 drivers/video/bridge/cmc623.c
 create mode 100644 drivers/video/cmc623_backlight.c
 create mode 100644 drivers/video/samsung-s6e63m0.c
 create mode 100644 drivers/video/sony-l4f00430t01.c

-- 
2.50.0

