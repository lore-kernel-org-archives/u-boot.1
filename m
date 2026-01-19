Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08DCD2ECEB
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 21:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307938397D;
	Mon, 19 Jan 2026 22:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o13TwKue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC1F5839D5; Mon, 19 Jan 2026 22:08:38 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 389918389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 22:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so8106600a12.1
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768856916; x=1769461716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=02BsdYD7htZNopQY5zhy5ETds7vPskkD65knyz7nEY8=;
 b=o13TwKuexyg+er+DRmu8FBGEdO/52X97YTtMN8EyknEsLASnFEWi5qNLA6AD3DAleV
 9Ni438JEOndhy7xDMrJNu4YDs38b3qMQmzG3s04DVdLrkfHOYMDzEMQZrxfKA5KKRs1t
 4tSiBthVEioI/LwMgQyNZ9nMlXOCl3mBZ/GlOicU1UpTD7CqsKQ+rKKBQfs2u2E9C5xW
 9ehYCeT/Ehpg5IbdHdRZXqOUnimbhurxu41nqPfSoGa4YFSAm/bb5c6VmfNzP8zW/GOp
 PK4CIveTr8hfhkQD4YYjHPJqSw/2ZVpy8m8j+/k3auRbT4Ji7tR3F3neYAjyFBaoy4//
 DQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768856916; x=1769461716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=02BsdYD7htZNopQY5zhy5ETds7vPskkD65knyz7nEY8=;
 b=OK9m9fTR80ysmk+kXb86qUsdQLruCAjuYcWbypDwmIi/VKNzmPjynvkAH8fPpevO/F
 7B+a2blVxyQlRGmp23C4lnAgsYb+H4OrNl8NL9c1zXmWF/zBUuVn6PCFD1dgeqlgZcPH
 5kSq8QMu8WS3+ob/PBo9CJzkoiMdwJflvgbwJ763oUL2biGKJfa9R9p9aqW8YpOhi4Cf
 KP6x8ec/wg7BTNTz4jT6S0fWNAXn4G/TJIZc5KUDI/aApR+IahwZLv+K+PG/8Zw/xoD1
 0Koo2lngoWVA2guuwnY2650vXswsOoc3dLbcMsl7ci4vrkJdhauP/fzxh2JM5gau1G7p
 m9bg==
X-Gm-Message-State: AOJu0Yxw4E96PE8FrtVLPPZEhs+Dvb37BgP5NgFV7EqbDrKumVPjhu0W
 BMca9NCuthxTnWAQloRO66HIP4Pohzb59ig24WH9avt+sYZIVqq9VZeOlNRxjYrMCqI=
X-Gm-Gg: AZuq6aJe8psg+vhlOrOXsGRjKai6NvPEgDHZLMrkFogMZNhNDv2t2gVjVRuqT0Yx1aN
 2TBMex8lPNFHDDD9ZAgNIN4J0ZkHDIedaXdPmbzYSIXFXmKI1oW8S5beH2RHiNAtTyzRpHAUEud
 MuKNez2njDf7USAZi+FQG9qYDWaOxdPTaY9XRWCgS92FlqjH1YeDUoIRYNXumgqtkSLgfwSBqb5
 3Nm7YBevL9sFrvY+Mx6M3c1eFH2aZYX0lsV6yN72t4z1QIGMHTvCwr8h28O4xR/NwAhNuJbPecu
 xgDBMBO9GU90mPPOoqwZRuVAmjMDZC1gfnVq1qL/3qVyzYcmP/uAzaPBfIAyuvluzXDOB+YdRCM
 56FPqMy32F9+fF62i7v8KDPiVGjOmRZy76zpXR3WuSCH8Doj1340dum5fyIIxyo0Uvtf5Y3fbjM
 Fz1aDJOwCfesGf44iMKCDXCNYU4L8AIpTv8LARkCKek3Wl2ZksiZRWH4je3jo=
X-Received: by 2002:a17:907:2d9e:b0:b87:908:9aca with SMTP id
 a640c23a62f3a-b87968a9870mr1019420766b.9.1768856915661; 
 Mon, 19 Jan 2026 13:08:35 -0800 (PST)
Received: from toyger.localdomain (p4fc3dfd7.dip0.t-ipconnect.de.
 [79.195.223.215]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795a350dbsm1208923266b.69.2026.01.19.13.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 13:08:34 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.denx.de
Subject: [PATCH] efi: stop hw watchdog during EBS
Date: Mon, 19 Jan 2026 22:08:25 +0100
Message-ID: <20260119210827.28400-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.52.0
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

Hardware watchdogs don't currently get stopped as part of
ExitBootServices, this can result in resets during boot if the OS
doesn't have a driver for the watchdog, or if the driver isn't loaded
in time.

As with the EFI watchdog, stop any hardware watchdogs as well.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/efi_loader/efi_boottime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ddc935d22409..2df6d2c7954a 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -21,8 +21,9 @@
 #include <time.h>
 #include <u-boot/crc.h>
 #include <usb.h>
 #include <watchdog.h>
+#include <wdt.h>
 #include <asm/global_data.h>
 #include <linux/libfdt_env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -2263,8 +2264,9 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 	efi_update_table_header_crc32(&systab.hdr);
 
 	/* Give the payload some time to boot */
 	efi_set_watchdog(0);
+	wdt_stop_all();
 	schedule();
 out:
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (ret != EFI_SUCCESS)
-- 
2.52.0

