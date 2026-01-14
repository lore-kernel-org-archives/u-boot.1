Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A153D3CC84
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 23:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41EF7835B3;
	Thu, 15 Jan 2026 00:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M4hzOOH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E74E803F5; Wed, 14 Jan 2026 23:59:10 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21D4803F5
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 23:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cfcbe7d176so227890a34.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 14:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768431547; x=1769036347;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EmYsoPoiI6UJq1l1bzI73l6ru94awrUkaZeBlZj4sjM=;
 b=M4hzOOH1ZplMYGWUOuT2VQOBMNN4B9ghgTzJoMZiCdNvTFkPZYg8P6yx35utDuCl45
 UVh3n3BupcGEh2MoFI56s6iU1+7UcTh0FB8REo5EBBaIrb7KI7wG8nQZoq+KDfGuXbxo
 4wfnhsqmcKqUigJuMLx5BKTyyyPLPEnJH8tVVVgTcfAglDoV0JHL/tOe/+1DkeQParCr
 XDDRTOxAW8zxNRP/vfXU2G9tskuiypXLSk6/qcPA0i0isyXcdDfwKyaPuwSLVTtLFj6I
 Wgeliem9E+2ahc5WamygCQ9uFhqu+FMy4gxZPIaDlPKg34RFd012+L10lGGSQTMBhhZr
 J23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431547; x=1769036347;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmYsoPoiI6UJq1l1bzI73l6ru94awrUkaZeBlZj4sjM=;
 b=s+bF/LqWYZGGdVja0ZBagaoEV4DhnI4SxecOapKujLaYUbYQgCQGaHFV7+raD9M71j
 V2HPs08/zGYfnpmHXOUQ8epEvzmrKnWtlCXvNyuPt30wQrPtcyj2uwEknS4PVOT2VhHe
 pXtY2IkSnzABQZ29FtEtIaq/ukVWIO1dh5aOH1LTuyv0h2+4FrxPFLSCQnl3pnnLE1XZ
 7UIb5rk/sTORr9vQk46UoRYVPyA4GMH0yTmXuML+FC48UNuIXqGQ06woeWwXQronhLFK
 XiOmSRrMCx9qfnrOylvHRGBOCFEXxyPgirxkeNX8EoN9sUB7W+Sj3TWN98lrrqk1nqUX
 pNzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNiPwtN3e7BtCeygwsoDcgbWbrXo3SqDMIeK/fmcMxS5huDyD2n4Lr2uKltesfw1IVQa1G/WE=@lists.denx.de
X-Gm-Message-State: AOJu0YyDzw5OtDc/08sj4MwqeR1QqQ9uzYbWK0FsSzVaaBcHxfmagH9q
 TkYR25179MliXBW5abl/zU1nXQPakYAJSBQas+PHIlQZTa6Y1G76MqHXk8R1E63MTf4=
X-Gm-Gg: AY/fxX5TqmUHeUPu42BDRzV7OQqJGuleqlyIVnMKessNN/DbyALfQY5vCdrAdOyw+NU
 RYcbyaJS79BMzOWD+NgqutjHYMnqtBUMT+Y8H5xbNmyWT11J34ulwNR6OS2ay8Ac9puoPKR2Mdx
 aCM2qPtZgjgg42tlDbvnYWYXw8DEqOTh8uoyXEUt2YQc8Yxups8bmYZ2AQdIZRaV2g3aq0WbTUk
 knyCcqfBWBxSyvz1rgyiaXn2PfNhHeyVLKvlrQ90JqHHzzsdNLHNEBI1FbeYwkpHdshYdU5P76z
 Lu/MaOML6VszqsHKfjVpPMgbUxTB9QhgNCuTD72+LggybwJReBO/GQXR66BeKhbYh0d20MQzsVg
 uc8X+PHDXe7SwVjyzbTFCQSdSdXAgDRvGTK4coVVg7AdxxDYr9DQs7Q3mxgZIE/OZPjTchbvAWH
 u6/MWGfnFPnD6eXtIW7ibT/Q5LVA==
