Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C896D60D18
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 03:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4F77892FD;
	Tue, 19 Nov 2024 04:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IoWORslT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3DA89258; Tue, 19 Nov 2024 04:28:05 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9EA8937F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 04:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ebc9bda8c8so1038101eaf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 19:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731986882; x=1732591682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmFrRPhacWvzoUIa6wEzrKeeHU7HJ9ZfHe6nVev0uvA=;
 b=IoWORslT9Kkqyb70Mh5pR6SyXDYO7E4BSlGAqJaCe+8dQMrKyZQCKrZuvLEOJloGIU
 zjV3geFXuY8JFxD4+HZNdW1BXWo0iiuuY1UbS55+2zB8z5buyMUl+DDMfD81EqZvj1WA
 ijGXFtEUfyZ87iJyQXeSqgDo5MuUXe8Q2/JZGx4OeitSBNrKkhxneKf6t/TRfQQJB19x
 qQgexlCUadchWEPMZkZkHoqNrpnTDLv3ACkiXF4q+wqKrvSwgEkoEhVirLyWLqpZOK6y
 bNbT0/KnGU64dDgxhK2sgnRF7E11lJ0XDByG2BOkdg9f8MscrzXA0BQSEurboGn2FZUv
 IOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731986882; x=1732591682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mmFrRPhacWvzoUIa6wEzrKeeHU7HJ9ZfHe6nVev0uvA=;
 b=qcGjv9wdxCrlIxwj1uBd0WY1QWz/OzgacxUqkmf02rAqsI6PKGCr8VLDn2upetRYwQ
 JSnlXqcDjawEvAAs2XCo6qMjvJSCpB85LKkwICpNXptYjVtZrfwwMKkkwPVFQNArPbUz
 I4kXbucwSNRlbfEvkL6KmZqj9+fLoKVukT+zE2tPvNYSCLztGcKZ1sgUmw0qnxWEgfue
 FrHOY+8L9sz96Y059j4/+2eusdTojKd0u2/Su7MWACp4reHeC/gDakr5/YGacxXOXRW/
 +KyAqog4eQG9FdZQH1Hp5/9ImDtIOdSy21uAMAPAauqfrmMGHii3swQAsNPoms4DfFkf
 bcUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+g8SGok7iQaXUHVPD25/1FiQQLM9YojPuy1vhkJOhzmWOaIL9Wr3u16it6AT/XpzQ87W0Qvk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj1bo/n967KUOKMOFjIhIjgpd04W65DsgRYgOUEgfrgQvjkc+2
 DchhKWcvARdlOz7eonKa1G0h4vrkKCkROcLN8WKlgOCYhZ7f8fjqOQY7gaJZv5I=
X-Google-Smtp-Source: AGHT+IFiXmCPFX3i/7uhv3CAIhHby1/oO+6uAPnN1Joz9e+Suh0+0664BFoNSOOe/8w4iYP85RqCZQ==
X-Received: by 2002:a05:6808:2111:b0:3e7:5b06:ff61 with SMTP id
 5614622812f47-3e7bc7e2c61mr13073249b6e.21.1731986882008; 
 Mon, 18 Nov 2024 19:28:02 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7bcd24cf7sm3448298b6e.30.2024.11.18.19.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 19:28:01 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <promsoft@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] configs: e850-96: Disable PSCI reset
Date: Mon, 18 Nov 2024 21:28:00 -0600
Message-Id: <20241119032800.14045-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

PSCI reset is not implemented in Exynos850 EL3 firmware. Disable it to
fix the reset in cases where it can be used, e.g. when running EFI
selftest.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 5797c6cb1f99..c36196c510c5 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_CPU_INIT=y
+CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_TEXT_BASE=0xf8800000
 CONFIG_SYS_MALLOC_LEN=0x81f000
@@ -9,6 +10,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
 CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
+# CONFIG_PSCI_RESET is not set
 CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
-- 
2.39.5

