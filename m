Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC62CCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 10:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4FA837B6;
	Sat, 18 Oct 2025 12:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="i0IplZy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C60DA837B6; Sat, 18 Oct 2025 12:22:44 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA2983869
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 12:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type; 
 bh=7T7ZYpLUu9XXHZHoZh7WJzGgTEySqAUNQ0iG/qBYgZU=;
 b=i0IplZy12ITzUTCPI+BkKPykkCz3zddv5C+TIb3E47qP4BsGjFcSI4BcXhBAj+Gm9E9ojKqCbXTpOY7MwNig07nuDiN59Haw4JqNA7akYFkm61Kx9WNcRpHRocmI8iIDm9/C9etyAWUrPG5/fdSXwP+7rWoJpuub57SBGcAXiOnWONu/d+MptZ/eTEUm2VOd/nYwYjq9kGr1gS2ztusYA6oLNATrjHSYEnXkCNmNDI4ygHBrfH0y3yBYQg
 ZU94pGSMnZLrubSxKzgG4UdaHJL0h9qmRUsAGMgZlM/lEEAoEoFxoYzIeDsxnYxM1u51C6USYW+5IT3a0X1abgh8WD2A==
Received: from GRAPHRT (188-24-192-7.rdsnet.ro [188.24.192.7])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Sat, 18 Oct 2025 10:22:38 +0000
Date: Sat, 18 Oct 2025 13:22:35 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Patrick Delaunay <patrick.delaunay@st.com>
Subject: [bug] RK3288: usb won't start
Message-ID: <aPNqayAhe0Qn723N@GRAPHRT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi.

Rockchip RK3288, Asus TinkerBoard S, u-boot master branch from 2025-10-14.
USB won't start. Log:

  => usb start
  starting USB...
  drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/ofnode.c:417-ofnode_read_u32_index() ofnode_read_u32_index: vbus-supply: of_read_u32_index: vbus-supply: (not found)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@334
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@334
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@334: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@334: (none) (ret=-19)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  Bus usb@ff500000: Port not available.
  drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: disable-over-current: false
  drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: hnp-srp-disable: false
  drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@348
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@348
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@348: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@348: (none) (ret=-19)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  drivers/usb/host/dwc2.c:1254-      dwc2_setup_phy() dwc2_usb usb@ff540000: Failed to get USB PHY: -19.
  Bus usb@ff540000: Port not available.
  drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: disable-over-current: false
  drivers/core/ofnode.c:525-    ofnode_read_bool() ofnode_read_bool: hnp-srp-disable: false
  drivers/core/ofnode.c:540-    ofnode_read_prop() ofnode_read_prop: assigned-clock-rates: <not found>
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #clock-cells: 0x1 (1)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for clock-controller@ff760000
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking oscillator
  drivers/core/uclass.c:406-uclass_find_device_by_ofnode()       - checking clock-controller@ff760000
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for clock-controller@ff760000: clock-controller@ff760000 (ret=0)
  drivers/core/of_access.c:556-   of_read_u32_index() of_read_u32_index: #phy-cells: 0x0 (0)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usb-phy@320
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usb-phy@320
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usb-phy@320: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usb-phy@320: (none) (ret=-19)
  drivers/core/uclass.c:546-uclass_get_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:397-uclass_find_device_by_ofnode() Looking for usbphy
  drivers/core/uclass.c:416-uclass_find_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  drivers/core/uclass.c:549-uclass_get_device_by_ofnode()    - result for usbphy: (none) (ret=-19)
  drivers/usb/host/dwc2.c:1254-      dwc2_setup_phy() dwc2_usb usb@ff580000: Failed to get USB PHY: -19.
  Bus usb@ff580000: Port not available.

The bug is caused by this commit from 2020 (author in CC):
e17a4bf198510693967644c331ab621fc41ea8b5 usb: host: dwc2: add phy support

This chip uses drivers/usb/phy/rockchip_usb2_phy.c driver, but that driver
doesn't register itself as a proper dm driver and isn't found by the scan.

This quick and dirty patch makes it work, but I think the proper solution
is to fix the rockchip_usb2_phy driver. I'm unable to do that myself. Too
complicated for my skills.

You may consider merging this patch temporarily, as the bug breaks USB boot
and keyboard console on many devices.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>

diff --git a/drivers/usb/host/dwc2.c b/drivers/usb/host/dwc2.c
index 16f21fa9083..74d71f23d88 100644
--- a/drivers/usb/host/dwc2.c
+++ b/drivers/usb/host/dwc2.c
@@ -1329,7 +1329,7 @@ static int dwc2_usb_probe(struct udevice *dev)

        ret = dwc2_setup_phy(dev);
        if (ret)
-               return ret;
+               dev_dbg(dev, "Failed to setup PHY: %d. Continuing anyway...\n", ret);

        return dwc2_init_common(dev, priv);
 }

