Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC1C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D9BB8129B;
	Mon, 27 Jan 2025 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QrU8GPnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B5C8129B; Mon, 27 Jan 2025 14:41:15 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23ED381276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863494591bso2479257f8f.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985272; x=1738590072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IxIhgfwyyeT7zkb25nXAfAc9AuD0Q4fHOjI6gQ2fhPg=;
 b=QrU8GPnlJfREY82uyndUiwaU9wUHCIuryEDos/+7z91P6bJcYWDBhCsOcn/fscanhR
 5Uf5G3Fv66lAE4BJ9Wqbths+GpDvRqFlFulYnrAcH4ACj7AlqTaTQE1C9q1dDWSWBW95
 ZgSMUJ1XDCwUi07/1dRdMhTrAZN5xBsi6ZxlwNWe4XmE67POlXf5w+th4GpJmj1QEhCV
 1D5m1HEL/pCjxRY5ndCUSHKngYVD/sECF2Ro/JTiFPHk4ak9y4nqaxxbOOFaNx5m+eRS
 shgDMxFQIbcYIf64axjFI3Z6AevohlB8zO/r/J9udk5AYH4vWmq6AZBko7amGXN3TKFc
 Hccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985272; x=1738590072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxIhgfwyyeT7zkb25nXAfAc9AuD0Q4fHOjI6gQ2fhPg=;
 b=punL05gdgBwYndiTvUx4Xe9Xa/sJeFowXkJ1X+9z//u3/Eyr5vnRwhuIn/ujnfSX2C
 0vIxcY89Ethna/pyHYYfivW/elgPZrayptgNxF4SP1saBCop3jBrC9IDGgxYS1+rHYMG
 kJdX3jmZLFKGpOVSc4k9Z3kbD4yavcl2lxmvY86eT6Pp+7iTDGe1Ivxj6bwXmEtADXOh
 98EWVsRbGVmGpdaeX0jFi8Z0bKAPwQ0QsdBOjCVJbGCxJNzsJfvSgsvHUCUk7k9yRD7z
 Dck9adDtMf28+W3YWbfvjlzE1gRzgVD4DPseh0thq0QE+r02k62TFvLiT9QknfNax5Qt
 eDFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHB/6uMbmALFgbSvrg8OwB/N1B6d8wPNzMTUpRDgTnUywnxm6c3F1Pg7B3DXeUghM2Cp8wwmc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+zl4Qq6rD8bhVTjwFkVwyyGubo+78HMsJaLbGOZo4naxyZ2LZ
 QGAK0+CiWccFIerQ7Go18MZy1eE2akRxuvRptGspF6Xl2sIooOYT
X-Gm-Gg: ASbGncuK87ob5ssOaNY1qG+Z5JkAwgcqDXRj7ygnbWJQIectoO60ri5rWNW09ZwF/B9
 uYgLI1UFpu1yHVHq0aITLt/YKpjwsTTzYhuqUTGVi2NgC/T6nxTXVPMWoBu/1Jd291+PV+7bZXN
 qRr9gQRbCUYbeh3cDsr3xezt3s9iiKtdalU9GmBORl979rEoh0MnnFGrSbH0+zNIbK9Maw82Scy
 ZSiRphZUdNMjifB+hg7uP3lKRtD21ZwPl/DjtJ1297gq2dczQkISzA7KLrcUbEHi+gaE/AUkE7N
 ynBFoYzufdAL/UJmxGHUpgh7Myfjb0Nr/zi64FjF3aSjFcWdZQ==
X-Google-Smtp-Source: AGHT+IHuQFk8lSNdV1pgwSjl5lT2PtG4gPeDzAixs6yM5VzAgi+PJ4UR98J8pYNE0CrlNHOTj8IHgA==
X-Received: by 2002:a5d:6505:0:b0:38a:88ac:ed10 with SMTP id
 ffacd0b85a97d-38bf5789edcmr32108197f8f.25.1737985272571; 
 Mon, 27 Jan 2025 05:41:12 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:12 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/8] pinctrl: mediatek: mt7981: rename reg-names to upstream
 linux format
Date: Mon, 27 Jan 2025 14:40:38 +0100
Message-ID: <20250127134046.26345-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127134046.26345-1-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
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

Rename reg-names to upstream linux format. Upstream linux drop the
"_base". To make use of upstream DTSI, align to the upstream naming.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/mt7981.dtsi                  | 6 +++---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
index 2844ab010de..3c8b9ab0574 100644
--- a/arch/arm/dts/mt7981.dtsi
+++ b/arch/arm/dts/mt7981.dtsi
@@ -117,9 +117,9 @@
 		      <0x11f00000 0x1000>,
 		      <0x11f10000 0x1000>,
 		      <0x1000b000 0x1000>;
-		reg-names = "gpio_base", "iocfg_rt_base", "iocfg_rm_base",
-			    "iocfg_rb_base", "iocfg_lb_base", "iocfg_bl_base",
-			    "iocfg_tm_base", "iocfg_tl_base", "eint";
+		reg-names = "gpio", "iocfg_rt", "iocfg_rm",
+			    "iocfg_rb", "iocfg_lb", "iocfg_bl",
+			    "iocfg_tm", "iocfg_tl", "eint";
 		gpio: gpio-controller {
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 047e37bc9cd..d1c8afd9252 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -1012,8 +1012,9 @@ static const struct mtk_function_desc mt7981_functions[] = {
 };
 
 static const char *const mt7981_pinctrl_register_base_names[] = {
-	"gpio_base", "iocfg_rt_base", "iocfg_rm_base", "iocfg_rb_base",
-	"iocfg_lb_base", "iocfg_bl_base", "iocfg_tm_base", "iocfg_tl_base",
+	"gpio", "iocfg_rt", "iocfg_rm", "iocfg_rb",
+	"iocfg_lb", "iocfg_bl", "iocfg_tm", "iocfg_tl",
+	"eint",
 };
 
 static const struct mtk_pinctrl_soc mt7981_data = {
-- 
2.47.1

