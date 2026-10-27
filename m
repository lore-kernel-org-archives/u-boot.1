Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA4606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T1aUutJu;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=R9PYT/fc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC38240770;
	Tue, 27 Oct 2026 09:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-dBRgVOH8lO; Tue, 27 Oct 2026 09:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9A5B40774
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094040;
	b=ldHj0DF6GMrbpUXrSwoAD5aJJrYz7Jc+sTJK6zGCSzvsMpTKOrrgsQhePiFvhsQOqg2P
	 Vs1vJcG7S4MTduDRBhoBAzZlo1YSxkyRuS6uKr2DKsg71km14oB0WijH6AUFAwN5BUwbw
	 Wzid2qqgkbMwLDwmU104jz8St6wCySYVIVzL6CmUoMdxJn6LuhtD1iQl5YvDrpbtRxbik
	 WTdYAAUbVFAWGJpNBUMUi25xO9G24JDFX4qJ6F6p8mydcfsSogxa+/d1bKkdJvrjdahsY
	 JBB6tGWDbLJID+WLR/WL9oP78M+YbXroeC5HyrWM29jDOJRj3aAhOlLNh6GsYBzm0Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=18sJdc0/J1i0Cc9cySrO5dPjY1B6rg/PDAn3MpP9p1Q=;
	b=h2zO+hZCYBhrN+KIGDuc1G95i/0jRWSRdQLT9e/uZum8QDHJ4rkGm9EYXymA+LUHXaw4
	 zVnNi5XHyuBWqDrEuLK1GlxatFgvAFRI08SuN0Sf8jMdj+Dc33P6LH1gg/HBncEZCqAT1
	 mXfa6YkJl4VIGriqDVpC74YZIKk8sIXxcqU1802hhqjrkB4feYoWYyUf9nz64ks6UjQLV
	 vxAaI2M7h6YPYeFUuyyQ+2NeBSeFaPQ5CnTCzjIQkFYZXYfFeA+YgC9Bm+uVrYH2kAbPp
	 IqW5Xf1oCsqSM6HmYXrG2B0V7LXL6bor+9Ia7zKDV433jxkmIbckxpw1nnFTwkWAVpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094040;
	bh=18sJdc0/J1i0Cc9cySrO5dPjY1B6rg/PDAn3MpP9p1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T1aUutJupvUwPzmJUmiKji8jnnBquMi/OOAreiqKydDld6/yObrloujnl85jQSxqN
	 SGuCZgai7Mcv2+NCDlipyWV4qGU3a4cOm+o352HjG10BzeF7tsoeD+Go9qVb7JAPXs
	 sVnpgwAQUV0BeqDhdM0gJKMgeWNa+O9Ozvl65eev1FB48k8BGsHLJKjctvnYEoc/Du
	 jMfKnwtA5u17YP4alFfRo/XCUMUiD8cFFecuUjoeqqU83blex7rugl97X1qjWCgyFP
	 L5YAWwP1Hyd0fprrbZk9V3RvK3YimNu3Rm9+wZGCvqbj79ljirtj36DB36Wdddl4Xj
	 QyYs1h34m6UPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9A5B40774;
	Tue, 27 Oct 2026 09:40:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8782C1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DFEA400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62T7ZFGcsh0f for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 843FB40042
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094022;
 b=mqaBb+hak+lYH7tQeRj8WBLViFrmSq4KET9gJ/oWM0lOdBWr5Pp2ciI0Z3UTliTFJ3av
 Frvph/KffH0Eyq8PFPc4sZAUr8Jj+NhuK8C4Vn7NS455q7rBXmRh3c6F8HgrNiWHYHY+b
 OqmFLoTQt5CJaoROX4MPY6ey7DReaN2ycC8u5LTtU+dwT7uYDJCSyt0Zq9/s/84H5S5mW
 cEAMoFxQdiY3g4wrJ7kvy3iLkEuObBTglSS0V7N83xmyqAG/WE3Quz71CxM9fr9uq417B
 tTCtZwwj0E8XXzfbEanXlxJGLeXIX+Z3El+D+BBato9skZXJAvtxzuzbHDiyQ4Ug4Jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094022;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=18sJdc0/J1i0Cc9cySrO5dPjY1B6rg/PDAn3MpP9p1Q=;
 b=NvFxjf6n2tCgqd3yiLy+COvCJ2ncvnHAwDsiJHi4TaTJkQlM/5muJI0nAFl8eXAiEINc
 Vl+gC89IbFs7AxMcRAcvKSP4Ba3UAK5jSP0eM5uIfbD31nh8rwlTxuIFgw/NDKVk0dAgQ
 fyo/6hkKbu0lB2HN9omWYGY79styBbDqxJmFjFdgvrBkQ+N1guZQlzQSH69Ke5xBohV3m
 Huh9ZKw/uFyWxw6Wn89AWDDjSUknTCfdnZB7ubFilOGWsITFuorq3pxHLYlqNjZXdw1SK
 xGjjs2sPnbS/XXk74c5uBZw3c5GJlngOXMlvYzrNK0oJ3pOXRRm4QLTx2XYjMYPQdsw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b="R9PYT/fc"; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=R9PYT/fc
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 843FB40042
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=18sJdc0/J1i0Cc9cySrO5dPjY1B6rg/PDAn3MpP9p1Q=; b=R9PYT/fcH85Kq0QY1ndiWTKVCm
 xVLILyn36E0jb4bFB1aXD5v39mfV47xJ9qVLq3K30B4HbtsT3gRXZK0/X+Kex76J8+WO3cjn7BK01
 ZvsIBQN0DKXQ7OWWzhB40NP2YGVQ/w0MJvOF/Kz9/27Bd4u/9EdTDt1mUUeSVTzQntiQ0h653smVx
 c+/OrEsP3p6wLHDs8Jl9sfxUyp07oJbENRvQo3P0N86TgdvSLSnHvHsGzf+Xm04dypXVQLjDUFTCe
 E5PVJo+lCYzfpauy0Fsi65NTrlN6y496NaS4CvzrfmEItFjie7oj+oHG282xku11n9fsAchD9xjbg
 9HS8o9WQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-0007Wm-2t; Tue, 27 Oct 2026 10:40:17 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfF-00022y-3B; Tue, 27 Oct 2026 10:40:17 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 09/16] usb: ehci-mx6: set up i.MX7D misc registers regardless
 of CONFIG_PHY setting
