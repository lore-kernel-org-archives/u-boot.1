Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFF3C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F90D82AB9;
	Sat, 10 May 2025 13:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LF9yieug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989A382B16; Sat, 10 May 2025 13:06:21 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F738091A
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso491952266b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875178; x=1747479978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqgYLQ6HwKEMT2C+Sg+YYzCW+ntJu+f5wmYVrDQyjG4=;
 b=LF9yieugI+Md5O7Z7cuHZ9x0KLCfl9wHe2CGBI6Y7/r4eoLcXwnoQtTpEYpklKmt+X
 rNkuYUaEPwxadok/hS+8prw3lPtwQ/i72QGFTY1TdqkuLuLHaNVSumqsje3va6jzL5Rd
 ROUqtgRTM485h8IUo4IrNh0R0FlPeH18LYw3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875178; x=1747479978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqgYLQ6HwKEMT2C+Sg+YYzCW+ntJu+f5wmYVrDQyjG4=;
 b=XzCzJGtE0tncV2Mqub0eYqRoLKHCgQTnpq4sKBCnlOzQnFAlZDe3b6HlpgXTJpZxep
 uE1MLHjGxjcBmik3kViNmhUSHCE4cDtsZXat8Pm12PvoJ3YtYumWi2f+XQLAl6H8/MCq
 hMAZKo/oXnGYzw+PUyv0G8biUUBgA+Z9nlrer/nDtb32zFeKGLdJ7ZVGMVD9sZ0ENxDE
 0ynlna6MF4H36rNZ8sCs67KRgOSpm6pCVl9d92QQk/xVy5b6+usUkQ7K6tqSxnOIghFL
 Lm4/9ktAc7eHKPpYqCg1Whi3feA9UWqGsy4uFtCh73qzAkF30yDKbPH7lCuRZaO5MW1M
 BP3g==
X-Gm-Message-State: AOJu0Yx4pOdDzvxH8HPmjt2VzGS+afWR3LwY7i8SiknaOmPEsHYOl21r
 O/3KO1qg4nUROcIGp2CNYvW/bHS+F2fe/YF0WyJWIOEoz93xwWneghmVJvsfgi/yvSxFqwRbvcQ
 8aXEOW9iiv5VL
X-Gm-Gg: ASbGncsRz6iiQu3pJ7/l55aEMDbzsfnMKAwvOl80+Waiu+lbXeIuZ9wdPOtwafQ1vAD
 Z2jGG1yB/sgtJZEF5wmxeCilbZNMbib3x0+dstoyEK8ExohnZdxwpL0ZluLetagqZUu8Xhe4GcZ
 FvAjIMK703gZeP+6GWJ/ER6oBFpOuFjbmTr5cwev2iJ9SKpYEY4kM5E6CaxsHR98UJLAahE2prV
 tyGVvCR4ozfhBgas834UJcnPEoKQMPe10qaWd3lLkm+t5zxuc2v+Jlx3k9Sdzmfi3rngFv9AHW2
 W+3fS78BXpJr+11fYBhHzQ0pLfbd3Vic4AhFP1kqMPeQ32c=
X-Google-Smtp-Source: AGHT+IE+bWE1l9p2ypkgz/DwM9oQSxqIzYCV+wCch64otkkf7Ilj12/n9iMCVrHhG9nhLyq2DmrISg==
X-Received: by 2002:a17:906:f85b:b0:ad2:2727:f482 with SMTP id
 a640c23a62f3a-ad22727f894mr398369766b.55.1746875178073; 
 Sat, 10 May 2025 04:06:18 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/25] patman: Introduce basic database support in Series
Date: Sat, 10 May 2025 13:05:10 +0200
Message-ID: <20250510110535.1453745-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

This class manages a series, i.e. a group of patches with a possible
cover letter. Add some properties for recording basic patchwork info,
including the database ID.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/series.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/patman/series.py b/tools/patman/series.py
index 97bb048c4b7..3d48836e90a 100644
--- a/tools/patman/series.py
+++ b/tools/patman/series.py
@@ -39,6 +39,10 @@ class Series(dict):
         allow_overwrite (bool): Allow tags to overwrite an existing tag
         base_commit (Commit): Commit object at the base of this series
         branch (str): Branch name of this series
+        desc (str): Description of the series (cover-letter title)
+        idnum (int or None): Database rowid
+        name (str): Series name, typically the branch name without any numeric
+            suffix
         _generated_cc (dict) written in MakeCcFile()
             key: name of patch file
             value: list of email addresses
@@ -54,6 +58,9 @@ class Series(dict):
         self.allow_overwrite = False
         self.base_commit = None
         self.branch = None
+        self.desc = ''
+        self.idnum = None
+        self.name = None
         self._generated_cc = {}
 
     # These make us more like a dictionary
@@ -63,6 +70,14 @@ class Series(dict):
     def __getattr__(self, name):
         return self[name]
 
+    @staticmethod
+    def from_fields(idnum, name, desc):
+        ser = Series()
+        ser.idnum = idnum
+        ser.name = name
+        ser.desc = desc
+        return ser
+
     def AddTag(self, commit, line, name, value):
         """Add a new Series-xxx tag along with its value.
 
-- 
2.43.0

