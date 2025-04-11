Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2ACC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 17:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D372F841E0;
	Fri, 11 Apr 2025 19:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cLnoOYlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DD1841E3; Fri, 11 Apr 2025 19:04:12 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BCF841DF
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 19:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-601c469cce3so607558eaf.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744391048; x=1744995848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zhOTrdnfFXiVRWzvauoXXNnH7fZsZLm7Zn7VR4X77zs=;
 b=cLnoOYlh8xodsp4dpi8gRpuDz0WSJLWB6K9j0bwgDNiihWch01+biJpAzxCajJsi/B
 nykTg84irX03nLLf2KfY1F850HqWK5BpbfEYGuZMW6yPIcUX+VBYkx2subcM4vbpAxIz
 BhCs2ajwa90MzLKQyOgRoRKMkWh1kALnHCDho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744391048; x=1744995848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zhOTrdnfFXiVRWzvauoXXNnH7fZsZLm7Zn7VR4X77zs=;
 b=JfFSX8/3FnzPH4L5wCXwtuBAE9i0rCOF2766mZc8FGJoXgya93DVpQYZ78CuJW90/O
 Hk/C1dewYy2qlpZbvOianNisEWeIarNTeosJYyihbc7SPcANtOnxXGtiAae/w5weUMUm
 yhqELLaJYBWbTO0LNP8oAnCWniqZmTbxTlE1K81QwiH3Sh10Vf+IgqMrepKvxnJxwoqB
 GLlnkL/XMD3UStMblsZ2OvhwcQfE1YQRQQlyhlLoXA8lvu4o9SmGzR6Cq7ftG1LbEjy5
 GJhH1Xk2xoDVQSvXlwADw4iXxZlKI+Utamx85xBT5uG3LYdQdDGqLaY3nQTcsUksfxfM
 GqTQ==
X-Gm-Message-State: AOJu0YyAsmKVmNi1ouj8CKjNnav7JayLFMCGt4m0Xw1X/YIfREHldn6O
 ulNZlox0N4ztQte/pUl9dB6qdYfoauxhcuLBdlDS+TM6DHMMIHs1ClYyH2YU0JvM9PpWYy7bmVZ
 mmWo=
X-Gm-Gg: ASbGncteI8khKsvtlv+vcAfYF8r4TMQkCLz9AWeVqEKjawwRS5twdpUqELsFD71UUG9
 y+Gz1CMc2UuGoqwn7MXoRQo2Sg9C97r4dK+TiqiS4d5Yep96xIzn/r3zjUxcs9gBo8M8MmzqjlV
 NQ8DjhCDwJE7z9qb2qZZ8L8LiuLLETjpJyEaSD1O6pCWVO2iWllkI/mKQ52FZr3Gz0qdKbDOehE
 QEtHulgw52ES6So6X2JalHrFyWN5kHo1sp1BSZU57Nyfq2S/4wlrj4C1Q0noccQ2VFSLmXx9fNd
 vg0ZLgz6i0sAthGd4xIonVsd3xPezHXwekWXdDQ3FW8RmQNmXpIoEbZP/i8aLhvsI9lXV5Wk8iB
 CzazD
X-Google-Smtp-Source: AGHT+IHe6lf+qs9zW4/QOxBTXkaR+K3NUWgXCJT5Zv5/a3OJOSbD/KQjh+AXfuyVArsJslV8GpXOoA==
X-Received: by 2002:a05:6870:6e15:b0:29e:62a6:de9 with SMTP id
 586e51a60fabf-2d0d5d5d133mr2008796fac.17.1744391047934; 
 Fri, 11 Apr 2025 10:04:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d52b7asm1035431a34.13.2025.04.11.10.04.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 10:04:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] buildman: Update to grabbing gcc-14.2.0 toolchains by default
Date: Fri, 11 Apr 2025 11:04:06 -0600
Message-ID: <20250411170406.3250498-1-trini@konsulko.com>
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

With the switch to using GCC 14.2.0 in commit 001bac5f16ad ("Dockerfile:
Update to gcc-14.2.0 and clang-18") in CI, we should make buildman match
this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/buildman/toolchain.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 5d051e005dae..f4c832be8d33 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -531,7 +531,7 @@ class Toolchains:
         if arch == 'aarch64':
             arch = 'arm64'
         base = 'https://www.kernel.org/pub/tools/crosstool/files/bin'
-        versions = ['13.2.0', '12.2.0']
+        versions = ['14.2.0', '13.2.0']
         links = []
         for version in versions:
             url = '%s/%s/%s/' % (base, arch, version)
-- 
2.43.0

