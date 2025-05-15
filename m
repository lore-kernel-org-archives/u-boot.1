Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9698DC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E625B82C8A;
	Thu, 15 May 2025 17:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="GeH4gzLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A407E82BC1; Thu, 15 May 2025 17:58:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F5C82C49
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad228552355so207391666b.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324693; x=1747929493;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ckvUKDdvQ0dFN54BMhDZUtFdcgxz09YjO+z08pvlBOQ=;
 b=GeH4gzLv6lpBs+FaFwYEcCy/X6HyPs7Tn0UsyiqaUBqOOM8T1/e2UZqPxKS5oDbqlY
 A0Vv6ibx6cgTzyyNUbgpChjHTJnTzsU0fplMcIvtutIOD8SzRpf0vAhhvJAysIWeTTmg
 xfzUwy9mSZvW6FJSmXJIObKV1oy6HcoNVa/VS9YrG6RDd0yYD5DwjSGTj0Uxj/Fd9rps
 5UnixOgEIZ2QPOO8CZd3+Mwl7+ac7+N45qaBheHrEsckCe1QkSKEtEjE7WOW4BCi3UgN
 1E7VZbOX2YHDNduy/866qLAIlmoB6BihF782rcLQJw1a2mIrBaGHzXGnobsZp/30y0NH
 W0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324693; x=1747929493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckvUKDdvQ0dFN54BMhDZUtFdcgxz09YjO+z08pvlBOQ=;
 b=fHb0HKGqdOFhfPqH4EfikEoM0Pz6yk9wHmzXIyUCILbvMTdfu6GCX57YuxzJEjskCt
 C4kc30470XQOybFM0U2YguBtUmyG++Ktd3i364/3lFsBSb9VxG6c6YG97f7opPbslMhC
 97gNCsaKMijP6Ov0IHRys+0HZsE4SEc8fDxRN9KAd5VPFEATneqr7b3WyghmgvovZfgk
 3IeaOOi/F2B3OsFaUN9G9bTjZW2UY+Vjjf1+8Drr8FWECPjfKVkb5qnhAuCflgSEDmyc
 d5kT3othNqtQhtEGxuZXLkF6hs/txpIWwvUx9HMzrSNyTXOC2AFT8+tib1rx/HZVnNJ6
 MaWg==
X-Gm-Message-State: AOJu0YxAxRDooQq+ss1pQ3vC3iij+bvArWOdSYy20Qn+Ol840HIMj9XS
 D6J60D41Hz0I4wCDVDOaqy+hlsUZBVPdMp14rZ6h7fd06YGHbDwwVoz1WNJxrjfg7T8=
X-Gm-Gg: ASbGnctkSznkYfGKlAfoYfpYSiuwQAJuPKmTANOl9QNmvf3qvqqU0MPw483TNksb5LM
 l6EG8+U5TBk6nWgqtaldM4K8eQo/uKeS/XvidTh6XhLUxCtmiOvJH6nU75d4/F8PCFDMDwIW/xm
 WKjWl3/2wUh6XBscShaeZ8Q4rQLb+MVhcREsJ1WqPrZECtiGKsWNb2QeXw3pNKYAZ0H/AC7Tcj/
 FlgXYd/72EnIMR2Dq18n/aHqAZUa4tpa60c93iGfjZ9wsOUnCtB4RPKAbpa6CiZOSboHRR9Bp+4
 hFfKahptB9fOz8hbzyacahJtwem41mY3ddd4LylPu39vhGLow/1S3ufic6Zn7n4Z
X-Google-Smtp-Source: AGHT+IHRi5mETv41XJaGIpZEGiyR8SG/tffYHZJIEcZ92DRXC7evS4zeBO0ol5sf46yM3nl9QL/gQw==
X-Received: by 2002:a17:907:7210:b0:ad2:3f9a:64a5 with SMTP id
 a640c23a62f3a-ad52d5a847bmr23103266b.41.1747324693246; 
 Thu, 15 May 2025 08:58:13 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:12 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Thu, 15 May 2025 17:55:45 +0200
Subject: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
In-Reply-To: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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
Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
to avoid compilation errors.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 include/debug_uart.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/debug_uart.h b/include/debug_uart.h
index 714b369e6fed..4526dca24ac6 100644
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
@@ -197,4 +199,17 @@ void printdec(unsigned int value);
 		_DEBUG_UART_ANNOUNCE \
 	} \
 
+#else
+
+#define DEBUG_UART_FUNCS
+
+#define printch(ch) (void)(ch)
+#define printascii(str) (void)(str)
+#define printhex2(value) (void)(value)
+#define printhex4(value) (void)(value)
+#define printhex8(value) (void)(value)
+#define printdec(value) (void)(value)
+
+#endif
+
 #endif

-- 
2.43.0

