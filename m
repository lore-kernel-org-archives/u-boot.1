Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49374606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yjxTEqUA;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=K1Odx7+V
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D4194073F;
	Tue, 27 Oct 2026 10:06:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G61j4-FjAu2f; Tue, 27 Oct 2026 10:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E8E740742
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095568;
	b=WRZ4DF9bg9HpbiPHuYBSb/wjc1YIWn+6r6Pgud/unekKoAMuOEUwlz8xsfRnmskR11Cm
	 GMXNAKn1CEppy4ZWZHLmFNo/o+s1V/FW0CvFt6DIOclknU1YpKcmBZmI1Ne7J+yo05uqa
	 P3ln0opbqhMRuIgr0tOOZuHmZl3+8N/G0luNJ/xmN1AUv6qbs3dZw4lrTEj6CmOkMePPA
	 NlF0Qd2ltOO20FK+l2ifReesCO8tlDqMi42poCor7R5Da6obZZipjoDanNCtC26i48D+h
	 vKDO8gPiUpPRZumuTzDS1vACJAufL9FmHN+1E5XVEseOhFN4HIUuGAjxMbXuXmSEVrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vaIVNRf7eijikOBKIwfJRetg3a54CHT2zcJJNfp9E1c=;
	b=r4U3pnJTWoY1R5HfbECKGhC11QidU4DA6GryXf4HJcTlJKMY93KtEa2akuAfqF7nQi8J
	 17/sDzMUHR9cMYSAZ1cHUWE5J9gHOGmtG8YlBG3VOO6A+tS6QO9tHS7PvzvjgOFPkvaOT
	 jb5YZTH76JkzaflDS/6uLBT+wuhy6gjcsoyGf3LFBV/bkeD/hUxcsOpcnGdXY03T9zx2F
	 pXkts8MUPSRqwAqzKA7CVdUmjOhmPcsmC7FhxlWx0Lq2f4ELTTnzvz2nu/6ZkGepJJZTD
	 Pm/FCT2Y2a5ZmUU453mVmpqodvX9xlrbLiIhSF1sGh7m0vqRWXMykYkH5mxio1FFxdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=K1Odx7+V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095568;
	bh=vaIVNRf7eijikOBKIwfJRetg3a54CHT2zcJJNfp9E1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yjxTEqUAyq2YE6DeivbTrt2c3ykROf8Pr9LGaXPyA5uKJo1DnYSom8rSP1DWdfe/V
	 pYEOrW7godBoAzhH8yYromO3DXNnuT0SagOhadGLe9uERe7G8Sj++b1ZJq2YfTf9vy
	 8RO34dl8flz56UBt4Hqs23NYUJJr+gPGh+cyaemzWSOscPaNt79bTtv6eu241XbeB4
	 nw3zY594UVDc8V+lGM/8SLzv6j24Oo9XogR0ehkkhTAVnuILZxjofbp2xxLO+HfO7m
	 E7wqx+yAqDXZ/u8Y8gA+Mt9CLwzFRTeakKg/J8ikQHS4BIGlltkP4sKGmx2bHNn8Bv
	 oKQ9TTYgBbC8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E8E740742;
	Tue, 27 Oct 2026 10:06:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FE13235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F14640702
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2db9zLw8s1UF for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60E954063A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095554;
 b=QtEnSn77zpob57XdhpZv/9H5xKyovvbqzNahkv5KdqePrFpAnZ+GKPBrylfViCrRQUjG
 J6Npe2h/oC7UKVjqvfEWkTNaiJXvQ0yirrVWQ5Bw+u6o0tT0plcntRH89j30/E9bv+Qfr
 pF9GTaZcUTQ5MidLJJDXm55PRQjxgn04alAKKh687OuwfMI2mljYlYHMvG6r9vAkKxGeq
 R0wG/Y0EIFFh/xODPf7/asbmtr5xQFgyquUYPT6k1ydkP4f2F85yt0kCUMRAclTzQJGMJ
 oZg+UlSEI1EZoI6XKdTQ9v0Twe6FLxhJ7VCsgtEx9wwLKT6x1fybJMB1j+C0iw9EgEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095554;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=vaIVNRf7eijikOBKIwfJRetg3a54CHT2zcJJNfp9E1c=;
 b=Q+on7ea/4D3fETdbqEQUR+NPhWv9euLhV1qOe90fXeEDGfxYgbSUCX897S/y7Icml3bg
 Qc9aQLyOOuIeZJGv6ElF+K6ucKHJ4QsV+5RWtNuHrTeGfymlZOghRf8uBOWVHLtwjibaT
 srF5RIQAhp6pUfigL0lkozYjDnL9ExsWfJnOD50Gsgx3IN7VbuuSaN3/hxXk6z5+QkUU2
 K0Z5TSOBPd4H2hU+5dmrCnkTpG2IMuh6bxUvRZs9xQMhmlvrxBQS3lN/lu+jeWWtLUYKy
 yANn2N00fMONfj/2BLTUuUuAMExpoxFqc8Wc++rMjRPB/OzETTxXbOtpRS52s635Z4g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=K1Odx7+V; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=K1Odx7+V
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60E954063A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=vaIVNRf7eijikOBKIwfJRetg3a54CHT2zcJJNfp9E1c=; b=K1Odx7+Viejwe9MiPByS21WMIW
 u8TNJzp222Qmq/yLdkXXs6DNkVVlTAWQ60uBzBpSnEAZsH0DuwiSBCLy1LPa8fAmBdYqJfp0PVgoW
 GOnnDjKUl1EqHjtubGuR2bAAYX9Nj4yXHco0FvHarRvExFp+jsCEik9NcrLS+D0AoC/9HyEtYFF3P
 Rvx8cCTCA+FRdoRd9t75Gq3FKvhg+Nu6nLeL8fBMjUvLsjaHuY//NiV1a2Y3d4VA6hsXWHqVnGOKa
 UlFZWNv6MiPr3DfxY2BdOBS0t5fX/xyXvNstR0DqRVZtGqzcl1qoD41cSWT33p8kiaQz4aTNRxvfP
 0nJD5npw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3z-000C13-0J; Tue, 27 Oct 2026 11:05:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfG-00022y-18; Tue, 27 Oct 2026 10:40:17 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
