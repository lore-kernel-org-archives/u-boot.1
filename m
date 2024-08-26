Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CC8C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D878B88B6C;
	Mon, 26 Aug 2024 21:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VG0Jr4OF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3563E8842C; Mon, 26 Aug 2024 21:12:03 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2AE88B6A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39e64b737ceso526155ab.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699519; x=1725304319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+iBSwpvGBt0Mlg0VkLGm9ReN2MV6QxOJapdvd5Rs7k=;
 b=VG0Jr4OFVTs7D7qrN1FzX1q+Felio56/QSctmQZ+ZLf7wXW1s5zHfgIw0AasROwBtu
 qLCCJV5v8OsshQbRgVcKxQ6dDhP9kQ0KwA/yeupgHk6ANEyrUDMIxZ0pkfR+M8vfGRbl
 l1+EykHxJpByHXHAIzfQy9QLKdt7n8j43TBGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699519; x=1725304319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+iBSwpvGBt0Mlg0VkLGm9ReN2MV6QxOJapdvd5Rs7k=;
 b=xDw+WfoEyMzne8gamGu7IspGr4j3gsbMyB+jiOn63RDq+0bAK6dpzJRFCNrjgjtUAC
 uOxIE4I/cfCy2m6tloUDvNSyIRlzllijR/3ciCdyOu+PuJUhIeJOI9vzH7vZFWEIn/pj
 H1fVIETlNciWljPp40cGai4Zpb3gXhy7aWGs20ErgmA8UfklqfOY8dAcRY54mOXQctoJ
 F/MVVl9qp451vmacX1g53a9WZf0Ooo/XAvbXpMfznZj0QwLe94rcBAwZkOByL3cCmUI3
 6ESHw7luHYiMEbv2H4kzo4BVJsAoZetcfR2MjOTD0TR9yEY10Fri0I3OzcUB62b9mdeW
 /PXw==
X-Gm-Message-State: AOJu0Ywckq0s56uvKmTZ17Lufl23qBLr1tYHlu86zezTbbst2XVTDU+R
 FyPT8JCMtSFh7oOgMQFRXDd3kgbqpYwLJNd0uCXKN2ZWcGvjj0ZLYz3g1DqFKF1n50+uJLjQIcA
 =
X-Google-Smtp-Source: AGHT+IFq3iQWHogX9e6hp+ZM85LsEZ03sggA/KpSVZ7iEk/4MaK6CvHxQtcl1MyG605nD62E8CapOg==
X-Received: by 2002:a05:6e02:b45:b0:39d:1b2c:c32b with SMTP id
 e9e14a558f8ab-39e3c985168mr133778145ab.9.1724699519368; 
 Mon, 26 Aug 2024 12:11:59 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/15] binman: Avoid setting the image_pos attribute directly
Date: Mon, 26 Aug 2024 13:11:33 -0600
Message-Id: <20240826191143.426387-6-sjg@chromium.org>
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

Two places set this attribute directly. Update them to use the function
provided.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/atf_fip.py | 2 +-
 tools/binman/etype/cbfs.py    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/atf_fip.py b/tools/binman/etype/atf_fip.py
index 73a3f85b9f4..4d84e96c376 100644
--- a/tools/binman/etype/atf_fip.py
+++ b/tools/binman/etype/atf_fip.py
@@ -248,7 +248,7 @@ class Entry_atf_fip(Entry_section):
             fent = entry._fip_entry
             entry.size = fent.size
             entry.offset = fent.offset
-            entry.image_pos = self.image_pos + entry.offset
+            entry.SetImagePos(image_pos + self.offset)
 
     def ReadChildData(self, child, decomp=True, alt_format=None):
         if not self.reader:
diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 575aa624f6c..124fa1e4ffc 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -245,7 +245,7 @@ class Entry_cbfs(Entry):
             cfile = entry._cbfs_file
             entry.size = cfile.data_len
             entry.offset = cfile.calced_cbfs_offset
-            entry.image_pos = self.image_pos + entry.offset
+            entry.SetImagePos(image_pos + self.offset)
             if entry._cbfs_compress:
                 entry.uncomp_size = cfile.memlen
 
-- 
2.34.1

