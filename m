Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451410775E7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 268588352B;
	Wed, 18 Mar 2026 17:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q6ohcC/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D31983FA3; Wed, 18 Mar 2026 17:51:01 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A73A8352B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so607985e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852658; x=1774457458;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=65eiNNefIGX7qMeij4/MPIBwVRrrGUySplzMRShKHpw=;
 b=Q6ohcC/PzEJxjvdNiF8tEdEgaJXAibDRHsA/WPgq9YrS4OVAlNufEmRUvUUagrLEDC
 zhkN36Grs3aGqEnaYX0F7RUJgykv91by7tJmRkTiEcWUQJkKplHb+6Br1ZzZ89xfrxrx
 MI8HwYpv8Zdf3PX44vo4G/JZtX9sCTo1CyKAUrxMSRR1XEDyVAHIBOJpNj8DE/MuiKVz
 LTYeMQIFjBah3Iu5bdH3mtPPZWsIvzj8xaH2p99ZcFBaYHNqsknWgtBOi92twszzyGql
 Iitxpti4M6v+VYPY0Kcl4WucEzu3AIa40n0Ea9asu4f7UPtNjwQWoWR2pgnBB4xe5CwZ
 ADeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852658; x=1774457458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=65eiNNefIGX7qMeij4/MPIBwVRrrGUySplzMRShKHpw=;
 b=Jwl1Zx3ftk1xeavPbHhTdKf1diDRe60zaDvx9doHUSYyVPeSshR1fFYmvY5fL+1XtR
 25HIFGj9G2ELhhmcCIhJwF+gBrzYWNZgvwMO3lS1I0t7NwnGfNTVhNny5pxFItgijcy0
 LbGuKlEiHRQM2PCyTeWvjSkIq7K6qzFAAbcd+e/OJ/WPqtcOt9wiTY58I1DAzReyY53Z
 DVdezO/2kk2oG3H/lKqDP6TxgDDJ2ixxs14pAWEn7O77P+6wwoh5jAdAmc41cOD/jeRB
 sosggGUgCeIq/xSBKWqYZr7OJfF7DQaPDJuqTFqZeTZDvsKAlBP/IFBgnjZUxNEClXgv
 vpdg==
X-Gm-Message-State: AOJu0Yx0L9YUADY1xFDj0k9qxFH6ux9Tsc8JkTG53fV+x1TvV8dit7KZ
 Ve+LIvrF1096FK98X1g7tB5V9P9Igb+LYEC9JDKUZlwIiq020bRypVeOVpSmUb9vSFs=
X-Gm-Gg: ATEYQzwPPHm4MqKcVEE85ZUlxFPS05J/AMwnmVDOMP0srclbtiryKcQO0tStiZiGl57
 DWXI2pL2BkDwc1Lmat9SdS0oWB8f5jz7EecPWzi4mZMW9KczaUyTihoJSYeNCdZDX/+KZsgElRk
 CIWRjzvFUhOcklI2Z+6QF77TRtOkZv/HHHMneuJtA7LtLHA/B53mpgu2bh7gfkuPDZJPu2DSUs+
 P/P2NptDUkO0zau/YM66pFtQ7mKOgF6uV6TJU7aJM4wMe9TldjlYWs4h0zCr4I5LRLsCPgg4QET
 5LGwdNpTLaXgQIKvyl5jDngXM+5qEkYenPy7HWvyAYlQ9uY42rC4fVIb3Ido8qaCPiioCE3VuQk
 GmsvulCR+vZKVD+Sc+lyWQM7/PBrqOR9tzP9KXcwCTLWVwItnqaEHKWTudN9oMDY7papfohqU+S
 RLbvP7oJ4Bj9gvCDrMg5X50DDlejpJn4qaf5MRdZ5tDyMs2ft+kRpSK8yb0VIspRGRR1kZ8shR5
 HPHSX3i6ynDX5apA6jDMA5bQ7zZWm/b8KzmiaXcaN98V/Do40Ukp0gBMYXIXwXlR9Fcc8ay90ul
 0Vdh77k=
X-Received: by 2002:a05:600c:c4aa:b0:485:3949:e5c6 with SMTP id
 5b1f17b1804b1-486f441fc71mr72116965e9.3.1773852657846; 
 Wed, 18 Mar 2026 09:50:57 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:58 +0100
Subject: [PATCH v2 6/9] drivers: ufs: ufs-mediatek: fix phy handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-6-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Currently mphy is declared as a pointer inside ufs_mtk_host struct, but
it is never initialized.

Fix this by using a struct phy directly in ufs_mtk_host struct instead
of a struct phy*. Update all call to mphy accordingly.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 18 +++++++-----------
 drivers/ufs/ufs-mediatek.h |  2 +-
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index e860d765eea..5d882904c84 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -182,19 +182,15 @@ static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
 	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
 	int err = 0;
 
-	err = generic_phy_get_by_index(hba->dev, 0, host->mphy);
+	err = generic_phy_get_by_index(hba->dev, 0, &host->mphy);
 
-	if (IS_ERR(host->mphy)) {
-		err = PTR_ERR(host->mphy);
-		if (err != -ENODEV) {
-			dev_info(hba->dev, "%s: Could NOT get a valid PHY %d\n", __func__,
-				 err);
-		}
+	if (err) {
+		if (err == -ENOENT)
+			return 0; /* no PHY, nothing to do */
+		dev_err(hba->dev, "Failed to get PHY: %d.\n", err);
+		return err;
 	}
 
-	if (err)
-		host->mphy = NULL;
-
 	return err;
 }
 
@@ -323,7 +319,7 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	// TODO: Clocking
 
-	err = generic_phy_power_on(priv->mphy);
+	err = generic_phy_power_on(&priv->mphy);
 	if (err) {
 		dev_err(hba->dev, "%s: phy init failed, err = %d\n",
 			__func__, err);
diff --git a/drivers/ufs/ufs-mediatek.h b/drivers/ufs/ufs-mediatek.h
index 11a83d34c5b..0ffd0483eff 100644
--- a/drivers/ufs/ufs-mediatek.h
+++ b/drivers/ufs/ufs-mediatek.h
@@ -154,7 +154,7 @@ struct ufs_mtk_mcq_intr_info {
 };
 
 struct ufs_mtk_host {
-	struct phy *mphy;
+	struct phy mphy;
 	struct reset_ctl *unipro_reset;
 	struct reset_ctl *crypto_reset;
 	struct reset_ctl *hci_reset;

-- 
2.52.0

