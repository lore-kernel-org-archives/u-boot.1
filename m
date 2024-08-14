Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB9C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4BC889AA;
	Wed, 14 Aug 2024 14:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N1ergbRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3D6889B8; Wed, 14 Aug 2024 14:33:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0499A88719
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54E123F2F0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723638831;
 bh=DfAl1Dig20MePwKQnYdH0ygEk+r0yaFl0NnzNpoUwYE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=N1ergbRl2MUGl9Aod0tUiHte5rVkSuZ9c89gMqNsIFn/IAUfNqMOgCquV2j6UkvDC
 D+eEM07wIJ0NpFYXt1Hwlw+YQUsLffzjsAgjgPexz1o64FWvkZcVJiysETURYsyuG2
 V6ZGjFk+Bu/mT6DE4ajdCGepCaKtOglKvZU3w8sxs4B6RarlRgVitdQEEmR/WX7os0
 Ej5dj9QNuN+NEoiv3/02XrZ4INbSh0AdyTUWrOCTNMOJKv36foW4oSaaKC9rKrmBZJ
 HDUfkf/DTKFqlzvuYwr7hZtaFUaNjc3TzX6yFK6ziT+Ter5lnKwrxhtdk7nctrbNF9
 kNnprCBcxH4Gg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280a434147so48114395e9.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723638831; x=1724243631;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfAl1Dig20MePwKQnYdH0ygEk+r0yaFl0NnzNpoUwYE=;
 b=f9LcPpwKH6Rjf7M2kYgrZuGD/gL67RXPPvQq3p0v8mOG2J0BlO+01+2lV6o+tZHRPj
 Dli85MVvtq3JlXlmKbqBuF4hApYf/AitrH3flS5yOun2Aejfj1qtfUo7B6FEGqYLUVih
 0rdIzIgtuGJ/+QR8NwhZcRyhOtQruE7k5u5+vTvjrW2J8k4dG9lENfg90hUSsqQkRYlY
 4aRejSeDFqvD7lOc3vGN3bkVwwRsOAsIOAyunpuL5gkzvUPGaBBEca3mSSH68VwEQsMo
 A3fMzPReraLSDpqqS3OKxjTD62X2FZPImww3n6iF/8UGgEaCHsFFIAfyGrww8XLjHe1X
 oJrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDhUhujm5orRKMNGjz0jah6pdYHGjMYv0lFQvUyKUumirlHvbhcgbTQ1aXtqqS9IkdSuq67LMRTqbVEb9rgg8LEhJZvQ==
X-Gm-Message-State: AOJu0YwX6bR3846T9jvfMrptOrRH0QIsqiICeP752qyLX40aiOtQ0gUf
 BnUrr7ObsKkk/pNvBlYaWnzYwzxc47s/Ovg/ARCwXUQy3ZOo1PJZFx66k0CxPh3Rk9U7jNlSO2f
 mf/p7rgsiHuixwdzvppIipdr1FZi/VVno77Uh738lFYUoze48FTMQWsVk2sL445fSH6M=
X-Received: by 2002:a05:600c:190e:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-429dd26c6femr20626135e9.32.1723638830788; 
 Wed, 14 Aug 2024 05:33:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW48PfRx272TWkXW2IKT2tPyK1co9TJTiVkLw3bUXkG8kUsk8FsrouTIXRYnnkokIXH8b38Q==
X-Received: by 2002:a05:600c:190e:b0:428:16a0:1c3f with SMTP id
 5b1f17b1804b1-429dd26c6femr20625885e9.32.1723638830320; 
 Wed, 14 Aug 2024 05:33:50 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded720fbsm18814305e9.35.2024.08.14.05.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 05:33:49 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] tools/mkeficapsule: correct printf codes
Date: Wed, 14 Aug 2024 14:33:44 +0200
Message-ID: <20240814123344.196991-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

uint64_t is defined as unsigned long long on 32-bit ARM.
Use PRIX64 for printing uint64_t.

This avoid a build failure on 32-bit systems:

    tools/mkeficapsule.c: In function 'dump_capsule_auth_header':
    tools/mkeficapsule.c:694:66: warning: format '%lX' expects argument of
    type 'long unsigned int', but argument 2 has type 'uint64_t'
    {aka 'long long unsigned int'} [-Wformat=]
    694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
        |                                                      ~~~~^
        |                                                          |
        |                                                          long unsigned int
        |                                                      %08llX

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use PRIX64 to print uint64_t
---
 tools/mkeficapsule.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index f28008a0829..1b53151d41a 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -5,6 +5,7 @@
  */
 
 #include <getopt.h>
+#include <inttypes.h>
 #include <pe.h>
 #include <stdbool.h>
 #include <stdint.h>
@@ -691,7 +692,7 @@ static uint32_t dump_fmp_payload_header(
 static void dump_capsule_auth_header(
 	struct efi_firmware_image_authentication *capsule_auth_hdr)
 {
-	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
+	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08" PRIX64 "\n",
 	       capsule_auth_hdr->monotonic_count);
 	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
 	       capsule_auth_hdr->auth_info.hdr.dwLength);
@@ -724,9 +725,9 @@ static void dump_fmp_capsule_image_header(
 	       image_hdr->update_image_size);
 	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
 	       image_hdr->update_vendor_code_size);
-	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08" PRIX64 "\n",
 	       image_hdr->update_hardware_instance);
-	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
+	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08" PRIX64 "\n",
 	       image_hdr->image_capsule_support);
 
 	printf("--------\n");
-- 
2.45.2

