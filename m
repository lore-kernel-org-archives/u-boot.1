Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7658C369B8
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 21:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A141C82BF2;
	Tue, 15 Apr 2025 23:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qrbJu3bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B53820F8; Tue, 15 Apr 2025 23:18:39 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530C482BD7
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 23:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3472201f8f.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751916; x=1745356716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdMU/EbfK6U0f1W9N0eR+lOtwJhaDFZbo9KfaF/CUyg=;
 b=qrbJu3bbpilGZ22JuaIivtJH5nUgV+8MQw/5vjtrmdxzaBRJbcPvMPh1PTKkkLz7MR
 2UJdUyyvgw+l7TQhI228TY66Rl1yBKoXmj6swjQxcjtAzlx+PYt5h6/V3IZD6sY6XWNx
 pJQNlzATYCcbdVvf5jwvI+GbZLEsFLIMBgCYc/oTUQQTrOH14mB9qerwmHdonJ2OKJxR
 KLPhMEv6sRDAT8Ox9oGkMFol0qHIyWDV9rCHMonqa75J16FZHnv7RzbIt3TrnzZk8api
 jEBdpVZ8gkeSciQpGIJcuqWa/EQzWazC2sMAgBJbrzpJbcOxU7wSifzy7a0enLbVaaqe
 Gzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751916; x=1745356716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdMU/EbfK6U0f1W9N0eR+lOtwJhaDFZbo9KfaF/CUyg=;
 b=Ex9YUz4FCLR9My+t8vTwanyVCSkhb9vyZoXUn3QSCiWRHUC9ToqQh/WyLMVCqPxRat
 bRXlnlyxsAm+Wz8zOpa0VeqIyqBLddPkTsoMb1jktHVGgaom2KGoZ8OpYtUUVjeyPjD/
 mHv57/0o/4fVjngkNfEZFHUPcUkLRkiDRRtIWr2izgknz1hr749Ha4Dd3cX0awsvabkE
 R3LLjLRY/NF+t8CBMEPWgmtm7aAT6nT4a9D4QefalqUrbLcnbKwTl7vCOJQUfq8AHkMT
 nU8KQr9mSEyRFSJ2a3Ju5rlOqCKHpaReWV654kuE3BPjBxdzeAcu1NLDHX32OzJcclPq
 3itQ==
X-Gm-Message-State: AOJu0YxiLr2lfUVADKHINabW21RuGOKx2o+LTfnUVjJNo+p4BZ3W2U8Q
 o6VN/M7DryS0xkSuGP5NkxJ1Or5gRpP0U0UiZw07Q1bN+y88kskzegQGTDv8g5CNxvlP+eOr4xG
 YOwI=
X-Gm-Gg: ASbGncsjSz/RV7+H9KHhPgKtAWE0DxyfqUpyt7gh4huuv2NOhpm1uYLjWHIGcizGoqr
 c1NELuW2yWM4vMCzdadcpf4On8P+W6hyR7GMYVMYcG8VsMV4rNJCILzCfcwO3ThfJ9AT+qKeN1X
 bKBIlpVWmYTBWlmCWUawzAt8ANAHbR2DLuOVGOeVtN1/9SWYBevoCghXvIFCdxIr4tSE56R4TBi
 hykAZxfL1pi4u4nWv5tKlw6ZeGWL0miApy5lSB1Rm0Nb4Cx6WkWtXARGbOUQW1pSM8GbHg5OUG2
 6QpYIg78S0ZZZg9XiX/zopNRatmsatbjaWvI3Oh5GRxZce6sQ++ydzffuzA=
X-Google-Smtp-Source: AGHT+IF48AhT47KW9egV/fJaFxfDrHtHvfsHoHaNtHZiPmXjQ8NsmSSIIQ4CftFVdwnvZTVuldVxLA==
X-Received: by 2002:a5d:59a7:0:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-39ee27610camr757771f8f.40.1744751916684; 
 Tue, 15 Apr 2025 14:18:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cce3sm15530917f8f.74.2025.04.15.14.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 14:18:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/11] configs: add sandbox64_lwip_defconfig
Date: Tue, 15 Apr 2025 23:17:45 +0200
Message-ID: <20250415211819.1254435-11-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415211819.1254435-1-jerome.forissier@linaro.org>
References: <20250415211819.1254435-1-jerome.forissier@linaro.org>
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

Add sandbox64_lwip_defconfig based on sandbox64_defconfig with NET_LWIP
enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/sandbox64_lwip_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 configs/sandbox64_lwip_defconfig

diff --git a/configs/sandbox64_lwip_defconfig b/configs/sandbox64_lwip_defconfig
new file mode 100644
index 00000000000..0e92728533f
--- /dev/null
+++ b/configs/sandbox64_lwip_defconfig
@@ -0,0 +1,5 @@
+#include <configs/sandbox64_defconfig>
+
+CONFIG_SANDBOX=y
+
+CONFIG_NET_LWIP=y
-- 
2.43.0

