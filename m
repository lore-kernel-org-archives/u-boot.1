Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C04D232C2
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 22:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE4938415E;
	Thu,  8 Jan 2026 23:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BEF841C8; Thu,  8 Jan 2026 23:14:23 +0100 (CET)
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116DB8415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 23:14:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gcbu-u-boot-users@m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <gcbu-u-boot-users@m.gmane-mx.org>)
 id 1vdyGo-000ADb-Fb
 for u-boot@lists.denx.de; Thu, 08 Jan 2026 23:14:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: u-boot@lists.denx.de
From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [PATCH v6 00/12] Rockchip VOP2 support
Date: Thu, 08 Jan 2026 17:14:13 -0500
Message-ID: <jwvwm1rep4n.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:06gx4vYv3UJo2R3Mpz8tg387BMo=
X-Mailman-Approved-At: Thu, 08 Jan 2026 23:18:26 +0100
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

Dang Huynh via B4 Relay [2025-11-08 12:37:56] wrote:
> This series adds VOP2 support to U-Boot and enable it for PineTab2.
> HDMI should work flawlessly but there's still some timings issue with
> DW MIPI DSI, perhaps that's something to look into later.

I'm trying to use this patch on my NanoPi R5S and the result is not
quite what I expect.  I suspect I'm doing something wrong.

I applied the above patch to the tip of the current u-boot (there was
a trivial conflict in a Makefile, but nothing of significance).
Then I applied the following patch:

    diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
    index 1653ab8b44f..d707dd5bc29 100644
    --- a/configs/nanopi-r5s-rk3568_defconfig
    +++ b/configs/nanopi-r5s-rk3568_defconfig
    @@ -56,6 +56,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
     CONFIG_RTL8169=y
     CONFIG_NVME_PCI=y
     CONFIG_PCIE_DW_ROCKCHIP=y
    +CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
     CONFIG_PHY_ROCKCHIP_INNO_USB2=y
     CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
     CONFIG_SPL_PINCTRL=y
    @@ -80,4 +81,12 @@ CONFIG_SPL_USB_DWC3_GENERIC=y
     CONFIG_USB_GADGET=y
     CONFIG_USB_GADGET_DOWNLOAD=y
     CONFIG_USB_FUNCTION_ROCKUSB=y
    +CONFIG_USB_KEYBOARD=y
    +CONFIG_VIDEO=y
    +CONFIG_DISPLAY=y
    +CONFIG_VIDEO_ROCKCHIP=y
    +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
    +CONFIG_VIDEO_DT_SIMPLEFB=y
    +CONFIG_VIDEO_BRIDGE=y
    +CONFIG_VIDEO_REMOVE=y
     CONFIG_ERRNO_STR=y

I also changed the U-Boot config to extend the autoboot timeout to 30s,
so I have plenty of time to hit a key on the keyboard.

and the result is as follows:

- A U-Boot logo greets me at the top-right corner of the screen.
  I'm really happy to see this logo, shows something is right with the
  HDMI code&config.
- The rest is all black, no text.
- Hitting a key on the USB-connected keyboard seems to have no effect:
  the screen stays desperately all black except for the U-Boot logo.
- After the 30s timeout, the system boots as usual.

I tried to disconnect&reconnect the keyboard as well as tried both USB
ports on the device.  Same difference.  Why do I get to see the U-Boot
logo but not the usual bootup text?


        Stefan

