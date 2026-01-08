Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF16FD1D483
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 18:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 356DD8415E;
	Thu,  8 Jan 2026 19:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jLTalEMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055688422D; Thu,  8 Jan 2026 19:41:01 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0718415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73161849e1so657710666b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767897659; x=1768502459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKmpJumNBylNqc2pZgl46uZ42qFU+8cUA5KqZKeGZBU=;
 b=jLTalEMC//CXQt0qdKLSE+XmPgpF8wnGX+DYkLznK69VHFwIAYMZC3OlB5fzbZ+bdN
 yZgdKrhkQ+Q3tImniEFfcAf3qTYt3N790NnYs4vETHL8KccUU01ewnvOJ+ZVOOh2c2bC
 w6qzjjKM8yXBj6fUPXmNpUoFt+4iwn9n60zX1E0FrpR36hV89a1tqX103rMGCVkwHOMA
 8P55zxcmvtJDTaKdBBv1KI2T79Q/jEf1fiPbaEslfJlTs7Bw+DaTutolQo1Wti3dLP8U
 tXyVghshJyrw4adqe7Btj4NCbnhXPQkJ4KRP2PQAn14ImmAtkZrKGsKOqjqGHpQCwR8e
 hvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767897659; x=1768502459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKmpJumNBylNqc2pZgl46uZ42qFU+8cUA5KqZKeGZBU=;
 b=VtsKRconG1VDGrPoqJFPoKR4GF4FX8DBexAX+L8BWOUPZrqZleDG/VE9C2LOP5NxXS
 hX6JSvKdKWuR2ITHPUGr8CUjJJfyGz26DZe2HRAWfTjPxAUTBW/uU+ZsV6RXb+M8xais
 N/+ko6L4nGSkdU0TkcoXmPy+aGFAzK/w/zymLjIajL1fHJIloFGqSNDcnWWZvsnGx30J
 kquULghJxe5wTKgQz/myPjLCL7it1n39jIuEHERzXbEEolkCIci7svlnbjNcmROUBUY9
 ll88W1qe41zSN7G8BNbRWd00YwGTZ/QozP/v2ibWz0D0zctIARPIiHZTqEQhtjSMvqb2
 bwqw==
X-Gm-Message-State: AOJu0YxM2JN4iQqaNtJq54S1zpO3DNT1ZyuVmZvbITwIYzT6e2Y5L6Oc
 EzdFKNSjXAmj7TeTeOWL/ZnGCjm/gyIIDuABMe0aEvAiHrhH9xou8oApHGwJQYSiZqU=
X-Gm-Gg: AY/fxX41GoXiLh6MUvAnjWDGRa/HARe9Zu8/KeW2RPzbOmHh6RATwnkJjh6r5V8vhNW
 1EKG+fSdr4t3aKX3fKSDNN8B0AHEKcaVrGrs2OLgIgiJT3p3OYbQDI8vJbnH2eFbpAR5ELdbC7Z
 mACwqo571uvbyY5RVqJ+upk9oPP6/YMG4K+OHR2fYUwngfKkgKmqPVb/Pa8tVl9A6BsRds5iNSU
 2FjJFxw1/rC3SMSf1aFmxFgC4MUPOItGnxh8Ohm4NKdEX/VBoU7wFz20PDwOknT5zsfe9uRRRtZ
 GpwLTMq9wfQMbPYg4oKZTyzgGXjhSABHjnfHo+J/9drD4BeDLneP24W95m0T02++nXKLR4rhkr8
 jwMx3MOr/j29gahu4XofPAo2kkqcRDt0fVyzda3wC29ClQcC/m09wrmwrG04bIkjjIjNDiJbgxl
 vLmLM+warn7yZSKCajatIKvD3epQVD1QbdTAElA+WvOauxB1ddHaZGBfr5GXsKZ+j/NHyi3VcR
X-Google-Smtp-Source: AGHT+IGOPkn2e3wNnOX2BTPXYzKcVBQA/yUCaO0G2jM5JWMunrcAerK8DJgVrTr4uZwC9Tyd0XE+7g==
X-Received: by 2002:a17:906:6a17:b0:b7a:9cc5:457a with SMTP id
 a640c23a62f3a-b84451bf366mr714955766b.14.1767897659443; 
 Thu, 08 Jan 2026 10:40:59 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a233fdfsm898021066b.7.2026.01.08.10.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 10:40:58 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] kbuild: fix out-of-tree build missing gpio.h
Date: Thu,  8 Jan 2026 19:40:27 +0100
Message-ID: <20260108184032.3084584-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

When building out-of-tree $(srctree) is typically a relative path, the
kbuild 6.1 sync uses it in more places where KBUILD_SRC was used leading
to issues like this where we create broken symlinks.

Fix this by creating the symlink with an absolute path like the old
behaviour.

Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 scripts/Makefile.autoconf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index e3c88badb529..522389e04e8c 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -137,9 +137,9 @@ ifdef building_out_of_srctree
 		dest=arch/$(ARCH)/mach-$(SOC)/include/mach;			\
 	else									\
 		dest=arch/$(ARCH)/include/asm/arch-$(if $(SOC),$(SOC),$(CPU));	\
 	fi;									\
-	ln -fsn $(srctree)/$$dest include/asm/arch
+	ln -fsn $$(realpath $(srctree)/$$dest) include/asm/arch
 else
 	$(Q)if [ -d arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
 		dest=../../mach-$(SOC)/include/mach;			\
 	else								\
-- 
2.51.0

