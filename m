Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C493DC54734
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C0D88753;
	Tue, 27 Aug 2024 16:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="gXIySyiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F9B88A2F; Tue, 27 Aug 2024 16:21:42 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0271688009
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so95592766b.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724768499; x=1725373299;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAgW55hiA6tnEAet1e09qZ0yGF71t6ESZNAS8YQvrZM=;
 b=gXIySyiWbph/zZCTCschzneso/dTtijRUCXAMAjZzcxJF967DfP/gvM8cCbjKyQufN
 3nN44RBXTOYmnO02FvX+16RlZidmJS7qjIYnXcd3WXbsfcOisxuHUWNCNUJNPqNXRJPc
 /25gQBWx/5m0j3EJ6p0yE4zXLSn9Zy4BJuAIAS68SjFPbbyZztbSXSIXvgDbRfmh0+OB
 Mk6asFbZNRVB5lqLvAnX/nxOGEjTRZMcL/euW0UEJMeczdUaTbo4ifoTgrPVQVVJsMHA
 QfLUSwWjfwpan3Oe0ftRRdD8abfeIuNS/cIeYtHm8lvjII8WRw4wzBJvoHAcCBg/yQPk
 sdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768499; x=1725373299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAgW55hiA6tnEAet1e09qZ0yGF71t6ESZNAS8YQvrZM=;
 b=pAJqwysygttgrCNhKFZlMtvY7ykkIEgiFbUhICSsh80hE/PENQtluIa0WeRaAfJMxO
 LayQSpbu0/QgQ7vPlHAx9H7KqGOIE+/Fuzptq4YEUHL37PPQWc3jolKdFSvgbKGNf8E2
 jYV+8subAxQjy0KihwoTSnehS2zcwHNSigQTJZ9ryWQp6yYKfBqVPaxHVX4kIi665O4z
 NUhFPNosUrU+d2xLr1Aja3Zob6A3NiGoTq8e6nP7q1NRgQKAlMBpCDKoS1dXy73G7dgV
 A8kBRMbCdqqaQ5sS3hslw6nqkVTDsMDDJpiL3hVz33hOwKTI6dWRDZm1vu56hRlUjLQl
 +IsQ==
X-Gm-Message-State: AOJu0Yw7bHUO4o+ttq2Rus3Z4wDmNzdy9ViGLziR0uawJqKPQ+n9awFD
 Lu9+R7GAWBKRURZBTXgGBPUISkWP1z3WbcMEw86HQ1Ax7GABJVkhS5n1OUo3vNT3ZAky0WAzAzc
 n
X-Google-Smtp-Source: AGHT+IGdhfKU5WZskwLYH60TOvH7qmOdXt1/w8Tysj2TPn6rBFRzQuh0/dVOndkUDEW1DCvv4brmVw==
X-Received: by 2002:a17:907:e229:b0:a72:40b4:c845 with SMTP id
 a640c23a62f3a-a86a548805amr970380766b.51.1724768498988; 
 Tue, 27 Aug 2024 07:21:38 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594e809sm114854366b.219.2024.08.27.07.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:21:38 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 1/4] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
Date: Tue, 27 Aug 2024 16:20:55 +0200
Message-ID: <20240827142058.594556-2-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
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

In case DEBUG UART is not used, define dummy macros replacing
the actual function implementations that will not be available.
This allows to compile code and avoid linker errors.
Because the DEBUG_UART_FUNCS macro should not be used if
DEBUG UART is not available, redefine it to generate compilation
warning.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 include/debug_uart.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/debug_uart.h b/include/debug_uart.h
index 714b369e6fe..dc0f1aa4c98 100644
--- a/include/debug_uart.h
+++ b/include/debug_uart.h
@@ -128,6 +128,8 @@ void printdec(unsigned int value);
 			(1 << CONFIG_DEBUG_UART_SHIFT), \
 		CONFIG_DEBUG_UART_SHIFT)
 
+#ifdef CONFIG_DEBUG_UART
+
 /*
  * Now define some functions - this should be inserted into the serial driver
  */
@@ -197,4 +199,18 @@ void printdec(unsigned int value);
 		_DEBUG_UART_ANNOUNCE \
 	} \
 
+#else
+
+#define DEBUG_UART_FUNCS \
+	#warning "DEBUG_UART not defined!"
+
+#define printch(ch) do{}while(0);
+#define printascii(str) do{}while(0);
+#define printhex2(value) do{}while(0);
+#define printhex4(value) do{}while(0);
+#define printhex8(value) do{}while(0);
+#define printdec(value) do{}while(0);
+
+#endif
+
 #endif
-- 
2.43.0

