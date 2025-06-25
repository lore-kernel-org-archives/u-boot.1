Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940CCC7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE61082E05;
	Wed, 25 Jun 2025 15:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HsbK6Jkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B666B82E40; Wed, 25 Jun 2025 15:21:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B6082CBC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so11691565e9.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857691; x=1751462491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBQHf69ZLJLZrVJvTLOhTYZYwmNTkk9oVoGrpZ1NPn4=;
 b=HsbK6Jkws0aIUJ5LDlUR5X1gG62T6ZLrC05MkOMAYc33fPZwy7QnsRNDS1guH6W7re
 zB1QQLtYXcbND+x9ewuIvpztbOVKhTW3mlHWpVpbpvfE+ScUW1CUZQXNROV1Ex1OkDGX
 wioflZ49ALkXe6REMhNYwddJ9VzTEzk5s/h9k8h3omgBGUjRKJvgoPa2W/i46ePb5qjB
 +1RsDGUqP++5YNc7GszM3GaDIIEYsm511NVTPXiYogRHuJRWX4QVVugNIxepz2Ye5veP
 txqhuVvH5LPDohFh9G0CBfB6FJKLcy2lYYYoCe58WPWGl6VXBfMIZT4XFiv7o8If99vx
 XRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857691; x=1751462491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBQHf69ZLJLZrVJvTLOhTYZYwmNTkk9oVoGrpZ1NPn4=;
 b=rBemIXVfWCS1ETMQiGlfrfX/VCn+pAbcF0i38UhQu2C3Nm+rkABWiJGabwWLtuKVbw
 k1Ng/fgiuvCL1VPYkAJ60GGy0q5JCo7WDRIkhcIGpRI62hTenWp4iihBcx2BLMe0YTGI
 tDDBHNuoUZr5494APaXaLAeG47cU6VZYCpnfp05ktxpcFWIT1NvH1rRx2h/84znobekz
 0YXQT83uXo/sKNwLsFp6KYmUKeryGeakzBNrc5RKZJJsR0vvz9540N3MhiAbzTXi5CAD
 SsbBc4FeHUOsEKnV46IdtP/CEWa+mKJO5T91pY4C1toaBzPPk4O5UjbDif8eo7d2rg8s
 SX4g==
X-Gm-Message-State: AOJu0YzCPAR5KyTWcuI6+Hb6hnOqp3XJjBJxJtL2MZ4IcnL9mF2wLKXm
 s/2uDToHPYCgWxM7fdrjHjA8XMQIjcEi09qiiNGdcpOZ2OaON+NHUNElpdpdAp/i26GXklyQPMb
 uM7afls8=
X-Gm-Gg: ASbGncsmz33amNsoVN8FS1HRXdYi+JUgKkrd5dIMZgmR3VPY70zKQVDkkeFPsxic9jX
 eWH9GhFvP03jIHWNXo7XJlyH1mkqeiukDONNxblkgyQaOEa1iu9m+f/HTnUTiX+HxKm/sDRB8C1
 +oxnEvB4hWPbCv1o3k/XPYKwL0Y/XSz6r1MFtRSSdwAGObnn9CP43vOJzSmygZfOHVTrwZ6Bn/w
 pJuWIk8cKYtlNg5cPCME5FwMsbz1k2/cztT2b1ahH5rkXnZ0Q5ApC5USQkTF9+4v7SF0GCFhRP4
 kJUkv8Ic2Kht7B3GfHfMUHS/iuVKrjndMPMk//hf564z1ySXdsCL4fK9y1N1nHIfL/25RJw=
X-Google-Smtp-Source: AGHT+IF1OvFEhhJystEO0Fi+tHNj3Shw4dOb7rGHPvFZuW7xA6ZcSj2eT9KbGfmEFdPnGWHQ6a6mYA==
X-Received: by 2002:a05:6000:2889:b0:3a4:f430:2547 with SMTP id
 ffacd0b85a97d-3a6ed5b8846mr2287099f8f.6.1750857690551; 
 Wed, 25 Jun 2025 06:21:30 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/13] lwip: split cmd/net-lwip.c into one file per command
Date: Wed, 25 Jun 2025 15:19:12 +0200
Message-ID: <20250625132108.3292932-5-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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
---

(no changes since v3)

Changes in v3:
- Patch moved after "lwip: move net/lwip/ping.c to cmd/lwip"
and "lwip: move net/lwip/dns.c to cmd/lwip".

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
index 9c5bfc91659..34fa73d64fc 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) += nand.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_NET) += net.o net-common.o
 else ifdef CONFIG_NET_LWIP
-obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
+obj-$(CONFIG_CMD_NET) += net-common.o
 obj-y += lwip/
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
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

