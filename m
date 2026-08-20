Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334D9C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 10:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B97E80CA6;
	Thu, 20 Aug 2026 10:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mU0K0Es1xLJl; Thu, 20 Aug 2026 10:25:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787221533;
	bh=3GwnPHvjOLS0V0a6i98x6akFCazp75i1WwUNxtuEXto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oZ5vr190Y26iBTt7lJw/GbqxELAR4EA3oSutT8Ul2XA1O6dPHSYWpOZm3C2fdpjOW
	 eqYmBTwDNaDGXmQs9rMptQhhm5g6sRiK8WYychBNxDjbk6d99Xxb9LMsP5No5SLNzB
	 VsHWQy5dBM55azYaU1oLnTr8n2+f5STj85IiBIir2+iSYHVeeqQ7bebr/oIADAFGPn
	 44rb3rrDtlwFkgG/bjZexQ/p5ROORArXcLK+Nn6IR12NhAuOXz0tjglkGH2EY3cyP1
	 cAqRhsSSy6rcbOc3AslN7Nhh9sTat0tTSvI5qISe1Jqkrq1wnJMBlm2cTZh1xHRlHf
	 21Omi0aWhWmyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0E0580C9A;
	Thu, 20 Aug 2026 10:25:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00AA929D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E678E60739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kx00NAcL3Mjr for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 10:25:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kqBNRQyX
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00F4960656
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso24468575e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787221527; x=1787826327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3GwnPHvjOLS0V0a6i98x6akFCazp75i1WwUNxtuEXto=;
 b=kqBNRQyXmjav5OTHNpjdCbxmyNstnIRFpF+KTHG9rCAkzDj9uDWEjR5NlvcSaMTUg8
 tcGvWuLo9BW3xgnpn/gEe/FWgxaBKxCnx0PpAsdc9ZjCc0vEFgYevQYga6Wy4h2SKCPp
 UlTdG4QiWy2JQL5jO9mwWsFe9zYIhpXdFsTtz+/CXDxh2NjR/uycVmsQg3d1teSSUvdW
 yDyZYhfo7iTQeIo6HIED8+Fh70uGMcJzkeJYryRobk16v/KF/f1sH+m5c9CSD/rGk0ho
 aMkjOwhDMGV3OOTAu7OnULnEsHSIYSLld4j3gq7LyPitXezDujJuyBqEh9yVM42cdnpQ
 TiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221527; x=1787826327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3GwnPHvjOLS0V0a6i98x6akFCazp75i1WwUNxtuEXto=;
 b=jICHGiSf+mz6HYvP3e5aVueWBTjIjdVQ/LGZpaUPIK8VpFZdZP8ZIW72J6mlPhcI1y
 IOdbRVsOpGzxPy/kzlgZ0To8TZBjdOKMIBRAFIMe5x7Fthu3H0OqTXTEgOvVhvumCEkE
 GwJp+1CvZAhFXteGSztZOKOomX6Iq83DXM2tN0T3Gswy8qxsT1SBWvR4vt2JJ4ZtYsh2
 bi868UWXAdbE3QFHVZIIvwo3Kt6MQHOSZxeWgp58/jnBf0kT67OGQYNssvqp95ABnm6i
 WTdJvFc2LkBWgM/6l3t1CNzy8tuTHxRFJml+97rGmWPcuDUx22HepXR3Ye70rh2af1nf
 CWCg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roha9qyTEBwxzMc1Xai78QoH7ine6kzmn3e8t9fpznb9Kh2ngPuALImjP6jpUec5mM4skmbK0U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwZsAbzQ4dhcCWLEOayo0MfSv4Dyy7SUcdZKYqrzn1BKGqz3O37
 jaoYbgiK6dHlSn1aFKdhprdhLvlCAoXm3igYDA/rCI3ICP+byDCHFPtW
X-Gm-Gg: AR+sD11/ul9OenkfSdZwDk1y99rnuB+Z9qGDNdQApoIrfBepPA1Bs4kG0P+2IaNSn5n
 C2yUhW9pMHVA86fSsR9b6U3P4/B2gvDtKvxYGSQofc8UD2Pq6gkHPnVm6Gf5TOe6o/20PpvItzh
 ilwQ4Lp+578GFGLwMnL0KmqNoUs8gzjItv65D4kqOSSk0vGnAgEnnhl8uCasxGPn8mJo+oCZ/VB
 ZJUT2zXuSJwVx+femBlnBaOrZJ7jVkPe0ApOSKpSHpRiWoHC8KYshW3WqZN7A3CrBHMLrOzTMf4
 80t+Ftqe+MgB8rBC+YSPSjP1rYz5xrmkHLS4XBb785bsLdsEWhzKdJsDLZolVahu5o3YdLAkdnE
 N98Ewp871faoYoF+Vo5A/8ZXFUEZq//8P22vSCjCr3KwLD3gYUxAPIwj5av+YFdATjpyNtd5MdY
 CxqgfM8TmPCfPDcLkxzzb/Sm7VBFAIytgMl6lRgNrrXa0KJX6Xk3our/mEvkGnIoMgHA==
X-Received: by 2002:a05:600c:540e:b0:495:4689:1e98 with SMTP id
 5b1f17b1804b1-499aa1d0b23mr216460735e9.10.1787221526486; 
 Thu, 20 Aug 2026 03:25:26 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e8b700sm134803915e9.6.2026.08.20.03.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:25:25 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v3 2/2] usb: ehci-vf: enable the vbus supply of the port
Date: Thu, 20 Aug 2026 12:25:23 +0200
Message-ID: <20260820102523.1076815-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820102523.1076815-1-mehmet.fide@gmail.com>
References: <20260820102523.1076815-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver never looks at the vbus-supply of its port, so on a board
where VBUS is switched by a regulator, as it is on the Colibri VF50 and
VF61 carriers, the port stays unpowered and no device is ever found.

Take the regulator the way ehci-mx6 does: look it up in probe, enable it
in host mode and disable it in device mode when the controller comes up,
and turn it off again when the controller is removed.

A port with no vbus-supply, and a build without DM_REGULATOR, are both
fine and are the common case here: of the five boards that select
ARCH_VF610 only the Colibri has DM_REGULATOR at all. Anything else the
lookup reports is a supply that is described but unusable, and the
driver gives up on the port instead of leaving it silently unpowered.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 6c9866bfa5f..39baceaa820 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
+#include <power/regulator.h>
 #include <linux/libfdt.h>
 
 #include "ehci.h"
@@ -53,6 +54,7 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *vbus_supply;
 	int portnr;
 };
 
@@ -143,6 +145,13 @@ static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 	usb_internal_phy_clock_gate(priv->phy_addr);
 	usb_phy_enable(priv->phy_addr, priv->ehci);
 
+	ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+					      priv->init_type != USB_INIT_DEVICE);
+	if (ret && ret != -ENOSYS) {
+		printf("Error enabling VBUS supply (ret=%i)\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -284,6 +293,15 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	ret = device_get_supply_regulator(dev, "vbus-supply",
+					  &priv->vbus_supply);
+	if (ret == -ENOENT || ret == -ENOSYS) {
+		debug("%s: no vbus supply\n", dev->name);
+	} else if (ret) {
+		printf("Error getting VBUS supply (ret=%i)\n", ret);
+		return ret;
+	}
+
 	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
@@ -311,12 +329,21 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	regulator_set_enable_if_allowed(priv->vbus_supply, false);
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
2.54.0

