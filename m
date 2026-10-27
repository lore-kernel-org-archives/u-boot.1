Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F5606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K3vVgc/o;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=j0GOYfmP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A948406FD;
	Tue, 27 Oct 2026 10:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWL6rMJKDh0o; Tue, 27 Oct 2026 10:05:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20C5B40689
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095558;
	b=nupH+p6CrGn8kT6wcJFfmQ8/xeoOj3yYY2hTmQ5xmTfo8bi/clKmJcvn9MTLkMEFBOPt
	 +YyCMZPuNTNFmp4kaaZmPPncTTMc03bv9XVQpuMezBvWao/m+uKKCPldgaf4cKbEKNAST
	 j09U7XlQpFQEoVK6i2G4HZ2c6OO1XBL8Jp8QTMEHosgrMdgQMUsnlGS8WKWO/9i7NlXXT
	 NtE+TDmOpjujqg/Aviz2jSF95eGofkCUVYvldLBycpnALmSd01Gv0O993SHx2FFmf84k0
	 cDd5aasdq0zcwicQ4afsV0zeomEW16S8qGTBZVMxmPKuWNoawcAVSwCl5rFv+YbpFtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B6u7PxDrZzsJ2CzopRbygGjEc7d9dbqqRFDhWgtzv0Q=;
	b=NYdxOm5eFmUC1bGXYqOnFcOcLk0npyCHz4f+eqMY+Hjf7ab1ihYaye5v7zDD3X4D4pBC
	 e9jyxCUJXv1UeG6INehoQ7pnyVIGabUGQYoIcwYQesqPGcR6/U16o5ubsm1P1aDGi7q6s
	 RaQu5d5TeInNsVM5klzZvZtESLPwi1hIs98ltD2/at7KayDssDvafQ7Lcxg9J4YyGI3Mk
	 5nWYKqjGyVz/nmYQhcxI+7GVMZ+1WjQwLH8ZYqV+UodoLivbPL9f3+Sz22U0cf5aEgkpH
	 vCUqSb5BpH8Whghs1ZYfVrvRbTRQQ8t+snT99MgQvvYZPg5Km0pTAvnZ0Ky/FuWcabA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095558;
	bh=B6u7PxDrZzsJ2CzopRbygGjEc7d9dbqqRFDhWgtzv0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K3vVgc/oZ1A734OR6Y0w+s6n+f5KaeVMXB8N3mW7LnbmcZvC8/R/Kk27FKJMCGCR0
	 POK04IA+4K7T4IKJb1VmqDldMmdA9XXO6PSPInUVGXbJQJnj+UXwCMYl5jhisBYgAz
	 GF0hVEJi8jGJl/aWlrYU0sigzplQEsH+2kb7mIJoKc/jXZjW0Rn1fAgrjl8919wfRo
	 DNoSgAPEVL9dNhnvp6FDIlz83QEYWLJEiqgSPkxe9Yn+HCiGGuRoRJchwiGeNQdvFB
	 HvjWp8WmQvQg2rniYplcb1QXvwwqDFFmuFAaCunJWUT3J9ou9OLAlPx+zCS/Q6oQxl
	 CFXyQ07A0v3cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20C5B40689;
	Tue, 27 Oct 2026 10:05:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D4DC872
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C72B080D58
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jfD0c7xOEN7b for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F172F809F5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095554;
 b=LJva+FdbTxBLdfmNzsUBOG4dtufqvXMpvGlZVd1dtT7ZMCLyi3nrUw41wnBnf7sb6Ate
 LnwuF7pKOJYV1UVCHAGhRU4DaovkGTMkob27r8lw77VItMUWZI9MxZprxtSKUNGMjuXGv
 kST3y9a+VNJW4c3WiSo9ybuTmQyV9N6fg/szYWf6KnWoAKV3M/JcrxE/t+zMrHGowTWmM
 4dA3Rf0eubYHjmvJReCyGIhQTdsqWN799uGJ+8ujEiumP4nnM9Vhg0dccGdk7zNsxtyVN
 S4zU+rnFNSRzzy/kCqp8kYPiCNOUC/fXGIxNJIqcCWThUpoVINJKpP0X0L7Z/EKxYcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095554;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=B6u7PxDrZzsJ2CzopRbygGjEc7d9dbqqRFDhWgtzv0Q=;
 b=pvh6c5aHXZ2eXGmKAyTXy4yYmhZbpScQ9WdusbIdSqyU497FlJ32JqInzLJw7nPIRA5B
 ugm/+DZ6H7o0JY8toeSbB3qkC1I3e+2KQEqRlN1Z1aZ4zub9jXeUR8UOCxYKPsyQwR7kR
 NU7/8SNfaAE7gIbpCjecvIM3vgmLyPndVYY1h5sfTeg9Wv50dvgq1DvpCVh+3BCC9ux6u
 9GAwMmK4CCqm9al+0J30DSuKzaSfb5oZYaCfcJsvfDwNyU0rPiCkNy+/S3rkKkAficO4r
 zR3uofd/oFm90YlUOKu1Uhs7NAonpSBm290axJdqk/SlQEFNmaHXps/Ffwvh0i6LHjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=j0GOYfmP; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=j0GOYfmP
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F172F809F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=B6u7PxDrZzsJ2CzopRbygGjEc7d9dbqqRFDhWgtzv0Q=; b=j0GOYfmPUM3cImgnNq7VBCQlXp
 s+OmDrVGDNAUxLrJOwd1vGQwdmysA+DBizT6mdxVLb9n2I4XJDBYMu7AUZWd7cFsi8cjh7oipyWl2
 aI3cc7NkkWIWlFcg5c3bF7brMCGaWlhLaXBmIsYfHB70RqKuX9IIOPziPy6Sems9ZZ9PZkCDWmU7u
 406ThJoYOsgeMfEpFZ45BF11Qi6yhwgGXI7so/mso2rTIXL4bLddX5fBeZqB7dxcK2JrJkCOomJmg
 4r3DqHoaA1TiEcsk/XaQmYNjGArZRoH134mNgN6iL9U5eFNnu5QQgDezxzf8HxwE9GHAVtkPDrYSq
 0LthD1/w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3y-000C10-28; Tue, 27 Oct 2026 11:05:50 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfG-00022y-2J; Tue, 27 Oct 2026 10:40:18 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 11/16] usb: ehci-mx6: add support for power-active-high
 property
