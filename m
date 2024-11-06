Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85B6D44D75
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E543891F4;
	Wed,  6 Nov 2024 15:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L/N2Vk39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEC9891BC; Wed,  6 Nov 2024 14:03:48 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CCA88C7C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so5634256b3a.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898224; x=1731503024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L2L8BQBiTVxExJxLBDz3DtKccrCP37UkZBNwKAeluWc=;
 b=L/N2Vk39XSqWXrX8KIs9ZRqc/f11iyEQzQqmfbvsIcKalno1y4J35VJt+Z702AKfyf
 wB3jCzRdC9BJgFivz7o9bILeuYOlCy3xgfntwhEMKB6vhf2s+NvDrdVx+Dx6O9tD0Teu
 rcRE0esru6sSfKd/nhVFw4hdEfztEDyeimnoyJWorqYg7kCDS5OBpa9a8xNXk6OE2Vw3
 Hl0MziZ4M7MM4I+9qGpDAqGsUM6gDqo2Cq5yUQylWhviVsPrJJa2yCSn8GhZ4UUqBwTL
 MhlzGuQqplTY786EFNvnGYlljcO53CgYgPX7V4bJpexOoWE/FTYuwY9F+o05LIgLEItw
 h4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898224; x=1731503024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L2L8BQBiTVxExJxLBDz3DtKccrCP37UkZBNwKAeluWc=;
 b=qBUj3wSf1rYE7O7OveFgsF/nob5xxbKsCQmBs73QgqjCd/7ax5NEE7rPkGK4A8BkGi
 appVrQqLPW2sUk3deMC3qM9pFuX6dVaKDNXyuRW25BbqPFp53HAlkbrNlgC27SghvQnk
 m3JFX5iT5qct+HODSLRQGnSwc1tT4kLeB48c4/ABEBUkVBTDfIUplVrEGGgjVei7SLuP
 XvO8081DgU5O2KXL7NZBJ9Yp7sgQVax+WAxlsvcrC2QphCjQ5a8O+LxjnAN+ksVeNPJf
 nlMUn0IDGXEpciZO9BSY2BM3FPnWXzUjoDzTaGKr30emekk87ljrcwjB3RnKUwqYpz7d
 QAhQ==
X-Gm-Message-State: AOJu0YyGljrRVGo9euTGZWD8p3bfcFq3fSuW1QIcySKLrKqDLWT2NqV9
 EfRqnKspj1QGYWP+pQ4GY16IvrEBiksp46vsWZWi99CrymFq3XHIkiCHD9+H9hM=
X-Google-Smtp-Source: AGHT+IE4ixSoKNDBbIRr0MaFMAvVOhNt76bHdtgcCeU+23PnFtp7pIJhBhQyZDR49FpDp6N7LWO5Mg==
X-Received: by 2002:a05:6a20:12c4:b0:1db:ee7e:6e4a with SMTP id
 adf61e73a8af0-1dbee7e78d4mr9480454637.14.1730898224389; 
 Wed, 06 Nov 2024 05:03:44 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee455a7ee3sm11116155a12.55.2024.11.06.05.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:03:44 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 3/7] net: wget: Add a global struct wget_http_info
Date: Wed,  6 Nov 2024 10:03:37 -0300
Message-ID: <20241106130337.211101-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

Declare and define a global struct wget_http_info. The default
values are so that wget works as it used to, but they can be
changed by an application before issuing an http request using
wget, and restored afterwards. This struct is common to legacy
wget and lwip wget.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/net-common.h |  2 ++
 net/net-common.c     | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index 38ba95cf60..3039dfdce7 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -533,4 +533,6 @@ struct wget_http_info {
 	char *headers;
 };
 
+extern struct wget_http_info wget_info;
+
 #endif /* __NET_COMMON_H__ */
diff --git a/net/net-common.c b/net/net-common.c
index a7f767d5e9..e969d508cc 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <net-common.h>
 
 void copy_filename(char *dst, const char *src, int size)
 {
@@ -11,3 +12,12 @@ void copy_filename(char *dst, const char *src, int size)
 		*dst++ = *src++;
 	*dst = '\0';
 }
+
+struct wget_http_info wget_info = {
+	.method = WGET_HTTP_METHOD_GET,
+	.file_size = 0,
+	.buffer_size = 0,
+	.set_bootdev = true,
+	.check_buffer_size = false,
+	.headers = NULL,
+};
-- 
2.43.0

