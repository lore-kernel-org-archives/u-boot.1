Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A482DC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD1A87FDC;
	Mon,  4 Mar 2024 18:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvsyZWgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399BC87F54; Mon,  4 Mar 2024 18:45:12 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C93876A9
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412e445aa25so409305e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574307; x=1710179107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LszvFO/XjqacKZUdm0FgJmdBhHglvTqFQhFQ+sydK2w=;
 b=lvsyZWgYTzc1VBhexQ04UHXHksIk3/3noonSfEMj2gU6oKlt2z2yd7r7YMftK695PO
 oho+cGV2NRZ91z2q7dCrZIsArS6yENZ1Cip3vF8csXJE7cZDwaGgV9dDYE86I7BFPPpn
 gV2EUvW5fO/0l5VqPWAEjeoUC6+2N/5yhiwl3YNMnPVGjOdxXlFox6a4OU1oFiH1KPmC
 fHj2f0dzFHgvBqMQLCTbdqWsER7leqJXTDeZpbbmLiOItHlg8UdBkFxgKaIGi4HO7AsP
 YHz9yOALflg1gIoCos6pff00MNdDIduArv6gAPrTE9nHPmPFCXOCyoCiFCEo2XvxkD8m
 18PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574307; x=1710179107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LszvFO/XjqacKZUdm0FgJmdBhHglvTqFQhFQ+sydK2w=;
 b=pKfETIVyIqq1ZoYvmCnKsk60lX0s7/OsbSm8XjpdnIaE9YmjvtX3Veuawf/pkmcf0F
 LN5LgharOJJ+3J15B0egfvL/77JVKlrzmbAZT9kUH8GWVHQXp+52GafRCkvff8vu58T3
 cUWFSZSdi89T0AUIlu0R5fvGtbw9PVTvX6Nc4Wbikcu5tbI5plptvylfpj39SRMPxx38
 V6etv4Qtu1tiLeKlOzwfwiExnnFaA5nxLnO2kU83VqZ6PYMhVslq3B4ymSjVsrH4Tk/t
 lh6fhNGvt7Wv4OL7RubZqpgyHzCMls51ezlPOxZa5Ua7hoE7DCqmR5WdsBQiSBFs6NMp
 SFvQ==
X-Gm-Message-State: AOJu0Yy4LlUMXeGajP9xL5xc6+EXrAspVT9Fldsv/yvP0TToK94pjU03
 NZQIJLHwovz4FthZo0OXLWxg6A/WUfie6hv+9l0rdNDAPtDeOUkVDBllKIx9LdE=
X-Google-Smtp-Source: AGHT+IHtiHn3SCEWnnQomZdsPnfsWVL+08QYFjr70+dA60nszcIjAvDnz/iYyWc8W+RGXuf79ERB9w==
X-Received: by 2002:a05:600c:3541:b0:412:c6c9:f329 with SMTP id
 i1-20020a05600c354100b00412c6c9f329mr7802246wmq.3.1709574306771; 
 Mon, 04 Mar 2024 09:45:06 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 jw21-20020a05600c575500b004126afe04f6sm18040902wmb.32.2024.03.04.09.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:05 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/6] tee: sandbox: fix spelling errors
Date: Mon,  4 Mar 2024 18:44:50 +0100
Message-Id: <20240304174454.1484507-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

(no changes since v2)

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

