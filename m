Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC9EC0219B
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 22:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB4080EEF;
	Thu,  6 Feb 2025 23:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RifJrDDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF0980F0B; Thu,  6 Feb 2025 23:39:10 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A7480BAB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 23:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-854a682d2b6so97795739f.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738881545; x=1739486345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zHHTtsZ5bxBDxH/vbzOPwK+fgIGUZY4uQl0XDphamY=;
 b=RifJrDDSkXdaCpMPn1aoqPwGbH27E4QDzjiTG/NAOVWT41PrGFaQy0NmsYnyi3vlM4
 Zo4ojnkYMYt84oqBEwuqeMffoQtCvPZ29XQPR70GilYIEOuS+hmLBlxesICsB38PMsZS
 WO1BL/StfJPqFIHcIfS8+QWWNFOClmOhvoGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738881545; x=1739486345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zHHTtsZ5bxBDxH/vbzOPwK+fgIGUZY4uQl0XDphamY=;
 b=hZs+e1gOxgddI5eV1eflR+EyESuqyrqFG6Pu8PXml8wPpom7xr4kmPOnpeZM7RHDWY
 rqKyo8fQTnDp0l740Z4LnVIbFxiBrSuUJBhXW6Xv3CLoML4noAueM4UVhaVzLkva1W0T
 fCc+rGuBc0oKRnZkcTiNFhJQRsSxmhlEHw92vNr6EV/2jDnxyuwQwPxunWbpJ2lzGTT/
 7J7odAcNAr3qnIN9qIQlUnfb2mbYWIVi13a+uzDoMmCqN7vphszqIdU55yMD9o6TauFH
 lsJtXgGmn8pzPTM7fj4UyiDi1X5NrWhDGU7jYcdzk5vOV27jqK4oxkB9jeerEIcpLuWD
 1t5g==
X-Gm-Message-State: AOJu0YxAg8O6fDKUEiPFw83I/7jqHsyH+sxphSYHMPZG8t59t3IJW8JM
 lufV1JBo572Lx3mF/AehEhXYNh87Q9wOP3ktD3ClmuQrNnlMIIxWn9ZTEpHnTs/P4SzPw/Gfgco
 =
X-Gm-Gg: ASbGncvkKLlW8aG/tm6An7jpXAtTGZ9J1vtadhIyjI9w14xDwk4eVL4LFoMG7CNhbXt
 cplViQvU0Ye/K0KiZhkPsq/N+/KLQVHPBBNxORTjQ+bV5Uoxme511hcdzoYgzmPiJdKKf/8YcHz
 zF67XIOouadp4cNNOfpQjGR8Qmf+ywdOdSLas8ue3PwSMRetA3HNgvs4jJVh+DEnrmjMVzeMR6M
 L7o+E6bZvw7ndhD8jQOwAsrLnj9t4zyfaM8R00R2zxi2jtwsJYS+y+hEiUgZcfMdTmI9jgzPeXT
 IDGAUUVwK0x0L46yccJso0HUt4IiOYMrvtXyauRaIM4D/KbDP6k9
X-Google-Smtp-Source: AGHT+IFYamYogK74UMhIBxmFy8mY7BWtNmGd8Vv08VlHsLC3D8NEx8vBj6hQ2Cc2hRAzBxIbqmC8WA==
X-Received: by 2002:a92:c543:0:b0:3cf:c17d:5cc0 with SMTP id
 e9e14a558f8ab-3d13defcbf2mr5817815ab.13.1738881545672; 
 Thu, 06 Feb 2025 14:39:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e87921asm4583335ab.1.2025.02.06.14.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 14:39:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/2] CI: Use different git-directories for concurrent
 runners
Date: Thu,  6 Feb 2025 15:38:56 -0700
Message-ID: <20250206223858.64672-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206223858.64672-1-sjg@chromium.org>
References: <20250206223858.64672-1-sjg@chromium.org>
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

When running multiple runners on the same machine, each git repo should
be in its own place to avoid them interfering with either other.

Link to docs:

https://docs.gitlab.com/ee/ci/runners/configure_runners.html#custom-build-directories

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use GIT_CLONE_PATH instead

Changes in v2:
- Put this under the global 'default' part

 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3305f7b4df3..85639ffb358 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,6 +5,7 @@ variables:
   MIRROR_DOCKER: docker.io
   SJG_LAB: ""
   PLATFORM: linux/amd64,linux/arm64
+  GIT_CLONE_PATH: $CI_BUILDS_DIR/$CI_CONCURRENT_ID/u-boot
 
 default:
   tags:
@@ -12,6 +13,9 @@ default:
   # Grab our configured image.  The source for this is found
   # in the u-boot tree at tools/docker/Dockerfile
   image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240911.1-08Dec2024
+  services:
+    - name: container-$(CI_JOB_ID)
+      command: ["--rm"]
 
 # We run some tests in different order, to catch some failures quicker.
 stages:
-- 
2.43.0

