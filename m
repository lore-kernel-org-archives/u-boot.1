Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EF0CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9EB849B4;
	Wed, 17 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="J8n6khVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF42848EB; Wed, 17 Jun 2026 12:56:52 +0200 (CEST)
Received: from mail-m937.xmail.ntesmail.com (mail-m937.xmail.ntesmail.com
 [103.126.93.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99498846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42c14b655;
 Wed, 17 Jun 2026 18:56:43 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: [PATCH 0/3] qcom: Add support for Thundercomm RUBIK Pi 3
Date: Wed, 17 Jun 2026 18:56:10 +0800
Message-Id: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEp9MmoC/x3MQQqAIBBA0avIrBPUYqSuEi20phqCMqUIpLsnL
 d/i/wyJIlOCTmSIdHPiYy/QlYBxdftCkqdiMMqgQm3lOSZsWiXj5XkLXEs0VlPrCZ11ULIQaeb
 nX/bD+35DE6YUYgAAAA==
X-Change-ID: 20260617-qcs6490-rubikpi3-6271e9be6a7a
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>, 
 Roger Shimizu <rosh@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781693803; l=1029;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=jSHGHHpmopRLgPJzEXfhC4okApFLcm1QqvDHCvMZmIc=;
 b=iE/5ryd0vl6YILDkn5SgUhWDp6EEQubhzKIB2c1oiJavEOsJ1PAcSnvA2BZ5abS7iz5CsDS5Q
 0xmk9NoPV54C8tsWSBB+nQJoFTwwx0wxv3NqM62uMZGFqDPtPjQR9dK
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ed539eb4f09d5kunme9f1286a14f7ad
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHh1PVkgZSkxIH0hCTR5DSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 hKTkxOVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=J8n6khVkyd0yAmS9y2KL016z5BihoWlLtgkMBFu9bhOVpb5We1OJDIBCcYCws35goDTHVi4oS7ckYjGLA8PuN2kzXsI0LsIlfM8Mathb0U5naynSoqgUTdyLLlCFGFMfJgGEQTJXJHd7l/QORKLVHTaLCct018VCd3ZqIaz8izQ=;
 s=default; c=relaxed/relaxed; d=thundersoft.com; v=1; 
 bh=lreAi8ZgHoqgF6LKJYkwcMCNbBDQhaactbB/olLkGBY=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:21 +0200
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

Add initial U-Boot support for the Thundercomm RUBIK Pi 3,
a QCS6490-based development board with 8 GiB LPDDR4x memory.

The series adds the board-specific U-Boot device tree override,
a defconfig, a MAINTAINERS entry, and board documentation.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
Hongyang Zhao (3):
      dts: qcs6490-rubikpi3: Add U-Boot dtsi
      configs: Add qcs6490_rubikpi3_defconfig
      doc: board: qualcomm: Document RUBIK Pi 3

 MAINTAINERS                                        |  1 +
 .../dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi   | 20 +++++++++
 configs/qcs6490_rubikpi3_defconfig                 |  7 +++
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/rubikpi3.rst                    | 51 ++++++++++++++++++++++
 5 files changed, 80 insertions(+)
---
base-commit: a0a1e9f2f1dffed04ee52723ce957c07bb905c25
change-id: 20260617-qcs6490-rubikpi3-6271e9be6a7a

Best regards,
-- 
Hongyang Zhao <hongyang.zhao@thundersoft.com>

