Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C8EC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BDC88856;
	Wed,  3 Jul 2024 15:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ol4dFb0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F82887C7; Wed,  3 Jul 2024 07:42:43 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A76888784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985361; x=1722577361;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TWV2QLk2a9/UP94U0JSshXh/yiZBiyKQZeFQUFRmC2Q=;
 b=ol4dFb0xEawzopC2K+ZsbXsIjEOsHNCnk/SbnD2DBX+UkjyYXV1STDIg4G1gDksM
 1pYpjrS4ZpbWrHu8KZmHN+KhBwd6e0s6Nw3422rcmBbdLgJuyWa4Yp5VKo6Ssypd
 pJ4D0L/ZLE9JJrLPKhLN2zWl0PYRvQLIZpXz3CsMezQ=;
X-AuditID: ac14000a-03251700000021bc-77-6684e4d19667
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E5.7D.08636.1D4E4866;
 Wed,  3 Jul 2024 07:42:41 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:38 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 5/9] include: env: phytec: renaming of variables according to
 bootstd doc
Date: Tue, 2 Jul 2024 22:41:58 -0700
Message-ID: <20240703054202.2812540-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWyRpKBR/fik5Y0g+/bZSxa1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDJ6Gz+wFJwTqHg6aTlr
 A+Mr3i5GTg4JAROJ52cambsYuTiEBJYwSRyado0dwrnHKPHu32cmkCo2AS2JO1vmglWJCKxj
 lJh7ZRMTiMMssIxR4tyMA2wgVcICkRJXf75hAbFZBFQk3kzrZQexeQWsJK6tXMAEsU9eYual
 72BxTgFricm/nwNN5QBaZyWx8I85RLmgxMmZT8DGMAOVN2+dzQxhS0gcfPECzBYSUJCYvW0y
 I8zIaedeM0PYoRJbv2xnmsAoNAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRN
 jKAIEmHg2sHYN8fjECMTB+MhRgkOZiURXqn3zWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3
 BKcKCaQnlqRmp6YWpBbBZJk4OKUaGKWsb//lm3d/axp34XdhUWtP2/4OFgN9TrutPE56k7Sy
 3VL+uhvprb+lffvyo7j1cksUK+8/uW2Q7fH7R1GkuJFt28KwCQlZq4sPS+gfjmZj9Jonka49
 g+1q7PeVMspbdQxEz1yXWSy0a6Y7T9Ueg4210Urz6v9/CA1+9qhG3j4v/Nm+LutpSizFGYmG
 WsxFxYkAXK/RtY4CAAA=
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

Rename existing environment variables according to the bootstd doc.
Renamed variables are fdto_addr, bootenv_addr, fdt_addr.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
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

