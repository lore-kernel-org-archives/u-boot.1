Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA0606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oZMOn+UV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jU0NEgE5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A246C81309;
	Fri, 23 Oct 2026 11:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSZ1AkXUEipk; Fri, 23 Oct 2026 11:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B7CA781316
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754183;
	b=qg7AIRnF61C7hzQaDV7T9wDp07ut8gFhfRdURcW5j6r0uza+ScqnqWWGL/noFo2ajr1y
	 /nI1bXkhFydAvPKRYnLZjUaCPfss1Bc3DFbvK9re99KHCScooybZfonk+0PrYgCRIxTpO
	 aICvg2lOMi4epjN/cvg/Zm/5jxszDjwznBdOPaGmZkjYYGgWkLNtqasOlyo16yK2YbIMp
	 gn0F3h7dQwjk0UUGS8RT6iWhuKcuMELfoKGHIVF1Y0AC++OhWBY7JPTruryNdc22eoIqu
	 Gg7iUNZLJaww7RHHL7fkGJYe2aA44ZfwWXBbtxSKXUBYrOGWIfcXMQkbK2oPIlp/kzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ubaKGwpgSBGM+kTZ9g2iSr2nvIyPPNs0jiciLEZ114I=;
	b=qWVwjTd7rK15pW1eToylWFH2QtATJK3KKbVSpsfQ6Kz1doJ/Bwl+wf76KByMjFe2zGJQ
	 3VjNv4XHs9vj4WQ6E+5dzj7LmOsKu3l8jQpXNXgu0f3UZA9kbGLR6B7PvfvaKW2wTpHvb
	 FL7hPOUirnLqiGnHR0ELu8/zZLrB2l4txpY2YQBo6Pce+IYABoS4a+wW5xxWPdcLWE4BS
	 s7L8MK1nYCqhlUdqFrQ55iXO8AwLedhBaOhmbc0TKUU0R1+C93r4sUyo4MreBEOQVT4v/
	 D3VuGz+EqmuCK5llLp/2rmleu1lpPWhNJv0PzlEcjXZs4bPvnhnw5zdJaFKCoOMhPVQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jU0NEgE5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754183;
	bh=ubaKGwpgSBGM+kTZ9g2iSr2nvIyPPNs0jiciLEZ114I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZMOn+UV7weeSWYYJSqEtSF/K9PJ77y6kRc2FwAFlb6xiXFPX1HnzJZlP14/0/++Q
	 +gwBCB/so/wfDZ2oljQQ59J/YOrI2jEu6nAgCXI57wChVIIUhXTF5lEjJ3W5NvsI7J
	 1T5Hag6xz2h3M3WltolGcWrQlW01kfmSuNH8zCryAVD6TqAE+5SrQnLuWmalU8fQe3
	 VOJsE9tBRa1q27P7IWU4lLnuNPyjOIMGW3wTR0h9ZTzivclC/4NKKM/hdfru3ABTt/
	 PcIu0IkpA//tH/c7zYFil64YyvA0urGlG5K2PVFtzww3YYepXF0fOx/7ZeymNs0sf1
	 sSngi8HuVCzvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7CA781316;
	Fri, 23 Oct 2026 11:16:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C1F1B02
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B5AD81281
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWO7fWSTAiux for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E7F481205
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754171;
 b=R2vJYOydIfS9D814o3bZbt2ISlNLzRDjVLxhrfb7gZRhd4AlOgAchiRCZ2eeU1UrPDuM
 atJWftM1uMX9xZHJXpLVmKz92593La0kmeV7DL9+A/BJDV5ppbY9FkWWI1YbgBQ0qDn+7
 11ecBcmylG76XTaYqosAhHnOJKzItslr6yB74q8m8MyKfRe8QERXG1obo2INTKkFOPig8
 5rJfsHY6QzfClQm3Dy6VISiG6sNbu1eT4cafNusdAJ7a5Ch7oFhtxguNuFSOPH8yyVj/I
 4zVgJQbF4vnZKSq22gDNnVNd1Eojx+dpLQCxJ1PV80kOWdNhY+KD54fDnV27vhZ00vQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754171;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=ubaKGwpgSBGM+kTZ9g2iSr2nvIyPPNs0jiciLEZ114I=;
 b=kTGuSTiGT+rO6UPaGVaGfBSxBs+cs6lBUYS3//PGxoF0qq6qCZXKC34QGpVb42vYJuzU
 3nIjUtaef21E6o/WrBdsXYwFPU/0CnXKYPbW1iQiDMzDnxYd90HWsQXTJuUcgUZs4j8nb
 zMA8PsZ87+OBwYEmhL34y7sPiIDf+PRFT3+efIOeUgFh5Un5/i4tV1NNrazlOX8a0110h
 QEsrX+wcq9hywbc4Ix+uZ/SxwFQM9maU165AsKHvXaMf5r6u8DL0YI0ybAfHTuvdzFSZE
 R41z81/xkCjSmltxa3I0rLg+OrLPwVLzTLrwunVl5HsV6MjjwxvKqrWkgSYIlFo0eOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jU0NEgE5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jU0NEgE5
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E7F481205
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a20b122af8so6490855e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754169; x=1793358969;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ubaKGwpgSBGM+kTZ9g2iSr2nvIyPPNs0jiciLEZ114I=;
 b=jU0NEgE51ghduvPcDFdjksho5RZqNNZOFea0uy+BUJyxpTcYFmFPmNRtnFftiASpB8
 rf0qL4QTpq2zIQLxr32SidORhFrtZ30vQrY2lDLK0ZDz1Zbr8ZISl9n6POTedwGvUHVq
 RMsoNzicfynS3MWPFj38N4/a/6pO+P0md2VFpiLMcUMqVcKdvSRg9IrHCKv+DWsOp8F5
 HF5OK+MNcBY8PigjaaQk7Ryf8lyu+bCBLF2WnAmlKDNp8MOfLgRTsanbpB3R9uWn+7+H
 w8q58fF1YhbOqjlwYzz0Y0nPMC+yvWaqUfF7TXN/7as0cHEdDgAdKmX1L012CVpNUJSf
 rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754169; x=1793358969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ubaKGwpgSBGM+kTZ9g2iSr2nvIyPPNs0jiciLEZ114I=;
 b=2bV6JGLrVSW/NuMyUGW/gImEV3ycQ0l7mANswq4ZmG7X6Z/SaHznTgbCYPQ/k6OiaC
 CHdNcQVqFHMiLPri8gzWy696SGyn0OYqvnWp92YprPLWCwl9JifaQHI5x9kT9rM8LB2n
 7ufRo1zwLQ96slrnx/42phSFZRSRPP8a5DpRO41ysPP+IoG+2vJm+Y1fi5PYa6Pq3F4B
 VDKM1ITXT8a70IljQEe/trju3NSy47l2dvoGMo4xRxxkujZsivu4cLlsMN9uIO6JOZEL
 M8SG263XvQLI7QW+m/LWBva+kvpJRsUyTge01F5Ic9kIwA/wXy6Dv29UOmJ/Cya1Ru+n
 8tew==
