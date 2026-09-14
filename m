Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E066FC88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FCE380E22;
	Mon, 14 Sep 2026 14:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OiAkRCOQGrim; Mon, 14 Sep 2026 14:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3D5CD80E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395441;
	b=O0+X9Qz1SNw3b8QOYtlQpGSu97pL6COWo0XUUxjoyaLY0HaT6LZCT5s/yZytULvUNEyG
	 e9OvqKeLWq0U6AK6PbkNnG+3JBpM0TtZ/TzeXRShqveM7ljs75ByS12ABBxBe4ir04AG6
	 FiXzorVGqRTqUadL1DlHROV/cpFpd1wZPf55TApMV2kOalSeYRNWzyY4zVZBgzUoZy5tL
	 9xYWZlyLJdH+Bz/2CWyr5fxUAlsruTqvLwfMV8+eXI2ORkDtmL5Q9XLwXXYjdJcLp0ZoP
	 GyaLR88BP+yIpddjsYEoxde0GIvg1w+HsEZXcHYla8V0whyhd+mAcrjrARMBKRCiiuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YA//ZeG032O4ru5sNvUQGV6dKup+aDHX8HGzmhNdu+k=;
	b=JqL3kJlE1NeruYA59+SEozVi0PWYCfkxzM8Z3ID/h7BAm2ok7qAw/KodVFsXOepbdlxp
	 iZy1M0tfWeUz0QzcAdIkaDACUHGWhh7ke2emm00rFIoHfhX0qX1izH/WigmfBebphrAhG
	 tX6ybBpfCT8eK1Uqj4+RhTwK1N25VQpAOHVgCoocd/Bh9Va0afSXdTGT7dJDHAeIMu6xk
	 8Al1hcTEXpxmQ1WGNKAVu/6mZtV/kfl/b0xzc8ZHPb/MXyvpP9Oih66nIE7qvsZWEzmm7
	 HSthzPjTEF8sekfmCxTFR2oG92Yi50oA0LRGbGtlKKHImw6cRjBX5e8j3L/svyWs78A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395441;
	bh=YA//ZeG032O4ru5sNvUQGV6dKup+aDHX8HGzmhNdu+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVXrgq99fEnMJVSdqqbC7Tzn/VI1LVredhbj/faOuxdrVHoeaeUXPjYyZLBfqfgwu
	 qSuHc1cZO9P8nj7KAYGxgXT7B6V+d0Aus8ZvJTJzxqTaQYoC7TvNWI2pGiCClrEGpS
	 zwY1dFu8Z7kJYID9OcMR7gNKkuhrQ8Yq7hpV2HYdOoDEEzhRNDOZwNZrwclf73vbvB
	 hy3Ve7wkfOLRzaPtgp3kIZ3rbv9/xZhtjY6uGhOxVzWLiN3ioUMxISJ+8AWl+mfZ3i
	 dX6WIMxoLk8UUh9l/h1FCTK0bd32eWEUx+mdylYx4hwsytEdCwc6VOZoZJDxYhiAen
	 QF3qsYf/pHOgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D5CD80E0D;
	Mon, 14 Sep 2026 14:17:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C374A2D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B569D6067E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7J2yqNIK_9I1 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C4EF060650
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371808;
 b=eN1DS0jRkyXuTDoG3x32iNY/5yWEX7OQna92+sMOO6ywogPVV1jJswsajI6I+SXoOjlI
 5QNUKKZrG5htaHspHzAux/8T6uCRZE+Y/wbEuaMAWbSA7NusrRYjwb0CbZbESc0l3fwPo
 V1V9sR320nBsj0PcNWBb2d0k/T12T8yqyORa9KX5ZeGq0+DK8PNl2NQ4mV1tYCxfz8QrO
 wLW1XR9Rm4X11WuR0sJEWhgpEY4ODx5hNEsbCEPA6uCjpG7SqUKlu3jHobiCX73uq26Ya
 foUFL0cqqOCdIu/HHBtY9voliRReHq18e36wGuhwI4YsZGKZKaZAdZOa8BM75IdchpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371808;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=YA//ZeG032O4ru5sNvUQGV6dKup+aDHX8HGzmhNdu+k=;
 b=EjDpgzYd+kcJFwQCr90hOOjaNqm9c6Vy9SmWv/Hj2s+7djtae/TBPBXKwyfMWkBz2dkR
 16fbqZgxMzXQIW5Xg0cj2SaadNc2LVrol4ySmwEmTemSZyYfBehN4vh6yhOY6l4/z8xdf
 0OXIZ/sEyPh0BF4/oEwfSB+NJOtElljDoYluROXuajRYSBkdd/LkxBItDn0l3cFn+bY67
 s71+IaeE313NIGqXkbWQa9VD+P/81QxtE45LBkjBVQJs+xX6Ev2raxxmOyeKlan3noijD
 wJqrDeEkmE3CwnPEF6yi1Nlf/vn9jLOk4EgN8BYB/EYPm2cEvmIiwWoD1qJUpGxgDVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=COFOQYcc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=COFOQYcc
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4EF060650
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:27 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so32297925e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371805; x=1789976605;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YA//ZeG032O4ru5sNvUQGV6dKup+aDHX8HGzmhNdu+k=;
 b=COFOQYcclaQz3TQxp0hYtJz6DHCi1s3ox8KHlVk8ZZUZXHmpwuyA7JMj3F0aeDnuVm
 skNv5RHopM/ozHQHrpx0go+9V6CHCxX+m6S2HhScNDMp+Ov06InmYdjPzFd8xAGph2pu
 v+JiMJmvPbhzSZR2pH9aRzN4wx1KicbkFTsRNjMZNgb0TYMatMp4GmGecuo7LcF0lupj
 7TV2reuriI3NU4k9OFws2FSX36Xmn2yfUWHyJ7K6rWYnc/G9oJ7Jb4ojVT7sf6C1mUZU
 k5cZ1NA68M131fWLh8LWG+ROn5Ve6gP2wyNeYG3/wuluK3Xowa9Rx3uRfOcyDcSx3yvt
 fPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371805; x=1789976605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YA//ZeG032O4ru5sNvUQGV6dKup+aDHX8HGzmhNdu+k=;
 b=rESAMPzG/am1WahfiNyPluFiHBIgLDel22Wut6Xnxuur81/yPIP4xhrJReQewFZFiU
 3cnMBc2m/Y5muAgO/DLYTS1jYQ+sdTwqgUlKow//qTGirJw0m0eY2yGGFdsRkMbuIT+i
 1ovC7lUSA+zgnuDhqvlpv5Dh+KXeyvdMR+QbxDCCKRWeETtji6m8u63+rI9vrHGp+KZX
 Qth/fEA999+CA9IyykyQutU2c+yc4s2F4z3zQ4FChKaqtiPXVZy9anHR2aB1UEEm/vTd
 zcuJ7dUy0nEAubf+2eq2JLFYH7IQWnvhgjs1kKWaQy59Py+1gk2QjesmLviM2C7sz6zW
 fZMg==
