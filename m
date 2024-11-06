Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5484DD44D54
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 12:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05A8891B2;
	Wed,  6 Nov 2024 13:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K8om3Nbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D502B8902D; Wed,  6 Nov 2024 13:42:32 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA283891CE
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 13:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso78019545e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 04:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730896950; x=1731501750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MxfjCOJ5WHlA62DVkzoVlYnqLPtXOP743mvuHSV7/HU=;
 b=K8om3Nbc9131pLpTjxZJjjG/RMq7SE72ezubmTNrekhWJ1uMTuMOlCQ/ub0/mE/QfT
 3OmXRBQJbwvO7WY2cotXHA1TvWwmiRZ3L4iKPH5QNlAha4Cn+mbFdJO4Vm+EtF2cGbk2
 7mvUtb557ZpPFSfNLimgFB+F1DMqHJyDsY1dvMXpTbRAgGzpDxSrxVXeXbNjeaQ2vQhd
 ZUdbjRxqdrsFzI9pSfMvzI87dvgxxMlZBOTGCS6ZX968ARGhhjWmSp3DkFTeIWZD/HC8
 4CLYORdnsaWb7NKc5qfpN/95CSX2Ya5xXkGcLIBcEwIOrSDCOzH0fxxQyZ4VotZ1JN7X
 ftMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730896950; x=1731501750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxfjCOJ5WHlA62DVkzoVlYnqLPtXOP743mvuHSV7/HU=;
 b=eDAPEsEGRbXshbnZ2jHqCJarumm7gppADOlS/9y9b548gHctxx+zcRaLgIQ6IGQJV7
 yEjwQ3rvdWW2FK7nTMgEAiedFGzApN9FOJv2cTwgLja1EnN8BBFILevyw2LuVpmBFX85
 hROG8spM93m7yovZeTnUcH3+zz/eqo4T602DdBgbmq87AzbZFTkdn/dsA1oS5YlMZKpA
 SddPadCqzhv7iGsJ4+nx2Df7Z22rwaqprMwuUMJBcAe4nrwt5aDuyySNKbM2BrDaQPP+
 zwFuOKyqbjAI8Lp/c2qH0ljFtCzWbApYGnMFNgStx7eG6IGIRQ0atVOJ8iwSbG+Plsw3
 iC3A==
X-Gm-Message-State: AOJu0Yx0PxQVBJBzYp1Bbx1WcIvmdG8CfnPaKL5T+wM68mrhq+Ppj9Wu
 3XSiQOjFbCa4u+VGsShGDGSQuyQBLTwkt107gJre+hdbK0BG8mK2JUwAKL+MWEyyro73l0acsQ5
 EyaqiV96y
X-Google-Smtp-Source: AGHT+IF4kF3sDS37/iUFLOL0DUxqHIZkRHAkstNv60jB6dXDK38vvBoINIqLnTWtcWBpHdDXC3hi5w==
X-Received: by 2002:a5d:6dab:0:b0:37e:d2b8:883a with SMTP id
 ffacd0b85a97d-381c7a464c6mr20795164f8f.12.1730896950330; 
 Wed, 06 Nov 2024 04:42:30 -0800 (PST)
Received: from artemis2.elfringham.co.uk ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116c13asm18884765f8f.109.2024.11.06.04.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 04:42:29 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/2] Select CONFIG_64BIT for sandbox64 and x86_64
Date: Wed,  6 Nov 2024 12:42:13 +0000
Message-Id: <20241106124215.677519-1-andrew.goodbody@linaro.org>
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

Picking up a series from Dan Carpenter and applying requested
changes for v2.

I had previously set CONFIG_64BIT for arm64.  This patchset does the
same thing for sandbox64 and x86_64.  (Mips and riscv were already
doing it).  This CONFIG option is used in the Makefile to determine
if it's a 32 or 64 bit system for the CHECKER.

Makefile
  1052  # the checker needs the correct machine size
  1053  CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)

Changes in v2:
Resubmitted by Andrew Goodbody with changes requested by reviewer

Andrew Goodbody (2):
  sandbox: select CONFIG_64BIT for SANDBOX64
  x86: select CONFIG_64BIT for X86_64

 arch/sandbox/Kconfig | 1 +
 arch/x86/Kconfig     | 1 +
 2 files changed, 2 insertions(+)

-- 
2.39.5

