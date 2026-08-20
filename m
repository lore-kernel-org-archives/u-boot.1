Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76CC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C4140483;
	Thu, 20 Aug 2026 07:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nnAPwjRozLz7; Thu, 20 Aug 2026 07:15:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210146;
	bh=xlD1tIPgIc7p/UsRFuMa47n7/Nuxh/KKC/pIEJvFxWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=te5tFAnbuuyv9tQEsPObnRNh2Kk91dkBNwChPiTlyKWYW8M1KkabYx3OnUfHwO3yd
	 1BVwBzmtmJC5lWZtSuchETtRuMnHTUwKU5vzgbJ2Iu0OcWlrz+o+RHzKC0TG4wsFFD
	 flipoi9GURasDxAijm3lAXZGfnTUEynUHDTtAwGbXFw+E53S9YBT6KxRgwdO7GW3O9
	 NSiEUIu8E5N09MRrBZiDqMSAAHOEoEPKqHJA39+hifiHfuY6GGivZCVkmhqCSUhiug
	 tICD++OFghmczUnavvlJ1JGrHlB7od7GE0u8BYnT0Wq1R1PW3bmebPMpk+P8t1jpdU
	 FuWlylIMrgdHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 442D74054E;
	Thu, 20 Aug 2026 07:15:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB3582FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD3EB60683
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4nniGJYl_VM for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NS/t1TmR
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0B8A60671
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:41 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1772979f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210140; x=1787814940;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xlD1tIPgIc7p/UsRFuMa47n7/Nuxh/KKC/pIEJvFxWw=;
 b=NS/t1TmRzVMsVyunxitZY4YwDu/bLEb5nBQ8uRE5bck1q/Rh3WdnZjyNzmjSbQxg1a
 KoEZgDq7iXZ0j70cocdtDT8iGxnlVnGtvhybOYdJ1CK3qzDsPAwISCsnqBEqNWi+2104
 JdW3P7k7wSR78k9FiEQPYD+zk3R3/H5JJzabiuZMh8Hz5HUmHcG3Me+2fNJ9FLVFGBKD
 YkOZtXbeOZYOIBcsQed6Ss8eA08Of2xHhgvff1KqDhTyGSH6EiEzWbNZV1DjnIpK4MBJ
 7Q8Cbg3SrcSaorrvHt6pBw1N3XhwTsFvR8dRRVx0JBnCqyiEyCae9FbzF8wULEM77Cly
 9fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210140; x=1787814940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xlD1tIPgIc7p/UsRFuMa47n7/Nuxh/KKC/pIEJvFxWw=;
 b=Sf7OxbDDiEGH+vo/IHT3dWj9P+R88yddX051VozfezCSgkdFlyNdYVJWn69/Q18f+t
 I0Bs1AxXxYo8o1WewcsXE/DvVhugcqmFLkKJpH+R98GBZKHLERXTanPECMfbrR56VDmy
 ybAVy+Wl9F+jBV27K/lrdoZ80TMR39SXTk2HSACTmBjcpRKQu4qmRSiNDo/o9UNThsB/
 Psxpq0B4fLLpLzYNdoRognZyc9gr1yWf/5712AfXb/QwLrUM6GkYBnpeBPVOBdXW3q92
 sXo9lh1zsFu2ROS4a/40fy63XAZrZ+3YOJdvlCa9X416MH/9bhGneJ/hqWa48fe8fGe1
 ADdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJgYx6cWMHV5WdL9f7ovasf7lD/00Eg55tEUNGvbA3mZCEuQgSNQ+pIAUrGB8cLT1llEDP9Tg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw6ma+HgFPQBMLZbnzv95qo91HkAyQORPStrVIg4tWvOQb2276f
 Z3qDWspEpc0PuUz0rxSDTO1NdFGxEpxY0s0z2xR7q0boBitEStCqVud7
X-Gm-Gg: AR+sD11npQ9wLfaegeDaTckiLWIoHSHY6F/R4M/NY4azx4/GPvr2N4oMSGL+n/cKvP1
 ry1QjUFulunM4V5Dlj8sxLSmPS+TucAMOL9oiNREPFWZ7ETfpFCCBiZvAIrE3u34FdnJcbgSXb9
 hco93s1IUXFKQld3JZjA0r3gwtwrtJXsjfIGPtwJANhw4Tt02nmB6N+vjxLqsUQ+kDywN4cAXVo
 oaXaL2r91dEZKlHlDDG/Vx8ggU4vjggI2nGJ917E2yKEDk9DXytr5JIMvy16TaCmRPBwfGKoh5Q
 kDcid7LcnuPGeLlH+hwOdIv80kzTj1TT/UmFLGRc5wp7ARGBoJih9YV/NUgjHuQY7KtD8sRNimQ
 vRVWKozfL/ZP5Kt0D1vpq7ekxuAds0NbB3rym52KDsGC05+Fh4Qz5wTlONVt3bBdNcD6PAjUHbd
 ez2d/msJ6xoWqnOhqHnkXk/ueyip7vcOnSWcilT63+JuOi1Ruy9ZO+ZCUj2N2XafPOKGNP/UBSy
 6di
X-Received: by 2002:a05:600c:c493:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-499aa15df47mr173166285e9.5.1787210139732; 
 Thu, 20 Aug 2026 00:15:39 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b23a00sm19197705e9.3.2026.08.20.00.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:39 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 2/2] usb: ehci-vf: enable the vbus supply of the port
Date: Thu, 20 Aug 2026 09:15:36 +0200
Message-ID: <20260820071536.1036898-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820071536.1036898-1-mehmet.fide@gmail.com>
References: <20260820071536.1036898-1-mehmet.fide@gmail.com>
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
and turn it off again when the controller is removed. The regulator
calls handle a missing supply and a build without DM_REGULATOR
themselves, both return -ENOSYS, so the driver only has to look at what
they return.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 6c9866bfa5f..f7c10e183d0 100644
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
 
@@ -284,6 +293,11 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	ret = device_get_supply_regulator(dev, "vbus-supply",
+					  &priv->vbus_supply);
+	if (ret)
+		debug("%s: no vbus supply\n", dev->name);
+
 	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
@@ -311,12 +325,21 @@ static const struct udevice_id vf_usb_ids[] = {
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

