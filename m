Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BFFC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFCD87CDD;
	Sun, 17 Dec 2023 17:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UJGcdYrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880E587C8F; Sun, 17 Dec 2023 17:36:47 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BD487C8A
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7b7a9f90ee9so86999839f.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702831002; x=1703435802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dChx4HXIUKydZN0FiPhsfdENh7VS4BfMISUzsAB9qI=;
 b=UJGcdYrM+4Rjj20rG6xrOZpo1M+evV0bfQO1WcA9i7IGuOGUqB0Y/5ElM0VsE2nqUl
 uZbPDKXNt/QWlCBEWtNcyXzyT47vj4Syhi2YmtnMKRmSAq1hOFJd8CkFKMqyV0OkfB7H
 uh0CZBowAF2uQamWVjB3ayr0UuHZp9/MtLCT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702831002; x=1703435802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dChx4HXIUKydZN0FiPhsfdENh7VS4BfMISUzsAB9qI=;
 b=p/BV1mFa8TIFtYJVWDBzQ5sgZJ2qnwZ9FguB9le0Pmmp85MY6H6SB7oiN90iQ6r7uH
 QAYe29UujieO+t9mnhpkgUCOtNfkm3giKv6Lp73RvSFDCKLpxzG43l6NAlPQUTMsdK1W
 kqgrVHym/KW9dLNgFbF6dJMwr3bV1U0RUdxQTD/gjPZBtHB1v1LtUnRdCCHGcIate7e1
 9dZNLlblcAzLj8GJqeP3n77y0VF3altF+s4u3kjBJZIVFpveoXNuMpWgOuN+hy9s/IDr
 4+iuHhiTYVm0PY/E+kKA+qQwgCOSJpigbAnTe5SuVZVynAGZtzwkW+EbZzmFRlr8F9VP
 7m2w==
X-Gm-Message-State: AOJu0Yx6JOSZ2+Drv9kbmhIttvKSW2eqTVeKvI1LuCv4MzXyF/GAkgM4
 76/GJejqSfiaQ4ObIsTEBFYlxJbESWjG1ecJyHJprA==
X-Google-Smtp-Source: AGHT+IGXGM8nj7l27UPKCRywa/7M2L+30trSz7qMneh5TcE/U7YfWTkeovKuUWDmMKbeAtYTlVGiUg==
X-Received: by 2002:a6b:90c:0:b0:7b4:28f8:3135 with SMTP id
 t12-20020a6b090c000000b007b428f83135mr14562249ioi.41.1702831002086; 
 Sun, 17 Dec 2023 08:36:42 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 10/10] Makefile: Use the fdtgrep -u flag
Date: Sun, 17 Dec 2023 09:36:23 -0700
Message-ID: <20231217163627.2339802-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

Use this flag so that the bootph binding is obeyed correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8dc6ec82cd56..21b1f7daa72c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -631,7 +631,7 @@ fdtgrep_props := -b bootph-all -b bootph-pre-ram $(migrate_spl)
 endif
 endif
 quiet_cmd_fdtgrep = FDTGREP $@
-      cmd_fdtgrep = $(objtree)/tools/fdtgrep $(fdtgrep_props) -RT $< \
+      cmd_fdtgrep = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u -RT $< \
 		-n /chosen -n /config -O dtb | \
 	$(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
 		-P bootph-all -P bootph-pre-ram -P bootph-pre-sram \
-- 
2.43.0.472.g3155946c3a-goog

