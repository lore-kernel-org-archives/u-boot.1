Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADAC71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AB182B20;
	Tue, 17 Jun 2025 12:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oz0J6nmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512D382CF4; Tue, 17 Jun 2025 12:07:49 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3758882CCF
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so43980555e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154866; x=1750759666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBus3lREdfBfRPlDnGauGCE503yX7PPRKy1v2APSgo8=;
 b=oz0J6nmxasDC5LmfjqqgXd3WaRKUWM/K7UmavB1mgKSdaR1zpxj6Yc4ND/d6oxWoWm
 EKqo+qsu+GaG3bTce4KPjtSFaPT4uGM37ruhxRdf4/MIgMaTXElfuY0AaFiRLJkTAygW
 pTgGWXTXrTbHRglAnPEPnTDUeJoZmVBHkNflhqfrRJHIfA8grLSGeayVZM6DWn0JYGvu
 HgHzcqDKFra/ByghyEyta4tmZXz8B4fEpiffr/R6SVnySilUc39UTcV1IC2s9bVNlfxk
 +vchBQrQVgioEFWT9lYKZPzwjhQTDGx2Ugv1sJZTSDkWeupJylbyp4+WskPDs+p7rm0g
 vNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154866; x=1750759666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBus3lREdfBfRPlDnGauGCE503yX7PPRKy1v2APSgo8=;
 b=isuuk/Qe3zRnF0Qg0+oXRt2kUIOQvDwKv4B7QwW3rqv8ZtaSHY/CHDMqkKlqn49O3u
 AK+ZOijIk6HyCRsVKlT10gkAeRGOvLQxtbulyrwwqHFHbSaETlXWiJ7T+oQfMbXGrpWh
 gvBex9In1yILOi8sF4fVv2zwEK+ludx/0THiFlFSza8gMuiJgNXDaG3g8kADjJigwwAC
 ljL9aXJ2HMneVfaMQ3wbBGoHfyG/HJ8UskrnDVRkoReWdgO/LnFlFFC8yeaJRKqk4wtR
 fB+/M/Z6HDGZPtUCebgmaJOoXlT8qDEivXe/UkxU43YL0kiBXCLSQbX1s9IAQpAiYs/v
 cigA==
X-Gm-Message-State: AOJu0Yz00h292H+aFO1yWD6VXM6hitrOK6+ynK7z/kuG7E3Vbv3N7jb1
 zsyWVsR7Zmeh1mIBEE0PUUuEZTjP33gxVZ3E8wBwwRkv7u4aY0LeXeVhDRCAXjIjZmSMcIN6dNB
 YEK3N
X-Gm-Gg: ASbGnctlGS85cLWhKbSEKaUBLj7j7U88VmO5Li6KV1eAiA6CCGdYoCkpkK9dJsGfC0z
 99vPCmgrnia91Y2mGTzi8iesd1rma+MSxH0xqx01Z/gRD0O78u3kEeh02YphSW1zbq9Y8t21PYg
 Td7orH3p1xaF5/NAOurlGcY/px7GFn+oNAADFQzdD+gpQHb6gesUEDOulwusryybwN52TgrGLlh
 aWEHJnZIudG0Hsmssw+ZZXdNMqnsS+5C5B6Avs3N/2mB14PKThN5yg+mAl9/Fk3RE4TXqXG4Vyr
 ErUOYNJaGFdlA2fv91y7Pnad1hAhN4ejZfPW/lHDdZozQAqkNZrtzadHRqnZ7szW8iyx81M=
X-Google-Smtp-Source: AGHT+IGrXzwNOUneOZTMQAd8qVNpxrrqMlvyaD8sDATmEb4tej7LjmXPfjn7tz2mdA1pg2pS0npJSA==
X-Received: by 2002:a05:6000:2504:b0:3a4:f7ae:77c9 with SMTP id
 ffacd0b85a97d-3a5723840d3mr10139322f8f.5.1750154866223; 
 Tue, 17 Jun 2025 03:07:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/13] lwip: split cmd/net-lwip.c into one file per command
Date: Tue, 17 Jun 2025 12:03:54 +0200
Message-ID: <20250617100720.2544758-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

