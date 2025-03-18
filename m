Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0550BC28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F51C81A0E;
	Tue, 18 Mar 2025 16:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XMqMXJM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6DB8129F; Tue, 18 Mar 2025 16:21:14 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2FD81951
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so23745945e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311271; x=1742916071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPGRsiinnBNBY+hfFMilDO64f6mRmt+Qn/aLXj9hP6w=;
 b=XMqMXJM4jLYgpi9aE1FwCd9URq7AhuQ3z2Chyh3kqABZuJ5WW1bnpzS5yk58FxKu0k
 3wD01t+6uuhcW5vV43bQFKqIDCg4xCt4oiKb+Pb1OXMrmnEcZbvLMrLK2QzXme1XANGs
 WufRey+IB0S4HiUB97/HXuXsTDPU0nCyAUPUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311271; x=1742916071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPGRsiinnBNBY+hfFMilDO64f6mRmt+Qn/aLXj9hP6w=;
 b=gKZumqZj3X2uM+qDkSvljRk9XOqN7gTrU/CIdK09G7cHoYLoq+KOd8gUmeYPjgBefu
 aUFGqnP72pcwqdK773UFiJRu5VnyTfv9FleVsd2fPhC8muMdgdkQJYLc8MSOdDdF7L59
 muiLJwdGyRladcxM3W8eTQviU6qmov9Z7H67XA0lHokEHvuPmRXJHpg8WFIxNu4fCi+n
 d3e0rGqTO1Uk1IeMVIpL7SdDzEGkuD62BEENUf7N6+xQUpzChzXlH3dnVgeK4Eums9Pe
 UrRvhltt89GqizxWHJM4+TR4vlJwgJqhUHCZtXyZKRfE4UJwWDzdjmywKmZbKESDHY8w
 /Kiw==
X-Gm-Message-State: AOJu0YxVVlvcuQzqL3R7irLI14OXDggd5/mTbwAV7xA0s6qmShXfp9HB
 iNLXDaH5EIEgoq3RIMMu/ydxYLRIVK5RWNsqTT+UR0ybcBw6xzJcec4Iod9OU3DVkozX+Zoe+FE
 ltqYg
X-Gm-Gg: ASbGncvVG92Sb0CLz735oFVxfpoqrZ25W72Bem8ipOVD+Kt8T4C/OTD9VI1lDriw+Hh
 +/nMKH8IBhrFEzbBoVbWNlCzSdWgIIg82NBR3LiimqVQmITCA5dxJGw7ZsYiynSUsYvZOtXvgpT
 u75vMWELsLYKN53DUKwLLbmSqWlpNzCZBEwPwpeY3squ8+O7f6yPDa+vpLf7qKtxZcBifpimJVH
 KX9aprG4pVVT2LkXMjRjKOJZ23lFlQd8PcHUO7Qn/aZLlhlv3XRxsyIXY+PRkgSVjtTrph5dpSg
 SLEfSiCSOiJ0vX7Pi8mwa4zSSOuLJKF8sKr9rphqIg==
X-Google-Smtp-Source: AGHT+IHNfOo0/EjEFUeSJrGJjt3VSuRXROJcOrruduBUA7NB4gwJJtU1nKMAs6pe83AVy3cBudfo6Q==
X-Received: by 2002:a05:600c:1d2a:b0:43d:1c3:cb2e with SMTP id
 5b1f17b1804b1-43d3b9a4268mr32455625e9.17.1742311270890; 
 Tue, 18 Mar 2025 08:21:10 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/7] membuff: Rename the files to membuf
Date: Tue, 18 Mar 2025 16:20:43 +0100
Message-ID: <20250318152059.1464369-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

(no changes since v1)

 MAINTAINERS                       | 7 +++++++
 include/asm-generic/global_data.h | 2 +-
 include/{membuff.h => membuf.h}   | 0
 lib/Makefile                      | 2 +-
 lib/{membuff.c => membuf.c}       | 2 +-
 5 files changed, 10 insertions(+), 3 deletions(-)
 rename include/{membuff.h => membuf.h} (100%)
 rename lib/{membuff.c => membuf.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92d4a158fd0..fac9ce81d70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1281,6 +1281,13 @@ T:	git git://github.com/ARM-software/u-boot.git
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
index 789adf2c3f9..18d94592b03 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -23,7 +23,7 @@
 #include <board_f.h>
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
index a30ce1595d5..41de2671cc6 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -125,7 +125,7 @@ obj-y += hang.o
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
2.43.0

