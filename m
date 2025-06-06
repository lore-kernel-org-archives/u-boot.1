Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA2C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D148B82AAF;
	Fri,  6 Jun 2025 08:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gXWRUYpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C517882AAF; Fri,  6 Jun 2025 08:42:28 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73EF828A2
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so1028965f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192146; x=1749796946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3GiFy3MOKqfvDVM3FS6mZwtRpoFy5beRX9E8hZvdmI=;
 b=gXWRUYpCAEteDUO/PVqeyNICIpvCZMUfG+rQZZl/71ImoN5trzRqzSFCx+1YTvpNav
 J1cq9a1FYnZ8v0G2rLSP5T99qnVZSUJ7uAGjdDVG5CJVuPjtjh+7CPrTA+Ucch68sMmV
 yJoyP06/fxjBZWRe2939C5O9MiINWoZoTmU7yXhse/fEpjonYupxzT2txH6y7xvPP25K
 Xy8xRYHum3l5fgFq7iqu+EDmWkfbI3rJezlCdI7DjyyG2onu16czEQtNDHcNb6qLv4wX
 JX+lLzD8EFDqGeSadpPNpB2le3JyW/gxv6OMvVsP9J/2d8Va+C20CRYDP7ep+QynvYYf
 v1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192146; x=1749796946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3GiFy3MOKqfvDVM3FS6mZwtRpoFy5beRX9E8hZvdmI=;
 b=qd+wWWih04x5hMnJluLtc301FqUlNg1tnP4GrulsSHhi1drHg2Gjiu1isO/chSUKfM
 hKLvl8iweox5JJiVWYO3lxee9CzLKKU1SiXDDqCVtM9JtfwUsNIRI5xzSLb8AaRXWie/
 4ZVYpQ5XsDyi62Ns6+sxWYjNvZmO1OF7i0sqUuXUtjaXf/QaGkQMjy18B+3KA9ZVc9LZ
 1Se43RmPb8dRyRhsHGF5+lZ910h5NSzTdExubfe8UYZae0STAaSL7GpBGPwhwheJxbO7
 8z1ywEm9GGjH5qSryI98D1snHR0EQlsmv80t+Up9irL9YBRadi9/BtH6RqAmpGuRY+sM
 VKcw==
X-Gm-Message-State: AOJu0Yx/oR9+8B6rhnp1VXMOekr47mZGeyQZyLVEYmTXPIvNfHo9UD5g
 8L1vEFrOvxceYqgumMxPJf+UxXJvPwZq4yaznMPeUW/CtQECz+8Zj94jvDTPSJhs1krhTWsfwmi
 5ZA/1
X-Gm-Gg: ASbGnctOYi/YDHJFDyfdtp8seyC305RbVbRlfGq69LvCaw+VqRTNazWR2T5/H0VJc7x
 Y2rBaC7Np0VJbCLdrr+Q5Nj9mYbPBuYF/+mfNIUiXvcKGAUKkZlS4G2o2E6VHexGteq0sYVzs8I
 tMuv8yo3rCiYmPSSHAfPpj/b0T530VZZ5jyULjOiY7cVO5pz0aD73b4OuWTDAW5mFlgGzq/Qdwb
 ojqwm6RQ8Tv7zIQWlakQecT+NWHrm2r0buBD66hPVk098ttJpJ87go8emw3gvo/Ax2hrY7gsqXH
 onAQP6FShB8vXgBjVOCCaw5iKfbOriPQoBmVecqhxABID+Yv79O3dNeYKBNkaM1e5dRWgCw=
X-Google-Smtp-Source: AGHT+IGkYGCsexaRkO3NgukFpl+U4Hv1GeFFP1Pqx8cpaULShQrXA+oEov6xMzdPCCSTdQ/LMrQ37Q==
X-Received: by 2002:a05:6000:26cb:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3a5317868b5mr1629249f8f.16.1749192145610; 
 Thu, 05 Jun 2025 23:42:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:25 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <mwalle@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/13] lwip: split cmd/net-lwip.c into one file per command
Date: Fri,  6 Jun 2025 08:41:38 +0200
Message-ID: <20250606064211.3091237-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Changes in v2:
- New patch

 MAINTAINERS                     |  1 +
 cmd/Makefile                    |  2 +-
 cmd/lwip/Makefile               |  5 +++++
 cmd/lwip/dhcp.c                 |  9 +++++++++
 cmd/lwip/dns.c                  |  8 ++++++++
 cmd/lwip/ping.c                 |  8 ++++++++
 cmd/lwip/tftp.c                 |  9 +++++++++
 cmd/{net-lwip.c => lwip/wget.c} | 26 +-------------------------
 8 files changed, 42 insertions(+), 26 deletions(-)
 create mode 100644 cmd/lwip/Makefile
 create mode 100644 cmd/lwip/dhcp.c
 create mode 100644 cmd/lwip/dns.c
 create mode 100644 cmd/lwip/ping.c
 create mode 100644 cmd/lwip/tftp.c
 rename cmd/{net-lwip.c => lwip/wget.c} (51%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..e8f644fc75b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1409,6 +1409,7 @@ F:	net/
 NETWORK (LWIP)
 M:	Jerome Forissier <jerome.forissier@linaro.org>
 S:	Maintained
+F:	cmd/lwip/
 F:	cmd/net-lwip.c
 F:	configs/qemu_arm64_lwip_defconfig
 F:	drivers/net/sandbox-lwip.c
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8..2c6b13ffc5c 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -133,7 +133,7 @@ obj-$(CONFIG_CMD_NAND) += nand.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_NET) += net.o net-common.o
 else ifdef CONFIG_NET_LWIP
-obj-$(CONFIG_CMD_NET) += net-lwip.o net-common.o
+obj-$(CONFIG_CMD_NET) += lwip/ net-common.o
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
new file mode 100644
index 00000000000..4c28d2b28e5
--- /dev/null
+++ b/cmd/lwip/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_DNS) += dns.o
+obj-$(CONFIG_CMD_PING) += ping.o
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
new file mode 100644
index 00000000000..31642b864af
--- /dev/null
+++ b/cmd/lwip/dns.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024-2025 Linaro Ltd. */
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(dns, 3, 1, do_dns, "lookup the IP of a hostname",
+	   "hostname [envvar]");
diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
new file mode 100644
index 00000000000..af5c022f55f
--- /dev/null
+++ b/cmd/lwip/ping.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024-2025 Linaro Ltd. */
+
+#include <command.h>
+#include <net.h>
+
+U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
+	   "pingAddress");
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

