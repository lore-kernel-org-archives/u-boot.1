Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F585FCA191
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 21:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CDC83F9A;
	Mon,  9 Mar 2026 22:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gu6u1iXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2376A83F53; Mon,  9 Mar 2026 22:29:21 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AE883F53
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 22:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4645dde00a7so11752710b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 14:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773091757; x=1773696557;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hmnYnGT+Q2LwEALcs2aVEIPcFxAR1kys0CWC99FMsbs=;
 b=gu6u1iXCSmd9KnOp8dBywH0FVxTKY5LIjWOHpa7KFoozq18UGIqR4vNi5ulpf9tGUz
 1vPibSo3+0Wr1Y5YegwyFUeOv7cmbn2Dj64Vmx0KLHVPPPLH34eGRo9HInUhGoKqPd9l
 cM/aYlfC5QZxfassmNNLmYjmQi9pkw35c4rrpt4DDktxKq9x+Emw93eo2V6DIKBPRsex
 cc0AMozXvDDQBwGPPvGonSEo52F44RnmwVjpZAZNP7alEqKqTA+wDc5mXYk4f0Qojki8
 cTicefC8O/7sJ0kTt0VfcWAVVPC5Fzofbv/6s6CJMqNzGG+mQu6Wb6KJ2KdE5t6rNDDW
 vG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091757; x=1773696557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hmnYnGT+Q2LwEALcs2aVEIPcFxAR1kys0CWC99FMsbs=;
 b=OoNXuNq09rx5T4uwVF4Qk04H3ugWYC3D3ZgP7NVKrl683U8Hud/sVec56DKSO7g8vR
 xDe79XhGqAl8K0e0z6U+oATLzLRx0frz6bTsfAdN18ZEnJY9hThYdUhqFZMa3mHPIgTw
 tHPP4+lltZWmnA0sV2SCdAY2bXeXsteKFVnvGwZR1SbDHT0xqJTQP4ELi4NqQo8EP7Bq
 cZBUJ3hs14YkCBzhPLnfqUOQQgduuxjF5UTwlW6GPKN4+zrgUwx+SpPWDzhq6l6GThOn
 zB0v/SWJn/+/sguvUAQQFIh5TBMyElN//CCuqXRqYqV+OkSqj3emJI7TSHi/p4BwTsls
 rHcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ZqEEhVufErDgdnbShT6rIoIcH9+xNHX8AHf6A/VD47eR3iaYOPCYiTsq1JuIAXXD+CmHFNA=@lists.denx.de
X-Gm-Message-State: AOJu0YwTBvo+MDWppSeZrOKfba5+qm7frP26WZN+TKdRb4tjWbkgb68c
 tnAwOJl3mc8Sc0uedhIJvJ7D1iVy4v5mW4Cw2OzHj3mfp0msNcuviSNMTqB8IuFOEz0=
X-Gm-Gg: ATEYQzxy2pM2k5voRdxsqF6IhHdDE0A610DuJqcDTpozzSGdXZquDvdVCYRRN8wLNUF
 6/keXzXWHAeB2MLEsKuwRRXqtuFUrLcGfwJK0edt0/2D+2SyjD8iCjKAi3b4GjtZiEMuTq+tb8X
 LpfqYyV0OKVO4WrWMwy3gGz/9Yd7hcedFICSzC4/FYTF3+wX6ytyQikmhU6YtbCOVucZgkOu5Ab
 gAOhMg6UMX63POnnInK/MbpsmqGRr7+/bGpnXAnkw4WfneqFRoWJ42MB4eiQp0sGinu1vylrT9P
 Qk2VXcMuqFT5kD6GAJtFIUPemT5xNgMxWR4Zbo6HLXmq/Yvcw+2fgr+N5hJkhGC9OmYDwkanv+K
 wgbu4KYXotCXWB/IDQED/qvJchOeH/TaUJPGnePX/IS5VsVyCt/z7/PnNa3XFlL9Y770up0pA7d
 5Anc4MuHmC7OG0GW1VyLF7Jn3JkQ==
X-Received: by 2002:a05:6808:3448:b0:464:5f3:2f60 with SMTP id
 5614622812f47-4671bfd0509mr669462b6e.27.1773091757149; 
 Mon, 09 Mar 2026 14:29:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm826221fac.8.2026.03.09.14.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 14:29:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Mar 2026 16:27:36 -0500
Subject: [PATCH v2 01/13] clk: mediatek: mt7622: convert to struct mtk_parent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-clk-mtk-unify-mux-parents-v2-1-b084ea74b99d@baylibre.com>
References: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
In-Reply-To: <20260309-clk-mtk-unify-mux-parents-v2-0-b084ea74b99d@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ydo+JFJGFR1zAHM7jcF8tCxEnGppSdif5/w5g33X5iA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBprztUpyohTEjwxiI8xVtjZ41u//VFpy4IZra00
 Y/Eg2iMgfCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaa87VBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdVcH/2WJI+JyXL5vRV0Towf3GADbFUenXY6I6/LFqXM
 muxU+7Ws8YqXfWSF+EmZXDU+s3XFCU4BkiQSI1j/Odqp/r7vj7rqd4qn6WaZaXtnTc4mfOkv0r9
 gswosb2KGuWzLaALq2oEbj/PbEdGW9hGO+Q3XG66IRm/yaOtZggRpZiGb7nGqIUvDBOV4IXtpnD
 NE6jNJ8xc03L2X11feA0uInoZPRxaUrJ8Xr4JPAKQfNFFCqr2pkrDV3rFv/gDqblJl/cblmCO6D
 mfxGEYy89rN7QUGhQsPkdP7VSnC7+JJipfB7vNZ6dSdaokq+7akaesTqFUkllz9yDhTwJctZSRU
 efWA=
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

Convert all parent clock arrays to use struct mtk_parent. This will
allow us to simplify core code later by having only one possible data
type for mux parent arrays.

Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index dbacf485b69..0207646ff78 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -423,16 +423,13 @@ static const struct mtk_gate infra_cgs[] = {
 };
 
 /* pericfg */
-static const int peribus_ck_parents[] = {
-	CLK_TOP_SYSPLL1_D8,
-	CLK_TOP_SYSPLL1_D4,
+static const struct mtk_parent peribus_ck_parents[] = {
+	TOP_PARENT(CLK_TOP_SYSPLL1_D8),
+	TOP_PARENT(CLK_TOP_SYSPLL1_D4),
 };
 
-#define PERI_MUX(_id, _parents, _reg, _shift, _width) \
-	MUX_FLAGS(_id, _parents, _reg, _shift, _width, CLK_PARENT_TOPCKGEN)
-
 static const struct mtk_composite peri_muxes[] = {
-	PERI_MUX(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
+	MUX_MIXED(CLK_PERIBUS_SEL, peribus_ck_parents, 0x05c, 0, 1),
 };
 
 static const struct mtk_gate_regs peri0_cg_regs = {

-- 
2.43.0

