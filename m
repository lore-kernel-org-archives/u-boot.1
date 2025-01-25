Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA8FC0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A4C480F56;
	Sun, 26 Jan 2025 00:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1ishz6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4991C80F56; Sun, 26 Jan 2025 00:38:36 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156AC80F4B
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso266971139f.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737848312; x=1738453112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0lCci3Ke+jQq0mX6Fk+BQK7lK+0KnuSemVqAoOLN08k=;
 b=c1ishz6+RLHtbuRUfEt5eV4FFX871wjec1J3xeWD4KAjB5O/sUQIiNK54ht6T+mjzb
 /WOw85S+JvQ9Hn7pE6OWbwtTNmkMEoLnweK2mE8RmZDLoGjUayxsi/nUFc8Mvao1XK41
 yvXXWD8DC5eAQFjtBHV+qYUaDjkVs+IbcpTEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848312; x=1738453112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0lCci3Ke+jQq0mX6Fk+BQK7lK+0KnuSemVqAoOLN08k=;
 b=iQey7Dk3JpJHcGEBm2NbSrTPgtArhfQxnhdtXIefteQenAF96XM8rsU53Gb4F6eqif
 2BeLf1QnQLNMYb92ONIYt1leL7r6nr0KJvSWm9HO7T02qcfnezXWnZvJMFb0escBNfF9
 9+a5QvnVciDi6ZNqvgENiTYH7AeCODkwAfBR7a1qPKh3ltSyPxoS2vqB58aBonHUFo2F
 WxmJ/RNRlwrprTHmWT7i354nhoRjqxhH1s2PxPfMavaPhZ9AvtZ6z4OSirotpPGfgfL5
 afrSL8mwj04Tumm3p4Rx4bcZQGybQnAWUd3Hxz5Gaiqmm37rbzEf40p4Mp3jb+AvMy7f
 CR0g==
X-Gm-Message-State: AOJu0YxQ6gPD/zvaeEho8v56+6HhzHbY8JxIqz0FS+I7cF/7sFFkKbDV
 y0t7GsvLU76xNUqVJbe47HmZw8TFt6wGFZBAG/kEuRPpsXJOE8m2b7Bm8M2SyEDKTXhqBSJxvUQ
 =
X-Gm-Gg: ASbGnctvvRU8UfZB5kfurdaiDYmln3ARlHbyWxqNFoKtaWjrWUJ8UjiAGvP+GIC6ylP
 FCpUlLvW2c+5dEhZdty4EsA9IcffRhtqe8hNL9C+0ety6eG8VP/RECz2r5859PN9X4rqh4RDfjn
 y/0WBQSccBdZO2Ubd1Z3sPvB4hbMdwWG43o40oQfNmbmR2LXVZNf5fjnkJQ7TDj1fe9LbirJ3wr
 I68uO12EFa9UD6Ukm5iSlpNeWgf4u2rn2rkk4t5hHN9itgS4ZK0ScVv9nXmvP4u4VLkdkpDt0LI
 T43QomzWmpGIg6jruwoB58sqKr+vtAovYlo2bvDgRA==
X-Google-Smtp-Source: AGHT+IF45F3RdxVFefamTDFyx0uxbS25VpQs5ibBgKdYzIFrMWBqaXOJ1JWsskh8h39rZlhFstKXbA==
X-Received: by 2002:a05:6602:3e94:b0:83b:a47c:dbfd with SMTP id
 ca18e2360f4ac-851b618f83emr3530009639f.6.1737848311836; 
 Sat, 25 Jan 2025 15:38:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521de11161sm171496339f.15.2025.01.25.15.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 15:38:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] binman: Rename Entry.end_4gb
Date: Sat, 25 Jan 2025 16:38:11 -0700
Message-ID: <20250125233826.2173192-1-sjg@chromium.org>
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

The property is named end_at_4gb so name the variable the same, to avoid
confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

