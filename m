Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06F1C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 06:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7EC7406C3;
	Wed, 19 Aug 2026 06:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSBQ4jZzbQhr; Wed, 19 Aug 2026 06:59:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787122789;
	bh=FL6Drxv88A28hDjeOIXo4+RQRd7/9wv28mYYcuZ0k8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AVMrEUXEMb2Qc+ZDjteviuVw+0iLe9fHCsPGP9xFuLMHNGVzKCsDgTK4Kapw6nWWK
	 0PM+zyNGIfAjKpmlDHAZO0TetZf/Cffb490zRWhJO2WmWS9Y+0Fn1o54kjvplEzO6L
	 zS4e/cwGRhp+obS/ngruF9/f3GaPBrJJPnRNo7jFwr6Keb2ILwt2usPe6coNr1kgxU
	 VSqBj19eB9jZV6sRRMoTlmkGcV1xBKmwOIGKYBltTnvSlFpprZ+qdQPa7Dkv5KXylw
	 fO5Vpi3zxWMa3z7kUnSeTKPj8hqDqO99BoQlYKTYo/Mt/gRmi6oSjRekN03jRn5wIO
	 tCyOhY5iiX12Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49EFB40654;
	Wed, 19 Aug 2026 06:59:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 179311460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08E7860659
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id js5gMSYQJ4xR for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 06:59:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=qJAwKM/0
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B151660658
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:45 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787122783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FL6Drxv88A28hDjeOIXo4+RQRd7/9wv28mYYcuZ0k8c=;
 b=qJAwKM/0iNiRWX+shc1NUCYn2iQplbWjmH01aLhL99Yux484pHsh1iNu4zJ7p+vyQpHNqC
 WQzeTd+70JVzB6WwqJ4uIAk7h2asQCQhSqD01jnnNDzxTsOR//Pc85qlPVXUrVn9nL8C/o
 ggcNRx12hn8UrdU9iFz81Dh3asNTJQK0D9S5MwgmweKVfaIBFqyDWBnR48QTL3lBIAK2IY
 ZI8r0YevKcd+yASvl8HXUofhrw9A33JSdsgfcrC/VR+lltUoJPiBudWURiMQ0PGYfaeaJ5
 tHZXLIgpFrRxW1F+uZEaNyZZ1+RuNlVHatBm1epMAgSb/tzRo4ue//9H1KnOZw==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 2/4] ddr: imx: Move error message for failed training to
 calling side
Date: Wed, 19 Aug 2026 08:57:59 +0200
Message-ID: <20260819065804.32156-2-frieder@fris.de>
In-Reply-To: <20260819065804.32156-1-frieder@fris.de>
References: <20260819065804.32156-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Move the error message from wait_ddrphy_training_complete() to the
calling site in ddr_cfg_phy(). This is more robust to future changes
in wait_ddrphy_training_complete() and allows us to make the message
optional.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/ddr/imx/phy/ddrphy_train.c | 4 +++-
 drivers/ddr/imx/phy/ddrphy_utils.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 63a6ca800a3..68468610fd6 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -72,8 +72,10 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 
 		/* Wait for the training firmware to complete */
 		ret = wait_ddrphy_training_complete();
-		if (ret)
+		if (ret) {
+			printf("Training FAILED\n");
 			return ret;
+		}
 
 		/* Halt the microcontroller. */
 		dwc_ddrphy_apb_wr(0xd0099, 0x1);
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 8e350de8315..8779db01607 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -97,7 +97,6 @@ int wait_ddrphy_training_complete(void)
 			debug("Training PASS\n");
 			return 0;
 		} else if (mail == 0xff) {
-			printf("Training FAILED\n");
 			return -1;
 		}
 	}
-- 
2.55.0

