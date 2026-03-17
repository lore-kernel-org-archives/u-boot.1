Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0915FFD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1C1684383;
	Tue, 17 Mar 2026 15:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BcYHtbEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE0484379; Tue, 17 Mar 2026 15:24:24 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD4384332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso66703905e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757460; x=1774362260;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5QwyqVLT1zO2aQkUU9a7pf/+/eJErXwCWvZSJ9LrhHw=;
 b=BcYHtbEfGMLxGzZVlTUT4Vj69Expsj3v5S69Z4t7UijVPh6m8yTiMxfnYEtbdX7yPn
 Lnd+jl8kwOI0xNZb9VIXUtl+Z2CWERlYI5k460q6uQpU20/mfOO4BHjHI7ZHxWP3vwu+
 u/pSkFTeOTZlI+6mUHxDXUxQK3gdjjB6tLJvTSYRsQEY4QyNQe2LZLNJeRm5ypnIVU4+
 +7p+rJmdoBwTWWkcZImH+c3t8elwy3tj+xtHxd9iKbJ6lIUDW1fH/0kRXU+m2t7tK7uc
 /eNP9BmTOU2RkKYV+6MKQhtriM9BDUd/8mZh06jW4rdkhURh19ytW+UNIL+Drljv4Y5G
 UD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757460; x=1774362260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5QwyqVLT1zO2aQkUU9a7pf/+/eJErXwCWvZSJ9LrhHw=;
 b=S1W3OEjyFjwMdAVWuXwdLXktmUEZ6OkhEWcLrLT23xqNpC5iJd4EaxqsIdzmD1+875
 YZqgcwp6+E2AAbrMpU1h5l//utDINvWi1VvHIkUSix5FgHs0YqPYTeOw/09Ef9NhF8Y9
 qNKkS8VU0jNB+gZ0U5UX4FGKGf5t6MATERJPUCiBy/oHVFEpia+KZpLKaP7kOYnBpxSF
 ocTIxcCtjn7TTtVETVHlyx5i7UzJStOxM9ekkwOILg/ZgiKpmzdq6Tf6nHtmb210IASV
 OUB2pV4MefI6w3PEXUbwPxBIEog/msVT0MmsjzcjxxFliHbepsX2KOrCU/IKQI5fnIby
 NM8Q==
X-Gm-Message-State: AOJu0YzaGU9TVs7OoPIyi+96yXqp6bW5X59y4r6/07/L1Jgjrq5SABpo
 51x04NlQDVsE1C7SdOTDiN7n9WUfVZ/NFnMzcZRtrWIuIe3AVUeC3eDQzOdNhy8P3M0=
X-Gm-Gg: ATEYQzwg2gnKhqw/mD71XmR42gJwsvVoU4DjeIXu5Jjpill+iXDaUXvrBB1uuNvkOd8
 k43hbMKXW1nXNiFYNdkvcQQ63P4g4ngXMVmyUAW9YnoNaYEK4AG7GFdK8wr8Tcd3z4DKsT40p4O
 fzOu1CXwjybm9sCJjQJMUjdCU8FoSzEgvV6ma49frWjyOMAXpRXO9XV0jCCerSB5La2s+Vzc/lj
 1Mwx8+funobXYN3zQVYv+rsTb22GNK1FEWr4Ek6HahKt40c4bQIuoaG4G8OHzJYQsrOi5fwMUXf
 uyVWpaOZO0a/WNwmBV/QUdUdh0mPYUWLqxC7is+wT2H5tpqcYkzGrMTH2yH5y2sJTSj00m0tRZZ
 5YSOhO4OaFBk7cZjJKEZHR9JCkdrv5DxOn8BflPTRqj4WcyfwXOhcDokNjF6gYqOMrRRaDj+8yM
 H20byKHeX4eCQmeT/TUKWgm8/SczYn9P252rB6kkjnher0Fnf+hWm4jdEyqwTiHGYEaF+BLK0/l
 UFCUgfCyhY8p173dKl8QAfb9FwrPMdpIMXqzBA1sI/f8oyVq64kM3EJqJ+gf5cPK4FkayLGx9a4
 GXaIBFs=
X-Received: by 2002:a05:600c:a09:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-485566ddac0mr303205345e9.14.1773757460537; 
 Tue, 17 Mar 2026 07:24:20 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:22 +0100
Subject: [PATCH 04/11] drivers: phy: phy-mtk-ufs: use tab to indent defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-4-7d731ec438ae@baylibre.com>
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

Use tabs instead of spaces to indent defines

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