Date: Tue, 27 Oct 2026 10:39:07 +0100
Message-ID: <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
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

On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
there is no PHY driver handling this. Always run usb_oc_config() when a
fsl,usbmisc exists.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-mx6.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 16a45b82399..84e2328a767 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -263,15 +263,16 @@ int usb_phy_mode(int port)
 }
 #endif
 
-#if !defined(CONFIG_PHY)
-/* Should be done in the MXS PHY driver */
+/* Should be done in the a imx-usbmisc driver */
 static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 {
-	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[index]);
+	void __iomem *ctrl;
 
-	setbits_le32(ctrl, UCTRL_OVER_CUR_POL);
+	if (!usbnc)
+		return;
 
-	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
+	ctrl = (void __iomem *)(&usbnc->ctrl[index]);
+	setbits_le32(ctrl, UCTRL_OVER_CUR_POL | UCTRL_OVER_CUR_DIS);
 
 	/* Set power polarity to high active */
 #ifdef CONFIG_MXC_USB_OTG_HACTIVE
@@ -280,7 +281,6 @@ static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 	clrbits_le32(ctrl, UCTRL_PWR_POL);
 #endif
 }
-#endif
 
 #if !CONFIG_IS_ENABLED(DM_USB)
 /**
@@ -465,8 +465,6 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 	usb_power_config_mx6(priv->anatop_addr, priv->portnr);
 	usb_power_config_mx7ulp(priv->phy_addr);
 
-	usb_oc_config(priv->misc_addr, priv->portnr);
-
 #if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP)
 	usb_internal_phy_clock_gate(priv->phy_addr, 1);
 	usb_phy_enable(ehci, priv->phy_addr);
@@ -474,6 +472,7 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 #endif
 
 	usb_misc_config_mx7(priv->misc_addr);
+	usb_oc_config(priv->misc_addr, priv->portnr);
 
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (priv->vbus_supply) {
@@ -695,8 +694,6 @@ static int ehci_usb_probe(struct udevice *dev)
 	usb_power_config_mx6(priv->anatop_addr, priv->portnr);
 	usb_power_config_mx7ulp(priv->phy_addr);
 
-	usb_oc_config(priv->misc_addr, priv->portnr);
-
 #if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
 	usb_internal_phy_clock_gate(priv->phy_addr, 1);
 	usb_phy_enable(ehci, priv->phy_addr);
@@ -708,6 +705,7 @@ static int ehci_usb_probe(struct udevice *dev)
 #endif
 
 	usb_misc_config_mx7(priv->misc_addr);
+	usb_oc_config(priv->misc_addr, priv->portnr);
 
 	if (priv->init_type == USB_INIT_HOST) {
 		setbits_le32(&ehci->usbmode, CM_HOST);
-- 
2.55.0

