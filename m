Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE7CA100B
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 07:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F7E8346A;
	Wed,  3 Sep 2025 09:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="LDuWt38m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F7A8349B; Wed,  3 Sep 2025 09:05:19 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1832833C6
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 09:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61cdab7eee8so8646690a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Sep 2025 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1756883115; x=1757487915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VGuWeqxI87SaFMRdQr5H6nMw6erukwGqdANyvII+ceY=;
 b=LDuWt38mAe2rT8gQiCsR4QS+RStv5oRdtRumRBQjah4/9jTc3hJZN+7ZXJHre4gIux
 qN5lHfPCAUtC8nziHCzfzRhvxu2tqsnI5qukCOnMr7ZZVDgCG3uFlIZY0jByqcwtIIXK
 bnOloqqMiJsvnwvnNEwpr0TDYpUUsjUmR/vaAK8hMXodvcWB5rgOAMdS03PbBTYgOkym
 8B5B9/lVep2Sn/pSa/nCR8uhJ8uyLriR2tgpnD+36Vl4g74nYl7heOPwqoYhCMqxmfCo
 NIq0kh2vRrRf0yTKR7SKKSAr1jBP9V8jRXWul5QZe00Bt6gUsa89iS5et3ZA2LHUdjwF
 wp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756883115; x=1757487915;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGuWeqxI87SaFMRdQr5H6nMw6erukwGqdANyvII+ceY=;
 b=cy+tOad8JFxv39Z45oa0IUjaSazR5wvvkFyJaAfikMNAwKTQVvJgDUAdYRXUEf776r
 YwRbmmfZx9friqMEbVk/llM+kKRJZTJwum3Da9fMxjfEyQVMbzgt9nJ47wu4Dgrt2sIz
 ydB5HFvNWHo/PhS7gwktiwFNA8XaXVMebO6w1V9t6Xo8o/wHjuiC6DScO6A4vrp9zWJf
 aXCMK5x1Rn3J0n6xLihsg1BZJxnbCyzIZwyMbommPpKQrcU5W2kmbnAp44yFoFyzDP7J
 xOzWGEnsWjud86ttIzks74GMvAR6VOU3SrwZlqelbrUKXRVjJnuSxJJS26pHaGubkVz8
 MVNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5jqh6iTt0BK3vMXiMt+V51z8sOCOszyfQY/wg4zmCSn0pLNlfQGZaBBH3ijJeCFs4q0MV4YE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxo9aZrVogAsiQlVfxYWJMdLDEv5OBM5jdMpUGmCb/D/9QPMfoL
 Mu5AMI4l13MYb56I1d0bIpuOMBlDqWv2uggYdtGUWo1nNHqEESRlq0NwvUr7LjMXwjk=
X-Gm-Gg: ASbGncshJFY94HAvzLozyUZk5uQpfbMXedDP+r9RqNGYsxLYPN9BoDT8HJb831ZPGXm
 IQDXNShwb7xw1IZqsEPyItStytoZ/oQ5UADUITm4ivAByQVdYQHcbs8ofZ26HxgIW6pVRoW2Hsd
 RFhsr9mk4OY31r4emwPej+Un/92NtcCOsCT4X6YGDLqw4VJ6PULNsX/5hIDolykbuBjg7V4E5H5
 RUY+jzIBxGmi/xfQMLgTFtcdbLmjBX4agzRXa7/1Rq5t1gsbAj4wQIPHAbNeq4IcWPUqA8WuVTC
 K+We0Ha+AMBpyuAFDIJo90xZexuyOXTJEl+6itKbWdKAxI4Ie81IqQCoHgOWbOiGBVZA9exxz+T
 mfapyyWVZuGq2NTh4Qn7bE1371upFfqbDFANcTRO1rnwvnhZzG2dCzFqEAYhRwB0bOkAiuMZuaU
 gYjw+K54qmq9tJnnvOj6UL/Eyka4c1RDbqW/E=
X-Google-Smtp-Source: AGHT+IEk5lmI3snGGbprwfIHVJhyyYBN9U+NV9Fwjb/mc8nIJ/ZeXqXW4m19fXT9nBpIV0wSCb9B9g==
X-Received: by 2002:a05:6402:34d0:b0:61e:8f70:ee26 with SMTP id
 4fb4d7f45d1cf-61e8f70ee36mr10217128a12.38.1756883115072; 
 Wed, 03 Sep 2025 00:05:15 -0700 (PDT)
Received: from T14sGen4.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc5572afsm11323095a12.50.2025.09.03.00.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:05:14 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH] configs: Fix crash on coreboot x86
Date: Wed,  3 Sep 2025 09:05:01 +0200
Message-ID: <20250903070502.136681-1-patrick.rudolph@9elements.com>
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

Booting u-boot as payload with coreboot's main branch is currently broken
since commit [1] on x86 as U-boot assumes the active GDT matches what
U-Boot would have installed in start16.S.

Make no assumptions and always load the GDT when building as coreboot
payload to make sure the segment registers are actually matching the GDT.

Fixes #GP seen when booting U-Boot as coreboot payload.

1: https://review.coreboot.org/c/coreboot/+/87255
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 configs/coreboot_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index dfb97a3d302..033746e4f91 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -66,3 +66,4 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
 CONFIG_SMBIOS_PARSER=y
+CONFIG_X86_LOAD_FROM_32_BIT=y
-- 
2.51.0

