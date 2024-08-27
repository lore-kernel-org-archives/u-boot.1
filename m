Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C689FC5472D
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 00:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975F988580;
	Tue, 27 Aug 2024 02:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BPJgqAiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB67F88915; Tue, 27 Aug 2024 02:58:41 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C339A88770
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 02:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2705dd4ba64so3452930fac.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724720318; x=1725325118; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg1deV2nTeGTAtxyIUKxwPNcAWal0Jwy7T3e9JThlow=;
 b=BPJgqAiqHR6J1FQtqDW3O7jqJtlD7L1rljqQrQL9XC7a3/aRGRdo0f/3j2no6Nh1dU
 AgqMrXZiDzjnp67tt0cURk5V/EnWSaFfEnPGha+WhFh+PbONowS6bjY51+X3c84pFS8Y
 snNXSPhsJoihL3iekSi736rH+2GtDR6w8+2yfGjHa64Nc9EDmN6FYSe+lGzuS4Q79zLy
 BFbhJ7R4fOE+ic1bTKr1z+eGqYR25joY3sMLUmvLsUW3An0evYfTClwuYZl99rHolA/X
 TqYJhay54D4Dcjf0+TiA+18aMFTTFjNlGoA0BSbYzhb9eGNKqCQSlF+d6smO34SzXgpf
 4xZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724720318; x=1725325118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mg1deV2nTeGTAtxyIUKxwPNcAWal0Jwy7T3e9JThlow=;
 b=I3PHg3suBMMwMSAXdiS+dttPCHkd0s1UPubiABeLQyoS2DgapS1iRjSbib8QLGdvLi
 hwg+VumRMIz4x8ynGY0XI+TTQiNnaVqEd93p8eYAnQOvoPptc1bpq5IAQdmFO5n6JmwY
 lH44GPTGwNQzzbZJGO0kt5MW9zI7ttrbQW/d6SuWM03Dt8FNNGgYOrkiOpxh2XvKevIa
 KV7wPOQOYXuw9iKjsc6oCBuwEKSA0UIQFeH8bb6IEYmXM4zyZFJotT+MuR6YhYVfQTqE
 qTe66o38WgOZaLOX/XL7ckJp9MTwZGoU0nrEaLwRzT81CO4XZV/3dYJFOazmUK/SH9WO
 sOyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB+LM6RAoTfTIAoBrU368AteZy7k4SSAkCpdTi7+n2Ce55M5EJ4DYDBvO0kyU55UKI2KIKtEE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8viV9i3HIrDJEBvjVF4ks8BY8kVQh29trwjTXLCKf+cDfASfP
 xlZOE9RCJ/grs3rq9d7ZTNpBA3alvBBYCgd1ldvkoIpE+1a+wcyc/eCgrA==
X-Google-Smtp-Source: AGHT+IGvl0E0llSbLLPe1a5qCLbcBdRj45HjloXf4aVoJ2f/HvtkDP9QT+Y2DtBHIRIoyWvqUAddew==
X-Received: by 2002:a05:6870:80d2:b0:260:8f6d:f01f with SMTP id
 586e51a60fabf-273e66f42c5mr11279681fac.39.1724720318381; 
 Mon, 26 Aug 2024 17:58:38 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc67:f2c3:ca16:906f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71434254057sm7560311b3a.77.2024.08.26.17.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 17:58:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: marex@denx.de, u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/3] usb: ehci-mx5: Add a default for CFG_MXC_USB_PORTSC
Date: Mon, 26 Aug 2024 21:58:24 -0300
Message-Id: <20240827005826.2831478-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827005826.2831478-1-festevam@gmail.com>
References: <20240827005826.2831478-1-festevam@gmail.com>
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

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/usb/host/ehci-mx5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/ehci-mx5.c b/drivers/usb/host/ehci-mx5.c
index 44912de7787d..d8f521befe14 100644
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

