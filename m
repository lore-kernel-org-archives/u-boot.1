Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01C1CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540D483984;
	Fri, 17 Oct 2025 17:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Yf71y6/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC9383852; Fri, 17 Oct 2025 17:28:38 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D0483826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8917A26368;
 Fri, 17 Oct 2025 17:28:36 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g_5ZeGlrglOp; Fri, 17 Oct 2025 17:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714916; bh=riweQeLwtXw+6kYeqdocY5Scq5JWXe14L4oDNteXaGY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Yf71y6/nmU2CJftPTv2VSXbbrW/VmTsGKWbXmctPmvktVWj3GoNkftvJI3qdnf5V7
 2GyUP3itl1E3K18hDCHVzUCVFtjfQK3zFM5aed+dQd2Uld3eDDbIInYHMGBv0ulA6n
 07l7Wfrc859OeVOkFU3+alTBliXWRG9YNSTRS6QwyxSninOBWBCjxmSIyMpQB+aFC5
 3dPJ47oHlCEo6tUE0ieEvPHC5FWXUtmc4LwXooQ533gBsj4sg1IRBVIvGdcoeo/Xzr
 7eArfLgzSXV39iln+EzuLM2X7wTE1XQXlwLUpe0Veug/7Cvf5t/NbPbAVu+5Lv6tab
 xnDNF7/uwlc7Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:58:16 +0530
Subject: [PATCH 1/6] power: pmic: s2mps11: change the probe function to
 bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-power-pmic-regulator-s2mpu05-v1-1-91cadc0f4156@disroot.org>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>, 
 Anand Moon <linux.amoon@gmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714904; l=1149;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=riweQeLwtXw+6kYeqdocY5Scq5JWXe14L4oDNteXaGY=;
 b=QnfKx0nmSrLigrQMSuCtceIwNkKvZaQECu69matODfYeXKsaUaClzP4GPDTEWFgwlDO2wK7S1
 0ui55CvcJlyCJiR9p/MiIacGxCPYKrkkf8/Abpr4qd16M8uOUvA9Cxe
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

The probe function, s2mps11_probe() is responsible for binding its PMIC
children. The driver doesn't have any functionality directly, but has
sub-devices which are parts of the device. Therefore, this should be a
bind function. This is the case in the Samsung S5M8767 PMIC driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/power/pmic/s2mps11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 6e81957903012d0f33fbea44c70db4b583993a99..23c96da3fdf485e171252f76f54a8778fa8bb20a 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -47,7 +47,7 @@ static int s2mps11_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return ret;
 }
 
-static int s2mps11_probe(struct udevice *dev)
+static int s2mps11_bind(struct udevice *dev)
 {
 	ofnode regulators_node;
 	int children;
@@ -84,5 +84,5 @@ U_BOOT_DRIVER(pmic_s2mps11) = {
 	.id = UCLASS_PMIC,
 	.of_match = s2mps11_ids,
 	.ops = &s2mps11_ops,
-	.probe = s2mps11_probe,
+	.bind = s2mps11_bind,
 };

-- 
2.51.0

