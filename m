Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A2D2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 21:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793C8839B1;
	Sun,  7 Dec 2025 22:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EYeSFUUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9257C83979; Sun,  7 Dec 2025 19:49:33 +0100 (CET)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6048C83015
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 19:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2a45877bd5eso5900645eec.0
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765133370; x=1765738170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vxWfIsiH//fSuJ4oNMGkAKX/sE3Dlf2eJIzShhMhuE4=;
 b=EYeSFUUOMNTkfJFdNyUwYHIsAnsKpb4/4mhJPIOPpsc2lmzWFCq1V3XQOZI99yk0HL
 qm2ZKTnmlOeegXsGivEh1Dt32/LkcWeVzueE0uczuB0yb2QGRmQYdzqeuERNL/OHXpC6
 qutcTn6MiD0mwK/c3tmkSnhctIAxzN8P4VJFSEQxgR9RMP6SoggabkXsfxroq4XbfifI
 +sl93cwp/f0ghmTRWEKE0nlF4cvxiMt6EisQLAk8yrxS5360ZQyWDZs3B3XJD9QzmNjJ
 BcsIOn93QUcUYckposNJZR7KErCTrRuqkNCjpyj1Gu4XEnF+8BPJRnyel/3MTnnJUdcQ
 fabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765133370; x=1765738170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxWfIsiH//fSuJ4oNMGkAKX/sE3Dlf2eJIzShhMhuE4=;
 b=p+JVc2diobv4HaJekLl16XA6JSWsLtaXibcIomsFzfhnxtI7XebasDpFCLi5f5CKb7
 8Qv8igfeJSh8p5i+540gDgVRCAeaFrX1XkbPxb5Y8akziyHodRZpF8gg1El0JzP3IquT
 gee5PUW75tbXQ7NYlmk1kylYtUQrIJJ12Y3OrNkwOarFdOWA5rRcED4PM/gJRd04Vp2O
 ajeQ/muVU1/lKA1gOlUwuVkcsq9687dXkPJ1lN1WQRZAWTUM7oj6ONgtnllrXP7vHP1h
 X7QqyzRVxO7tUq6saksR9P1sKaoeDSmTuufUi50OPcjWOUB5FjH9qv4bs36GJh39ekpW
 +mig==
X-Gm-Message-State: AOJu0Yzee/G8S5QaxpgtTtF7O3kqs9lCNvAVA+oa3V8Zsh/U8wg3Zgxb
 GxbYGt41iQCQqwFwn4DHkC6QY2yr+WwgcSw4OyYrB8OgJJAqhkRASFW+Ti6w25lM
X-Gm-Gg: ASbGncvwzPE5wfR4F9L45QtznK6zTSkdURUyyqKoKxuQvri4yG2+uZJmubpjuujFOO/
 RsvqgMudgLvs7VvvQyqWNVnoKtccpCiBsURq4H75O3IO3oLvS+ib6iU9XtZqMo2dsIBdjJeV8Mn
 8bIVT1YgYW7rwayOxJR9ZKejJFvhbFTebeepJm9qsgZdIaDYRP1ZG/eDa9n8087VI0fE7qhYl0I
 NUAldthFCm5CnT85in7VFaUeDPqP3c8KgTPC4cSK9xwkXUZRnuen9Lx5G/dE/+GFopnAxHqeGrf
 DUUnzlJZBNfLSrxrZSz3ZPqHBbTY7TgVQUGK8lT5TO77FkSFkTcplVBdlNWa2TCHhOVsZ77NMla
 PJt3hoJRRzqAyOx9NLkuQX12jG89I8q9ro8BZNCLi59YomeeiZAVmJkb6/JOcWGob3+Ys/7ZmIv
 re5hrhkKZr
X-Google-Smtp-Source: AGHT+IE1+agITt/LmkF7l3eYh50eWMZz/gXGtxbbukJEQqds+b2cPPL8B495yhI1+iuxey0gXXGHbQ==
X-Received: by 2002:a05:7300:f283:b0:2a4:4595:123d with SMTP id
 5a478bee46e88-2aba34e5be0mr6001745eec.18.1765133369590; 
 Sun, 07 Dec 2025 10:49:29 -0800 (PST)
Received: from ArchLinux ([43.251.91.121])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-2aba88433fesm31088752eec.6.2025.12.07.10.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 10:49:29 -0800 (PST)
From: nathbappai@gmail.com
To: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, bhupesh.linux@gmail.com,
 nathbappai@gmail.com
Subject: [PATCH] phy: Add MSM8996 support to Qualcomm QUSB2 phy
Date: Sun,  7 Dec 2025 18:49:19 +0000
Message-ID: <20251207184919.12202-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Dec 2025 22:12:33 +0100
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

From: Biswapriyo Nath <nathbappai@gmail.com>

This change is imported from Linux driver and tested with SM6125 SoC.
Note, the msm8996_phy_cfg struct is same as sdm660_phy_cfg but
qusb2_phy_cfg::se_clk_scheme_default differs only.

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---

 drivers/phy/qcom/phy-qcom-qusb2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index d98f6108..9e821365 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -224,6 +224,18 @@ static const unsigned int qusb2_v2_regs_layout[] = {
 	[QUSB2PHY_INTR_CTRL] = 0x230,
 };
 
+static const struct qusb2_phy_cfg msm8996_phy_cfg = {
+	.tbl = msm8996_init_tbl,
+	.tbl_num = ARRAY_SIZE(msm8996_init_tbl),
+	.regs = sm6115_regs_layout,
+
+	.has_pll_test = true,
+	.se_clk_scheme_default = true,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
 static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 	.tbl = sm6115_init_tbl,
 	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
@@ -450,6 +462,8 @@ static struct phy_ops qusb2phy_ops = {
 };
 
 static const struct udevice_id qusb2phy_ids[] = {
+	{ .compatible = "qcom,msm8996-qusb2-phy",
+	  .data = (ulong)&msm8996_phy_cfg },
 	{ .compatible = "qcom,qusb2-phy" },
 	{ .compatible = "qcom,qcm2290-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
-- 
2.52.0

base-commit: c7c2c3c0101f625c01bf101d652e03a6d4aa950f
branch: master
