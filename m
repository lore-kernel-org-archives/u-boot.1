Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D5C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BFD88835;
	Wed,  3 Jul 2024 15:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="a4cuVjKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA74887C6; Wed,  3 Jul 2024 07:42:32 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9020788784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985349; x=1722577349;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tnjg0brQygI6264KaVZc4Emwa3bzJ3TL1eomPz9iuI8=;
 b=a4cuVjKrTSpGjddhClWYp7pmF4Yzo9ruMpvlMkdlq4TAP35MlfUkcgVVtE+Tdcwp
 li/kunxq8uwcTPiEtzSSHbbIkC8gG2RaTwbrB8qYF9aeF97hRa2Sn8QMvUzNpSuZ
 g7FiSoOwSKmMzA2aeyQIVhI35OSu6OyUOPyTxzRLBMY=;
X-AuditID: ac14000a-03e52700000021bc-66-6684e4c52cf1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AE.6D.08636.5C4E4866;
 Wed,  3 Jul 2024 07:42:29 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:25 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 1/9] include: env: phytec: Create env file for loading and
 applying overlays
Date: Tue, 2 Jul 2024 22:41:54 -0700
Message-ID: <20240703054202.2812540-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWyRpKBR/fok5Y0gzXfZSxa1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDImH9rMXnCLv6J94VOm
 BsZfPF2MHBwSAiYSsxbbdDFycQgJLGGSmHJtIiOEc49RYsXGbuYuRk4ONgEtiTtb5jKDJEQE
 1jFKzL2yiQnEYRZYxihxbsYBNpAqYYEYiRezF7GAjGURUJHY36QCYvIKWElMfCYEUiEhIC8x
 89J3dhCbU8BaYvLv58wgJUJAJQv/mIOEeQUEJU7OfMICYjMDlTdvnc0MYUtIHHzxAswWElCQ
 mL1tMiPMyGnnXjND2KESW79sZ5rAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozKktRk
 vZTUTYyg2BFh4NrB2DfH4xAjEwfjIUYJDmYlEV6p981pQrwpiZVVqUX58UWlOanFhxilOViU
 xHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhjb553Ri+/ZdoU7++/Ell+7TaJlXiqKFc6carj5
 qKTpqntlP65X53t1rVF1XJAw009Z6a9ynZhqDZ9WjGbjl/sH/uY/tP5pnngj/0TQ2YOBSaZ3
 NLdlq1Wt1/X2uGNssvOyz9sQ1eL2jOojan0yl+eftZ4c5cG2JEDedK9rl/HkJp6Uvvt6/Uos
 xRmJhlrMRcWJAJZUl1iLAgAA
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