Date: Tue, 27 Oct 2026 10:39:06 +0100
Message-ID: <bd8f810425b7d3f8d1d78fc699b232da5a7ea60a.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While a separate usbmisc driver could be added, no such driver currently
exists, and it would not necessarily be part of the PHY subsystem. Rather
than making the misc setup conditional on CONFIG_PHY, make it depend on
the existence of a fsl,usbmisc property. This will allow enabling
CONFIG_PHY on the i.MX7D for the NOP PHY driver's power domain support.

Also update the code that reads the usbmisc address to use the modern
ofnode API and fix the portnr to be determined from the usbmisc phandle
arg instead of the alias seqno.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-mx6.c | 65 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..16a45b82399 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -141,23 +141,21 @@ static void __maybe_unused
 usb_power_config_mx6(void *anatop, int anatop_bits_index) { }
 #endif
 
-#if defined(CONFIG_MX7) && !defined(CONFIG_PHY)
-static void usb_power_config_mx7(struct usbnc_regs *usbnc)
+#if defined(CONFIG_MX7)
+static void usb_misc_config_mx7(struct usbnc_regs *usbnc)
 {
-	void __iomem *phy_cfg2 = (void __iomem *)(&usbnc->phy_cfg2);
-
-	if (!is_mx7())
+	if (!is_mx7() || !usbnc)
 		return;
 
 	/*
 	 * Clear the ACAENB to enable usb_otg_id detection,
 	 * otherwise it is the ACA detection enabled.
 	 */
-	clrbits_le32(phy_cfg2, USBNC_PHYCFG2_ACAENB);
+	clrbits_le32(&usbnc->phy_cfg2, USBNC_PHYCFG2_ACAENB);
 }
 #else
 static void __maybe_unused
-usb_power_config_mx7(void *usbnc) { }
+usb_misc_config_mx7(void *usbnc) { }
 #endif
 
 #if defined(CONFIG_MX7ULP) && !defined(CONFIG_PHY)
