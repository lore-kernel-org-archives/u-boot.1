Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF964C5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 19:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BF688A8B;
	Mon, 26 Aug 2024 21:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ev+L9TU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3BF288A8B; Mon, 26 Aug 2024 21:11:58 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9658688B02
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 21:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39d47a9ffd5so16445065ab.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724699515; x=1725304315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQy76jj9ZEwvjg9OzVP882hm91S0p+pjfXWxbKli1gw=;
 b=ev+L9TU/CQCvm9fear1h5oSWT3TMdDXsEcTUTVBqPJ3bnTCD2ciRfFi1qAc9Kpf0Vr
 O8Dk1FtGayFBNQ/aWYH8SAvi7ITjsuCljPAhxn3D21dRONH7NqK18zZksLKfGWOQiIkj
 3miz0dKrpqHeLxLLV/jgduiB34plV8ay3jgDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724699515; x=1725304315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQy76jj9ZEwvjg9OzVP882hm91S0p+pjfXWxbKli1gw=;
 b=WeIq+OvkJrq5AlqBpCAvtA6ojHl2PYYv9MtI3c20jWvQtrHziOp7S0mjQbXqKLGVVK
 m0+EJfqi9OriABjpG4nTWsd3KdOXLA+iEmIg4hvwTFEIqki4DWseRtEBNe4zNumwIMi7
 Q4kqQhN+oNj+6pYpMHwu1C9xcY25ukjTU56MKMCMV8q41jUhwD/HCROJf/Dgsj1YaWtq
 FXQbbZGTJgosjlMlD4Z8CgNLRe9Lx3byjvGaCC47cWrNfCHYb4HkgVGB6QUIS5SNlaFv
 LYLJXPogpNX68lZpTvcSZpjxyuvtHSt1gu3kYqTlJWRHAys07GfeH4Vvqh6k5O952ois
 fYCg==
X-Gm-Message-State: AOJu0Ywa2pxJw0ClXTqG16adoRNQDqQckrif2RJ1njsrOzc+FqtBc+VQ
 XOYLivQVc4M4Bh12VXkSXXL11jVNL/6THIIR5VEav3+Hmbkw3v6LsxVyuM6/+SwoClcv8PthKO4
 =
X-Google-Smtp-Source: AGHT+IFB5G3WpsswMa3hM79JtYsruJ/3mvb4XqCHIHcX0CmueeB+2fel5FuuYAwQ9CMd2hGtmVy6LA==
X-Received: by 2002:a05:6e02:19ce:b0:39d:554e:6986 with SMTP id
 e9e14a558f8ab-39e3c9e96f6mr157200105ab.23.1724699514976; 
 Mon, 26 Aug 2024 12:11:54 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c102sm34412575ab.37.2024.08.26.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 12:11:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/15] binman: Correct the comment for fdtgrep
Date: Mon, 26 Aug 2024 13:11:30 -0600
Message-Id: <20240826191143.426387-3-sjg@chromium.org>
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

This returns stdout, not a CommandResult so update the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdtgrep.py | 3 +--
 tools/binman/etype/fit.py     | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
index da1f8c7bf4e..446b2f4144b 100644
--- a/tools/binman/btool/fdtgrep.py
+++ b/tools/binman/btool/fdtgrep.py
@@ -74,8 +74,7 @@ class Bintoolfdtgrep(bintool.Bintool):
                 (with only neceesary nodes and properties)
 
         Returns:
-            CommandResult: Resulting output from the bintool, or None if the
-                tool is not present
+            str or bytes: Resulting stdout from the bintool
         """
         if phase == 'tpl':
             tag = 'bootph-pre-sram'
diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index ee44e5a1cd6..b957df54548 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -550,6 +550,9 @@ class Entry_fit(Entry_section):
             phase (str): Phase to generate for ('tpl', 'vpl', 'spl')
             outfile (str): Output filename to write the grepped FDT contents to
                 (with only neceesary nodes and properties)
+
+        Returns:
+            str or bytes: Resulting stdout from fdtgrep
         """
         return self.fdtgrep.create_for_phase(infile, phase, outfile,
                                              self._remove_props)
-- 
2.34.1

