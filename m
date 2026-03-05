Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80DCEEF31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CCC83FAF;
	Thu,  5 Mar 2026 09:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JEy/Jp+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5744F83FCD; Thu,  5 Mar 2026 09:49:26 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF31483FB5
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439c56e822eso2010015f8f.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 00:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700563; x=1773305363;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xyzTyws15Tj1S0rtCpVwAgtYnRC3j+kYvUFI1Smdm/8=;
 b=JEy/Jp+pemZ+0gCUxB4Ry4SCSCGNbFK1pQ7r7QeRfiaE2JKeTjGusGssgBHn6x8ljP
 2muBDWf8iqBYx9ndPZuA6K8BjFUtZGutgbTTdc4k5kPNKEPpdgIjT0Xi90fcCY5DI4L6
 BBL45du6/IiRfEM0M1gs9jKppzNVVKyZPDSMflQQH7CUUh2g4AuMVixfboDcvabapUZs
 f2NziMDOQBpV4VmdYqy4ZogAqyyP85uHNFqTFPGNW9pIHUX/zGad9sdshx4B32mImD2A
 lB1voWMmROsNhJ+eqzaLO/UEEfk76YW+W1PNTITm/BYxSt3LYiC+AY9ed3apVg51Tx30
 NPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700563; x=1773305363;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xyzTyws15Tj1S0rtCpVwAgtYnRC3j+kYvUFI1Smdm/8=;
 b=ovdempK7Rupk4aNZ6Juk0bJ8S+sEmDgSgCWqJQKtarYNFWkSrGfXzzzPdbF2+6nIcb
 GRZEPAs1x8nZU6HJzKeAuKWOcNYtu2zdxDCKx8yArmw8NBAESVEhYt2RYC+eWdJMxGKK
 QRtDg077uZEzW8mUrjJzs6C1vgqj/qhBVYFS/kfyhT0sojNuPCFBVzLTJi9nDT0J1jkl
 tM5Ysl0AgCBFvtWisgCiArDYUVAF+V0zv+YvZSXDhPBAzcDPmnkBeQPy9cszBX4aEwkC
 aws3P//54wDSzVMjgsAlow7Am1SQtj5AURIzTp2qEpXpxQpgoAwnw9eWgfQFw3aH2IV9
 oLbQ==
X-Gm-Message-State: AOJu0YwLP/7rPLOAW4igiRGtV5rwt6B17nCsEqNXBlNmqhqQPUJS9jV8
 C3RNSMqYGTSn1aVdRghMOFl3Vuqy7t7fnYI7OtnzAviIjGYoxpyHz8RZOgdZl/pkIJA=
X-Gm-Gg: ATEYQzzMw51tA68ysadRfvNG+4/kLspI9GlYFiHc/hz27TFtMM07sWHdXI6bMKTKM2b
 MTIkY6GYjJ3xiTWsIdOYEboxxOSkcIouEJ7rSOBQQJRGPBGpK3tdeAj3gojpiZ5ZDGEAq4XRMpr
 qxWqnG7I0qo7Z0OzBW8V3MknndFwugmPk2+wVKTHFtjao2D8el6pAEviVv7hAvFOtWZQ2iNGOko
 qVnB1q3nspWsgA2+7kME6xgj5QFruBWSrdbGevIkaJk8PDLuS4ZcRnKp8taZWAA7nCe212lb0Ik
 g4EJWuL9DefNx7/PUzBTJkARaUtv4EowoksmeNMgc5hR//XMILwAUp4Y2aC62krS4/R2G62VABe
 oaxunkAX37pbIKBPFyz0nXHPhudk12OQNP3JP6libfxh63AGD32wF/t+Lb01LO+AEpKyHMNEYSa
 vNnJSlyf12hiyfzlfrMVJeklPDLyvpjnQw/isU+ryrNI+kY5VyoMi1QlpNdrNYO0ujn0m2lwFuv
 PiycBTxalRCnuNevNKtVA==
X-Received: by 2002:a05:6000:601:b0:439:c2b6:d5d8 with SMTP id
 ffacd0b85a97d-439c8006b97mr8771728f8f.36.1772700563300; 
 Thu, 05 Mar 2026 00:49:23 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net.
 [2a02:8428:e55b:1101:1e41:304e:170b:482f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm33638231f8f.18.2026.03.05.00.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:49:23 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 05 Mar 2026 09:49:03 +0100
Subject: [PATCH v3 2/3] drivers: ufs: add helper for phy_initialization
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ufs-ufs_hba_ops-cleanup-v3-2-e153ffab98f5@baylibre.com>
References: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
In-Reply-To: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
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

Introduce ufshcd_ops_phy_initialization() as a helper for invoking the
phy_initialization callback from ufs_hba_ops.

This mirrors the existing helper pattern used for other ufs_hba_ops
callbacks and keeps the call sites consistent and easier to maintain.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs-rockchip.c | 9 +++------
 drivers/ufs/ufs.h          | 8 ++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387d..8ce3c269cf7 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -30,12 +30,9 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 	ufshcd_dme_reset(hba);
 	ufshcd_dme_enable(hba);
 
-	if (hba->ops->phy_initialization) {
-		err = hba->ops->phy_initialization(hba);
-		if (err)
-			dev_err(hba->dev,
-				"Phy init failed (%d)\n", err);
-	}
+	err = ufshcd_ops_phy_initialization(hba);
+	if (err)
+		dev_err(hba->dev, "Phy init failed (%d)\n", err);
 
 	return err;
 }
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index bc839a43704..74125b1ab31 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -756,6 +756,14 @@ static inline int ufshcd_ops_link_startup_notify(struct ufs_hba *hba,
 	return 0;
 }
 
+static inline int ufshcd_ops_phy_initialization(struct ufs_hba *hba)
+{
+	if (hba->ops && hba->ops->phy_initialization)
+		return hba->ops->phy_initialization(hba);
+
+	return 0;
+}
+
 static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
 {
 	if (hba->ops && hba->ops->device_reset)

-- 
2.52.0

