Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E6D68B28
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5489E894C9;
	Thu, 14 Nov 2024 15:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DoASUiGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5A789584; Thu, 14 Nov 2024 15:20:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF2B88C66
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43158625112so6513005e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731594044; x=1732198844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T9s26tvoMWoE0LUEf7FGl7DyHYFrTDXHJOPnFUOKpuM=;
 b=DoASUiGaUGUT180wuXCcfSjbc375HLAYE+7+hRMMDsmEOg/Tqkzy1EO+LDwcMhan33
 UGzvSAxPJI3tsS1dXwlooJxjtGg2c+MWE+RPVDXo1+eKLaxqsXZ6WMg2jN1ZQXoqsxsb
 fl4jr+hn2W2XlJZz/qkN2lnErLoD8psH4xGY7AwBgHw44DzmFbT2Bbgk9Tj82d/NzJ/r
 OeX9Z6pMyA5+aQTS91gupfEaGfcDDjjzChd7vdS6RvBkiw4BSS0qnMRgN7Ylu4nqNTeH
 fnfxNHDjvGXjE5s7fFxGVjfABtkCD4lkoZkMJyiBzD6mE0RpTjL0a/3+IhcRa5LdAcuH
 L7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731594044; x=1732198844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9s26tvoMWoE0LUEf7FGl7DyHYFrTDXHJOPnFUOKpuM=;
 b=hTUEuEtWvvbT2MQjccsUWXLuSn6s1nSpx22izAxDpVlh6Ib86EMAA/tK9MjsoJbl5B
 Yut5oemDjXjqQcxPIeKWFDD/28wGaYLmC1LFD9IbEp60od8cgaXQh5Dzk01jXnS/UWhv
 rcK7QHvPKU/vzj2LVwEqwscH2CDGTy10SXrlhhc4Dr8ZTkWhufINRgDgWJdcrGT69Sn/
 51mby2KYMwDSzWc7kbZAa7uZDM9liz7lFzBO5m6kaQd0yMQPUoJ1OnqjANCEn+JcVVXu
 k6P3PuMNwB7nHDNfkZWxI9hqb+j2kBiEgN6OBqNqbbtSEYQjB1eyz6eASqX+XO4SalAE
 gByw==
X-Gm-Message-State: AOJu0YyB+6C24+305GeVw4Lwy2GN8sH7Hrp/9xe7XDv2wJpbtR++ODAe
 M9+yuPsakhOzuY8Pa+mo83JtWnUN2Lg1Fhs93q6YgSqPTjGWctQVNnkCGzvLoQ1zsLpfANrkvWc
 /qkE=
X-Google-Smtp-Source: AGHT+IHV16eaQzOIBD8LJwgoe/UiuLRzYYkLXEUPChPhSIGLXppeRk00SuPmuOmZ15JJ7vLY/BMixQ==
X-Received: by 2002:a05:6000:400c:b0:37d:50ed:daa8 with SMTP id
 ffacd0b85a97d-38218502c9dmr2244338f8f.18.1731594044594; 
 Thu, 14 Nov 2024 06:20:44 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3895:27b4:20b7:7653])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbebe2sm1582047f8f.61.2024.11.14.06.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:20:44 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: wget: update help string
Date: Thu, 14 Nov 2024 15:20:40 +0100
Message-Id: <20241114142040.2051271-1-jerome.forissier@linaro.org>
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

The lwIP version of wget also supports the legacy syntax. Document it in
the help string.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/net-lwip.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 42f8bd6b259..4dc97c6e184 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -39,7 +39,8 @@ U_BOOT_CMD(
 #if defined(CONFIG_CMD_WGET)
 U_BOOT_CMD(
 	wget,   3,      1,      do_wget,
-	"boot image via network using HTTP protocol",
-	"[loadAddress] URL"
+	"boot image via network using HTTP/HTTPS protocol",
+	"[loadAddress] url\n"
+	"wget [loadAddress] [host:]path"
 );
 #endif
-- 
2.40.1

