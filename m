Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9009FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 15:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E868488B;
	Tue, 19 May 2026 17:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aRF5HX95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9213D84895; Tue, 19 May 2026 17:21:10 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D3A84886
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43acf1694daso1250927fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779204066; x=1779808866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDSdHMzJy/NdvhTx1dk7v7dt+rruTIS+6XPfCA7vLC4=;
 b=aRF5HX95VTq+0zIs3R0aOv1qqpB4sxo7uKi6RnfVmf+5dXz2oIsLezRmyeyfXVGEzW
 o+CKAunXq5kTkckxF78B0dsYMgVWLYdFa0GyHdB+R/SnFQ6N8XA0Hk/ee3yIOvRL5pPz
 ZSWM19CZWM6nVbHpzd1TNWP+wp13GuJMwNdz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204066; x=1779808866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDSdHMzJy/NdvhTx1dk7v7dt+rruTIS+6XPfCA7vLC4=;
 b=ph1ZbmoEfOiUUw6DL20fkVLMbZy3u5kDqfnsYACBr8A9m8N9ZaDhaCblwCMIKc4A0z
 AheBUfKyr/X17NE6+HXH73C5Efwvasn3TIczawO5R9I7r4UM28YrgC1eaM8k87R/Lku8
 QoA3uMJ1r3WyAPBPDj3TSO6voYfEJn9rs2l8TLISqrT0ateICCXUp6Vpr/RwUo5qxE2g
 l+Dcd/rCzXgqqRQHWuLkwaK8jI5QzRlkH18Iixp/kGz8eg6T2CJo69bvSkrFXRnTEHg+
 uq4Rirwk/L8VC7EgwqAYpG6WuYuVta3Q+9/YX52D17wMy5ka/ICLVvqB4XVXsXX44clr
 TKag==
X-Gm-Message-State: AOJu0YwfEkQnxfdAmbCK2/AewOI0q5ihtWtkgDWx5S73LDN8E3zcujrS
 EBwUWsMpsjpMxemT8kIo+oJebzTzG9VO60mGh8ZacclB5iIFqUFBpYFSPlflR6FWM3t3F2BVSTT
 f1W6BwKJ1X7pa
X-Gm-Gg: Acq92OG8gu2d5xbkfRLWkc/4cPcz4FuBg6IbizZLrswJjweeShUYPnPwsgbWXdg74Lh
 dJKNFYAidRJ0X9lxj1I2hICTNZztsvvY52l24T/xW6GAWviAvdxU5mLY/+iz73foydUOcOQDrQS
 x16st0/ppmaC1QojXDt3Rst9lckQHK34E74G3AnSuBHhXnYa4WXV2Aj7omHg+oNRB1Gq+ToPd3p
 fk0FM/L+zYSRJ7HigX4sjZPPQSE3DcTSPdPSeqPvZ1wrDqhkwxwODZTrQ2p9I5C0ZeNOVG4eUl9
 AWrC3lllpotNeQxMKIpIm96eviZSD0JxhXWX0NAmxx1U6uAQztmSp/8/A+lo01oiG6PU1uikDG3
 /5EVN9ER+VSWJOsvEPkYfB0LC685NZ/IUvuSdxNS1FPK+AY230uNLJ8TwNkzo6N4YMTsGolDeT9
 wYawuGUmeHIdjwPjefDNkkVtQxVcNJfgo2NE6ZUl/HRplQ3CVaDRU5VDvZJwV2HTwqrvyW9Ot71
 cuWAr/IWx6FvCxEXvpOLG+JGbSxgHMDcOAxltUrK0mWlVBGxfiqoX2hL+Me6n9tWXtWeCNvupwY
 QrCQdFZ4mQ==
X-Received: by 2002:a05:6870:88a0:b0:430:3ddf:9712 with SMTP id
 586e51a60fabf-43a2db5afd8mr12954056fac.5.1779204065687; 
 Tue, 19 May 2026 08:21:05 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a9576cdb2sm7170167fac.16.2026.05.19.08.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:21:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/5] bootdev: Fix the case where the driver ops field is null.
Date: Tue, 19 May 2026 09:18:16 -0600
Message-ID: <20260519152101.716714-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519152101.716714-1-trini@konsulko.com>
References: <20260519152101.716714-1-trini@konsulko.com>
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

In the case where a bootdev does not have a custom get_bootflow function
but instead relies on default_get_bootflow to provide one,
bootdev_get_bootflow was not handling the case where ops was simply not
set. Restructure the function to check for "ops && ops->get_bootflow"
and add appropriate log_debug calls for both cases.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/bootdev-uclass.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3f8dc2c3c4e6..657804949f8d 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -566,13 +566,18 @@ int bootdev_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
 {
 	const struct bootdev_ops *ops = bootdev_get_ops(dev);
 
-	log_debug("->get_bootflow %s,%x=%p\n", dev->name, iter->part,
-		  ops->get_bootflow);
 	bootflow_init(bflow, dev, iter->method);
-	if (!ops->get_bootflow)
-		return default_get_bootflow(dev, iter, bflow);
 
-	return ops->get_bootflow(dev, iter, bflow);
+	if (ops && ops->get_bootflow) {
+		log_debug("->get_bootflow %s,%x=%p\n", dev->name, iter->part,
+			  ops->get_bootflow);
+
+		return ops->get_bootflow(dev, iter, bflow);
+	}
+
+	log_debug("->get_bootflow %s,%x is unset\n", dev->name, iter->part);
+
+	return default_get_bootflow(dev, iter, bflow);
 }
 
 int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
-- 
2.43.0

