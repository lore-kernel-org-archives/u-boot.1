Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49428606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tt0vbH6A;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=TWmoV8G6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2200140719;
	Tue, 27 Oct 2026 10:06:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PsGi_UdSdS2C; Tue, 27 Oct 2026 10:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3BD5440651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095566;
	b=ggzmGcmNjmiQHCy/kz0osUzRlhzOstbf5iEYNW2zbd+CJnktIbB9kqLUJpchceySHeBk
	 VW/bkzJMCRRWmNvbW+le1OF1UcFUGArclk1a43B9ij9jBtgWVKvA/QZWnUcO4RCVNUVcy
	 HX0K/7HSz31EhYA4yDbTogwa3RxFvQlxxzWeusx2xxNM9qlMexV0Mqx0S0hCY4+w7zRcv
	 X2fI5pMacIS/dU/+liBlAQVt96dYQVgt/ctGm0GAWsQUSEPDTmtaiZXlvFdXko5FCE+nM
	 JWiW7qSrl8GvpJ1nfR3ZVII82IY23fstIe/QR74JM5AlDXutr4ua9VQynnWydmorYkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cRXmrvVOr6y8TI9OxN83LVmiu2K83sCbcIqogSijSXQ=;
	b=fJNFyzB9VPmMyu6hTKF/d2Ml6QkmUbMIov9NsRS1zwVSQ7RMK1kI67UofjznDvydYcY/
	 00bDYoeXFJiWp5P+FHV+vcF40ircSfznM4fnqrJjtvbeGcIrlUg561T2HauPtUekoJkkE
	 tPol7zlAGU/3pA5qDva/kIkvn4AX3l/BSgccrTsycG9+Vw526BOsNjiwanAFKC5lHmnFt
	 7fC0zztVoBoTZwVWaPUxiOjDjyEIhU3OXEi14VGMnxF8GjJebqcTkGQfuXjEhNnPdzajC
	 nUneR8V0C4AH7DLbR4py+oFtZlebWKtbPv9/Q6mcvqA+GIyycr/z2hdDuW7/KON5Iig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=TWmoV8G6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095566;
	bh=cRXmrvVOr6y8TI9OxN83LVmiu2K83sCbcIqogSijSXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tt0vbH6AW+taOauuQ86TROd8hYCwUMyiraiLBaqcMMwxm/2oR8HNpA4+2c3P3Zb7f
	 nAKMkXTRLN225oZLUTezCTm98sxgWnUPzDRhS1C12cl9QRXcmc2A8ZG47hIgvJs4sa
	 xERAVxjRFHio9oYt6h+EGE8o10hFMu3m/mw09FMSFR+j/tfSdCVBty2bVu21klSGct
	 RArWiCymb2UN9+dIb0qv764N5BgG+105cz+GxkBsg2gtubKtx84goJNG6fgE2ht2De
	 E1/M3TGthhsyGdzCpfXVP+uawerU5NnrPH8djTVH7WTufTsWyYISNRph0VgVNsUHy/
	 SsLaGgyzT0a8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BD5440651;
	Tue, 27 Oct 2026 10:06:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38E49120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A7CA406FD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6KpVpHV3F2A for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A0F2406CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095554;
 b=rzoDpHXtg+zHxMs1EPhbV4UDPhxzwrIfbcU/yXTywI6+/WLMG0CRqaj/FCmnjm+wL8VF
 ZkWEcEM3dN3twK1zHyElBKWneQKiodmFGKnGnfaryOKdZmHZrAdVupaU3JTjCTU0rmhT/
 y0EhAyoVqu9bl5QF+4CPhTllGXKoJXA1JIB3jKnrpUNHTst/MTHafnmIjdja0bhpFd9W0
 DGMGRAAgHOG7fmJNSmOZPlnL69zSTc2uLm6DEol9iZwWDe86FWk7h5rEGNOpTI8AA+KDc
 X2CuCip54qc9G/uenxW9JyzjQWften6Guh3LtZQ2aMkPZJ+wBBS4CgYDooalrVWcwdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095554;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=cRXmrvVOr6y8TI9OxN83LVmiu2K83sCbcIqogSijSXQ=;
 b=eVUtfqGCvuUgUMtzXHI//Ei/M9x8GG5HeooXaAN/HedfuhnwCjCniVtMOl/mYdsKJzv+
 1OKPQCjF48VjPA3o0w/cxDa21MRYqRPZ0pyJ36sH3CSeTQ+GDzfx9SyWZAwspViVzFBe1
 Vx5MIipx6GE7CEE/4XAZGu4rqKg2y4SZptNjiZG8eBaeJEbyc8zlXWufSsLQskt/+9/Yp
 SJn7HRJwqKhFy2uAtnXpLKAVi/tSIfWMSWJA6vwoNgRJ624Gn7iq8SwR8CJvhSlhosGMa
 4MJEDS45ZnboGkVkBNnd9HKpg37blT+AB8PsV8qMW5VKattVN7Gqq+YeS7UStzSUkrQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TWmoV8G6; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TWmoV8G6
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A0F2406CE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cRXmrvVOr6y8TI9OxN83LVmiu2K83sCbcIqogSijSXQ=; b=TWmoV8G63EMv2ThKxUuq7jMk+s
 N/I45eIw09hNHcUpaef/7uNvQfPZECgo3reQC2H4N6nASWni+KqpOuSQU/pzOhcclryL+6apJSF79
 Jhz0Onzi03wbl6ZDvjiT1TyKNuswli37FvOw/9Me4iDMgxCfYJpS+Z25LcJ4JgzGUlkiRYrpZcyL/
 hOVZO5eLCkaxViz1zqPZj7gKiJQ9x0y3wYvSuEJ1nwbHncJ0FsXq/RQuEvoqKN2/WRBabHajRJG7e
 Wi4R855oZlGe3B16oAP2vtIFS7VbsuNPSeKfORwyCJNkLkilTxrEXXgMXam/RcNTxWGikLZWIY8wM
 BUZYhanQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe40-000C1I-12; Tue, 27 Oct 2026 11:05:52 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfH-00022y-0H; Tue, 27 Oct 2026 10:40:18 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 12/16] usb: ehci-mx6: handle fsl,usbphy with CONFIG_PHY
