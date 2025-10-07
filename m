Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F7CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D6D838BB;
	Tue,  7 Oct 2025 10:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="fDIbxOcA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA81838C2; Tue,  7 Oct 2025 10:18:19 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9FC8386F
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 11FB8C9A4B; Tue,  7 Oct 2025 10:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825096; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HuJSOryuJDd+m6spMIudKrnmfdNy16Vs9ytxhibCHrg=;
 b=fDIbxOcAAo1K1GweDr0Z3ufStTE9Ublt3S2B/M3NqWz+92TC05tCV/4LwobCeHaslPSRcZ
 SAThSeBzOne9EwV5gM5zbrx2sfIOWmP0cDVSOQXIFGP3jEpNgfX8RyzYr6nFOKxKfJCEyj
 AL5sj5gTI8ow7TfaKZhJjNgFIbzy+ROUciPuuTkdNHtXcJok3akDQEWlkjeffHkevgBlPH
 qx1f6PBTLXFG4tVu9yuinGmzUNaQ4925QuUiUVNaAfLC8G8hreyKPEUfsj53vsaxNapPaz
 lnnSDoynNMgPBZa2Pq/+QUp7SP0a+QxH3WWYw8FWRKHq1zO42h1NnXA6KsWtoQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/13] imx: kontron-sl-mx8mm: Enable fixed regulators
Date: Tue,  7 Oct 2025 10:16:01 +0200
Message-ID: <20251007081640.61772-5-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable support for using fixed regulators from the devicetree and
auto enable them if requested.

This way U-Boot will enable the CARRIER_PWR_EN signal of the OSM
module automatically while initializing the board.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx8mm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 7b6ab1e217f..71dde10ee4f 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -131,6 +131,7 @@ CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_RV3028=y
 CONFIG_RTC_RV8803=y
-- 
2.51.0

