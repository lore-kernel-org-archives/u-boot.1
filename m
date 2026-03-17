Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B6FD877E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9D5843C7;
	Tue, 17 Mar 2026 15:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Afv2ULy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0708437E; Tue, 17 Mar 2026 15:24:32 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F49884353
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso52698895e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757468; x=1774362268;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8cQ1CsVFbesz3r5cEMSPR+0+cP3Vu8Eb+XcjKsLfin4=;
 b=Afv2ULy2ZULGqXq40fuw83CM6MA6Jt4ZDUEvcFWWy4DGA9SylGXRxno6V5mHN/lejU
 H0ZtA9pE52dv+tIPNe0hsJLOIo/1gG1RxVNVA7rqYDQZvi8c46gGBFvOSkPrPmDtJkPd
 m7AgsdN1/FnnVtvtVpxrmrO6OyIvivR7sxNpgmXXWgpSd4gYrtXkVu9MG1tnTT22TdwY
 Xe+DFbCxOy3W5/yns3bpBPbvD37qAf5Ang0Ky2NH0+NsdnybksSJb2KKHCP5eh6A0XIV
 LQa1Q44FoPYe711xdSDPJ97do4Dx1IK+E2HYycHDwOuRUd8kL3l7gXOTGhk1myG+9oU+
 6QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757468; x=1774362268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8cQ1CsVFbesz3r5cEMSPR+0+cP3Vu8Eb+XcjKsLfin4=;
 b=KMqr9KzHPHjRYhO1v19kmsmg1sFYb8uD0Zj1tCLV7bOogQ1DCbe/k9pVZ8fg966Wwd
 9lSBuGK5KjBG+lsYSVZ2zundUDybmRU8EaQmvIfASoIvOvm34jHR3i6RixsXSeDfI3Az
 BlD4CRvpgt5R/+T9h/Fw7hpV1dUF7hlxDPmPDqEsRtFonjlsU+X16ysDu8/qDldp+fUg
 zw313cnVx1V2jklZRtgA2v8uptcx1bm21ZP9cgWmU6PDajmWcJGm4ZrHH67sQc6ECeJO
 /ZlNfwYg39NphM6vY4fAyqD1g3qAcS0stN+qRXQc9VUWU3+Qtl8EXhzj8A70fnaOn3bp
 lZmg==
X-Gm-Message-State: AOJu0YzFPk9cjuWmzhHntOLL3Fp5ckOXFIPshNrIjFFsJjpDBwvjFeGu
 y3RdrVDn5MVKjZSLneXSbUQL+U0yVluzH6SXlZLRUZTm2HLxX0OKSw8RFkzK6aMHcfc=
X-Gm-Gg: ATEYQzyrojlA63bWTBkMjBM0hU084AaQb0llpzmFmh6TMLJjk5MlhozaocTKNVcgXl0
 +LOXFot3jhHcd1TD65cuVc6mihgDvh1eDKAvcfHEb1QLf6mHI7P8OvtY6oTwLkGujpAK5r6orJ6
 FMtVD+o7nJkYP/kLXSy5dRaM94Rhm6G+hkkMomtpmGXbrgVi5qMhwqVLPl8a2SHMUdlHXmE3e8+
 uzvBb7N4a7uwiodYeyvsk5N8Um/xwPXz13I7WCxqnieDorv4jYSahuRIil0vHwXCxKy3l0tv7dj
 GhrDuZkOPKKW/zjkuUJKpXYV31F8xcecjtco36/qgPBvIFiFaSXYBOu6Bk5lpp0bYn8JLHXIqMN
 p4fdBHc4mrSw2+ZPN5/DpXsSQvnt7NyoNxwPZUXTlDse/9wjpZCVz3LsJ12ySY1pIWnSHS/9DTW
 1YCnBvSfvhVy+b7yj6LCNWSmrS30z0RzfeDBuAYAY/B54U+uKfRiIR9UcqEkbLXWhoqYmknGCT7
 AUp938ZxWzbXg3SFM5EopwGXSY/HyDm9Qm6l3RcIfdLZOWryTtGizmxsZJ2EHpcQ6MooswCgwiZ
 W2lhA/4=
X-Received: by 2002:a05:600c:354b:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-48556705121mr280553095e9.27.1773757468184; 
 Tue, 17 Mar 2026 07:24:28 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:27 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:27 +0100
Subject: [PATCH 09/11] drivers: ufs: ufs-mediatek: implement clocking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-9-7d731ec438ae@baylibre.com>
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

Implement clocking.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 5d882904c84..31916f72c86 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -177,6 +177,18 @@ static int ufs_mtk_link_startup_notify(struct ufs_hba *hba,
 	return ret;
 }
 
+static int ufs_mtk_get_clk(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
+	int err;
+
+	err = clk_get_bulk(hba->dev, &host->clks);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int ufs_mtk_bind_mphy(struct ufs_hba *hba)
 {
 	struct ufs_mtk_host *host = dev_get_priv(hba->dev);
@@ -317,7 +329,11 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	ufs_mtk_init_reset(hba);
 
-	// TODO: Clocking
+	err = ufs_mtk_get_clk(hba);
+	if (err) {
+		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
+		return err;
+	}
 
 	err = generic_phy_power_on(&priv->mphy);
 	if (err) {

-- 
2.52.0

