Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1739ACCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC09838BB;
	Fri, 17 Oct 2025 17:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="d1QQRLI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C93683857; Fri, 17 Oct 2025 17:24:32 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD6283826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 9048B25C64;
 Fri, 17 Oct 2025 17:24:30 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QDrd9rfl4a5c; Fri, 17 Oct 2025 17:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714669; bh=UA6UFrUqGG84N03cXSmHZmlAgueadTwf/LKLFuPkgDA=;
 h=From:Subject:Date:To:Cc;
 b=d1QQRLI9PcwzZducIKlpQdoZt/EKvfd1z7YMPyNTUJw/0BkfF4H8vre90QqSrgDKG
 7hOL8K8u5P6C/oVDofDUCNkQTlrfZtLZtHnKhc07SJEv+HMVIH35nYcBV6L9ZEn+qY
 6/TnDnzxoTCN7KXjT7xKQ5s5jbvOSQEZRzHe2C0CxSyLNAIH/y9MTw9smKAfBPdbZe
 bfKU9LmDfmr5HHUEMe6FfSdaKZMu59ysz42nyB2/Mcl1iSEpTAkntVIxl5hO0efQ9g
 cNvNAi83vK2hQ1i9Uddaide4X1Hyyh84HAxtHcBhBY52PEdb5rqltjuDf6x0HHiVg5
 akBMt7UKWKZbw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/9] Support for Samsung Exynos 7870 DW-MMC device in
 driver
Date: Fri, 17 Oct 2025 20:54:05 +0530
Message-Id: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJVf8mgC/x3MTQqAIBBA4avErBtQqdSuEi2kppqFGgr9EN09a
 fkt3nsgU2LK0FcPJDo4cwwFsq5g2lxYCXkuBiVUK4Vs0PsJ5xPpukPM2miBVpJVzi6dMw5Ktyd
 a+Pqfw/i+H24/vPVjAAAA
X-Change-ID: 20251014-mmc-dw-exynos7870-91e92a9f6a8a
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=1400;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=UA6UFrUqGG84N03cXSmHZmlAgueadTwf/LKLFuPkgDA=;
 b=GGfBvODm9V59lpFOniIzG7XDuzkEH1vCa0UQx4sIg5bY5ImUshn0sRAcKws54U1ilP8Fy8YhD
 gMtUTVmkXHuDTyevEeEnsnPDyGzE2PysZ+LgqY8aS1KdQAmVq1vAzsw
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

This patch series aims to add support for eMMC and SD-Card in Exynos
7870 devices. This brings changes to the core DW-MMC code, and the
Exynos-specific driver as well, introducing HS and UHS mode support,
and changes in SD init sequences.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (9):
      mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()
      mmc: dw_mmc: do not skip dwmci_setup_bus() for same non-zero clock frequency
      mmc: dw_mmc: properly address command completion in dwmci_control_clken()
      mmc: dw_mmc: add voltage switch command flag
      mmc: dw_mmc: return error for invalid voltage setting
      mmc: enable/disable VQMMC regulator only during MMC power cycle
      mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes
      mmc: exynos_dw_mmc: add support for SD UHS mode
      mmc: exynos_dw_mmc: add compatible for exynos7870-dw-mshc-smu

 drivers/mmc/dw_mmc.c        |  50 ++++++++--------
 drivers/mmc/exynos_dw_mmc.c | 135 +++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/mmc.c           |  20 +++++++
 include/dwmmc.h             |   7 +++
 4 files changed, 169 insertions(+), 43 deletions(-)
---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-mmc-dw-exynos7870-91e92a9f6a8a

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

