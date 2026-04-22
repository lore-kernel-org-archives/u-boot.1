Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9058FFA1FEF
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 20:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B9584309;
	Wed, 22 Apr 2026 22:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DnaE9JE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B1484370; Wed, 22 Apr 2026 19:00:38 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A791B842FC
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so45864165e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776877234; x=1777482034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAVXVUlM7Q9D8WAUH2c3K+e6DOL2+EccKKlp4o+ZPLg=;
 b=DnaE9JE9vuU5nfL8/y2j3iWMPHJ/TDiFZ+aA1Pq9evRveACAm3UGjU3uzhaOxRocp9
 vJkMBeUIdTxGDmNRWcJgw8QHqqf0VCQPyvZLd/X4bbM51tFvvHYCNexVsUNCndyXhSE0
 5FbGM7mHVPyyMD6GLmvtZXQ8wY99kVF+hZUtZR8HEtIPVuxkVoI0i6A7eT9ShfXhzjra
 +TdExOILzkk1xcTD9il2yGD3UtDFtTOejKnCqIMw7Fm75FtsHzT/10LD0pfj/kmrtOSW
 L7GIVJH3CmqTQDMIib4gO/NGPhRIVpncgUfsf9a3rRz/mBxfX3BN9dFRjHpY8PUePSxn
 U7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877234; x=1777482034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sAVXVUlM7Q9D8WAUH2c3K+e6DOL2+EccKKlp4o+ZPLg=;
 b=FDc1GuLbTUKDLDbKtKfKmSQLdIKzoxbZkslIBfKEZ6eOgnt1Z6UnouxO4WBLscONME
 GV77n31Zgknl2gGow9Q3bxI942dNUqwjNjyxB1IFzCL02rWBYVoaW7PGCd/obRhCoHwK
 y8QxOHP+JvAdUmw5x3IFOAGgTI2KL5f+AEcNOLdRplPiszcrqdqF1mdVJ9DPFJm1hCQa
 alEUg6cb8QOzK5JLGIaA+YtRUsJs5OOd86fNA8riF81hYeGVBD21ZOOTdCx2AXduYEjk
 f5A0V+p+pYjJiihpVHWpPa9KHkQtp9A/RrAvswThiLKNxeX388W4cIZ/P33F1DQYNDvz
 s4gQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81oUw+rKOAxT07y1B+hi6zBKRqYuFV4q0xA92pDFiyifwAaf2OvvWlfaORfNByngKh+FlwiiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0JMBSDffHETVG1LU6g7wh4j3VJ8FVH0FjIV0yLjB1UGnxmzzw
 cepVH775ksRB0cUE+3OipwMqHUVllFGu2HkKQB/A/XWjG1RwC/fs5Dcx
X-Gm-Gg: AeBDietsP4GTqtTUS7yiFPa/7eWmIj7Qz2dO0eUxoLeYBGX6cq949hPz0JM5HN5aWGi
 zZ+im9aeQtkiGBrYqIaooOo+HZycC9Rm6TGvqnEK132BWJtgU20F9/uNZkzl9/4LW8BrJTYl2tQ
 +rkv5bH5Hu6D8SQLtKQ+qrWTfXsmuliTy+Id8mVf8u3eHed1m8CccWCmJ6N0l0Bcu7JbM5ot7vY
 VYw6+ZZprbNDwtgC3eXjV6QuZtYYa10oUTMQuJsY0MSN565mx5ao4JjI4okpl3ZRsWjWdl9VlUg
 j3K0PWGsZnbTVJeCiL51QrQU7fF5uny+ZBMlPxbAsAYUrpKNvWmGrRenuZ54QYRiRgIDmC4WapO
 7Qrp50XH7xiN7js9ZWuJrsrtHSyqLwQZ6/MuurcWfLnOxba7oDz4iqHgq/8GwvVqF5ePP1qoGhK
 trq+wapu0ONE6UOuEumxvH/jBpJHVLXEjWSVvtYGxHM0kVlF09rsI=
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr346236835e9.28.1776877233845; 
 Wed, 22 Apr 2026 10:00:33 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm453725165e9.1.2026.04.22.10.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:00:33 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v4 1/3] usb: gadget: rcar: Fix gadget registration lifecycle
 in remove
Date: Wed, 22 Apr 2026 18:59:36 +0200
Message-Id: <20260422165938.35925-2-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422165938.35925-1-micbis.openwrt@gmail.com>
References: <20260422165938.35925-1-micbis.openwrt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 22:21:26 +0200
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

The driver currently fails to unregister the USB gadget when the
device is removed or the driver is unbound. This leads to dangling
pointers in the UDC core and potential memory corruption.

Add a call to usb_del_gadget_udc() in the remove path to ensure
a clean teardown of the gadget interface.

Signed-off-by: Michele Bisogno <micbis.openwrt@gmail.com>
---
 drivers/usb/gadget/rcar/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/rcar/common.c b/drivers/usb/gadget/rcar/common.c
index 2ba022a3f2c..f7b34f0485f 100644
--- a/drivers/usb/gadget/rcar/common.c
+++ b/drivers/usb/gadget/rcar/common.c
@@ -447,8 +447,12 @@ err_clk:
 static int usbhs_udc_otg_remove(struct udevice *dev)
 {
 	struct usbhs_priv_otg_data *priv = dev_get_priv(dev);
+	struct usb_gadget *gadget;
 
 	usbhs_rcar3_power_ctrl(&priv->usbhs_priv, false);
+	gadget = usbhsg_get_gadget(&priv->usbhs_priv);
+	if (gadget)
+		usb_del_gadget_udc(gadget);
 	usbhs_mod_remove(&priv->usbhs_priv);
 	usbhs_fifo_remove(&priv->usbhs_priv);
 	usbhs_pipe_remove(&priv->usbhs_priv);
-- 
2.34.1

