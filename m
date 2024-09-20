Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC16CF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7608893D9;
	Fri, 20 Sep 2024 09:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uzjbf1bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50C5893C6; Fri, 20 Sep 2024 09:25:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A2E4893D1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso14852605e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817114; x=1727421914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZBPM2XQxBdGTxjB4IkB4Nr9qxPkuDIsCjn3rEuh5lY=;
 b=Uzjbf1blND4M3Z+f5TP28R0LLsV7mmVGVSABqa1NjJXlj90aEgVO6jE7XRbKEtx4m4
 10Z9WQQ22Xeae64zOwSnnQZXuBOqLkRPBuchBOf3usMQFiA+H8t0AWkLoGmThHP+xPku
 A+jHexllNyntz015ps7+zNnVtIsYA1osk7Yw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817114; x=1727421914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZBPM2XQxBdGTxjB4IkB4Nr9qxPkuDIsCjn3rEuh5lY=;
 b=uEfPwreyKr+jHfMGE/4GDFWZNY1ulCCE9BHrcjoSr4rKb4s5Z06vDGvJirt3KKeESq
 Wu4a1SN8Ff+PBZjBx+ihH3cFz/OSSJ8yi+6qzQj+qJaZSN9nAiv+99yGAaFAf42yfa2K
 YGgnB0gOEfB7TO2n8hzXy4nyRPnkiBLod0AZBEvsWwkQPdTj801ZsAYIU2Aqx1AThHMt
 FQ4oCywnd+F/w0/4rVHdD0bRTWdOiOVbGPP1k/atvDED6EInX7waDukGXO6v8XlPQNSn
 rq/xmvc3hgRIZC8HjDDBJ67DlUwMLLNQhHAaAjPV+QU6+elf2mcbu+a26tzKf5yIkKYk
 tCqA==
X-Gm-Message-State: AOJu0YzCISB0SXKZCV3iAYkaKQIj05o5LcupTAjIPokQ5Id2t2zgGGV6
 KZ18nlUTwEPPdmtvMWGSaDGtDmLTktFrGO2Wg6eCX6hUaKlsRtqHrOIku79xqEvFD3dqF5cUfXb
 XAqP7
X-Google-Smtp-Source: AGHT+IF49l7Hwx7/7FjUbmE0hFuZ2JP9R0gZn5rUDgqtnxFYcSzROnjUfoKiEMn8osuVlKmatELwjQ==
X-Received: by 2002:a05:600c:1d98:b0:42c:bf94:f9a6 with SMTP id
 5b1f17b1804b1-42e7ad92602mr13135235e9.26.1726817113645; 
 Fri, 20 Sep 2024 00:25:13 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/18] arm: Fix up a stale comment in sections.c
Date: Fri, 20 Sep 2024 09:24:35 +0200
Message-ID: <20240920072444.134997-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

There are currently four symbols here, so drop the word 'two'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/sections.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 07efabaa7dc..8955aa6111c 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 
 /**
- * These two symbols are declared in a C file so that the linker
+ * These symbols are declared in a C file so that the linker
  * uses R_ARM_RELATIVE relocation, rather than the R_ARM_ABS32 one
  * it would use if the symbols were defined in the linker file.
  * Using only R_ARM_RELATIVE relocation ensures that references to
-- 
2.43.0

