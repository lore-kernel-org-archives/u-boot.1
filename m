Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07707F513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 00:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47663838BB;
	Fri,  6 Mar 2026 01:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0zkqKgpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47BCB839A8; Fri,  6 Mar 2026 01:45:32 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1989836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 01:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40fb2789476so3079749fac.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 16:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772757928; x=1773362728;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N77mqBcQLUPLGumdpa7AvGHO2N3gfO0lHVD4v6veO8w=;
 b=0zkqKgpI//AFr6hQqIr5W7sjz3JbSVmCtoiXSRPeJdpP+g9fYRnjahsRKYoAH1grKu
 3m5ooMgCsnTgSKH/Lnd0d40/A2/ldmd6UNqMVtRqb8Wv+dJdqAMwxFQG8oUYoFbA+sly
 ynjgicHCpamT+JE/qAN9Np/VnjkhucEJ5d0AglztsojqxKkcfbgzk13K0iOWvaHLIuj6
 SKaV1J6j2yCUn/niglacMaZ6LtdEmytgwqkT5IxlhL59m8LvF5o92hBw5bcephz5rp6W
 NWz3qBntg6+anfe7Fy3XDYJY/QxDyZ1rQ1Zc0SFQZdLMX9eRIbhGg4dAG95jurZLa2UM
 LUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772757928; x=1773362728;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N77mqBcQLUPLGumdpa7AvGHO2N3gfO0lHVD4v6veO8w=;
 b=HqLJXg6EdsHEWn8UQLm7EXf8AVKxymMu+QV25YJUgWYTfD1hbhCQgFioFwn3otOqfO
 d9pVlx+ZKtiQhifv3Z+UDFohEj9LUFqjSI/L8G4y6j4olIur+BcyGHp2JthdHs5E9RUs
 k6hEcHaKTjOFkZkLfhtVJN+djcAKWzAR5H1eiijPL3WJwIdkOlM5gGsUlZ0a4h+EDFED
 JnLIKjdjGHQRUGpHIs/uaeAP9jhmWjQDX6WaX1I2QXZcHNnAsJc7FTlqaxLW5CwPRpGa
 zKhd/lWuxFt05wRw1vBssn7q+hrjxZ52RIvcUdjYN2QHrQAjUAYY5kv6FcgYDxURZHiT
 SkTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqaPUaxVsCl1GqejxOUKvoSyz5fncFtdGcHHzIRF+dU1POwqOJdhCzmjejQ65uQsTTd4RQAkE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0QynG7639Qq+YzlbQJcRzTQiXe5dNdtZtQpcZhAlVmkp5Efb+
 gYV8wT71DLCdtqH97Kf3M311SE213dV2c5L2mMlrxgCr1te58PdGsKZ+IYpr7xn+24k=
X-Gm-Gg: ATEYQzyLArbA40wNBasnWYgruf0B8JbA3Yfg/2GEeutcm9npbJefsUknpR+NpPSfOq1
 8llwkY0x+dsTl7ovRTZ2jSsq7Kos52caxMoUDwsfNHHc8MHMRlNi8goXJEnOlN1lAxDGe0XZNIW
 ZFJD6RRgQvwt3xUH5G2I7ZEqDUTnZKwWL4EoEtwW69If0uRyw5Yc2r0uU0kEUDmekpQgfPQN6u4
 qskIQ2TwFzRchlYtdNZ29E4DKcrUVoFb0q8FWiaE8M3RbO/ZKHJdalrgYfVbn38OmeGXQtMTbBC
 51RhFrrwddA0QFTza1+dLuWWkcZ8ngRkXvStkWBokdnd/BmSFvm90M54a4IMuiKV2VBAtIJrsJ8
 KiD75/wEmYDU40cDITR0QAO9FU2A8oNR3NMIrvmnNzamDaD+O7+R2Dr8lJTyW17yq9I1lNna0vX
 f3eE+KizOV1JkoXk9zgHeTL57d0U/O
