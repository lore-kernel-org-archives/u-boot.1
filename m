Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2700D185F3
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2FB84131;
	Thu,  8 Jan 2026 14:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hh1cNmSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D328E84121; Thu,  8 Jan 2026 13:34:13 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE94839F1
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 13:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 38ADF26106;
 Thu,  8 Jan 2026 13:34:11 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STjhozs7SpGX; Thu,  8 Jan 2026 13:34:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1767875649; bh=u6dxhaFXUDejBStN+7/jOLy4M9bf+RXsjk+80IZW4Xk=;
 h=From:Subject:Date:To:Cc;
 b=hh1cNmSJLtqsN4OPpm215IZ/StmX6luNOrNPoxq++lJWqNhA8/k+xRos3H7Z3J6RF
 lbHs+0iORGP/2Wje46pVVgD4dXLkvJVimVRclLO2tvaJQ/Cxl+zoUl/VY3TLaPJmzY
 IUEpgw9UoRzEhZcYw84HHsijwIJDip4D9j5BI+yCocBNDDsI/CzgnnbjiO2k28OSje
 NVSvrJT8CMx0KNP0MYro4vOejJWhxAOgl3MEuKYAf/mLp4l19axW3lhy85ndD0TZMP
 gbz0/s3lmMVLVrHCdctsyOe1eOv2hygi5KriZpnNZcxZmIcX0PWyIPL8sdYfpJQs0u
 YEllh6tHNetUw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v3 0/2] Support for Samsung Exynos 7870 DW-USB device in
 controller
Date: Thu, 08 Jan 2026 18:03:43 +0530
Message-Id: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACikX2kC/23NTQ6DIBCG4asY1qUZfgTaVe/RdKEyKhtpwFKN8
 e5FExdNXL5fMs8sJGJwGMm9WEjA5KLzQw5xKUjTV0OH1NnchAMvGTBJP7Gm9tsIitM8+KiNBlp
 aYepSmAoUknz5Dti6aVefr9y9i6MP8/4ksW09PH3qJUaBtigVcrTsBuZhXQzej1cfOrKJiR+KA
 gbiXOFZUVpKpgxYbvS/sq7rD1g/D87+AAAA
X-Change-ID: 20251014-usb-dwc3-exynos7870-5d38b538a06e
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Marek Vasut <marek.vasut@mailbox.org>
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:07 +0100
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

This patch series aims to add support for the Samsung Exynos 7870 DW-USB
controller. The support is added in the dwc3-generic driver.

This also has a patch which allows the driver to fall back to "otg"
dual-role mode when none is specified in devicetree.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v3:
- change link in [v2 1/2] to upstream repository (Marek Vasut)
- use dev_info() instead of pr_info() (Marek Vasut)
- Link to v2: https://lore.kernel.org/r/20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org

Changes in v2:
- clarify rationale behind [v1 1/2] (Marek Vasut)
- Link to v1: https://lore.kernel.org/r/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org

---
Kaustabh Chakraborty (2):
      usb: dwc3-generic: allow fallback of dr_mode property to "otg"
      usb: dwc3-generic: add support for exynos7870

 drivers/usb/dwc3/dwc3-generic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 5e7624979083e2bc163e18165452d8ead462b58c
change-id: 20251014-usb-dwc3-exynos7870-5d38b538a06e

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

