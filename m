Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06DFC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C9F83095;
	Mon,  7 Apr 2025 20:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kvebrmzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 668FC82E38; Mon,  7 Apr 2025 15:04:56 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC3582CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so38039395e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744031094; x=1744635894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NnaYF6zQ60ypqZ7WHUM3pYVjKVM7XP5pdCHOUBAVb8=;
 b=KvebrmzvjCnb+/3F0E8NyBIgN5c1m05TSVNxv22C0ZaVmgybrt0QwOgOQSFyhXTg7s
 xVscFWtrld+bQItk4/rCnPkW6FiGmUCLvS2FKHI+iqqs5FVBKYhjOm29PQ+V8ECMbiDZ
 I67Hhecqea3BuEkS7hXZ8e9qSIGuYDK115d6zgQYacpuHgY+ZvB02USyxK9XC53ybt8o
 1i72mYL60bReoD5Axy9oOODBIIB+Z1X2rH2MIydu9TWZXHd4HBorZZZeHCjOUgdUWs5U
 QrRGm6RttL1OSYQ9P6ZUNtB1n+dftYFfx/U7aUzy1HzfiEW5BlFS5nYdwVzHkSGH5tuq
 pqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744031094; x=1744635894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NnaYF6zQ60ypqZ7WHUM3pYVjKVM7XP5pdCHOUBAVb8=;
 b=mxxPt45cRURUreFqkzNLsa0LjO5I7rcGw7FW/A0vzw/jNx1g1EbWSLgjRrtqLY1ygw
 IVz1m0EKSlIAuzMOcx1Lew8sHicILd76Wjy2yGVOhuXr0uxycEPi8QgrAXohzE8Ye5gy
 CZkkCJDfRIYG4Dt5c4FLE9jU6cAZrUr9ef97uXlzifxe8TqTvB0JnYmz9IkkXwYTdPzK
 jB+DOGGMkF+IFT4TYIAUD0MtqBR844V3WLHFpcDAb9pq/imTPwOJbWv1DMJptLFUu9Sj
 9EAG8jQguMxlAUC5i6/hwUpAFNukkokaO60Pv/kXNheVx6N/6vm727P1OCqoTOClQ5g+
 vzjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxFrwcAIpQu4JVmhJbgGLRKfM9ERM8Y1MmzB+lh9TP/9KACrGgPJV/VG06Ft5EKQOttcpM/Qg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl/oj6eUTrHfgr7Sd12yhoU+syw5M7/wdBqm5NW9JyGGVs14rH
 z57IY7T5w2qL/qV3jtx1twEnjUqt2TFPZGm/rJrypHVMQSDnVNkK
X-Gm-Gg: ASbGncuRt+KTANTr+ibQepytTkraD/Ux5gMKMfGIQuEx5Yi2/5QCKozSrtn8DtiPBg/
 4fLzHPN+ms4smvYpaynCXzrTHx1e9tTloiB4/AzEa7mggHQ36mp+xS0FC6+iYd7058gewHCwllB
 50UI7S0nS+zZ+uMhrhdZNfTJFVrqyjHEGRJxqFhhxuJroKmpNuSexs9r1t65XuDGoqymEnFdSBK
 MyP2UKfQ49jQuk9VmPMxLRW7bnbKBbfMMNzdyOemercqlo/WK1lVd2KFCLFNbL3S53gOQzTeuAK
 RClv+wen0P+sKb5MgBdj4fCp3TN/lDZQ32eLV90+Nw==
X-Google-Smtp-Source: AGHT+IG4ayW1eS0j1EzkIobo5WwpcXDaV0PIf4ezLNpkyY7cN7AGtamWm5D1UfU+d4YcYt7dxL+6Hg==
X-Received: by 2002:a05:600c:a04:b0:43c:efed:733e with SMTP id
 5b1f17b1804b1-43ee06401a7mr66172635e9.14.1744031093514; 
 Mon, 07 Apr 2025 06:04:53 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:96ff:4d69:f7ba:e072])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795db7sm135931445e9.25.2025.04.07.06.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 06:04:53 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com
Subject: [PATCH v1 2/3] toradex: tdx-cfg-block: add 0096 Toradex SMARC iMX95
Date: Mon,  7 Apr 2025 14:04:35 +0100
Message-Id: <20250407130436.223645-3-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407130436.223645-1-ivitro@gmail.com>
References: <20250407130436.223645-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Apr 2025 20:15:00 +0200
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

From: Vitor Soares <vitor.soares@toradex.com>

Add PID4 0096 Toradex SMARC iMX95 Hexa 8GB WB IT to config block handling.

Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index b2149438b88c..cd1e75dcca6f 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -164,6 +164,7 @@ const struct toradex_som toradex_modules[] = {
 	{ APALIS_IMX8QP_WIFI_BT_1300MHZ,         "Apalis iMX8QP 2GB WB",                 TARGET_IS_ENABLED(APALIS_IMX8)     },
 	{ APALIS_IMX8QP_1300MHZ,                 "Apalis iMX8QP 2GB",                    TARGET_IS_ENABLED(APALIS_IMX8)     },
 	{ APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ,  "Apalis iMX8QM 8GB WB IT",              TARGET_IS_ENABLED(APALIS_IMX8)     },
+	{ SMARC_IMX95_HEXA_8GB_WB_IT,            "SMARC iMX95 Hexa 8GB WB IT",           TARGET_IS_ENABLED(TORADEX_SMARC_IMX95)  },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index eaa52ed24f70..71d70015da13 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -122,6 +122,7 @@ enum {
 	APALIS_IMX8QP_WIFI_BT_1300MHZ,
 	APALIS_IMX8QP_1300MHZ,
 	APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ, /* 95 */
+	SMARC_IMX95_HEXA_8GB_WB_IT,
 };
 
 enum {
-- 
2.34.1

