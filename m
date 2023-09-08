Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D2EEE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E086A34;
	Fri,  8 Sep 2023 15:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jF+3ZcZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C502986A63; Fri,  8 Sep 2023 15:55:43 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA6386A49
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so36857891fa.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181339; x=1694786139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdgneGqqiBGx6Qr+uBbt0uaj/QAsGJ1j6vG1ulncYAM=;
 b=jF+3ZcZ1nNd98zXC5XSY5CTqqf5rEqLfFYUnXW5I5oaSyzcK5Y7xjg5E2pILclONMj
 SCVyUVqXr9VJ2fHnX6pRqD12TO3yuh9iNTixI671Q72qjAGe3KPhj2RyQCl7BfZzAECQ
 CcizQh1Xv080dUuxontRVT+EEH5kXDkH6406dcPhhZRFNq3FJFY+OmHhiP9Hzf+KeNxQ
 1UpcrMjZiaSZgospTI3niPhgbRn6GRanhiGgERhlg+DKUkkzjbA/7x5tFv8B33YzliZZ
 LV9m5aTThcvfUaMHc9zugmpn475ggIorwGxZFULylVw6Np0DEyiG4rxj80dU5uIjDwh+
 wwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181339; x=1694786139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdgneGqqiBGx6Qr+uBbt0uaj/QAsGJ1j6vG1ulncYAM=;
 b=wnfZTyaHGfvxXk9NboIAsiVXvSQAyuirtzOG/47GJmao7UMfvDZipl8GD980e2gBfn
 q/mk8MbSoeA1RkJG56ViwYcKe0SJ3newC9K+bEimiIfWyO5WLVnDzNa+kq8MyYRoCOLD
 b6aJSQ4szYQS4x/zLZdLtuXacrTUfKtlyHVA2Zzncwr+RbtKeWDsdrL6t53vDhSvuS/4
 Mng4/9nwMry5QaMnrxUcjWapaMahipuFRH1nE9lbpwMbXKOKY9RH3GKYHAr6Pyfzc664
 Js1TUiOxV1IqmTEhaSpAQ41Rka/9ENbC3dn9UfC/HiPJIKCOW7oxJ1PN1AzsKpQVbIfD
 J9MA==
X-Gm-Message-State: AOJu0Yx7VGvDdcOIRGP67mm7MLlJWm87qU9O0RQjr+Tb/xLwLonm4wJZ
 cKZT2FkrEdCtedbSd3r6nguRqiPpdZQkdrfkd0r/+A==
X-Google-Smtp-Source: AGHT+IEeyigXkxfEE0wmaeCTpHbKueZJ4DE8sTqf4V88qkaBlZBjQB8srZwlwNIM63kC0K65YvmrBw==
X-Received: by 2002:a2e:9206:0:b0:2be:3ca8:bdc9 with SMTP id
 k6-20020a2e9206000000b002be3ca8bdc9mr1810804ljg.49.1694181339127; 
 Fri, 08 Sep 2023 06:55:39 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:38 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 04/15] net/lwip: implement dhcp cmd
Date: Fri,  8 Sep 2023 19:53:09 +0600
Message-Id: <20230908135320.7066-5-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
 include/net/lwip.h             | 12 +++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/dhcp/lwip-dhcp.c | 61 ++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
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
index 0000000000..68334a02bb
--- /dev/null
+++ b/net/lwip/apps/dhcp/lwip-dhcp.c
@@ -0,0 +1,61 @@
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
+#define DHCP_WAIT_MS 2000
+
+static void dhcp_tmo(void *arg)
+{
+	struct netif *netif = (struct netif *)arg;
+	struct dhcp *dhcp;
+	int err = 0;
+
+	dhcp = netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP);
+	if (!dhcp)
+		return;
+
+	switch (dhcp->state) {
+	case DHCP_STATE_BOUND:
+		err += env_set("bootfile", dhcp->boot_file_name);
+		err += env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
+		err += env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
+		err += env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
+		if (err)
+			log_err("error update envs\n");
+		log_info("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp->offered_ip_addr));
+		break;
+	default:
+		return;
+	}
+}
+
+int ulwip_dhcp(void)
+{
+	struct netif *netif;
+	int eth_idx;
+
+	eth_idx = eth_get_dev_index();
+	if (eth_idx < 0)
+		return -EPERM;
+
+	netif = netif_get_by_index(eth_idx + 1);
+	if (!netif)
+		return -ENOENT;
+
+	sys_timeout(DHCP_WAIT_MS, dhcp_tmo, netif);
+
+	return dhcp_start(netif) ? 0 : -EPERM;
+}
-- 
2.30.2

