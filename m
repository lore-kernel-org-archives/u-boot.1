Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A221C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C809580D07;
	Mon, 24 Aug 2026 19:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkDMyndAh0PD; Mon, 24 Aug 2026 19:03:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598239;
	bh=WWma5TYQe3RyqXnjHjz9tf0kdvExsfL4A/VKlLcUh+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiHKnkIc2dVBQLnnVQ35vDFpS2pef4ojnpj8pEc6DemUSdo3s9Kf3pEhaSR6BIKKt
	 YXZRx1rJBsVNPTyipVNfx8D3XteyKd7oS+sTq0eZ6QOoE8d6FkcfeJDY0D6F89zhHj
	 fVUpm8PAYw0kzRoOsN+3wpilAb2VwBdxJHRCouaNKC3dubw+X0ZM/yGg23sB4kNsmS
	 OYwBoeHBcmYc0zIGBf9a+03vB6iTCccUFkzuuqn7aop+bTryjfq8caAK3j8/Rc5hiw
	 npO22e2rzGntKaCAfAIrfrmANwwildwERk3s3K1i7+yJiA500qyrsJOQVeif3pxvCD
	 sdjDJ8ITfH0wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBA8080D09;
	Mon, 24 Aug 2026 19:03:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BA3D84B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0CD640059
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wqtqb0Ozv52Q for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TnB6pVAH
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0C2B40026
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so33213066b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596260; x=1788201060;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WWma5TYQe3RyqXnjHjz9tf0kdvExsfL4A/VKlLcUh+g=;
 b=TnB6pVAHXWCOw8PHCLpBxDcmLA06tyOTNFuHPMShIVTRPldFR7Key4z6UZovcKf6GV
 +6db2h6Cy9ZBpho3ogpAqtV7UaWTfI2GEV59XxsAOptXO9xMwd3yzjDjCPHbd/6BnDnW
 RZlLrlh4QvDbj7neCwJcVvQ3fph0mg0CKQ0j6OQSwh8rxT635EX3RVUOGFQ0Opp5K3An
 /OKeIUH4hFET/EJ9nFyA38pThyYhoBxJRp0lIDI2lyuSzb7NmzEd2LVIWlYsBVv0xJbq
 bPp+kM26XEPjgCPNAePhgMYZRlHAe59Gzupk/beDN5ffI/vtL4mwuprKMI94mfKu3n5N
 RTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596260; x=1788201060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WWma5TYQe3RyqXnjHjz9tf0kdvExsfL4A/VKlLcUh+g=;
 b=ATW1qYyc56bVt8uV+5qq68Qafe4VXWeJMVlKWxb5AJOZGk+HasaHMOkrrWsgL4Q29o
 2Zq5nCQmTkPRgzHBYQvcyglGRDIXWSUHT+HLVSEy46uJ6QCCDz4pcn6TRl4HLjKG5SeC
 IamZ9FCW/XZuzbiVpeJMOC1VEywVSO0guxjfXLJGD370t/JrpXTHMnNFNCO3ikdVMf5B
 yH9552jnR9xCQIVTC0zhJ55pbwrzB7EsPzgCiW2n7ZTvj8ZvHkM1uY2kJPVmForIctXB
 a8HX0MAjKZT7vYCDqvELQkuC7/gsr/0jXwzPvaYIgRn9YBIyih8/FHi5kZuvZlFSyYhF
 aLPQ==
X-Gm-Message-State: AFuF++ngsnJiysqvEhnweRV+CwvSfD9Nx+HR1gQtAPXIMsC0ofR64sDQ
 aXHpvxkUmcWgYg1i81XbkvBOI91JHG7hB8/isPUHNtnVRLTkkiC35riV