Date: Tue, 27 Oct 2026 10:39:09 +0100
Message-ID: <6c0380143ffb2f27b79d3140a3356bbf80bce6c6.1793091394.git.nora.schiffer@ew.tq-group.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace generic_setup_phy() to handle fsl,usbphy in addition to the
standard phys property.

This allows the USB controller of the i.MX7D to work in HSIC mode if the
following configs are enabled:

- CONFIG_NOP_PHY
- CONFIG_IMX_GPCV2_POWER_DOMAIN
- CONFIG_DM_REGULATOR_ANATOP

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-mx6.c | 47 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index eae18e22c57..c804af8ab45 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -571,6 +571,51 @@ static int ehci_usb_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_PHY)
+/*
+ * ehci_mx6_setup_phy() is equivalent to generic_setup_phy(),
+ * but additionally supports fsl,usbphy
+ */
+static int ehci_mx6_setup_phy(struct udevice *dev)
+{
+	struct ehci_mx6_priv_data *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	struct phy *phy = &priv->phy;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "fsl,usbphy",
+					     "#phy-cells", 0, 0, &args);
+
+	if (ret == -ENOENT)
+		ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "phys",
+						     "#phy-cells", 0, 0, &args);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
+
+	ret = generic_phy_get_by_phandle_args(args, phy);
+	if (ret)
+		return ret == -ENOENT ? 0 : ret;
+
+	ret = generic_phy_init(phy);
+	if (ret)
+		return ret;
+
+	ret = generic_phy_set_mode(phy, PHY_MODE_USB_HOST, 0);
+	if (ret)
+		goto phys_mode_err;
+
+	ret = generic_phy_power_on(phy);
+	if (ret)
+		goto phys_mode_err;
+
+	return 0;
+
+phys_mode_err:
+	generic_phy_exit(phy);
+	return ret;
+}
+#endif
+
 static int mx6_parse_dt_addrs(struct udevice *dev)
 {
 	struct ehci_mx6_priv_data *priv = dev_get_priv(dev);
@@ -700,7 +745,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	usb_phy_enable(ehci, priv->phy_addr);
 #endif
 #else
-	ret = generic_setup_phy(dev, &priv->phy, 0, PHY_MODE_USB_HOST, 0);
+	ret = ehci_mx6_setup_phy(dev);
 	if (ret)
 		goto err_regulator;
 #endif
-- 
2.55.0

