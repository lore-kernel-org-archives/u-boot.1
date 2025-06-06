Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FF4C5B559
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D7682AE1;
	Fri,  6 Jun 2025 08:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eObtZH1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C68982BD6; Fri,  6 Jun 2025 08:42:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FAFF82B63
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so1002550f8f.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192154; x=1749796954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bXs58POLdIzbyc9mC98f2ECYsUr8btFnWShoBpeY/0=;
 b=eObtZH1W26Q2j36qo40Rk6pkoujgQqSVkhEfDhB8ZnZRNeTFpVH59pGqBf6jSaIQzS
 wua5xyAgT/FDanac7feX6ZbxL8pbPOTDqgEeemfozh+51WgNz6TOYV4F9abvSVqjySWj
 f9X52d3aoJ2lMBGsmf9MMbJRMxsZqenY87f1BnDmJgwJHayswBo4n9dbF8Xq4it8QViz
 +cV+QewNtxH06+fXnm+iJaa4z7Ac474RwuRP2wqOxObs5JtY1KyQrfU8Td85OwVzwFD9
 kaL/WZrpRz9Y0wb/VbJQJwRcmpnnQX6Sszw8d30QFoK+n9xmmXNcQuzcgXZ8mV3LnR+9
 cRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192154; x=1749796954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bXs58POLdIzbyc9mC98f2ECYsUr8btFnWShoBpeY/0=;
 b=YXWKHsdp6YjoOn45VmFGmpiS9GoiayccKS32gCKakaV2mx4uaWl6FrC4w5H3euMMv6
 d57P7wHNlFc56BroviS/GC2wJ667SJnQWvMxaQ4HxjprldyAZkq+vbBbjHfBBakLhmeb
 3YUl2mkehD/EfTmUxi/+RzhJGJhjXr5NkAZb25KImN9zd7hfJtIgUBbwlZ/BtE9APWQ3
 QdHMNBl1rDmvXJSSvimBzZ5iMW+RTQiuwRPIqLxttZXm30pylULCur5M6WO28xh7+LBu
 honpp2aJOJsigXS28dJpGy+Iil1v2W9rOJ3KzJie9SzvxttS3ebQfa7KVIxqm4i9ShTi
 lcyw==
X-Gm-Message-State: AOJu0YzIgZFSjRjVIQ4+6FUKvlXUldJS/CWw/ic+XtNc9Ru78j3h2LXp
 YVh3SZQ6y8Fi6VZuR6eHH/5KvoXtJeWU2Tc3V1JMYPLACpzB2SwHJ7ZO8MyAr8KMsQk1RfirVih
 PoopI
X-Gm-Gg: ASbGncvSR++9DCSNsyg0FirF54UVgKBejez5l3nQO3O15kbPD4TEcKuVQLoie+BVRKi
 QcD/Lsl8Zh3JNNQhRQPu8eV/zSYSZa7kfbcozzp0/e/Tmah3TvxemxpZp/KxybUauGA5jbRDi8e
 CvYghmS6lulwhtefJD0CW/AL+ZzOwR989RU4+0EOCvmT6KFs+LfGmnvv7A/gYMLnAqxPP9cPwkg
 DLjOxyzarnfBLQGmXy9Io+BtKfI/N8OvXM7rud49wlzCBOiJjtZJuyh2YJmN0W/0BC5q/un3rGT
 8k8m5ug8UrSz6rYAMe/ZwVxNQlltwOSoDKK7paI1ZM2Ce5J+Jsr8qnT7WJ9+
X-Google-Smtp-Source: AGHT+IF25N01B1ZZ61x7xX4hUcIsM7wS6Af725FGyL3TrmBhuQ2GlCLvlczNvunIlorqqt7Y6Nc2zg==
X-Received: by 2002:a05:6000:144d:b0:3a4:fc3f:8d5b with SMTP id
 ffacd0b85a97d-3a531cb76c5mr1615450f8f.47.1749192153680; 
 Thu, 05 Jun 2025 23:42:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/13] Update doc/README.SNTP
Date: Fri,  6 Jun 2025 08:41:48 +0200
Message-ID: <20250606064211.3091237-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Fix an error in doc/README.SNTP ("timeoffset") and clarify the
differences between CONFIG_NET=y and CONFIG_NET_LWIP=y.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 doc/README.SNTP | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/doc/README.SNTP b/doc/README.SNTP
index da9ec459ad4..da68aa318a5 100644
--- a/doc/README.SNTP
+++ b/doc/README.SNTP
@@ -4,14 +4,23 @@ configuration file of the board.
 The "sntp" command gets network time from NTP time server and
 syncronize RTC of the board. This command needs the command line
 parameter of server's IP address or environment variable
-"ntpserverip". The network time is sent as UTC. So if you want to
-set local time to RTC, set the offset in second from UTC to the
-environment variable "time offset".
+"ntpserverip".
 
-If the DHCP server provides time server's IP or time offset, you
-don't need to set the above environment variables yourself.
+[CONFIG_NET_LWIP=y only] The host name of the NTP server may be
+provided instead of its IP address provided that CONFIG_CMD_DNS=y.
+
+The NTP server address does not need to be given if the DHCP server
+provides one.
+
+The network time is sent as UTC. So if you want to set local time to
+RTC, set the offset in second from UTC to the environment variable
+"timeoffset".
+
+[CONFIG_NET=y only] If the DHCP server provides time server's IP
+or time offset, you don't need to set the above environment
+variables yourself.
 
 Current limitations of SNTP support:
 1. The roundtrip time is ignored.
-2. Only the 1st NTP server IP, in the option ntp-servers of DHCP, will
-   be used.
+2. [CONFIG_NET=y only] Only the 1st NTP server IP, in the option
+   ntp-servers of DHCP, will be used.
-- 
2.43.0

