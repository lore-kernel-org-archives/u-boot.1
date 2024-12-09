Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B587E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4609F896ED;
	Mon,  9 Dec 2024 17:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8vtDUzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE6289712; Mon,  9 Dec 2024 17:15:05 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCB4F89709
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3002c324e7eso33589131fa.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733760902; x=1734365702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyiBLcAxH/nrwTomz8x8G1itGFykJnXiSv8uDLnDlXg=;
 b=h8vtDUzG3TQAkutc2t+bB3azDAd7v23KDxqPyRz9/O0xRmxiuMedVseqZXX58e6riW
 mFT/zXX1ZMBg7dFfIirhkHVBNhfdwEuhShf+YYnGlUe7UkJsgoJmkSCEoiZIjEzdhtE8
 wtZXQ4RYAg4NfHiykK04UnrgGJmmVp9K6Dp8ZHhP/jX8S4jlhCh9MP69ZhDGIDk9Xvp9
 BZ46gdin7PTJxIZeTNTsh5ODQeo1IKgznguwWeG/PqaFhxrUAwM4HuZgnD2AzDLaeXKy
 F9jF8x2JVToFjQ1cGZm46MdYDxqjJZYdA0vJmPaaLkRh0MPokCrUPoMXG1A/LA4L/Yc0
 k2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760902; x=1734365702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyiBLcAxH/nrwTomz8x8G1itGFykJnXiSv8uDLnDlXg=;
 b=AgvEyCJQsd4zGxCjEwgw7lbaBpWHEB9VMRNPrQWKv0kDnAl9q93hj3P4mnUO/sJkgF
 hmOzHi7+fChwva+UEzgQnyS/Xkl1BCEEvc+H6Uzf8v6QwnloI1+6sKt3j1hnL40Qgbjj
 bLVCLFBwfcjWG3vK5cKPmpCxjdULXg17KXaq52299fSqA36L1EENBdCwUSR+hnfmKxjF
 ksFIPBnAArdHGxpTDQUz+VsBZs+tvjWBo3QFi26WdQGZVSKPKvClNK2qMOYXPhTPS9wN
 8f0TToFi7ANYiAM405cbCjeNxh6oFyhKRhNw93qRKQZhUYLB9Bw67Pf+D/TADQFK1kZi
 nqAQ==
X-Gm-Message-State: AOJu0Yy0KbiIZWpKB4KYFCl4T7UH9v7b8ph58U3ExeaLtsLp48tRnyP0
 f4kumt24zucn3uROYVFq7pU2EOR4jVDuXzhEs4rCcmQMxLKxCpyk
X-Gm-Gg: ASbGncsfTfYm8Z2yqRYH3un0oTcfQp6hJ4zOZWcG7PK2ZUISCqqYKthGjP1OYzSTo2X
 2BmCwVK3WObjsmCgd/dUugdgBBNZjdOB8n68rLrNi6FOy8h1walq6/yNrJ83AT33J99/qbKvhn2
 r93W8K2ixzbBMHrPmRNq5CmQes3zxy4bagd9+xYmIG82UOEgcboOJa8O6yOhQhjmbZhkY5LS6ms
 JDzo8fQX1Ky6eWqHsFrSAQm/L3lbypKpUP/9t+WRA==
X-Google-Smtp-Source: AGHT+IHUEji/Tr7DbkXVb5UgA4/8Mn7bo68CpYR0jz/bapYSj1xsCyHhxz6PQvLgz11DYzywKvcIsg==
X-Received: by 2002:a05:651c:507:b0:300:2848:fc6d with SMTP id
 38308e7fff4ca-3002fd45707mr57561721fa.32.1733760901490; 
 Mon, 09 Dec 2024 08:15:01 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3021a02d90bsm5940971fa.80.2024.12.09.08.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:15:01 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, Heiko Schocher <hs@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] pmic: max77663: bind children to parent node
Date: Mon,  9 Dec 2024 18:14:33 +0200
Message-ID: <20241209161434.6563-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209161434.6563-1-clamor95@gmail.com>
References: <20241209161434.6563-1-clamor95@gmail.com>
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

Bind GPIO and SYSRESET children to parent node since they
do not have their own nodes in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/max77663.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index cf08b6a7e1d..c2a7cbf7e40 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -47,8 +47,9 @@ static int max77663_bind(struct udevice *dev)
 	int children, ret;
 
 	if (IS_ENABLED(CONFIG_SYSRESET_MAX77663)) {
-		ret = device_bind_driver(dev, MAX77663_RST_DRIVER,
-					 "sysreset", NULL);
+		ret = device_bind_driver_to_node(dev, MAX77663_RST_DRIVER,
+						 "sysreset", dev_ofnode(dev),
+						 NULL);
 		if (ret) {
 			log_err("cannot bind SYSRESET (ret = %d)\n", ret);
 			return ret;
@@ -56,8 +57,8 @@ static int max77663_bind(struct udevice *dev)
 	}
 
 	if (IS_ENABLED(CONFIG_MAX77663_GPIO)) {
-		ret = device_bind_driver(dev, MAX77663_GPIO_DRIVER,
-					 "gpio", NULL);
+		ret = device_bind_driver_to_node(dev, MAX77663_GPIO_DRIVER,
+						 "gpio", dev_ofnode(dev), NULL);
 		if (ret) {
 			log_err("cannot bind GPIOs (ret = %d)\n", ret);
 			return ret;
-- 
2.43.0