@@ -380,7 +378,7 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 #if defined(CONFIG_MX6) || defined(CONFIG_IMXRT)
 	usb_power_config_mx6(anatop, index);
 #elif defined (CONFIG_MX7)
-	usb_power_config_mx7(usbnc);
+	usb_misc_config_mx7(usbnc);
 #elif defined (CONFIG_MX7ULP)
 	usb_power_config_mx7ulp(usbphy);
 #endif
@@ -431,10 +429,10 @@ struct ehci_mx6_priv_data {
 	struct phy phy;
 	enum usb_init_type init_type;
 	enum usb_phy_interface phy_type;
-#if !defined(CONFIG_PHY)
+	void __iomem *misc_addr;
 	int portnr;
+#if !defined(CONFIG_PHY)
 	void __iomem *phy_addr;
-	void __iomem *misc_addr;
 	void __iomem *anatop_addr;
 #endif
 };
@@ -465,7 +463,6 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 
 #if !defined(CONFIG_PHY)
 	usb_power_config_mx6(priv->anatop_addr, priv->portnr);
-	usb_power_config_mx7(priv->misc_addr);
 	usb_power_config_mx7ulp(priv->phy_addr);
 
 	usb_oc_config(priv->misc_addr, priv->portnr);
@@ -476,6 +473,8 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 #endif
 #endif
 
+	usb_misc_config_mx7(priv->misc_addr);
+
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
 		int ret;
@@ -576,12 +575,29 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 
 static int mx6_parse_dt_addrs(struct udevice *dev)
 {
-#if !defined(CONFIG_PHY)
 	struct ehci_mx6_priv_data *priv = dev_get_priv(dev);
-	int phy_off, misc_off;
+	struct ofnode_phandle_args misc_args;
+	void *__iomem addr;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "fsl,usbmisc", "#index-cells", 0, 0,
+					     &misc_args);
+	if (ret == 0) {
+		if (misc_args.args_count != 1)
+			return -EINVAL;
+
+		addr = (void __iomem *)ofnode_get_addr(misc_args.node);
+		if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		priv->misc_addr = addr;
+		priv->portnr = misc_args.args[0];
+	}
+
+#if !defined(CONFIG_PHY)
 	const void *blob = gd->fdt_blob;
 	int offset = dev_of_offset(dev);
-	void *__iomem addr;
+	int phy_off;
 
 	phy_off = fdtdec_lookup_phandle(blob, offset, "fsl,usbphy");
 	if (phy_off < 0) {
@@ -590,30 +606,14 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 			return -EINVAL;
 	}
 
-	misc_off = fdtdec_lookup_phandle(blob, offset, "fsl,usbmisc");
-	if (misc_off < 0)
-		return -EINVAL;
-
 	addr = (void __iomem *)fdtdec_get_addr(blob, phy_off, "reg");
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		addr = NULL;
 
 	priv->phy_addr = addr;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, misc_off, "reg");
-	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	priv->misc_addr = addr;
-
 #if defined(CONFIG_MX6)
-	int anatop_off, ret, devnump;
-
-	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
-				   phy_off, &devnump);
-	if (ret < 0)
-		return ret;
-	priv->portnr = devnump;
+	int anatop_off;
 
 	/* Resolve ANATOP offset through USB PHY node */
 	anatop_off = fdtdec_lookup_phandle(blob, phy_off, "fsl,anatop");
@@ -693,7 +693,6 @@ static int ehci_usb_probe(struct udevice *dev)
 
 #if !defined(CONFIG_PHY)
 	usb_power_config_mx6(priv->anatop_addr, priv->portnr);
-	usb_power_config_mx7(priv->misc_addr);
 	usb_power_config_mx7ulp(priv->phy_addr);
 
 	usb_oc_config(priv->misc_addr, priv->portnr);
@@ -708,6 +707,8 @@ static int ehci_usb_probe(struct udevice *dev)
 		goto err_regulator;
 #endif
 
+	usb_misc_config_mx7(priv->misc_addr);
+
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
 		writel(mx6_portsc(priv->phy_type), &ehci->portsc);
-- 
2.55.0

