Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C92C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 09:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A79680EFB;
	Mon, 28 Apr 2025 11:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hybBbtKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB6780FDA; Mon, 28 Apr 2025 11:24:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7F080EE5
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 11:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso35975075e9.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745832278; x=1746437078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHWgbmB6w0sbG4ZRdXgXcPIlb0fhDb1XNemUyd2PUZE=;
 b=hybBbtKvFQvUtH8F7ltNGwxsPD4mZpT9X+JAjyPvVnZfEm2YCxhjyG6kSKT4CdezxG
 4cfPTEQrZHiy1YqONqbw3wKGjp0pG9EjGQjfNMul6tYzqsGZrDLJw82j+0VO6k51ct89
 MLWdqCC0F5RNt7rRPnXTUnG/tgjQkacHqt1Kaz7EqrY/7dEF1Y2q9JLRicUaQgpFY5kd
 fTxiQZxprzu6F6zSeQrbN8vVXmWPESCR9ADtrJdw3W8joblNzquZsx62H75eLerzxxLV
 XwK+MB7vFIjNzFFqXw3ySzOpWP3n1SnDNHwZV+dxl1r6nnbiUuHjPfOwkYdvTeypjx2B
 5QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745832278; x=1746437078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHWgbmB6w0sbG4ZRdXgXcPIlb0fhDb1XNemUyd2PUZE=;
 b=OrKMCADNOkdiJcEQD5EM8esuVXpVedAQeRvIJF0Lv6zXTV75T36dhV3/qKgZKQKi8S
 kkhtoizvVGwxovpRfrexVc3FE0p6b/IeQzox/2ni0by8Qdk2UfVZqEUsMgxMZ7f312Hh
 m/hmojLR8PkHnLXspJR3HVJhV/Mq+zfLPiv2pUu69AKkBdPQh8LexST0iiWHpi3vkFZP
 0bIZrBrZcRgky/HnUUgYFZ+iTDC/VlDlvrcV1Ju+OX0u7+phQG+fLke9sgGtW/BWHkbI
 N/5wC9BarcZPY3aXHUvf8BzNBYnvnpBdA2w4RMSYXtFvWGTnACJ9aJaTvElIuL37Gryj
 //xw==
X-Gm-Message-State: AOJu0YwvLcj7/tn4ydSZ6EZIgzbFRwrx7i0O1j15SSKsKxl83j1MjrzU
 zsP/ReWKW8TynCQjdTjLLJOoeHNODAu1d9dnkKmt9cNTgQVsXTFF6VnL3D7S8l7QUCZmfOv7A5Q
 bMq8=
X-Gm-Gg: ASbGnctVnH47yPPlw0WiAMIxszNywOSLUjRsbEC91yGx/8gqLs4IVn6FQruVfBCAvAl
 qRcimcSoc7IO0x2zjmiZVmRRwMAIDyLgO8IJ328ADlYiUEZRIa2EEgb9mrdQB61rAY5n5yUV2/N
 ba7cPlH5f0mlywUTKwV9xP86nIj9t3QM7CAZCljuB0J6PPmq9/kv58SEqdEf6uewcLrOTYaM719
 GEL0q79ZrozT/g63UKbT+FoBhHFKqLS3xQ4UGxzf5OL7GROxg2oLZE7drF1jVYeiUvWXk6MhuEK
 1sVXQiFk0fHGhAntwHZQ75cQ3SsdkMYTxjtdINB/JkRBfQ64
X-Google-Smtp-Source: AGHT+IGTD2zp/aUUNWJdcQO30qBsXJVlSb6bsS4rziqT8BL8D+ESdR2lf1KsHEViqCao3pgsEspRbw==
X-Received: by 2002:a05:600c:1e88:b0:43c:fee3:2bce with SMTP id
 5b1f17b1804b1-440a66ab25amr86327485e9.26.1745832278150; 
 Mon, 28 Apr 2025 02:24:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:635:b5ef:1b38:e66c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2d8976sm149323365e9.27.2025.04.28.02.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 02:24:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: tftp: time out if there is no reply from server
Date: Mon, 28 Apr 2025 11:24:07 +0200
Message-ID: <20250428092418.2606467-1-jerome.forissier@linaro.org>
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

When there is no reply from the TFTP server, do_tftpb() should
eventually time out. Add a 10 second timer for that purpose.

Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 net/lwip/tftp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 4f9b2049187..4f88924e47e 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -15,6 +15,8 @@
 #include <time.h>
 
 #define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
+/* Max time to wait for first data packet from server */
+#define NO_RSP_TIMEOUT_MS 10000
 
 enum done_state {
 	NOT_DONE = 0,
@@ -106,6 +108,17 @@ static const struct tftp_context tftp_context = {
 	tftp_error
 };
 
+static void no_response(void *arg)
+{
+	struct tftp_ctx *ctx = (struct tftp_ctx *)arg;
+
+	if (ctx->size)
+		return;
+
+	printf("Timeout!\n");
+	ctx->done = FAILURE;
+}
+
 static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 		     ip_addr_t srvip, uint16_t srvport)
 {
@@ -150,6 +163,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 		return -1;
 	}
 
+	sys_timeout(NO_RSP_TIMEOUT_MS, no_response, &ctx);
 	while (!ctx.done) {
 		net_lwip_rx(udev, netif);
 		sys_check_timeouts();
@@ -159,6 +173,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
 			break;
 		}
 	}
+	sys_untimeout(no_response, (void *)&ctx);
 
 	tftp_cleanup();
 
-- 
2.43.0

base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
branch: lwip-tftp-fixes
