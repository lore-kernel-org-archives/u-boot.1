Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9CECF34C0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72FC083F72;
	Wed, 19 Nov 2025 15:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ADmmzh7Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853DC8397D; Wed, 19 Nov 2025 15:50:42 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB8D83F6C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso1854377fac.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563835; x=1764168635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0Hbdr4z2StG/FZM6DBuujap00VawFAwDmNH6C8Q6eYU=;
 b=ADmmzh7YYD/e5oa57MLrIUoCNMdPtrLM02pqQb9FzndEVgfke4txtHsOosfem930b6
 hxXwa4JeNjF/Hs1kBVXEBll7ZtEodsXbXsp2WFwHIfuyMyiLycuZm7I05sliYEWGL/eg
 vxvOU6hYssdxQ0fQnOx/u7PLbV5UzCUEgWp3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563835; x=1764168635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Hbdr4z2StG/FZM6DBuujap00VawFAwDmNH6C8Q6eYU=;
 b=YxgNshxSYbjhd34BQZMLt4gpfM8ngdLbjhdphQoW6iQmdhYvfBYNs8kZAEw+B2yJ7f
 OovATusnLz236RJEaefK8zGwLzY00ngghjsAoV17pOkZXXQj/AexBSgskmV8xyf8CeNJ
 uuvxJwAJ8O06p22JHAJsE6iqYDmAVWdvwOk2WOGNpQrASB+QzAh1cfKr/KmNoZ4CosW1
 3yWV1WhOf3x2BN4AJS/kLC4ELf/pQcYBMRns7VXrZ/PVeINsv9xdJEzlNJ+lINspfCFt
 xjgr8DBHbC5hFiTHIVPvgjQ4MwX3FXukKDX7lvph3wKu0mXeQW8efgZlIn+2WVDjWZlp
 PvPw==
X-Gm-Message-State: AOJu0YwnObJmHLEZV0QTdDB0zSG/KbBhAax2dhQc2HK322eWbu7F08sW
 GJHGw3Rg2A6OVUd4CwdV2Oki1TfLciTP/JIm7LaYBXUqRbYS6UNQzm2PCiK1vdSvcvmqy/zAUQ2
 oiJouxptYoQ==
X-Gm-Gg: ASbGncvK5ExkwccpXPUgc5+WMnjuZL7aOJRTkUAyMQFvmy4TtYxAhJRpjJcuWcD7x2e
 K98SQ5Le2D0gppTr9oox5wzEvFksDhEBDA2/iJ5uhFsf7BV+bK3irYWrJNaIHBFbQ+OWG/KeaZ2
 RFJ04Wbn+ncgGvRUYzgbc0CqeW65lOfyT7YRofDj0lRNEwjdd0YZ1yoouSAKOTXDCEr9X6tEyec
 BvOGH055Gc+JHqFxEZ5CztnDlXJQ4phAJwIKmJT7eEIDK1AostBigwE2n/W/0YIJG2hyTpEL054
 5ovA1MuwcvvTHPeM1+0jPzs0Tpc2mVBQwbGu2MfSHwO4sS5/xQfmy1dQfr7cTtwwk3sJL/tbt2k
 nnwpg5RzEillfnS16vVRICIifmn2Kj/XX0Nr8JDDQCn+pAD/82VpAaVww+tkvMNGHzAZ3PIm77j
 Qj7j4cF+ZPvN4NDxXN0X542oa7WtxuIQZtatSuUM21WysI7DGXR/Qe
X-Google-Smtp-Source: AGHT+IG8w55R2dLJ80m/zYNgQYHMhQ10+4c7Z3dMvErI8WVYKW4NdYM0dn4gHxmgALQ5gTzaUA0lvg==
X-Received: by 2002:a05:6870:a253:b0:3d2:6aae:6332 with SMTP id
 586e51a60fabf-3e86917754fmr9928660fac.33.1763563835196; 
 Wed, 19 Nov 2025 06:50:35 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522fca39sm8212788fac.22.2025.11.19.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>,
 Parthiban Nallathambi <parthitce@gmail.com>
Subject: [PATCH] pcl063: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:33 -0600
Message-ID: <20251119145033.842175-1-trini@konsulko.com>
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

Cc: Martyn Welch <martyn.welch@collabora.com>
Cc: Parthiban Nallathambi <parthitce@gmail.com>
---
 include/configs/pcl063.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/pcl063.h b/include/configs/pcl063.h
index 0c96506b5fbe..e5f4dadcf464 100644
--- a/include/configs/pcl063.h
+++ b/include/configs/pcl063.h
@@ -44,7 +44,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
 	"fdt_addr_r=0x82000000\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"kernel_addr_r=0x81000000\0" \
 	"pxefile_addr_r=0x87100000\0" \
-- 
2.43.0

