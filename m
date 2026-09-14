Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFEDC88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B7C6061E;
	Mon, 14 Sep 2026 14:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QaHmb3XWE69X; Mon, 14 Sep 2026 14:17:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 722EF606E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395437;
	b=SP7CYyBYL95XXG2bSwEPodFiRRyk8b3p3oPSjbRHzj5444hU3ZicGwSbgITszfByjRaE
	 HkgSvNEtPJMmK+ZZMdmXMIj9oGLNylR75f1I8EJpACTrT121HboLACVWkiCxifKQUbcqW
	 9J1Vl0YKv6iawWnssyGYHd+k3PRgYGYsrzknlJffDFA5oaXP6aMqMvbm+yuqYSiwiEv31
	 I6rL5J78t4pMTGJTEO5v0l6rBR0WK7BH0jkkY+K1cpRZrIJs66VL/NF45+rXE3IU1VdoX
	 5Hdp9JUCzMpjc29LHdXYwSK0BD+r53liEvoIfIMAY0WN2Bd8LX413otazcOpbhAp6Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=emJbqheWpPg1o7kLf6Q/pJXTk6NqERm2kl3ZY2DDQLs=;
	b=NJntqUyK7We+/UVqFdcZtHsVzDp7sZo2RfYEfMoDflQnUTLT0c4ssUQOiIt4Z5/hXi6m
	 DZEI/TER7JnE2po3GyIc04wo91wb+741csAWMLIM9PbPHxnONOxEdYdjALRkeG5sloGMI
	 msWdyEa/qBjZOwQBmFF+B6+nDgu7cNtMzDgxYso3Gxw5yEaHWS2c0OqByYhUv7XUT5PRj
	 +avcqfheTQqh78wvwqNuX7IW9ms2rU+OlbNoEovHY6yQKK+zROoxJLYTS1egM/Z/tOLXQ
	 QhkDr2iSB/3Lom8wJj1cCrqq3SBGR/7oEdhVm2AAFEDWrOvDDVhoCWwYiGuKDN+i3Ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395437;
	bh=emJbqheWpPg1o7kLf6Q/pJXTk6NqERm2kl3ZY2DDQLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dU7IIqXpLEhwOCDWfsdZHxLbezBswkA+huBdy5sJ1Ta+NNRJDvJsJd8Rys/+cas8o
	 5FXXNcd0E+4/3IB7GDDbdiiG5MgvvWBqsqIVTRfJ/XkldBaKXvDeIfUVKU/vuKktjg
	 HGquNOS2fXjwy6mq8AXU6InKqkKtCtfxMcOGPfWUZKDBHW3b6opzIQErvNmr0GR+lD
	 m2XygST8S0IFnFQMIw/anTfXBx3q7dVv+tPsulYRcU/NTcdE+8mfVzPMb0n1zkNX6s
	 B8liOpOwISXIQxN2842Vc1WZQq10yRD2f+BT1Jt0gZpLmuBQXmvk6GxbH/vb+Cy5aa
	 xDQg47Oz9OejA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 722EF606E0;
	Mon, 14 Sep 2026 14:17:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C683224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E859400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id riDPgbLED8tj for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 07:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 70AAC4007C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789371805;
 b=LiFVcl8LDN83f1HRWSJAlHxOigygYa0KGvHKatkpX7K89Xg2h4XjlmfJosKCTSzwSgFm
 +PTElQrsT3BgP2WMybbqpNUQysM4M7WK7FPahurqdN8sS2P1iH8CpZYW374fhQHBbeYc+
 cVwJcdw0hp7F/Nev7GxSTvdofLk7FFbuB0jeajbIopdz6f357uvVDlYRRamjW5VGBJWZn
 0cuqD8HL1j8KFflAgRZF4b5KjiXSBvrGsLR/UqnVmBSanYtq4Uoi/4pCZ7MEU0Ei+TjA0
 F7ovsddJRGK/XOzw1X5Nd0viy+lmc4MJEpL97Q4z6g46oyYRBnIeMf4M1HaF41riSIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789371805;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=emJbqheWpPg1o7kLf6Q/pJXTk6NqERm2kl3ZY2DDQLs=;
 b=raQrdEenIfHp0OfTv0IOztGyCymgK+27wtpkbM3087SJTjtCtyujtpCR0X8mrwfiyY8c
 jVzessFT+C34ql83TN4kFp7rCUlp45qW7I9OeAdfIKABNh6UCi84jxI2e4gmdX7M7dX+8
 tFK+MgKuDC01N2CD0F8AoWveb0iNcoiXMDpblRt85TrTSXmcyLQHBjvhuh40zJ5xhEN8O
 5yBe/S32+Y33Of1qbm0CQs9sQe4z9ktpQuCj6tPgQWkLdlIH2C374S7cXaf7kKDjw4P2Q
 lSOiYvZ1KMEMpH41ZeeGphgHVuWzeuC3PdEDs6Y6jtvLlUkm3/lz/QslPofxnZ2gooQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Jc/wJWAm"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Jc/wJWAm
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 70AAC4007C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 07:43:24 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so13730625e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 00:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371803; x=1789976603;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=emJbqheWpPg1o7kLf6Q/pJXTk6NqERm2kl3ZY2DDQLs=;
 b=Jc/wJWAmdYS3lN0CwZID4xkFfkeSlWfEfhmp+BRu+RiqZ6eTKv6V5FLT3GgPZwmg7m
 w2uERqvKXRmilPOgNA0zLb4K89m4XFbvE25YpqXBQgAFtT8MR2FLCwGlQKIvkZV1IhQd
 zhiwJNIDH3ApAhQL3mCIRR01xrKqk7nGyF+xcpcL0SNKrORjSV5zM0ePbmQNaVnJc+nI
 lhTCxvPrti2y9XZxnobmdDUrDJtsF81l+swWAA84nF/l6JOTedbK6qr1TWtJJBvBwV3j
 wnIuyea1wlGPSlVgl9jgUgsujAFsraLCFuodsm5N44o7IdJg74mw592HZwh9I+QpgBRN
 B6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371803; x=1789976603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=emJbqheWpPg1o7kLf6Q/pJXTk6NqERm2kl3ZY2DDQLs=;
 b=qN5yVIDUDeIhRafjetrrG95l1eZA4and9C2XAdpaag4Gnw93VmGNRM5clSUvV/kJpc
 bo2l21tpqk1c6DqHh7tlRFPDiNiqyi3VsYeJMOcfXS5ZeBqI3C9k7WF8bvrCaSO9tK+X
 egbcP8hN5YvN1oqMWC5AvYEcQbn2ManhlKLZxzQzz3Y0JMvtpJVakgBSdp8Nyl1oP4qE
 0K9VCzrC4pV2KWMYIvp7BaBOAVHtsf7l0oyhXS2YEvILQ9JJ77AqZ05uzxJmQrv11Hhq
 8kznt9eHbPkq/6989a9FdGyXWhrNRuPWb4dAdFGNsap4MXem0ku0ec5H2AE24L3yWsei
 Ny7g==
