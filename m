Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F3C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2093080F7D;
	Sat, 15 Feb 2025 04:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Afi0fC6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEDE80F7B; Sat, 15 Feb 2025 04:23:51 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D9C80F95
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-855183fdcafso101471239f.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589826; x=1740194626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=Afi0fC6gD2UGHaOFAwx7O5YtUqscNDb4d4fdHN1sr4ZCuhU7LKYtWGxkgWMCOGR+NB
 ywSGn/C+MpRXSXz4yq7MpGoniimaPywq8sXS9tpKYAhPYcIC2LI5ks7Y/KiPEkPZPg0F
 G+W/Eq+VisLLSyECx6oMTzhvEQCcKC1ORzfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589826; x=1740194626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=XcU1khXvhC8vRsD01zJumio8xDenGZSJsfPsSMY5byGEZm21ndiKbbDJHwUtW2pVHp
 ILvRZuWDR7UX3YQaQeFfNS2P9sBN7WbW7dfbwIYPYhWCWH5bXE6EGcMmoirxJAi4+Nfp
 d3isGWJP+46fxR4Xmp08f3oNIKiebgfgjWrYvdXBDTImKAAmDda8QqsEGK/1g/e1+OJ6
 FCwYhWQ8ZAi8qJFvSdK1BPkIWwJGexYBFhTyf7n1F24mUUplHtzktN7XeUcLJdD/GHCk
 FjeC2DmQJ5UMeK4m9Or9e4Rm6TPasKBl+Enlq6ZL5kA0oBBETWiO906XgKGvDUk7b2Pu
 CUag==
X-Gm-Message-State: AOJu0YzUIJGCmsPa9IUduSS4PMESqFeiKfGxHHfvh8s+MSsWt609rrFp
 hr1sx4G7iGqkeEP5yWJInTFh7xD7vncCh72sDmFAMWm86UssdLxOJ/MBARxIUsGfCjixzIHAWBk
 =
X-Gm-Gg: ASbGncsm7grY218TiUFR8J0CfG4aVc4xkX2wcuFMkerNKCFN70Wo9q3bBeBmrNXQvmo
 2t8iBlD/IEbJV9cLrZh1kpI4XNb1gFBC99qPV/1RT1fCatnwLnw548j3+cZOPGX9FuEEz+0PBIh
 S64PN7MNdpIrRkadgnDzJqWafa9xsPwAJXj8TixiDg5XNMjLWy2q705di4TFKpuqdA7qwFv0TV3
 P7ouYHRQDAIoeOqZqgwJXb1mmJMriChuGMwyQtukXgR111FUWu80/Nn0NJPFEoKcCvavrNVvNSV
 dYxjtC3TLDbggQchp9dzgvuxno8v7bY8vDBfV5LzMMF1mthImbnm
X-Google-Smtp-Source: AGHT+IF6x6d9+G/3KgPBN1gXNIzCyBsvf2fp2hH0oROYOS5pPiiozIaKkD3Vpsvz+b/QGBE35oInwA==
X-Received: by 2002:a5e:980d:0:b0:83a:943d:a280 with SMTP id
 ca18e2360f4ac-855651b8417mr635355639f.1.1739589826584; 
 Fri, 14 Feb 2025 19:23:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 14/29] efi: arm: Don't do the EL2 switch when running under
 EFI
Date: Fri, 14 Feb 2025 20:22:35 -0700
Message-ID: <20250215032254.4121030-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

The previous bootloader has likely done this already, so avoid trying to
do it again. This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/bootm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400..688c2f3f29b 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -16,6 +16,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <dm/root.h>
@@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
 #ifdef CONFIG_ARM64
 static void do_nonsec_virt_switch(void)
 {
-	smp_kick_all_cpus();
-	dcache_disable();	/* flush cache before swtiching to EL2 */
+	if (ll_boot_init()) {
+		smp_kick_all_cpus();
+		dcache_disable();	/* flush cache before swtiching to EL2 */
+	}
 }
 #endif
 
-- 
2.43.0

