Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A2CC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A11681782;
	Tue,  4 Mar 2025 14:10:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dm4c5hDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBC38171B; Tue,  4 Mar 2025 14:10:00 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA8781426
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-851c4ee2a37so396165639f.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093795; x=1741698595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GF9mKh3CpivpUSZloMFA7yDWjcBtgxJrZpLBnB+9oC4=;
 b=dm4c5hDZnjQs+4DAyVFJzB4sa3CqWqy38dd8GdymVbXSlw7+tusFBUBXIcVKnb63Ub
 /ehbhlO6uYfGPrb7dOFWCX0sO45TYd8sBLaNpqVOJIN1n6iNBZkROWBH6kg5KqUf/IEF
 qduLo2jO2IhK1KrwEKW4MESUkIPB2SzX8oBh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093795; x=1741698595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GF9mKh3CpivpUSZloMFA7yDWjcBtgxJrZpLBnB+9oC4=;
 b=wri060K91rshFWQ5+3PYKAKtin66Ogq6P8tLa2J2TIR1KcaO5L6w2e08d0f1koSJYH
 sRRb+Hdc08wLbh1ZoRy3LbtAamtyj3bR10m0ibX4k6RzQmLHd9f5lVjnLB5Alv2eJm0v
 5BGCV/GvIGE8doy4W+R+ofZtryuKwTsS/f+Ev53zYZ16ZRELAbYPEZbaCrn2CHvI5Nuz
 Fi4DdEp1BfFGchafubLzvqdeC5zJtmJAIGZbp9fUKsvKIycIA00sGXaZMTpppZw00pMj
 5OKl2BaafSZdaaqn5PI6kkRoyZJzVVIfxD/XEPxjR18Vrc/xn8g0c3qIY0R/IQsvH1gv
 t+oQ==
X-Gm-Message-State: AOJu0YwQ2ECfKki5okLANGStuHLWWiZ9vy8hajnIzH7wv65jSuCfS8Ks
 hAwLbztv9XqoYAuCJw1J//Kvkc9M+aS13RaDm8C8+BrT9fZw1kola0jDJqsDf7woQBfwdDyP5bo
 =
X-Gm-Gg: ASbGncvlJ1sQLUiAjo6PnTFzIBfYGD5UL26teuonKln/aqt3wxrnUjo90VhjoF020wZ
 MXWfs/syH10dg2RJ6lJEprxJV4xxycPQXAS8M+RZzZSolPU+8DKiwaWZbMYlFLe1lDAe7VONx72
 zMrc2B/9qxUyAEcm/A8+rk/KL5dQvd7DVMUCuvfG79Ta0c5VJQ5s6ZxQZu2E9Vmp93EFtq5ijuE
 pzdoMT2A/v84nBZhmeLtlq4x+UsrZRa6Ge4Jjjs34P5HkSm3sMWcGYusKv5pq5b20ije/yK6EbO
 SHc65xmCqXm6ylZM3nh2iSSHKIrcKYiTDY515GDUZ+6LcSe28gnL1zJo7uaefl/vcEvkXytzFVD
 0NCFq/g==
X-Google-Smtp-Source: AGHT+IFDTIt3vbj7rPaHZ+DP2b/NmPrIy2J2wdoWklv9Ze1PZDvL6FdXrtEattLqWjEIXRUM+OZT5g==
X-Received: by 2002:a05:6602:7512:b0:85a:e7eb:e448 with SMTP id
 ca18e2360f4ac-85ae7ebe663mr557999539f.0.1741093795588; 
 Tue, 04 Mar 2025 05:09:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:09:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/7] binman: Exclude dist-packages and site-packages
Date: Tue,  4 Mar 2025 06:09:38 -0700
Message-ID: <20250304130947.109799-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

