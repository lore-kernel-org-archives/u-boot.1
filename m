Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841D606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0s5f5lVr;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=qyX14vXh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97AE46076B;
	Tue, 27 Oct 2026 10:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgh7hM01U_FD; Tue, 27 Oct 2026 10:06:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C8EED6075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095564;
	b=V2QJki4hveLdzyQ7Rhcme9Su9VflKQVDM+XXkAG1b6HMopleK5DrM2M0EWwjNfzIiGg4
	 hU5hJ76ZGFuNIMLk7Ikch553TxDqXnGxYRr3pmvXhs1PsuHSxOraifRtJtqgWjh+yY/oe
	 hdY1oNFIvafe7yHyDJLsvf6irKm7wa/gU4nAvpten6NY83byh0HqW50Ep12yk9CX0wYe2
	 YkoFRoBpT1bENFOglhvMXMoXFXKo0B0NDcdAaa8+IYHRqDNE74+u0U70cmrFp+iyNGfT4
	 DcW9cXkOEZ8vN25odzvz/1H1WcKF0DNIlttO/OXXcKtohkaUTo13nBlC8TZd+Bys/Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WCbPJdzqN/zodkpovKDjLnRDjtRSQ0rns09JVi2So7I=;
	b=mMJdjK3mPEtfv+YdxoXOhY2f8TNc7Lz+JMRKjkmOUnFQJQAEqLOVe8qWJa+THcFbpezE
	 7lvUso20m1b2DMujNcFMSeeJwtIlF2wEQacAXkZFNFw18nH4WyiBNRnB8RmNfM1l9WuiH
	 /l3jyq2I/bH/Ykh/3Oi9eER/5zgndeTUz4pbhMxUdtS7uqYKJ7kLilrlQx80SeefcBAVP
	 CRi3B7fNMN9laiLT91K3TR9S9YfgahEBSBYNBk0D6ajoOvMSuzcr7Y6NO3CMYxHcEZPQt
	 kglPH6K98REUspaANsWWwWdMvWPSyq5yCRiw6GOCCiGomJoEzAFdV7LLRIzLoqyKhdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095563;
	bh=WCbPJdzqN/zodkpovKDjLnRDjtRSQ0rns09JVi2So7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0s5f5lVrIpvHvAIC9APkMSxusZ0kuwM37GLy24uAGtsJLUEBaH9Eg1r2ObWV1wV8S
	 2oLQoFihf32F0zYNSekKxN3gf10WrdzmdKKfAroSpVFvQw2ZDNJ2dGPjx6NNeqBYvT
	 DHd3kYDkCBuq6cSo+R+0VKiQbaQHky8gi8DhafIX0lBXlDj0+//a+6cCRr7iRK7OkD
	 7WRIu3YyrbLEfkPqk7qTkpHzTiEQssHkwZbYowrHi6Fv7NoZf56BFHuFRrxNqszWqd
	 XAg7SOvRtRiY/MSbBA+V0zD96Ny6l5wzulv00wQXUgpVy7mvunkhdmyGdCWCVBV/2V
	 vsSSV2v6yHMmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8EED6075A;
	Tue, 27 Oct 2026 10:06:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C4772
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0AE240261
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l43x94nq3k51 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B05A4400C5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095555;
 b=Wfecu0IOAnFVKEW5iiX67zjt/YyIE2Ibm1uRW0uXIOGDMR0xY+BfesEPl6tO1qgBRLSx
 D9JwAFzhQvaa4tV2ZHv6+rBtJBX/iI6RBmdkU8vupycAyyGqdopWaQky9f0kiXH12H8Du
 NxX1C8DiWlEHJwbJUNHt9CYgzfjkNhgJizgA3b2BR/POUfBZ/4VP0xeFWBjV8yRsrCAg4
 eh2V25KzeerddhFT3ikJwCyrFcW4Io3qwBVkTeleHJlFa+OKlkAsulyW+RrD4w/afL7aa
 xWieuC5fZcXAI+mkflYKF7ew5Y7CfcXaHRWued8IEpnyZdGiX6H2B4Tar4Y/qXgNAxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095555;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=WCbPJdzqN/zodkpovKDjLnRDjtRSQ0rns09JVi2So7I=;
 b=r0c07Fx8EqFmSwguYxefyi3lNVVTVUKr9+5dgLdZkVoc1UThNV/PnH55Gl1GYm9VEf/3
 XeSXCuIMuiKxh/hVWoR/jsg3Rdbx+7lt0nh/oq6Tu/7DOEnLi1numO/tGclWG5UCXqCrQ
 lzHiuMmCddMsukYNmvDIH2EgF/acXPEmatmgXW7YVmbnxZfttc1l/TOdkeuA+DOVTPWUy
 dQQE0JdS7xjxeqwm4bz4aBXB3To9Y/CbUsZAFL3Roa7j6v8cEjXlbni9pAAKlG+gwdyML
 LaYhmbfaUZkQqbpkpLeSWaWQ2iyhIviZbssqFNbZv3z9b+ImSru3nq0wjylR+L3Iwpw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qyX14vXh; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=qyX14vXh
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B05A4400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WCbPJdzqN/zodkpovKDjLnRDjtRSQ0rns09JVi2So7I=; b=qyX14vXhEIZvllLNO1sbNqpiyI
 /YmHyqRDxyf/P2UXjFW0KEPWFxufpOInbaMONU0d09AvG2rCOi1OZ4GpPu933DbWqq7+3LfJ5LCJA
 z16/CZJ7a3c/ftOKqfgzytBk7keDAg00TDjjUamPRKzD/ozz/6L8+AOoezpX0vni3Lsa04j2AqyAh
 992E5CgICgLtT9P9ZKo1Par1DJRs8vdXdsrFYzA0x6ZrnX+hLfXlvwUHF/i4CSO/0hY5n77QU6qn+
 i+YDc8jsOj1NYWmrbHncUWhXHXYYTQVR2onCWvzD/yy212DixYPpY7jmJjiLFbrSIJneAXKVTmzML
 2baO/Ehg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3z-000C1D-34; Tue, 27 Oct 2026 11:05:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfH-00022y-1Q; Tue, 27 Oct 2026 10:40:18 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 13/16] usb: ehci: allow overriding port enable operation
