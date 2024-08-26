Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE01C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B29688BFB;
	Mon, 26 Aug 2024 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htiPAzHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F70488B68; Mon, 26 Aug 2024 21:12:06 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D4988BBE
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso16549875ab.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699522; x=1725304322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAQscC58pLNMDuzbgAQzJcXl3J7koWUGpz8xHXscQ98=;
 b=htiPAzHxBiVgDEAwmjBUZnk/rD3dr9YP1jZgxRW+Tzlb7vyl60z56SE8VUEwuOfBcG
 9tigQRbYF8Hsa2c4reTPkrmKOFHVYGtT2vVmBvjzrDD35yHk68TXqIRN1s4mP1f/NGIa
 l6StaH8dH8G43F3u9vpfqnWZfmqpr9AN68l3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699522; x=1725304322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uAQscC58pLNMDuzbgAQzJcXl3J7koWUGpz8xHXscQ98=;
 b=wAKnHzLCYgxDhCceRVd4YEwUtEiNJEf59c29ako7yeqbAznQ4anp5RRJuk2ybgnZh5
 +bu1i1gVCt5DLVeiHwGs7jBt9hXby/IGbkHVm/6TtuMInsydLbnoreBfScKr0zCDLpdM
 B8mvIe7TSGjug+h03AYEteqOjuQbucCsOese4rcMrAA9Q9t54zPpONyBhu6PsntNbT2j
 Opvp3grkk8MGOXAkNzgs1kn3mTnxyHxYAoZ6/FkEYB1sfMChq/IWrBrQWaxGUIk28Uqy
 BLWZvnaGBlfXmDSOAHPgczWIit+td/R+SNdPVyqdFIjW4zUSkVoxEwvlWx0TnMsU2A4Y
 ReoQ==
X-Gm-Message-State: AOJu0YyBJhCyN8yis0ROCGX7fOJQ268AkNCk+tedsvOr2EY3lzJApYI2
 c7qxqciTC4q4J3aCEq32er/6GB/YNfTGs2T+QXi2Ry9+i+cq2IhS+7PC5V5vW+k+zz9Nv7Aiz7Y
 =
X-Google-Smtp-Source: AGHT+IGFurFEdmH7ohMnx4BbEik/9l3FnsXqNA8fHhxOsVnt6WIuT1EKZGpRgeFQBuWC/7qzuMJESA==
X-Received: by 2002:a05:6e02:1b0c:b0:381:5590:7561 with SMTP id
 e9e14a558f8ab-39e3c9c0b01mr143948215ab.20.1724699522206; 
 Mon, 26 Aug 2024 12:12:02 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:12:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/15] binman: fit: Avoid assuming that a FIT member is a
 section
Date: Mon, 26 Aug 2024 13:11:35 -0600
Message-Id: <20240826191143.426387-8-sjg@chromium.org>
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

Use the more generic variable name 'entry' to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 51c82c55e4a..3adc4a959e8 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -904,7 +904,7 @@ class Entry_fit(Entry_section):
         fdt = Fdt.FromData(self.GetData())
         fdt.Scan()
 
-        for image_name, section in self._entries.items():
+        for image_name, entry in self._entries.items():
             path = f"/images/{image_name}"
             node = fdt.GetNode(path)
 
@@ -936,8 +936,8 @@ class Entry_fit(Entry_section):
                 size = None
                 self.Raise(f'{path}: missing data properties')
 
-            section.SetOffsetSize(offset, size)
-            section.SetImagePos(self.image_pos)
+            entry.SetOffsetSize(offset, size)
+            entry.SetImagePos(image_pos + self.offset)
 
     def AddBintools(self, btools):
         super().AddBintools(btools)
-- 
2.34.1

