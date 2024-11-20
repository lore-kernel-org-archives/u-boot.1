Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D1AD60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9252489661;
	Wed, 20 Nov 2024 10:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Nx9rNGMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBCE488F20; Wed, 20 Nov 2024 10:22:50 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F088889500
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso56176945e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094568; x=1732699368; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yuQ5TzXWP5OfUIZvQzt0XVE1jS/2Og+WgtXMFL/PJ4E=;
 b=Nx9rNGMV+eVUp1yRosM5zAx1Wbv5t758F1SKXae0Joe0B9Lc+4wbirYojM9UoLrdgL
 mOwc6peZlHM43h8ESeRwvCgApRZtyDV3DxU5b5K1myBSbn+QllgjvuMY33ixUvvUIajm
 Dy7G5fgH9Fhg/dC/nij4sny1McJ0KdWjpVt5/4o1jAE423fL4AY1rT2C4NlSCp0m+EQP
 uTDykHQ/FYVbIB9kw/Fp44MY0BAfZzDxwskZNSupD0M1Zucrg98HKJYqYjg3YVOlAdDg
 p0bTxkmN5amKBIJTs+LCyiWoFNiw3A/KVnFe4SQFwQ608ZvxW3muWvMLcoLtuowJ3cZC
 z0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094568; x=1732699368;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuQ5TzXWP5OfUIZvQzt0XVE1jS/2Og+WgtXMFL/PJ4E=;
 b=fONau544RubEdX22CJxNdqUF6TMR4Vsx9gmEHtPvC/sknNcZj0wpkbywn1+wMFKIK2
 7gX32FyDP3qZ9TEWWSzQMidlKg5biyicRkWJCAAoN6dQ4IHFfBMvKfMlNGuqFPX6QzSE
 kUhXRg0EUqmkE+gNHOr9elOP8SrGP1UxEA6ft9h0dhAa6X09S9kKaZFEQg7N18dquOyA
 Mlezi5aCIENQbJV6l9TiGhvcwdIhHN4DJ4LAZQ9Mpt5yHjEUubrehQJcFVhoke6V3K50
 O9JWLp+xCtFmgJdS92LFUboCnkD4P8rPqFE9Z7y7M89QqhF9PGuPn7npSnP+uawSZvu9
 YvTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWG+8DbfRnB0oi/WQeIjcVjxUT9HO30pqZg4WMpEzxemwgnPUs3CNo50gkz+8yPFNQL5KcUkA=@lists.denx.de
X-Gm-Message-State: AOJu0YytOvbk3wszRbTKmX4ChoQoCpodAEPxexVYxxy87vTuDG+IKGwj
 2mP2TzpumoS1sLVFHXQD5oX7VxXiNu7DPOw5I2fAEvEmSpTwnIO0YFtXA8U25oE=
X-Google-Smtp-Source: AGHT+IHFK8+X4Qru4awbJSRKv+rkda5lfAp+J15LHZ8Ea7SNxxYUHo8xd0HYIn8yUlv+gPT6uYWRrw==
X-Received: by 2002:a05:6000:184f:b0:382:3f77:8584 with SMTP id
 ffacd0b85a97d-38254afa9b6mr1563731f8f.32.1732094568506; 
 Wed, 20 Nov 2024 01:22:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:48 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:42 +0100
Subject: [PATCH 1/6] ufs: core: include missing include/ufs.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-1-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=583;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Wh1qd89AhJPQGtArWexykWlNyamVeqfZNnA3tF5gY4I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapkFLBOIqb7Aar9YqJEHrgoUf9DPXNONtVJQtRA
 sILL0V2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZAAKCRB33NvayMhJ0W4/EA
 Cxr90/x3ir42sWmcZPqNvUjw3/yK5okM0FRVUlIZ8v9sgPquZEcJJO47kmZA4MA9frGbOY4476V5fT
 Usy7soAynXBdr9CPw63Gs6IeyjuG3wjebxgt9JmCiIQO5n3F6OH5eCEzHVcgR/ovnyGBhEvOBN0ruS
 vHPO79de6J8hwQJ111/lWkGSFZp3/0LJclJJnY+yLYRpBMrLasvdPKASPU4KDTz9/wDKjNj6e1cIRE
 usabThwSrbt5V/pNDP+DfktMJw+c1+aHBeUyT7wnCDDQWFP5NOFBx3V8A5lQmsFf14SuDUFXLvLoCZ
 q1xFPuZhT5G1jnBSFX0ld+S7a56A912hg5tcXN+ppnq2VRYz1h6jVOjGd47IrKCi2atamgI6Oj9cTY
 ejNbDUKljdHtXCQTqNSf6/ogi9SUHvIHhGFgu3BLRDCYFHSF19muUZD+LkYYOeD5CpYGwLbKGYf6zK
 iqI3ppf+UpxRTfHjnxVhkvS5k2f5K67EbMsyEep0rrppDFrklMBPF1auuQM2fdZYT4uj8GfOlrIwnN
 V432rXGz1dmOJ24IBPNHEoba+DiIJcIC7tutKDn8rK86YtoMibIc49UMxEAWewcxLI0UcRvTRZ8Psd
 JRsXI6N9cTUcLW9y4Q7ElRYqo+UiFY9pK2JIx2c/ngc7V+SEuIEIljbUV5WA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add missing ufs.h causing build warning on some symbols.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index f7d8c40c448c6865b7c04e03bab6f3f93a44a591..31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -19,6 +19,7 @@
 #include <malloc.h>
 #include <hexdump.h>
 #include <scsi.h>
+#include <ufs.h>
 #include <asm/io.h>
 #include <asm/dma-mapping.h>
 #include <linux/bitops.h>

-- 
2.34.1

