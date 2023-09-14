Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFDBEEAA53
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F5C86A3C;
	Thu, 14 Sep 2023 18:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ljqCIAvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC9A86A94; Thu, 14 Sep 2023 18:20:50 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2EA86672
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2bce552508fso17390541fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708447; x=1695313247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TpMV1fzgEaRtklvSF1wLKwOvwOJoWTA7xIFAq1N3os=;
 b=ljqCIAvjmfAO877hZFx1wSImW/qMteKp6WVjgaBio8MkYbztLx2WjxFS8FGYHZ0GJf
 +ce/dQIN8uHBmX28bUgRZkvQtJ9VsU2CaNih+Ayg+NlGEu+EtsiqbvKSH7RBW6Lrc763
 Kn/ZUNYYJABo003yH2CBNrE6C9wAnCP5UUXq33kGdDp7e3IluecS3XU+VBDg8Uqk6rhs
 oJniavE/eBSESgFo0qI8kyZAx+BYtSnLdyJxhqEfR2Pfc1hCFU4+nW8epfjBtT5tlshP
 f4C1cFfN6OzRdUdEnSeRiHzV+plYw8x50iJbUUZBc3/JqIRVbHBT0zKxfQ1WLU70vcez
 M+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708447; x=1695313247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TpMV1fzgEaRtklvSF1wLKwOvwOJoWTA7xIFAq1N3os=;
 b=R4JD/AF8sUp6w6XXW+h5Dp5NP11D5BikiqYBuNq2nwFTMVcLIkRlhqDKsmKW0E6xDL
 fczia+ET3Y0revJgOtO8DCfUceffBqK3l4G3P64Q7lIvzkLNukGshx2h7KmJ1bSJdNy/
 80BmlMYMyrJlGY+k0fsXD3fJAYpK0llUjuPDouQSXDqHy5Br01XxpYAE4PUjyBoTesGv
 612mESI0R4Ev8wxGNjnhwHbWanQIxKQfAde+Ifc81pjHyJDr4i/3vjIjjg99reWbH8X5
 lcME+Mjwzc4LDYYb789FeF82FIlSxIuGaMZ1O//gMuhxIF575CVTmXkqJC5bUjoNveWr
 eiTA==
X-Gm-Message-State: AOJu0YyOVAt0gu+X60gKPzvS8TUsBLsbN8XOBR+RysGnn3eB641EZS6S
 yx6zhPNuqRup480w6nL2aRTFcp6M0MyF6VprKBGlCg==
X-Google-Smtp-Source: AGHT+IGtNkB3G35mxmr7W9KFZgW5oqUTfYlnGn3//XinzP7GAAZIWXSYS5m8WI1fjOpAxdGAx+jXhQ==
X-Received: by 2002:a2e:9d41:0:b0:2bc:c3ad:f418 with SMTP id
 y1-20020a2e9d41000000b002bcc3adf418mr5241251ljj.20.1694708447426; 
 Thu, 14 Sep 2023 09:20:47 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:47 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 05/15] net/lwip: implement dhcp cmd
Date: Thu, 14 Sep 2023 22:18:18 +0600
Message-Id: <20230914161828.3662-6-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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
 net/lwip/apps/dhcp/lwip-dhcp.c | 85 ++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index ab3db1a214..6a8fcef392 100644
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
+*/
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
index 0000000000..f0b0e26f6e
--- /dev/null
+++ b/net/lwip/apps/dhcp/lwip-dhcp.c
@@ -0,0 +1,85 @@
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
+#define DHCP_TMO_TIME 500 /* poll for DHCP state change */
+#define DHCP_TMO_NUM  10  /* number of tries */
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
+	return dhcp_start(netif) ? 0 : -EPERM;
+}
-- 
2.30.2

