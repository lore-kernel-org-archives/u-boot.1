Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97DBC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB3E7812C0;
	Wed, 26 Feb 2025 17:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2A8R4Of";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0082D81249; Wed, 26 Feb 2025 17:26:49 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD40C81250
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-855b3e42c5bso194796539f.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740587204; x=1741192004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h+0viqg4+tP4OIRJmW7RINMOmrxqoFe0VtmKD7xrq0=;
 b=l2A8R4OfJDME1KJBo25JTa+AqeSwQeY8krs6fUjErz/YnZDNODB3uZDQles6/clhJR
 lLj6+9Wuit5fC8GzEhozF7ntyLZPis8P7sR+d5UXSukH15rqQnVueuBfFUQBABiArzd8
 VM0XqnRZ/zAHqSoU8ongJyn3AGtPWt9MqVOR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587204; x=1741192004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4h+0viqg4+tP4OIRJmW7RINMOmrxqoFe0VtmKD7xrq0=;
 b=rwygtdtpKfV6+2qD7UnGoA3KLnaAZpEc2BNeDcGq7khShT3Ujn803wEbf1JUyP3rb8
 l1O+kJCkHmmmJXsCmN53BxeZLg4GGfrUi/qM/SLrJnkS1WlpLLXLpa+Q1adgNPIdLL2G
 01io02/oKRNbQgdV7FhlqUO4YQKbLStgqHEIwbMRWmzHE4MSPKYrSZrAXfAwR2enZRce
 9S0N2YPeDNaUUu3WLpgdPX9veW7mwN4fBVUpLHPZsOjQso+UgrxphRdXLAIIz9KQw8FW
 iHEFZnQv8SbwoBb81HAeHH8AgY3u7mA0aS2fYdHCW0n4C8u5PC4mjWUVbpUh1+nXKHZC
 TKSQ==
X-Gm-Message-State: AOJu0Yx0bZlx7yn1krX0urWYBIcISBPHkRVAg5ztgRFhhsH1LIVF4iRt
 JWOf+GBbu7wnq5tyx6tMtKvSLE8mP0iDdznXcJlZ6c9a1Z79JPNHyi9qHsGROwWNeVHvtarEKyQ
 =
X-Gm-Gg: ASbGnctOQ70iaqx4CxR9lYp222Bah01VcqvQJStbOg9xc4xy/BQIdHGe+gvohpWNjHw
 +4+IUeg4a0xxva9Zf/VovSEXJIzk+yRq/wwH/0e6MVgSmLfdOX9h5LCCaa/WP+6a/SPdInpcr+O
 r3JA4TaF31r8EiXP0H9pt7wS3HI8H3E16dkRxXOpHXXPt8WY++DK56q6TGRIKkJ47+dH2F4+s9a
 TaAG9ijojuDm9UZETeRxSdLCfaW7ta6nGviTukw5urXrRuORNs2yUYi99TJyC+jYvtQWiELaqcn
 fkqPfgzOwdyKF0q/9IY7oEOFjvsZ/cfEttc/J7SLqBHuhWjtaRenvGO0YAsaI50=
X-Google-Smtp-Source: AGHT+IF/ZdKDfvnPT5TRSBjDdJKDnBcaC6yKPPS24fyffO452Ppyks9W1t17Y2J7pyz1Q1EA1+UiRA==
X-Received: by 2002:a05:6602:3fc1:b0:855:9c88:7888 with SMTP id
 ca18e2360f4ac-85620129e13mr924656339f.3.1740587204445; 
 Wed, 26 Feb 2025 08:26:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85620a2f9c6sm77857539f.21.2025.02.26.08.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:26:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/5] binman: Rename Entry.end_4gb
Date: Wed, 26 Feb 2025 09:26:16 -0700
Message-ID: <20250226162621.2681677-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
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

The property is named end_at_4gb so name the variable the same, to avoid
confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entry.py         | 2 +-
 tools/binman/etype/section.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 68f8d62bba9..e506b552a8d 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -722,7 +722,7 @@ class Entry(object):
             is_elf = self.GetDefaultFilename() == self.elf_fname
 
             symbols_base = self.symbols_base
-            if symbols_base is None and self.GetImage()._end_4gb:
+            if symbols_base is None and self.GetImage()._end_at_4gb:
                 symbols_base = 0
 
             elf.LookupAndWriteSymbols(self.elf_fname, self, section.GetImage(),
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index f4f48c00e87..020fd57d704 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -165,7 +165,7 @@ class Entry_section(Entry):
         self._pad_byte = 0
         self._sort = False
         self._skip_at_start = None
-        self._end_4gb = False
+        self._end_at_4gb = False
         self._ignore_missing = False
         self._filename = None
         self.align_default = 0
@@ -187,9 +187,9 @@ class Entry_section(Entry):
         super().ReadNode()
         self._pad_byte = fdt_util.GetInt(self._node, 'pad-byte', 0)
         self._sort = fdt_util.GetBool(self._node, 'sort-by-offset')
-        self._end_4gb = fdt_util.GetBool(self._node, 'end-at-4gb')
+        self._end_at_4gb = fdt_util.GetBool(self._node, 'end-at-4gb')
         self._skip_at_start = fdt_util.GetInt(self._node, 'skip-at-start')
-        if self._end_4gb:
+        if self._end_at_4gb:
             if not self.size:
                 self.Raise("Section size must be provided when using end-at-4gb")
             if self._skip_at_start is not None:
-- 
2.43.0

