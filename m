Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20D9CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066F68397B;
	Fri, 17 Oct 2025 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hcOCs3aq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D3283804; Fri, 17 Oct 2025 17:28:32 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 918A983804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6165E26292;
 Fri, 17 Oct 2025 17:28:30 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZiBmH_nKglQ; Fri, 17 Oct 2025 17:28:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714909; bh=GLEkKuuebRmaNfd8N4otOCwZa9ZNE5NgEYQeswpsh3U=;
 h=From:Subject:Date:To:Cc;
 b=hcOCs3aqC9ejIfMIYuCkDh9s+286HfTEAPgt799XDgAfpu/muBxjpq4z5NYs7Yvmp
 KOI24nKmoq10r90Aq9RuNfJWVzXEGKVgVhyO3sHQG66c1syBIOWnJunFbG5UP1i13e
 0Pql0rfwAta3LkFQDK+PdZaL7Ysn39o/OO4GKtJJCZJ9IciwKjGjf7BDZsVag43VGa
 gd7jgygDl55WW6zEanapjb5zhtLTyPYeUJbEdG9UQhDH3ubw1LFK+CeCqKbscwMqFa
 r59dXxuW/njdPEQVIMOF7JYUCrQBzHF8lhK3Q+xJzv1prKAXpkvDdtRXT5ZRBhNad1
 AmNMUzsmwpQBQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/6] Support for Samsung S2MPU05 PMIC device in driver
Date: Fri, 17 Oct 2025 20:58:15 +0530
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBg8mgC/x3MQQqDMBAAwK/Inl1IYiXar0gPabrGhWrCptpC8
 O8NHucyBTIJU4Z7U0Do4Mxxq9BtA35xWyDkVzUYZXqt9A1T/JJgWtmjUNjf7hMFs1nTrnp0gx0
 dKfvsRg21SEIz/65+epznH1KSMX9uAAAA
X-Change-ID: 20251014-power-pmic-regulator-s2mpu05-a879ae07b391
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=1208;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=GLEkKuuebRmaNfd8N4otOCwZa9ZNE5NgEYQeswpsh3U=;
 b=7d5jaabQlMxGh1PmX96im4IL/JPO3X5ssKjyXttp3Oq2xKeCWhz961swfHeovPxUpov0xStYQ
 iMe+53JsuEQBC+JyO48e6lFeixJrOZNMIqR3OabP1oUBudj0NtsA3eS
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

This patch series aims to add support for the S2MPU05 PMIC. This is done
in the existing driver of S2MPS11.

With the PMIC, voltage regulator driver support is also included. This
includes significant changes to how the driver identifies regulators.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (6):
      power: pmic: s2mps11: change the probe function to bind
      power: pmic: s2mps11: add support for allowing multiple device variants
      power: regulator: s2mps11: declaratively define LDOs and BUCKs
      power: regulator: s2mps11: declaratively get/set regulator mode
      power: regulator: s2mps11: add support for S2MPU05 PMIC
      power: pmic: s2mps11: add support for Samsung S2MPU05 PMIC

 drivers/power/pmic/s2mps11.c                |  37 +-
 drivers/power/regulator/s2mps11_regulator.c | 590 +++++++++++++++++-----------
 include/power/s2mps11.h                     | 134 ++++++-
 3 files changed, 515 insertions(+), 246 deletions(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-power-pmic-regulator-s2mpu05-a879ae07b391

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