X-Forwarded-Encrypted: i=1;
 AKwUvByenQi2JRJq+sR3BC/7aKm6Ewutfp4gv5SeO2XBidqqLqfPe4R9LROKl2o2s2HOxm2LrdPHb1A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJkMs3OSLNmF/cmy6LVxutcWqwfTSsDlsH2xcnDC0a8LK8FCjnM
 5qHi6sF7gsyoY4lPlW5CBczTQ/wfRoZHjZYU/l4lcf3evGsD+U4QEg8xlOGBj1oK
X-Gm-Gg: AYBFou0Cd4VjT5Y1WEEW8aWHk4AG2/ce+G1Rj0vsoeY2aMcs0mgdgJ7fRQST5Y+2nGC
 7JXDLj23Vksf2i4a5T3dKQ4wy9Vk5QFSp+Do0tCBJy6Ba2GMpJYdM8DFOz5Br5U2BRR7jnxaEnD
 Tr4yg4gHGmDGnJohi0Z1Mty+RxkqfvwGlUeP372L60LqqvoqxWpr6fuPgeGiswJ2M2S/PNbcmVB
 w4LQ8cZo2EB0JuMdavQyyVUhyU+Ly2eIlxoTcTC8aKfsucrtVnDHbdz2h3q+9h4x+wAvnYSfqdN
 dSqvYuHa+TBLZ5XKwwVGGkSvtYwY9Cm8Boe3HgTieAOPs8rsCenlf42DzjN/ASZRd/85XznPhPi
 TdBe/eqZJjUDWNX72BFM+YnuA3P3jBehFS7myzPW+RLtRGG0HHe4qmiM5IMt6Q9InAHJOStAGFG
 4PQGIiBtgTg6DEVbYVEa285St6vn6WvhmpO76cRh2XaQNtkfrnh4JnVsv9H7TgAJvjd9HAi6hRY
 WxPEUPbv7zooG4ZnpOqSZkPBJ3CjHmOtytyb464u0bDLrXpM27ZcqgGlPzsgZ4=
