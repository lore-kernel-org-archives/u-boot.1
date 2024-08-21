Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F7CC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B446C88E5B;
	Wed, 21 Aug 2024 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KaS+xmcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07DC88E82; Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF2D88E6C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7095bfd6346so4121849a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257201; x=1724862001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoT+ejXC+bHGjP7EcSc1JQZdsvxt2mf5sMyF0m/2Xtw=;
 b=KaS+xmcCt5r0pLBTPibKKwjpAzhIrDq66qmJO/CwFFVp+8/1CFoSwAxBQCfxqPfcBx
 tXBWfwMKWW7D+rfT00e3cu6m6nS1tHFLz56LyzcJqTcO2cb3932PZdO6wjIf+3WJWoA/
 5EWt1JvbI0qrevaDPjgdE1UipCsZVoxwj79FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257201; x=1724862001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoT+ejXC+bHGjP7EcSc1JQZdsvxt2mf5sMyF0m/2Xtw=;
 b=anbwWCmRL6H1U2nr0p8/YtklDdw6/h5i39Q3pCdem7RinOS2ULeFf0FnxJPUIaNIH7
 CVOpB2BAPht5gUqY/OVce+EYRZUYCqvqEUMF9/1rprCkAptNdGXS2zcMIIT9709HopOD
 oHs77mrxIj7xJEOMrZZ6yvEKHLe4MFNsYipYcHZ1Hew24L/CJYncCGtVecdR7rEFjEUm
 1lB6jEw6JMt1L8SmSbCQuKon216gTOEytAhWOT6aTXBAR9c5eG5Zm/eBUqfgXQWXCCxv
 XfsFUNlyy4TsmsWFHqnv4j3XfJnzTEvDHOOFWO1Z4Floq6l5GgmSOphyR4okRmKR4D6N
 D8/g==
X-Gm-Message-State: AOJu0YzGLzfJfIAe++v1rjmreCu+i8FDxMaTRv4QHkOF2M7t+7L1KbdR
 lrDvlIVuFrW50/64Kr0dJ+jX5VxAYKr0EMmYmXTGiiDu+E8Xl22OL0sh89SgaC2w44uP2/DxS7M
 =
X-Google-Smtp-Source: AGHT+IHC8+zOOSthLMlLVRuDBUgMxA6XHMz+7Mna80MGdYRd8JKMH9ZJdNdq5IChIU+8XlsbdEYxug==
X-Received: by 2002:a05:6830:4890:b0:703:6477:460a with SMTP id
 46e09a7af769-70df888f77emr2735387a34.29.1724257201457; 
 Wed, 21 Aug 2024 09:20:01 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 28/35] global_data: Move env_addr field higher
Date: Wed, 21 Aug 2024 10:19:20 -0600
Message-Id: <20240821161927.695717-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Move this field to be with others of the same alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 3588e1eee5b..3296813e86a 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -59,6 +59,13 @@ struct global_data {
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
 	unsigned long cpu_clk;
+	/**
+	 * @env_addr: address of environment structure
+	 *
+	 * @env_addr contains the address of the structure holding the
+	 * environment variables.
+	 */
+	unsigned long env_addr;
 	/**
 	 * @bus_clk: platform clock rate in Hz
 	 */
@@ -75,13 +82,6 @@ struct global_data {
 	 * @baudrate: baud rate of the serial interface
 	 */
 	unsigned int baudrate;
-	/**
-	 * @env_addr: address of environment structure
-	 *
-	 * @env_addr contains the address of the structure holding the
-	 * environment variables.
-	 */
-	unsigned long env_addr;
 	/**
 	 * @env_has_init: bit mask indicating environment locations
 	 *
-- 
2.34.1

