Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B44DD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3D688E3F;
	Wed, 13 Nov 2024 06:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wOuNeb/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A9CA8952B; Wed, 13 Nov 2024 06:06:22 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B308884D2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:06:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so7822729a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731474379; x=1732079179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wAX5Ef2SrOxGF+xYVjbG4OIUse+l2G80GuismvHqiWE=;
 b=wOuNeb/8rAqdEdyAEJkKG/oCXXewFF3k6Smkmbk/7qlsZRqWzW+jH4/HvT6vwcL7zN
 aMD7HVYLifbnfwoM2F7CKLIJpQl7SL8NDlEVg7qCcy+zS4B9ntJ5XmbC7avYj5a/QnP/
 g/KekO7QYaKOFPpgZ3bqwI39AsdN3erkQWID5vad1uUrO+J7hQRXrab135uvVf01Zz7c
 m9xz5vKvq5+l+/v11ilHivCr9pzsNQlGb8ZFR8jGJadK3PXiBEHg08i81mwz1+bPf8B8
 PxGr+21/Gn4/o1U8UNql2GnEhXbnalWa9n8LCPVYUf3MGLWl03qIAyCAJULG9M46+Mul
 x7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731474379; x=1732079179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAX5Ef2SrOxGF+xYVjbG4OIUse+l2G80GuismvHqiWE=;
 b=Zr/MPrGwD+AnlI3DzTWbB0F/RVQeYu7YvA3H3iz+xch6MhzCKBd7EKt7LvGnqVofaQ
 382ZUKrmSomjxmNLKtGaKcl4tOas/7hopIvBlux8G63eNFZSwYim2RTnyVA4BWbtYEDX
 DyKZrPFQ9wGsdY7KAaAPKoAISCaf6GwGMRfbNifyZmLOzmYMiXeYbcHC86eoXbjt164T
 wW/6koMJxuyYB3UDPgHrvmCTAjzSdTOs99EAiw6DAZBl2R+oWT2eeG2ByffZMLohdvbA
 QcNR8O0b4AjpjTfAmQ/lrXBmOvHVjvdKeM5QfcfUbsbQHnMUVuYKYhsJxRvzY0m7RrZb
 ZpiA==
X-Gm-Message-State: AOJu0YzzK9lYziyem1oEs1DMLKVVNkO2ob5Gmv9RxrNmb74g9IohySRn
 /s8gPj7zVlY4FGJNJe2ajLDGK85H+nHwweNlVNwaONIqd0WlW9jq5DMMJUS9Wi4=
X-Google-Smtp-Source: AGHT+IF5VVz9fb998T6h9p2LwdBce90TtEmd0tJbKc9qzKKvwrEel52xcdD9hFlgj9UjY3CoVHd7Rg==
X-Received: by 2002:a05:6402:1d4b:b0:5c9:5e43:9480 with SMTP id
 4fb4d7f45d1cf-5cf0a310c43mr11753368a12.7.1731474379542; 
 Tue, 12 Nov 2024 21:06:19 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c7ce0asm6727970a12.85.2024.11.12.21.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:06:18 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] fastboot: properly handle unknown partition type
Date: Wed, 13 Nov 2024 06:05:59 +0100
Message-ID: <20241113050607.1850472-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

In getvar_partition_type() we attempt to find a filesystem driver for
the partition (of the list of driver enabled in U-Boot), on failure we
return the error to fastboot and completely bail out of the operation.

However, this should not be a failure, instead we should just default to
"raw". This allows commands like "fastboot format:ext4 userdata" to work
if userdata didn't already have an ext4 partition table (or if FS_EXT4
is disabled in U-Boot), as failing to determine the current partition
type is not an error in this case.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/fastboot/fb_getvar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index 93cbd598e024..9c2ce65a4e5b 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -229,9 +229,10 @@ static void __maybe_unused getvar_partition_type(char *part_name, char *response
 				       response);
 	if (r >= 0) {
 		r = fs_set_blk_dev_with_part(dev_desc, r);
 		if (r < 0)
-			fastboot_fail("failed to set partition", response);
+			/* If we don't know then just default to raw */
+			fastboot_okay("raw", response);
 		else
 			fastboot_okay(fs_get_type_name(), response);
 	}
 }
-- 
2.47.0

