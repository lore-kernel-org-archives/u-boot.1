Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CD9C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EE788A1F;
	Wed, 17 Jul 2024 07:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YXaiYmcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AAE388A1A; Wed, 17 Jul 2024 07:11:56 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B14588636
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193114; x=1723785114;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T2THgnCOPHIQWk1cSpcW9K5B9/QU7rIuIssmmV4Pw4Y=;
 b=YXaiYmcPjJGkUhRYexbBm8lu6kWkXlPCVPF8Ol2le5f7mO1+lHIIjhsro2BVAXj4
 kD25knMzqrYbvNgxttZvHY4fd9uSTWpkaB7fbgQLbRcR8I82pH7WoJFfgqYRPh2o
 wT1moYOFAYD35NzOU6o2G6IGkzmgGQnDPy4c4sv/inM=;
X-AuditID: ac14000a-03251700000021bc-e2-6697529a1486
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EB.7B.08636.A9257966;
 Wed, 17 Jul 2024 07:11:54 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:11:52 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 1/9] include: env: phytec: Create env file for loading and
 applying overlays
Date: Tue, 16 Jul 2024 22:11:26 -0700
Message-ID: <20240717051134.1538180-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR3dW0PQ0g+cnWCxa1npYTJ20md3i
 7d5Odovud+oOLB6vDqxi9zh7ZwejR393C6vH8RvbmQJYorhsUlJzMstSi/TtErgy9k3fx16w
 W6Bi16nKBsaLvF2MnBwSAiYSfdc2M3YxcnEICSxhkrhzfw0zSEJI4D6jxLX92iA2m4CWxJ0t
 c8HiIgI+EkdbN7OANDALdDJKrN+3gAkkISwQL7H6+jRGEJtFQFXi/9ONbCA2r4CVxPxvL1gh
 tslLzLz0nR3E5hSwllh88TaQzQG0zEri8INAiHJBiZMzn7CA2MxA5c1bZzND2BISB1+8gLpN
 QWL2tsmMMCOnnXvNDGGHSmz9sp1pAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktS
 k/VSUjcxgkJchIFrB2PfHI9DjEwcjIcYJTiYlUR4JzBOSxPiTUmsrEotyo8vKs1JLT7EKM3B
 oiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXA6PBsT9yh42IF8x6HMy7QvNnR2rmZ9XnBQQ5H
 oz3CNRPqW/VbeDq6lzdIvbvFwLqpw+q/xb69j5o/6/Lk8cgyed5MVhZh+hD44eXMx3fDWFuP
 N9+p3FjdzSzx686/ozW6TRacrjXnq17l7DmuwLWjPd7nTs+3m5f5Gv+UvHfhyP4240Q4199E
 JZbijERDLeai4kQApXqj5F8CAAA=
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

From: Benjamin Hahn <B.Hahn@phytec.de>

The env scripts for loading and applying overlays are identical for many
PHYTEC Boards. Create a common env that can be included.

The env variables bootenv_addr and fdto_addr are board specific and need
to be set in the board specific file. The env variable get_cmd also
needs to be set in board specific files and can be set to tftp or dhcp.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/env/phytec/overlays.env | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 include/env/phytec/overlays.env

diff --git a/include/env/phytec/overlays.env b/include/env/phytec/overlays.env
new file mode 100644
index 00000000000..febb991f4f5
--- /dev/null
+++ b/include/env/phytec/overlays.env
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later  */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Benjamin Hahn <b.hahn@phytec.de>
+ */
+
+/* Logic to load and apply overlays. Load overlays from bootenv.txt into
+ * environment and apply those overlays.
+ * The variables bootenv_addr and fdto_addr are board specific. */
+
+bootenv=bootenv.txt
+mmc_load_bootenv=load mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}
+mmc_load_overlay=load mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}
+mmc_apply_overlays=
+	fdt address ${fdt_addr};
+	if test ${no_overlays} = 0; then
+		for overlay in ${overlays};
+		do;
+			if run mmc_load_overlay; then
+				fdt resize ${filesize};
+				fdt apply ${fdto_addr};
+			fi;
+		done;
+	fi;
+net_load_bootenv=${get_cmd} ${bootenv_addr} ${bootenv}
+net_load_overlay=${get_cmd} ${fdto_addr} ${overlay}
+net_apply_overlays=
+	fdt address ${fdt_addr};
+	if test ${no_overlays} = 0; then
+		for overlay in ${overlays};
+		do;
+			if run net_load_overlay; then
+				fdt resize ${filesize};
+				fdt apply ${fdto_addr};
+			fi;
+		done;
+	fi;
-- 
2.25.1

