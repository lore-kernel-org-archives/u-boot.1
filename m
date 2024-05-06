Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04DBC25B5C
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A082587FCD;
	Mon,  6 May 2024 12:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="FgisnEoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03B67882FD; Mon,  6 May 2024 12:27:05 +0200 (CEST)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2161588013
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1714991222; x=1715250422;
 bh=Ft9zpNnUTnceVB+hzC+UbPmhzA5i8KstkWOp3gtLkVU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FgisnEoIBmE1Y5kjzxzCK1pJoj8+Pnotb8+F2ZXJcDBktCg5gdg/aJQuP4H35sRO+
 +fFpEKEEyvG48spEBITfk7mnSTYug7yUH+wrvnu9zVAbydB07ZOLDzateq7l1t7Q1q
 +hxvfNf2da9UgSofj03fkm04zUZT75yDb2HufkqW3NU9p7m6cTU4mxFyiK2/OJ9JHt
 GnvFOfY+M60GEx21dhfEtgq33KFxTrUpSm4nPEc8cqhmRH+Iip54R2zwVfEQaOc2dv
 yakYWM1scZGaZ6d/daMpg29YPGTQ7lA0ZdYxljVY90oooih3NO29zfswhijYS213st
 kdGBuOp4f1AiA==
Date: Mon, 06 May 2024 10:26:58 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 2/2] ehci: msm: bring up iface + core clocks
Message-ID: <20240506-msm8916-hs-usb-clocks-v2-2-34f741b3a2ec@samcday.com>
In-Reply-To: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
References: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 49d79e4bd82138e88ca3e16e6e6b0340dd84ad00
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This seems to be necessary on my samsung-a5. Without this patch, the
first access of EHCI registers causes a bus stall and subsequent reset.

I am unsure why this wasn't already necessary for db410c, perhaps those
clocks are already enabled on boot.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/usb/host/ehci-msm.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
index 98fe7bc3bc..b2e294dd64 100644
--- a/drivers/usb/host/ehci-msm.c
+++ b/drivers/usb/host/ehci-msm.c
@@ -7,8 +7,10 @@
  * Based on Linux driver
  */
=20
+#include <clk.h>
 #include <common.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <dm/lists.h>
 #include <errno.h>
 #include <usb.h>
@@ -25,6 +27,8 @@ struct msm_ehci_priv {
 =09struct usb_ehci *ehci; /* Start of IP core*/
 =09struct ulpi_viewport ulpi_vp; /* ULPI Viewport */
 =09struct phy phy;
+=09struct clk iface_clk;
+=09struct clk core_clk;
 };
=20
 static int msm_init_after_reset(struct ehci_ctrl *dev)
@@ -53,20 +57,46 @@ static int ehci_usb_probe(struct udevice *dev)
 =09struct ehci_hcor *hcor;
 =09int ret;
=20
+=09ret =3D clk_get_by_name(dev, "core", &p->core_clk);
+=09if (ret) {
+=09=09dev_err(dev, "Failed to get core clock: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D clk_get_by_name(dev, "iface", &p->iface_clk);
+=09if (ret) {
+=09=09dev_err(dev, "Failed to get iface clock: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D clk_prepare_enable(&p->core_clk);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D clk_prepare_enable(&p->iface_clk);
+=09if (ret)
+=09=09goto cleanup_core;
+
 =09hccr =3D (struct ehci_hccr *)((phys_addr_t)&ehci->caplength);
 =09hcor =3D (struct ehci_hcor *)((phys_addr_t)hccr +
 =09=09=09HC_LENGTH(ehci_readl(&(hccr)->cr_capbase)));
=20
 =09ret =3D generic_setup_phy(dev, &p->phy, 0);
 =09if (ret)
-=09=09return ret;
+=09=09goto cleanup_iface;
=20
 =09ret =3D board_usb_init(0, plat->init_type);
 =09if (ret < 0)
-=09=09return ret;
+=09=09goto cleanup_iface;
=20
 =09return ehci_register(dev, hccr, hcor, &msm_ehci_ops, 0,
 =09=09=09     plat->init_type);
+
+cleanup_iface:
+=09clk_disable_unprepare(&p->iface_clk);
+cleanup_core:
+=09clk_disable_unprepare(&p->core_clk);
+=09return ret;
 }
=20
 static int ehci_usb_remove(struct udevice *dev)
@@ -82,6 +112,9 @@ static int ehci_usb_remove(struct udevice *dev)
 =09/* Stop controller. */
 =09clrbits_le32(&ehci->usbcmd, CMD_RUN);
=20
+=09clk_disable_unprepare(&p->iface_clk);
+=09clk_disable_unprepare(&p->core_clk);
+
 =09ret =3D generic_shutdown_phy(&p->phy);
 =09if (ret)
 =09=09return ret;

--=20
2.44.0


