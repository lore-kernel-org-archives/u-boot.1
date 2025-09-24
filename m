Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182B6CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 01:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516C5808AF;
	Wed, 24 Sep 2025 03:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fIj0b+oF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="r287mT0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23D883443; Wed, 24 Sep 2025 03:47:54 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B843B80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 03:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cWfqr3qFQz9v1T;
 Wed, 24 Sep 2025 03:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=da2YE6hjX6ik8zspXJquSuucOUVFqr03Nhns2HE0R1I=;
 b=fIj0b+oFPAulbOrw5d8N9pXpWLbXE7ndyfXJ7Uj8OjR/KBrcq99e8FpmBpdMDCwf0nSR4a
 qlF8C54XAtLn/zGUTs5w2iqbJzZ216POgOTL/wAMzEyajHv1DBarxcdg8CW2/5XSj0x415
 E9kp5kN/QLOF/GlxgKLeq5oqRDEgRbcj4gmOblAQH7UGGxo6Mfo1h06O3US3DWG87Pvco3
 9Mbodq5CyPT2/VbQcGYwF76U3O8FPVcMsiHv4YaFDJ/FGiSoc4k8r6pEySH2f/kCaXS1vY
 liFux/BQ7FwMCYc7yKmam6O/3wFXNYjkhvLD+XXOhbOyIwOWBEhyJPKtqPbHEA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758678470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=da2YE6hjX6ik8zspXJquSuucOUVFqr03Nhns2HE0R1I=;
 b=r287mT0aoDK9Io+8ifIUCC5p9O0looRVv1XSwJqr+RVQiH8+yRJhDSmxjTTOeX1zJn24A3
 Du8U3RYyKq4BSqkXlm/iqpK3yqBwTNSUTHygQNXk/5FToX0qebDX1ezcp7C5vqLRXKiB9L
 rJegazf+Y8QHPZJ7CURDOH/9GBj54IK1EKSl4H7B42g8+JNYKjZPtn0mWfIiAFE7RcE0L1
 rUM4Je6jnYuS9y+pOYinYbSt5Zd163fy55etQJ4CDiMm/iEdiaHzrAGCRZYfzC/S9l3qfO
 APaQD7SfhHVJjck0uXCN29u3kJ75dYgHrg42k9PabG499vIzuhxx+cL5e2FMPw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] pci: pcie-rcar-gen4: Fix inverted break condition in PHY
 initialization
Date: Wed, 24 Sep 2025 03:47:12 +0200
Message-ID: <20250924014730.120800-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6f61cf39d3d1b913e0e
X-MBO-RS-META: k6yazfze4mz5n535dcbejszwns7khpkw
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

R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 4581
Figure 104.3b Initial Setting of PCIEC(example), third quarter of the figure
indicates that register 0xf8 should be polled until bit 18 becomes set to 1.

Register 0xf8 bit 18 is 0 immediately after write to PCIERSTCTRL1 and is set
to 1 in less than 1 ms afterward. The current readl_poll_timeout() break
condition is inverted and returns when register 0xf8 bit 18 is set to 0,
which in most cases means immediately. In case CONFIG_DEBUG_LOCK_ALLOC=y ,
the timing changes just enough for the first readl_poll_timeout() poll to
already read register 0xf8 bit 18 as 1 and afterward never read register
0xf8 bit 18 as 0, which leads to timeout and failure to start the PCIe
controller.

Fix this by inverting the poll condition to match the reference manual
initialization sequence.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/pci-rcar-gen4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 1db7c73436e..1b79d834122 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -245,7 +245,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 
 	clrbits_le32(rcar->app_base + PCIERSTCTRL1, APP_HOLD_PHY_RST);
 
-	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 10000);
+	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 10000);
 	if (ret < 0)
 		return ret;
 
-- 
2.51.0

