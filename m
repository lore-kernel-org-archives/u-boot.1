Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3451EC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8695B88C50;
	Sat,  3 Aug 2024 13:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BgnwMiuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2953C88C3C; Sat,  3 Aug 2024 13:10:39 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A0688755
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso4997065f8f.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683436; x=1723288236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R/u82FzY6HJBxboUGzFHbPHQG9eTtVvbnDAolUt7TM0=;
 b=BgnwMiuFEk1Q5lYI3FUiTayx23b9Kxce4hj8mIS6ya1wLOPFqhKbV0ZVpN9knJarNa
 HxNC7Mg3I+PuHMGXswm9+np15Amz2+pZyxFTwFPf6yvNSZZc8YQnnk/GsET+urngbojR
 UXKhM8F/1gHgFybMWwaABkyneaOjzCPz19EFaF5ZxcEjny+xNWzOjWA1yhFgJBwZmVcB
 +9glZ4b9L+wWjIi7HIax98iA3S4HCtZoTFgNeGN8HGCRRuknIklkrxQUpcslOnIfIc0L
 B5FQZHd2y/79Njy0nbUKPgAHUPKty3MjbwwNXWwDjE/mxxuWiHA67SN/aIsjENAt8HyQ
 ttug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683436; x=1723288236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/u82FzY6HJBxboUGzFHbPHQG9eTtVvbnDAolUt7TM0=;
 b=BjcRHRsHWdCkm/eo2LhOfH4z3KPt+cR7OwnUTzModpOZ7lFcJqgE4VK0jAHru84lw1
 M2j/4JQyv+n80R5kAPOjR+04wAdew4ZCuNNgpW0GdRTgWQuI6Ph2XY8SxM96wvDVO86N
 ICXCIYrMxjnjsk02w0wMqMCTfLESzubVR6tsVj59OptNc45Am56j1KUVsp1Gt0JTjaNH
 l8siulrb18+8LpPXoVJu1UWKKqAzjlQnQwX88kcjOAPNPbaZC81KDKaJ8eVma7n5Boex
 RHsag76gGWHBmR/c54kLU7LHrj5HLm62PVqqFlV2E9By4zawGxLUMCiy9WTMXyCYzVj8
 3sEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9j8bwgdLJWLzy1kUM4dDqiq5YvMZc8FfJnZhqiZK6QEN3+2lAK4NYWsHmSIvSLzTg1rYG/JiX6IExgXjM91wWPyJReg==
X-Gm-Message-State: AOJu0YzzpWemutiUFi6Wa5QP++KWbha+NicUkO+ZCYIxPX0EAigkL3Rh
 KAPY6A/ctBxHwD1/xoHeLzJzM1gR4zfraXvGJhmkNuhwJV/G8+2/
X-Google-Smtp-Source: AGHT+IGFBuuGJ3ZD26xoElD3k8oWTOTniW017SzcwziQZUTwICKgyu2UVa3RnIo8/aRfTWoOsDg4Xg==
X-Received: by 2002:a05:6000:dcf:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-36bbc0f7e36mr4175615f8f.9.1722683435656; 
 Sat, 03 Aug 2024 04:10:35 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 01/15] clk: mediatek: mt7986: fix wrong shift for PCIe clocks
Date: Sat,  3 Aug 2024 10:40:34 +0200
Message-ID: <20240803084050.449-2-ansuelsmth@gmail.com>
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

Fix wrong shift for PCIe clocks. This cause the PCIe port to malfunction
as the gate clocks weren't correctly enabled.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index efc3d4120b7..1e8c3278346 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -504,8 +504,8 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA2(CK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", CK_INFRA_USB_SYS_CK,
 		    2),
 	GATE_INFRA2(CK_INFRA_IUSB_CK, "infra_iusb", CK_INFRA_USB_CK, 3),
-	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_INFRA_PCIE_CK, 13),
-	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 15),
+	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_INFRA_PCIE_CK, 12),
+	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 14),
 	GATE_INFRA2(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_INFRA_133M_PHCK, 15),
 };
 
-- 
2.45.2

