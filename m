Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAF7C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 16:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E069687D7F;
	Wed, 20 Mar 2024 17:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NGd4qtG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64E9287F3F; Wed, 20 Mar 2024 17:49:14 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2069980245
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 17:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29bfc3ca816so111050a91.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710953350; x=1711558150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pABemtsVUMJBKU4giPqbJGtJrHbFS1UpZOD6MOGyc/I=;
 b=NGd4qtG3kUiB72yGgE2ywEA8/aVsLu43bbeXsPADAZt6e/K/r1eRqKK4xKRsK/YfG4
 uOALoJkEh4ga+c+/sIpbo8HbD6jeem+FV9R0lUX4eZsfypRZDoG9AuJipvu9NeDDfTTs
 7gCAkNNyPFu/LLGtIpoH3awh6NL0fk3EuvDJJZ2/a7zb0z0gAx1OHMNPEX5P+1IbNIO5
 dZWU9p9s24XwgfxF+2B76w+dpdzKARhGnrzWaKvO7SXX7SvVHY2exakm2XAB5Mw9czx5
 cF9y+8Lm3o0ShgCMX/w+ay5VwtvZTyef7tR2EdoPWS5N/2ytoxVaxmhC5/T9L+ZO/3bO
 9w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710953350; x=1711558150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pABemtsVUMJBKU4giPqbJGtJrHbFS1UpZOD6MOGyc/I=;
 b=bDczz3GOUJECtcLwx7R/C2zUkj9/0h0qD7QzFclx4KHoO1GrgHXE2jkNOS0PHNw2hM
 g4l8BUnZXlEcCNO6Mk7oxKa2BtXYAeB1U8rwjpT6SCqSuz7AdR6cco9YjRYZYjjKGuin
 tnGZWefglCHV2Ybc6G8CAMFC74ofa20qima4ZMxrHcTKsrKsB4demx7p6wU3HS+YWjFd
 +Eijg3TfxsoRRS0lYgI/BHKh0xFlayciFmZor1RM4A60cLHux5BT6Eaab5yo87uE4d9G
 jPRhx7RWOedOatfKZ5D5agBcQdm7TaChpTFYYeeug3xg7Xt6rC7PVFv7ds4P+zN4Rz4m
 RCMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl4a5QK21td40UgNpbULAkt3XMRzC7A5InjODnvRPmkYVm4IPKhqJAraY8WN9ZLALvHi7JgM2M0hXnHFIirVz7q77yJA==
X-Gm-Message-State: AOJu0YwLZkJsiWdz/qIVnDgEvGqdmgvfygQGWvPMpWZkr0OPx+ZihwIn
 Z6pGpUSkgsrVeZ+0lYVljO0aF3xUurY68M6BT7YqIguaWltNtlshqvr7mqgq9t0=
X-Google-Smtp-Source: AGHT+IEnoQABcwHRtjSPWMIq8MeK9oTDBA4oMLo+Pw5cOV5ohs81mCXZpSwgcwEqT1SaybM1jeCVDg==
X-Received: by 2002:a17:90a:5d89:b0:29f:77ab:b982 with SMTP id
 t9-20020a17090a5d8900b0029f77abb982mr2290310pji.47.1710953350372; 
 Wed, 20 Mar 2024 09:49:10 -0700 (PDT)
Received: from frhdebian.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 si10-20020a17090b528a00b0029951d04dc4sm1868001pjb.54.2024.03.20.09.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 09:49:10 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Hiago De Franco <hiago.franco@toradex.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1] board: toradex: verdin-am62_r5: Increase
 SPL_STACK_R_MALLOC_SIMPLE_LEN
Date: Wed, 20 Mar 2024 13:48:45 -0300
Message-Id: <20240320164845.141894-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Hiago De Franco <hiago.franco@toradex.com>

Increase the SPL_STACK_R_MALLOC_SIMPLE_LEN to 0x200000 to accommodate the
size of tispl.bin fit image. With the recent upgrade of ti-linux-firmware
from version v9.1.0 to v9.2.5, the size of tispl.bin fit image has
increased to 1.4MB, causing allocation errors in the R5 SPL:

```
alloc space exhausted
Could not get FIT buffer of 1325056 bytes
        check CONFIG_SPL_SYS_MALLOC_SIZE
```

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/verdin-am62_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/verdin-am62_r5_defconfig b/configs/verdin-am62_r5_defconfig
index a3febdcb6941..5b4b81c925a0 100644
--- a/configs/verdin-am62_r5_defconfig
+++ b/configs/verdin-am62_r5_defconfig
@@ -35,7 +35,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x140000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-- 
2.39.2

