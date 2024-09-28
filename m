Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A6FCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094D688E0C;
	Sat, 28 Sep 2024 22:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AV9JsEmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B2D88CB8; Sat, 28 Sep 2024 22:01:26 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E75B88B23
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a1f1ef7550so15933685ab.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553682; x=1728158482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4wpv3aF4s4BmvGpn2h0tB0lYY45u16KmBZDEqIiAnw=;
 b=AV9JsEmF8BjpIuEYN0QbRnekhpbklVjMF4+KGWEXtqDlHB/pgBkTwYsFdiW5/FVnRa
 XJ1LBE0YQLkBruG4VWkvt+o5hs3Cp+WmvJqmjDjXqbMub9vtm/dqqmh0cEioyNBUpg10
 ge/FE5SKNWyfw5M7K/ZCy5Rz85sSRW3snAxsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553682; x=1728158482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4wpv3aF4s4BmvGpn2h0tB0lYY45u16KmBZDEqIiAnw=;
 b=ef57p6JWUdwJzN0kYKsiN+X5+Z/sJLSs0RLo9/qRiW19PDC3/oO2+/+vufTgh8jH+x
 7vh+AeRMSABJr7HcIhVknXdBx1HeP0BeuoyIoPPFnvxWpXa5NoESwQhpM332I3NuLach
 DFM0g9B1i1vBv6uWVf+Bs0TyDQZ2iazKIQoVPrDoLhGxsMrOPK4ZSMW6QZYwlDGj1eef
 mQQpm8kZAdpi3/tzhakwFwyKPIqYmpX7t1pRSwcSYh8c0n6TgJgk5SLUs/LPK/N4J8c2
 jRL17ktxnSWfULVCTzkjbGbPjPfMb+V/A936vymRhPRrD9LNz2DN2/o2LptZ83G4oixZ
 SEHw==
X-Gm-Message-State: AOJu0Yxfm/i/m5EC7bqkZsNgnBfQjb/C4XB5mjgIaEsOnqurOSNsKkuT
 ZfUCyl/Az0UjrW3Wx+DXjbYy8gmo7Pi48SzztwXlz5Os/E5GfbK/pqYAZobRCxaLzW3YE3NyXZq
 hPQ==
X-Google-Smtp-Source: AGHT+IG0LmFQFSe6Lh8aYmljQArHgqP9w38Nxcjnjv9xho/O+aJuZrnbfLaIzDE7Ju00qo8Uj8uWZA==
X-Received: by 2002:a05:6e02:170e:b0:3a0:a71b:75ee with SMTP id
 e9e14a558f8ab-3a3451bc0b1mr67271465ab.19.1727553681715; 
 Sat, 28 Sep 2024 13:01:21 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 30/30] doc: Update init docs for the xPL changes
Date: Sat, 28 Sep 2024 14:00:30 -0600
Message-Id: <20240928200030.194546-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Update the documentation here to cover the meaning of xPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop patches not stricly necessary for the conversion
- Update cover letter re code size
- Rebase to -next

 doc/develop/init.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/doc/develop/init.rst b/doc/develop/init.rst
index 2955d9bdbc3..ce985781bb4 100644
--- a/doc/develop/init.rst
+++ b/doc/develop/init.rst
@@ -4,15 +4,16 @@ Board Initialisation Flow
 -------------------------
 
 This is the intended start-up flow for boards. This should apply for both
-SPL and U-Boot proper (i.e. they both follow the same rules).
+xPL and U-Boot proper (i.e. they both follow the same rules).
 
-Note: "SPL" stands for "Secondary Program Loader," which is explained in
-more detail later in this file.
+Note: "xPL" stands for "any Program Loader", including SPL (Secondary
+Program Loader), TPL (Tertiary Program Loader) and VPL (Verifying Program
+Loader). The boot sequence is TPL->VPL->SPL->U-Boot proper
 
-At present, SPL mostly uses a separate code path, but the function names
+At present, xPL mostly uses a separate code path, but the function names
 and roles of each function are the same. Some boards or architectures
 may not conform to this.  At least most ARM boards which use
-CONFIG_SPL_FRAMEWORK conform to this.
+CONFIG_xPL_FRAMEWORK conform to this.
 
 Execution typically starts with an architecture-specific (and possibly
 CPU-specific) start.S file, such as:
@@ -48,7 +49,7 @@ board_init_f()
 
 Non-xPL-specific notes:
 
-    - dram_init() is called to set up DRAM. If already done in SPL this
+    - dram_init() is called to set up DRAM. If already done in xPL this
       can do nothing
 
 xPL-specific notes:
@@ -68,9 +69,9 @@ xPL-specific notes:
     - must return normally from this function (don't call board_init_r()
       directly)
 
-Here the BSS is cleared. For SPL, if CONFIG_SPL_STACK_R is defined, then at
+Here the BSS is cleared. For xPL, if CONFIG_xPL_STACK_R is defined, then at
 this point the stack and global_data are relocated to below
-CONFIG_SPL_STACK_R_ADDR. For non-SPL, U-Boot is relocated to run at the top of
+CONFIG_xPL_STACK_R_ADDR. For non-xPL, U-Boot is relocated to run at the top of
 memory.
 
 board_init_r()
@@ -82,11 +83,11 @@ board_init_r()
     - BSS is available, all static/global variables can be used
     - execution eventually continues to main_loop()
 
-Non-SPL-specific notes:
+Non-xPL-specific notes:
 
     - U-Boot is relocated to the top of memory and is now running from
       there.
 
-SPL-specific notes:
+xPL-specific notes:
 
-    - stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
+    - stack is optionally in SDRAM, if CONFIG_xPL_STACK_R is defined
-- 
2.34.1

