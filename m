Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365FAD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B783783C9F;
	Mon,  1 Dec 2025 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V2VC0I0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26EE83C6C; Mon,  1 Dec 2025 18:40:43 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD72883C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c750b10e14so1437584a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764610840; x=1765215640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eujT/i+aOoqokbRN1k5H3+ZU8GbZSjzkujQjOj7fCQ0=;
 b=V2VC0I0SCmoPak/hqwqSt0DAvpdf8KFu7QmMw2WdGrJxRexYt3nUk7dAg6enAo52NF
 abjBQvVJE+Yb8Bti/JXQGPR9SIQI32wJT6CLpxI4PHi0YLPVTrhBvINWeKR+bTqsIZH3
 61D1at2bI5P+vWeD7XB5vw0Ksl8kttgfPWxFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764610840; x=1765215640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eujT/i+aOoqokbRN1k5H3+ZU8GbZSjzkujQjOj7fCQ0=;
 b=a1OvF8Pv+5R0WglrwDw2hI/S9WJBUdY62xQJmzHpGiVQUinyTdEZq4ljm8ZmtiDKYx
 TsMP/5oyuCcJJWjMlHNQrKvvagmDT7faeBs7O/Ha7xdSsnXH4nAh5JHVCNM3I5jjbg7B
 TWeDrLMI4spIFvabZtMg+Q0LLCjkTM4NryrMKubHb8NIyMoJ3WMrIxO1HQppxozTSiAA
 FnKAN0YYefaLsLgu2wrFen1RAjgn79PAJopYD82hlXj5E8R2g9jTKq6ygwHISD1velyE
 OTWI+LYceu3YKHo/Nr7/iPohWGyQSXfTP9iIAj8nWY/Wn4Ot9IDqbUJZIXrfUETiHxZt
 D0OA==
X-Gm-Message-State: AOJu0YwTo9PklZs30bSpHoGQt4L8ynXxAj2UQOamXBUbTzbTD1CDgdb/
 yR/TGfLfuzlfHBOP1NZm1RIUG7sH5KUXvTArUOt5pxBxxFh5ioEd3cDpRznbFI0VTz1fXhluMkF
 O2vSn7IE=
X-Gm-Gg: ASbGncvU4gBLvjzCthgNPTq2bEr96F5gOcjMjib56+N64KFcspqtFfAhejdDmLajpfX
 /jSb9HtTwxGPDE5dIxEiRmcQaWezDWUO7UAfT+QB9vJXsKK7ufGDgYeScC42ryP34OcFis1f7qu
 txJBR9d4Q5UUivOhSjgAelldeKixdbVbJPHLcUif4wn40Y3esP5WvzW//mSFbXMbAClhDLKHOhV
 kCkmGMQJlv2j83WEfooqJdZgF49z0ZzmkpdM7ZjW1g1MxqZKsvvmsd+OOhk4wI5NxQRSlBhTw4N
 eN0soo8aXrVQkdEWoIsUoRAz6pAwfP8AomwtYWShn2o/0jtQQTLJotnfKwvOtn6Rdae2t5XcZnY
 iCjkUTOulplADqLlphEiTz5bm9WOFnwudi8bpwJLICaU8AvNK/zDRpiLa7Z4QNYvDOOkO8g++o5
 xowyeamHs3neEhWFncmR1IZQnzfEFqhnGyHqntkoRwAA4qWfgC+z6S
X-Google-Smtp-Source: AGHT+IFyr21DvHGLmulbjPET4/12jLl+rPrrGMuBvuyXJIjHXx/LCZi+RxDwut7lFUBZ6B0qk8EGzw==
X-Received: by 2002:a05:6830:a90:b0:7c7:1c77:f107 with SMTP id
 46e09a7af769-7c798cc684dmr21596583a34.34.1764610840380; 
 Mon, 01 Dec 2025 09:40:40 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65933cedba1sm2686544eaf.14.2025.12.01.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:40:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] boot/image-fit.c: Restore building tools on macOS
Date: Mon,  1 Dec 2025 11:40:38 -0600
Message-ID: <20251201174038.2246180-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The ordering of headers in this file doesn't follow our rules exactly
because this file ends up being included when building host tools and so
has to be correct for host include paths and ordering as well. We need
to have <malloc.h> higher in the file or macOS will fail to build due to
declaration problems.

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index cccaa48f6839..3f66bec49041 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -23,6 +23,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
+#include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
 #ifdef CONFIG_DM_HASH
@@ -35,7 +36,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
-#include <malloc.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
-- 
2.43.0

