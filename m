Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C3FC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A9A88C15;
	Mon, 26 Aug 2024 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kx/aQdu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD4F88B68; Mon, 26 Aug 2024 21:12:07 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE3B588BFB
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39d3b89ded1so17066865ab.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699523; x=1725304323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kp74oRL80oPEecB4E6l0pj4plnK3Oeb52w4g7skiGBI=;
 b=Kx/aQdu5C7OtDMoupq1m/n32XSwYPWQfX6q1QJLM0gimiFx/zg8bMxvJmCbSW4gQXE
 i4v741pcifqzMFfV9g7ulOrU27zHr9qp9vQd6uLDis8kN+vMVJ/JUiAVBdR/p2cAuS76
 uWyVFF+3/ka/syi2dzIu4cBZpryVukVzvO2pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699523; x=1725304323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kp74oRL80oPEecB4E6l0pj4plnK3Oeb52w4g7skiGBI=;
 b=TOBOgQ+gNCDl95U3nuSSToH/f4oVJpiNOYRb7KEITFVwB2/5wYrvdnjK68aVEEyeqZ
 EgWEa5qoq5LOnlLJpyiz3Cwod2Xrp0AZH1t41XdluWXhPBtDJrYnyj2KjAtF4GiI/P+j
 clBMlr2twKHH8Q15LGV5KMeb0pZCZUsB1X9eUrdKJzJLNBYrvTjMUuu3wU23TywbyFO7
 zn/xXOFHTDexTxrJvfmx8Sob9REWWY55/UOqBkz+HD87hnLFtHg5R9XHffhtSveV6MLV
 d3Qj0F0sk4s9X6YkJ5eO+c+orerU6GFDhWExhF+htfbKIC8C9RABL/gp/B4MXb5a2R3i
 XbCw==
X-Gm-Message-State: AOJu0Yw1RVOLL8YFHCfz8UqFYJSU5Mszqru8AkctgJyFgnr5iE45fvuj
 1r5ctSp4zYRACXe2Q+Ya5e59sHIhKsXZLYFYVcl7LWUFZi6SYUB3CJRqFohNqmrDKUIZGDVnMu0
 =
X-Google-Smtp-Source: AGHT+IEqLXjya/VLyFQQIY0t8KVckewkgQyldfj2UxGOpgaKukRK6jMIofb0cFbz8hIOfBqdPXrsuw==
X-Received: by 2002:a05:6e02:13a7:b0:39d:4ef6:b36d with SMTP id
 e9e14a558f8ab-39e63e11f19mr7593965ab.7.1724699523407; 
 Mon, 26 Aug 2024 12:12:03 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/15] binman: fit: Set the image_pos attributes only once
Date: Mon, 26 Aug 2024 13:11:36 -0600
Message-Id: <20240826191143.426387-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826191143.426387-1-sjg@chromium.org>
References: <20240826191143.426387-1-sjg@chromium.org>
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

The section etype has its own implementation of SetImagePos(), most of
which is not useful since the code is included here. So call
Entry.SetImagePos() which has the only piece of this which we actually
want.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 3adc4a959e8..96f4fdf3333 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -894,7 +894,10 @@ class Entry_fit(Entry_section):
         """
         if self.build_done:
             return
-        super().SetImagePos(image_pos)
+
+        # Skip the section processing, since we do that below. Just call the
+        # entry method
+        Entry.SetImagePos(self, image_pos)
 
         # If mkimage is missing we'll have empty data,
         # which will cause a FDT_ERR_BADMAGIC error
-- 
2.34.1

