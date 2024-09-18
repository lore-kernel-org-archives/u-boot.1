Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A628CCD1A0
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF26888C35;
	Wed, 18 Sep 2024 15:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="d8iIrFdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C12188BEF; Wed, 18 Sep 2024 15:03:40 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C72E88C10
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so76323631fa.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726664617; x=1727269417;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7a7xq2xOWb+DHAzuU9dKnLwsF6Y3IW3tCXHkhH8VZj0=;
 b=d8iIrFdkB6ZgtJDfLRuuET+xjklExO4jB92nEik84aXna9wkOX3L4QXkCgVQIZl5Hg
 7kZXniPFw0LUtg9txkbU8ahrGoA5VGKF0G3JpNMU/aqC0Gw3KJ4OVnSbmdVHWgnaM5oq
 Jn5yihzEHC4wPC3fjo+ax6SL1cyqJeGTBTxoBNkxi1rKEe6LwnhwlK4TtNVp34F0/icZ
 qApmLTPkcXgLP0Ka14Vb++70hutoUC2lPDGIcvzuTOR6Lrm+OKJgcaHgMoSwqv6vE5o6
 Ih3nrNW6Mb/2OfMYGmuqiyoTFKEmMSR6VIUGldan7nKuUCZi37+paX/6MaUqVApr7DUt
 Xhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664617; x=1727269417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7a7xq2xOWb+DHAzuU9dKnLwsF6Y3IW3tCXHkhH8VZj0=;
 b=TQ7uL/g4eaznhgtXwaygdkiRlya1L5UMi2hQP+mQYjn32A3C7gTGHc+J0k8+2A9nfl
 cK/oqIgRMMmdtrdt2GeL95iP/IypHyNnmmP/gawaREyClAbinAA/qJssKMTGtdkwhE6U
 q4419kw/2KVyoZbC35SihaFkFfFzere9+ooNPmyoZ9B7fvbmawyRiaueXARAQG7Fh2Yf
 bYdSp3TGB2qSI1c4o8KbC39ZEWnJtbq5WptTNgihQ2L1B2Nvdg7Q71Fzpa8so5pEm6ok
 oUJ9z7ri0KDZUAmMPBs+6uPy6W0PVe3yravaILvWMGlviBQnHJVzabIkJPtkKdU160PG
 Sv0Q==
X-Gm-Message-State: AOJu0YybgrpxL54mu1ho8NAWXbHRlg/MKxo/9t5DkV98zJmOlM9UGJU6
 4t4MSxEHEXVxZuMDzOZvnHcTNAOeG7fpGIPcBVsbO3zQDlPantOMLdoRHbBIlVVldsMUKrvCIja
 0
X-Google-Smtp-Source: AGHT+IFZRaJhXee9IGVIcf9RC3QIIp9w/rce5BMY3H1XqFTAC48oW+bogdMP+kF3C7DMzoZgPyMDbw==
X-Received: by 2002:a05:651c:19a5:b0:2ee:52f4:266 with SMTP id
 38308e7fff4ca-2f7918e2615mr133076081fa.3.1726664617167; 
 Wed, 18 Sep 2024 06:03:37 -0700 (PDT)
Received: from localhost.localdomain (83-238-227-197.dynamic.inetia.pl.
 [83.238.227.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb495a8sm4885576a12.11.2024.09.18.06.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:03:36 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies if
 CONFIG_DEBUG_UART is not set
Date: Wed, 18 Sep 2024 15:01:52 +0200
Message-ID: <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
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

