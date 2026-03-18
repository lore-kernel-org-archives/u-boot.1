Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E0C10775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F7F083FA4;
	Wed, 18 Mar 2026 17:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t7wBTv6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0118983F86; Wed, 18 Mar 2026 17:51:01 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A146083DA6
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b4d73463dso1456683f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852659; x=1774457459;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CE2g+B//zHBFK+BVOU1KHfh7IYaooVXe13E05VmWilI=;
 b=t7wBTv6Zlu6Bk8UMlo8oZN4A9rAbpGlJVLfzn5ibb7jxK/AQam+mJ+E9BvinL5Xm9M
 lL9lG3W5SQm2Y7vlwHec9TjL9tJv6/5tB/xuw9w44bZPgJEFsJxPlIvFFUtxFcfRvb8h
 9TjOZc05zu29QyXlf69XgQ3yDxA0ngIH9M0M19lvqJNv5aCwQS+LzufoyCN9WXyVAqeN
 akXGZ1H3eISen3HYrthBokodhclZIH5gdDZyuP7kdLbyaudCCIFttiAOVl8JVKcSBWAF
 aCjja2efG/MnZrGkeW+CpuwKV7NaHBMjzhqJSceZp4K26l4aaldLVH9Am9Wwme++miYo
 aG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852659; x=1774457459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CE2g+B//zHBFK+BVOU1KHfh7IYaooVXe13E05VmWilI=;
 b=Wndk6FdLc9vLBYKQV6VpOOx6p3rtyhsNsXdJcNLMy3G+PTfgmto/QK1EFP0faEUpG6
 LEj5nm6uAdE0B9UZfOlijSCn92UIOLnonGoNJOqwObVluS6G8IFnixF5Vf6BJh46UkmE
 EDJdFM726CHItK5NnkRkgo1ovRtbRg/HVvUxKf2qBwBJTTTQho98q9BGe2bop5K6alJJ
 QxbxQsRrPHs19D29tWq+WqDcAnda33QeBDoQ9sOSnpVGqwLgHzf81EdKuJnJNP2khtRH
 DEea0g1PgnaneSX5XenscxxyspJSR0b7SncOI3Ogz1omEWdCnDN8FpyekQowPsBhHBCA
 6LSw==
X-Gm-Message-State: AOJu0Ywub75KGe6vGjnJAkZoK0qpVPg/SX39PwzcApQiRLKJ4WrQ2NLh
 NJCLt3ePTkrmNzxzFhZlnQBjui2b+wG2YZS4CPY6LztY88Vd5pdM2l7Y/ryAUJxVj6I=
X-Gm-Gg: ATEYQzyAOEhnlk73qDGVvsNMH4G6JfQLVZqlnpc/7s+D/K7Fv29/SVSwHrLIt3VXJuK
 IO/8oQEpBgavHGdbt7/k7FwjNFHP4304WXwYucwX40/tYAMFsVxinF+41XPEJI4Kl2bfOHFRgks
 W0Et29U4shvZiGbKQomwCl5mSJHtPQzB+WAP36LNZ1S//2aP1ydRBnMBRHh1eRlEpRtdhkezVKy
 JRoU599Yr4WkYhSOPTI2vdoIzXEJcjJ/TD2M7tj4zqSkXC/EQHuk7eAzx1mFMnNuGp4LElDoTwE
 E6BgFJ5tLKhoi1FJ+uLnoKYE0P0hTEzapZDl1mC0ArJTO4f0pw+0/aOiJyCEyKDCFQu4WA0tVKp
 rsIxHlAlTDDzv4p8pXTShEvfiDCE1rjwDC4SidJg/z/BKdMApNO6ZXTI0Ds2mDWxTZ1qeLu6A3C
 U/oyfCOeMWaLpuGCo9x3Uu85i2RIxQSGfyUMoVMsqURL1CeCKU90xdsxq8gqQBEiq19OVrO0t59
 mIpOIktsCtNnACIpI3GmVnmFg1c4ND4RQXZfYihWdAs2dAdMc/1CM16YlRXsemZxigyItaer2/C
 MyVxKWk=
X-Received: by 2002:a05:6000:310f:b0:43b:4273:a6ce with SMTP id
 ffacd0b85a97d-43b527a490cmr7344662f8f.3.1773852658972; 
 Wed, 18 Mar 2026 09:50:58 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:58 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:59 +0100
Subject: [PATCH v2 7/9] drivers: ufs: ufs-mediatek: implement clocking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-7-f18eeeeb0e72@baylibre.com>
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

Implement clocking.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 5d882904c84..c65be5c2df1 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -317,19 +317,35 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	ufs_mtk_init_reset(hba);
 
-	// TODO: Clocking
+	err = clk_get_bulk(hba->dev, &priv->clks);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
+		return err;
+	}
+
+	err = clk_enable_bulk(&priv->clks);
+	if (err) {
+		dev_err(hba->dev, "failed to enable clocks, err:%d\n", err);
+		goto err_clk_enable;
+	}
 
 	err = generic_phy_power_on(&priv->mphy);
 	if (err) {
 		dev_err(hba->dev, "%s: phy init failed, err = %d\n",
 			__func__, err);
-		return err;
+		goto err_phy_power_on;
 	}
 
 	ufs_mtk_setup_ref_clk(hba, true);
 	ufs_mtk_get_hw_ip_version(hba);
 
 	return 0;
+
+err_phy_power_on:
+	clk_disable_bulk(&priv->clks);
+err_clk_enable:
+	clk_release_bulk(&priv->clks);
+	return err;
 }
 
 static int ufs_mtk_device_reset(struct ufs_hba *hba)

-- 
2.52.0