X-Gm-Message-State: AFuF++mjkXoPNsYqNaAeQAdh5ZUDpxDUPHKFVkakkuAUx9bYqeTo9yNp
 flrt0tEASyte+jq7m7BfR9D/FTErJsFJrpPZ3qYBAbBL0FQEX2+9j2pr
X-Gm-Gg: AYBFou3ql4f2y0SP4EG1dVqHokpUCZxsyGy15dP2mPtlTNScn/oJOL0eAMGIuTr4cFR
 ug4Eb7pY2o/ndHF6ndV6dyIUJ5uLr95GeakjhcCbOYOiJyNgCp1dFeQA4AOSQLaGtgtx3o+CAjj
 dkdaIBtYDyLz6GTJlnMcyGDaj5uvNJAM+FUJuoYNibbaKZ6Hpoyw0LF9CZHksnkfu6WdQpMiXXQ
 J9EzmUC5AmbfcdYP5OVFzRjbRG2qt8IxpRSmKoPNtrowm2mllCoGZgDHcopPXqVpnSFKfMk7kbH
 sU219OBLQwwKwqj/aaQHCQte8FMKafIbe4ypQwqJXIpIQ4scqrToHcvFP1Ks3+HaSK2lZMXQyoJ
 2pK7UNixbpoTZilrKJ+vTBsqqgwVne0uMeaFS260K0tjxDdDI+sjub43kb48McNW2PScYywJWYV
 R9Lc1WGUMS+clwc0TWXv7N6+4vpQkJtYVPZ7xEDC5P1JUDcDXv8FpPIBfkEzX1Tc2Z
