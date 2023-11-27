Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4BC0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C878758C;
	Mon, 27 Nov 2023 14:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qCOyDr19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 736C187515; Mon, 27 Nov 2023 14:00:26 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE84287570
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5094727fa67so5972657e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090020; x=1701694820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JT5v0igFMxgK43yQbnjgeHYXiWam/yzmig+d+0Kn2s=;
 b=qCOyDr19OshgH5oD2/5g7xOVjp87BSAXao68VzQeF7FO+DG7IxX8R/uNkWR8Rn89U6
 RenFoGwlMTnbMXyvyxfmSlAJWtwzWCvE2Jl+B83s7cf9xmxOBq5FILloDbNX7Qy3h5C1
 xhjhRZxUo448Upf8HKyv4xLteF+IgJTVaGrFdXlHbXACLfWxRuzqozuZGuKZ6YSNkT4h
 K6Do3Vjsry3+hm+fyItU7eu199h729grUmRoKFsDa5WwmZSif5h4P8EJ/Qz/MDTQn19K
 vJKmnN9SkzXSj5mK8W6hzls7dAkUtBIcc2K8IjNiQPU4HAqRiw8SGVpCGx9L6nO2w4et
 tpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090020; x=1701694820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JT5v0igFMxgK43yQbnjgeHYXiWam/yzmig+d+0Kn2s=;
 b=LuRJUb9RJciKAxzVy7Dej1tykT0PAL1iOKDSrgXnoo5wRKVTxffjYzhLknbZ9uD/xu
 DU6fgYNSRU3nUjF2sHUpKgJXET1Da4OM9//aHrUYKGbZT7RtzrDXBu7XgmrxmFnp53mx
 UuQBV2JVxWgcZvh6NmcQoqPEfpxENvsAFamT+CJsMKQs267jiGWa+u2s8vL+lvyzWVCq
 bjXu0C/imWaU/B5AmqGEcA7bY2COP7IjeYNpHPfsmQTmMRvsOFzqXj3Tj2i3nOTOlkRv
 yz//0vJwNw5iKIGz5dpPGaB3xqUH9kNHhIfFu4Jfn7hMXNh84MfRa898ucTGV7bQ0bdM
 L/jw==
X-Gm-Message-State: AOJu0YwTAqrYzz7Gp4fhdFii1+4O8Nv9HUI6s/6/bZqyXLPPijw/obtR
 /3rFXFw3sJr/raP6nksfCLaOycQ9WJdgzAUX+S6g7A==
X-Google-Smtp-Source: AGHT+IE4WSr1QMmXjhGAxh6+pLT/K8xjaxn2EGN6cFVqFLrHjil0MYoTKEVH0RCwf3QxCVC+kYfdoA==
X-Received: by 2002:ac2:532f:0:b0:505:6cc7:e0f7 with SMTP id
 f15-20020ac2532f000000b005056cc7e0f7mr7457865lfh.44.1701090020061; 
 Mon, 27 Nov 2023 05:00:20 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:19 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 05/43] net/lwip: implement dhcp cmd
Date: Mon, 27 Nov 2023 18:56:48 +0600
Message-Id: <20231127125726.3735-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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
Replace dhcp command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             | 12 +++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/dhcp/lwip-dhcp.c | 86 ++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index ab3db1a214..9941845f8c 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -17,3 +17,15 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
  *          Other value < 0, if error
  */
 int ulwip_dns(char *name, char *varname);
+
+/**
+ * ulwip_dhcp() -  create the DHCP request to obtain IP address.
+ *
+ * This function creates the DHCP request to obtain IP address. If DHCP server
+ * returns file name, this file will be downloaded with tftp.  After this
+ * function you need to invoke the polling loop to process network communication.
+ *
+ * Returns: 0 if success
+ *         Other value < 0, if error
+ **/
+int ulwip_dhcp(void);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 5d8d5527c6..a3a33b7f71 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -63,4 +63,5 @@ obj-$(CONFIG_NET) += lwip-external/src/netif/ethernet.o
 obj-$(CONFIG_NET) += port/if.o
 obj-$(CONFIG_NET) += port/sys-arch.o
 
+obj-y += apps/dhcp/lwip-dhcp.o
 obj-y += apps/dns/lwip-dns.o
diff --git a/net/lwip/apps/dhcp/lwip-dhcp.c b/net/lwip/apps/dhcp/lwip-dhcp.c
new file mode 100644
index 0000000000..966b3991ee
--- /dev/null
+++ b/net/lwip/apps/dhcp/lwip-dhcp.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+
+#include <lwip/dhcp.h>
+#include <lwip/prot/dhcp.h>
+#include "lwip/timeouts.h"
+
+#include <net/eth.h>
+#include <net/ulwip.h>
+
+#define DHCP_TMO_TIME 1000 /* poll for DHCP state change */
+#define DHCP_TMO_NUM  20  /* number of tries */
+
+typedef struct dhcp_priv {
+	int num_tries;
+	struct netif *netif;
+} dhcp_priv;
+
+static void dhcp_tmo(void *arg)
+{
+	struct dhcp_priv *dpriv = (struct dhcp_priv *)arg;
+	struct netif *netif = dpriv->netif;
+	struct dhcp *dhcp;
+
+	log_err("%s %d/%d\n", __func__, dpriv->num_tries, DHCP_TMO_NUM);
+	dhcp = netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP);
+	if (!dhcp)
+		return;
+
+	if (dhcp->state == DHCP_STATE_BOUND) {
+		int err = 0;
+
+		err -= env_set("bootfile", dhcp->boot_file_name);
+		err -= env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
+		err -= env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
+		err -= env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
+		if (err)
+			log_err("error update envs\n");
+		log_info("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp->offered_ip_addr));
+		free(dpriv);
+		ulwip_exit(err);
+		return;
+	}
+
+	dpriv->num_tries--;
+	if (dpriv->num_tries < 0) {
+		log_err("DHCP client timeout\n");
+		free(dpriv);
+		ulwip_exit(-1);
+		return;
+	}
+
+	sys_timeout(DHCP_TMO_TIME, dhcp_tmo, dpriv);
+}
+
+int ulwip_dhcp(void)
+{
+	struct netif *netif;
+	int eth_idx;
+	struct dhcp_priv *dpriv;
+
+	dpriv = malloc(sizeof(struct dhcp_priv));
+	if (!dpriv)
+		return -EPERM;
+
+	eth_idx = eth_get_dev_index();
+	if (eth_idx < 0)
+		return -EPERM;
+
+	netif = netif_get_by_index(eth_idx + 1);
+	if (!netif)
+		return -ENOENT;
+
+	dpriv->num_tries = DHCP_TMO_NUM;
+	dpriv->netif = netif;
+	sys_timeout(DHCP_TMO_TIME, dhcp_tmo, dpriv);
+
+	return dhcp_start(netif) ? -EPERM : 0;
+}
-- 
2.30.2

