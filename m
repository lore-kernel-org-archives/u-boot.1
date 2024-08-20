Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6FFC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 23:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4C988ADC;
	Wed, 21 Aug 2024 01:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sZv00/+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F9C88ADC; Wed, 21 Aug 2024 01:00:50 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A88B388802
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 01:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5bf01bdaff0so2762713a12.3
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 16:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724194847; x=1724799647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ln8RRdiEizsvhK+l4ain/VpC0y7WrBaHHrX0vQK5m9w=;
 b=sZv00/+KAwu3rwehk2nepbN8EYIy4aSkSAgkpyxs0sljj/xCsv+Ik2Ipv+au8sispE
 zfRCJhOsOIx9wv29LLmJKjNQ7ppxlIlnms4zKeh3EGiIGyJ1IiMxnyimrN2R/cv8Jy+s
 a3trkKUl30iTd3jQq2ZxX54OxzlG36hWme4ixJr2uWMKVH7E09VqTB1o21W4ij16eYyb
 141YzUqg9PN0qcXrHpBc1Lz+Cl3bHIASZYrwm3zvBhxLQoUxsTKU7NWdYm6/B9o7sUBV
 qgGjStyWLLAFL3Vd9rYb/ysi4VEKfK35jRfpFhQA4W+odyKrTlHFJew372IFBcCNfhd7
 lCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724194847; x=1724799647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ln8RRdiEizsvhK+l4ain/VpC0y7WrBaHHrX0vQK5m9w=;
 b=I2RzmOFlwBKj8uE2k5bK7dMEiM6eMvUDuAQRZagUs/OvSesQJCQ8HM5XlyclYiL+Uj
 0Re0uXEbRh+fMSQaJGZWHP/czQex61YsebmukzbjFYZXCDhQYi5V+fOVxR7Mlp27iLKo
 /flgS9J+pbYrZHpn6bgyZ7kU2Pf6r5T8HCiqdKMpRjPIa5Wsc4XOHTEso1jGKFcMQvjz
 b85ygw1fIRueV2Lme/WSilZNpyP4qlouVVHaE6kHMx03Oh1cVNL3SW01IPddcx+v4sLW
 vE6Tu+1rxomGJqJab2tK9XuGavF/iRLHXGUYcX8/nRL5WFGO0+rIpNsYiUawQTCtf0PY
 Vlyg==
X-Gm-Message-State: AOJu0YwlOxOkpjXBd4uWKbDxSkKZ/TLvTskzSq0wl9zDgEvp3xJf2RXS
 VGMRcXpfK9dcUiSOcnHzxD4ZMj+X9IaZu/RcvOd6UgCIXYLhCG0FEzDUtJwfnFg=
X-Google-Smtp-Source: AGHT+IEItVspo3DolApk8Fe8HHmPG8ld7Eem09+7xX7VsMCP68EDpYW4t9fndD76JCAL9Oz9JGT/qA==
X-Received: by 2002:a05:6402:540f:b0:5be:ea9c:5fce with SMTP id
 4fb4d7f45d1cf-5bf1f0d9309mr147642a12.16.1724194846680; 
 Tue, 20 Aug 2024 16:00:46 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc0832d2sm7263701a12.97.2024.08.20.16.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 16:00:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] board/qualcomm: add debug config fragments for some SoCs
Date: Wed, 21 Aug 2024 01:00:27 +0200
Message-ID: <20240820230037.1859088-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
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

We already have some documentation describing how to enable debug UART
for Qualcomm SoCs. However the UART address varies per-soc... Add some
config fragments to enable debug UART for few well supported SoCs.

These can be used like:

$ make qcom_defconfig debug-sdm845.config

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/debug-sdm845.config | 5 +++++
 board/qualcomm/debug-sm6115.config | 5 +++++
 board/qualcomm/debug-sm8250.config | 5 +++++
 3 files changed, 15 insertions(+)
 create mode 100644 board/qualcomm/debug-sdm845.config
 create mode 100644 board/qualcomm/debug-sm6115.config
 create mode 100644 board/qualcomm/debug-sm8250.config

diff --git a/board/qualcomm/debug-sdm845.config b/board/qualcomm/debug-sdm845.config
new file mode 100644
index 000000000000..31ad6d02a3a7
--- /dev/null
+++ b/board/qualcomm/debug-sdm845.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa84000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=7372800
diff --git a/board/qualcomm/debug-sm6115.config b/board/qualcomm/debug-sm6115.config
new file mode 100644
index 000000000000..131c6e230de8
--- /dev/null
+++ b/board/qualcomm/debug-sm6115.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x4a90000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
diff --git a/board/qualcomm/debug-sm8250.config b/board/qualcomm/debug-sm8250.config
new file mode 100644
index 000000000000..4d3cc4cc97f4
--- /dev/null
+++ b/board/qualcomm/debug-sm8250.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa90000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
-- 
2.46.0

