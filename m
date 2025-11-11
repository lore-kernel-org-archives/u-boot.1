Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C19CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 11:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4170483B5E;
	Tue, 11 Nov 2025 12:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="eizEmoub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E10B83EC9; Tue, 11 Nov 2025 12:26:45 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F2483A94
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E59C81480134
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:26:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762860402; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=IMf5j297axpNnO8LGusD3LN5c1XHQVHt3f8jBxumjlg=;
 b=eizEmoubXBCZ+EepSUQ5E2A7/5eSza7Xycser8A010LvGXNKHDaskQXoXO9Pmk8Yml/Be5
 iPT1hGBow8eV3aihzrpi2IYQZUEYM329W+H5f8Vc+mtkvhjVpULOHY7tNu4Gz1Penpe15O
 l4xY5dTwWKynmsg5snz14Xm+Wr2/dl8noEfZtk9Jmbu0xXVbHkrIGIACdlN77drS+yMLt/
 baLbJ7aBkLNC6gE/YnPAocllTD6L+cIVt0qKWoB/R+ckFqqLvg36RrfbJx9yRMv5yPfvag
 PRZu52DwVyIIrOJZYXfJtOOmfJb++oavNaElFmKvZ3EfiEjAoM/lfmTFZu2ibQ==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/3] arm: dts: at91: sam9x60: Fix and improve flexcom 0 nodes
Date: Tue, 11 Nov 2025 12:26:33 +0100
Message-Id: <20251111112637.919074-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
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

Hei hei,

have a custom board here with a SPI-NOR flash (ISSI IS25LP016D)
connected to flx0.  While the actual access through mtd, spi-mem, and
the old atmel spi driver does not work yet, the dts changes are already
ready for submission.  One tiny step towards using upstream dts.

Greets
Alex

Alexander Dahl (3):
  ARM: dts: at91: sam9x60: Fix flexcom/i2c node addresses
  ARM: dts: at91: sam9x60: Define i2c0 node in dtsi
  ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)

 arch/arm/dts/at91-sam9x60_curiosity.dts | 12 +++----
 arch/arm/dts/sam9x60.dtsi               | 21 +++++++++++-
 arch/arm/dts/sam9x60ek.dts              | 43 ++++++++++++-------------
 3 files changed, 46 insertions(+), 30 deletions(-)


base-commit: 365a7079fb918643da0f0709660a7d8ea76dd6f3
-- 
2.39.5

