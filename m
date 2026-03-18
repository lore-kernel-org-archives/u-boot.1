Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E1010775E6
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD37683F8A;
	Wed, 18 Mar 2026 17:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rfjXZEn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C808183F6D; Wed, 18 Mar 2026 17:50:56 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2716083A1B
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so28659f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852653; x=1774457453;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dqyJfW4irwvcQgLHhb4f7SDswpFhY98S3wmSHMzyXco=;
 b=rfjXZEn4ZxPcnKu0lh4WDUWhH/2RNQJr5z+XoHQvw03610ZEWkg9SQ7ZWhlxTHCUWN
 Adfzup7/AUAurIEgrSIrIk+N1GtxiinDxaEJ90YsSTu0bm5lAy6KkRFUneTM5MseiEBK
 BGsd9SQaEFUqwccn4I06tw1eBz7em8ph7TkrXb93+w2hmtV7VP9iGqAeZDdHzgVGNX3D
 gTezr2J0zjOlP6mS1wRI0r2P8yH7kj6GnIJ9ioi2XisvA4V956yKnqt7e/y6lZEum+R2
 77f0lHW0+XDQYyxyc8ja2UpG9cOhQei3CCi3xtZG8IRhsvNForQLt+KRBlt+5iSZV4Vf
 siaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852653; x=1774457453;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dqyJfW4irwvcQgLHhb4f7SDswpFhY98S3wmSHMzyXco=;
 b=p3RbayZoteyHyZ+QJdqvwF+9hONact3nlh/24WbBJoaC60mwj2XQm6f11MUS8bn//A
 Ff7WvJfeEVRFP3/Jeq3eTRqMaBFdWbBDCFpZp1w07Jc5FhBkDO2dcthfh/v8FKA/+eq8
 5pOnCFejcPppKr5NWAc0vUxyIqRbY3GBeh754WBQFMDrPYkrxfJH45lci5cjophXrTUb
 0h74aCQPpPMln9tODXJphRKhoaTlc0UWZPSFSnr+sTjU8brXa7cGmvMWN5t2Mc8JQJYn
 mK0rtL14iCgPss8rZnYV0LYazEDxRxvHtFdXpeg5UXY2zFN7lKunIHjTIZ4V0QqPpH7f
 ZCTA==
X-Gm-Message-State: AOJu0Yw+bfPij2tUjwGAfzqQ3QCNSyh7VzqCoU21z5UYt4gzwpf1zXa9
 Hr3FV/wrED3MvJh0OuCNrYGb9D7Xv2H5i1D2h2yN6QLrSQEm+GKgpWipV1IB3nRn0yU=
X-Gm-Gg: ATEYQzzjuEimnZh+bQuwl+1w8l0vdYaB+1l4Lh8YAF5g63Am6faH/MUfnIumwxfRtce
 UdFPUluSBrSqP63wTj1GfntrWXeCxGhAoJmL8xEXQp/MrdL7HmBvoIpZ9/2zxsWz97ci6Gxcz8P
 Kn9HNmXVvGQj9xTaj+9vv99Zl19JegsXNVA5qR2pYouu1oONUKB7sS1xIByzf89c5jb3Dli+sQQ
 zCT2C2AmbMd/yGgnKphZ6+V04Xa+2iJuA3ZHx6H6NBt1U7dOtQt3H7LyBMeEcAOKiI+aNW60PAV
 1oMkYbZ53ysW2NfYQ+1ZnvC5ui2DUm3w/pNujX5idFVqareDmCKkuSe4upDKPM5A4TVt2hdpvrb
 ezGlwh1e9c8WO4LncKPqhRNLX91OEGRTnLqx2+2u5LhT9Oz6kmm8GwQyg1+ULhLz+sZtwD4vY0P
 k1VVSwhN8CIlQzhwH398OAYpiAPiv1gHFZEN638UF+nQ2LxN3dZeGM5ZqmNctoPVcWXLhaWvypG
 ktkToMDU20B+JA9PLYo5EWZOkExvyaXtZWYM9/mv33kVK9oUS88L5/FZlEqDGBIpWgCK/UdxPT3
 UjlpmZM=
X-Received: by 2002:a05:6000:608:b0:439:ddf9:a205 with SMTP id
 ffacd0b85a97d-43b527a0afbmr6498293f8f.10.1773852653504; 
 Wed, 18 Mar 2026 09:50:53 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:54 +0100
Subject: [PATCH v2 2/9] drivers: phy: phy-mtk-ufs: use tab to indent
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-2-f18eeeeb0e72@baylibre.com>
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

Use tabs instead of spaces to indent defines

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 14a90cf2064..321151172d9 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -17,26 +17,24 @@
 #include <mapmem.h>
 
 /* mphy register and offsets */
-#define MP_GLB_DIG_8C               0x008C
-#define FRC_PLL_ISO_EN              BIT(8)
-#define PLL_ISO_EN                  BIT(9)
-#define FRC_FRC_PWR_ON              BIT(10)
-#define PLL_PWR_ON                  BIT(11)
-
-#define MP_LN_DIG_RX_9C             0xA09C
-#define FSM_DIFZ_FRC                BIT(18)
-
-#define MP_LN_DIG_RX_AC             0xA0AC
-#define FRC_RX_SQ_EN                BIT(0)
-#define RX_SQ_EN                    BIT(1)
-
-#define MP_LN_RX_44                 0xB044
-#define FRC_CDR_PWR_ON              BIT(17)
-#define CDR_PWR_ON                  BIT(18)
-#define FRC_CDR_ISO_EN              BIT(19)
-#define CDR_ISO_EN                  BIT(20)
-
-#define UFSPHY_CLKS_CNT    2
+#define MP_GLB_DIG_8C		0x008C
+#define FRC_PLL_ISO_EN		BIT(8)
+#define PLL_ISO_EN		BIT(9)
+#define FRC_FRC_PWR_ON		BIT(10)
+#define PLL_PWR_ON		BIT(11)
+
+#define MP_LN_DIG_RX_9C		0xA09C
+#define FSM_DIFZ_FRC		BIT(18)
+
+#define MP_LN_DIG_RX_AC		0xA0AC
+#define FRC_RX_SQ_EN		BIT(0)
+#define RX_SQ_EN		BIT(1)
+
+#define MP_LN_RX_44		0xB044
+#define FRC_CDR_PWR_ON		BIT(17)
+#define CDR_PWR_ON		BIT(18)
+#define FRC_CDR_ISO_EN		BIT(19)
+#define CDR_ISO_EN		BIT(20)
 
 struct mtk_ufs_phy {
 	struct udevice *dev;

-- 
2.52.0