X-Received: by 2002:a05:600c:6216:b0:4a1:71e5:9420 with SMTP id
 5b1f17b1804b1-4a211ee9c4bmr28208645e9.13.1792754168764; 
 Fri, 23 Oct 2026 04:16:08 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:08 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 6/9] usb: ehci-vf: request the ID detect gpio through the
 device
Date: Fri, 23 Oct 2026 13:15:56 +0200
Message-ID: <20261023111559.4081795-7-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The ID detect gpio of an OTG port is requested through the flat node,
the result is never checked and the gpio is never freed: a bad gpio
description or a failing read silently leaves the port in device mode,
and every probe after a "usb stop" fails to request the pin again and
reads it only because the failed request left the descriptor pointing
at it.

Request it through the device in the probe and fail the probe on any
error but a missing property, which keeps the port in device mode as
before. Free it in a remove hook and on the failing probe paths, so
that the probe after a "usb stop" can request it again.

The flat tree access was the last user of the global data pointer:
drop it.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v9:
    - none, rebased on main
    
    Changes in v8:
    - Reviewed-by from Marek
    
    Changes in v7:
    - new patch, split out of the previous one on Marek's review
    - gpio_request_by_name() and dm_gpio_get_value() are checked; only a
      missing property is tolerated
    - the gpio is requested in the probe and freed in a new remove hook and
      on the failing probe paths, so the probe after a "usb stop" can
      request it again

 drivers/usb/host/ehci-vf.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 90840cea92d..52ec83fc485 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <usb.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
@@ -37,8 +36,6 @@
 #define UCMD_RUN_STOP		(1 << 0) /* controller run/stop */
 #define UCMD_RESET			(1 << 1) /* controller reset */
 
-DECLARE_GLOBAL_DATA_PTR;
-
 static const unsigned phy_bases[] = {
 	USB_PHY0_BASE_ADDR,
 	USB_PHY1_BASE_ADDR,
@@ -162,7 +159,6 @@ struct ehci_vf_priv_data {
 static int vf_usb_of_to_plat(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	int node = dev_of_offset(dev);
 	fdt_addr_t phy_addr;
 	ofnode phy_node;
 	int i;
@@ -207,18 +203,6 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	if (priv->dr_mode == USB_DR_MODE_OTG) {
-		gpio_request_by_name_nodev(offset_to_ofnode(node),
-					   "fsl,cdet-gpio", 0, &priv->cdet_gpio,
-					   GPIOD_IS_IN);
-		if (dm_gpio_is_valid(&priv->cdet_gpio)) {
-			if (dm_gpio_get_value(&priv->cdet_gpio))
-				priv->init_type = USB_INIT_DEVICE;
-			else
-				priv->init_type = USB_INIT_HOST;
-		}
-	}
-
 	return 0;
 }
 
@@ -258,12 +242,27 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	if (priv->dr_mode == USB_DR_MODE_OTG) {
+		ret = gpio_request_by_name(dev, "fsl,cdet-gpio", 0,
+					   &priv->cdet_gpio, GPIOD_IS_IN);
+		if (ret && ret != -ENOENT)
+			return ret;
+		if (!ret) {
+			ret = dm_gpio_get_value(&priv->cdet_gpio);
+			if (ret < 0)
+				goto err_gpio;
+			priv->init_type = ret ? USB_INIT_DEVICE : USB_INIT_HOST;
+		}
+	}
+
 	ret = ehci_vf_common_init(ehci, priv->portnr);
 	if (ret)
-		return ret;
+		goto err_gpio;
 
-	if (priv->init_type != plat->init_type)
-		return -ENODEV;
+	if (priv->init_type != plat->init_type) {
+		ret = -ENODEV;
+		goto err_gpio;
+	}
 
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
@@ -277,7 +276,17 @@ static int ehci_usb_probe(struct udevice *dev)
 	hcor = (struct ehci_hcor *)((uint32_t)hccr +
 				HC_LENGTH(ehci_readl(&hccr->cr_capbase)));
 
-	return ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	ret = ehci_register(dev, hccr, hcor, &vf_ehci_ops, 0, priv->init_type);
+	if (ret)
+		goto err_gpio;
+
+	return 0;
+
+err_gpio:
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ret;
 }
 
 static const struct udevice_id vf_usb_ids[] = {
@@ -285,12 +294,22 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	if (dm_gpio_is_valid(&priv->cdet_gpio))
+		dm_gpio_free(dev, &priv->cdet_gpio);
+
+	return ehci_deregister(dev);
+}
+
 U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
 	.probe = ehci_usb_probe,
-	.remove = ehci_deregister,
+	.remove = ehci_usb_remove,
 	.ops = &ehci_usb_ops,
 	.of_to_plat = vf_usb_of_to_plat,
 	.plat_auto	= sizeof(struct usb_plat),
-- 
2.55.0

