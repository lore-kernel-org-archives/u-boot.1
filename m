Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20378C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3C082CA8;
	Sat, 31 May 2025 10:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JPtj8B0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D8082CA2; Sat, 31 May 2025 10:45:12 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F174682AC4
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4dc0f164fso2619471f8f.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681109; x=1749285909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H4ND72Ylou64JJb89L+RAiODSpoWeTnC0TejW9RznGQ=;
 b=JPtj8B0AZEjzY/6ENOOYtZ/d+nGWvUqhmVJknDz6qO4Asw7VgQLu3KA9F/FKSUxFSi
 AF4MOIrO3PWcGzll3lPjpHUcIoY5+aK8IJ911x+9BNwVjx7J+bGEJhvQqiX+55wCQh6z
 WkMqRowWnBKgU+ZAFHRaMmd7puB8NDqxtvPmZdkNCZyhpK6FF+JX1TZuFCnFhvdvpJgl
 fbUkyRe2YK/31LnwKt9EluJc5szVZpc1kpEL4yiVV9oTCwEKzVLnwstP6vNeU+Kp6eSi
 0tE9py5LeSzKpL/XDlV3/uVXP4bs1n5ZcFr/Wmo1MvCiOIaQw2qzCClMjRjY23OsGlSu
 QA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681109; x=1749285909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H4ND72Ylou64JJb89L+RAiODSpoWeTnC0TejW9RznGQ=;
 b=jvCfQAk1uMU2fDrQfb/4XN1XHudrSggZB6eJgksgfhdK0BYMSnD7Iq7ETcYFC+UVK5
 SCynUEGy/jMy4zCJs37CNQol3cWZogPd1jjj9RufreXcOwzg9pfJ2VUuKp6x5x24HOGL
 Kfb98GHgKbn5m0ETFMQSnorUFY08OgKjskOl1CgrBWgUaJCUFGNn41lsPm2j/nMevdjO
 P3vXJLGapybivK4ggeR96QxfljWSFTWNv6HoxNIervUWT/fsxPFPCMb150FBi9FMSFYV
 A6+c7sJktNaEHMq2UCahHBuSK8q6zUo4iuUeydiFu7NJXkYYcdD1RF4iqkhEyQ6QVdCW
 ow2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV31d9HX6R2lDyvkwfeI2nQ1Tjj/1k6y51hmr+O+eForH6KJcYjkizs1Otb37t4fXMdf/Ts+IA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4QM4d7wHqrqTUFA/r2kPRTjIehZkgI3yNYCGZ6BYvAHQEXzbL
 /jfSr4UjUuflgQzGbHgJrE+rJoFzUWoxhucFPGajeulSTc63sj/GPuuj/0dpA9Tqzek=
X-Gm-Gg: ASbGncv9djxSIGKrek/C7BeupDPOZRdsCMz7EOz2JhLBPNOAH9LQ9Y2S0OXYjRSs9v7
 IT6F7/JjwlszsfFdOQCdMoLnbRAWAbK8xsRwPuNPeZRaxF5ld72GpnfEWKEe0HXJbMbafHMQ41H
 o829aHlJju9vYdu3coRzS/F/0k9xtohHAue0vciijgfZTcf6fq4hMBM7XhjzkFhKP4/cuSrUXzH
 JUp7rcpeP4yHUYeXtunPbNHaKe0nqpCeZIYcBjiILobwpbN4/ItqQTaJhLcg98K0jZ+O/41KtV5
 qWdE2CUayYfBJEQTfaSxbv/s2lG7gzRiz9GwYtTaA4YqHf97ZO04aTavjnmF/2gFnfBC1F2aRgh
 DcVoRDn5m/YqQf1GFrwwBK9KLdA4AaA==
X-Google-Smtp-Source: AGHT+IF4ZaT800zQfV85ZK8PxDZwjMIqOZuGo7Z25ZUb517t56Mvpmo+hhAejqrpRexGqlIslbRUOA==
X-Received: by 2002:a05:6000:144e:b0:3a4:d975:7d62 with SMTP id
 ffacd0b85a97d-3a4fe393721mr1166867f8f.35.1748681109418; 
 Sat, 31 May 2025 01:45:09 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:08 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 08/13] gcc-9: silence 'address-of-packed-member' warning
Date: Sat, 31 May 2025 11:44:36 +0300
Message-ID: <20250531084449.4125187-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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
commit 6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f190b40ef2c..055898935372 100644
--- a/Makefile
+++ b/Makefile
@@ -800,7 +800,6 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-- 
2.49.0

