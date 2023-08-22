Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5229EE49A8
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F690864A5;
	Tue, 22 Aug 2023 11:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SLp4X6hM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84ACF86485; Tue, 22 Aug 2023 11:38:34 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7D886483
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bba6fc4339so66454541fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697110; x=1693301910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dr8LaPlzxDtuhlzzdz7uUgU31NMtIlicn5bWCKGw+no=;
 b=SLp4X6hMAMLsrGM4D/eXn1RvrKhkCBDE5Uy9owWmE6XN3hXK2xbScjhUlRUpTgGMdB
 RjCzJ3srhIZdOTsVnuPym+DEol4n0jkkbZSwIdWjAgActVbNNk3E3UHMj5O8tX1Z3U69
 uezpXXkeUR+EjQ9oYDwHLHGoeeaS1+7eCh3RY2molDuP78y7wzdfmc0x2wJiN76/JLhw
 Le1f17FcRWjS/xQo/aNBuyqKviF0EtFFo8Jy/eI/6/nZw5RqHhTxa3H0OJi0kCYM09vQ
 vUUw0TTfMNwXQwEp2dECZ2BsRb2M4i4lHahO7efN1ZH6xwFXIBFl12uRKptOUbBRCNcU
 VEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697110; x=1693301910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dr8LaPlzxDtuhlzzdz7uUgU31NMtIlicn5bWCKGw+no=;
 b=bvBQfuMb2X1pt60K/CVGR89d3JpWlzo/KzzVTZsWrdZhMatyOqvJIXaaueNgbe26qT
 FWSwmlnIVc5RHPQ7sWaF85sbqnpZZjbR40435M3N909gI4YEIUFrFqmCdjCK9jyrrWif
 6fIwFeFGT0oET3O6TrlDmpgrsaA1CQugdO3NMKgt7m0Zxj6Z37Q6eeZjUl1SZma23NGN
 jgTluBvWxLzCBBF3MxDVzYDkYLraQveh9EjX51gYM2Lpm0rLck/KoOpLzDc++qBjKKfk
 e++QKvYOPeZZRcuqaxC3bp4mpQnMFfJPQuoP4cGD3ryzXfwTs4IaxA950KmotpAlnCmQ
 9xUQ==
X-Gm-Message-State: AOJu0YzLG8dAvG9Gg3LOxiMMUBPeMEpCoPytETNfbJ5OG5yhUxypro0a
 Mhv5Rpz9nglhQGtC1E5hs26OuB7Vp63yU81VsEI+4A==
X-Google-Smtp-Source: AGHT+IEbRuv1+FGNTRBcLgyOuUZISeCE9WQNGbY7bOiLI/hHEgiBUgIlUL1wqGpF/vQN4iJPUnE3Jw==
X-Received: by 2002:a2e:9089:0:b0:2b6:fa3e:f2fa with SMTP id
 l9-20020a2e9089000000b002b6fa3ef2famr6912626ljg.32.1692697110582; 
 Tue, 22 Aug 2023 02:38:30 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:30 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 04/15] net/lwip: implement dhcp cmd
Date: Tue, 22 Aug 2023 15:36:03 +0600
Message-Id: <20230822093614.4717-5-maxim.uvarov@linaro.org>
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
Replace dhcp command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             | 12 +++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/dhcp/lwip-dhcp.c | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index cda896d062..240ebba354 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -17,3 +17,15 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
  *         Other value < 0, if error
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
index 6d2c00605b..59323fb325 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -65,4 +65,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
 obj-$(CONFIG_NET) += port/if.o
 obj-$(CONFIG_NET) += port/sys-arch.o
 
+obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
 obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
diff --git a/net/lwip/apps/dhcp/lwip-dhcp.c b/net/lwip/apps/dhcp/lwip-dhcp.c
new file mode 100644
index 0000000000..cce1e367f9
--- /dev/null
+++ b/net/lwip/apps/dhcp/lwip-dhcp.c
@@ -0,0 +1,62 @@
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
+
+#include <net/eth.h>
+#include <net/ulwip.h>
+
+static struct dhcp dhcp;
+
+static int ulwip_dhcp_tmo(void)
+{
+	switch (dhcp.state) {
+	case DHCP_STATE_BOUND:
+		env_set("bootfile", dhcp.boot_file_name);
+		env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
+		env_set("netmask", ip4addr_ntoa(&dhcp.offered_sn_mask));
+		env_set("serverip", ip4addr_ntoa(&dhcp.server_ip_addr));
+		printf("DHCP client bound to address %s\n", ip4addr_ntoa(&dhcp.offered_ip_addr));
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+int ulwip_dhcp(void)
+{
+	int err;
+	struct netif *netif;
+	int eth_idx;
+
+	eth_idx = eth_get_dev_index();
+	if (eth_idx < 0) {
+		log_err("no eth idx\n");
+		return -1;
+	}
+
+	netif = netif_get_by_index(eth_idx + 1);
+	if (!netif)
+		return -1;
+
+	ulwip_set_tmo(ulwip_dhcp_tmo);
+
+	if (!netif_get_client_data(netif, LWIP_NETIF_CLIENT_DATA_INDEX_DHCP))
+		dhcp_set_struct(netif, &dhcp);
+
+	err = dhcp_start(netif);
+	if (err)
+		log_err("dhcp_start error %d\n", err);
+
+	return err;
+}
-- 
2.30.2

