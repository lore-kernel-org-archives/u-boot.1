Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A6ECEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1DF841CD;
	Tue, 18 Nov 2025 19:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RrAEoSC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74AB584309; Tue, 18 Nov 2025 19:04:43 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56BE583CB9
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e89a44007dso35314fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489080; x=1764093880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VGDN9rbUxHDCuifYX18GbZPOauAsl0PV+0ycZzsv6Ic=;
 b=RrAEoSC+qPJGN4gIl9ecoQPlXqN49kS/oaSnCHDtycec2ZUrJW7qZuVfoU/OkaTrs7
 4uC/X3Bxyuq5z3O2Oa74vDEWeExqnLNWrycIPOA813plBO4YVsiyzq4vCN1OTkbVhgz0
 JTC6en6RZr6EtfMLqqIbLuWbLU27LI2fxSrJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489080; x=1764093880;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGDN9rbUxHDCuifYX18GbZPOauAsl0PV+0ycZzsv6Ic=;
 b=P+rZd2l9DXNhmt4hJVKNNLKStAHR3Fmkosrgr1Bthf5slB6+j5d7c59ofR1KrpXSz0
 YNIX8nFItnu0TwxH3nZmnBc5cy54SNAlUyIVha8ez86d0RY6SNXhXmg4lWyZANbmguOp
 LLjPOZeDvL+yhLD6hksYVAo40iRLh/qWI7Cg+6jc2Kf31VaWO8rXIjp9AnGRRFpalEHI
 YoCMfeAoYSKmXhgBRR2+RuAsVmLejgae7p5r0x2nOxJhouLSbYVZcShsoPYc0tTMT3nk
 HzAwRg0ehVIGwDA/vFO+yH4zcd3dwQjC1Q9VoQ7+1ABQ9rShhAM9bwQxAauEewErg6zs
 +TYA==
X-Gm-Message-State: AOJu0YyXSXHmVGvwOR3QQrs6dTdLr0Bxi4cXiJuoiyzqGUBCe8lH5yZW
 BPuQCnFXou1gAmGmGNdBKGl6yb/wLdQL7qUEGBTrUBuLLfLameVqWET9i9ZUHxm+v7TEuq2GJGL
 lmcD4RJCGKg==
X-Gm-Gg: ASbGncvUZIpjepA89cdnrhjh0lkPtiq+a+mZf8Q6tuiXk64uRjtXOaHcTzXhRUHejva
 OLY4wZ8HKcgq+SGtRfKg2f/plbvbpxQbJD+ZwL/kprviLVgxOHvIsmmL+vuXrdjdZoNReXDokR0
 YP/l+unrxc5R+8UWN+itjB9Q3r/jUqtMJQIO0H0gxrhdXJkvGNjcFQdbhyV+Sv/V0vYTFNpqEcO
 7nEdsMvOtlrz1sFiEOfYUH/FMCRq0aVtgdap6LGEXXUU8/TE2NXjrgAkId1a8S4zCulN1KJlwsl
 59Sj7oPHqJ9mpMy6AN+Vy2tdsLNXeFozoV6lfa7R0UMbUFmDF/rZ3kP2tyZnuYz97BDRle1DhNl
 31hbkUZUDt+YCdnDIIMHabjfO/7Vhyh8loBHpMEiYSnCeYq0gkRtbuEm+ZAexi9K+2VLQ/aoRxp
 cOSsz3YxFTwZ5vnobwRhlP1LkpsyuCIpRS78J01vE8t4pVrfdU4a5g
X-Google-Smtp-Source: AGHT+IGog46mQ6J7gpfCeRjaMMYMHBpD8f09IESMBV8ZUPZ8SvJDPH/6mbfj7uJDm5uPxXYH0otEdg==
X-Received: by 2002:a05:6870:380d:b0:3e8:926e:bf9f with SMTP id
 586e51a60fabf-3ec7da9363emr248154fac.13.1763489079935; 
 Tue, 18 Nov 2025 10:04:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8952f7e89sm3703920fac.14.2025.11.18.10.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] wandboard: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:38 -0600
Message-ID: <20251118180438.591533-1-trini@konsulko.com>
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
 include/configs/wandboard.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/wandboard.h b/include/configs/wandboard.h
index 7f764b900988..7015df87b4be 100644
--- a/include/configs/wandboard.h
+++ b/include/configs/wandboard.h
@@ -21,7 +21,6 @@
 	"splashpos=m,m\0" \
 	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
 	"fdtfile=undefined\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_addr_r=0x18000000\0" \
 	"fdt_addr=0x18000000\0" \
-- 
2.43.0

