Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D8E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D85E8926F;
	Sat,  2 Nov 2024 20:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BHC8Jqd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44439892C6; Sat,  2 Nov 2024 20:37:47 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315A38860B
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ce3fc4e58bso18837026d6.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576263; x=1731181063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qj4mJVgHEAwv2y9TCpaRXkrlZfZ2D1Vlb5+d/m5u+w0=;
 b=BHC8Jqd24OZutj88QCLNNUmhKXG0O0UmuIV0lIATqCKVhVzvV+Em5/Tg1mqcJa1+BW
 moKe7dV+igNKCVQKpjCPSBQlMHntK0xhNwvyCN6ayXyKcbrsT61NffZccMKta1Ug40mS
 rcoV43SylNRDpnN5q3cWoqFLJUWfDj3RJq5MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576263; x=1731181063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qj4mJVgHEAwv2y9TCpaRXkrlZfZ2D1Vlb5+d/m5u+w0=;
 b=kjldXjWt0d9ROzj+PDKe6c9kXplpaNqA9+zfZqExNZuL4vqr5hupI5KiVY/52zpkx6
 Wz2ajRRi4pPifIS8sMFodfZ5AhdXaJe8Kncg8itXaBgHwpisds+92cfXHATbjBdbHupY
 LKQ48nOHsbJykp9bDxQ9y4pnkPHF+lnv5otAtbW2asaHkRTK5uIyexBLXG0aGXJjLEBq
 i09gg90E3Li5fZNZw4sxoHaOCainVVmofGzVAY35qAF+vvaKYfzzkyVsWnd864jYYmvD
 BRxwf8z1xg/VYlnJ6OiWdHPj0Mj61a4tibV9TW4ms3g6EANrls8E/dUaaCN6dzSU4JtD
 CK3A==
X-Gm-Message-State: AOJu0Yy57xhIM/V48JQNQY/gEtf1Q4sMT1NA+tFSnNlUB8MkCTXSVyAc
 m0JbFxIzAT5ZbZCy+sen0HdgUJGY1qW5vI/LI2o3JY1ppoV3lPfl1VpiABfZ5vsO0Vwa8kCnv2w
 MOY1R
X-Google-Smtp-Source: AGHT+IFHoZEAxwM2j3aPXtNnaIKYgeRQ0AsrfBtKAkgHIpKBqawxNLyn+kzdpxO/aPG09nYvxtwmig==
X-Received: by 2002:a05:6214:4283:b0:6cb:e860:eae6 with SMTP id
 6a1803df08f44-6d351a8e362mr177522656d6.5.1730576263152; 
 Sat, 02 Nov 2024 12:37:43 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/20] bootm: test: Move test into boot
Date: Sat,  2 Nov 2024 13:36:54 -0600
Message-ID: <20241102193715.432529-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the boot/
directory, to match its implementation.

This test is currently dependent on bloblist, but the real dependency is
on sandbox, so update that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Make the test dependent on sandbox

 test/Makefile           | 3 ---
 test/boot/Makefile      | 3 +++
 test/{ => boot}/bootm.c | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename test/{ => boot}/bootm.c (100%)

diff --git a/test/Makefile b/test/Makefile
index 48d8bc91ae6..4366e495a15 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -4,9 +4,6 @@
 
 obj-y += test-main.o
 
-ifneq ($(CONFIG_$(XPL_)BLOBLIST),)
-obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
-endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
 obj-y += dm/
diff --git a/test/boot/Makefile b/test/boot/Makefile
index d8eded20d4f..63487e8d29e 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_EXPO) += expo.o
 obj-$(CONFIG_CEDIT) += cedit.o
 endif
 
+ifdef CONFIG_SANDBOX
+obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
+endif
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 ifdef CONFIG_OF_LIVE
diff --git a/test/bootm.c b/test/boot/bootm.c
similarity index 100%
rename from test/bootm.c
rename to test/boot/bootm.c
-- 
2.43.0

