Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0003C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 06:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75B89829C3;
	Sat,  5 Apr 2025 08:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FHYd+B2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9429682A46; Sat,  5 Apr 2025 08:58:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E7582991
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 08:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-021.46.114.pool.telefonica.de
 [46.114.106.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D3C0C3F2BA; 
 Sat,  5 Apr 2025 06:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743836306;
 bh=6r1YHp4N+chF8G9kO6e2+SJ6FmBZo01AKlUIEuEKVas=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=FHYd+B2I1BOL5GxLZRW8/VbUVxmUFvqNPYb18S5AiGTpDMAKiV8c2U+riUAfssIGe
 rAhfpFKjVPXs1y+UfUi5wHVtJukcSueT7xgKtVpuxSlIQubFAMDwDJThTLqBgyxq1e
 zElTODkviwMa5LKAQoozQh8bDRQydI/xpOC3VRquqwwtQBcPsHekFuCyKkxD9xNFpH
 Tdl2xgT0vMNi8dZV4qCE4yAASHVtsfRvrhzFHurMeolIgFy8ObAwAqfQc6c2jcta9Y
 qU+CEulb95N/qfV95UcVlcju3m4Y+arnYpG6Ge8T1WHG5fvceQGMwigQ8mFyj/9epc
 l5AOCe5q2vEaQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Michael Brown <mcb30@ipxe.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
Date: Sat,  5 Apr 2025 08:58:12 +0200
Message-ID: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It has been reported that memory corruption can occurred because network
packages where received after EXIT_BOOT_SERVICES. See the thread
starting at [1].

We try to remove all drivers when EXIT_BOOT_SERVICES is called. But

* Some network drivers don't call their own stop method when removed.
* Some network drivers don't have a remove method.
* Some devices have CONFIG_DM_DEVICE_REMOVE=n.

Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.

[1]
https://lore.kernel.org/all/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com/

Cc: Michael Brown <mcb30@ipxe.org>
Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 5164cb15986..eaa6464fa39 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -15,6 +15,7 @@
 #include <irq_func.h>
 #include <log.h>
 #include <malloc.h>
+#include <net-common.h>
 #include <pe.h>
 #include <time.h>
 #include <u-boot/crc.h>
@@ -2235,6 +2236,8 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 		bootm_disable_interrupts();
 		if (IS_ENABLED(CONFIG_USB_DEVICE))
 			udc_disconnect();
+		if (IS_ENABLED(CONFIG_DM_ETH))
+			eth_halt();
 		board_quiesce_devices();
 		dm_remove_devices_active();
 	}
-- 
2.48.1

