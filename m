Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E245EA813E
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416AC83DCB;
	Tue, 10 Feb 2026 17:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mMiAGxps";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB82583DB6; Tue, 10 Feb 2026 17:22:53 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C261283D77
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso2479720f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770740571; x=1771345371;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gLMXeRJzk/F1MP3iOK1XQj2/8Y/Iv20RFR4qmixR/78=;
 b=mMiAGxpsNOxK7EEFBdVg+bEPzQbGCbijhieNwOhjij//JKlVeU54E3JlaiiCJB/Ef2
 JP5XcQOJrnay/uU5sz5tVkZpkpRP+1AHfgr7ej2jOnWNVHpMCCmClNXF4ODQQAao+qZ8
 qciALUj95n6F4m2CdvK9pQj6ufd3hgICuepnX1wTvjDQbJKs/bEE38KvGYJzQWjxMTm1
 lccoM9c5th2ZZD5sJhuTp4kcWWRXWsVKu+woofpulyN9fCT9kteLwtvO5QeSF+zMV3pZ
 Z/YfvDotDzHQAO4IuM6jqJiHGB/LqD93SeK5Bk3cXBoFSOBVBNVpEAv1XwTzJinL+Urq
 N1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770740571; x=1771345371;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gLMXeRJzk/F1MP3iOK1XQj2/8Y/Iv20RFR4qmixR/78=;
 b=SPVl0jHil7/6+fzsUUcQLDSkHJDk1hQjwdoKTgczRklwSqCIAVAHXCyB1NYzGQMlUa
 p6FyC+5/3NbVbNjL3Dw2+qFw4pM9w4BKTjneUe7sXrRsa//hQnMJQrLm3CfR8TNHr0ch
 iwK+nF+4vrAAZ17mMs8qQasxu+yE/Snxk8nqAsbdY5cESqqbiJCBGfwMJn/Eo+lkUGzc
 dvMzYB7PNKx36UZuLJvVclFif2QDQGa1DuFNv8iZ/uatESHb3uOWd9RWJdGw7dtpDDcY
 pXz6WwAMvR+BviB1OzEZ3dKixNOy8miDw98tejZ9tlu/aEpdjvISHkX4liPusa0YXIvJ
 ZYWw==
X-Gm-Message-State: AOJu0YwWEfgcmOHgC8AXLpF+qHeoY2WE4sxCTYO7r5RJEHZe+iojs6F8
 Y/LX3nXGItq3yXFwoN4/A6top94/xbbbysZJochXJLq7/Pfs2HfI0iGi1aBMBWqF6RM=
X-Gm-Gg: AZuq6aLqTTM+8ptYNL1E1SOMsMUOKz3AmZNYEeG1E1eQhBxNxvURi2HNf8Qn09xhURD
 nLqgR53e6OAwww4aVxMtNwufHPsTvBHDzwkDel1cdEJLsr9DwLqKCBpdIo8j4vgsQekvDbmHBQA
 zuCF/nSc2wZ77ey0yT96dr5w28xexCPm1iq3jq3D3l0Ze2pIjAZUKQvf5ccL9xe8HsDt9Rbm6ql
 VTsVUJdQXrILcGudTnnM1xb8HcrGdhOkKqEwWwPt8qyxe0DR5+mb7kL6lKUQECG2jtoGm8H4Q94
 IPeQLOnGGhVHUcWKbKHbdwBBICOnkBUZJbXStgaYOBJ6sD3OREVUaXynrqEoOek2V355oFMEwL7
 wiJJenzciPE0VAQRTz8SLTpvkXkisQJKxlHd6+5I/0J9uU3x6NnJKSwrJ3Q86n97aJ5QEYo3yx5
 RdJ9YzzgSLRHii3Y+TE660iEtmdn1C1sfxaPP8qeRNQOqywAqtoR78lkUDCl9sLUm+bECD6inxo
 fVWUXYXfV0K4lURneRltEUV0kLtBK0Q
X-Received: by 2002:a5d:5d0d:0:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4362933bddemr20494341f8f.6.1770740571089; 
 Tue, 10 Feb 2026 08:22:51 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm35185402f8f.17.2026.02.10.08.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:22:50 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:22:44 +0100
Subject: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
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
 drivers/ufs/ufs-rockchip.c | 10 ++++------
 drivers/ufs/ufs.h          |  8 ++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
index 0384244387d..cad753d5990 100644
--- a/drivers/ufs/ufs-rockchip.c
+++ b/drivers/ufs/ufs-rockchip.c
@@ -30,12 +30,10 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
 	ufshcd_dme_reset(hba);
 	ufshcd_dme_enable(hba);
 
-	if (hba->ops->phy_initialization) {
-		err = hba->ops->phy_initialization(hba);
-		if (err)
-			dev_err(hba->dev,
-				"Phy init failed (%d)\n", err);
-	}
+	ret = ufshcd_ops_phy_initialization(hba);
+	if (err)
+		dev_err(hba->dev,
+			"Phy init failed (%d)\n", err);
 
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

