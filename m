Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB726C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 23:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5EF884C3;
	Thu, 27 Jun 2024 01:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719446356;
	bh=ik6jTz7Wn86liTSjIjh6ryzPRVpdwnbb1+rEP2z4KIw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N72aNrkLOzIL0wj4bDvhU81FbcgAeK4z2CeSUt32GoHx/B4r7sV6ah8LmzI512hMp
	 jqDQraMcv3rzIPS+SmsHKVajZT7uk2KOrM31WV1iIfw9qdJoI4TxS7potcu16O6cgp
	 AFqgfdbs+1vlYZrzMXppXvhBqMBXpalGXFth1Oq5PT3+vFX9StJfAfzoz4oklhmK0Z
	 A71kEa2oiedzeJBLnfnpXjT8bZi9tdK+BfrWZnjNiJCkPtV3VTnNShAOobH7RFXhO5
	 Ol6XlaOU81SEKbzOgQthZKw92obC0+sIHQhOAKSkWJQ4I6ykEUacxKXJXmx/C5Ofmz
	 26Ax5YNC9xJHw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1957B88495;
 Thu, 27 Jun 2024 01:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719446355;
 bh=ik6jTz7Wn86liTSjIjh6ryzPRVpdwnbb1+rEP2z4KIw=;
 h=From:To:Cc:Subject:Date:From;
 b=CTqyGLglo99SvF9fqbLVdSgSYJDMz8kxNRfqLsKrK8MFGMDurc7kuy8b5vI+QBb8L
 oUy+R05dzhkuwJB/UbFHiMr1iOuajb2NdjWTrJIfdWOBNxTyAaeDZC9bN5kApPpRxF
 0TEa3mPNaNkQ0xCtE0XbcoRJUWa/ffXftw7IT0EDQyIFm9Ddp40JmU307Lj+Qp329V
 /fPTiEk+ijN0Dtq1Eb2ajeE/wHxJfCyERP00tjKNovA2/INC4V3Vi8QNWlq0+2ytoA
 Kpr4A2g/QzJlKqjbK/jXYJ9gLH2TsJzMUN4+IMDCA4Q8hHZYRgKW8grRn+6T5ehXo1
 0nJsU+lC5voPg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
Date: Thu, 27 Jun 2024 01:58:02 +0200
Message-ID: <20240626235857.272264-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Insert /u-boot,<dto-name> = <index> property into the U-Boot control DT
during SPL DTO application process. This can be used by user to inspect
which DTOs got applied by the SPL and in which order from running U-Boot.

Example:
```
u-boot=> fdt addr $fdtcontroladdr && fdt list /
Working FDT set to aee9aeb0
/ {
        u-boot,fdt-dto-imx8mp-dhcom-pdk3-overlay-rev100 = <0x00000005>;
        u-boot,fdt-dto-imx8mp-dhcom-som-overlay-rev100 = <0x00000004>;
        u-boot,fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast = <0x00000003>;
        u-boot,fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast = <0x00000002>;
...
```

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 common/spl/spl_fit.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 988125be008..261b72419b1 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 {
 	struct spl_image_info image_info;
 	int node, ret = 0, index = 0;
+	char dtoname[256];
 
 	/*
 	 * Use the address following the image as target address for the
@@ -450,7 +451,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 
 			/* Make room in FDT for changes from the overlay */
 			ret = fdt_increase_size(spl_image->fdt_addr,
-						image_info.size);
+						image_info.size + strlen(str));
 			if (ret < 0)
 				break;
 
@@ -464,6 +465,26 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 
 			debug("%s: DT overlay %s applied\n", __func__,
 			      fit_get_name(ctx->fit, node, NULL));
+
+			/*
+			 * Insert /u-boot,<dto-name> = <index> property into
+			 * the U-Boot control DT. This can be used by user
+			 * to inspect which DTOs got applied by the SPL from
+			 * a running U-Boot.
+			 */
+			snprintf(dtoname, sizeof(dtoname), "u-boot,%s", str);
+			ret = fdt_setprop_u32(spl_image->fdt_addr, 0, dtoname,
+					      index);
+			if (!ret) {
+				/*
+				 * The DTO itself was applied, do not treat the
+				 * insertion of /u-boot,<dto-name> as an error
+				 * so the system can possibly boot somehow.
+				 */
+				debug("%s: DT overlay %s name not inserted into / node (%d)\n",
+				      __func__,
+				      fit_get_name(ctx->fit, node, NULL), ret);
+			}
 		}
 		free(tmpbuffer);
 		if (ret)
-- 
2.43.0

