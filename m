Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FCC52D6D
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 08:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC37B88BF5;
	Sat,  3 Aug 2024 10:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k24G08W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D25088B43; Sat,  3 Aug 2024 10:33:29 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208D788C58
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 10:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so136662611fa.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722674006; x=1723278806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uWwkNg0iGFmB5anuP6t2lYi4LwskvyGFOqRgQUDMVQo=;
 b=k24G08W0mgPuYBxz/R7TYvgD3+N/j3gDVy4uVsCTJ7c7kRJ8RcXfKS1h9LMM/Hjt0C
 JIqBMGzH0r4WPlyV3pwC3/B6WGGYjWheeBBdUN482mrI2HiOBJ08NbEU09r1GotdG3s6
 IHC76Gj8Rc2e8/rVcIsGk2oegbdKyebsfs9BprxGdXXH0YYALNes4pg2gJA0lKUeHirI
 Q1iwgNAIdr/ZmQ4EdFK9mK3zl9E+Pe++b95cKFNGlbSNisZmC8Ek6m+wtC3f6Sny1GDq
 MzPaU2nket3jeeyuHaYm6e5ZXAHvcu6ZTCtheOb1cDsJRaj1d8TUp/kk9weU1tYR66gI
 DDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722674006; x=1723278806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWwkNg0iGFmB5anuP6t2lYi4LwskvyGFOqRgQUDMVQo=;
 b=rygyOTsRDQwSx/b5+/hs7Sg0zk70EoX93noojJ4Qp8bjDb7rRkIyTJclDdBPH406QI
 /HzcyDnTUojnYswciZjDcp29bRgPbDw8ibIbhpPhKEKLMrCfYGaQabvZ4f/BU4YkPJsm
 wPyZO+w5d9QNahij0qvWlWIkMUJ40kZLIYipRW7AiyxjqtMhzfKNI3BivsrozTk9HiZv
 SMtMtF41IOO6De69FXB7Eq7RZzK7XL0hiezROdpp4oKLSEqaalaAfI7J4oTWJVVLCRr9
 m8gzmS+PZSB5cAWaWEUl2AHgOFPMme2wLDNd4aN59jZWPn+VcTSv7FJ5uNtHvYLxvCU3
 cNlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyElsIoX3+RXxBvT++G7JGzGz/1cci7+NxjkusIMOkKPYC2icl7XfLVFZw9pg+u0NAC5gPFdIVQItMEeEzCJK4b2BeHg==
X-Gm-Message-State: AOJu0YzIjrhxzaLtRh9ow+Kvbm5N0L48c0X3/QsOEJzU0OOS5sfzCRWT
 9tJLQ/y3GcBxz7J51atzFjLdOOS1aKuBGq/k0dgzHsZhQUpXob+5
X-Google-Smtp-Source: AGHT+IHQM9UdK8VZAwFhwr/YgC8gzRtMv5JHkUlvQIuslJb+dCepGeHdg5qS3yK8q3cugrMrjCyLLA==
X-Received: by 2002:a05:6512:1086:b0:52c:dec1:4578 with SMTP id
 2adb3069b0e04-530bb6c949fmr3493012e87.60.1722674005951; 
 Sat, 03 Aug 2024 01:33:25 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4282baba5f2sm121248145e9.26.2024.08.03.01.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 01:33:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH 05/13] clk: mediatek: mt7988: fix wrong parent for
 INFRA_PCIE_PERI_26M_CK_P2
Date: Sat,  3 Aug 2024 10:32:54 +0200
Message-ID: <20240803083305.30697-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
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

Fix wrong parent for INFRA_PCIE_PERI_26M_CK_P2 as should be
INFRA_PCIE_PERI_26M_CK_P3 instead of INFRA_F26M_O0. This is to match
implementation on upstream kernel linux.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 5d146246fea..a37ad574e11 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -650,7 +650,7 @@ static const struct mtk_gate infracfg_mtk_gates[] = {
 	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P1,
 		    "infra_pcie_peri_ck_26m_ck_p1", CK_INFRA_F26M_O0, 8),
 	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P2,
-		    "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_F26M_O0, 9),
+		    "infra_pcie_peri_ck_26m_ck_p2", CK_INFRA_PCIE_PERI_26M_CK_P3, 9),
 	GATE_INFRA0(CK_INFRA_PCIE_PERI_26M_CK_P3,
 		    "infra_pcie_peri_ck_26m_ck_p3", CK_INFRA_F26M_O0, 10),
 	GATE_INFRA1(CK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
-- 
2.45.2

