Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6EDD3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF54A891B0;
	Fri, 18 Oct 2024 05:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A4zvb73I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D77891A5; Fri, 18 Oct 2024 05:00:54 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409C4891A2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83aba5e162bso10273239f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220449; x=1729825249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEqFsKYoSLCwSd/fFH6G8QL5GlWcicivgLCogXaH7V8=;
 b=A4zvb73IHBDUBxRtGgOwQ7PqWs8EuLzpAlnGJ9DcHDU4s4bI3i2mEEtnfwRc72yiwa
 PYVTlqFJT1Nqsnii+TP9oKYEb0vRuae/6oyW0P7KYFVEA3B3ZJwNmjT/eV1ij9K5kMOH
 71e9m7bCQaAmWTBQQ+UCjqhdaD9ZD/G77/36o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220449; x=1729825249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEqFsKYoSLCwSd/fFH6G8QL5GlWcicivgLCogXaH7V8=;
 b=enHqJ+n6hNz4oYlg0I8SzZHEx4N3gEhsVKTCCenJADE61MOv+I8uTR/W9Lz+pGB1vZ
 TCyHTb72p2MoJFFkivZZuz5zF4R7lkWM1NnHlTp7T+VeRvLw0v+GCK6mF8BWtKazOLHc
 iD8ZSkjI+z8zx9F5MOh6Gnn91r/CPskzW65CaVI0m/nbrqrlg2pVc4iYi2QNO5wyLSJk
 TDYptXkqfFP7Tq+ZHIrotRVvLVIBYJuQWEAIJDeWNx1tpmkUToR5ICG1jkkFAYTJzi/d
 G72Rklku9vTGqRQml/63wO+0omsDmohdmNq1CHNOQfi9NpsEhLW4EGaO+w074vtKnuP+
 bmpQ==
X-Gm-Message-State: AOJu0Yye+BogyEtGTHf5xy6O6CrfEQoyRLyIkkGU0K9OO2y/pamcSjye
 fsNJoTBUljDAAuKieaz88gkzAoOE3+ETTSW5MAMijnFs+5EILAIJgc0e3XWUdMjLODu0sAyp/kY
 =
X-Google-Smtp-Source: AGHT+IEyNjupa3faGzPb5aYDzTcK7v30+xfo7G/yUt/UhMlQuOAsVt9toI63WZG0BxE8smipHbvFjA==
X-Received: by 2002:a05:6602:6d14:b0:82d:16fa:52dd with SMTP id
 ca18e2360f4ac-83aba5efff8mr85802039f.7.1729220448860; 
 Thu, 17 Oct 2024 20:00:48 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] membuff: Rename the files to membuf
Date: Thu, 17 Oct 2024 21:00:21 -0600
Message-Id: <20241018030027.842749-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

Rename the C and header files to use the membuf basename, to match the
functions.

Add a MAINTAINERS entry while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                       | 7 +++++++
 include/asm-generic/global_data.h | 2 +-
 include/{membuff.h => membuf.h}   | 0
 lib/Makefile                      | 2 +-
 lib/{membuff.c => membuf.c}       | 2 +-
 5 files changed, 10 insertions(+), 3 deletions(-)
 rename include/{membuff.h => membuf.h} (100%)
 rename lib/{membuff.c => membuf.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index eef63530f68..7e12fc82a63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1242,6 +1242,13 @@ T:	git git://github.com/ARM-software/u-boot.git
 F:	drivers/video/mali_dp.c
 F:	drivers/i2c/i2c-versatile.c
 
+MEMBUF
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	include/membuf.h
+F:	lib/membuf.c
+
 MICROBLAZE
 M:	Michal Simek <monstr@monstr.eu>
 S:	Maintained
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 644a0d77873..cc87d0037f0 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -24,7 +24,7 @@
 #include <cyclic.h>
 #include <event_internal.h>
 #include <fdtdec.h>
-#include <membuff.h>
+#include <membuf.h>
 #include <linux/list.h>
 #include <linux/build_bug.h>
 #include <asm-offsets.h>
diff --git a/include/membuff.h b/include/membuf.h
similarity index 100%
rename from include/membuff.h
rename to include/membuf.h
diff --git a/lib/Makefile b/lib/Makefile
index dbcfa87ebd6..57cc4b0bdc8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -124,7 +124,7 @@ obj-y += hang.o
 obj-y += linux_compat.o
 obj-y += linux_string.o
 obj-$(CONFIG_$(PHASE_)LMB) += lmb.o
-obj-y += membuff.o
+obj-y += membuf.o
 obj-$(CONFIG_REGEX) += slre.o
 obj-y += string.o
 obj-y += tables_csum.o
diff --git a/lib/membuff.c b/lib/membuf.c
similarity index 99%
rename from lib/membuff.c
rename to lib/membuf.c
index 435d12b8a3c..5473efa98ca 100644
--- a/lib/membuff.c
+++ b/lib/membuf.c
@@ -9,7 +9,7 @@
 #include <errno.h>
 #include <log.h>
 #include <malloc.h>
-#include "membuff.h"
+#include "membuf.h"
 
 void membuf_purge(struct membuff *mb)
 {
-- 
2.34.1

