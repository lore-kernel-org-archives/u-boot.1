Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642BCEF8FFC
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 17:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56A9838BB;
	Wed,  4 Mar 2026 18:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mdIBhn4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B1F683F61; Wed,  4 Mar 2026 18:04:16 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4DA83642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 18:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c4cacf78so3498295a34.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 09:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772643853; x=1773248653;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vxT4AGCsCJ3rgHtDRDxP7fbHyfVDexnqbegFk+DCMgU=;
 b=mdIBhn4ok7LQevSgwBTWLkBT+Hudb8PV0ur6bUPOIxriGaM6XHG2zOfqJaUbuHEFLj
 KRFVriPlTGGtFLDjESODkDYKnTCyPKPobQsf/fSG0YN1cphPvrJbg6ow0WRznvEsLtt+
 pAglY7dm2FEU9DIdFwRWFL/sGRrtD7n88abTtaWUdRoYl81Z1MIdNQ+0ckJYP8w1Px4v
 TVEE+p4lmlQGaNs7tpY8FU0WxPP0s4ccijJf2AfgGvGEBqiNyeapMe1CpXH+ldOnOAzw
 eIxclvRt5p2jTgSsryiMt3HmxyrKe0h6sy+RrRaXLscUzECKJCNl8aaTBM9N874A4ju5
 kQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643853; x=1773248653;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxT4AGCsCJ3rgHtDRDxP7fbHyfVDexnqbegFk+DCMgU=;
 b=gmK/Yr1gW0wu9prfTQaK8wB0dLBolvEPlllcemUm0CjpGQu8vCze15c1700mepZh8l
 d+7hdUZuq4ZZDDGXZhhM5wIoOOQdeEAfy2s21hmlRN4UYR8b8d5oKQQmn42ldEu+Wg3g
 9Gr/i8aqiEGLeNkoUnZ5VPfkX+DEWmz/8Jnd1JTDVDQInVrC966MtuXCmbSS7EADDUm8
 HbqEH83/JskGC8rcD2YUDduM00D2d1QF5p73S6kxCTFpQ3J6mXf+siN6wWouZC/UwSOx
 jYzxD2DSkp7zNaNBpegyqWmg3W3Zei/QBSOMWE0BDOdrR+DOc6CsA+bVEbLvBNQq6kBp
 PgIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfH/unxlhpBPTQ7l8sk+yXHcYTagdUB4aRsv2a0z2C9z0SQVi1zriUAd2j07Pymj7fvP7h4AU=@lists.denx.de
X-Gm-Message-State: AOJu0YwRJdqpAgDzo2q6DhBs5QLYryVV102l0qurlrmmhHzaRbQjjPky
 4AJLWMobTCeYrdP/nNdIoDHV5wKx86I0JfSrgkUgLniI33+ry+6K5dcHTAcN3TqSiidk33yTY8K
 ccqWL
X-Gm-Gg: ATEYQzzdAyFodk/2t+KgddwB7DEkV369G9mwhIVyYXnBcmbvLTqXewy7ujlEAmT5BgJ
 4cLXdu+AegWpR8s+pwjFaxtkNd4wJ0nrXTbqaY2Vr83+UwbKz45FpEZOko4GVT+9sU1aNzGm0m4
 veVuGPydLEu5cCwA+9XxK418v0+i9O1cDu8T/vVn4eTIIHUHrZxEZwcgfuj2RXatTscRoxLS9US
 86XpoDhJ9D3/b5i5f4FkcVvPf5BfD7sDL/EMkIr13FCA6340PtDcycZGLdlqX/KIPOliUCYvKUz
 o6fJFB2YkR/LKXdjIpmhl2xZ8MDLLFyM2L+KPx54CiSk8gVDpB4bLJge2vXBw36GrAjrFAfrTsP
 lVJjFy3UuMdA/7DWA361pJVB/nVzfWMp7ckMUY8fbNi/ZfQDmNLY/K4/Iy8rSWY7Tou85cC8tud
 82q5Y6a6lV/lYGSp/mi5Lcim+nDKFq
X-Received: by 2002:a05:6830:6004:b0:7c9:5959:8de with SMTP id
 46e09a7af769-7d6c7f5e597mr1753043a34.9.1772643852787; 
 Wed, 04 Mar 2026 09:04:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d719:8353:352f:b2e0])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586653d8csm17355260a34.22.2026.03.04.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:04:12 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 04 Mar 2026 11:04:03 -0600
Subject: [PATCH] clk: mediatek: mt8188: fix CLK_TOP_CLK26M rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-clk-mtk-fix-mt8188-rates-v1-1-c71fb26179b3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZG2itn+pVxEWpUYNfWhFBvLvB1
 TAw7z0QKTBFaJIHAl0ced9EdJqAn9w2EnIvDpnKSmVUjn6ZcT1nHPgWWm0tBndSxNpXxjib674
 oQeZHIGn+67Z73w9WCf0VagAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0KIQRmU8hnCWLpp6g0ByZBacqzHS0xSi9/xqBfZTZrM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpqGYFB41vY1fqCkoAnxCJtWAaZPNcsPDvK7Z1Z
 oMJ2+ChQmGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaahmBRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AglYH/1wBkP6Z1zESaX5vgncTP35bIO9xBqUo/wARzma
 tBZ9c81lYffsyDD1odyopaGlIc0aQC0ATmmFmkbJXbfVKA08WUFt7Hx9E1zw+1A9Y6GP7Hk6WvM
 wlHwppibgpX+65aCoOMTTXyGU0Ac0LHI0aypsk70e2nH6mzD/e1L8y4c6LZ3eIaKy2rv9uJOz8i
 W4JjILUfy/5M++HeSGQKLRekAa6YF6j7Lnje9B8sYkRR/QVUzJL5WwM9RtLISeDcFuYxlsZd4lq
 A033m0jD5rsygUauE4/T5qf26BAthmRPmN3HkjW87NIDNlU5x7Oa4zuQq9qsQgC7wzH1AycDAr6
 97NE=
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

Change CLK_TOP_CLK26M rate from 260_000_000 to 26_000_000. As the name
implies, this clocks is 26 MHz, not 260 MHz.

Fixes: 11f3cc46322a ("clk: mediatek: add MT8188 clock driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This fixes a bug in master, the intention is for this to go through
master. I have some other changes prepared (not sent yet) for the next
branch that will conflict with this. I assume the thing to do there is
wait for the next rc release when master gets merged back into next?
---
 drivers/clk/mediatek/clk-mt8188.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 64aeaa5949f..5a38fb0fd49 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -98,7 +98,7 @@ static const struct mtk_fixed_clk top_fixed_clks[] = {
 	FIXED_CLK0(CLK_TOP_466M_FMEM, 533000000),
 	FIXED_CLK0(CLK_TOP_PEXTP_PIPE, 250000000),
 	FIXED_CLK0(CLK_TOP_DSI_PHY, 500000000),
-	FIXED_CLK0(CLK_TOP_CLK26M, 260000000),
+	FIXED_CLK0(CLK_TOP_CLK26M, 26000000),
 	FIXED_CLK0(CLK_TOP_CLK32K, 32000),
 };
 

---
base-commit: f473a453b0c03d0042b4422de1d822274d2e2d4e
change-id: 20260304-clk-mtk-fix-mt8188-rates-9c733a841d56

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

