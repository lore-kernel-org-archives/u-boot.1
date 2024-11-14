Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AEBD6A234
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F20B8968E;
	Thu, 14 Nov 2024 22:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lSPUjlJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4736789692; Thu, 14 Nov 2024 22:29:57 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA22388D5A
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 22:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so9292525e9.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619794; x=1732224594;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=lSPUjlJ6XzKIPGW7p2r4NISXJ3gugs9xBoI0JuScdVGY0KXHriMlLbUxYzbLdIYyrw
 5Xi1SL14BuaI1PcVlLN1Sxd+giCHcGMbu2nHA/2HfTZOiGatCrQMzq8LxyEE/qu9kZwh
 2Rfd+krh7Y1ix0iJBVR+9yje8XFj1o1Ne0MTUYvmUlkl57p0y/Zb/y53rxYq267rOBQV
 cl1abOd7DIevUu8lrwzWsT8KvPn/QofK7jPsuc/yarjVM7EvoHmuMq3GNHCIhA2/CTtv
 cs7U5fOZ5aA0bC6Fi7ct5BkE89ABBWrxRNOMYf7kKxHZ2UAFxnY55nOuRDmv2OkCIQkN
 yR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731619794; x=1732224594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtbTU7FLjCl8orbIaLhCYTw3PmzNbPP9nFpN4ROC+FU=;
 b=ssqQDbJBixDplcOwBuhboU5oxw8QmLryE+kdCz1AdZ+3WpDvWL7SnM8x2OC4u6+Hb7
 k+T/oZCQAKxSzy4S5geJBrgpGY8Uu45zCcSmnXpOujOa75VqN3LDjUGc9q1/+9cHJCIw
 xuX/cr6r5quWC9eWMThqMzGlYPMHOWAjdHsm2aJANOKkW4WJ1j3AKOgQV2Be3ZmPy5jT
 80VAmnztPg5Llnms4UV9AFobVn8Z2CtCtexJ8HoumqWNpNDbUsDvSSed/MKDkjcfcQtb
 vjJj2FfaDpUXNRX60PIL7hZLDC5lyKbeomSKzoPEETdV/rwO8dNpks3eegsHxyUrqKSX
 lZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcLgOb0XDB6eFeZUxVQ1cU3mhkU2/9jcxv1XMpPbrS+dDhBOQV6VmCDuSHJcbAT/rWsdN+bqA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw42S4ws3Zp3pIKTemjK2DvNGj9/cGWxYq4SLhzEP4KU/m30UcQ
 ldvJ4EHWrUxtMV0FXBNYoK1AFOPEbFGjTBzvGX0cpidR+FBVpReqoXRM2z9caC1OaOz9IgO9bZv
 b8i4=
X-Google-Smtp-Source: AGHT+IEcBF+9wkrlQEeC5mSKwymVTfnjHDGNZswpOEf6Vm1s0Zqh2lo4x44cfOJGgFluSzI2EJsSsw==
X-Received: by 2002:a5d:598e:0:b0:37c:d11e:949 with SMTP id
 ffacd0b85a97d-38225a0b7e6mr205729f8f.28.1731619794247; 
 Thu, 14 Nov 2024 13:29:54 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 13:29:53 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 14 Nov 2024 22:29:44 +0100
Subject: [PATCH v2 1/5] bootstd: android: add support of bootimage v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-adnroidv2-v2-1-015bffb1373a@baylibre.com>
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
In-Reply-To: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Android bootmeth only support boot image v3/4.

Add support of Android Boot Image version 2 [1].
Vendor boot image is only supported in version 3 and 4 so don't try to
read it when header version is less than 3.

[1] https://source.android.com/docs/core/architecture/bootloader/boot-image-header#header-v2

Tested-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/bootmeth_android.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9..2e7f85e4a708 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -259,16 +259,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	if (priv->header_version != 4) {
-		log_debug("only boot.img v4 is supported %u\n", priv->header_version);
-		ret = -EINVAL;
-		goto free_priv;
-	}
-
-	ret = scan_vendor_boot_part(bflow->blk, priv);
-	if (ret < 0) {
-		log_debug("scan vendor_boot failed: err=%d\n", ret);
-		goto free_priv;
+	if (priv->header_version >= 3) {
+		ret = scan_vendor_boot_part(bflow->blk, priv);
+		if (ret < 0) {
+			log_debug("scan vendor_boot failed: err=%d\n", ret);
+			goto free_priv;
+		}
 	}
 
 	/*
@@ -476,12 +472,13 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read boot", ret);
 
-	ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
-	if (ret < 0)
-		return log_msg_ret("read vendor_boot", ret);
-
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot, vloadaddr);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		set_avendor_bootimg_addr(vloadaddr);
+	}
 	set_abootimg_addr(loadaddr);
-	set_avendor_bootimg_addr(vloadaddr);
 
 	ret = bootm_boot_start(loadaddr, bflow->cmdline);
 

-- 
2.34.1

