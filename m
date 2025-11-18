Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B55CEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 529B183E48;
	Tue, 18 Nov 2025 19:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="snkvL7s1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDCDE83E61; Tue, 18 Nov 2025 19:04:44 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CE7841CD
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74526ca79beso4458523a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489081; x=1764093881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eYU4RJPUWN25zCcqFFxq/Mmt925j4HEYoR+AH82zNY4=;
 b=snkvL7s1jtbljhYQP7kD6oYXaHdoReAnyrVtUSLtN69BacDCLQJdlL+GzTdj5SU9R5
 Ff7OS97HEJuR9nn904/fopo7pr9Y2ZRiuwYh7L1g6zHVTPsPdvG1sLzQCydgvZqd9eMC
 vr7CF+ZJryShWtZRDHogReqE3Y/cxZpBB1bLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489081; x=1764093881;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYU4RJPUWN25zCcqFFxq/Mmt925j4HEYoR+AH82zNY4=;
 b=tQl2vG0BJfzT4n8qVpf4BXGwQ6BUZ5AQmTv77TJV0vsB19EYZb5tofp7I2jpV2bUeL
 UhKRbOH7CSWTORE2DAksGy8aAcyzGb1enMBemjAowZtsH06xjfaAoPRTeHzNPIqXDMk4
 MyD7eaw5knxi/srvKYhk29tWoDoZ9T93nkhclgh/2ItDtANIKLRBRD4MCJ+J+Yhyq4be
 el92nsXBScJmgkzrnVGFW4E/cVRvVRbXG02gpzyxMTzMl21Xg2vo1zExi5GdubI70w/0
 /12crDo8ZipXX6JblAIroYWlJYx//QGuLuJxvRLEL1KhIJcN6wPJ3C+XPNWV/SE862Dv
 xEAQ==
X-Gm-Message-State: AOJu0YwsMuTPyhtW5TE7f/bSmuuhMlYRo2XKPm6Ryd+r/m1WyahnVONr
 2odmmqhQRNMJxEysjV6cU0wh/ejUdCq1jsi+XKhY2AtN+xb2kXqWcm8ITwGE5CEPRpH4N806PZD
 7kTWPs+OJ6A==
X-Gm-Gg: ASbGncvhN5k14GZ5t0gGxQf9v228zwb3fVMqqihIs7hf+y5d45XgU+wx+0tGxQHz6UN
 uyU+5mKxyfGWw/Z3iQtSCooLD94/jgazJY7NSiWf+l1Mwzk7i+4Lyf5uua006hZdLMgPLJhN46L
 7zJgESfbef8r4WBWqwSdXOAAd6dBXdUwL3OVn6K2TGY7eOWr0rDFEI3L/EcwNCUhj+LKDqwjO9i
 DTU5V5jvjmfX+Px+MYJOVqD7lmhkYQTy0sG/lWjbnOGzDrcMUR1DJnj7d9Ed3RFcTx7vxlg+w1C
 7U8B8sj8d0KJeZAyhhEpIUqH7lZh3GSM1/kSeP+ETXLNCsTQ13H0vgWd4PP8aN4RHhzif9hlx4L
 X18pp8x5Rwbt6YiTDrYrFNH1myocZM3Ee01r3+Gp+dlJ7RfKPQUjPAnrKP0v8hrm+1+Wtvac4yc
 9IIuKFrwUEeBxxIzKvOfz03akK5Ir0pF2sGlEBzKQK/+Ahn3ogBDPrO68UzM0nOJI=
X-Google-Smtp-Source: AGHT+IHscTbpkAeZbZ01PulSOM0YAfz26J2slFj71qgQF3I4QEYSjqRSMVsVjkcoKcCybG8wKRQahw==
X-Received: by 2002:a05:6830:2b28:b0:7b4:1768:ff3b with SMTP id
 46e09a7af769-7c74453d1d3mr8773413a34.22.1763489081458; 
 Tue, 18 Nov 2025 10:04:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c752f9c934sm3606950a34.6.2025.11.18.10.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] warp7: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:40 -0600
Message-ID: <20251118180440.591560-1-trini@konsulko.com>
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

Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/warp7.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/warp7.h b/include/configs/warp7.h
index c79c4e5bafe7..eb792c228c7a 100644
--- a/include/configs/warp7.h
+++ b/include/configs/warp7.h
@@ -35,7 +35,6 @@
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
 	"ethact=usb_ether\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx7s-warp.dtb\0" \
 	"fdt_addr=0x83000000\0" \
-- 
2.43.0

