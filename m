Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E4ACCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 22:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B7083B49;
	Fri, 31 Oct 2025 23:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s8jNOaey";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KLiJN9hJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D04D83B48; Fri, 31 Oct 2025 23:44:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC8783B3C
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 23:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cywyx2Xbmz9smC;
 Fri, 31 Oct 2025 23:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761950681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPalbM4NL1TwQopaEBSVOD0lboPMyV2bF8lr8Mj1Ctc=;
 b=s8jNOaeyTXtvJmRjBM81kdSKvbtMfAs94qIGzk19VvF50SGua0kFM/q/q7YddeJhtLTLfF
 gmqdTaWg4xmg5Cv5apvUD5DJAzcJI0gLcT9748zCaiCAGi8NmyW5ihSYphgnWNSpth0hIa
 UYprxgZe0l5SzQ4vnbxaZIyt5PLVSb4ONfVLhtOOKmCQ3hW0GYzvi09ACeiFtxxDF4EM5s
 2xUQpQyawLXj1P6oLOw6wdRpyZKqGH2bjAhhl2HUM0eb+BFYVKA5uNM9tiRXokCssUqbqj
 J0kVizNRaxVsiKB934QFMOhnMbrCzgFBODZrFNIhTqhX/7cQl8P3Fc6ONLdgFA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761950679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPalbM4NL1TwQopaEBSVOD0lboPMyV2bF8lr8Mj1Ctc=;
 b=KLiJN9hJuvamBGTBiE+miJl4hmIpLWH2UpjG5+emP09SBmGQPU5pkPSGa/Uwy9ypmoZtP1
 O6DLu4tSP2RoGza7fRN3FnhvB2j2comJzoQ2hMI2SeTLjgh1s6FLA1pjzuuPtM29lky2bI
 DeRzaypAgrNVVoGITiY0ldQL38/7Pn7ThchKeWgpETUAeJJuZj1qnxs1wEjcN66woI4Wo8
 SYkIusYVYZcrLJ8afxV5MNMb0Vds6U6Cn8oTfnagmkVviGwTi54JWRATMKOp4gDu6vEoy4
 WmVFPQSmLV9S5yod2Q5ppJtcDXmR9GpmXQQivR+vXh944UHgD1L7EsaVwICDHw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] spi: Clean up more of the stacked parallel ifdeffery
Date: Fri, 31 Oct 2025 23:43:43 +0100
Message-ID: <20251031224434.102648-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251031224434.102648-1-marek.vasut+renesas@mailbox.org>
References: <20251031224434.102648-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 53gropohmm41cmnki4i9fi8e7mjnakpo
X-MBO-RS-ID: fada77a3cf1956e9b72
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

Invert the conditional when to exit, and fall back to common code
in the default case. This should have no functional impact on either
code path.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Dominik Wernberger <dominik.wernberger@gmx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de
---
 drivers/spi/spi-uclass.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index a7a06312435..7a4e6d0fc5c 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -180,25 +180,22 @@ int spi_write_then_read(struct spi_slave *slave, const u8 *opcode,
 static int spi_child_post_bind(struct udevice *dev)
 {
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
-	int __maybe_unused ret;
 	int mode = 0;
 	int value;
+	int ret;
 
 	if (!dev_has_ofnode(dev))
 		return 0;
 
-#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
-	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
-
-	if (ret == -EOVERFLOW || ret == -FDT_ERR_BADLAYOUT) {
-		dev_read_u32(dev, "reg", &plat->cs[0]);
-	} else {
-		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
-		return ret;
+	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+		ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
+		if (ret && ret != -EOVERFLOW && ret != -FDT_ERR_BADLAYOUT) {
+			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+			return ret;
+		}
 	}
-#else
+
 	plat->cs[0] = dev_read_u32_default(dev, "reg", -1);
-#endif
 
 	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
 					    SPI_DEFAULT_SPEED_HZ);
-- 
2.51.0

