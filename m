Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D23CA0EF7
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612EA88D8C;
	Fri, 30 Aug 2024 11:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="B9Ml5eq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F9988D8D; Fri, 30 Aug 2024 11:10:04 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D41788D85
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1725009002; x=1727601002;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5+c/xLvQ/2hhPxI80HaBQPh6bMekk04+GVlZ1zZpjkw=;
 b=B9Ml5eq1LJu09EmiLvR8bgkzYRcyif8gGVpT+RO6Vs5CbZZkZ0nPyL6DoHJ663Ue
 icQNoPUyY8xia22zHkgXZK5QLrjwIG3Don973LrJy7NUA/G74lKkQeIyLQiMwUQ6
 CvyzAW242aPLfnNpipohTRypISAG45i3pScBGw8mPY0=;
X-AuditID: ac14000a-03e52700000021bc-20-66d18c6ae3cf
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 47.42.08636.A6C81D66;
 Fri, 30 Aug 2024 11:10:02 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 30 Aug
 2024 11:10:00 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 04/13] include: net: phytec: Add K3 network boot logic
Date: Fri, 30 Aug 2024 02:09:31 -0700
Message-ID: <20240830090940.2592157-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBRzer52KaQX+bnMWnnY9ZLaZO2sxu
 8XZvJ7tF9zt1BxaPVwdWsXucvbOD0aO/u4XV4/qZ7UwBLFFcNimpOZllqUX6dglcGfOXtTAX
 9HBVXLj7kK2B8QJHFyMnh4SAicTuhbMZuxi5OIQEljBJbLt/nR3Cuc8oMfv7KTaQKjYBLYk7
 W+Yyg9giAkkSu54sA4szC7hILL7xgbWLkYNDWMBN4lYXI0iYRUBVovnaFrASXgErid+LH7FC
 LJOXmHnpOzuIzSlgLbH56wMwWwio5vi0c1D1ghInZz5hgRgvL9G8dTYzhC0hcfDFC2aIegWJ
 2dsmM8LMnHbuNTOEHSpxZNNqpgmMQrOQjJqFZNQsJKMWMDKvYhTKzUzOTi3KzNYryKgsSU3W
 S0ndxAgKcxEGrh2MfXM8DjEycTAeYpTgYFYS4T1x/GyaEG9KYmVValF+fFFpTmrxIUZpDhYl
 cd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBsYJE3XLH3EXfE65sr6VuzBybhBTjGkM//HNu46t
 MC2X5dq3pbr1YvSCHzPaCj4Hbb0nPZ1rqnhobSY/035pz/CrP07lTvi2zORRIef+Sl3NpEnh
 oc+Mj99celDXwGK6zrTWELeVmvlKVV8LT3ouniN9LVqh8Xtu76TtPktE328/ddxSbp2uc48S
 S3FGoqEWc1FxIgDsT3aUYQIAAA==
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

This boot logic allows to boot a Kernel image, Device-Tree blob
and overlays via tftp/dhcp (configurable with 'net_fetch_cmd').
Additionally, it loads a rootfs via NFS.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_net.env | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/env/phytec/k3_net.env

diff --git a/include/env/phytec/k3_net.env b/include/env/phytec/k3_net.env
new file mode 100644
index 00000000000..377e406688d
--- /dev/null
+++ b/include/env/phytec/k3_net.env
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+/* Logic for TI K3 based SoCs to boot via network. */
+
+#include <env/phytec/overlays.env>
+
+netargs=setenv bootargs console=${console} root=/dev/nfs ip=dhcp rw
+	nfsroot=${serverip}:${nfsroot},vers=4,tcp
+netloadimage=${net_fetch_cmd} ${kernel_addr_r} ${serverip}:/Image
+netloadfdt=${net_fetch_cmd} ${fdt_addr_r} ${serverip}:/${fdtfile}
+netboot=run netargs;
+	setenv autoload no;
+	dhcp;
+	run netloadimage;
+	run netloadfdt;
+	run net_apply_overlays;
+	run net_apply_extensions;
+	booti ${kernel_addr_r} - ${fdt_addr_r}
-- 
2.25.1

