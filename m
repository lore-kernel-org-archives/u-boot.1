Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC3C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217998755B;
	Sun, 12 Nov 2023 01:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZDrcmneB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C3386F8A; Sun, 12 Nov 2023 01:09:44 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDD286FB0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-359472f74c5so13727345ab.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747774; x=1700352574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znVNNm0EC71WZA70HbeaJsSneiRZb/CUZanApopr4xI=;
 b=ZDrcmneBPwoBOYO/VrG/Gv6VnrxD+jzzKYSvfkbbT29BMz9tUDXQSWJpQ20axo7XoS
 o2Y6x814aZwv+mV7qtnDVzu2moZdnSUvYIljHjJHv8Vwha5fbHKXJ8ITRb2x0LabZaei
 mngs4Fb6Qg5IUUgjhFuoMRcdE2lS7bdL9CI1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747774; x=1700352574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znVNNm0EC71WZA70HbeaJsSneiRZb/CUZanApopr4xI=;
 b=YOfwCxebnpjUrRPo1k/ZgdMqZmqbp+kx1foJUFSmsm1Kg65klOE4+CCE/ybgSRKYxX
 JnwGqcjhAXAaDFVakoQZ+o+rykWSg97LBGeNa9rLAy++ENCMyGmU78kvAWn0B8gE5sFA
 S1TtInIAr4B+iGF+sO3GNdzcQGipQaOr/vODu5ov0SC/9BB09/p52GtgK0F493PJAh2Q
 VDY3I9ZX7/MhZbg/Wm/lKB3R7FJgBYbJg0WUgFCCfGlIFfgT5XwohGsdBUTzevDzs1oY
 hSCgKV/aob2nVSda7JRltGlzH9L2rBfg9DJjPYaAKVnrCp1FQgYPXcdNG/khqQQyonrB
 QTww==
X-Gm-Message-State: AOJu0YzgIF54tGvoK2DeWDqiPeDIn1Wfw4KoEEegsf3odMn5y5+Mnprm
 BNzT2E+eeYdUASzYYHXlu6qHjTuwR1jn+aJXochwQQ==
X-Google-Smtp-Source: AGHT+IF7TRV8TDmbLdfW/EEOV1dV0KNRGQQSmBHwTUOTrENJ3eH11xUHbH06A6pgeJYBOtvJBekhaw==
X-Received: by 2002:a05:6e02:1bad:b0:35a:b399:555a with SMTP id
 n13-20020a056e021bad00b0035ab399555amr1369406ili.10.1699747774338; 
 Sat, 11 Nov 2023 16:09:34 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 04/29] bootstd: Add missing header file from bootdev.h
Date: Sat, 11 Nov 2023 17:08:49 -0700
Message-ID: <20231112000923.73568-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

Add a dm/uclass-id.h to the bootdev header file, since it uses
enum uclass_id

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/bootdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/bootdev.h b/include/bootdev.h
index b079a91b5b7f..c1362673d418 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -7,6 +7,7 @@
 #ifndef __bootdev_h
 #define __bootdev_h
 
+#include <dm/uclass-id.h>
 #include <linux/list.h>
 
 struct bootflow;
-- 
2.42.0.869.gea05f2083d-goog

