Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53D3C54736
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2297988A7D;
	Tue, 27 Aug 2024 21:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQRQipQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D446F88A6C; Tue, 27 Aug 2024 21:43:21 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAAE88896
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71423704ef3so4767165b3a.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724787798; x=1725392598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvNFitujPQfnMcH2l6g9ek/tsIm33TQBlt2EL4kNVyc=;
 b=XQRQipQTzbOJhmGEIVbHE7zhzVp+4GKq08zzbBylUvcJXMGpk8IJuBW9PBZwUaFc3K
 E9pkqFM7LrMdaOW+9BmeHU1qxyQXSKD8uRaDlfRoul3+sbyu3LcEafFCY2dY42NCRcJl
 vJf3lFrEBPCKQFaL9eh+iQenAu57SW3xWb9yLUIlCU+A790Z3HpLpn3dTCMtRUP6OHmC
 7p8enlxv380RVyiwpx6CJ7lYoiDfcs3y4TQ1W6U/6vKlq0WWr5VLPielutT/lqU2UGUi
 DVatiPGITITwRyP3fJK9E8p2Q5vT9nGuGotoBjJuwv5QC3SGiQLzMUHY9T0Ml/WUVo3z
 qGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724787798; x=1725392598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KvNFitujPQfnMcH2l6g9ek/tsIm33TQBlt2EL4kNVyc=;
 b=cZys317mAvs7UcvAtbOCxF3QD/2La6U4mSoT8b+vbhPnO7Is1poj1oZ8kb6u3aKZlV
 p/dLy1iK0BKoVyx4V4bbm7VkuJxsD5Y9ewVhvDXodKyIh3+fBif9lOP6j0qWZiUlOZZc
 69dJhCIHGCdDzYG5cLKlAs9r2Gx8GaaLyNUd0HTAAGOY8kwMDN/5+udeQTJ8KVgc+9O6
 /yN1J03KLVdO09i1I4gWtzD5k8Tfx5ht6lmgXTkBbdVIBtliE9CyLpN0Xk6UXqfturUq
 hH48cvFYKTS40hM2aAkH+FRANyCc1OucvIFRudwCRfGMKvVG3dyQAAPF/qdA7wYLHce3
 23Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7UbQiQUt/jVOF1x62L/0qiAint1Nz0jeJdo2E5covqwSkrACn2IPQVI8jjxjCxpbDGjwwoKI=@lists.denx.de
X-Gm-Message-State: AOJu0YyqIWc9HscHLDmJj/LgC1W9D5Rg5ELtjOIdTbgI26+2mTvBcQFT
 0ksfP+pd4rnRN/5d46CDGudOwOmPuoBvNCo6w7r4A9BsxsEGnYIRi+5Uag==
X-Google-Smtp-Source: AGHT+IHp3+P3TNKNBa4FEqwV4QWJWiw5LygwX/UlRH+ctl0EQTRJolDYHhH4ANk/0ivZKAxfTmmKmQ==
X-Received: by 2002:a05:6a20:c6c1:b0:1c3:b61c:57cb with SMTP id
 adf61e73a8af0-1cc8b63e7admr18180795637.53.1724787797985; 
 Tue, 27 Aug 2024 12:43:17 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9a82:cd38:57a9:3c17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9acabccasm8311218a12.27.2024.08.27.12.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 12:43:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 2/4] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
Date: Tue, 27 Aug 2024 16:43:05 -0300
Message-Id: <20240827194307.2933299-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827194307.2933299-1-festevam@gmail.com>
References: <20240827194307.2933299-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Just like drivers/usb/host/ehci-mx6.c, add a default for
drivers/usb/host/ehci-mx5.c.

The motivation for doing this is to remove CFG_MXC_USB_PORTSC
from board config files.

All the mx5 boards, with the exeption of mx51evk, define
CFG_MXC_USB_PORTSC as:

 #define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)

So move this definition as a default into ehci-mx5.c.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Change since v1:
- Improve the commit log (Marek).

 drivers/usb/host/ehci-mx5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index 44912de7787..d8f521befe1 100644
--- a/drivers/usb/host/ehci-mx5.c
+++ b/drivers/usb/host/ehci-mx5.c
@@ -79,6 +79,10 @@
 /* USB_CTRL_1 */
 #define MXC_USB_CTRL_UH1_EXT_CLK_EN	(1 << 25)
 
+#ifndef CFG_MXC_USB_PORTSC
+#define CFG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
+#endif
+
 int mxc_set_usbcontrol(int port, unsigned int flags)
 {
 	unsigned int v;
-- 
2.34.1

