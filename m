Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CD2C52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 11:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731FA88C6D;
	Sat,  3 Aug 2024 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jug3XDPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF46088C74; Sat,  3 Aug 2024 13:10:45 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0199388C42
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 13:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso61403145e9.0
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722683442; x=1723288242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8YjHfs8glI7Lv6vNB/TW1RvYHSKvICD7T1685I/WnMg=;
 b=jug3XDPrXkwIz6l+8Bc8imeA+iYL9wR4U3za5QuVi9azexaY7hd5XUHbSMKcgIRp3r
 otQtmdLLN+0sbu7pfQv0kIFQGNR3OFbyecr6dvGVV+PNU2ATqYoHa+DjhmAP44rbOHRk
 kvZYatl/P5U7Hb7YiBns8MkAWdwvS5D/B/cuBHX7MpFn2UFegs38I6cXp3K7pzQLbxHW
 nBJwM+bqIFcsKuQnHHSRFJGT7KzHrscoFhdn41o/E4rmLFvBN5PlCqw1l6HV5znRSq/o
 PqFxyiy/diVzSeqnWa9zg2nalc05itPeQ+oeRpYA2/f9v9ziomF/vI4mq5a+IGCqSsfz
 6ZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722683442; x=1723288242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8YjHfs8glI7Lv6vNB/TW1RvYHSKvICD7T1685I/WnMg=;
 b=NLK24fAd9WiTp4xtKQObCdKRXYt0TjWjwWxxgB3tbDOJwpaqwm+el9ev3kytwflVA0
 HSh8e8KpzYISBtsVpf8S6ZauKkpt4Zc3AN86KOCwAJutoCsPdiKscUuSSr5nXD0HpxX4
 pElyq0KOK0ULSLySTYYzODQD8ExtM+a6AxPn3jjRHtDc+aOArirG+9U5Ooi7kSCZYZ0D
 hHGbIKoltauazb9tfzZFURosNDKurBrm2uhSfMDNNqKkKvg8EazeCBtPQwBLbENLhoL3
 U722vtgKS00hWMyLMzJn69AWCeBKUqObTN60OjYK/JDn/BoD3yhEy5m3grqF0BeFwKlI
 eFAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDACNF7e+BhuhxtPMzBJu4UyXDYcDQ9kuzPsCZnZgLYcrNdqeq9LzFOXbFni0vQ+JHIEJ/u/zj7gk2zP+OIefA4YFH9w==
X-Gm-Message-State: AOJu0Yw+NO8mOpsXY3qIetBcxY58Pow4XXmc4v8jDigMRWFspnNs7z2Q
 JFBw/u6fjbmD1FLxngd2AtpAVTZ7F4Qj70bKaGEklPlS7fGdPHVz
X-Google-Smtp-Source: AGHT+IFpW3nh12+1WwX22csGJOwAAffTMFjUHGyKNwUXTYmDxUEDF4wkESUAiL+1NaY4FxRdR6JE/g==
X-Received: by 2002:a05:600c:4f92:b0:426:6e8b:3dc5 with SMTP id
 5b1f17b1804b1-428e6b92636mr47399705e9.32.1722683442359; 
 Sat, 03 Aug 2024 04:10:42 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0dc9asm4085699f8f.15.2024.08.03.04.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 04:10:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 06/15] clk: mediatek: mt7986: add missing entry for
 IPCIE_PIPE_CK infra gate
Date: Sat,  3 Aug 2024 10:40:39 +0200
Message-ID: <20240803084050.449-7-ansuelsmth@gmail.com>
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

Add missing entry for IPCIE_PIPE_CK infra gate clock. Renumber the clock
order to match the expected offset in the gate array.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986.c      | 3 ++-
 include/dt-bindings/clock/mt7986-clk.h | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index f1870ce3d60..5f07de23756 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -336,7 +336,7 @@ static const struct mtk_parent infra_pwm_bsel_parents[] = {
 static const struct mtk_parent infra_pcie_parents[] = {
 	TOP_PARENT(CK_TOP_CB_RTC_32P7K),
 	TOP_PARENT(CK_TOP_F26M_SEL),
-	VOID_PARENT,
+	TOP_PARENT(CK_TOP_XTAL),
 	TOP_PARENT(CK_TOP_PEXTP_TL_SEL)
 };
 
@@ -487,6 +487,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 			2),
 	GATE_INFRA2_TOP(CK_INFRA_IUSB_CK, "infra_iusb", CK_TOP_U2U3_SEL, 3),
 	GATE_INFRA2_TOP(CK_INFRA_IPCIE_CK, "infra_ipcie", CK_TOP_PEXTP_TL_SEL, 12),
+	GATE_INFRA2_TOP(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_XTAL, 13),
 	GATE_INFRA2_TOP(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_TOP_F26M_SEL, 14),
 	GATE_INFRA2_TOP(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_TOP_SYSAXI_SEL, 15),
 };
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
index dbae389858a..16faca5fef8 100644
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ b/include/dt-bindings/clock/mt7986-clk.h
@@ -167,9 +167,10 @@
 #define CK_INFRA_IUSB_SYS_CK		40
 #define CK_INFRA_IUSB_CK		41
 #define CK_INFRA_IPCIE_CK		42
-#define CK_INFRA_IPCIER_CK		43
-#define CK_INFRA_IPCIEB_CK		44
-#define CLK_INFRA_AO_NR_CLK		45
+#define CK_INFRA_IPCIE_PIPE_CK		43
+#define CK_INFRA_IPCIER_CK		44
+#define CK_INFRA_IPCIEB_CK		45
+#define CLK_INFRA_AO_NR_CLK		46
 
 /* APMIXEDSYS */
 
-- 
2.45.2

