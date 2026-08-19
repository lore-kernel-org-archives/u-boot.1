Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61679C5DF81
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 14:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7FD740642;
	Wed, 19 Aug 2026 14:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5WswvKr9035; Wed, 19 Aug 2026 14:35:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787150152;
	bh=PZO/Ra7+EbM/rOuynszJysppY2j0F4sDDw0Jw3vVmpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E9bEk3K5vuZ3j7ihLj6IiJWBQpEEII2mA+UhIocF/+3R3s37aDz9GYbey2FiV1a+q
	 8cw7B1HpEVeeKF+v1L8MxtzRGXJLijG2rO1PXzGAKHgeB72HSddLTxy2WBx7V69viJ
	 OzhyPNK9LZpEoUrwgFzk2HZxT3rOchyKPrsc5CgAUhyboDFIFxJGAAV/x79tlz11Vj
	 773Du69WO3iw2/YzD0bTBOEXy0yEfm+NZeFECpTxZKuq98XdbOg4Chz+JnEdCttfiI
	 11aoRBbvkgCmyqfXqYdRtR2TKliOLuOgxRT9NIE3U4claFA9HCOoIdZQah0twKfvaS
	 8VNKoVO0unDiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 149F740629;
	Wed, 19 Aug 2026 14:35:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 503473AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 421C740140
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2EUmnp4F6X6 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 14:35:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oCfR9Sd4
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51C9B400E3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 14:35:49 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so10599295e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787150147; x=1787754947;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PZO/Ra7+EbM/rOuynszJysppY2j0F4sDDw0Jw3vVmpk=;
 b=oCfR9Sd4JRnSAxsUUHKGSVUrE2NrF2kuI9rgpAXi51frSkBLDwkpN3EwcJKJa5zFIu
 OxZlVOUBQyE7MCc8z5E4Bk5Fp4AXyEp8zClh9c5x60VLMqppVQco4+wM+rfsE/y1/zBQ
 YnniQ0xgz5kPJESoaC7ktp7j4D7//3NiOHO3d6ZaO1NRLspj2pXNbNp1W+KYvqwMtcI9
 4TeqZD0Sl+CLfPnww+zb2vfV2dAq3I49NO/Psc/za8VlidyMcz7wRu8x/lscgg1F3PN9
 qY99ThUPPcaJuyXNOU7RmBQqXhP/ldWcLxRvClJWPKsFEgI/1XqXBziR+vKCQZYo2yfs
 Thjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150147; x=1787754947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PZO/Ra7+EbM/rOuynszJysppY2j0F4sDDw0Jw3vVmpk=;
 b=N/HWKYnl0ULluYrjucj9Bj8+9rsLXKb/uDE4m4MlZVnG4AAsxtiaWd5d3XSzLhD5+Y
 3gknND2bJ2SXCtknvKTkqIcdoS/AgsI1oC3vwNoQEj4hczKQMI0eJK/vOsb/1xcV7yxW
 T4fNBW8ts091IeZK3xleGhaQuL1qNS0YuUk5VNTTuBBSPCtr3W2v2UJT+Ib7N5+SQRY5
 Yo/klqVm+CuJYRX11hlNC/died7JJex5NXuz42ZcoGXqSci2jKeIgzUXLnleAlve+n6g
 7VuxuSVRoHufFAG+um9S/WyVqTGchQpQdp9UvhXVT2c2avVF9DP3UL5aKcB6JO7eXdw6
 VCEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRrtlkDpjQA3tzj6lIFT+PzOVlkgPkr0DZThJYRqeNR4qQL7Z+gj0M6mtUI4U8BIE5uj4r8mI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzRNLupu3k+tGRIP7jIc93uka1SxOjVaEkqN0LXHEqK5TOHexjK
 SfVxxpv7wY3B5tZ1n/8Lvfq8qLKTa8ymmeEqylqpOA+dzzHM538RTJwR
