Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED6D32D81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 18:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0F3893C2;
	Tue, 12 Nov 2024 19:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Uw3nXczz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D038C89452; Tue, 12 Nov 2024 15:57:51 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FAF88DFE
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.bonnefille@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7B6440004;
 Tue, 12 Nov 2024 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1731423469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vgYZauMPmY1eEMMheGBblrqQtPgWs2Wq8SvOTF9qJVM=;
 b=Uw3nXczzEL9MwLyZEiKapJvhFcDHinE+S91Dw37yYE5yyKid8moMZpmaeSJxZnEYv6Hq2r
 AU2E15gSTrPB35ukuGTwKRLyA6HjH8OJN7TsMVEbB8vfpNZnz9vyHkJOjtCjRR+TiZlu0G
 dyVUTwvUf0QtnmAo5i9yykcsO9nu+8nQD5sYS8aut+47qgV4pIDEruk/0tAr/6lOb24EFe
 4LX4NfcXNxlgBAud8JrpkSWDE1bm8PaW+OjN0yYVXQ8HVXzk4fxVB3W4+1XbSBEIoPLKfH
 Gu7GYjFp/+RIWkTmgEdyfpAZ+6wTjhgWyu6sn/EEoVk7Hr38IGmcmLr1zG+tfQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH 0/3] Add support for LicheeRV Nano
Date: Tue, 12 Nov 2024 15:57:35 +0100
Message-Id: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9sM2cC/x2MSwqAIBQAryJvneCPoK4SLUxf+SA0FCQQ7560m
 MUsZhoUzIQFVtYgY6VCKQ6REwMXbLyQkx8OSigjB/wmFxBz5dHGxJ2evTBaLUYfMJon40nv/9v
 23j/hNPSxXwAAAA==
X-Change-ID: 20241024-licheerv-nano-c36d0432943b
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com
X-Mailman-Approved-At: Tue, 12 Nov 2024 19:41:23 +0100
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

This patch series adds support in U-Boot for the Sophgo SG2002 RISCV SoC
and one board using this SoC, the LicheeRV Nano.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Thomas Bonnefille (3):
      doc: add LicheeRV Nano and SG2002 SoC
      riscv: dts: sophgo: add device tree for LicheeRV Nano
      board: add support for LicheeRV Nano

 arch/riscv/Kconfig                        |  4 ++
 arch/riscv/dts/Makefile                   |  1 +
 arch/riscv/dts/sg2002-licheerv-nano-b.dts | 45 +++++++++++++++++++
 arch/riscv/dts/sg2002.dtsi                | 34 +++++++++++++++
 board/sophgo/licheerv_nano/Kconfig        | 28 ++++++++++++
 board/sophgo/licheerv_nano/MAINTAINERS    |  4 ++
 board/sophgo/licheerv_nano/Makefile       |  5 +++
 board/sophgo/licheerv_nano/board.c        |  9 ++++
 configs/sipeed_licheerv_nano_defconfig    | 47 ++++++++++++++++++++
 doc/board/sophgo/licheerv_nano.rst        | 72 +++++++++++++++++++++++++++++++
 include/configs/licheerv_nano.h           | 24 +++++++++++
 11 files changed, 273 insertions(+)
---
base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
change-id: 20241024-licheerv-nano-c36d0432943b

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>

