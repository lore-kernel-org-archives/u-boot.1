Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6ADCEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36C583FAA;
	Tue, 18 Nov 2025 19:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ktdeEiYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B820683F9D; Tue, 18 Nov 2025 19:04:30 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9648C83F8A
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso1421842fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489067; x=1764093867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4QOze4D9O89ag2tz7Kud6PfG6fORToFZWho0c3gBJCs=;
 b=ktdeEiYB7greCuJxqxis4jdfds91Pvavyp7X6VFXjJQfFEqSgZlx1S8hpr30Z8cxhH
 RB18UckUw59huRbi0+s5qolX3bn25pwKnnym9iSlR8jiVnRHlUndQDTvh2Pl3xN3s9kE
 kiw/hBoX1AEGz8bm4iI6WvqGGL0lzkkOtk1J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489067; x=1764093867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QOze4D9O89ag2tz7Kud6PfG6fORToFZWho0c3gBJCs=;
 b=PTkW1ghHAYUK2Vdn7mfcvXHQWaFHBOPPIkOBz1YOlHRjVu6v5x12xsNViqGVqoybKX
 Rq+guZOYSoIq8woGGX8brerkWYu7Ykg3P0e/oZtTIS3gwR+C7iqxh3opow5UbJruUZMt
 F99JSKwMN0ieiux68/wsRU98l+5cHiv2ksIIVArbfJrsnUCKDrdHVsD239c8Rf6Qk4Hr
 malzVa2ljgHp8MVBt80t8bILrhy4vQtRsXThqf1TZpG68JIJ8VdFvbMeEe0QNVZiBOWz
 dJqC1eszGKYKZZvjzdtQJIuBrMWpcLg7QJeLbUcW6uKwODO79Q6iQo2xSDfHuvVDFHmR
 0Tmw==
X-Gm-Message-State: AOJu0Yy2HsT6X/0GrZASEWNBrR9jN8fzgtiy0qDdgZpQhfphV7BbEKhf
 WQ6jy1HNiO/I3mlkPrM+O1U715+j/sn5O53ElK3y1Fe2+rHlYHJlYWkRknGTb1+c+FVdSn0x9uH
 sbdWk4LBm8g==
X-Gm-Gg: ASbGnctwdPH9K+2/9ZB1WBHuFGZ2MEDfdfbw27GabtI4zfR9hCiqlkns0NL8F8QOL4G
 vyJXlT+o3cfmmEs7GN4CwNl4/mq9mb6FikVxwyJmOQLil+CXYDRM5lr5/yfmBe/M3QfVZ0z3opv
 uT5oZGx3ZRbqCkLUI3yhsfgUB3qVi2ARokUTlh0jR7f73jhAZbbm0uO27C/IcdNx9zRLPqXFiz8
 6WhSw+oxiEptVUAOA7wF9V9zcNVHOiqcYUt56qzrgsemyu1lxjw9XLokQt997E/nAKaRdtxBpEt
 BD+C1iAuG7sn3aaEWnp7bXGQFf0ieLGHJcMMC0W1vs9LkzJWIgYEaTYPBg3wVDO2WaF8LzAoiy2
 HMQ7bk04lAhsccDTUIW33xE4rjAADSjMuyIn9bGP21oMMXYUsyqj/RM6d1BGcc6NzhDmPmIOM9W
 9AESma3elxJ491qhxX8xjKxCBPLWKTQjSjq5c37fXSuVIrIc535TqBK6Ru0CfC+lw=
X-Google-Smtp-Source: AGHT+IH4FpVcxH5RS31BWk/hJNHFvkCOvIz9Jp6k3omLLaEoWtbT6j+bnCDqWv+61vOuC8fJ6+xSLg==
X-Received: by 2002:a05:6870:89a9:b0:3ec:495a:74f2 with SMTP id
 586e51a60fabf-3ec495ae52fmr3568315fac.3.1763489067308; 
 Tue, 18 Nov 2025 10:04:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851d64d3dsm7311319fac.0.2025.11.18.10.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] nitrogen6x: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:26 -0600
Message-ID: <20251118180426.591394-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Troy Kisky <troy.kisky@boundarydevices.com>
---
 include/configs/nitrogen6x.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/nitrogen6x.h b/include/configs/nitrogen6x.h
index 23eefaffc721..cbfbdce48d50 100644
--- a/include/configs/nitrogen6x.h
+++ b/include/configs/nitrogen6x.h
@@ -60,7 +60,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc1\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_addr_r=0x18000000\0" \
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
-- 
2.43.0

