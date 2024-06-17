Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C92FC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67EBA883BB;
	Mon, 17 Jun 2024 17:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="htfZLC2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED972883BB; Mon, 17 Jun 2024 17:33:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B296883F5
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4230366ad7bso39005305e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638430; x=1719243230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5VffIYNcJu8ItnZYrnAKLEtjyTjAuXi/dkGvy3aV7U=;
 b=htfZLC2TwxjBF4ootH9IBhkxkgkPryD13EQckU7wlJQwKAffPIu9gfToo48T3S7JL3
 wANfDcxjFQPDGMBtzDjRbfG8vl+0epwRgInwhCw5eJlNzdHI+zFyTwbyoBPtX2f5/D0o
 9VZNV0MH21nsyKG30eIg6S/9xPfwswU5GdFm2liDus2j5x0PjzWHJDbn1kDwk87PxCPP
 ce2WGx8HoWzFtNrnNzZfDHpRUFn53bwCyKoh7Xt+mZBwHhbm2fMUeosXJYI6EJLf6bgX
 qhaDQh46YiNbMVlmZ96s1UT7Lhjb6l3R2BScntDuTf/AYpF7waRP1K+AcciiJevLgXu7
 u89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638430; x=1719243230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5VffIYNcJu8ItnZYrnAKLEtjyTjAuXi/dkGvy3aV7U=;
 b=WJO+elwTDfo1OaoZo6M7VDEL7dA32obWhcFmB89rTRuXUMb8Oq4F0mamOiipvfCiaU
 iDBPr7/S9eyTOKDE2kU+wqNBWGeT5Pt/f5dMd0EUmpjj2S0MR9/oQe46rsk8LCHLRD2i
 L7eUFmfK4jdow209tMjOsgr0gE5B0AbNpKOXDCl7VJZV8wxyh4IS2ac4SY/uVwL7+YQ/
 wji4SvsCgfbsPPAN4BHD3/zxWY1Ne3BuBeKXWNvK4aaCNnho9jxwMbu9Sl5ujgZMRFpA
 6YmETbceoJbNCFG/fiaHZmW4VHlgzb/UNo1qQzQNkCjvQiHW6O4pO/vEJZ0od+9RKJJ0
 +e3g==
X-Gm-Message-State: AOJu0Yy75T99vsHyfMGEBKc0nFE64d1ymkS6Gjl5TeU3Ph1Ul0+evcji
 W8JeWE4X7ejOHpjZHArULzpjo1PUgxlbh0mlVhm4P/yJo+SdJRAVUd+qc5XroQLB4joFoK65x1I
 F6ww=
X-Google-Smtp-Source: AGHT+IFfSzOwvEFVC6MsCKOY7SGMxLB+bBwRlhK8KeGgr4pXkQHIRa35Pu6onrLjsBXFwJyaADQhVg==
X-Received: by 2002:a05:600c:474d:b0:422:178b:bedd with SMTP id
 5b1f17b1804b1-4230481a0bdmr86329605e9.1.1718638429856; 
 Mon, 17 Jun 2024 08:33:49 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/14] configs: add qemu_arm64_lwip_defconfig
Date: Mon, 17 Jun 2024 17:33:04 +0200
Message-Id: <e76ac139a4f3841535e1ee306e912fd758dee957.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

Add qemu_arm64_lwip_defconfig which #include's qemu_arm64_defconfig and
selects NET_LWIP instead of NET. This config has all the supported net
commands enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..1f5fd097f0e
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,4 @@
+#include <configs/qemu_arm64_defconfig>
+CONFIG_NET_LWIP=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
-- 
2.40.1

