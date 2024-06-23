Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF2BC2BBCA
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 11:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538868841D;
	Sun, 23 Jun 2024 13:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MS9T/zGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8815884D4; Sun, 23 Jun 2024 13:49:10 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F339B882B8
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso3930215a12.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719143348; x=1719748148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8x4wNTBFZsOmUuS4Y/uFUDdWkxhwonx25gzwnIvo4w=;
 b=MS9T/zGYc3Vk8mTO90lRZlW8kTLVD0rQEI7t54Lpk7ce46vBbym1cC6gT/W9FgPBMT
 MkQAgTDAysR6LfqEMZXz9ezQZjHhCAjuzVzu9CO8V1QkOiCQSb2jU8rhppU2dW3XFYgn
 R9UOfOWZ5ZtFf1RDBUpE0yB+PhlaHOHpRZ+MlZbpZUuJIlI5BX7j2IwX+dqDlV5Vo2GM
 6vglCZRyCQVbNXfq0eCgq9sQ9KVSRUldmitjBc2cdRCILywnlycMUf44AYBjy8w5nTOs
 ppa6ezwCKqP4yncpUK85FktWcB7TQxZ1OZWG+w9swYf8XEfNr+JVaM7sD6dxJqL+JfOQ
 hKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719143348; x=1719748148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8x4wNTBFZsOmUuS4Y/uFUDdWkxhwonx25gzwnIvo4w=;
 b=hUjN574lWwuHSd2XBYVLlRtnuPdnhzL3mHg1mrgPq7ulj/JtYmkyBJVNEc/OONA096
 wzwqCINAGbv8PeVO3J/lQJHTPNwRmIEXvR/nwJ/8qSUa7UUbimJGXL8buUOx2it3fUcy
 9O8X0AU5RX/Gk+5DeCKo2Tth3XnCh1E0tHa7mpcUDTWAwY1dSo1FwbUE3vygG6vJL9Ok
 74nl8MqlZejxRlVP1XzRzxN39ORr6/xNnxxzKhgLl51W8lbWTW3csnkjcH8Ln63xzCGu
 jMuhJboISMELNIIbs0krha5mMA4CZVzfnVzupwOHFdaiZn/aKY0VccoGYsrruCj3HyKq
 FQkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnmIC21rOkyxfZmREnG6DpBrSBg3VRzApO2KiJeVlZJ6Md4TC3g5QNMo4ZWJKz4SXOyC91Z/ig+c2FmtP3kgdqt/uXQA==
X-Gm-Message-State: AOJu0Yw9jNGzEKUegwoWevVhvqUDevW2p8kg7FxEgiNPak9cXE8qYOQI
 CNCn3FpJ+Twhtd1wjYI1BBLG1tZ3NZQ+Gy10bGA4NqH5Do/1KNTjOCttEk7PCjc=
X-Google-Smtp-Source: AGHT+IF0/4PfRK2LK5ufJnpiKdEmkpmUxOt4eOU84cmy6cT7X8QvzqBhagEaJ2MENyltjxArGqw4Sg==
X-Received: by 2002:a50:c34d:0:b0:57d:4bd:7315 with SMTP id
 4fb4d7f45d1cf-57d4bd80e2bmr1277892a12.20.1719143348164; 
 Sun, 23 Jun 2024 04:49:08 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d30534ffasm3402053a12.60.2024.06.23.04.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 04:49:07 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH v2 6/8] efi_loader: remove unneeded header files
Date: Sun, 23 Jun 2024 14:48:16 +0300
Message-ID: <20240623114838.14639-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
References: <20240623114838.14639-1-ilias.apalodimas@linaro.org>
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

efi_tcg2.h already includes tpm-v2.h. Remove it

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b4915cab6be7..19fe4720ef48 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -16,7 +16,6 @@
 #include <malloc.h>
 #include <smbios.h>
 #include <version_string.h>
-#include <tpm-v2.h>
 #include <tpm_api.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/sha1.h>
-- 
2.45.2

