Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593C1C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 16:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87ADD800B3;
	Tue,  4 Feb 2025 17:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PPBwCU/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20CC3801BE; Tue,  4 Feb 2025 17:01:16 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FAAC80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 17:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4368a293339so66748935e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684873; x=1739289673; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7jMRRunng2OcOEIGW14xnD3tcjDijGkJj7ls2qvjd/o=;
 b=PPBwCU/0MJt2j6dhAiCOmzZwWF3cm8dCfZL5fodgZFvRkMOgq8/ZS6Uya/o2mQAisn
 6pG0DMkdds+PklK3yqMGmMJbTXhJYH9I8yZ+iTdjDvJzmlu8hPuTo+i9UZT8xolTr3k1
 lypNgO+oBZSSa6icAL9MVvrYOEbvt+V9IKyqPE2L62vpQ9J6LVzSESBUQ/zpPfJixvPh
 nB4dZram4qhb30bxmV2LP6q0lFEAhxD9XmtIwo6BLOVu7vuI6ZB80upErz1GQIktMEIV
 ihAR0rKXzOCdq0PVb3sHI/AHAlQ40Irx0faUtKKebmR3eBex/rGvP+L0StCjQ0J+WFtS
 mzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684873; x=1739289673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jMRRunng2OcOEIGW14xnD3tcjDijGkJj7ls2qvjd/o=;
 b=wqAWeY1ryYOOiXRypeUiAggTumSWBQqtc5rfuLOIwMYglSI4u2RC984b5HSuOva9uQ
 047v7Pwc4DRh4NcBkbepLw+Zr3ADPs4x0QcuRacdjFvcgOn7fjQy0/YyYLdxh0RoF0+A
 NRh0C6sDFyQJejsrLM0oMlOfCii6Tmak0YKOoluEwRolXaHFnhDYigC73Rl+lRI1wsyZ
 Qw+xjfUhuGaPygwpQ5/DGJeihu3N93akxcYjiF4jr7oJ75Bu/THNtsMCsqiVywha672A
 RehhaNlZnAa3ren4k0rX3ZhH1X8bQSua0RuEqfc0lLC1IhTmjXSNUwCd3VWCYXij1uLI
 PSgg==
X-Gm-Message-State: AOJu0YwYngl0QJo1AvQqfvWz25Mc/SHmmQiDE5PM6tgMbN78mb2OvWwX
 BLypDAdS7MHK2juX0D0A8kszvikGrdPQMsZhSR3KE7WegPQMJOkwZas/Ky69U1Edwz7rgWIzdfQ
 Zc0ob/OKC
X-Gm-Gg: ASbGncuKdV/t+HU0F5ureTUcAYC4xZxJ5G0eGu+s+icfkkBcxskMhgAoDC7diBEJs/4
 PkzG2q9uk0S1YGEzYnYMd0oF6bt1QNtzP0ocrslFJ8XH9bDDK/NPf/t5QHv2sS62PVUu1E5kyC3
 0Co/65P9RtqHFloSJLm51xQt14jL+jLeEwkw2GXn50R5GR/98mGJtAEdrbCOkO7vjFkhIsvhtMv
 1Bxgh9tQXiPeI2R4ppa0jilYSxBDgGdkHQR++H9jPmvA+WrfT9wVB0Fh3y3s0SrXYv4Xu7co9SE
 d9lzHMETjLt8oNbv6kPb9LmW
X-Google-Smtp-Source: AGHT+IEq2ZjdoH/NzRcjWcwULY2uIlTAliRWE3eLT5Ms2jNUeVNcocGXVod8ZTt8Syd9Nv1wAs91pg==
X-Received: by 2002:a05:600c:1e20:b0:438:a1f4:3e9d with SMTP id
 5b1f17b1804b1-438dc3c405dmr208118055e9.9.1738684873010; 
 Tue, 04 Feb 2025 08:01:13 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:43d5:b1e2:1df9:edcc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de2dsm230933245e9.26.2025.02.04.08.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 08:01:12 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] net: Kconfig: depend on DM_RNG for WGET_HTTPS
Date: Tue,  4 Feb 2025 17:00:49 +0100
Message-ID: <20250204160051.3055038-1-jerome.forissier@linaro.org>
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

net/lwip/wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but
dependency is not recorded anywhere that's why depend on DM_RNG
when WGET_HTTPS is used.

Suggested-by: Michal Simek <michal.simek@amd.com>
Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |  1 +
 net/lwip/wget.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e62817bd977..e3fbb7538ee 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2154,6 +2154,7 @@ config WGET_HTTPS
 	depends on CMD_WGET
 	depends on PROT_TCP_LWIP
 	depends on MBEDTLS_LIB
+	depends on DM_RNG
 	select SHA256
 	select RSA
 	select ASYMMETRIC_KEY_TYPE
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b76f6c0f1d9..de688641dd7 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -433,10 +433,15 @@ bool wget_validate_uri(char *uri)
 
 	if (!strncmp(uri, "http://", strlen("http://"))) {
 		prefix_len = strlen("http://");
-	} else if (!strncmp(uri, "https://", strlen("https://"))) {
-		prefix_len = strlen("https://");
+	} else if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
+		if (!strncmp(uri, "https://", strlen("https://"))) {
+			prefix_len = strlen("https://");
+		} else {
+			log_err("only http(s):// is supported\n");
+			return false;
+		}
 	} else {
-		log_err("only http(s):// is supported\n");
+		log_err("only http:// is supported\n");
 		return false;
 	}
 
-- 
2.43.0

