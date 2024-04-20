Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EF8C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:04:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD515886A5;
	Sat, 20 Apr 2024 02:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="FGqhikG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B00F886CF; Sat, 20 Apr 2024 02:04:23 +0200 (CEST)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF047881F6
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BU1iC6gVG3dJUyc04farFgf4QliHt9fc540Un9bkKzg=;
 b=FGqhikG/qMOk8h78ZPmX/SjG+6TgI/oefoNshw81mxZqc01aKzGfH2hV4cZ9+zMVmXjWXL
 /G772WaJxu+TbQEOt8OweU69Y4NtsILbfzQn+5aCEfSGivycZlBdKThY2c/4fWwWtKYl3I
 Gh77nV7cEg2cHfbyfn/dKSiLSVuChbBRMdixtg6AMLUWZzN+8/dJmwI2ADzQu4p8U/psuL
 wOBlK9iMMUDYyPxawuI9AftBmIdOkTtO8sivAXrD38TQ+Uu44E9KhaAPdwPFq3Wz9ISJaE
 vp9hTzgB/vb2jlRoPBo3bp5fQ6i55Dow0xCN7IqP6t6GbIrjmdOUxu00S8aBRQ==
From: John Watts <contact@jookia.org>
Date: Sat, 20 Apr 2024 10:02:38 +1000
Subject: [PATCH RFC 5/9] sunxi: video: enable DE2 on H6/D1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-d1_de2-v1-5-297efca674ba@jookia.org>
References: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
In-Reply-To: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571381; l=1517;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=CXRmt137o26NSf5yQUCmUV0QW+NJzP/eXJkYV/+fOhE=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAixuIL/X++RoZtmFaWm5EHLb
 0FPsZr9EvwWICZ/hOs70kIkC6XkSoyR6UJNpQpc1LIa9r9ckqd1bRgxd8w4pbAwUAAOpC
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This requires just a little change to clocking and reset logic.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/video/sunxi/sunxi_de2.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index e02d359cd2..9b6c41b212 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -45,6 +45,23 @@ static void sunxi_de2_composer_init(void)
 	writel(reg_value, SUNXI_SRAMC_BASE + 0x04);
 #endif
 
+#if IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)
+	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2)) {
+		/* Set DE parent to video1 */
+		clock_set_video1(432000000);
+		clrsetbits_le32(&ccm->de_clk_cfg, CCM_DE2_CTRL_PLL_MASK,
+				CCM_DE2_CTRL_VIDEO1_4X_NCAT);
+	} else {
+		/* Set DE parent to pll10 */
+		clock_set_pll10(432000000);
+		clrsetbits_le32(&ccm->de_clk_cfg, CCM_DE2_CTRL_PLL_MASK,
+				CCM_DE2_CTRL_PLL10_H6);
+	}
+
+	/* Ungate the DE */
+	setbits_le32(&ccm->de_gate_reset, BIT(RESET_SHIFT));
+	setbits_le32(&ccm->de_gate_reset, BIT(GATE_SHIFT));
+#else
 	clock_set_pll10(432000000);
 
 	/* Set DE parent to pll10 */
@@ -54,6 +71,7 @@ static void sunxi_de2_composer_init(void)
 	/* Set ahb gating to pass */
 	setbits_le32(&ccm->ahb_reset1_cfg, 1 << AHB_RESET_OFFSET_DE);
 	setbits_le32(&ccm->ahb_gate1, 1 << AHB_GATE_OFFSET_DE);
+#endif
 
 	/* Clock on */
 	setbits_le32(&ccm->de_clk_cfg, CCM_DE2_CTRL_GATE);

-- 
2.44.0

