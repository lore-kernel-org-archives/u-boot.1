Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC25C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F4D812C3;
	Mon, 27 Jan 2025 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iVNmS6jQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAA38129B; Mon, 27 Jan 2025 14:41:16 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FB181221
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso28797105e9.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737985274; x=1738590074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fhUvwSuFhgs/O8Fy9tYu9AMskoRbW7U2vOy0Yz086wE=;
 b=iVNmS6jQ78SFRocSh7ywoi0DNylbgs753Qk2XtzKIUePz44OGvSS1sjoqcv2c0UC8B
 L5nQZT3+CCXcjSSz020WXCN2P0DFSudC7rp/Fooq2/X3NE+yN7yKrVUax7rVqIrP+dQu
 TVl1nBqdoEvYYAEIaTIWBy8d0xcUDtsNfCk3D0u/qlgDIF0MZOJbtXcdTvM9onnpT5Fv
 OTZmyQno3xwGsb1xd+Xk7bqvw9tiSQ9s6GhqzF0+EJdGNExgVTxeQlWXvYeBimnHZya0
 jplXhLtxLnVWEpLVXoKHRETTHMYNYYkT9G4chtXFpQPp/vIYtnuSIxFSJsgEkcpZQ+Hj
 x7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737985274; x=1738590074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhUvwSuFhgs/O8Fy9tYu9AMskoRbW7U2vOy0Yz086wE=;
 b=uO2HyDcSyITyWCe0hVPPfTHhpi5SFFaBZeHD1P95ni8lXkPB1dyAn6qdT/4984Kpwp
 NaBwBJQwN0clHL8j0x+Js+V+tIp05PrROfiBD4ghlug+v/gxmNPOhmj+3JNgHzh60xfN
 z2gATNGreVpTFX08Ie6eESGGozxXJNc+3Wp0B3ds5U/u2M2Apru9AvagW6o5AonVCPDT
 kar3RHXtuQfrHpqQrvl2VImUNee6sICPVFu4drtuip/4c2R0f+3/mrhNvvDpw2sBDpNK
 uoUfD5fCUWYAJkXtgtpVS3/mvByyLrrwMax+eYYf2MvSKLgbEH9kwJKVh6s9D5kMWp0g
 A0gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp+AWUQ2ZCts9CnJGtKwI6mAYc5RiX6ubw7Z8rvNAonO/sV7gFkn0BJarf7hzWEO7QF7mxUGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyvJj+Lhyd7ebFto3xfRQ6tszcuuxlHaNkE5im4q6AM9svf0Ak1
 ZpJnv1OHv2ZAC+3x50LxnXK3JFpFortXmIWuS+BuXRHE3ZcrPqXk
X-Gm-Gg: ASbGncuTXzDIWdDe33BY81irie3eFWinOPfnKWEt3xUx8WoGn4qIrNHW4mLTXBvUxai
 i8hLtOl7Wmp2BmkBL8xBp3bzYMIxlNcNrHoZK1tZzo2ru1GzAt6cPsfoJiszW0gi7XpxU8PaJ8k
 fEIAZFlvLF/gJ5sQXQ76ETLMXMFRZ+mGWj/8oQk7apdMndVQ7qCBqBlQefxhss3QmaLXFAeW10J
 uZIl24p5fMre0Wrf5dACxkyJzC/SgZpra/kmJ+kzOkoRdamdsDQL1HW3i2AH0Lbnadf78rG3rrB
 8NVZ3+RTJY4yBvIhCAL3l8qonz0tBEiHWO161vo5Q3+YAz9ZvQ==
X-Google-Smtp-Source: AGHT+IEbw72ijLEVDj12Uz9DQuW7+sq3EeEeAR7nF3BWGIL+R+13mHMUOSiZQmo40znkgas65gRA+w==
X-Received: by 2002:a05:6000:186f:b0:385:e105:d884 with SMTP id
 ffacd0b85a97d-38bf57b6095mr40835662f8f.46.1737985273594; 
 Mon, 27 Jan 2025 05:41:13 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c4199sm10873900f8f.89.2025.01.27.05.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 05:41:13 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 John Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/8] pinctrl: mediatek: mt7986: rename reg-names to upstream
 linux format
Date: Mon, 27 Jan 2025 14:40:39 +0100
Message-ID: <20250127134046.26345-3-ansuelsmth@gmail.com>
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
 arch/arm/dts/mt7986.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/mt7986.dtsi b/arch/arm/dts/mt7986.dtsi
index f871f2394c5..64ce45a6530 100644
--- a/arch/arm/dts/mt7986.dtsi
+++ b/arch/arm/dts/mt7986.dtsi
@@ -132,9 +132,9 @@
 		      <0x11f00000 0x1000>,
 		      <0x11f10000 0x1000>,
 		      <0x1000b000 0x1000>;
-		reg-names = "gpio_base", "iocfg_rt_base", "iocfg_rb_base",
-			    "iocfg_lt_base", "iocfg_lb_base", "iocfg_tr_base",
-			    "iocfg_tl_base", "eint";
+		reg-names = "gpio", "iocfg_rt", "iocfg_rb",
+			    "iocfg_lt", "iocfg_lb", "iocfg_tr",
+			    "iocfg_tl", "eint";
 		gpio: gpio-controller {
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.47.1

