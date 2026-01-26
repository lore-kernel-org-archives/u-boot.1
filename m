Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6024AD19501
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F09C83EC0;
	Mon, 26 Jan 2026 17:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3dG3F5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F2F83C04; Mon, 26 Jan 2026 17:15:16 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278D083B03
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ozndrgt@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso47435745e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769444113; x=1770048913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9fgQEwbn9RuEw6zC67PMHo7kDK4g9uwtgbcuyvtV6A=;
 b=W3dG3F5uEEzlP5xBWXi4H+Y+Hq+/83dRuVztZqwCrdrvM41oX4hX+bg4e+LF9PZpZ8
 rg+GDfyal/c3yR5q6Vae6lqjBjVxpJOvmB6UPBRSQRBy/Htn8UBSM1QAJ0BNj6FTOQ0G
 6hELpsRk0BX1b/8Txhkp7+NR27fY1Z24PKYuQ4y7y29GXxKvTTvRQAPyuHqIBG1W8l+e
 c/+P3NSlS8giq/RS+Ri5gxxsp8pc9y8stBraL9WgdkakjTAQ27FvqRzopBnkS1Kchkwm
 eJzfqvQJ7i9AIJTQW2HfGoclIDFypoFpmBzPVqfFoTE0wYmxSkn7oemuYjsAVjlJ0fW8
 2+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444113; x=1770048913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9fgQEwbn9RuEw6zC67PMHo7kDK4g9uwtgbcuyvtV6A=;
 b=IaOKv5KOSukrvpSfVlhaN8T5+S0Nx3/cgKl8TWDqZl9iNofbJkWTSSzqg+nBbphm0X
 GPZ05Xxu0B/rBYOCQTxlABz9sGVrs4NZZddbvv6yLlzl0MnNVrMi2wwDPlUw8JEG6Keh
 qwtGh7+0T2elOv2ylc4wf7mCQcQaJ5dGl53+y42Dkv7eIQQD5PHt/7dFnZzltUfv/GYV
 NMK6Sm1XYxMsCXoNy/T3Few89EgOKQa8OpcKAcZ+7ysUBr7jvIbBizeW5ElURcpxDtpN
 I20+V6GxqQlAUu9ldBTpuh4gl2SaVVt7eU2c7ZqBoCcxr44K1gu/OEQ2XVCDdesP3g4N
 Yf6w==
X-Gm-Message-State: AOJu0Yx7IIAsfhLV8q8Pe/MViRsjr4OGyDLH/cu0H80T6vfitl5mYpel
 Lq/3xX0yYv00JC1LeVppH8a+Iu9NwAzh4OvXHt5PMWqZtoTHZe5VaQzlmwY/Sw==
X-Gm-Gg: AZuq6aLIMYh9Ha9jx1R1mzK/HFmhzk+ghNAsCy8jYgyJ69CKrVDISuLbF5TnKtQgifQ
 jXqUi9PpWb3deah2BHWaXLXWIap0+ckP/Bybiv99gXGa6RkbdviDYDnYK5v8F5HmWdjm/MQna+a
 frUL5xJ8jv38sD3hvPrnZgZON1PiM0rfIAEo7AU5TzE9V86b0PMQ/NL+H3vlS3ozO43iEi/enJM
 8eiTsp03GFhRnVzAei3P3fLjKUSDQS5V/bbETSdOi4kO7DVbEO7l9F2MbGbQLAdDhqxcfy5xOuk
 iYxqNYPi+sQ5/YtJIEzVPbAU5aqRsHwm0eaxk2kJUsrZvS5xokxTohjZhOxsXaebPrpHqRwEhXi
 OJmcDbGaTVMzssTbmza03fDmkTJSGg15wy5KXxmOD4Fu8+rcOcNd0BYxOkP7LGILwXgwJrNfnMt
 Fh26auvLX7Hc+ylNJ3n/fu6CU=
X-Received: by 2002:a05:600c:5494:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-4805d064297mr77843075e9.32.1769444113302; 
 Mon, 26 Jan 2026 08:15:13 -0800 (PST)
Received: from odurgut-Precision-5570..
 ([2a00:20:c361:3985:cfa:b5c2:f360:f511])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d5ffe12sm107368615e9.3.2026.01.26.08.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:15:12 -0800 (PST)
From: ozndrgt@gmail.com
To: u-boot@lists.denx.de
Cc: linux@analog.com, malysagreg@gmail.com,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH 2/5] arm: dts: sc598: add missing GPIO hogs for Rev D
Date: Mon, 26 Jan 2026 17:15:02 +0100
Message-ID: <3a53026951eba0ff6e0f7d2be8760feae8b48521.1769439596.git.ozan.durgut@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
References: <cover.1769439596.git.ozan.durgut@analog.com>
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

From: Ozan Durgut <ozan.durgut@analog.com>

Add missing GPIO hogs for UART0 enable, UART0 flow control,
SD Card and eMMC control signals.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 arch/arm/dts/sc598-som-revD.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/dts/sc598-som-revD.dtsi b/arch/arm/dts/sc598-som-revD.dtsi
index bf1ef88cb58..26e272966ff 100644
--- a/arch/arm/dts/sc598-som-revD.dtsi
+++ b/arch/arm/dts/sc598-som-revD.dtsi
@@ -55,6 +55,38 @@
 			line-name = "spi2flash-cs";
 			bootph-pre-ram;
 		};
+
+		uart0 {
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "uart0-en";
+			bootph-pre-ram;
+		};
+
+		uart0-flow-en {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "uart0-flow-en";
+			bootph-pre-ram;
+		};
+
+		som-emmc {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "som-emmc-en";
+			bootph-pre-ram;
+		};
+
+		crr-sdcard {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "crr-sdcard-en";
+			bootph-pre-ram;
+		};
 	};
 };
 
-- 
2.43.0

