Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD09CC27C78
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 22:33:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A3387C69;
	Sat, 22 Jun 2024 00:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="KhE1yNyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B968644E; Sat, 22 Jun 2024 00:33:27 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6169B87FBC
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 00:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52bbf73f334so2186342e87.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719009204; x=1719614004; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+nzSjo2ZmyG/U0ldPJy4kie3PaLPjDMddxJB2jQbzv8=;
 b=KhE1yNyQlYE4KU+cZn+8JNd75mXbYdSghTeCuLDeivyFfSfakPbhU556yBWUZ7g48v
 doG0R3mFQQz3jONKSCIIZfgCdOTF+WKhJLC8Lmkyrfhki8AiDlvE2fg8JmiSXXES09Qb
 o9jcqPog9VEX1vIkminsGQ9cY2gL5hg+uyYEDuwOaGnSrnXAP6yU2NP0h2ti+vHxpn3k
 BDJhR2WHhsmeQravDBDlIprR8BUUOShGn9PxuAI0Uu0XAz7w7oDi5N28oeuRt+L7gIC/
 +w0pGMunxUjCizyT8hDf5/iqcraaIRZ5a2QDwFK8d2m9hCofMn4ozVZ8WB4P9eO/g61a
 ysOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719009204; x=1719614004;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+nzSjo2ZmyG/U0ldPJy4kie3PaLPjDMddxJB2jQbzv8=;
 b=SkVLToYPKHmOLSDX6AERucJWZ4JeTBy7rErkYvte7fNnuujO4+CeA+5zmI/d7DfHgb
 0SIozHCPWYYc+RpzzAc/soKCQZhBlnphPRgL0RQdqUZLRD2zB+3y9Uy2fLx/bi6uuS4X
 PBIjkoG5Z5vryXCZqzrYPXX8O00onBSyQJ8tH8wYtQwMHtmHlgKAYVchZwZIFG2Ide+L
 NNDsfLadumgJOSqg85ri0roFTmwruM4Di1OPggvbono0SpZd/G2miSxaa3KCJr4aamXG
 sl8cocFCtp4eFtWTxzgZwSbTengGlHbdJ/D9j2zlsr68kRdAy8TT7JB086Qh7OE83tI4
 w6JA==
X-Gm-Message-State: AOJu0YzqiFVfnbrn2SCT2s22W0aj4CT+rHR4d9bHyRhFuRGCCkL95yMd
 dZE/uAmXGJiSXt5GxCloue753ujnGczZ5249DyhcPk24H3Ua4jY9bG4otkz27M6PKGeuxgKKoga
 moKLXuMJtCcQsPjlyH6+AG/jWLBwFAzsqSd2/ziveF5qM4TinfQQ=
X-Google-Smtp-Source: AGHT+IHnDG/C8eG5ujUxMkN0G6zEiamSIWvwCuHBSdbRJO4IMpwtlqHGIdyPxGZVWYkk0P3k4OKgzEPzEALg94cM3+o=
X-Received: by 2002:ac2:58c5:0:b0:52c:9fac:2147 with SMTP id
 2adb3069b0e04-52ccaa5cc98mr5557265e87.16.1719009203131; Fri, 21 Jun 2024
 15:33:23 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 21 Jun 2024 15:33:11 -0700
Message-ID: <CAJ+vNU1cy9LmQ82J+pHTO22xTCh4G6MG477ncpjvzARREnMMjQ@mail.gmail.com>
Subject: USB gadget device (USB_ETHER) with ChipIdea device controller (imx)
To: u-boot <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Greetings,

Is anyone successfully using USB gadget device (USB_ETHER) on any imx
that has the ChipIdea device controller? (imx6/imx7/imx8mm):

I've never been able to get this to work as when
usb_setup_ehci_gadget() is called from ci_udc's
usb_gadget_register_driver() it first removes the usb controller (and
its children) before reprobing it and this causes a hang.

Here's an example with v2024.07-rc4 on an imx8mm-venice-gw73xx-0x
(imx8mm_venice_defconfig) after enabling CONFIG_USB_ETHER:
u-boot=> net list
eth0 : ethernet@30be0000 00:d0:12:ba:f8:cc active
u-boot=> bind usb 0 usb_ether # bind usb_ether to first usb controller
u-boot=> net list
eth0 : ethernet@30be0000 00:d0:12:ba:f8:cc active
eth2 : usb_ether 00:00:00:00:00:00
u-boot => setenv eth2addr 00:d0:12:ba:f8:cd
u-boot=> net list
eth0 : ethernet@30be0000 00:d0:12:ba:f8:cc active
eth2 : usb_ether 00:d0:12:ba:f8:cd
u-boot=> setenv ethact usb_ether; setenv ipaddr 10.0.0.2; setenv
netmask 255.255.255.0; ping 10.0.0.1
^^^ board hangs, USB host connected to board does not enumerate a CDC
ether device

Unbinding ethernet via 'unbind ethernet 0' first does not appear to
make a difference.

The following patch resolves this however I don't think this is the
right fix as that was apparently added for a reason in commit
fbeceb260232a ("dm: usb: Allow setting up a USB controller as a
device/gadget"):

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..38111fda8af9 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -403,6 +403,7 @@ int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
        ret = uclass_find_first_device(UCLASS_USB, &dev);
        if (ret)
                return ret;
+#if 0
        ret = device_remove(dev, DM_REMOVE_NORMAL);
        if (ret)
                return ret;
@@ -412,6 +413,7 @@ int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
        ret = device_probe(dev);
        if (ret)
                return ret;
+#endif
        *ctlrp = dev_get_priv(dev);

        return 0;

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d669..38111fda8af9 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -403,6 +403,7 @@ int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
        ret = uclass_find_first_device(UCLASS_USB, &dev);
        if (ret)
                return ret;
+#if 0
        ret = device_remove(dev, DM_REMOVE_NORMAL);
        if (ret)
                return ret;
@@ -412,6 +413,7 @@ int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
        ret = device_probe(dev);
        if (ret)
                return ret;
+#endif
        *ctlrp = dev_get_priv(dev);

        return 0;

Adding debugging to device_remove the hang occurs when removing
'usb_ether.bootdev' and I'm not quite sure where this device even
comes from:
usb_setup_ehci_gadget removing usb@32e40000
device_remove usb@32e40000 flags=0x1
device_remove usb_ether flags=0x1
device_remove usb_ether.bootdev flags=0x1

I don't understand why usb_setup_ehci_gadget() is removing the device
in the first place just to go and probe it again.

This is not a regression... I've never seen this work since I first
tried it back in Feb 2022 [1]

Any ideas?

Best Regards,

Tim
[1] https://lore.kernel.org/all/CAJ+vNU1xH-J-0RV09OuM1e+hsRV=HXvh2oS6PfCWY5d+0stRYg@mail.gmail.com/