Move each command in cmd/net-lwip.c into its own file
(cmd/lwip/${cmd}.c).

Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
- Patch moved after "lwip: move net/lwip/ping.c to cmd/lwip"
and "lwip: move net/lwip/dns.c to cmd/lwip".
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/Makefile                    |  2 +-
 cmd/lwip/Makefile               |  3 +++
 cmd/lwip/dhcp.c                 |  9 +++++++++
 cmd/lwip/dns.c                  |  3 +++
 cmd/lwip/ping.c                 |  3 +++
 cmd/lwip/tftp.c                 |  9 +++++++++
 cmd/{net-lwip.c => lwip/wget.c} | 26 +-------------------------
 7 files changed, 29 insertions(+), 26 deletions(-)
 create mode 100644 cmd/lwip/dhcp.c
 create mode 100644 cmd/lwip/tftp.c
 rename cmd/{net-lwip.c => lwip/wget.c} (51%)

diff --git a/cmd/Makefile b/cmd/Makefile
index 102422470c2..d026ace6573 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) += nand.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_NET) += net.o net-common.o
 else ifdef CONFIG_NET_LWIP
-obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o lwip/
+obj-$(CONFIG_CMD_NET) += net-common.o lwip/
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
index da79b64b5c2..4c28d2b28e5 100644
--- a/cmd/lwip/Makefile
+++ b/cmd/lwip/Makefile
@@ -1,2 +1,5 @@
+obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
+obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_WGET) += wget.o
diff --git a/cmd/lwip/dhcp.c b/cmd/lwip/dhcp.c
new file mode 100644
index 00000000000..3894d71f654
--- /dev/null
+++ b/cmd/lwip/dhcp.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024-2025 Linaro Ltd. */
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(dhcp, 3, 1, do_dhcp,
+	   "boot image via network using DHCP/TFTP protocol",
+	   "[loadAddress] [[hostIPaddr:]bootfilename]");
diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 19172ac959a..13da52b59b9 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -8,6 +8,9 @@
 #include <net.h>
 #include <time.h>
 
+U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
+	   "hostname [envvar]");
+
 #define DNS_RESEND_MS 1000
 #define DNS_TIMEOUT_MS 10000
 
diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index d8042ceecf9..21a30228642 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -13,6 +13,9 @@
 #include <net.h>
 #include <time.h>
 
+U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
+	   "pingAddress");
+
 #define PING_DELAY_MS 1000
 #define PING_COUNT 5
 /* Ping identifier - must fit on a u16_t */
diff --git a/cmd/lwip/tftp.c b/cmd/lwip/tftp.c
new file mode 100644
index 00000000000..6bb7a3733a2
--- /dev/null
+++ b/cmd/lwip/tftp.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024-2025 Linaro Ltd. */
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
+	   "boot image via network using TFTP protocol",
+	   "[loadAddress] [[hostIPaddr:]bootfilename]");
diff --git a/cmd/net-lwip.c b/cmd/lwip/wget.c
similarity index 51%
rename from cmd/net-lwip.c
rename to cmd/lwip/wget.c
index cecf8d02555..3f5b9952c93 100644
--- a/cmd/net-lwip.c
+++ b/cmd/lwip/wget.c
@@ -1,32 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* Copyright (C) 2024 Linaro Ltd. */
+/* Copyright (C) 2024-2025 Linaro Ltd. */
 
 #include <command.h>
 #include <net.h>
 
-#if defined(CONFIG_CMD_DHCP)
-U_BOOT_CMD(dhcp, 3, 1, do_dhcp,
-	   "boot image via network using DHCP/TFTP protocol",
-	   "[loadAddress] [[hostIPaddr:]bootfilename]");
-#endif
-
-#if defined(CONFIG_CMD_PING)
-U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
-	   "pingAddress");
-#endif
-
-#if defined(CONFIG_CMD_TFTPBOOT)
-U_BOOT_CMD(tftpboot, 3, 0, do_tftpb,
-	   "boot image via network using TFTP protocol",
-	   "[loadAddress] [[hostIPaddr:]bootfilename]");
-#endif
-
-#if defined(CONFIG_CMD_DNS)
-U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
-	   "hostname [envvar]");
-#endif
-
-#if defined(CONFIG_CMD_WGET)
 U_BOOT_CMD(wget, 4, 1, do_wget,
 	   "boot image via network using HTTP/HTTPS protocol"
 #if defined(CONFIG_WGET_CACERT)
@@ -47,4 +24,3 @@ U_BOOT_CMD(wget, 4, 1, do_wget,
 #endif
 #endif
 );
-#endif
-- 
2.43.0

