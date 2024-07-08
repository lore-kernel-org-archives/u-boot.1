Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E480C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6FF788655;
	Mon,  8 Jul 2024 08:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DChsMD5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E928865E; Mon,  8 Jul 2024 08:07:55 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7826884C6
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418873; x=1723010873;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CVc5V+AceU/bNECHn5/R7VBDxcZ8DKSM0DqM9NHLLgU=;
 b=DChsMD5tVk7KKq2PBxA2wgw3xDQUJFYstmjlz/ITo1Pzno9+U8uCKf0IyDMXZOnH
 dQZOZbS8xRxwRgeVVelp0TreMEiKQeZGY/he/lRy33Wi36zSPovwwo1Rv8eHFNco
 DRiK5HSCnVIVH4xpLbttvg2wOfsdMJzOJPE+rqGYk3g=;
X-AuditID: ac14000a-03251700000021bc-46-668b8239af41
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CB.11.08636.9328B866;
 Mon,  8 Jul 2024 08:07:53 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:07:50 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/6] include: env: phytec: overlays: Add extension command
Date: Sun, 7 Jul 2024 23:07:29 -0700
Message-ID: <20240708060734.4029040-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWyRpKBR9eyqTvNoP+ZvEXLWg+LTx8yLT7t
 fMxqcbR/DbPFpQepFi+OzWW3ePPjLJPF1Emb2S3e7u1kt+h+p+7A5fH+Riu7x6sDq9g9zt7Z
 wejR393C6nH9zHYmj+M3tjMFsEVx2aSk5mSWpRbp2yVwZVz8cYWl4DR3xdv3jUwNjD84uxg5
 OSQETCRO3vzJ3MXIxSEksIRJ4vqN1ewgCSGBe4wS07YngNhsAloSd7bMZQaxRQSSJJZd7GQF
 aWAW+M4o8eLjL1aQhLCAl8S7u//AmlkEVCQmHlnJBGLzClhJbOiZzwyxTV5i5qXvYDWcAtYS
 j6Z1skAss5KYO3kDG0S9oMTJmU/A4sxA9c1bZzND2BISB1+8YIaoV5CYvW0yI8zMaedeQ80P
 lTiyaTXTBEahWUhGzUIyahaSUQsYmVcxCuVmJmenFmVm6xVkVJakJuulpG5iBMWMCAPXDsa+
 OR6HGJk4GA8xSnAwK4nwnn7cnibEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQQHpiSWp2
 ampBahFMlomDU6qBUcxToPgm74znaxW/7Ph42Cg1N+/0wZiZL/plxUPXrdrq06K0wXPv8SUR
 K00lS33+x9gkpCwRkdiTbH/gj9aHH3EJZ+5wzU0T3Fs7S3PGqpP7k0+H1s7U578me6cxKz6D
 5+m9wPRd7M9trk06mp6RcP2iavTKw9tFlA+f+bM6PsL4dk21TrCyhxJLcUaioRZzUXEiAKeW
 mROHAgAA
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

Add a new environment routine to apply extensions. Our SOM detection
adds overlays via the extension framework to alter the kernel
device-tree according to the flashed EEPROM image.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/overlays.env | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/env/phytec/overlays.env b/include/env/phytec/overlays.env
index 78721cde654..50110e731bd 100644
--- a/include/env/phytec/overlays.env
+++ b/include/env/phytec/overlays.env
@@ -23,6 +23,16 @@ mmc_apply_overlays=
 			fi;
 		done;
 	fi;
+#ifdef CONFIG_CMD_EXTENSION
+mmc_apply_extensions=
+	setenv extension_overlay_addr ${fdtoverlay_addr_r};
+	setenv extension_overlay_cmd 'load mmc ${mmcdev}:${mmcpart}
+	  ${fdtoverlay_addr_r} ${extension_overlay_name}';
+	extension scan;
+	extension apply all;
+#else
+mmc_apply_extensions=echo "no extension command"
+#endif
 net_load_bootenv=${get_cmd} ${bootenv_addr_r} ${bootenv}
 net_load_overlay=${get_cmd} ${fdtoverlay_addr_r} ${overlay}
 net_apply_overlays=
@@ -36,3 +46,13 @@ net_apply_overlays=
 			fi;
 		done;
 	fi;
+#ifdef CONFIG_CMD_EXTENSION
+net_apply_extensions=
+	setenv extension_overlay_addr ${fdtoverlay_addr_r};
+	setenv extension_overlay_cmd '${get_cmd} ${fdtoverlay_addr_r}
+	 ${extension_overlay_name}';
+	extension scan;
+	extension apply all;
+#else
+net_apply_extensions=echo "no extension command"
+#endif
-- 
2.25.1

