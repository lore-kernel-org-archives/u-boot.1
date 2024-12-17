Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438C3E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 16:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC408022E;
	Tue, 17 Dec 2024 17:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UkeJJstP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB74380239; Tue, 17 Dec 2024 17:00:10 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080EC801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 17:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso59750915e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734451206; x=1735056006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xidtNStbnwE+v0UOCwnLkOTG7ANuPpQ1sto+3K2OWSQ=;
 b=UkeJJstPweJLnImidwZNCP1besY23MLzSuJQUdgegA7irVoRz4GvQHQz3aih2veHSS
 nXK338tthcMBPO5apeQql2gl5dzGyaCQSXDWVFWfaielECJVrhrhkYR7hKwCrL6mS7Bm
 /iNjZrbFwDBFh8lmIVFFcQ+pwWcRJ8Ub/GD1lHKj3j4QsIq1KBez/9vgzfpKJYl2mNYP
 plnKI0E5ZN7EMn1RXz3GUkEiTJFd0GBWXdKb7aWR3yI2aR/FUX/f7dF0VQn70d6/uYaa
 wueF73OJ2Z0a7dgHsrA1CrC5tJCbkCTDmJhb3AwKkWpj2sCnP8zDQUnnO5tE30wAjBfI
 bLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734451206; x=1735056006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xidtNStbnwE+v0UOCwnLkOTG7ANuPpQ1sto+3K2OWSQ=;
 b=AEdBqFNI1tR9yc39XI/AGcp64QGZlHLmCF8luwR+e/8jCVKKFIh+K0GCLpfgAdn1Gy
 UePnsMKk1mn4ea5jZIjnUpXdYvxACg26kZEbEsNhxFKPvnk+Ue6AqtC5gPv4tHhigoCV
 foO+ruqdb3vuZK4yMc72Y35cICrGI1C0rNI4I+kZGyH1Vzh2Azlmr+eMDvYV5fKAi4+F
 rI8o6MPZt9e+f8Md29d4ePcklEcMpTV1l08ThXAd+1HOcVvLlJ54irONSzsTV5i223uE
 4U2FSgYbmDSTN1gquL7DXYmCoXyRtyKsViAhd7FFHnu0z/eEB9Q8GRoMSnFXj3WiZqhE
 rOhA==
X-Gm-Message-State: AOJu0Ywaa2IeX8+4hlbxxxjFrIX12xF1vutdXZIfQ+zDwpq30PAy+99z
 BHVqxo6YPSf39N2xK/k+1VVf+O8LRxunjaXq1m8wPyfa6259Vtji8NEuZc7WO/rwej0CJ3+Z158
 Y9fc=
X-Gm-Gg: ASbGncvdE4cL2RtZyCoUYq2JOofNePOzFBq7E7iu+GWBAYy8C6Giu4UeE4mHNZFMgL9
 vo1feDdjJyuRWQt8fnSK3Mi96unn5+J8u+IGqoyaEsjV1blGSLFrh6kf+oQlS8+cAh3Jy6qQCLF
 T2XWbxIbOKt99TK1lBN81P7dVc4BQDwRGBsfNWcOHdOIy6vBcoM8CBQn4rd61tXnRmXsqPpsLd9
 2QvAOJBw6yzj9DmeK/ntztF3CAcccyAeMyLTNil1v8daHpE+RzTUSIJVKrQtU8upA==
X-Google-Smtp-Source: AGHT+IFxehlyisWNWLd6YkIrcjcLfbJcVVO3GimUfECeVtxinCjqp+JtpuLUoZZdq+j+3SlfkaqYmw==
X-Received: by 2002:a05:6000:1846:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-38880ada79emr15001870f8f.27.1734451206067; 
 Tue, 17 Dec 2024 08:00:06 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ad9asm11390181f8f.58.2024.12.17.08.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 08:00:05 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH 3/5] board_init_f_r(): use static calls
Date: Tue, 17 Dec 2024 16:59:34 +0100
Message-ID: <0adfb649adecfd0b11e764342ca22ea0ebe438fb.1734448827.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734448827.git.jerome.forissier@linaro.org>
References: <cover.1734448827.git.jerome.forissier@linaro.org>
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

Replace the init_sequence_f_r function array by direct calls.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_f.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index ba1af3d8055..b2c83af943a 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1020,8 +1020,8 @@ void board_init_f(ulong boot_flags)
 /*
  * For now this code is only used on x86.
  *
- * init_sequence_f_r is the list of init functions which are run when
- * U-Boot is executing from Flash with a semi-limited 'C' environment.
+ * Run init functions which are run when U-Boot is executing from Flash with a
+ * semi-limited 'C' environment.
  * The following limitations must be considered when implementing an
  * '_f_r' function:
  *  - 'static' variables are read-only
@@ -1034,17 +1034,18 @@ void board_init_f(ulong boot_flags)
  * NOTE: At present only x86 uses this route, but it is intended that
  * all archs will move to this when generic relocation is implemented.
  */
-static const init_fnc_t init_sequence_f_r[] = {
-#if !CONFIG_IS_ENABLED(X86_64)
-	init_cache_f_r,
-#endif
+static int intcall_run_f_r(void)
+{
+	int ret = 0;
 
-	NULL,
-};
+	CONFIG_IS_ENABLED(X86_64, (INITCALL(init_cache_f_r);))
+
+	return ret;
+}
 
 void board_init_f_r(void)
 {
-	if (initcall_run_list(init_sequence_f_r))
+	if (initcall_run_f_r())
 		hang();
 
 	/*
-- 
2.43.0