Date: Tue, 27 Oct 2026 10:39:10 +0100
Message-ID: <1d308aa9b50b48ffdcf11327a631e4fe157c15a5.1793091394.git.nora.schiffer@ew.tq-group.com>
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

Some USB controllers have quirks that require additional handling when
enabling a port. One example is the Chipidea USB host found on various
i.MX SoCs, which must be forced to HS mode for HSIC interfaces.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-hcd.c | 15 +++++++++++----
 drivers/usb/host/ehci.h     |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7d5519c65a9..2de2a5578a1 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -139,6 +139,13 @@ static void ehci_set_usbmode(struct ehci_ctrl *ctrl)
 	ehci_writel(reg_ptr, tmp);
 }
 
+static void ehci_enable_port_power(struct ehci_ctrl *ctrl, uint32_t *status_reg,
+				   uint32_t reg)
+{
+	if (HCS_PPC(ehci_readl(&ctrl->hccr->cr_hcsparams)))
+		ehci_writel(status_reg, reg | EHCI_PS_PP);
+}
+
 static void ehci_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
 			       uint32_t *reg)
 {
@@ -874,10 +881,7 @@ static int ehci_submit_root(struct usb_device *dev, unsigned long pipe,
 			ehci_writel(status_reg, reg);
 			break;
 		case USB_PORT_FEAT_POWER:
-			if (HCS_PPC(ehci_readl(&ctrl->hccr->cr_hcsparams))) {
-				reg |= EHCI_PS_PP;
-				ehci_writel(status_reg, reg);
-			}
+			ctrl->ops.enable_port_power(ctrl, status_reg, reg);
 			break;
 		case USB_PORT_FEAT_RESET:
 			if ((reg & (EHCI_PS_PE | EHCI_PS_CS)) == EHCI_PS_CS &&
@@ -1005,6 +1009,7 @@ unknown:
 static const struct ehci_ops default_ehci_ops = {
 	.set_usb_mode		= ehci_set_usbmode,
 	.get_port_speed		= ehci_get_port_speed,
+	.enable_port_power	= ehci_enable_port_power,
 	.powerup_fixup		= ehci_powerup_fixup,
 	.get_portsc_register	= ehci_get_portsc_register,
 };
@@ -1019,6 +1024,8 @@ static void ehci_setup_ops(struct ehci_ctrl *ctrl, const struct ehci_ops *ops)
 			ctrl->ops.set_usb_mode = ehci_set_usbmode;
 		if (!ctrl->ops.get_port_speed)
 			ctrl->ops.get_port_speed = ehci_get_port_speed;
+		if (!ctrl->ops.enable_port_power)
+			ctrl->ops.enable_port_power = ehci_enable_port_power;
 		if (!ctrl->ops.powerup_fixup)
 			ctrl->ops.powerup_fixup = ehci_powerup_fixup;
 		if (!ctrl->ops.get_portsc_register)
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 5770d35b464..78da0bc0d17 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -238,6 +238,8 @@ struct ehci_ctrl;
 struct ehci_ops {
 	void (*set_usb_mode)(struct ehci_ctrl *ctrl);
 	int (*get_port_speed)(struct ehci_ctrl *ctrl, uint32_t reg);
+	void (*enable_port_power)(struct ehci_ctrl *ctrl, uint32_t *status_reg,
+				  uint32_t reg);
 	void (*powerup_fixup)(struct ehci_ctrl *ctrl, uint32_t *status_reg,
 			      uint32_t *reg);
 	uint32_t *(*get_portsc_register)(struct ehci_ctrl *ctrl, int port);
-- 
2.55.0