X-Gm-Message-State: AFuF++nvBgPV0aGKe7PZIwDTybc6J9h5a15sCgltwVW5+cgZT3D238yE
 6b0gjtpD5MNsb86JNkmufm0Lf1lLnMd45OzTbqfOKxc16XmB9AZ312Vt
X-Gm-Gg: AYBFou3q+V5jtEQaeXmjBXcAmIhL+C/g98LYbR2nmZXzK1GuS0QxWlCcXRozx0REb2X
 fPSE2Jcx1Re4nnlxRYwq3t5Ni8ncbVdySo/v0MMO0l2HCKnoHGqgSc6fYFnPwoowzusYjFVlr+a
 XEmn/O1nyYfrG9N3v4mKzWGTPTj2CS6+kTgV95qMz8GRe22fadCyCRUUuRiqRKsUBb2In9Ipanz
 ekjbelfV/KjBJdFwptVWjtXOaVY8itsn4OgamJG1dL81TjtJXCUejj43lTLhuw5GuICNrPoCw4I
 uaXcCbdKRYshYu4RqYWv2GKkM7VCTbGk1M86sbFwnwd/CIryy6wmSiVOaXGqQGG5oV+4Na9HI2S
 RM1iyd7HfCNRDQqHVjCdLdFUTjKIf9ChOar2H5x14LQVJf6T7RkBjGokfheZ1wfzhJi/lrdJmAo
 I3XE35XJucwnvbyONJQOLBsSjtsGddXVY6PXdWTCmCXiqfA4bdxrFftbC6QrqsJNrg
X-Received: by 2002:a05:600c:1546:b0:49c:fc6c:be0d with SMTP id
 5b1f17b1804b1-49e7a685a0cmr14228355e9.19.1789371805242; 
 Mon, 14 Sep 2026 00:43:25 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:24 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, lukma@denx.de,
 mkorpershoek@kernel.org, antoine.gouby@toradex.com, alice.guo@nxp.com,
 stefan.eichenberger@toradex.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 pbrobinson@gmail.com, quentin.schulz@cherry.de, jbx6244@gmail.com,
 ye.li@nxp.com, xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 4/7] usb: skip host-only devices when picking the ehci
 gadget controller
Date: Mon, 14 Sep 2026 09:42:46 +0200
Message-ID: <20260914074314.12522-5-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914074314.12522-1-eichest@gmail.com>
References: <20260914074314.12522-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

The i.MX95 SoC has two USB controllers, a DWC3 controller and a ChipIdea
controller. However, U-Boot might select a controller that is marked as
host only in the device tree when attempting to set up a USB gadget,
leading to failures in gadget mode.

Iterate over usb devices and skipping any that are marked host-only when
selecting the controller for gadget mode. This ensures that a controller
that is marked as device or otg is used for USB gadget functionality.

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

