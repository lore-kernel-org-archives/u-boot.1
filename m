Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29223E95A84
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 02:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48152864D4;
	Sun,  8 Oct 2023 04:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITLgq8dP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F5086550; Sun,  8 Oct 2023 04:02:37 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B449586496
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 04:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-65b2463d663so18246586d6.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696730519; x=1697335319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YSjvEQ5he5li9rsF12WCwfAn7VoDVxsmryxmLHUL6RE=;
 b=ITLgq8dPQGHYt66smp+8Lli7SAx9a8mfUlW90JffhvehcnH7RPxChmM7hz7LfOHJXJ
 x/uRwbdPj/glsx3MtJIm0MHGh1oM+L9hXKDR/RMblCHdoVxD15PZ9SykHHfOeUAYENUB
 enwN9vXc3lVOX6qthWYGfTFtSmBZxOptFPyPcnzo6hB5YPKFt471IfAAoHvbU/OSUOyq
 5KKlR0NxZ7xi0h86OzYt5x7+CASyLw7O/rOuQBVSefFnuNdHkYE5ZNGHJ/6+lk9USV5q
 3UtNLW0o8SwC35yFYcITLfHBcPskMJVcCTXr5I1JCxF06jDT2yNdZTQhB3HfewVbdG50
 iGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696730519; x=1697335319;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSjvEQ5he5li9rsF12WCwfAn7VoDVxsmryxmLHUL6RE=;
 b=gV5A599OTsYl27kFRKVWcj+vd8f43bxZMUc3v37lV+F7R2LM2VjJ9mltT72G0N4oa5
 mzm9bLL5Tdxejy+eY1rDCfYzIooUK1ANKmS/3lDrT7TFQWflti49swyHMZ39CYazOgrv
 vF6T3e+QtEqdYSLHxNRTTXN+h51urC3jl45+xdYZadUsCbiohFHLycjdGppTMZHXSgWR
 Xs4flkWJsSufXb43x4GSqtusDUBPkLCCCqRftNMAI4qMoS8h1Eu52yE4zU59hM5qw5e2
 u6dJrBuwEUwoeDfFLSFah0+QZPZs2FiX1sTyzrVnjWYOyZkybJUcWB2PqlsBsPv07s1o
 /+Rw==
X-Gm-Message-State: AOJu0YyuG8Vnven7ph9BCHOYTPxkNpoc9RrC6gbEhGrnIkbB7Q9mqqk9
 IK3Mbe6Cx9oyzHliug1zbfg=
X-Google-Smtp-Source: AGHT+IEjP8Y6Iga6Tpcff9ISMi/9HWQTvv51B0uiSebTKKOXumArLufOcVU6wnPUpzbrsp3xLe+6qQ==
X-Received: by 2002:a05:6214:1fd3:b0:63c:ec39:13d0 with SMTP id
 jh19-20020a0562141fd300b0063cec3913d0mr11108831qvb.64.1696730518710; 
 Sat, 07 Oct 2023 19:01:58 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 v13-20020a0ce1cd000000b0065af657ddf7sm2631641qvl.144.2023.10.07.19.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 19:01:58 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] malloc: Enable assertions if UNIT_TEST is enabled
Date: Sat,  7 Oct 2023 22:01:56 -0400
Message-Id: <20231008020156.1990125-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

dlmalloc has some sanity checks it performs on free() which can help detect
memory corruption. However, they are only enabled if DEBUG is defined before
including common.h. Define DEBUG earlier if UNIT_TEST is enabled so that
assertions are enabled in sandbox.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/dlmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index dcecdb8623c..500a0dbda89 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -8,14 +8,14 @@
  * as file malloc-2.6.6.c.
  */
 
+#if CONFIG_IS_ENABLED(UNIT_TEST)
+#define DEBUG
+#endif
+
 #include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 
-#if CONFIG_IS_ENABLED(UNIT_TEST)
-#define DEBUG
-#endif
-
 #include <malloc.h>
 #include <asm/io.h>
 #include <valgrind/memcheck.h>
-- 
2.37.1

