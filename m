Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB3FEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BE98648C;
	Tue, 22 Aug 2023 11:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RO8JZVsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52194864A7; Tue, 22 Aug 2023 11:38:36 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961018648C
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bbbda48904so48127031fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697112; x=1693301912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3zmAwXtqc3guciP0kryq60f+uDEjSPEHUuH41ebGGY=;
 b=RO8JZVszvFlozgS1CXG4+QOXF5V5pfgTluws3SQjuoowSx3EdG8TVhWvy1E09L4edp
 HoslhiWvvDcxmLlpRlGtiexhtFyC7qfeZKyvuDxZ5YYom3vUTBYIVkvSLyrkPPxe0jyZ
 LkEim0FkZ4kSJFF0pP1k+ziYDyfFxiaG2MePIK6TkY4lNaaszyQupHW5Z8gidfiRzx06
 DG8T6zslpeMwveviqchMWMdvkdhnqdeLyqMvxr7BHI+A0lu2iR4ea02Zvzc3tSUDIN4Y
 Lzd5aaAnNt6J4VQ2V0GCGG2JucijBv0BPpDSO2Mh6jiEQa1aRcP0HZfQ+GoghyP8Wf/T
 XJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697112; x=1693301912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3zmAwXtqc3guciP0kryq60f+uDEjSPEHUuH41ebGGY=;
 b=GsUwtHvFbz7KfYDpZZnLdhtEowhVz05MwFM7ICNWd8iNC5p+1MhqWspNaCPKr45BVO
 6R5QiLQY47jct8INAbBqL6NINXTPexPLjRZOZnX/4FEeOyt7ugPXhMc/R9bD6nOdPivn
 tDZp+aCUkBX5LcQ14Trw2sc2L82HmtzsLA1fhoP/rEdmTU3RHCJrCKNnEMdPHcG6sT9M
 pOtSZVep+DM+wnb/BywElfMO6UTZ04TyjBK8XqZnkh78rjqNQfuO9O+eXMT2ouR4Zfmo
 ZBQwV7J/EalmcKMlg3Yw9OriY9v5F63Ex5LCTHeiaRRGtZcFIUe8tcxRhB6EgcPXkVTL
 dp+Q==
X-Gm-Message-State: AOJu0YxgUghteXCW+tcT9g/2/ByEDCoX1/UAgabmxLAVWmJ2wKAhkyBJ
 CuXAvUbAwYaLHVPzw2jrziJD1Bi5fxSwwFZeLlnAXw==
X-Google-Smtp-Source: AGHT+IGsLIZR9XGulFf6kXYMEHqiZzNayJB/vCyZe7wYz5TWFMeAQWoAO6RXZGEccaPJ1EJX4i9l0g==
X-Received: by 2002:a2e:91d8:0:b0:2bc:c3c0:a997 with SMTP id
 u24-20020a2e91d8000000b002bcc3c0a997mr3512761ljg.38.1692697112730; 
 Tue, 22 Aug 2023 02:38:32 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:32 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 05/15] net/lwip: implement tftp cmd
Date: Tue, 22 Aug 2023 15:36:04 +0600
Message-Id: <20230822093614.4717-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
 include/net/lwip.h             |  14 +++-
 net/lwip/Makefile              |   1 +
 net/lwip/apps/tftp/Makefile    |  16 +++++
 net/lwip/apps/tftp/lwip-tftp.c | 124 +++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 net/lwip/apps/tftp/Makefile
 create mode 100644 net/lwip/apps/tftp/lwip-tftp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 240ebba354..14a65470ee 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -28,4 +28,16 @@ int ulwip_dns(char *name, char *varname);
  * Returns: 0 if success
  *         Other value < 0, if error
 */
-int ulwip_dhcp(void);
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
index 59323fb325..0337d82cf5 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 
 obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
 obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
+obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
diff --git a/net/lwip/apps/tftp/Makefile b/net/lwip/apps/tftp/Makefile
new file mode 100644
index 0000000000..0e50fcad45
--- /dev/null
+++ b/net/lwip/apps/tftp/Makefile
@@ -0,0 +1,16 @@
+
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(obj)
+
+$(obj)/tftp.o: $(obj)/tftp.c
+.PHONY: $(obj)/tftp.c
+$(obj)/tftp.c:
+	cp $(srctree)/net/lwip/lwip-external/src/apps/tftp/tftp.c $(obj)/tftp.c
+	cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/tftp_client.h $(obj)/tftp_client.h
+	cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/tftp_common.h $(obj)/tftp_common.h
+	cp $(srctree)/net/lwip/lwip-external/contrib/examples/tftp/tftp_example.h $(obj)/tftp_example.h
+
+obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_TFTPBOOT) += lwip-tftp.o
+
diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
new file mode 100644
index 0000000000..e6e4883de8
--- /dev/null
+++ b/net/lwip/apps/tftp/lwip-tftp.c
@@ -0,0 +1,124 @@
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
+#include "lwip/apps/tftp_client.h"
+#include "lwip/apps/tftp_server.h"
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
+	LWIP_UNUSED_ARG(mode);
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	log_info("\ndone\n");
+	log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
+
+	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
+	env_set_ulong("filesize", size);
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
+	LWIP_UNUSED_ARG(handle);
+
+	memset(message, 0, sizeof(message));
+	MEMCPY(message, msg, LWIP_MIN(sizeof(message)-1, (size_t)size));
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
+	env_set_hex("fileaddr", addr);
+	return err;
+}
-- 
2.30.2

