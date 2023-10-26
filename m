Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA86DC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 21:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7F758744B;
	Thu, 26 Oct 2023 23:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fm20Xijw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2781C87B80; Thu, 26 Oct 2023 23:00:20 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE7887644
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 23:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b2ec9a79bdso871434b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698354016; x=1698958816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DTO2Nms3PyPIUnoGqtsEjizj28yYh3SY3etDDJmlpEU=;
 b=fm20XijwMX6PYx96CJjL2FdXHL679xUPvTvD5cfHa1GsN+LYYsrFXDYGXreT6+3Am9
 t9l1Sdxtz/2JuH+dy6cEDHP6RuOdGlMm69vYiHTEBgPGaSVEMcb+E1T5vvj/EPsTjylr
 9MBXaqQhV3hOJRvp4VflG45RPCDF7KZhWEdfCEIcWuO701bg80VoiGfKS9/pq66sBhyR
 IdHo4IhptF5RDjL0/TbzVM0jtamxFlhzXfFwW3jnsfQB11AOSxZ9dI5E2aC1bOJrsGTd
 7zeysP3OAmV9mElZiiQjXrfns0T9yQjxCvN1nI0tQPcIvrzSbiOQLDvOYoX+0FtI30rl
 nbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698354016; x=1698958816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTO2Nms3PyPIUnoGqtsEjizj28yYh3SY3etDDJmlpEU=;
 b=QxwriKUNnnv3EOuVd8ROUJOB86QE5/HBL2/WWKgj6AjCMqsLSg2YQ4FJ33B+63MG6F
 g6ROG5nLfZkNQnyXHioTG3MXxloMqT0vZGLQ6ysRrKUSJ75nefpSvjKkZyZf5edpE9ar
 fh1beGRXMsMsvInS1aFdv9R/Zivsxp7qArYABNq8NPmpOFbKASQYHQ7oZYIFtzZXPoLj
 ClXlyn1Ks2C7cQVskpWVlTBUuospLuEdGcAdhI+8GII61BjDC/yviWAPys1CG3VQgCXy
 8jFo8kNR5w4HJy6G5ihDwI0XFHDktbvAUHmUyjIj3Yhgud9eFtyKu3Q8WH9JozR9wppG
 dUaQ==
X-Gm-Message-State: AOJu0YzXDoOobjp7iVEXXuLkJNnKgigJK6p+wElJ1Nfr+5UW4uyxapdm
 kY/tt9b4HDzgAmb5VjOCZ4PF3g==
X-Google-Smtp-Source: AGHT+IFA2LLFCkKuTA4CxQx9qtLzWS4hIJHV0R/ZuxsNpsqZKLW4gPa5ruckvGzPnmSQsoBc0PEd5g==
X-Received: by 2002:a05:6808:10d6:b0:3a9:c25d:176a with SMTP id
 s22-20020a05680810d600b003a9c25d176amr739776ois.36.1698354016087; 
 Thu, 26 Oct 2023 14:00:16 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 u23-20020a544397000000b003a7a34a4ed8sm28975oiv.33.2023.10.26.14.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 14:00:15 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: John Clark <inindev@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] tools: gitignore: Fix tools/generated path
Date: Thu, 26 Oct 2023 16:00:15 -0500
Message-Id: <20231026210015.17802-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

'git status' shows 'tools/generated/' after running the build, which is
wrong. The corresponding .gitignore rule was already added in commit
c623642d29be ("Adjust gitignore for tools/generated/"), but because of
superfluous 'tools/' part it wasn't in effect. Remove incorrect 'tools/'
part to fix it.

While at it, remove tools/ path incorrectly added to the top-level
.gitignore in commit 801c482207c7 (".gitignore: ignore misc include,
simple-bin, and tools/generated build artifacts"), as it's required in
the comment on the top of .gitignore:

    # NOTE! Don't add files that are generated in specific
    # subdirectories here. Add them in the ".gitignore" file
    # in that subdirectory instead.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: c623642d29be ("Adjust gitignore for tools/generated/")
Fixes: 801c482207c7 (".gitignore: ignore misc include, simple-bin, and tools/generated build artifacts")
---
 .gitignore       | 1 -
 tools/.gitignore | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index a1a79e92feef..330148119264 100644
--- a/.gitignore
+++ b/.gitignore
@@ -61,7 +61,6 @@ fit-dtb.blob*
 # Generated files
 #
 /spl/
-/tools/generated/
 /tpl/
 /defconfig
 
diff --git a/tools/.gitignore b/tools/.gitignore
index 941d38de212d..0108c567309b 100644
--- a/tools/.gitignore
+++ b/tools/.gitignore
@@ -34,7 +34,7 @@
 /relocate-rela
 /spl_size_limit
 /sunxi-spl-image-builder
-/tools/generated/**/*.c
+/generated/**/*.c
 /update_octeon_header
 /version.h
 /xway-swap-bytes
-- 
2.39.2

