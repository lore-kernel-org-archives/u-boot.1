Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B0D6A220
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 17:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DBA89607;
	Thu, 14 Nov 2024 18:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xNgO7xCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C7289624; Thu, 14 Nov 2024 18:20:27 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368E388DC8
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 18:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so10313885e9.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731604824; x=1732209624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yDarfKcQHt0ftA/X0hF+SjyGnz7S5K9MK6SPlnXHbbU=;
 b=xNgO7xCzlitkdVLkeYkbTljxVT/+c7NHpLJK3g+DyH3vW9Kb0Ll4YAjv1oSebc8s7W
 D0q1Yo1fABdELShWXQvm1P0JNJ/mUrwbY4C/WorRNQ0wijcwQR0X8/KhfLbrnD0rjqW8
 v816Y/MZktG4EVl/CJmyVnf4bdggbaveVojh5D2VnI6Wpw3ieBVf5LcMEyBzu11NKXwF
 s5E6agvMstuOkjcs9LT7qjmgkex30DhthVRmEuH5cq6417FT6isR6i0ZK6JFtkQgcfEC
 8IeTlDd6wvYTFA0X8Es5gQcXLopNgUxS2I02tROwk/rtN8kLqsa2jt5rfBkLXMMAk6ny
 7zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731604824; x=1732209624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDarfKcQHt0ftA/X0hF+SjyGnz7S5K9MK6SPlnXHbbU=;
 b=h/+Y4kqFcziAo4mcXa7JXcAZvmuobOlw25AWHqn9AtcZBfjEtz0HPbc3QsrNZ3NiNp
 0lU9S34hCfiIf+iHeYnXnd1BiBZGt2zIAWEr2wxzh6+AFdLuR664Mpjbkf1UvZac9l5+
 ahqk1wLhq3m9Pln/hTMpBtx6mZBIeWRCTZj/a13nBhd0dKGZHhTNC/R32e58WYHk+Mv+
 mwFAntkzZ67nSa47J70WAZYTk8uRZUlpuRkjaeVV16WLSSM3J9KUvlKA0g8oEJfJohKC
 CRIKkiHcHmDw3JsF1pT6cuGu0/dUWEto1YHv3ERFL6lfoFMmwLCyZ0fBV9sjSRxqtsNk
 L8eQ==
X-Gm-Message-State: AOJu0Yyj2Ahs2Vnh7x6MIxXj0lyiCDbydoDeGGIlUgMsKgtfyRYvBWMH
 PVjisljcOoqaCyXvC8+Y4MNvvV/zL5b3bscnj2hRDYfpP8qvLbZo5H9cGY6S/ZgvBBY5EMatf0Z
 O7Xs=
X-Google-Smtp-Source: AGHT+IH95D/RvBJlULCysqGc1W4/BfbBWRXGgFUZHVnI/Gv1o5SqUw120Z0svbfCMmMghzVHi4fxGA==
X-Received: by 2002:a05:600c:1911:b0:431:5465:8072 with SMTP id
 5b1f17b1804b1-432da7f12d1mr35180445e9.31.1731604824344; 
 Thu, 14 Nov 2024 09:20:24 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3895:27b4:20b7:7653])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28ba80sm30751115e9.29.2024.11.14.09.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:20:24 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <lucent@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2] net: lwip: dhcp: support arguments for TFTP file download
Date: Thu, 14 Nov 2024 18:20:07 +0100
Message-Id: <20241114172007.2074874-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

The dhcp command is supposed to have the following syntax as per
"help dhcp":

  dhcp [loadAddress] [[hostIPaddr:]bootfilename]

In other words, any arguments should be passed to an implicit
tftpboot command after the DHCP exchange has occurred.

Add the missing code to the lwIP version of do_dhcp().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/lwip/dhcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 23b56226921..281f4620958 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -111,9 +111,21 @@ static int dhcp_loop(struct udevice *udev)
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
+	int ret;
+
 	eth_set_current();
 
-	return dhcp_loop(eth_get_dev());
+	ret = dhcp_loop(eth_get_dev());
+	if (ret)
+		return ret;
+
+	if (argc > 1) {
+		struct cmd_tbl cmdtp = {};
+
+		return do_tftpb(&cmdtp, 0, argc, argv);
+	}
+
+	return CMD_RET_SUCCESS;
 }
 
 int dhcp_run(ulong addr, const char *fname, bool autoload)
-- 
2.40.1

