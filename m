Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8820CAC582
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 02:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEA38319C;
	Wed, 10 Sep 2025 04:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oh4+KEYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4977831A4; Wed, 10 Sep 2025 04:16:44 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E06830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 04:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7742adc1f25so2936544b3a.2
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 19:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757470600; x=1758075400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W7ikYE0H0NXsOJwSLGRh1BAgp6lxNDZJOZ4ZUezdtN0=;
 b=Oh4+KEYuoWBsmAbk6x6M0gjNZgPiJKx9KVDDg9vynxK8su1oUzE2gsFyXgYWB7vYc5
 65036+AjM9fqERSeobnFxFDRGXSm1J0+p+wC/yguFH4HIQJNgNEBm+YZ5rPAH8EBjJ/g
 ODgrUUpfjfKHC/rgi2h+mdtEXhJ6pWZzgQkqA5v7Lm5W49F8n5CMZFLeqP14As5VxJtu
 psv179l9HxCsR7h7Kqllm0YcVEKCRcjlSucZTt+Q+Q9KV0IJ8aMZddQz08dDdM47uWbt
 soP2Y1CP4osTQ7sTKpmgC/a41efA+gQlPzQsnR9zBMqF84p8bRRqVlGj0NGNQBYdiZUW
 PrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757470600; x=1758075400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7ikYE0H0NXsOJwSLGRh1BAgp6lxNDZJOZ4ZUezdtN0=;
 b=Ge/M7p8dy19p2rkttgPPDm/DBObU04HAq82sPyAVf6/PD0N6wUkrVkelTP2IMBozHD
 WQTWwzAZTa4SsZel1wnFZxWadd7pgRfkHdU8+WH0UlBtnhMUUUbgW70/BRoXd0oNikjD
 IYMRZhXWnQK2i0KSHGlfbY9pE+tERpyAWfP4KhQl7gGeM7SS+Z9i2LhjIW81aMH5QMsd
 kRSJ9/b6sgu0KdlFct/QAJOwPJeulxpsacwt4fekMaMDfauUX/KWwNh2N5j+QSGBxIj5
 R0KAu84vzXQADEqq+KAgApJupCT+b4zsB2IqXPAzHbkoWx5SmM7F5EmdCsM/gsH+JKcq
 lNew==
X-Gm-Message-State: AOJu0YxPj+F0Ueo/oWPzyFAbtILPAbDy+rIcWOFeZadKXZshnJjObcNI
 ua2s+iBX7g0ScS4WvKoFj9vuwBgJj4P7+/QBxr1D9Qcb86SCISKGHxXS
X-Gm-Gg: ASbGncvs2bkm/q7X77kL+9jLzf+P+XHixCC1OrCH8D2FY3k3uh2BdRkBpOdVT9z7bb6
 K25wldDWVPK5Utxy9OLcgEVHJn2QAekp3Tsi2sga9OwpzD3gnS6nPYMDoMQh5SIRMAi1+e1kNOI
 F1rEyATJNc4VScYW7eRDzw6j4OxOvVAa6m+htnnrYRwWMmWjVqVBjbR9ldpKxaCQwYBPEc0mQgp
 kpCc/WZaIhKyuqIT/hzaUZkxzTyjgnopdPTPAPOnF1YF8hGkhZylPV8SBCwN17suXBicSpq8OxT
 st6L8KAFKWIkZjyfhxboHZd8WB/x3SKK9i6tqTtN9lfM9efE/FEbgFoAAleMu8iLHWKmRmg32MQ
 JawgF3HoLkDpQIZApvy7Bh4/9MuP8KvYUYhWS+Yri6/qOU+CCEygTfw0=
X-Google-Smtp-Source: AGHT+IHzJuuQLL/1s0WnZWNAjQfy2HTR5XfH4g51soerVbPghm1tZ/U9bArmRL0fyGoEi41I+F2LOQ==
X-Received: by 2002:a05:6a21:328b:b0:247:f6ab:69e1 with SMTP id
 adf61e73a8af0-2533d226021mr21716217637.15.1757470600405; 
 Tue, 09 Sep 2025 19:16:40 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:502:af2a:2ed6:962a:cd37:55f9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b548a6b964fsm1007343a12.41.2025.09.09.19.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 19:16:39 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] arm: nuvoton: remove unused parameter
Date: Wed, 10 Sep 2025 10:16:17 +0800
Message-Id: <20250910021617.285527-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

remove CFG_SYS_BOOTM_LEN parameter

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 include/configs/arbel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index b5f684e88fe..63112baf9b2 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -8,7 +8,6 @@
 
 #define CFG_SYS_SDRAM_BASE		0x0
 #define CFG_SYS_BOOTMAPSZ		(192 << 20)
-#define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
 
-- 
2.34.1

