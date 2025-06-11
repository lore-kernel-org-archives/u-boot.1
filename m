Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4822C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61D082CD5;
	Wed, 11 Jun 2025 22:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KEG+PnAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9BCB82CF5; Wed, 11 Jun 2025 22:25:21 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF36A82CE7
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so1004854f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673519; x=1750278319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yi2f56CKH8KBqCyNPpwoXR98HlpxYUiPmL22p+iKl4w=;
 b=KEG+PnAAzpa621IBYp5v/lrSoGFC6+7LxCJ+eDKSmuYL+x02PaeItyaOJe5k0+XCmY
 YgMhgOq/8KFN581fo/ORcvtr8VWft6LCC/cwBZHch3SxVWho4n3ZUuaGZ2F+JCQTkYNE
 dJjger4QY/cDHztYDhq648tJQ3xq1y008RxrCaIiWvzrfb8EFJtjaonw9TgHcx2JloQ1
 3fPb+a747p2nCkI1aAkEOA0ppI/HoZXHwnnK3DSnCIspG+Ya0IXHBb+YJbZhDOi86Qzm
 pkmgFEk0/zIf9hUEZnz5+2LoZGZEvAdRE1MgVyFaRxYg61Tp4F9WSn79jcNKkiNA8PfG
 C0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673519; x=1750278319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yi2f56CKH8KBqCyNPpwoXR98HlpxYUiPmL22p+iKl4w=;
 b=A8Zs4vKvEycdC9dpSXC0k9iMGxzZZfAUyPdqgD4wOU0jhtYXBmZ+OHGuwYdSWSqcb6
 43TdfNCFsBXYfHG5EzcNIdrER0J7D+8RvViltBuO6O1lv2qzRgYrtDI7uZcXsMN+OSR2
 JfUznu3zCc5qVrQMgftmZhQCMVPG1XsU04CTmZiTpRTu8cbmTazV8KiLXFHAQG9s+0LF
 aceOUa5gI9fWmjTJXalMsc5Oz53PY0zherV38MSNKdmRuP9zamkYO6XvX5VyQdmEz1Mf
 pMYqaZONzgv4lCY56C7bUEv+8OZXwxRmlidGC/VM2Q5FuPtDkstyyMPFUFYalUqbARmA
 Wlfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp90Rom27L29JOeGdJ3y2BzADJOflf4OmwLvoRhmyyef13Y7GJTmN4yOjIIOiopLsiVyHXq74=@lists.denx.de
X-Gm-Message-State: AOJu0YwANRONYsn7GLv7rcfyjTM7AfB0sDpArHZPszNbmwPbpAJKxW4x
 eyFohWseCAKe9EdyEIBK2+22jTa3F1qQGr3CdNkX6H5y6xCe04JDew1LpF+7K15e6Pk=
X-Gm-Gg: ASbGncstpz4SmwgDfb7ASlEHQfZDUV+Qs7i4o3tj1zdP6pyysFmbpsCJzq+OYi96zWR
 ydlpwUy+7a8NKTvYDsj3eARb4o9I1u/w5jt7wUdKp1nReMYRNSm5feWlm7xp11NX2yFJ73OrLos
 phtfdMge6TCd4zsv+J996fwa0a1JpcTmCimfY3sGXRW/5v1qe0khcKikvBH9c3oa0iBurvCiJne
 nqaL1XMXsLy3mHh3p4ygjvL/FF5xzQfwIL8mH8a4GI6BePHcWwkpVyAhWmBHRKLwbc/F9MKD2fO
 TpEcSl81M8GoA/zkxcYfIpLG6Mz+mW8qhCTq+fPaiMCHGnaAm+r5tHVAjuuGrcbV03vCjBZO0VT
 XPEhbPryyMQLFgJwM2RGU1yRjYyRkbZgE5EFmhYit
X-Google-Smtp-Source: AGHT+IE5Jg+XJXrk8mYA6IiTbXZx+QRgRw8d3Iy+78Zb83UPJyaYalL6AS7icaUzNwC8LGLHNrjs1A==
X-Received: by 2002:a05:6000:4029:b0:3a5:270e:7d3 with SMTP id
 ffacd0b85a97d-3a5607fa06cmr565109f8f.13.1749673519374; 
 Wed, 11 Jun 2025 13:25:19 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:18 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 11/13] kbuild: mark prepare0 as PHONY to fix external
 module build
Date: Wed, 11 Jun 2025 23:24:38 +0300
Message-ID: <20250611202449.2317279-12-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit e00d88804814 ("kbuild: mark prepare0 as PHONY to fix external module build")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4e339ef4bb9c..a31e89d77490 100644
--- a/Makefile
+++ b/Makefile
@@ -1739,6 +1739,7 @@ u-boot.elf: u-boot.bin u-boot-elf.lds
 u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
 	$(call if_changed_dep,cpp_lds)
 
+PHONY += prepare0
 # MediaTek's ARM-based u-boot needs a header to contains its load address
 # which is parsed by the BootROM.
 # If the SPL build is enabled, the header will be added to the spl binary,
@@ -1950,7 +1951,7 @@ include/config/uboot.release: include/config/auto.conf FORCE
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare prepare0 prepare1 prepare3
+PHONY += prepare archprepare prepare1 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
-- 
2.49.0

