Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A675DC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA43F8367B;
	Sat, 24 May 2025 01:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fIG/prfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1292783409; Sat, 24 May 2025 00:59:29 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD72B8333D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so542315b3a.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041165; x=1748645965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dEkOebyHIW5sFbRQIjVlRYoEAWWpj+eXL/AHGOvwbs=;
 b=fIG/prfSYYM984o6w431nfuDpv2bJ9CVyMzP2iQpF5uLr1Mmd2srX7VEnK+efRipKr
 /imdmbAT+MdRxG+3g72A4nF6qg11voWB9YKPwiOB2Auvbb537GMeV5GL8j5nBXzixs9s
 r9ojqLCtJVQF00pkAokdK65fdB9fXafOLSgqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041165; x=1748645965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dEkOebyHIW5sFbRQIjVlRYoEAWWpj+eXL/AHGOvwbs=;
 b=n/hwR00t7T5xyKZS1fNu8YhazplwZt8ocioU93X/KPL7tHRbirjL1/gFdN3g5M47td
 hj9XWeRGccSF0lwcLpfv70swPtcuRaEllH6RWKwFaBzRQWCC/XYrUooXSZxnVXzK6K5/
 YFW8x+w902VGewDKfUkm4fWuG7/6qQwSpqth094fIorwoAOd4L1EMH7gku+l5vC5B2Qm
 9xMRyZrFlLLjkqSr0fi7XR1yNNz9v9hirJTW6JIRfSCdCF8XtqD5C0mmEWfgrCX4swoP
 epQN3obiqKOJEykTfpS17U2pQrYmhr/d6HOJEbODEYCRghMueiCLgu6vEh/ZDoS8+N5D
 2sFQ==
X-Gm-Message-State: AOJu0YyJOuRvXzvr1KKPTPAEidgwwKoz2Cvmo+9EqZDGIiE8fLlYebeh
 e6quKWBXTwYfkaaR3C+QYoIBuJIUPTQBRVr7fN+KKMHEqXhLjvUEU9YrR9NVgjycxArMRYhbltj
 Kx24=
X-Gm-Gg: ASbGncvKGEGcJTfLJ6KqbscebJ/KKgJAgHb5KUHc/lNKCCBhr4umhcEYX7JVnEDmqiK
 bTF0JaY++0fGwT1wBxOz0wsyt96DqRx/ZZ68YG/BKhCLYZyUr1QSQ1movt58UpZwvSKdkTcanFd
 irh3nhVtKQV0Ki+d1AR57fW2hhV9PRHctJUhlgj55pwoWgQve6cbGcYh/IKgysjh8rOOt+GCoWp
 MXFsU71UMOVbarxVJhxVa1HBP/YBpnZJSVSvA0mOgjbMHSfsKBWxRwzsOIiM3qKcm01LnCSjUG5
 CfSW4g+tWTNyPgMJq3Zm+DI4AyT37rw0mcv6x5UrDEj2yZt7gTBSuoE6vYTBUySOAzLCw7K1o8R
 CWWehA1lpWFnYnQE=
X-Google-Smtp-Source: AGHT+IHTEFl3LscnNS+tPJtkdQEWXX5kvPF8C4qt63RD2r6v7FW1v5gMraNUab2NyT2KQiIVrBKU7g==
X-Received: by 2002:a05:6a00:1822:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-745fe064383mr1864347b3a.16.1748041165317; 
 Fri, 23 May 2025 15:59:25 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a9876e7asm13640846b3a.145.2025.05.23.15.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:24 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 25/28] cmd: ximg: Support LZO compressed images
Date: Fri, 23 May 2025 15:58:40 -0700
Message-ID: <20250523225845.2311989-26-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Add support to decompress LZO images.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 cmd/ximg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index 29d7c3279b39..a6341a078019 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -14,6 +14,9 @@
 #include <cpu_func.h>
 #include <env.h>
 #include <gzip.h>
+#if IS_ENABLED(CONFIG_LZO)
+#include <linux/lzo.h>
+#endif
 #if IS_ENABLED(CONFIG_ZSTD)
 #include <linux/zstd.h>
 #endif
@@ -238,6 +241,18 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			}
 			break;
 #endif /* CONFIG_BZIP2 */
+#if IS_ENABLED(CONFIG_LZO)
+		case IH_COMP_LZO:
+			{
+				int ret;
+				size_t size = unc_len;
+				printf("   Uncompressing part %d ... ", part);
+
+				ret = lzop_decompress((void *)data, len, (void *)dest, &size);
+				len = size;
+			}
+			break;
+#endif /* CONFIG_LZO */
 #if IS_ENABLED(CONFIG_ZSTD)
 		case IH_COMP_ZSTD:
 			{
-- 
Sent by a computer, using git, on the internet

