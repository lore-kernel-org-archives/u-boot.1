Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0ACC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E6D82C87;
	Tue, 17 Jun 2025 12:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fvtihFz8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C50682D3B; Tue, 17 Jun 2025 12:07:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D0182C87
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so63436945e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154871; x=1750759671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkjgIbxAHU8Zj90b6X0L5ImxJYsM1pvo4wIHkeMkn8g=;
 b=fvtihFz8daF/5kVSNiWiIKwOWZYNbT+4VcYAH09tvZ4MCtRQ2Mj3LgeDp59tWNIUJx
 LFNjXAHVNV+rGPLQJ7zsE6P4Kg/XBUjUM4fKv4HykHgnOZxMPgLGn4XONn7Mnlt+BXD1
 y1lacwb4nebFl8fQej2NgUDVBWMyZsQfZWN+lGO+SK7oyC4INagfw3Vs6Q/cZ859P2wB
 k1ay2PcP3qy3cEj0l5BPuPWHjoYR2Y7e08YxcuDK4p5Kp/sXbca3/0S0KSSIknnjW6l6
 vPwIr6U6yMDhZl4VB5bvzX/fqZ7+UjL8vcuOCcZZw+ACqUiHSk6e4piwQ7Hw0M19QUrl
 yA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154871; x=1750759671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkjgIbxAHU8Zj90b6X0L5ImxJYsM1pvo4wIHkeMkn8g=;
 b=b6aRzkP8qtbp3DAggBhqF4gUolQTFM1MxdSN73fnVbHBd0S9ElPy5ebTY7ffJwAK+g
 7GaDKbeMwlWdouVBkAbKUecqeYl1wsMWvEN6G/2IDuAemBCiDr6CBJbrPMsZ+X0dRvCp
 jtlcVM+Xau/yiu3RCEqtk6/Rv77YADB+FJqCYXzKgyujEHFGQae8nUHqsU3/IYXxqj1g
 y8IJAXhBLTLnjvbKjzLVT4miuIZ9SiK+A06ntXi2IR1/97FTmbsVgpixoix9ydxTCz69
 Xing3ehiy35xR6NDqn4AcD2Oi1Cn8REGoJtVe2Qb5TLf/WI7yEDqEI9DKPCAWq9kic6i
 OfTQ==
X-Gm-Message-State: AOJu0YynUSDacpamdqKx2DayqTfRWpNRzL622FKykt7zS16EAAE1trcJ
 M0M+jrXeaNh5ehumRUNO+bzolo5tg1Apa2IkcvTAdftMVQsUWvxigZ45MOoG7K9vDaopLun4+7c
 JHni0
X-Gm-Gg: ASbGnctWsk3+YSYgMM9DxaE4A4wyjTAwri4GpOOagiKnOlyq3+J147bBXza+H7IOH6J
 LmTciZgEKfaS9RNlB3lRGo1IWLbrnpWDIX3BIgez9TL5LAZLa9oQLD/1UKwRmX+sLCTN/KVc1s9
 sj+GPZaHoA6P6+2Nwbhy+Qa72a0eiYCE4X3svSmnPCzSsqw4h4H53IRTK0vgc7zj+bYMcmmXGuj
 MteoYPkg+onyui+ROizPD0ny96KNGpCkQM0fYc/WsIHWeC0dTMPL71WkskZtjCr1Zvry8KaqAcN
 3M5U4lSn4oqP9p/qFKZL5FnqdS/hS3HHtuRg3tsbWyIhHthcHieXdzSy7A6aci2WyqU/eCY=
X-Google-Smtp-Source: AGHT+IHHE9COLlB9JwZttWDBmi4L9okBRI44kDciE9POCaGw8lfMyA/gL7eHdj1Us2l4wQskFCVN1Q==
X-Received: by 2002:a05:600c:698d:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-4533ca46737mr130972665e9.3.1750154870826; 
 Tue, 17 Jun 2025 03:07:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/13] lwip: ping: accept host name when CONFIG_CMD_DNS=y
Date: Tue, 17 Jun 2025 12:03:59 +0200
Message-ID: <20250617100720.2544758-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

Update the ping command so that a host name is accepted in addition to
an IP address, provided DNS support is enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 21a30228642..51e37111ca9 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -14,7 +14,7 @@
 #include <time.h>
 
 U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
-	   "pingAddress");
+	   "pingAddressOrHostName");
 
 #define PING_DELAY_MS 1000
 #define PING_COUNT 5
@@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	if (!ipaddr_aton(argv[1], &addr))
+	if (net_lwip_dns_resolve(argv[1], &addr))
 		return CMD_RET_USAGE;
 
 restart:
-- 
2.43.0

