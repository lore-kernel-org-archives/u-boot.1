Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3797DCD98E7
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 125F484996;
	Tue, 16 Jun 2026 16:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="drzZCptM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B3084910; Tue, 16 Jun 2026 16:30:07 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CF88495B
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-486621f0adbso3126493b6e.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781620203; x=1782225003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff/E4IS5kJ1vnJ1F0CD+ygEM9QjyScKkov1ScAm7CU8=;
 b=drzZCptMW3RJnQgy/Fqe/5KXVS7nk324LCie2lExUWtkKvAaZv5IzEcUA7xyH0i2FK
 uRascWUvsMNSQoPOjWgHu39//aIH2a/QuDGWU8UYGoU5Ixe6Lca44youonJLV0y7IWyo
 fu7hHoAYMtIvRh342nvZPorXNb2scNLffrQ9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781620203; x=1782225003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ff/E4IS5kJ1vnJ1F0CD+ygEM9QjyScKkov1ScAm7CU8=;
 b=UGspoV30dqTtOT7Ce3UDN2sBEShIGS04szkSLKYfdFCOb4BaGrT13UAjInAt9xKnoA
 YP0NZj3ymv9opHZe7I55kMlViXSprJGKY2M+2NZERvk8Hy5xzMlHXug8JHa4bK6CcQ24
 iXAdcrzoO8BcwGUxsqxOLN7UIZt7WZ4KuYh96uUobiczEAqxqC+Or/rgTXvA+Hqt9meN
 4zaGAxPBiTX9Kd3LfcCVjaRBKFSgSWvtqKk3WKUTion1SNWubMS/hiLbb0M2kQqgsEnD
 icr+pKZC0Q5ai9SefZygH1w1Ob8xXBOu+6aGlT0/rN7wxXt7cLcdF6uA2E6uJGsunnc1
 lT2A==
X-Gm-Message-State: AOJu0YwQbOwgtE1OF/mWGaEVnm1pTU6QlVWFHz37FNjxdrvZtw+HIZEW
 122nK8rAxUiKC6APSleHIxoevC1jYk/cnQJL6KuhTif8pTmqa2OE3N9pjLK/xcQM27gh8ISdhR3
 FElE=
X-Gm-Gg: Acq92OFxorFNOoQX998z5RGfmqAE1gjzvLZzCb7FNSibbHXBDYd1vlgWY4YYnbRTnOD
 GOvrspAEXkUQR2sGMTCFH2HMbpK9qRUlMgFztXSgeXKuuwS7dlKUBdGErm5LFSUuBskqwZ4IX2F
 RlBtVrBTiqLgEOYZlfg0hR+92LPD/IDA8GC6/vU8Ls3lGB8KHxcMFnV7ebi2H+QXRmlKKyjr/D8
 pCtYPiyLA3+Q8vczFQbgsOh5gmPtb6GaeqGEcUdMCOK0rY4+2TDzn6vcSPjL5oifP/wL/zwij8L
 nSjZOp/AccXyGHSWd68rGxi7HQ9sglVqJ7jNVyDMWLMz1DebWSzhuVh3dVIgpUecEnOrqXMNi4H
 gZRCR7o+QbC2ply4KBY+RPKjSi29zxVlR08yQK3eVIlLLVuXplw4t5POJhgRfQowYpSTL8Phym8
 SGGaYOLmbUbLRGq4wNwQ==
X-Received: by 2002:a05:6808:11ca:b0:482:4df4:ef5 with SMTP id
 5614622812f47-4874195e753mr10407681b6e.3.1781620202269; 
 Tue, 16 Jun 2026 07:30:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f6fb5edsm7263749a34.26.2026.06.16.07.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:30:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, E Shattow <e@freeshell.de>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 9/9] test: Stop running the patman tests
Date: Tue, 16 Jun 2026 08:28:49 -0600
Message-ID: <20260616142859.54136-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142859.54136-1-sjg@chromium.org>
References: <20260616142859.54136-1-sjg@chromium.org>
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

The patman tests no longer exist in the tree, so drop them from the
test/run script (used by 'make tcheck' and friends) and from the
tools-testing example in the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/testing.rst | 2 +-
 test/run                | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/doc/develop/testing.rst b/doc/develop/testing.rst
index 3a2b496fa00..1d19b49e82c 100644
--- a/doc/develop/testing.rst
+++ b/doc/develop/testing.rst
@@ -22,7 +22,7 @@ the quick ones, type this::
 
     make qcheck
 
-It is also possible to run just the tests for tools (patman, binman, etc.).
+It is also possible to run just the tests for tools (binman, buildman, etc.).
 Such tests are included with those tools, i.e. no actual U-Boot unit tests are
 run. Type this::
 
diff --git a/test/run b/test/run
index 768b22577c4..7c0263713c6 100755
--- a/test/run
+++ b/test/run
@@ -80,7 +80,6 @@ export DTC=${DTC_DIR}/dtc
 TOOLS_DIR=build-sandbox_spl/tools
 
 run_test "binman" ./tools/binman/binman --toolpath ${TOOLS_DIR} test
-run_test "patman" ./tools/patman/patman test
 run_test "u_boot_pylib" ./tools/u_boot_pylib/u_boot_pylib
 
 run_test "buildman" ./tools/buildman/buildman -t ${skip}
-- 
2.43.0

