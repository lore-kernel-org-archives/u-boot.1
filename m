Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EE6FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 01:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6D0848E3;
	Thu, 30 Apr 2026 03:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rTvee4Um";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ACE5848FB; Thu, 30 Apr 2026 03:09:25 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8182B848DA
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 03:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dbec19732eso327571a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777511362; x=1778116162; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f/7JXr7iL6gs4EJurJd5XIn3oqkCEIAPYZCn/VHt36w=;
 b=rTvee4UmGmX9muoXAwPANr8Q+PmiYBpEFgOXgiZzOqTwiBdFylPlPwE48x7hOfQ+rp
 WpTOquCUOIa3a5XmA8zMORGwI3RqpyGdjjnC4WP0vTAx+4c3X/sKX4si2xzY0FOvyG4m
 wj+CIQX3w6cmX4WMw9BFL+PktkcYStMkFklG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777511362; x=1778116162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/7JXr7iL6gs4EJurJd5XIn3oqkCEIAPYZCn/VHt36w=;
 b=V1+IiqRNf/uvRb2Pjhg1e4QKTnqa4bilYwm2a3rrVoP2tVb/JpCUY2JH2F5+WYV5U/
 Ado8OjF7aslZSb7JsfUa80xBOSX0kqUjNI5IwGZ50hxLprkj4467dTBUmU69E8/rOBUC
 eqU97Ja/1ZtqLboGpM/tLJzq3L2oNJzH/wYimEjMxg9SFPnMZl8zUc+Jtv0hbdAqsesw
 LY/cvVpLRfq3tpgBzi3DkucK/XVMXUFW7275j7/bkDQqFh7dnCofGwXwNi1qEgepy/Ij
 WVhwS3iTAJtikPrkIGZNhvdlHvDVmgSfZd6bXlfr/RzQKID/Ul7/3qWnTR4J3Wfn8dkM
 kqIQ==
X-Gm-Message-State: AOJu0YxPmRmArzLCAn6zLRu09P8MuGg07TbUrFZJIf13jvmDNHyKG0WT
 aNb0SCFP5N0RwQc8ljBnGqVf8ElS0Gs6pzIVOIciH3gh7/BvhtAGHMnRcJgdCAw8fM92ZRl6j/B
 CqVDKgpln/A==
X-Gm-Gg: AeBDiev/EuCu8xqxysjmJ2fq/xhOGK6p/Iw1tmoHITX4TjohGKKieELZbBPp+oY2Csx
 Ueem8BH0w7UH7XB/bvvnR9V0UQ+4y8Ty3PXro57bGt1cUhs8hXuLu8XkbB49UftQ0gnQdvhwSfh
 rwQtYx3Aul/4JOO0ivIbhvGxouykATkCrZ0hbFpG+wCeApW6LBC3yoUh6h5z5NvdymdMQafMAXa
 VktyP6gscIOQwPPDRpaDaGh4X7bLtRUN0ENbtAPEPum6CBaBQBcm7B6dlIiX550uMjbtNlGg30y
 fy/Lbq/csSyhcGvmxWbkw6v2vqJcO4+1ZeRkAZ1jxa/4UJXI+pbJn36thKBo3fqG+yXi7s7ChPA
 L5vFHulMdCOl68m8KtK588+DgZIU6chA4DgmWVU72ozxcgw7cxDHWoS2etxJCLD3OSKEXqTjIVK
 oD4fuguACDHoK/5sMfidqwjgU/sqNH9RvjlmpXMTFNmyQbzG4cfX47zkDjKP5kGUO4q6hAlxeQ+
 GJmWKcym0r4pibWP583f1rrffC5ebtqxnPUnf1m/r8xfTh9K6yGalkCCjMfOWBM
X-Received: by 2002:a05:6820:f011:b0:694:a362:4b8f with SMTP id
 006d021491bc7-6967a4a0839mr503220eaf.6.1777511362199; 
 Wed, 29 Apr 2026 18:09:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6966bb9e1f6sm2248041eaf.3.2026.04.29.18.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 18:09:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: [PATCH 1/1] socfpga: vining: Enable LTO
Date: Wed, 29 Apr 2026 19:09:18 -0600
Message-ID: <20260430010918.1450541-1-trini@konsulko.com>
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

This platform is often close to the binary size limit and minor changes
lead to exceeding image size. Enable LTO for this platform.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@nabladev.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_vining_fpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index f698b86e59fa..a280869e2085 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_SOFTING_VINING_FPGA=y
 CONFIG_ENV_OFFSET_REDUND=0x110000
+CONFIG_LTO=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
-- 
2.43.0

