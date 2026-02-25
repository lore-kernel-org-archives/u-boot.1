Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCA3FD3758
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 13:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773AA83642;
	Wed, 25 Feb 2026 14:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ka+ht8ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 443558366F; Wed, 25 Feb 2026 14:08:14 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BB98003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 868BB3F73D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772024599;
 bh=m/uadMrH3RgN41uG6f4UgVxUsFmD34YIrj8tiWuWcrg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ka+ht8uieyPgmdgfqa/8dtEFPCazPHgi0ULDrfh0XFAwYqK2hpKJtj8q+vMMT7c91
 QLXXJKXrIBl6T/GWCCgRIFz1pishThcomi5a7bTtMgCc6dS6DCtGHPNt5dz2xL9tAD
 E9igBKDQR3zZzAyCZOwbQfQo6YmDwGroYqgqy4OoH/VbKIYUJNyyeIomMBUbQtjy9G
 gEPeca3fn3cByPD5jd9evLYVQO6CtNhgwQEoZoiHCXO/s1VrXGi92sng2ATRclXziK
 1xu6tF+VnTZtpBlCQVTAvlmgEea9SStbkfIxttYgGccCNyuMdC80SSP07eRT2VVWp7
 mhRUKLrMYnWCPifnxSVJQ7TspW2LIAQfvXzuLLERMxXSEcUVM1nmrS1yrQJ/E2KfdP
 ideQQrIjCRqA2AQvz66p6B9/Isx4Ye0wIk+muCQT996zakpYlYpJ7s74bfyPsWgRX9
 dOhbudxVv8JYK9PqD1xfKrzXR89yA01oaj+PK4OtVfLMxnOgXbro4KYXfO0KUpq5jx
 zaIzAf93QrZBgvoXLyn3oH2wd+eQ+L8lgvjczwZN07FCLQAn4amVRtqDAgmTg5Iwog
 4qN5bQpLDDB0CusE1uOcLReq/cqy7BEvrLlgH3y1oNcPPrpBbzZv2PjoBKHhOvV7bo
 qckx7X1hH1K7brla/xXVDXw0=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8ff07df5e4so637732866b.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 05:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772024599; x=1772629399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/uadMrH3RgN41uG6f4UgVxUsFmD34YIrj8tiWuWcrg=;
 b=ss4MPBvtbW+Od015e7qS8YoYaDQHEVTOWiQduHkwIQsNdItRa7G1vt7yqjE/CFoRAL
 Kno3OlPkALIyL78pR1fJZFQfhYago+fiUjzq+Dqa8ZpB5+NtqeJ/OJfe1guBKk/vVuMq
 DBy3L1rNJftYZm3PNGxJNnhEDEBI0gaPacmafORvLHk4k/mLWCYwvIwKxiOxwulKIIe3
 ZdF16rbD6mphG7mlUzYJ7NNfMmQZ4wCacV3QuOY6BnZEBHRLImfFeB8KSr+cHCyJELTH
 aQGDcGnWbN7Oa+j76nE/MZ+N3Q+gN7Cj52K2L2g7EcjuHC0bGS/VePaF0mxcY+NuZ9pR
 etqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK6sidwIL8KmCSPyvV/5RgseOrgMr4h1rjrw7g953JNPMEQBEcRRVFokbYFHDYgft0y6mI2Zg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2qdwmt6GeMWrEWZeuq3juyeqIS+URi79alzt9VMAC5myo1lMX
 zr9Otxx2std7mnJvEHOgHRBObTUbWRqD6aopM6q5UdBsbJ7UbRuMwrkUuYXJxsPuSZ5kLQ4+Lal
 KyQ8BdGusofuFaXUh1UUklXh6sEB5u5+m7m5vskqZBFsjH4RmvGWuFqxGNdKvsbA/Zrv+jP4=
X-Gm-Gg: ATEYQzwMIKtRqtfLCkl//bYVx/53nLle426jCaTPP8nTDo0WL+8ell4Yd/B5RBAuVU7
 Aw0RZudhllopb8hZzrgxFdGhpqWBeD2t5PDPo5onb7NFNOPpdDu844dfhwdotVvXTfY2hzO/WZY
 edyit9eGhes62mGQAfeydE2hc017YqK1eZC8iZsIBYy31xsd2R1xBk1hknzjcbsYCpG1qjfoMKv
 RSH4/bjHXB6BuZK50/Bh7RVYH1kO0o99ZP2/2yriM8zmKA8aBjiSIe2bPqqljqJ7Vk2DzBbk3GG
 C30E8v3FGJz4dHH7vwmxl4pZ2DyWqeg+I8TVzUvPHGwKPw6olZAm75hbry48MXoC1AVLbuHUjzB
 6k8PJQyqGk8/1hHJcIeX59cr+KQyQzuJKwUGT3lLaIZRaYl9PGk0Q/KoI1q3GdBQbJBt4B+mqg1
 5edvCRqN+/g5wZfYvty+NB80dIUQVWW+TW+jKH5aw4mMip
X-Received: by 2002:a17:907:da16:b0:b80:751:ee62 with SMTP id
 a640c23a62f3a-b90819ae26dmr973001266b.14.1772024598970; 
 Wed, 25 Feb 2026 05:03:18 -0800 (PST)
X-Received: by 2002:a17:907:da16:b0:b80:751:ee62 with SMTP id
 a640c23a62f3a-b90819ae26dmr972997566b.14.1772024598476; 
 Wed, 25 Feb 2026 05:03:18 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd732eb1sm70098795e9.12.2026.02.25.05.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 05:03:17 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] disk: fix DOS_PARTITION dependencies
Date: Wed, 25 Feb 2026 14:03:12 +0100
Message-ID: <20260225130312.60122-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

* The symbol for the x86 architecture is CONFIG_X86 and not CONFIG_x86.
* Correct the description. The partition type is called MBR.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 disk/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disk/Kconfig b/disk/Kconfig
index a58717bda30..0a2ee7502ab 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -60,9 +60,9 @@ config TEGRA_PARTITION
 	  If unsure, say N.
 
 config DOS_PARTITION
-	bool "Enable MS Dos partition table"
+	bool "Enable Master Boot Record (MBR) partition table"
 	default y if BOOT_DEFAULTS
-	default y if x86 || CMD_FAT || USB_STORAGE
+	default y if X86 || CMD_FAT || USB_STORAGE
 	select PARTITIONS
 	help
 	  traditional on the Intel architecture, USB sticks, etc.
-- 
2.51.0

