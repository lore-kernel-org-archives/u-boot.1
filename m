Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A3DC54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A6387EC4;
	Sat,  2 Mar 2024 23:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YBeleUHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A24F87EB4; Sat,  2 Mar 2024 23:01:20 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B288187D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e12bcf6adso973737f8f.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 14:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709416877; x=1710021677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsndbrMadB8ds6vftsC1RVM22BmewswFr649wt8st/Y=;
 b=YBeleUHuSk9S922z7vRYrdwuEIl8moUkqxeytJOuUWArEGkjwm4NqqAJSc1uCCrsN6
 vl+zqDZ2aOc+2H0EmV/AqSxIUPECBmapMmZTFL/8A0Td6gbrBJcqkIoJIGSq/3lqhODN
 dSAJrauE8CnyWpB3cG2LHVnIFXaZjjX0cI72mA1Xf8yBgmLZOX2iUPExFk6az84Tnv3Z
 aVG4qE395iQqgsKHK2Gj7X44TVTRRN+B42sUOPZhPU6/6tRgHmOu+VK18J08yaZ7lT+d
 mf9RlRy9evXw/q0+QePswqecqaRm2QKR+AcYEW+Vfn3+wXenIDeJJ79YAeHi2gr3pEFa
 6oLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709416877; x=1710021677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsndbrMadB8ds6vftsC1RVM22BmewswFr649wt8st/Y=;
 b=jU78JQ/Fp431/WVA9clmFywV/q2KSHKm0H4oIdiX/QIQjMBJiwxa3oyu692Lffn+DI
 6Ebq9NYTHSFSwzaRo21OiyXjiV2HUreYncBQmWuDVB6Y1L0KFaE89ySJ28TGXi8QtPOk
 HAzjh4ICEJTMJwciztxE1lBP2RtMtJE/SEhfuU3J5pn76dDR7XlBNhhW7Xt1zAEVad2l
 20QiCfTBpuG6Yz6KRT8WOo45IAgPzsfl8PlIhhVk7qgE93eS1yCRzPTXzwJcv2NVhusc
 b4OB9SkZh/v6+iZCVHi/1Zy7u/9sxoq0rsCOHv/Tht+fpPj7DdJiTZiITwsBvN5z5A3E
 S+7A==
X-Gm-Message-State: AOJu0YxQsLOfkpZvKQK8VJqR3p8x1eCTONs36H+0Yw46y9NHCIhXOBlb
 7dJgnM2fwv3GuIAZoCkLnnfXgrRX45m4Ale4eWyoW63J3CrHGW60UHuynwAh
X-Google-Smtp-Source: AGHT+IGi+NwzzqVInlytvZ1depcwFAqy0fxtTi6iGuIqRguyggIy96790toqUhjGFKns+YXLClLC6Q==
X-Received: by 2002:a5d:42c1:0:b0:33e:527:e1a7 with SMTP id
 t1-20020a5d42c1000000b0033e0527e1a7mr3740848wrr.2.1709416877297; 
 Sat, 02 Mar 2024 14:01:17 -0800 (PST)
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 b8-20020a05600003c800b0033e17ff60e4sm6583393wrg.7.2024.03.02.14.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 14:01:15 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/5] tee: sandbox: fix spelling errors
Date: Sat,  2 Mar 2024 23:01:05 +0100
Message-Id: <20240302220108.720637-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302220108.720637-1-igor.opaniuk@gmail.com>
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
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

Fix spelling errors in comments.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Applied R-b tags

 drivers/tee/sandbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 86219a9bb1a..ec66401878c 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -14,7 +14,7 @@
 #include "optee/optee_private.h"
 
 /*
- * The sandbox tee driver tries to emulate a generic Trusted Exectution
+ * The sandbox tee driver tries to emulate a generic Trusted Execution
  * Environment (TEE) with the Trusted Applications (TA) OPTEE_TA_AVB and
  * OPTEE_TA_RPC_TEST available.
  */
@@ -23,7 +23,7 @@ static const u32 pstorage_max = 16;
 /**
  * struct ta_entry - TA entries
  * @uuid:		UUID of an emulated TA
- * @open_session	Called when a session is openened to the TA
+ * @open_session	Called when a session is opened to the TA
  * @invoke_func		Called when a function in the TA is to be invoked
  *
  * This struct is used to register TAs in this sandbox emulation of a TEE.
@@ -140,8 +140,8 @@ static u32 pta_scp03_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			provisioned = true;
 
 		/*
-		 * Either way, we asume both operations succeeded and that
-		 * the communication channel has now been stablished
+		 * Either way, we assume both operations succeeded and that
+		 * the communication channel has now been established
 		 */
 
 		return TEE_SUCCESS;
-- 
2.34.1