X-Gm-Gg: AR+sD12nqYutKUVHe9iC1pNfsqxOWryGarifCfK58Yx0azhCrHMJJN4UjoSxsOnrzcd
 MNAuzFlcqEI7j2PYXR1Zxa83GwsjMICc5EM5P460WsF83AaYWiXyrdbY/peKG2ewASa0n7I51gd
 CnjsWATvE7SZ+9RMqEvR+Oj5tkDr0FYjk3IVAaG5sUGxnKTmWNTInYylECPXPT1Vnd9gBUfRgA8
 OtPbWk8FwcTlCBgFxUkELrexhOfJtxkXpM3g1G6eVspS5QvljAjxnF8Na+MAUQOaLhx7OAgWB5J
 0tdsTQmvbUGWtN+v8/Tex2bn5I0UDvqEbu54okB7P22Cd8N0sK03WoKGIsDPPTyW1ElwNo8pZ3M
 BPeENTxFrY31ZG/2gvIvjjDNKHAGZmTQQedjlXafpJ1PQvPbVtTpZvt9pQDPfKQaVlbRAD+dWDh
 w47kmF8M6P29kyi5VNkE1HUK9LxBVwHlvx3vc6Kq8Qj4RzAFQf9F6ssVr5M0wVlnYIXA==
X-Received: by 2002:a05:600c:3593:b0:499:841c:2016 with SMTP id
 5b1f17b1804b1-499aa0ff5a0mr113761475e9.0.1787150147175; 
 Wed, 19 Aug 2026 07:35:47 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499affa25acsm3811405e9.4.2026.08.19.07.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:35:46 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 2/2] usb: ehci-vf: enable the vbus supply of the port
Date: Wed, 19 Aug 2026 16:35:43 +0200
Message-ID: <20260819143543.427396-3-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819143543.427396-1-mehmet.fide@gmail.com>
References: <20260819143543.427396-1-mehmet.fide@gmail.com>
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

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND, with a USB stick in the host port:

  Colibri VFxx # usb start
  Bus usb@400b4000: 2 USB Device(s) found
         scanning usb for storage devices... 1 Storage Device(s) found
  Colibri VFxx # usb storage
    Device 0: Vendor: SanDisk  Rev: DL17 Prod: SanDisk 3.2 Gen1
              Type: Removable Hard Disk
              Capacity: 61584.0 MB = 60.1 GB (126124032 x 512)

Reading the partition table and blocks off the stick works.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index fb305569a15..4ac7f8bf53f 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -21,6 +21,7 @@
 #include <asm/mach-imx/regs-usbphy.h>
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
+#include <power/regulator.h>
 #include <linux/libfdt.h>
 #include <fdtdec.h>
 
@@ -54,6 +55,7 @@ struct ehci_vf_priv_data {
 	struct anadig_reg __iomem *anatop_addr;
 	void __iomem *phy_addr;
 	void __iomem *misc_addr;
+	struct udevice *vbus_supply;
 	int portnr;
 };
 
@@ -144,6 +146,16 @@ static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 	usb_internal_phy_clock_gate(priv->phy_addr);
 	usb_phy_enable(priv->phy_addr, priv->ehci);
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR) && priv->vbus_supply) {
+		ret = regulator_set_enable_if_allowed(priv->vbus_supply,
+						      priv->init_type !=
+						      USB_INIT_DEVICE);
+		if (ret && ret != -ENOSYS) {
+			printf("Error enabling VBUS supply (ret=%i)\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -288,6 +300,13 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vbus-supply",
+						  &priv->vbus_supply);
+		if (ret)
+			debug("%s: no vbus supply\n", dev->name);
+	}
+
 	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
@@ -315,12 +334,22 @@ static const struct udevice_id vf_usb_ids[] = {
 	{ }
 };
 
+static int ehci_usb_remove(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR) && priv->vbus_supply)
+		regulator_set_enable_if_allowed(priv->vbus_supply, false);
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

