Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE4FD877D
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6052E84368;
	Tue, 17 Mar 2026 15:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MJsKtgfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8019184378; Tue, 17 Mar 2026 15:24:20 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88DFD84332
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so34762015e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757458; x=1774362258;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jDcltm//NAUbVQ4pku5rPZK3W9KO65JsvixgX3LjewY=;
 b=MJsKtgfThlKUBJ4sE3wKjhG1khZKsYwjD4KL/LFiAkZ07Wtye/ggdQnT7NRugiULyY
 Z+3dE1RpYUbKE72IR/rBu9/C9AWvazq764FEsPV+pe4zVCCPl+wp20Uit5Ae06HrjZ0s
 oJc3NfM/l+p+RdTZ7A/GlQtug+JLvWK3PgRfuqOjKKGLtBRIvyyJOrhIh4/YO5euvYx6
 mItsYIgXPnPqJ0nWbqlgGKum9oQIwXRFEHd/pHS5EJUQ5oqhUKQn8DOL+l0ghkGYlvq7
 NU4VDxPEGGqBrs0RC72vlhvJL6fJBEpvQ6nI2AHif6PwaqClzYGJ+PE2rK/Z04bvM7Vq
 eSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757458; x=1774362258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jDcltm//NAUbVQ4pku5rPZK3W9KO65JsvixgX3LjewY=;
 b=JP0VSwQdN49rba9sij1NHXc/QoJUJmLnK7KUpRzGihkHnYzuvGpoiff587ZEQQS+jg
 zxgIj4GNk97ALgluE1ek4YaxugdD2D9Ezd1XVIrPviRiTBNRBqJRnKALARQ6jGEir6pU
 LMklUQiPjLzutNp0DQvUF3g2sSfd5TeoUz+mEox6hIfjKqe4MrEicPfW+qA5kB12X7Na
 8bAofr8POVM8IZCjGuV6DvBfTGLCBJxUkxdg59pm2RF6XYQt6q6CeS8oF6YMS5TUP/21
 88WS7qMKbo+U0btm4ihL2MiPgOawulFALxBnnunLLEbjAp511JbZS/UplLJvTTBvHkXD
 8EZg==
X-Gm-Message-State: AOJu0YzKjkAEqHHeB6W08XNr/ukH64F2bwfUaRbXbpyoXe8qg57I1uIs
 /vAge8PjFKl5N9j+NyZgtQsmkWTaBigV/4K8tieKYTafchTSJe6EBdguFl6R9CE9j0s=
X-Gm-Gg: ATEYQzwFJPLM3S3sk+Tdle/6p7BI8odvHtdg0ioWfpE/msA21YUFy9vJpYrmjOLrbmt
 iWRybTtm1O/VkPmmjye4ERRC2v7shsm9nR5sAUTgL0RCXyp8NRMYTSQF2GuW7vxilGe3rX1TFXP
 4PEYpVp9r2rU7HkU5Ul5eW6igANY00tGjJmJNi0ePApjdeA0OHHrueTJwxGJtxAhrG/+6yo8HD7
 vZYAuPgf4kZh538MJ5fdsDbZadpclBgsWmlaLSCWKZjvXSrOwqgVSP4eOT9k99kfauhNX+oUlQK
 kDvlo1p1dOiBQmip3+y94LMMz/ORx2g4Esg0guOple7nq5burAl0gEYjkS7SDGeBnk+r38CE0WB
 gu2tbsysPG2XjTgaa0+6AXXTENOn8g27uVkIp4lwDcfz6vZ7P+g77id7Bgi8cL2VKUorYTNraNr
 RvePStynKoOVo+xHMiX0KyrWheT/qtoq/SOiaPoMnExCXtq7A81ADod/9+FDJxvFkth4NK1SOLn
 sqOFvnzNbEIijQ3X3t7BAhJ3wmRGcFpRVeOKvxJOEic+OBNJMRqY3PHfkK7LOpRuCQ2tB02HThR
 SV31RUo=
X-Received: by 2002:a05:600c:4592:b0:483:7980:4687 with SMTP id
 5b1f17b1804b1-48556714c04mr303671235e9.17.1773757457915; 
 Tue, 17 Mar 2026 07:24:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:20 +0100
Subject: [PATCH 02/11] power: pmic: mtk-pwrap: use tabs for alignment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-2-7d731ec438ae@baylibre.com>
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

Fix mt8188_regs definition to use tabs instead of spaces for
alignment to be consistent with other definitions.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index 8ff6458a5f2..446b78fb0ee 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -249,20 +249,20 @@ enum pwrap_regs {
 };
 
 static int mt8188_regs[] = {
-	[PWRAP_INIT_DONE2] =            0x0,
-	[PWRAP_STAUPD_CTRL] =           0x4C,
-	[PWRAP_TIMER_EN] =              0x3E4,
-	[PWRAP_INT_EN] =                0x420,
-	[PWRAP_INT_FLG] =               0x428,
-	[PWRAP_INT_CLR] =               0x42C,
-	[PWRAP_INT1_EN] =               0x450,
-	[PWRAP_INT1_FLG] =              0x458,
-	[PWRAP_INT1_CLR] =              0x45C,
-	[PWRAP_WACS2_CMD] =             0x880,
-	[PWRAP_SWINF_2_WDATA_31_0] =    0x884,
-	[PWRAP_SWINF_2_RDATA_31_0] =    0x894,
-	[PWRAP_WACS2_VLDCLR] =          0x8A4,
-	[PWRAP_WACS2_RDATA] =           0x8A8,
+	[PWRAP_INIT_DONE2] =		0x0,
+	[PWRAP_STAUPD_CTRL] =		0x4C,
+	[PWRAP_TIMER_EN] =		0x3E4,
+	[PWRAP_INT_EN] =		0x420,
+	[PWRAP_INT_FLG] =		0x428,
+	[PWRAP_INT_CLR] =		0x42C,
+	[PWRAP_INT1_EN] =		0x450,
+	[PWRAP_INT1_FLG] =		0x458,
+	[PWRAP_INT1_CLR] =		0x45C,
+	[PWRAP_WACS2_CMD] =		0x880,
+	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
+	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
+	[PWRAP_WACS2_VLDCLR] =		0x8A4,
+	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
 static int mt8189_regs[] = {

-- 
2.52.0