Date: Tue, 27 Oct 2026 10:39:08 +0100
Message-ID: <0bbbbf7c0043510fd6c10f0ab8d94c68c8ca762e.1793091394.git.nora.schiffer@ew.tq-group.com>
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

Support the same property used by the Linux kernel, obsoleting the
CONFIG_MXC_USB_OTG_HACTIVE Kconfig symbol.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-mx6.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 84e2328a767..eae18e22c57 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -264,7 +264,7 @@ int usb_phy_mode(int port)
 #endif
 
 /* Should be done in the a imx-usbmisc driver */
-static void usb_oc_config(struct usbnc_regs *usbnc, int index)
+static void usb_oc_config(struct usbnc_regs *usbnc, int index, bool active_high)
 {
 	void __iomem *ctrl;
 
@@ -274,12 +274,10 @@ static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 	ctrl = (void __iomem *)(&usbnc->ctrl[index]);
 	setbits_le32(ctrl, UCTRL_OVER_CUR_POL | UCTRL_OVER_CUR_DIS);
 
-	/* Set power polarity to high active */
-#ifdef CONFIG_MXC_USB_OTG_HACTIVE
-	setbits_le32(ctrl, UCTRL_PWR_POL);
-#else
-	clrbits_le32(ctrl, UCTRL_PWR_POL);
-#endif
+	if (IS_ENABLED(CONFIG_MXC_USB_OTG_HACTIVE) || active_high)
+		setbits_le32(ctrl, UCTRL_PWR_POL);
+	else
+		clrbits_le32(ctrl, UCTRL_PWR_POL);
 }
 
 #if !CONFIG_IS_ENABLED(DM_USB)
@@ -383,7 +381,7 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 	usb_power_config_mx7ulp(usbphy);
 #endif
 
-	usb_oc_config(usbnc, index);
+	usb_oc_config(usbnc, index, false);
 
 #if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
 	if (index < ARRAY_SIZE(phy_bases)) {
@@ -431,6 +429,7 @@ struct ehci_mx6_priv_data {
 	enum usb_phy_interface phy_type;
 	void __iomem *misc_addr;
 	int portnr;
+	bool pwr_active_high;
 #if !defined(CONFIG_PHY)
 	void __iomem *phy_addr;
 	void __iomem *anatop_addr;
@@ -472,7 +471,7 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 #endif
 
 	usb_misc_config_mx7(priv->misc_addr);
-	usb_oc_config(priv->misc_addr, priv->portnr);
+	usb_oc_config(priv->misc_addr, priv->portnr, priv->pwr_active_high);
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
@@ -690,6 +689,8 @@ static int ehci_usb_probe(struct udevice *dev)
 		debug("%s: No vbus supply\n", dev->name);
 #endif
 
+	priv->pwr_active_high = dev_read_bool(dev, "power-active-high");
+
 #if !defined(CONFIG_PHY)
 	usb_power_config_mx6(priv->anatop_addr, priv->portnr);
 	usb_power_config_mx7ulp(priv->phy_addr);
@@ -705,7 +706,7 @@ static int ehci_usb_probe(struct udevice *dev)
 #endif
 
 	usb_misc_config_mx7(priv->misc_addr);
-	usb_oc_config(priv->misc_addr, priv->portnr);
+	usb_oc_config(priv->misc_addr, priv->portnr, priv->pwr_active_high);
 
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
-- 
2.55.0

