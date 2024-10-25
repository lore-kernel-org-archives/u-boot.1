Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0E3D149CD
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2E788F68;
	Fri, 25 Oct 2024 19:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nQHxXAev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83D488E88; Fri, 25 Oct 2024 19:07:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126D18901D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so22466425e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729876027; x=1730480827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WL65VXqxCwCMKyztWyuoEJ+i9TDsstjDu9yWI5oej6g=;
 b=nQHxXAevwxw19GHVIs2GZXSlFDvh8BEVOpL040g6nFN+CoghRRYKuiLyy7PKbyvPxA
 F3dcahn2Lk5WWlasvaQs6iXbBAEPYNzI3GaYaOCrDbpvVjh4/CiughP4mWd0tFPr1k+w
 9Tvu2HT23KsDqsnUasuSFPYV2uFduEqpYudmj817fJxCfweD2FlWR5GU4ks5X3xuXnHK
 7U/ncMo2H1dIys3SJViBB2g8QmDkPjzaSVdQeeju1LYkvFbhKm7Jb2E0zeyGHVUeQA+8
 t6nflwAeD501CSzcgtuvYgtedeuv79I8ATDIw8s4Pvg5G5CqQXn4E7hUwwLJvDqSpTaY
 FdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729876027; x=1730480827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WL65VXqxCwCMKyztWyuoEJ+i9TDsstjDu9yWI5oej6g=;
 b=RUb8DikHLuCE0KxcFzhtOkgYWQ4GU/RdU5IPii0POIaqIasdIRkNSHQUA7edaqIuEI
 ba6fifbtO8EVCG/2TzRg/rsNT6U7748pKRLIQsYfdS2S6bp072KeqYloMbkMGNl/5Rf0
 gULQtnjkwT0iABYNQUZGSPcjqub5zlKki0LAYfVyX3jX2/qyZyYPFvC+S2FwitLgWuWe
 ADJJopWMAr+Z+g2rVywlYVk9tLt46VFTxg6ktlvmlw7kwBpqxNo9f0Hv1cylwVI/B/St
 O+CWcAwxCLgI+4PEdUBc30w4Hq+byX51kg2vPaCuFLwh6SBJfTM0Cduzg4SgekEvFuT6
 q6vw==
X-Gm-Message-State: AOJu0Yzs8XCSeqIAGjSWR0AwZUpf5V1EcY3k4CV2g1f9VrVqPjPftUlw
 gg424Yk4hwK0UqXEb8k5RRfQuZOcYrr/rBnud5SqeQAcfsSuxdbZ0aqSdL555HI7+eGLetsvZpZ
 frP0=
X-Google-Smtp-Source: AGHT+IG2ZM8FWoLjgYg1awpE2JS5jcYtv6YAFBYmmPbbjwFYZDXqgppEOo3ijp4ubl2VHidkOYBvOA==
X-Received: by 2002:a05:600c:1c11:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-431841aff4emr94956245e9.29.1729876027498; 
 Fri, 25 Oct 2024 10:07:07 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:ee89:e818:eaa4:afa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b567e18sm52862755e9.26.2024.10.25.10.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:07:06 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE
Date: Fri, 25 Oct 2024 18:07:00 +0100
Message-Id: <20241025170700.74440-1-andrew.goodbody@linaro.org>
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

The config setting CMD_BOOTEFI_HELLO_COMPILE was removed in favour
of BOOTEFI_HELLO_COMPILE but the usage in this Makefile was not
updated. Fix it.

Fixes: 6fe80876dcc7 ("efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 arch/x86/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 7677c0c352..43e6a1de77 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -97,7 +97,7 @@ endif
 else
 
 ifndef CONFIG_XPL_BUILD
-ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
+ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_BOOTEFI_HELLO_COMPILE),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
 endif
-- 
2.39.5

