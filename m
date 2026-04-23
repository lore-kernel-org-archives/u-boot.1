Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D0BFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7340D841DF;
	Sat, 25 Apr 2026 20:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KqKGfsT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D765284399; Sat, 25 Apr 2026 18:57:39 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6F7384314
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-506251815a3so76124461cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777136257; x=1777741057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2NVRO6Jy2fDO9x6Z0sYUv3aXbLVkyU20c6c0+/bOhk=;
 b=KqKGfsT4jgceoJiIH6f5Z1SjInROivJAf+nVfCLf89NuZHUFvVkzTKcLPaeMVm0QZ9
 6K8ygzYQZ+l9U+svfIhn7t3DEUttKsLf9lw2kFphpkFCY6XZKGTS1+iXYwjxuZxoLF3h
 yrbMaZ3UuVNRzfYVck1URUYPVZKUKj25adhmB95M6RWMi1mjbIN29pQYVkUjBHLmEl20
 JlZLn5+gPTYr7LH3v55zZ6qesw+9msEleQWGUXmKYUTdO3RB+sEHYxOsy366k1CKq0oR
 vGN9IAHr2LzusVzZmUHGl5ewtiqnb1ReoOA4XKCTK9tJk+FafIJLE/RED3Jn1zm5Pgjc
 g22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136257; x=1777741057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i2NVRO6Jy2fDO9x6Z0sYUv3aXbLVkyU20c6c0+/bOhk=;
 b=He46oQb9Tr+Pxco1XIQCCyGlvMfr6BcF6L19zkzm5ew6iGi6STBXbVokBXO+7Rl/Zw
 G4xXHAYXwUkFxPOcjzjy3Q/VzF9qlLPh1oYQ3jx4AiIBkgmU5zomDg1R6CKPvtZ7NXiU
 5R4jnrw6sh1/lx4Sfmu0CWiYHiVlfRaIlWj0HZUq+RdE31Zsmr3pzmME/V7+NqsI8mOd
 5UgqwUs6mNaBFuQO54WbrLVUFQId6YjflB1mAU9ImN1PFcb/tiKv9mQT3g1qc367eopz
 GzGsV8z5oO8nAFvBSv3VGvoJamHlZubYJw/KucbTtxnyF0NTOlZH7BPsdVDD9+gwrCwG
 iTtw==
X-Gm-Message-State: AOJu0YzSCQvL3Jq5DI4Y2dfqvIEnKQMCnDZhEymVLx8sgX9es/DMHh/E
 XH02tLYqA+p1ZHQHNNgGRVPr0MjFPUg0TWjnxY40Vbdex2zzF4oE3fpP3wNw+mqc
X-Gm-Gg: AeBDievXUG/KRKMWQZdwJP4HPukT9FpjZNqDNUgPICy/E1egPNoC1CAhKcNe9eRrFk2
 kUFUjZuuMIVhrIWLJp4NToqsFl7yyKaU3Ov6NupFPa+JyxF7HtFzz5Ryojdw224EeIzZ5/LdWvE
 T/pRDK6TLWaO3AVRJCtcQh+1tNJvr9L6cDoXeNLwPcIjUK/KMxw08HPF8BJ/Ur/9iwatXK7RcQe
 4yrXgMYw2CzP6azp/klqlfMi1ohV87XcdHHP2Ag4yQ2MFwNNHshnh+2LzwhyBzdgGy7cWJ+XaOY
 MF2qRlfxbp0sW9/i4+R/Jh03RFf8OJFKesSGffezp8sPQeqe8HpjjNGQEeqBOukfQdj2+LHsa95
 XEk1u2r0gMc/LZLVXN6YLDdir3kovOxiPHgW/J/ggIX7EBClO5txcYGAIu4aczG4BNq7ADsWYDp
 SYB/22dEfr3rXphVWWSvaV5W4cnJWkmI3AAlHOC0707tee
X-Received: by 2002:a05:6214:cc8:b0:8ac:a3fe:b94f with SMTP id
 6a1803df08f44-8b02815633dmr415501556d6.44.1776954356147; 
 Thu, 23 Apr 2026 07:25:56 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:55 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v5 13/15] arm: sc5xx: add missing boot env selectors
Date: Thu, 23 Apr 2026 10:24:48 -0400
Message-Id: <b5496d52e8093374b8c5b0ddd50d9943789885b4.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index fbb0565dac4..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,5 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
-- 
2.34.1

