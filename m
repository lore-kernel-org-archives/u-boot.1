Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1054C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 20:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B5E80F56;
	Tue, 25 Feb 2025 21:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SgG0/N97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B68880F88; Tue, 25 Feb 2025 21:06:50 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070B180805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 21:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3d28792a49dso39869955ab.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740514006; x=1741118806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF9mKh3CpivpUSZloMFA7yDWjcBtgxJrZpLBnB+9oC4=;
 b=SgG0/N97ZPGzTLcpK6iASdWsyo+L90RHpgODNtuyUnBSbLBL/Tc/Ehckk27DiqkRYX
 YgwGNmcV0s6hfXt+9CLlWEGlrysPy8rd+L8NihYUYPcxCTlc75tfCiRicR9uUbpAuMIz
 UF66kH8Am1LWpJoBfQbWfA0cg2yXqtbOvb7Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514006; x=1741118806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GF9mKh3CpivpUSZloMFA7yDWjcBtgxJrZpLBnB+9oC4=;
 b=ljgkbm1yXM7WTV4yC7W7EbSrlypS3lSq7+tdS2+m6MJYISyQnlaaM1sNBmhGdIbZfE
 +toogj2msYszEvbOtAElQ1ojwWG2eTfCJguXTWQk+DlDgE6DkgXrZAUulS0sXVYILlPS
 8g23NM8kD8V9E6ULVCn2N95ZGZRAIhcYWPCOlxW7qCtTBJI6/XXwS9V8rCX2okgxMk1V
 gIbbsgGvKvwwCX7OZAZoYNVltqyCmtSPvPKK3ZjnUPPJ7d5aq8mrR8FtawLpu5c/mpyN
 0sqt3NnSM7OcGf5kiTYWxi9+ZNvrxEnVNU6eDdPuXviUyt82Pu9QV3VvB1sZDDJ616xu
 Sd4A==
X-Gm-Message-State: AOJu0Yx2t/mLwnB1/S395ZHyiV4sqkNCrIXUGg+UHdxfZfFoR7eNs7FN
 PQgdyF01ZC1io9Ri7nD/jukMCiyz7dYCU0IihtmK2J83nz08K7yepGLQ1WeFjaxFf0aQt4Z6/rs
 =
X-Gm-Gg: ASbGnct6/fkClkBHDuiFvSqENg2j+C85NxLaWQRdiYMwX8coPJfgsRkZCSYmHr08iDU
 crCqKT8XEXfvYYmOdcw0dXz1Lwv/ftYyXiAQTn1rh46wmnh4K70asb/kCKjJuMu4P+/uQgVJu+U
 xrHwpNnZwyVT9RSbmJKFKwgXTYKUafpwRM3GzDsVoVnZD05IKEobB2/P2pta/2YzET67WguP+mo
 sWKHF/EDb0OUkKRJsKJMSL6OcYlNluQJOi0bez0AenzPBrhjuGGYkCiDw0NlWxqSOcW/EgpuTx0
 A0wyGT4K5w29rGomV156cAzcRTUgn+S08p6Pctfu81iMeHMZYqq3YkgrQXU3voE=
X-Google-Smtp-Source: AGHT+IG0KFxVz3AXsuHnVFOMgQ8tXCGkaukDyMiw/6pNNM5im8UXj/lCS4udPKaytaB3hlU7XhPcPQ==
X-Received: by 2002:a05:6e02:12c6:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d2cb492ea0mr174013865ab.11.1740514006215; 
 Tue, 25 Feb 2025 12:06:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d361ca210bsm4653305ab.55.2025.02.25.12.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 12:06:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] binman: Exclude dist-packages and site-packages
Date: Tue, 25 Feb 2025 13:06:26 -0700
Message-ID: <20250225200635.3781149-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225200635.3781149-1-sjg@chromium.org>
References: <20250225200635.3781149-1-sjg@chromium.org>
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

Newer versions of the python3-coverage tool require a directory
separator before and after the directory name. Add this so that system
package are not included in the coverage report.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/test_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index dd671965263..ed216c4fc4e 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -56,7 +56,7 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
     else:
         glob_list = []
     glob_list += exclude_list
-    glob_list += ['*libfdt.py', '*site-packages*', '*dist-packages*']
+    glob_list += ['*libfdt.py', '*/site-packages/*', '*/dist-packages/*']
     glob_list += ['*concurrencytest*']
     test_cmd = 'test' if 'binman' in prog or 'patman' in prog else '-t'
     prefix = ''
-- 
2.43.0

