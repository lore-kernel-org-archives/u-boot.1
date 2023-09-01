Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2032FCA0FF6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 20:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27DF867DE;
	Fri,  1 Sep 2023 22:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b7lZEhun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1DFB867B6; Fri,  1 Sep 2023 22:04:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 149D586703
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 22:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so24509155e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693598653; x=1694203453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=b7lZEhunMAFsxLlqLLTDAPaRQYxCOQFC9BTrWX7WBbNhXXKMrBb+zkmqSIpLLpU67N
 qv6BAT61BOSoSkOlwGCfmjgZtlN8HESWpsDAZ/dZVbGMnpR9k4EdJGx8cugym0UtS0aM
 Y623MARbnGsjEgBWtDZ29jh83EV0awdDT+stmveA+VN1GFvqoq8pJo6skcAX3HOPtWP+
 89Q2Qpwr6KP058JDcxp7kRr1a4bQzGNPS/QHkicGnXo+ULE966Ow+8YsIhAmtiwWAXUz
 7QiGu4p5HRPD6WfmPSUx0uK6zv+Zp0eU0QrcdXHld3uEgCEId3HBQPrMb0IR7wpNtGw6
 ih0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693598653; x=1694203453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7hb2jrvivQxON1XeovwgMxiW+RYRxZdLPP3zp29do4=;
 b=kTMsfiv/pokSy5CfwY0CicL4SlHsP5CnQdRoY5Bq0N7KN+gMxTl2Ysifssfu6E7p/d
 ZrMppojgNls4kkA8mfQp8yfbeqvmeO4LN+dZzrB1ShSBO2ZLVgmEj7lnIzX3CBpETZaa
 xoYg2BnzS0DIURaqNb7JQVu6vvnu4Skq9iMdPqOeKjWyG5+J5ADKXjTvgfrT6pyq+3Cr
 ivNnyBst/26qbq7bjVNC2OHN3Y6DzK+wc9zDSIqwA7zfwLYfYLouLSgZ5LtKS4sFB22B
 w6SNcRGOful6z8pEsiMyuw8cvAqGbOpnFHEDPnpK0XyHFd2sTPbtAIB+CFKDnIEe4RIh
 j7Qg==
X-Gm-Message-State: AOJu0YwET2sfZybQblR8Uj2GBv0Vx4BMDx56iQXEmniqpQ3gFblv2uQX
 joTfzd0Xc6uxaody7xENWXlAfQyRkDB1CVp/
X-Google-Smtp-Source: AGHT+IHOlw7VPOOt6YxeLgZiLHhEQYkhOgM6Kqcl2nLqknKIngnBSW9iOzZvX9zqwD6bsf4pRNkmiQ==
X-Received: by 2002:adf:e48c:0:b0:317:6314:96e2 with SMTP id
 i12-20020adfe48c000000b00317631496e2mr2604678wrm.14.1693598653013; 
 Fri, 01 Sep 2023 13:04:13 -0700 (PDT)
Received: from fedora.. (cust-west-par-46-193-56-152.cust.wifirst.net.
 [46.193.56.152]) by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm6207849wrr.82.2023.09.01.13.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:04:12 -0700 (PDT)
From: Joao Marcos Costa <jmcosta944@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de, Joao Marcos Costa <jmcosta944@gmail.com>
Subject: [PATCH v2 2/6] scripts/gen_compile_commands.py: adapt _LINE_PATTERN
Date: Fri,  1 Sep 2023 22:03:49 +0200
Message-ID: <20230901200353.90290-3-jmcosta944@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901200353.90290-1-jmcosta944@gmail.com>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
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

For U-Boot's context, the regular expression defined by _LINE_PATTERN
should be adapted. Replace 'savedcmd' by 'cmd'.

Signed-off-by: Joao Marcos Costa <jmcosta944@gmail.com>
---
 scripts/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
index 15ba56527a..0227522959 100755
--- a/scripts/gen_compile_commands.py
+++ b/scripts/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
+_LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
-- 
2.41.0

