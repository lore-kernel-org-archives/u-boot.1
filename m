Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F0DCD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0DE848BF;
	Fri, 12 Jun 2026 14:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NCp7gAZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01EE8056B; Fri, 12 Jun 2026 10:59:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF12E84664
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490afc47455so2819605e9.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781254762; x=1781859562; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6bpEm9BvpA0Xw+ack2QNv8+Mf+suEUdpQrtrg577tyM=;
 b=NCp7gAZRCL/1/5e5lNYcyi3ipaP/+NHM8y0GfaBIeMvDjgn+sUKkMZthRTf3pVrPz5
 XVRSfw7WDO8owg9VL1Lm3bZZ863NdZgZkqNQENHDfdnA8D4xqwMSi5tJSfnalzAABR80
 tR25Cg7rJ+N8kQ3xigrMKUHHI0Ov7lqFcZ5XBATZHOczfo8PQLe8/Fd4Yq+AO9FOwtqQ
 z8R9Dzgilaz3GtQ5UwjeZNI38YHwXsI0X4FG0MdLBY77EH5gORTw4/2uxcj307IMoTYk
 shHLfKyYOWnT5I+gEsQOJD4VIskGEZhleEg0MXNfMuZwYVDZB2fRAGCGcHDa/8GyPENi
 tucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781254762; x=1781859562;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6bpEm9BvpA0Xw+ack2QNv8+Mf+suEUdpQrtrg577tyM=;
 b=hkxT7LBCp7i9oPqE0PQamFC//RiobXIj3/YmwKxxo8oYgw40XCtubb1GXaDXhODVHe
 BaCYvlT7rJH17g/zPbzfHgAt9BWla2jW9kFD2b2wT8HtrVo6ggqX8p3O3V5nBI+Y0Ver
 SQqteDhQnttrw5eR3vtMIH3NCu2+Ll7elbmYejjHasPET14EYnv9boTeSazN6D6S9KY3
 Vxc4rRC19pcadwy5FX1++huoiYAU6mDWXCQvh38YFlDIDsgnwb0RpzoAd2sVV3vdBu1m
 KFXq6sVlo4WMyZAPHBKPGVt1qavhrwwwarjnJod4FtW1gNgfkXZC7SaCzykuDfohYpLe
 yKFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0rudI0BoOQmyb4NG+HYVhJoJOhIWF33tV9UEGni8c+0ei9k5tjUZIV3b3MwFMuln5YvGZf1s=@lists.denx.de
X-Gm-Message-State: AOJu0YwzW4xD1ydM5Q4UNBwfSfmPnRWKVrS22KaCjQG07BWvGpqYhaCx
 eTkmOwTyCFLFccyhvNvQQMocmb2GVe1lZUgDeM5DrDGkjTAx9RCqiM7LowmMCX2b
X-Gm-Gg: Acq92OE2EfCCrebLCc5Dw96XIIeLSx9CS5G1v5crssca4FCzTSb6xbgdgcPuYPajtUg
 RsAHIReLTLjSS4hmh8sc6XY36pAIkcpMIqVyUy9lL5hwuO4a2ehtrvAeHw9Ce4whSezxsU8uaCH
 daRtbGe4wcvvVhfzhN7BcznhpTfPYU0JMC5LKt2sb0K1ICkRJlXevanbhzUly9fofZnUEkNjaWe
 n1+Q96FUySyF+LxeNR7bWO61hPJWi/Rk/OAscddc+oHa+H+nQxmYvdHDVILZS4p/NTo/EaP6wgg
 aO3FS/hjkrf3HcL3SW5nX8oUSJOpU7DutyAYh2RY0fjN7RESEVBqPkP7js3aLKS4ggAXetUirQs
 fJa++ud8A1ueCNQ2PnClBsXLrR4zDCyvt4hpZxhFxsMETaVayMQikFhWbHXDafI2RiX1xedEwCS
 MXqVSMwKRbh+psMLN1lXJKBVRazBas5L7wUl83SbnpSJ2H3G7+T1OmsFzZSMaj6eaPKcqaQgIuM
 N98bWHPrxwdbbbNSwkkuRA+N1GvAEg1ydvUQ1kj0Kn50X5FUyPTIcaVnvbNbkW1mNkkU5e8dq4q
 yd6qKaKjQJW+
X-Received: by 2002:a05:6000:1a87:b0:460:1755:160e with SMTP id
 ffacd0b85a97d-4606dba1c44mr2907207f8f.33.1781254761987; 
 Fri, 12 Jun 2026 01:59:21 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm3976896f8f.11.2026.06.12.01.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:59:21 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 12 Jun 2026 10:59:01 +0200
Subject: [PATCH 2/2] configs: verdin-imx95: enable PCI_INIT_R
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-fix-smarc-verdin-imx95-eth-v1-2-851197b36dcc@toradex.com>
References: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
In-Reply-To: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:35:35 +0200
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

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the ENETC device on iMX95 is not enumerated before network
initialization because pci_init() is not called. As a result, no
Ethernet device is registered.

Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
for the Ethernet Controller to be detected and used.

Fixes: 60d8255d8dc0 ("board: toradex: add Toradex Verdin iMX95")
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 configs/verdin-imx95_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index ea1ebb0c492..daf41a8b830 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -45,6 +45,7 @@ CONFIG_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y

-- 
2.43.0

