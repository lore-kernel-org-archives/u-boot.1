Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD52C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173B680A3E;
	Fri, 24 Jan 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730556;
	bh=7LU/QQTNN7eebcfzv3Hv2W/eex0Ae4N8xCtB0uG/6Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cI5u7JsWhYmu+lfO6ryKO7j/JVnDuqkUr5OsWYWum2oDR7JXtiBie+6Fxtz/6chkm
	 ifmYFaSda7oFONWW4RRAYTDUfoeCTU2qBp36pBjYk46dcHKm7Kj03nIvE1N6XPxqmB
	 z9iR6hQcmuO2tvbB5qxGytWtWRq9AX5NXxVFVuX7XY+srTAz0ULiecvGM8Qy5QUmxj
	 NA/JJbDluVRpsR4p4NMkvo8DVbFgOcqurIoFOIPSMQeMPvlI6lIArp/uPQgPgkIWPM
	 4quYyY0W4rEDaJZ8t/af1mLX14Iggu9gDlrkAutZFOnY6CDA7a/bM73xfxlzGTjkWn
	 0WLVHgQAWelYQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FFC80ADF; Fri, 24 Jan 2025 15:55:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C4180A2A
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="C8MAXJYW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D764710A396CE; Fri, 24 Jan 2025 15:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7LU/QQTNN7eebcfzv3Hv2W/eex0Ae4N8xCtB0uG/6Us=;
 b=C8MAXJYW1xQ69lcaR1fNTvbPxpgmXo+7QSqvuvg5qGFODhg3J6CR9dC88qLcO/BQb9VDvt
 KUOG+R5kQLOPpemVyPl9BJ5uNq2oJchMp73hvcdLdooUkSaNIgv1Mx8M6XJ/x0FB9BHMO1
 uc65dhNcaet9jRT1X8tlDRWpCmzFZmJi0UMVUEwJbmMiRPy1BUcOTj7mDCxFOMddmfFi+Y
 2lSEWWB8X+fTSEoEf2TePquZI/HLUcz9bBNtIlqhMJ/eJCQHkG63DoJZQthVNfJzCnFUI5
 LhRB1PbNzCS1/K/6x0/u1E7sqRPz67eWfzf1JSUG3jy1PRb/AhnXmhCU5hvgKQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] pinctrl: imx: Drop .remove callback for SCU variant
Date: Fri, 24 Jan 2025 15:50:52 +0100
Message-ID: <20250124145520.185414-3-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124145520.185414-1-marex@denx.de>
References: <20250124145520.185414-1-marex@denx.de>
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

The return callback for SCU variant of the pinctrl drivers does
nothing but returns 0. Remove the return callback from the SCU
driver itself, that has the same effect. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/nxp/pinctrl-imx.c  | 3 ---
 drivers/pinctrl/nxp/pinctrl-imx8.c | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 3f055321c73..3443cf459db 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -256,9 +256,6 @@ int imx_pinctrl_remove(struct udevice *dev)
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
 	struct imx_pinctrl_soc_info *info = priv->info;
 
-	if (info->flags & IMX8_USE_SCU)
-		return 0;
-
 	if (info->input_sel_base)
 		unmap_sysmem(info->input_sel_base);
 	if (info->base)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 0afae31eb77..85e5e5f5237 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -38,7 +38,6 @@ U_BOOT_DRIVER(imx8_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8_pinctrl_match),
 	.probe = imx8_pinctrl_probe,
-	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
-- 
2.45.2

