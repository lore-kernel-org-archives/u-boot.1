Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63052C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280A188636;
	Wed, 17 Jul 2024 07:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UHHACMxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D522288A30; Wed, 17 Jul 2024 07:12:04 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6EB088A27
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193122; x=1723785122;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rLusjLq1/UJ/o2wRCw9VG0izqcXyiv/x2kn9MV9sqsA=;
 b=UHHACMxixXCVzIvjG0YIGfGaT3To0wUW++tP5yTg4aBIy+7RXHQTvvZai72ZeL47
 y/DVPLu/ZXKa1T7VABTpAq3cm1bVkOkRDywLqDHwj1707cSqYKX6Zl54fFslbwtG
 O5NYitCRf9lDWo3CoIc+nmxotJv0cTloYlHchxFCctg=;
X-AuditID: ac14000a-03e52700000021bc-ef-669752a2fbc7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 62.8B.08636.2A257966;
 Wed, 17 Jul 2024 07:12:02 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:12:00 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 5/9] include: env: phytec: renaming of variables according
 to bootstd doc
Date: Tue, 16 Jul 2024 22:11:30 -0700
Message-ID: <20240717051134.1538180-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBR3dR0PQ0gy+tehYtaz0spk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+I3tTAEsUVw2Kak5mWWpRfp2CVwZt1YHFvwT
 qPjTsZaxgXEqXxcjJ4eEgIlE5/ZXzF2MXBxCAkuYJJqfbGOHcO4zSvTfOcoMUsUmoCVxZ8tc
 MFtEwEfiaOtmFpAiZoFORon1+xYwdTFycAgLxEgsPqcLUsMioCpxbdNBFhCbV8BK4v+6v2wQ
 2+QlZl76zg5icwpYSyy+eJsdpFUIqObwg0CIckGJkzOfgLUyA5U3b53NDGFLSBx88QLMFhJQ
 kJi9bTIjzMhp514zQ9ihElu/bGeawCg0C8moWUhGzUIyagEj8ypGodzM5OzUosxsvYKMypLU
 ZL2U1E2MoBAXYeDawdg3x+MQIxMH4yFGCQ5mJRHeCYzT0oR4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUw+l6eXTxTseHZCh/X75v/1DlccVyr1qkc01G1
 2HjtSxfe6yfeT51Y0fR5saR4SZPLhh0GM4R+bWhb+Mf65syNx969a7mskD7B/Fj0TJmSgoks
 nx8/3sV5fjPHlU/TA84sNt6f+jpj7h8rF3mTXQZm1jsOVD/Z9ONsj0Tth9cXoyatl2FOOhy7
 pVmJpTgj0VCLuag4EQAtFDhCXwIAAA==
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

Rename existing environment variables according to the bootstd doc.
Renamed variables are fdto_addr, bootenv_addr, fdt_addr.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 include/env/phytec/overlays.env | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/env/phytec/overlays.env b/include/env/phytec/overlays.env
index febb991f4f5..78721cde654 100644
--- a/include/env/phytec/overlays.env
+++ b/include/env/phytec/overlays.env
@@ -6,32 +6,33 @@
 
 /* Logic to load and apply overlays. Load overlays from bootenv.txt into
  * environment and apply those overlays.
- * The variables bootenv_addr and fdto_addr are board specific. */
+ * The variables bootenv_addr_r and fdtoverlay_addr_r are board specific.
+ * get_cmd can be either tftp or dhcp. */
 
 bootenv=bootenv.txt
-mmc_load_bootenv=load mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}
-mmc_load_overlay=load mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}
+mmc_load_bootenv=load mmc ${mmcdev}:${mmcpart} ${bootenv_addr_r} ${bootenv}
+mmc_load_overlay=load mmc ${mmcdev}:${mmcpart} ${fdtoverlay_addr_r} ${overlay}
 mmc_apply_overlays=
-	fdt address ${fdt_addr};
+	fdt address ${fdt_addr_r};
 	if test ${no_overlays} = 0; then
 		for overlay in ${overlays};
 		do;
 			if run mmc_load_overlay; then
 				fdt resize ${filesize};
-				fdt apply ${fdto_addr};
+				fdt apply ${fdtoverlay_addr_r};
 			fi;
 		done;
 	fi;
-net_load_bootenv=${get_cmd} ${bootenv_addr} ${bootenv}
-net_load_overlay=${get_cmd} ${fdto_addr} ${overlay}
+net_load_bootenv=${get_cmd} ${bootenv_addr_r} ${bootenv}
+net_load_overlay=${get_cmd} ${fdtoverlay_addr_r} ${overlay}
 net_apply_overlays=
-	fdt address ${fdt_addr};
+	fdt address ${fdt_addr_r};
 	if test ${no_overlays} = 0; then
 		for overlay in ${overlays};
 		do;
 			if run net_load_overlay; then
 				fdt resize ${filesize};
-				fdt apply ${fdto_addr};
+				fdt apply ${fdtoverlay_addr_r};
 			fi;
 		done;
 	fi;
-- 
2.25.1

