Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEBEC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 08:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F768366F;
	Thu, 24 Jul 2025 10:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qXAmzAkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F101C836A4; Thu, 24 Jul 2025 10:34:56 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0994883616
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-454f428038eso6140075e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753346094; x=1753950894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AVja27B6RFdjozdA20ZrNCLs/E23i8zEocTavP5gQ6s=;
 b=qXAmzAkwfjQ0LdEj8DTPfFIYadfUoZD4BmxDJnzVBesloTAxN7j2rWQq/2W5NtKld1
 /PgtqrsBpBBaXoGV6/qYJ66BSQmXkaxkVGAgNtQh4PJGm+taujLrJDRmPtvpcUNw5ue+
 bHtE+QumCMw5E77O/8eXiZfSTcv8jOZtAkDCjmtAr02DWKc3sXLyt94RzmrO/NbmREBN
 GzvTRib5hvBegnaBRxs9XkMuv3pSDWm5d94qHfHwiqwS+qgT79qMzxjGg418YzCwZtrJ
 qK5Pmea0ue8Dz+pfRewXtgm7EVlkF9e/2nJkD4PtJWVOp6dBAf1EF15CW7S5nOqB2MXC
 wOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753346094; x=1753950894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AVja27B6RFdjozdA20ZrNCLs/E23i8zEocTavP5gQ6s=;
 b=IZM0oLofiHDTZpJFZyLuwloOM9PYPDAgOOqYpEAvZ/NCYDIAi4PzbinzHwhXSW5gVv
 8ieUKpYcqLuOrhUbY9EE9dDvncqw9JI9XTDeoScBfKSp/Y5jJAX5esp/nKsQPiHMLFJa
 Z/F9k17YHwlomzKW+wdcChXc28g2Y5W+RvIkkaXpDsnpJw2+PJi+5rOwyzvs5x8OJIx7
 xIZtmrnsYYXC/oO9VyzNNfCL0YitC00V6XfQ4qyxF09oIsZ1nseHqjE0nrb2VYzMJcz9
 gQfgZ92JidizHQvNH8S7njl52CNcvbsayKL4pk6jgDGFG0r9bSzBYe/80TbeKAQYSwiX
 BUEA==
X-Gm-Message-State: AOJu0Yxo5/6jQLgOYdoW607XAedQ/0GK5D0nVlL4TfWPghHgKVwobyi+
 Q20MDbRICErPczI0jJ3FFHv/xbvtSYHCi8JPjf3TeUgybQt5yn4VUw1xFaZVQNaHYLQBd8SN6NC
 bMVngVzhcgg==
X-Gm-Gg: ASbGnctNnch6tZrJk+2xL4eQFNqgFOVQH/zT5O8ix1gGex1O4R3Hqi0FZ+1As58jLzP
 unRLEXhQ3BUGK0U6Bry78ZAitLcLzSBv7NsJ4EiBkg4cSOK54BDGrHMS6IUjrM59APA+QbgbrNQ
 zpZGpEMAwMbqV5J3puxkj+e2vgucaaUtEIcpiXzlPmhjLww5KZLn0zdQQB3oNUS6O6axrz8gSRp
 TK1ZP+lbCKKMm8jfR1WCJPj/zmahoebNKGIl+HNNmKcB1luqt6XGpyr1AJsZcyln+A1Dnp0Kt4U
 FdIEX/h5TxCpJ/f169/WXm0JWrB7Sn18CfFlvTHsbcfRRNvV7eIpFXkBJLIKglaHNSxLNoGnJ/0
 ngeDenWlmAi7T23QpYO/3Q85ygS0XUQ==
X-Google-Smtp-Source: AGHT+IHO+sc8jLjcRM33+7WNKFQ2B/cAu1DblDvAE+lkFfvOQBDnBREdGXzvTvsyz62YC7MeGLfnZA==
X-Received: by 2002:a05:600c:6096:b0:456:1c4a:82ca with SMTP id
 5b1f17b1804b1-4586a4924a9mr45653035e9.32.1753346094149; 
 Thu, 24 Jul 2025 01:34:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bcf7:2df7:a82:bef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45870577af8sm10962605e9.32.2025.07.24.01.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 01:34:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] bintool fixes
Date: Thu, 24 Jul 2025 10:34:19 +0200
Message-ID: <20250724083433.57867-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Two small fixes for binman (bintool). The first patch avoids a warning,
the second one makes sure the APT package list is up-to-date when
running apt_install(). That one fixes a CI issue I encountered.


Jerome Forissier (2):
  binman: bintool: use apt-get instead of apt
  binman: bintool: run 'apt update -y' on first invocation of
    apt_install()

 tools/binman/bintool.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0

base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
branch: bintool-apt-fixes
