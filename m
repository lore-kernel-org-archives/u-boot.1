Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCACCA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC951835B3;
	Fri, 29 Aug 2025 10:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EfELKO4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4215A8354B; Fri, 29 Aug 2025 10:16:44 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE29083447
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so10662415e9.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756455401; x=1757060201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3XMRas6douaqPvZG0hjO2PLlDR8aPCUUgCggXZ8jKes=;
 b=EfELKO4kBcGLK2pqvu7w8vGlFvpKwXWhT/MjIIPOEVTdyRzLt2ar1LrV+F7WL5e82w
 4yIZfnjev3bhUFmVujvQ1cFg2YlHLgj4nfTMYr8tdqxmOl3kPUIaVdlRJJ20XihEElpf
 rGN8vAjm6fTDxChXLxQH74M/j6uj9gN+efYYpVEKLx+/OWWo40Wd5i7Y7dPDByvzK8KY
 1TtxDDwoEGYErCBXAsa5wxnnhMDLSrX0ZfeMrbpBgNlgtpQ+nVqVuxNEYH3vUmCsHkOZ
 W+yvihEP6+7v4BoiNzymiYi3xtF7uv0yCRRxjXigN0vONBjHgQWdGeANI+rYO+VdILvM
 clZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455401; x=1757060201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3XMRas6douaqPvZG0hjO2PLlDR8aPCUUgCggXZ8jKes=;
 b=LWiyRl7cG136WqzQwJfzBFgApWTT5t1Y3JFaeFKYunfbxlbVHX9c7vltWjfipqKT/a
 zz5ALWw9c6jciNLEAC0s/K2RJrhpOL/32t3l1eIhCSvntvP+fTnKGGI6p+SzH5k7qmcH
 DgplSW0IQcXAcBTkH0Q7+H724ZNR4KxZd81sy8l/lBSo17JYn6eSQoDIGcFLF1fma21+
 wFUkQbSx1NGegCLQCxZfmWmhLyDrnCf/OQbTCKmgywaJrdlmY7o+x7eaR5l0ht2sur7C
 /P9WUSLzy6UTOq7kzzPKlED8XlH7FPxpTKZAdwe+KaLx3jquHGpiYEN3UhYrRuGiCZcZ
 g4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6cnkrM0DLPmOWCetMpB2eA1xiGu568TVYW06CotilgomHtBrfnFHTJIngPo41WvHdWX+k0GE=@lists.denx.de
X-Gm-Message-State: AOJu0YzocKIE7Z5P/HPElCxlvgKxY2njT5Z07dTgwhLje5UCJLCavCPW
 HPyg1g2pNEQWycBKjcyLT7eB3s3LQzKU0SaLYExhyy4+PYLIocfRc8jgPTeAsiRJSDQ=
X-Gm-Gg: ASbGncsjlPHm1Qw6IOb5O2Qn8K/3ybbRZZ4Wjg1BcU6cU9Mc8gasXK/FODP91bEvSmn
 5RJEMMub3s/zGl8Ft08uXIWNTyFedgvby+shYd4Mz/e/wlNMonRirbf/nz4jAmbr4kZFbXN2ewP
 6bX3PCA3P9UzZ1QX28kgJl71gns06DUilFuoilwbD//zzHeysmBJpIpsQmG5T4XTlTfryPjZZIf
 nWO7f37X3vkxb0K/hWmsG4xCUXLexMxVhi01n2F8HWJYtsJIFq8XgkFXLdyLiuU0cbMyXGvLCxL
 HDD08w/XWvorAVaBgWBIZlhF4XJrVOy5dsS51Z0Cmuf8HJm62HGQ5wzmVAupr7SdRidhZMz2Tkj
 hwiiPGQhnraXF5Cf0sCpbgXjCpBChRrc2Eus0FJqPpGLAr1FGbb9HweLNB+qUx/BkmkaFy3MX4i
 exagJZbrcuULYLFnqIUMDatC1Ooj9Dtunlq+iubyw+Ylw7bOOh6YAC2pu4lDz6p1RPqgaYtLYYl
 afUKhebsIf24jPVpzziDSG+iRBdl6okc6rxd+YFEfZX4A==
X-Google-Smtp-Source: AGHT+IF89hVmn+5/xOI187mKpSO1trJSZDOsd5ZUeRoFNBIpBNKZK9pfvXChFJN+YHKvPPPcvj/o6g==
X-Received: by 2002:a05:600c:c87:b0:456:f1e:205c with SMTP id
 5b1f17b1804b1-45b5179f338mr222271355e9.4.1756455401221; 
 Fri, 29 Aug 2025 01:16:41 -0700 (PDT)
Received: from hera (ppp046103010177.access.hol.gr. [46.103.10.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm2449008f8f.12.2025.08.29.01.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 01:16:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?q?Carlos=20L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Yifeng Zhao <yifeng.zhao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/8] tools: fdtgrep: Mark util_version() as static
Date: Fri, 29 Aug 2025 11:16:15 +0300
Message-ID: <20250829081628.2327372-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.50.1
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

The function is only used locally. Enabling -Wmissing-prototypes
triggers a warning. Mark it as static.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/fdtgrep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index 037176bc9ef8..6372defedc2e 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -1109,7 +1109,7 @@ void util_usage(const char *errmsg, const char *synopsis,
 	util_usage(errmsg, usage_synopsis, usage_short_opts, \
 		   usage_long_opts, usage_opts_help)
 
-void util_version(void)
+static void util_version(void)
 {
 	printf("Version: %s\n", "(U-Boot)");
 	exit(0);
-- 
2.50.1

