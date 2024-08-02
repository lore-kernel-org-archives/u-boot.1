Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDC0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE90B88C13;
	Fri,  2 Aug 2024 21:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aBbEaVii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFE888BE4; Fri,  2 Aug 2024 21:56:35 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1305D88C45
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4281c164408so50263415e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628592; x=1723233392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a7eJIUdqa4bx380FNZyZLuT84kIEeNWT7n74/hqN39w=;
 b=aBbEaVii3g/ReqkfR3zTF9eyJRV8nD4cZqeZP/1BJ549jsDeV6xZwxXMXsP9dWfamx
 6zZ7GgUxEUJCKhRqND/YypD9A6dZStBemmOakSCK8SvSwzLVlBQfQfeYqVdCyzOlHIfL
 JxP9XS4zgXwHVM9nKjVc5zL9Na/zgsNjXfN4lMJ4m8IpiRsP3YwVHHyFQM1tJ0j9ACWd
 LRDEKwzpQMzLP7NE0cQcO92fMdDPfcIpSSHwhnJRR2ikKP3i8TMAudfLrJUy1A9fvJbF
 aeCg6ozwl63M+pwNMJIAFcwMkgxqI5SJ8v7JRgWOZ0zk7VyN93urYyXjxr4L52hQhA2a
 sn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628592; x=1723233392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7eJIUdqa4bx380FNZyZLuT84kIEeNWT7n74/hqN39w=;
 b=HU2gEWK+J1XZYlEPu12TSHILg40diaoWd2T9GNwJHSU1s34O9oHG/vAQFtf4IGM+N8
 JXkUCDWMg4J2L7osMfLEmETUBqj0gPcTgSmev6iuKuLcI/U3+84Y5VRx59fTKBMtCR0Z
 YTqXaz8mJ/yVCP9hatN0mhEvGDFP5G+AZlb0lW2TxVkkjFAVmIgmZ9KzH4OyI101hia6
 7IRkB4nig3hLl4LwejWOFX+mwNubfGFfUVSO4sa0aJPHaASpBD5Ls64mKSuuC3tWBLB0
 T1V+Hae9b46rvYJmXspI80y3zvIJVEVN+k65+5Tw0R/5EMfPmzXHiJClhna4PYfVMvW+
 KwNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHhPX6/JLN2KF6cb/C3jC3Oh2HpNdmgo8hubSpPfySbKFDErVnaZWQaP1E0GLhbKQkTS1tv/XCYuiXZUTblcebMsQm1A==
X-Gm-Message-State: AOJu0Yzb45aHMo249S61X65OrU/bsGsbpfvg0rtUGwf3tjItzY2vEhdA
 5hPK7fKqmJN9LkoAaTLxu8iNKhXbNuxT3yjZZiDSlIStOUGg2Zkx
X-Google-Smtp-Source: AGHT+IF3WwCC9Lp091cAAnNUNTAeWW2Dd3PvoKtOek5kJc81JRj3ogdcA6ClsLnFpCHHnPTcb0wxVQ==
X-Received: by 2002:a05:600c:4449:b0:426:6618:146a with SMTP id
 5b1f17b1804b1-428e6af1afcmr30501895e9.2.1722628592213; 
 Fri, 02 Aug 2024 12:56:32 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 01/14] clk: mediatek: mt7981: add missing clock for
 infra_ipcie_pipe
Date: Fri,  2 Aug 2024 15:53:02 +0200
Message-ID: <20240802135326.25303-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Add missing clock for infra_ipcie_pipe to make PCIe correctly work. This
clock is a parent of the fixed clock from topckgen cb_cksq_40m.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c      | 1 +
 include/dt-bindings/clock/mt7981-clk.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 13dc3df0e9e..7a699162421 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -515,6 +515,7 @@ static const struct mtk_gate infracfg_ao_gates[] = {
 	GATE_INFRA2(CK_INFRA_IUSB_CK, "infra_iusb", CK_INFRA_USB_CK, 3),
 	GATE_INFRA2(CK_INFRA_IPCIE_CK, "infra_ipcie",
 		    CK_INFRA_PCIE_GFMUX_TL_O_PRE, 12),
+	GATE_INFRA2(CK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", CK_TOP_CB_CKSQ_40M, 13),
 	GATE_INFRA2(CK_INFRA_IPCIER_CK, "infra_ipcier", CK_INFRA_F26M_CK0, 14),
 	GATE_INFRA2(CK_INFRA_IPCIEB_CK, "infra_ipcieb", CK_INFRA_133M_PHCK, 15),
 };
diff --git a/include/dt-bindings/clock/mt7981-clk.h b/include/dt-bindings/clock/mt7981-clk.h
index e24c759e499..1c2781cd765 100644
--- a/include/dt-bindings/clock/mt7981-clk.h
+++ b/include/dt-bindings/clock/mt7981-clk.h
@@ -226,7 +226,8 @@
 #define CK_INFRA_IPCIE_CK		(54 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_IPCIER_CK		(55 - INFRACFG_AO_OFFSET)
 #define CK_INFRA_IPCIEB_CK		(56 - INFRACFG_AO_OFFSET)
-#define CLK_INFRA_AO_NR_CLK		(57 - INFRACFG_AO_OFFSET)
+#define CK_INFRA_IPCIE_PIPE_CK		(57 - INFRACFG_AO_OFFSET)
+#define CLK_INFRA_AO_NR_CLK		(58 - INFRACFG_AO_OFFSET)
 
 /* APMIXEDSYS */
 
-- 
2.45.2

