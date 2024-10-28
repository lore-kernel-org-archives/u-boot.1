Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF76D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47CDA89100;
	Mon, 28 Oct 2024 13:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eJ6/jXNN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9176989102; Mon, 28 Oct 2024 13:41:56 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F22C89110
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a2209bd7fso634582066b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119313; x=1730724113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDdUD6IaH8CqgixQJok1Ra8m4cKzvFFtOa2zUo8orfo=;
 b=eJ6/jXNNSrQnh9GLcDFeGAZdI7qg13pcMEJX8yuwawBjW14+MVnDw1/QsmJO1Rhem/
 scbl/v8sDq2ys6i5aurntpadCXkJIbiKaaK6xHc1DejtPhYimy79J9OwECGvJjFbadCL
 rHAlt1EV16q9Z3REAgK52eA0N66HMtObefa2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119313; x=1730724113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDdUD6IaH8CqgixQJok1Ra8m4cKzvFFtOa2zUo8orfo=;
 b=UIebuRgyYLesO9eYleprIJEFqipaZCabzQ/OW329kbleJFrXO6USOcIcPxWC4QDK2R
 QrzuRIcP2Ur9eA/zuIiWg/5dikZ0kkfdMQhDJvisBHKGj9hLpPrcIXKNpCTocQ6YbhrC
 S0NAhpXjLIOPJXiV7YNB7X/ttjLfA0KrCDCtQFyPlFqYSN6sA44LeuhuZlAP1jCpTxGK
 XTyKp/6QwMERZvLxK47c9yfJ4c9l+JpHe5Oifzcwr4gmipCMjhMo5BQnut7F9RzkvaKT
 AoYc+bq5qH0mKKgn/+q8rGyGfpcLvofFN1I9cQ8Oez4x8bJhPYI31bm2v78MR+jo2BOc
 vJ+g==
X-Gm-Message-State: AOJu0YwcsNx3zqZopbVsX/kcG9p8W2cDU/dixgzVy8A0wMNsq8huSGpZ
 cwl+Kgf85wpIKJbs2IWT9DOPyLsH/VfkjVlb/GNkV7flrRi912IiMm5g61cN+yVIcDSz8sWowSV
 vbw==
X-Google-Smtp-Source: AGHT+IGhIIG308eZ5JweLoavrzYJx8ua4mt84TACLTWiWzGlnPd3Rye/mSXGvX91+o6UMY+ZzCnrqw==
X-Received: by 2002:a17:907:60d6:b0:a99:fb10:1269 with SMTP id
 a640c23a62f3a-a9de5ce4ad3mr822151266b.17.1730119313502; 
 Mon, 28 Oct 2024 05:41:53 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/21] test: Move print_ut test into common
Date: Mon, 28 Oct 2024 13:41:16 +0100
Message-ID: <20241028124130.32072-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the common/
directory, to match its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile                       | 1 -
 test/common/Makefile                | 1 +
 test/{print_ut.c => common/print.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{print_ut.c => common/print.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 4366e495a15..9f19bfa472b 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_$(XPL_)CMDLINE) += print_ut.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
diff --git a/test/common/Makefile b/test/common/Makefile
index b6bff9201ec..53c4f16164d 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -7,3 +7,4 @@ endif
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += print.o
diff --git a/test/print_ut.c b/test/common/print.c
similarity index 100%
rename from test/print_ut.c
rename to test/common/print.c
-- 
2.43.0

