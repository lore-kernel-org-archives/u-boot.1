Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC0CDB471
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 12:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476C2846E1;
	Wed, 24 Jun 2026 14:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="bXyaSS3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30B480398; Wed, 24 Jun 2026 14:45:22 +0200 (CEST)
Received: from mail-m17197.xmail.ntesmail.com (mail-m17197.xmail.ntesmail.com
 [45.195.17.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F2380398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 14:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from [127.0.1.1] (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 439ac6888;
 Wed, 24 Jun 2026 20:45:13 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: [PATCH v2 0/3] qcom: Add support for Thundercomm RUBIK Pi 3
Date: Wed, 24 Jun 2026 20:45:03 +0800
Message-Id: <20260624-qcs6490-rubikpi3-v2-0-829dad7e6dd6@thundersoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/RO2oC/32NQQ7CIBBFr9LMWgxgBduV9zBdUDqVibFUoETT9
 O5iD+DyveS/v0LEQBihrVYImCmSnwrIQwXWmemOjIbCILlUXAnNXjaquuEsLD09ZjoxJbXApkd
 ltIEymwOO9N6Tt66wo5h8+OwPWfzsn1gWjLO6OY9KXIzA2l6TW6YBQ/RjOlr/hG7bti8hwcKyt
 gAAAA==
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
 Roger Shimizu <rosh@debian.org>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782305113; l=1317;
 i=hongyang.zhao@thundersoft.com; s=20260127; h=from:subject:message-id;
 bh=XcKGEQcsdHoSAlUL4L6/ph91QiFXnZ930MnXuFiQCbQ=;
 b=Id9sP4S9t9nZsYe0kQdmFWaTmQxjXX1BkRUUKGFj+fEOtwuq3I0aYruB7uWb5z3R3WMAoDoTc
 ZZRxxTqAOQ0Aw7rVnbFJvMEWBO7yLjPd66jW4FczQJ/AqlBecMkHlsK
X-Developer-Key: i=hongyang.zhao@thundersoft.com; a=ed25519;
 pk=D9yL5W9Zj0lPBDAq9gzY++1849VlXuTWAkROzZ88J/4=
X-HM-Tid: 0a9ef9a9c58609d5kunm227b613b9d3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkpPVkpNGhlJTR4YGUxKGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=bXyaSS3L6IToUcjRhBtDKSWxAlRcgRTWlWzdwcSsemsZjCMok6ow5tE5/ApJ1Q/VhU45022dadeBi/GP4aXKjrxOkbd/0pjZ0BTZVS8/nXTglFe3c+n49yDEu0pPejvyuvgR2+xsV9+nhrdzzno5xz73FU+yJyC3+HAfNIV5lgE=;
 c=relaxed/relaxed; s=default; d=thundersoft.com; v=1; 
 bh=88n/hbfkV7nJOleAfNDk4Y+wAACgjzONYif3DTPT670=;
 h=date:mime-version:subject:message-id:from;
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
a defconfig, and board documentation.

Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
---
Changes in v2:
- Rename the defconfig to qcom_qcs6490_rubikpi3_defconfig.
- Drop the MAINTAINERS update; the existing qcom matching covers it.
- Add instructions for entering EDL mode on RUBIK Pi 3.
- Update the documentation for the renamed defconfig.
- Link to v1: https://lore.kernel.org/r/20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com

---
Hongyang Zhao (3):
      dts: qcs6490-rubikpi3: Add U-Boot dtsi
      configs: Add qcom_qcs6490_rubikpi3_defconfig
      doc: board: qualcomm: Document RUBIK Pi 3

 .../dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi   | 20 +++++++
 configs/qcom_qcs6490_rubikpi3_defconfig            |  7 +++
 doc/board/qualcomm/index.rst                       |  1 +
 doc/board/qualcomm/rubikpi3.rst                    | 63 ++++++++++++++++++++++
 4 files changed, 91 insertions(+)
---
base-commit: 9f16b258e5632d74fa4a1c2c93bea4474e05234b
change-id: 20260617-qcs6490-rubikpi3-6271e9be6a7a

Best regards,
-- 
Hongyang Zhao <hongyang.zhao@thundersoft.com>