X-Received: by 2002:a05:600c:620e:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49e7a69c01fmr14849935e9.30.1789371802769; 
 Mon, 14 Sep 2026 00:43:22 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm184611495e9.2.2026.09.14.00.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:43:22 -0700 (PDT)
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
Subject: [PATCH v2 2/7] usb: ehci-mx6: bind the ChipIdea gadget driver
Date: Mon, 14 Sep 2026 09:42:44 +0200
Message-ID: <20260914074314.12522-3-eichest@gmail.com>
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

ci_udc has no device tree match of its own, so bind it here for the
ports it can serve. This driver already owns the controller node.

A peripheral-only port is of no use as a host, so hand the node over
completely and decline to bind. An OTG port serves both roles, so bind
ci_udc in addition and stay bound. Neither device is probed at bind
time, so "usb start" probes this one and puts the controller into host
mode, while "ums" and "fastboot" probe the gadget one and put it into
device mode.

Boards that do not enable both CI_UDC and DM_USB_GADGET are unaffected.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/host/ehci-mx6.c | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..8b997e88946 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -20,6 +20,8 @@
 #include <asm/mach-imx/sys_proto.h>
 #include <dm.h>
 #include <asm/mach-types.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
 #include <power/regulator.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/phy.h>
@@ -553,6 +555,41 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 	return 0;
 }
 
+static int ehci_usb_bind(struct udevice *dev)
+{
+	ofnode node = dev_ofnode(dev);
+	enum usb_dr_mode dr_mode;
+	int ret;
+
+	/*
+	 * The ChipIdea gadget driver has no device tree match of its own: it
+	 * shares this node, so this driver owns it and decides which roles
+	 * are wanted here.
+	 */
+	if (!IS_ENABLED(CONFIG_CI_UDC) || !CONFIG_IS_ENABLED(DM_USB_GADGET))
+		return 0;
+
+	dr_mode = usb_get_dr_mode(node);
+	if (dr_mode != USB_DR_MODE_PERIPHERAL && dr_mode != USB_DR_MODE_OTG)
+		return 0;
+
+	ret = device_bind_driver_to_node(dev->parent, "ci_udc",
+					 ofnode_get_name(node), node, NULL);
+	if (ret) {
+		dev_err(dev, "failed to bind ChipIdea gadget: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * An OTG port serves both roles, so stay bound as well. Neither
+	 * device is probed here: "usb start" probes this one and puts the
+	 * controller into host mode, "ums" and "fastboot" probe the gadget
+	 * one and put it into device mode. A peripheral-only port is of no
+	 * use as a host, so hand the node over completely.
+	 */
+	return dr_mode == USB_DR_MODE_OTG ? 0 : -ENODEV;
+}
+
 static int ehci_usb_of_to_plat(struct udevice *dev)
 {
 	struct usb_plat *plat = dev_get_plat(dev);
@@ -774,6 +811,7 @@ U_BOOT_DRIVER(usb_mx6) = {
 	.name	= "ehci_mx6",
 	.id	= UCLASS_USB,
 	.of_match = mx6_usb_ids,
+	.bind	= ehci_usb_bind,
 	.of_to_plat = ehci_usb_of_to_plat,
 	.probe	= ehci_usb_probe,
 	.remove = ehci_usb_remove,
-- 
2.55.0

