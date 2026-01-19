Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28396D2ECEB
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 21:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ED48397D;
	Mon, 19 Jan 2026 22:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LYcucNja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3101839E2; Mon, 19 Jan 2026 22:10:16 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC2F8389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 22:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b87f3c684a1so120395766b.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768857014; x=1769461814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wa/p8Rg9fuOLjnpX/zx0zOp4+HXYLcWFRKDzRPXNA4=;
 b=LYcucNjae4UvzSr93glLqOfDdhCmh1uU6JPPyAZopjzxszSibqMhhSBJAeU5h41u8q
 B/FMl3hPCml+ON6YAhcWnRFxsg/7K9cEyy4Rr8mozyQCUgmDfA3aSSu6m5uU+AM8+JpN
 cod8D6ezHRyz7RF/Cp7E3F8q56Zlynj70zouMAr4cWljj6DuUGz7lFU3dOrrqe8CfqGN
 yOqmjZNIJb90pv7vx1zYqanJyOS4uaep7dks5SnTDhGeii6KiWjrjzgxXYOpOn3rZdyo
 ueGH9I29AcmkE2eSBj7UIVztjOn8sEiSq8KHtO90KRqZNVodmTjjWlP47LCfX3Vm0sFX
 GK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768857014; x=1769461814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wa/p8Rg9fuOLjnpX/zx0zOp4+HXYLcWFRKDzRPXNA4=;
 b=s6LXqHc2oEd5o5nrndkP1pS55f0wQEyTxE3mshaac52C5kXy3jJJ6T4p0nziNTZvA+
 xz9oGU/Ts+jZGsSBITmZ8oqwmKiskhA2jqPkuwMQdn0S4YLmROm7ZlChwgi1XD7HUe9S
 fTfQfycJ2X7NYRm5ifGdv0RJUkFhPoWv9+S/v/U/ROfSW1jC4A+6h7zhhVeLwbeVa9aE
 YF0Ae0WJ+JkMEhIbxM74vmum32yMoBbaK3oTG+DQCY32lDT51IOfqKF1+eTV8Zfi1xYT
 ZuLvSobfTIbRtcSxW1fKklNJ1FEFSxfp368Ab7A+jg+BjQJBcbT7TDVCwTX3fqXLS2hS
 33Dg==
X-Gm-Message-State: AOJu0YwovJuCnYTJzOM2xi4nxJhtyQNxzFTO+DcKEDL4UrJ5XXQ2+77A
 KKwIZcsNeRNwGmxEx9UlDa8OdkGfj8s+/PczxKFYkl0Hve85M/iwpShSNTc2vLCzGZk=
X-Gm-Gg: AZuq6aLCMrD57tSSVRCWw64BqgJNPwRiDBP5Kodm0XPmh7u3iX5bEIfEXy4B3RZnY1v
 +i67Is+N+PtEEN374Zdd8qnSYclyJnATtHyXFLrq3Ef1TdY1HDRxAU4BDcbaQkjf++Au5V4j1pQ
 tcAhvGHYeyjKTCFxkLJKYg2X+0wTgNGC9Nx7qdhsNZJ2pCbpV54/bQ0jitcs3KMHcPXlngDs2Co
 V3mxZKn8JhH1NIG1ReQd2aZ56bBcVuFbeThwZ8tPeKJiE5Fu775RgonkUIbgi+qi71opUnxBddF
 cR1vYWEOygR1D5LzpseW0Ub+KrM7sfwJoEhoLsjAFLCAZ7k6/DsE4DimFyP2mbIjAwSsYltqzuB
 Z2eEVwBCq41xTS3baGP4E1dn3N+XsSkj+1/1YkDScfAw9qTtYBvs3hH7OXs+fgpGaMQJTL6zJt/
 mRJY/8S55ngBCAn9YchYVEYZiObkUjQy5p5IxcnmaQQ1CRcerUIfIZvR6W4niso2FCOnMPAQ==
X-Received: by 2002:a17:907:728c:b0:b86:f558:ecad with SMTP id
 a640c23a62f3a-b8792d6826bmr966261466b.7.1768857014470; 
 Mon, 19 Jan 2026 13:10:14 -0800 (PST)
Received: from toyger.localdomain (p4fc3dfd7.dip0.t-ipconnect.de.
 [79.195.223.215]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fbb38sm1181513666b.52.2026.01.19.13.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 13:10:13 -0800 (PST)
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
Subject: [PATCH v2] efi: stop hw watchdog during EBS
Date: Mon, 19 Jan 2026 22:09:25 +0100
Message-ID: <20260119210925.29185-3-casey.connolly@linaro.org>
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
Changes in v2:
* Fix compilation when CONFIG_WATCHDOG is disabled.

---
 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ddc935d22409..c34616db578a 100644
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
@@ -2263,8 +2264,10 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 	efi_update_table_header_crc32(&systab.hdr);
 
 	/* Give the payload some time to boot */
 	efi_set_watchdog(0);
+	if (CONFIG_IS_ENABLED(WDT))
+		wdt_stop_all();
 	schedule();
 out:
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (ret != EFI_SUCCESS)
-- 
2.52.0

