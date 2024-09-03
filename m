Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75232CD3448
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D425C88C21;
	Tue,  3 Sep 2024 18:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="lEuVux2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B33A88C41; Tue,  3 Sep 2024 18:39:25 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3341388C1D
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f504652853so62872291fa.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381562; x=1725986362;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnZzDc4/9a/iuPUn1krXpYeqtkUN/a6IHTxZ/sOs+o4=;
 b=lEuVux2o9lwuAjMbrxewSF+l2wf0D6qFFAOwNlsi2J09e60AN/AS0o27mOZB6/O6Ks
 +DLeBB26J7ME7s52/slGbZ0NK6YcUJjnp3i8rpNRf2itPDweaOpR+j/nwi3O7Gbc+LKx
 Q9B7BGZMmrthSGNGJ+6iRqbImD+r6LZ6Xt707cmUhliIcYhyJGXun/H/F1xJ9/TUYzBo
 EPNI8CTSs6IxgQbb/laB6Ail5atZ1D/S6RA7WLi09UbqoEXSBcF5hVj1rE+ZTMr87tY4
 +SbAe/GNLuKgQ5RBmCee3jVYA+RhJphI1T6P0qq+ZJvj8byDcGtgvm7q1eA3m8SboxDO
 bqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381562; x=1725986362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnZzDc4/9a/iuPUn1krXpYeqtkUN/a6IHTxZ/sOs+o4=;
 b=Z3ttf6Yqx9uZdZ8iStBfvjdduzw9koT8yWNQVfX8ogKobsi5SIeEvo4Gf3yWpxn5kO
 0UySppN7gs8wYOAVygYy9uhcA4ULOxrMuaqtkviCNLffs6D7W3/iK1tlFazzc+Fc3V6u
 v8Jd0I1yrGN+8Ztkpzp2KfPS84fqMxQNLIrCW8PUYMbsWrw/pvuuLOXLQ/JF9E1rwfbZ
 kR2Og/6A7oE6zzwltsycYOktbsCanjbhtzMGty+3/nkVPmIMFW4q+GrPf8b68Cr8BrjB
 HRq7DDbvoPAwbt9xDjadn6nXVJa6iTXHOD7lihFWTfUtrvn08hc97DdzRj9PIvn1bYTk
 5szg==
X-Gm-Message-State: AOJu0Ywe/AZYUfe3sie2UqkAWbxC/buMDjEpxUN/YD4sSjZldaf9Satm
 XO3iDuyZ44SMe3h0yOnoOliu1QigPOxe9nOJzpXMJ2KmwcACJfbZmvWQCwE5tMaokgU3pVqs6S7
 R
X-Google-Smtp-Source: AGHT+IHovVCz+pzzUBCzJ+cLQMem7gvGEq7d4LHCPBnmAHr5HkSHwPlEqK0sBPPx6EWFRTbERdw95Q==
X-Received: by 2002:a2e:bc0c:0:b0:2ef:2e1c:79b5 with SMTP id
 38308e7fff4ca-2f61e03460amr118222181fa.14.1725381562021; 
 Tue, 03 Sep 2024 09:39:22 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:39:21 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 1/5] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
Date: Tue,  3 Sep 2024 18:38:54 +0200
Message-ID: <20240903163858.1155218-2-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