X-Received: by 2002:a05:6830:4ac5:b0:7c7:6626:b586 with SMTP id
 46e09a7af769-7cfc8b4fefcmr3178876a34.25.1768431546732; 
 Wed, 14 Jan 2026 14:59:06 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:3ff3:5a3e:f89a:1938])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm18518497a34.16.2026.01.14.14.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:59:06 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 14 Jan 2026 16:58:57 -0600
Subject: [PATCH] clk: mtk: use IS_ERR_VALUE() to check rate return values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-clk-mtk-use-is-err-value-v1-1-ab35f0f35118@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G7CiRfyKeCht1OBKYkUQ/27xO
 AwzDygJk0KbPSB0sfK+JTB5Bn5y20jIITGURWkLYyr0y4zrOWPUpBRJBC+3REIXGmNt43wdAqT
 8EBr4/tdd/74f15mBM2oAAAA=
X-Change-ID: 20260114-clk-mtk-use-is-err-value-ad81668ac5dd
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=h4MCfYVkLQYIVdBYMs8dpssThXNf0R4GUGbzTcpfAV8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpaB+yuh5xD6/eBepAENN5JOEOy9zp2JYQqIawE
 Ch6ym/eW/SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWgfshYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsS8H/2HS9bbgL3wXvmn61o3K6kktY8M7LZmhtPu3wlD
 lOa9Adq+k5nruKDOfEZjQEvhjGCP+UtxQ0LlRkdMfUuiI0DFDI8qRAUOhgz0/6rIgg8+m0zqY5V
 1GJ09OXfUBm4KxBXC2yBz5msdNKQnNLqh2OvYVl8ChH1L40nXB2OLNfp53dwAr7ntg3+aIL42n2
 nI6r9oFhpRcsQp3MLpP46p48TGOAXhuGDrRk7QlVCysmZF3Zk4FVM8yPpXUdgGxOnQVE55R3tdM
 EjqE4DsDnUEoOIdGnU93GO66ixJDk/l/BSotKMV+WnapgbthXCwmrO7+6HKNrNyEJ8X7zJdYvZG
 Hdis=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 15 Jan 2026 00:23:23 +0100
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

Replace casting with long to IS_ERR_VALUE() macro to check for error
return values from rate calculation functions. This is the recommended
way to check the return value from clock rate functions.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 82306ae285c..a275b359227 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -12,6 +12,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 
 #include "clk-mtk.h"
 
@@ -218,10 +219,10 @@ static void mtk_clk_print_rate(struct udevice *dev, int mapped_id)
 		.dev = dev,
 		.id = mapped_id,
 	};
-	long rate = clk_get_rate(&clk);
+	ulong rate = clk_get_rate(&clk);
 
-	if (rate < 0)
-		printf(", error! clk_get_rate() failed: %ld", rate);
+	if (IS_ERR_VALUE(rate))
+		printf(", error! clk_get_rate() failed: %d", (int)rate);
 	else
 		printf(", Rate: %lu Hz", rate);
 }
@@ -632,7 +633,7 @@ static ulong mtk_topckgen_get_factor_rate(struct clk *clk, u32 off)
 		rate = priv->tree->xtal_rate;
 	}
 
-	if (((long)rate) < 0)
+	if (IS_ERR_VALUE(rate))
 		return rate;
 
 	return mtk_factor_recalc_rate(fdiv, rate);
@@ -951,7 +952,7 @@ static ulong mtk_infrasys_get_factor_rate(struct clk *clk, u32 off)
 		rate = mtk_clk_find_parent_rate(clk, fdiv->parent, NULL);
 	}
 
-	if (((long)rate) < 0)
+	if (IS_ERR_VALUE(rate))
 		return rate;
 
 	return mtk_factor_recalc_rate(fdiv, rate);

---
base-commit: d503633a36767d756c7de28305cf0de79440cbc0
change-id: 20260114-clk-mtk-use-is-err-value-ad81668ac5dd

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