X-Gm-Gg: AR+sD13XfCaboE/wEQIqtQry/zMiAMtDODmv/yENUmqD18cEwP1GDGjN/nkiglQNbSN
 T5iJXguONvVcYWVTWnPuUeR5e9R+x16n3VDdzJ7MQmtQjef80fqlc0esrSSW79Z29R1sBa5vBTn
 /2F2Jm6nEynrg1aAw3HvLyUBKN4qmF4qwuagjvLhJ8qL1fIHou8v15Fq3RQABUCLL2n9VbqkHTk
 mGNjvnn7gerBXVpHIKHB8WZKKVd/38+dJG+XQ0Y1Voicxl/mOvGPzeFXqEyw9d6VaE3H9gbvJge
 rWmQGIN79dzvWNBafkKBOIp5JYARzeQCvrRIxyd2gAGU2pLtkocIQf8rJv72YtLUsOGh1KApnul
 /psOrV/YO/9xMS5oHL/uH7vIZzzCPQHz8Y87am9j09ifCJEnNuPNAplfXraYsY7l5HDTfnT74D5
 3i3HqnglKry1aTgjRrpthCpOauh7ch10nch13jhHH0YNc=
X-Received: by 2002:a17:907:9807:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c24e2d24874mr90046966b.6.1787596259389; 
 Mon, 24 Aug 2026 11:30:59 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:30:58 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/6] usb: skip host-only devices when picking the ehci
 gadget controller
Date: Mon, 24 Aug 2026 20:29:11 +0200
Message-ID: <20260824183048.419198-4-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The i.MX95 SoC has two USB controllers, a DWC3 host-only controller and
a ChipIdea OTG controller. The latter is the one that can be used for
USB gadget functionality. However, U-Boot incorrectly selects the
host-only controller when attempting to set up a USB gadget, leading to
failures in gadget mode.

Iterate over usb devices and skipping any that are host-only when
selecting the controller for gadget mode. This ensures that a device
only or otg controller is used for USB gadget functionality.

Verified on Verdin iMX95 hardware: "ums 0 mmc 0" now correctly flips
the ChipIdea OTG controller into device mode and enumerates on the
host PC.

Fixes: 821ca608d816 ("usb: Use the first available device for ehci_gadget")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/host/usb-uclass.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index 1c74d6fd39a..b9e9ef7e86a 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -18,6 +18,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
+#include <linux/usb/otg.h>
 #include <time.h>
 
 static bool asynch_allowed;
@@ -484,10 +485,23 @@ int usb_setup_ehci_gadget(struct ehci_ctrl **ctlrp)
 	struct udevice *dev;
 	int ret;
 
-	/* Find the old device and remove it */
+	/*
+	 * Find the first UCLASS_USB device that isn't host-only. SoCs can
+	 * have more than one UCLASS_USB controller (e.g. i.MX95, where a
+	 * host-only DWC3 port and the ChipIdea OTG port both register under
+	 * UCLASS_USB); taking whichever device happens to be first could
+	 * pick the host-only controller instead of the OTG-capable one this
+	 * is actually meant to flip into device mode.
+	 */
 	ret = uclass_find_first_device(UCLASS_USB, &dev);
 	if (ret)
 		return ret;
+	while (dev && usb_get_dr_mode(dev_ofnode(dev)) == USB_DR_MODE_HOST)
+		uclass_find_next_device(&dev);
+	if (!dev)
+		return -ENODEV;
+
+	/* Remove the old device */
 	ret = device_remove(dev, DM_REMOVE_NORMAL);
 	if (ret)
 		return ret;
@@ -507,10 +521,15 @@ int usb_remove_ehci_gadget(struct ehci_ctrl **ctlrp)
 	struct udevice *dev;
 	int ret;
 
-	/* Find the old device and remove it */
+	/* Find the same non-host-only device usb_setup_ehci_gadget() used */
 	ret = uclass_find_first_device(UCLASS_USB, &dev);
 	if (ret)
 		return ret;
+	while (dev && usb_get_dr_mode(dev_ofnode(dev)) == USB_DR_MODE_HOST)
+		uclass_find_next_device(&dev);
+	if (!dev)
+		return -ENODEV;
+
 	ret = device_remove(dev, DM_REMOVE_NORMAL);
 	if (ret)
 		return ret;
-- 
2.55.0

