Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE076C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9598682C8D;
	Tue, 17 Jun 2025 10:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g37JJJKd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mAbSyfjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED70C80C83; Tue, 17 Jun 2025 10:17:14 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01BDA82C87
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bM08m5tZtz9swL;
 Tue, 17 Jun 2025 10:17:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750148232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwoPJRPRTqqVrPkam43GUzS8fdj+4R9STOqtuVLiWcs=;
 b=g37JJJKdZf4Fl5oLJ1kDRz/gaRQmFKVCGe8q38qj6iS0PH5NmzxtCrPtaDYZuQI3XXmcpF
 +szL6Lr3o0FhNfEzAaZ/KFe7VAuLedj0e5hH1TyB/9A5z0kkCtAcTfhP7m+LWQfVJVCvAN
 v/p7tTOIgaeeoo/XAOvL/V5E1pycWftwo6NL3C85upCq5EwunUkNZECtsSWqRTyton3NTL
 l25dzIsHzaNXXyPo/Q36yGzNBC/X4QYybls0qOHdJude7ThnGdotqwXghZH8Z00aTfPEoX
 xzAMgJaTVcWHKmhbdYWY4R9C+6+6zQR2sskEGcm5Xdhc959fx88FBI/+qzjBPA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1750148230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwoPJRPRTqqVrPkam43GUzS8fdj+4R9STOqtuVLiWcs=;
 b=mAbSyfjQL/9GxHBM8fg5PW0MMbVne4dEcDN7gZ7z8PyfqF4oYrqMpqTrNstubJihWaxg0w
 UdaQEaAaNRwg7SRvw5cMPIQKs8FjS5iDW/zkIKP6lWptKFTGleJcfNztVISoKvNWN+x4Qk
 kTNEXcKQ877mMjeKbxfJHET/hoM6vydFgDqql233xz0V/F0xrepLxOaZ32vz34QxjZ0P0T
 B/TMzpHxyjHx4KZqoAKiGBRfZ4MkFlZ8eHqQ9uDErAouEyzjSzmoCD/Q50PtuAm6vPGcoC
 toENht/FRXKjDiLENdkctZoDJG8vhImPGkt4qcKdce+U3j9+tnUyQvY63+EbrQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot-qcom@groups.io
Subject: [PATCH 3/6] pci: pcie_dw_qcom: Use dw_pcie_link_set_max_link_width()
Date: Tue, 17 Jun 2025 10:16:29 +0200
Message-ID: <20250617081641.8385-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e3wt73y1au67my1jddic3rus1myg5kss
X-MBO-RS-ID: 380f6469c229cd87810
X-Rspamd-Queue-Id: 4bM08m5tZtz9swL
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

Use dw_pcie_link_set_max_link_width() instead of local implementation
of the same functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: John Crispin <john@phrozen.org>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 drivers/pci/pcie_dw_qcom.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index 39b4cd4efe2..978754e8472 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -213,17 +213,6 @@ static void qcom_pcie_clear_hpc(struct qcom_pcie *priv)
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
 
-static void qcom_pcie_set_lanes(struct qcom_pcie *priv, unsigned int lanes)
-{
-	u8 offset = pcie_dw_find_capability(&priv->dw, PCI_CAP_ID_EXP);
-	u32 val;
-
-	val = readl(priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
-	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, lanes);
-	writel(val, priv->dw.dbi_base + offset + PCI_EXP_LNKCAP);
-}
-
 static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *priv)
 {
 	/* iommu map structure */
@@ -299,15 +288,9 @@ static void qcom_pcie_configure(struct qcom_pcie *priv)
 	val &= ~PORT_LINK_FAST_LINK_MODE;
 	val |= PORT_LINK_DLL_LINK_EN;
 	val &= ~PORT_LINK_MODE_MASK;
-	val |= PORT_LINK_MODE_2_LANES;
 	writel(val, priv->dw.dbi_base + PCIE_PORT_LINK_CONTROL);
 
-	val = readl(priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	val |= PORT_LOGIC_LINK_WIDTH_2_LANES;
-	writel(val, priv->dw.dbi_base + PCIE_LINK_WIDTH_SPEED_CONTROL);
-
-	qcom_pcie_set_lanes(priv, 2);
+	dw_pcie_link_set_max_link_width(&priv->dw, 2);
 
 	dw_pcie_dbi_write_enable(&priv->dw, false);
 }
-- 
2.47.2