X-Received: by 2002:a05:6820:1985:b0:65e:f108:9971 with SMTP id
 006d021491bc7-67b9c3f1af6mr170507eaf.17.1772757928222; 
 Thu, 05 Mar 2026 16:45:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:874e:e775:4f67:b3a5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9cc280d2sm17971eaf.7.2026.03.05.16.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 16:45:27 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Mar 2026 18:45:11 -0600
Subject: [PATCH v2] clk: mediatek: mt8188: fix CLK_TOP_CLK{13,26}M rates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-clk-mtk-fix-mt8188-rates-v2-1-0ce2b5212775@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBCFr0Jm7RimRSiuvIdh0ZZBGn5qWkIkh
 LtbOYGrl+/l/ewQOTiOcM92CLy66PycQFwysL2eX4yuTQwiF2Uu8wLtOOC0DNi5T1JFSmHQC0e
 sbSWlVgW1txJS/R04Zc7pZ5O4d3HxYTufVvq5f4yuhIS2os6IkqrayIfR2+hM4Kv1EzTHcXwBA
 uNmxcMAAAA=
X-Change-ID: 20260304-clk-mtk-fix-mt8188-rates-9c733a841d56
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GCuShzdhZEZIPYxOLjmifR+FCvEM8NCm5kui2eGhxl8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpqiOg/wQPLejZRLuORYnmCY6/f9bBv5bJpSX5F
 W7ruBGAkEWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaojoBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4rQH+wcKxrt7R0l/BjO7Tf/lzlze1IVupvbuS9+vkXJ
 qMDxFoPEINzJTfFSvwR+rLyRveippQtzRxAqay1eEZlAT1G7ovYp2ei2PvJ9gpmra4sYcA1iAzc
 G1015EiwoXv4hAhHO3KIXs21h58ytG/aeCEn+QvIWLeD+crePpw0g0A/+Fe9DGsjcTVS8lLlLzV
 Jp7lgUfs5W+kQvw/2+kX9nhhkdME+VFY1e56dq+noGdcY3dZ5XtNg9F3htTx7ncsa+B82Wh8Lht
 9gcykcw8K9upUg+GL7of6q6riMrwWtubu0BhLsi6tqgiYyZG5dgzAcUY2LRjyQzx2f2wkU7RCmH
 E57I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Change CLK_TOP_CLK13M rate from 130_000_000 to 13_000_000 and
CLK_TOP_CLK26M rate from 260_000_000 to 26_000_000. As the names
suggest, these clocks are 13/26 MHz, not 130/260 MHz.

Fixes: 5e9bbbdab003 ("clk: mediatek: mt8188: add missing fixed clock")
Fixes: 11f3cc46322a ("clk: mediatek: add MT8188 clock driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
In v1 I said that this should go into master, but I found that there
were other fixes that went into next already instead of master. Applying
the v1 patch would cause a merge conflict because of this. So I've
changed the patch to apply to next to avoid merge conflict. This driver
and the board that depends on it isn't really usable in master anyway
so I think this should be OK to not fix it in master.

And I found that next had the same bug on CLK13M, so I've updated the
patch to fix both.
---
Changes in v2:
- Added fix for CLK_TOP_CLK13M as well.
- Link to v1: https://lore.kernel.org/r/20260304-clk-mtk-fix-mt8188-rates-v1-1-c71fb26179b3@baylibre.com
---
 drivers/clk/mediatek/clk-mt8188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index b720eec8ba7..803330717c6 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -97,8 +97,8 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
 	FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
 	FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
-	FIXED_CLK0(CLK_TOP_CLK13M, 130000000),
-	FIXED_CLK0(CLK_TOP_CLK26M, 260000000),
+	FIXED_CLK0(CLK_TOP_CLK13M, 13000000),
+	FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
 	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 

---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260304-clk-mtk-fix-mt8188-rates-9c733a841d56

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

