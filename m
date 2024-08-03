Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC0DC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED3288C93;
	Sat,  3 Aug 2024 13:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JOomGtGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3937D88BCD; Sat,  3 Aug 2024 13:10:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C04F8827D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-36ba3b06186so1894933f8f.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683440; x=1723288240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gIxVSAM6b6TU9e9OFbI5pJYVSkd25vZuyDRfjIs85IE=;
 b=JOomGtGpO0IpGKKt1N7s0EjcfdVWaU2KSfxrgVCtrjWMaMxDCG26Hbts6vV82s64eB
 sk+lR2cVzw+HBZVybUYCZfqEwoL/WlrZLBPQb7h5XzPPI5mvHvHf6lurjPmflIUDa9Qr
 1X0fUoJyV7KxeMuSFpOAAyyu1LZuum0/icAoMWDcAE3+A7ZJyq61marnl3b+u6/8luzk
 Sqkv2v7cNok4wTvddXa4qyKaWthzXrYEBwY4EvxBHJEC0nSEQqpoPnWiBMlobnsp8CwY
 Fg6zcAqrgWc5AhedoO3k+W0wt7NSVvGtcLrFqh+0zMQU6rGBNtu6VQH/YXUQ2rBXldTB
 RgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683440; x=1723288240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIxVSAM6b6TU9e9OFbI5pJYVSkd25vZuyDRfjIs85IE=;
 b=teggaOGgrs7/7g7JpFzNSV/2EafwC4MNXck24/SCvaLrc+11rqvkQ+G6KkwWH3e4DI
 5HcAGO8rKq+Cg2tSKe/S1Ix3cd45akL3JCYHhGZt0fmzgAvMmR/xL9gVHsh9mr4NlQIB
 Lx90BzmXoeEIvOdgPzCK7XZi3tGdRv9Eyl6tDV3NyJAMWGGiiODcOv/54BE83/BXex0w
 IrXm/vbBWccJY5kSoI88uoy/PfEgch8Yie0DKO0ErDkv4KaGZop+dSkwcvFu+fW5Hx1p
 iJLAlbz62alqUTYOSDjKOcM+tDceYMyao7kSiWxleMKplQxK2YGkn12Pihg1LGLma+6i
 EgGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfGWWPlQCxBpVl2/bCtclfl6EMMJ6az6XNzCUeJYGrhM0rVKUWoPN4p+Jd4BfCgx17JeLDPLlfx7BrIXF6i/9c09bgzQ==
X-Gm-Message-State: AOJu0Yzpn//2CKT6v0RO4gkTOpOjVTRUzdIlBHMQ6zTQ5V1yDurKdIeX
 d9r1JrurINTUk7Z/QMCUi6/L40j2Chw4OI3zGzyk+nqYWd/pg2fB
X-Google-Smtp-Source: AGHT+IEYY8YK83tWrN1+qwYmrvQb1P2qO++ykBQbR1nCOSVtPFaDFxyzfYuu8pWdMsbgPCJ3Tc1b5w==
X-Received: by 2002:a05:6000:1883:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-36bbc1bd4d7mr5087078f8f.48.1722683439768; 
 Sat, 03 Aug 2024 04:10:39 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 04/15] clk: mediatek: mt7986: fix wrong parent for
 INFRA_ADC_26M_CK
Date: Sat,  3 Aug 2024 10:40:37 +0200
Message-ID: <20240803084050.449-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803084050.449-1-ansuelsmth@gmail.com>
References: <20240803084050.449-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix wrong parent for INFRA_ADC_26M_CK as should be INFRA_ADC_FRC_CK
instead of INFRA_CK_F26M. This is to match implementation on upstream
kernel linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index 72300d80884..cb4d20a204d 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -492,7 +492,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 		    CK_INFRA_PERI_133M, 18),
 	GATE_INFRA1(CK_INFRA_MSDC_66M_CK, "infra_msdc_66m", CK_INFRA_66M_PHCK,
 		    19),
-	GATE_INFRA1(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_CK_F26M, 20),
+	GATE_INFRA1(CK_INFRA_ADC_26M_CK, "infra_adc_26m", CK_INFRA_ADC_FRC_CK, 20),
 	GATE_INFRA1(CK_INFRA_ADC_FRC_CK, "infra_adc_frc", CK_INFRA_CK_F26M, 21),
 	GATE_INFRA1(CK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", CK_INFRA_NFI_CK,
 		    23),
-- 
2.45.2

