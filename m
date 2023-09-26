Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95A9E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8F586DAD;
	Tue, 26 Sep 2023 11:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SPzP7NTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C1F86DC9; Tue, 26 Sep 2023 11:43:59 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E9B86AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-503f39d3236so13532713e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721436; x=1696326236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC1rzNwjkmeiEROge7PliJ2TWgUzdEBLyUtsof2ZFvo=;
 b=SPzP7NThldg2+kdctObNmJMpNAz2eUx3TJBgyBFmFWJPgyGP5QDcvz/HAYVyQ+zmMt
 pKQdgOQ30RXORZNcY6TQcCPvWlzConxrmkgSGtExSDa9Y0VKCzvbuklHGEu/jeueKzEb
 ssDXjoYKxwXSDW8vHj51t9RoqmxNLNmgS9M1Oa5HMqXnNCOzmeSQu3lPxBPQMbwhMUrv
 yMrPs7f+DpFKOhdqQqHkGIWTwKr9cJtwbUe8Xt7GsZ2Y4R/sRIgeLhcd40TqRBSo5Apj
 rnfeZSAkTfc/R2g3Mhqs2czpRG612M6utg8EIlQmYVh0Rj3FS9T1kFAdp5rSoWHj1/wm
 Vi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721436; x=1696326236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC1rzNwjkmeiEROge7PliJ2TWgUzdEBLyUtsof2ZFvo=;
 b=hBRKP6JdE/INznrGZM9jQYZ+aXOJU+ymdOVco4/b0vziF/P9bfU7dmqYmSrD4TaksZ
 j6NCU7VRbyqkmxA/5RZKr6MTJ0VDAXIp6iWvhjI+ILBqaSsV8R6s8M2a0iKcXOoF99az
 41Zj2KT3RHcPR7BTBOFXm8ug/FtLt6GKbDQPHSq7g4j4by6+6KP/5PxwOId1S7d+d+05
 /VbisPnoRaLrCesPdwbXkRhvuyO6wGF+qrkMelG4diPkDroiijFVHteBX+refgnCQC+j
 OcdCBxOM/OKWKnorgQSkVqbLKluShUEF4VSWgKjbILJkujdin0kYajtj0NYIaRYfv1Z8
 f/hg==
X-Gm-Message-State: AOJu0YxvmhWr/1QdpxEAV2dIGT8RCIX7EWu1Kw6s9TC1bd/hL4haWpb4
 ZroRN1pRQdl8jc/MF9ytofexbZD47T/XMbVbnCsUQg==
X-Google-Smtp-Source: AGHT+IHUjyP/Bhlv3sWmkgkkNOhhuWN3FACO7bqCazN1VX1KZVAu/VYpGLnZGndVUpi3MJvzDqE/pA==
X-Received: by 2002:a19:5058:0:b0:503:9eb:47f0 with SMTP id
 z24-20020a195058000000b0050309eb47f0mr6857092lfj.59.1695721436456; 
 Tue, 26 Sep 2023 02:43:56 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:56 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 07/15] net/lwip: implement tftp cmd
Date: Tue, 26 Sep 2023 15:41:16 +0600
Message-Id: <20230926094124.7024-8-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

U-Boot recently got support for an alternative network stack using LWIP.
Replace tftp command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  13 ++++
 net/lwip/Makefile              |   1 +
 net/lwip/apps/tftp/Makefile    |   7 ++
 net/lwip/apps/tftp/lwip-tftp.c | 129 +++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+)
 create mode 100644 net/lwip/apps/tftp/Makefile
 create mode 100644 net/lwip/apps/tftp/lwip-tftp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 6a8fcef392..11389bb038 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -29,3 +29,16 @@ int ulwip_dns(char *name, char *varname);
  *         Other value < 0, if error
 */
 int ulwip_dhcp(void);
+
+/**
+ * ulwip_tftp() - load file with tftp
+ *
+ * Load file with tftp to specific address
+ *
+ * @addr: Address to store downloaded file
+ * @filename: File name on remote tftp server to download
+ *
+ *
+ * Returns:  0 if success, !0 if error
+ */
+int ulwip_tftp(ulong addr, const char *filename);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index a3a33b7f71..b348e5ca31 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 
 obj-y += apps/dhcp/lwip-dhcp.o
 obj-y += apps/dns/lwip-dns.o
+obj-y += apps/tftp/
diff --git a/net/lwip/apps/tftp/Makefile b/net/lwip/apps/tftp/Makefile
new file mode 100644
index 0000000000..c3ad3c6353
--- /dev/null
+++ b/net/lwip/apps/tftp/Makefile
@@ -0,0 +1,7 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include/lwip/apps
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/contrib/examples/tftp/
+
+obj-y += ../../lwip-external/src/apps/tftp/tftp.o
+obj-y += lwip-tftp.o
diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
new file mode 100644
index 0000000000..56eed3030b
--- /dev/null
+++ b/net/lwip/apps/tftp/lwip-tftp.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+#include <bootstage.h>
+
+#include "tftp_client.h"
+#include "tftp_server.h"
+#include <tftp_example.h>
+
+#include <string.h>
+
+#include <net/ulwip.h>
+
+static ulong daddr;
+static ulong size;
+
+static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
+{
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	log_info("\ndone\n");
+	log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
+
+	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
+	if (env_set_hex("filesize", size)) {
+		log_err("filesize not updated\n");
+		ulwip_exit(-1);
+		return;
+	}
+	ulwip_exit(0);
+}
+
+static int tftp_read(void *handle, void *buf, int bytes)
+{
+	return 0;
+}
+
+static int tftp_write(void *handle, struct pbuf *p)
+{
+	struct pbuf *q;
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy((void *)daddr, q->payload, q->len);
+		daddr += q->len;
+		size += q->len;
+		log_info("#");
+	}
+
+	return 0;
+}
+
+static void tftp_error(void *handle, int err, const char *msg, int size)
+{
+	char message[100];
+
+	memset(message, 0, sizeof(message));
+	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
+
+	log_info("TFTP error: %d (%s)", err, message);
+}
+
+static const struct tftp_context tftp = {
+	tftp_open,
+	tftp_close,
+	tftp_read,
+	tftp_write,
+	tftp_error
+};
+
+int ulwip_tftp(ulong addr, char *fname)
+{
+	void *f = (void *)0x1; /* unused fake file handle*/
+	err_t err;
+	ip_addr_t srv;
+	int ret;
+	char *server_ip;
+
+	if (!fname || addr == 0)
+		return CMD_RET_FAILURE;
+
+	size = 0;
+	daddr = addr;
+	server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: serverip variable has to be set\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ipaddr_aton(server_ip, &srv);
+	if (!ret) {
+		log_err("error: ipaddr_aton\n");
+		return CMD_RET_FAILURE;
+	}
+
+	log_info("TFTP from server %s; our IP address is %s\n",
+		 server_ip, env_get("ipaddr"));
+	log_info("Filename '%s'.\n", fname);
+	log_info("Load address: 0x%lx\n", daddr);
+	log_info("Loading:");
+
+	bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
+
+	err = tftp_init_client(&tftp);
+	if (!(err == ERR_OK || err == ERR_USE))
+		log_err("tftp_init_client err: %d\n", err);
+
+	err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		log_err("tftp_get err=%d\n", err);
+		return CMD_RET_FAILURE;
+	}
+
+	if (env_set_hex("fileaddr", addr)) {
+		log_err("fileaddr not updated\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
-- 
2.30.2

