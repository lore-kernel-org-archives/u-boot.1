Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE79FD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E17F843C3;
	Tue, 17 Mar 2026 15:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0/ZdJBu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956E88439C; Tue, 17 Mar 2026 15:24:31 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7959E8437E
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so69081555e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757467; x=1774362267;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cK7du9nWArgfuMg4bC48GeAPpzgsckZrgH/a7ryhfqM=;
 b=j0/ZdJBuZO83Jp+W3cyUKzn2inWBN7CsXrQV/AAZ0E8DYw2N/AYk2r1PdD0Va4N3Ak
 0N0VWlI3QJ3yEqCTc93l2XKye60ebrHi3TLgY8KfKtaaCzqRedLTCsh1eNEwiEh6uc/V
 +8GOqZLWH9oTpJauaUhd5VRtELapVDOlO2/YiS4twxx/sFYulCnxNJhqls2Jt93SUPBJ
 oNx4Roi0hrF8dkWmaa9vl2Er0PSB9xhIUb27cpwrjewRVGcKedbw46jiX9rD7OWWSVEv
 kE+8no5XXqZEB/Z7OSqLY0Qc3C8VqCNSxGln73DYAhnn1BeaX39slYalji2gCFW2ieY+
 UnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757467; x=1774362267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cK7du9nWArgfuMg4bC48GeAPpzgsckZrgH/a7ryhfqM=;
 b=FawqClRie7lfj/rYMoXx+6LdJMDpYH+zmJvaKCpm7AdRquW8ykPLqwymcj6oEcBfnI
 92rDct5OHEF+lUaX87e2YpN3j7paWQrNjkvG0r7cQURVskD+wslvgzITqc3SkFOD+l1b
 xpK0EsVAWiMLxSP11SyGSLddF3VCFMfPKBfF9ljrYGf0wpnlavSYW7HTWKMRuoE3KFnX
 dtcMd3P/e4OS7alU0kdNdzfFucngvAbzhV0z2pR4SGKhWbfnPV/z1Q3JMqesW43/cNmq
 iNtKjdw7ds01SyAeyFC8pRP8cTF0Cz4KYWXiZstTnjrQLvM+1B/ztvdwxHz4q6T4LPsk
 eF3g==
X-Gm-Message-State: AOJu0YyelIEfTGrXRKOCW+DKg2tpyGsPwpUSy3BOZfErswDG6SVHT201
 rUYkTGbrRwZIVkiW7YUrHXnqP6kem+DExKwqEm9xw4irUF5HNjfTjAOFmqIPBYDMONo=
X-Gm-Gg: ATEYQzyQZ0LZ7zxYZdvsJfb0vUNjiXT3E2gL8BWjnSDZ8TolYO8WJ9cQu3+ZEHe9qEm
 27pnIljleccWQZdmj/8HMZJBAFpqff7w6K1pTx+ptlMeFXpuMd0t9nyQh4Z9LVi60yGmlvtdV25
 AUiKanZXu8s7NP0EfNIl3ggcbEvnGrMjkEb9fzFMACJ2UrH3/rK7S5N+0lNKVajDojTWRqtI73L
 Y43FWNfL2ypA4Y671ocg9/G72w/si48hGOn08/qeQkgPoS9bRa1a5O9fuiuHKJEmRQXlfpXS0wk
 l+AccMoizO4XrhQRyXqq47xBgoTzvTxSVYh62c7V8I9fXAPketzebeZDYb9/sYyck1x9VbmS20W
 1gqAhexrCrKyERFt0jTsLvTapmQLif7M+fWUbs3u0cTpOilq2PwCv5ppx2QDob6wj2jljg4npsG
 LUbnD/FezPp8Pg1sSDfWdSh3OYWcbDJKb2vPxilwfJ1MQQVtnAERuFOIOjxgBdeR/O3BZshOdVc
 B9DzepjbUYxZtsaXEupLrwwBij7Pz+ELlEiUh5QqrVaGDzKfP4uBeoqFHfjE1RAxfynCKlY9tQW
 obs9hws=
X-Received: by 2002:a05:600c:1388:b0:485:3a03:cee1 with SMTP id
 5b1f17b1804b1-48556711f7fmr285497605e9.33.1773757466813; 
 Tue, 17 Mar 2026 07:24:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:26 +0100
Subject: [PATCH 08/11] drivers: ufs: ufs-mediatek: fix phy handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-8-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
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

