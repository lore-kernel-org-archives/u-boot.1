Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6A7C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 19:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4655981F95;
	Fri, 14 Mar 2025 20:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G9v+u2eJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD86581FE8; Fri, 14 Mar 2025 20:00:23 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9681D81F66
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 20:00:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so248205e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741978821; x=1742583621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g+pfH+FeH0WtTcM7Utp4Ere0OCa3U3rIkYv3dTL2znI=;
 b=G9v+u2eJ2S1RUvJfLk4A7XauhvBzX1YLdyxTXKQmzw7j3Zft99WfOOYTQ0NkucqeEC
 DIy+Zng52qbu7yfgYo8qd9bjMAxpCp0IShlueFGPGCr+eF8SQBVCS93G3JKro3G1R/Sp
 gkcDmZWmeLqtHv6VxPNMBimKlYT3KG/+RcV1qSoMIUU2GEl6X+M38D8Fxiwr0MvqegOE
 co5msHCDIxGoch837MYFCS2cQqTmh4IPrKVtXinOQKRX1TkniuXmk8a7Xvw/lxKGxCDu
 SwjKBv7q7HoPmYdJk7HyhC2u+KfnqQvP5p+scGXSlycY/torWRBu/v9FLZDIfAmdIByh
 jvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978821; x=1742583621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+pfH+FeH0WtTcM7Utp4Ere0OCa3U3rIkYv3dTL2znI=;
 b=kjTAZRYJ29iKABl2dPr1/GG7Nfz8KcOWebO7z5nKPvgXYPB3rzSjOg7kvzR1SIbVRj
 CTyUJ2jxXaRBYsP8y1/ppY5EtX/nE6Zhy6bzjW+jX03GBRryOU4VbQqp0OCqK10TS9Yt
 IZvtgHgWwe9EWFeY+vVwrs2v2kisaiSxf358ZRhOcddTeguUw0lM6GWuYQysEyAJK9BJ
 Ke07J0IBvPgOxbVdIbTItdaSVSeJrk8tW84ptHC7W8W4fkeeQvTZaR0rr2GsuyWn/8Gl
 jNvi5yx02VJ0XLSpWkz4nIKllBjDdY5hmkA6mXgOviJoWBRbLXmS5rwO+We6jsLArG4z
 Kcxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWesPronAsYFALgZ0JBm/cSwNMwwvcYwBerwI/lW+qDt1/nSSD+Xy1H08CmE2s5/Eqv0SxT2yI=@lists.denx.de
X-Gm-Message-State: AOJu0YxrQWXS7559amXWgOw8IKblzbAVMgA2WG6KE55CAqTTngihH4QM
 TMAiyWhnZMSDdsNTS0zE6hwHolAxaK2CP14zZMhgoWql31SpwdO0
X-Gm-Gg: ASbGncvCpIjNnX2oB47N9TD7WRJnXVuopY4DCEAWTs75gL34iXvp8eVCJjkj5GOjIEi
 bTFuB8Q4sgaAjC1+ZErvTO9MWQ+/gA7Eh1Jo1GEJuyLA4AjbC0SE67YvJEWT2GtV3oQpP6EB+6p
 V2jWcLHt6S/hmMtf6Q8jiifFP2uwXStzvcAbeo9xMmtVCb5wxe4wQ2a+wEIA3rTkCXyroc6mQtR
 fJ66te/WizwXh790Cc50FyE7qbnnrp0NEl2GEXD8Bk7budGJQq3ogG8iFjwBg2xPZXYkDuDCC5V
 wZ6Izv+OOPamM6nzsoVKKAPZONUPvGUn/9BwyZYxG5UTKg9JV0ItS1w6GGSPCJeU/qN+xRH4k0A
 jyNDapqQE8xRwqQ==
X-Google-Smtp-Source: AGHT+IFjdk1Z2EBYf1Vua4hDS9gb3SG7BAgQqcoozKheVrqp1ec7Ra8HGZHYnCLpPehMqR92rJGK8Q==
X-Received: by 2002:a05:600d:1c:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-43d2018096amr48283535e9.14.1741978820839; 
 Fri, 14 Mar 2025 12:00:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it.
 [93.34.90.129]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffc3e67sm25547965e9.17.2025.03.14.12.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 12:00:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 4/6] arm64: dts: airoha: en7581: Add Clock Controller node
Date: Fri, 14 Mar 2025 19:59:24 +0100
Message-ID: <20250314185941.27834-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
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

Add Clock Controller node for EN7581 SoC to correctly expose supported
clock for any user in the SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20250105150328.15172-1-ansuelsmth@gmail.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ upstream commit: 7693017580e9be839fa5f27130bb6500f3597595 ]
---
 dts/upstream/src/arm64/airoha/en7581.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/dts/upstream/src/arm64/airoha/en7581.dtsi b/dts/upstream/src/arm64/airoha/en7581.dtsi
index 55eb1762fb1..f584409e72c 100644
--- a/dts/upstream/src/arm64/airoha/en7581.dtsi
+++ b/dts/upstream/src/arm64/airoha/en7581.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -142,6 +143,13 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		scuclk: clock-controller@1fa20000 {
+			compatible = "airoha,en7581-scu";
+			reg = <0x0 0x1fb00000 0x0 0x970>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		uart1: serial@1fbf0000 {
 			compatible = "ns16550";
 			reg = <0x0 0x1fbf0000 0x0 0x30>;
-- 
2.48.1

