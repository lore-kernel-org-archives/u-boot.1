Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03322606A323
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vVkbxG6H;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=CTAiO9De
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFFE1406CD;
	Tue, 27 Oct 2026 10:06:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JiY2u_33JluF; Tue, 27 Oct 2026 10:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B12E40718
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095562;
	b=s9jOJkaZFLgBoq/6UwC8J+nWXJrVYpwB7mNn835iqZwnKCHc4FJ0mecHwee8xdcC76Vp
	 CysL1C9XobPL3VDJZxy/6dURUW+UHJXO0/IcygJjP158lVVaBUrmWY8hewx71gl11IpmR
	 0RHy3ws2To1uSCl9DUEke5NjMEghfUWrvkr0oGJxuEb6GueyDVbZQeE672x70AJ0S8zU2
	 pCY8ILyzkvbLTIZHibshWzyOFGRuES/00x1FrWJp9o1YNbamZ9TTQ9qYcVp13xy0ifAzz
	 xgFQExjQLyCHnuqEltBlolwjF8rtXnCTN31nj+3otvd7yUpKRUNhJ6zmPezFd6n0b0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EWucT0w+IEB0U1En0KI6Fb5cgDfP0zw8zp0d8nfDV3o=;
	b=dY8hyIFsGRcgMG4czmB3HmIYmWouxwSVqWukfJpQXrly0+gmJnXli8YFBtmPTQODji/W
	 15zdRCAMJEMg29iuqxIKoJp3RVif/wv7SS52eYY6SbYYgrzNN3xUoXc/B4qXs2n2UTkxi
	 mPfPUDUbdMgzSvSqKVcB8CpKWd31Rzh0PlAQ+RhVu0zfeXSbMxfiTDWe/nuhhg6F3nXvg
	 KyrOQ92qHVR/+BW+ZSxTDCGQyzPM3TCHbUMOhluOaEMTkT+u23rv/Ed+QkOFd6aZ9zoiu
	 qvgkkfOusOrjzuBN4MCUyTJYgJt+q7T0NnGq5/Ibb4GkEv6fbl/cOi9uehJMBXORGEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095562;
	bh=EWucT0w+IEB0U1En0KI6Fb5cgDfP0zw8zp0d8nfDV3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vVkbxG6H/5bny2XmMW6CtXZZij7sv/ZqcaF6CjTas4CKP34R6e3tYH90Qwk+NHeTD
	 FSYv9yAWKM9WaygZncaL5XW8zinCDbr6sDDGlMMmNI6IJ/gbtjMYFci6u5iObG9sEa
	 m1YFHYShntrOY/MLwPjLcYP93ZkHKGo6N27EXyjRf/5qRlijW6v0Guif7ic+sbFr5L
	 Y0eFtWG2XOQphzP1wrH+b2enKOQ7P9rQLt5YcdU76K+g6YS5EtqX+YVh6ezLw94xwF
	 97Wvx/ZbJd76RY0IJOVkwYVPgfBdkVt/f361apa2thi3NJjPjYMBtsY2wwYGpmrxXR
	 aJ/82lVJsUY4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B12E40718;
	Tue, 27 Oct 2026 10:06:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43687235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 295FE809F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YOnWrwaTFgUF for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FA0E80B89
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095554;
 b=imstDNJRdwSSJSiRBdnwePj5kGdkVxuRsEFo5oxdCimKlsyZJNfUNnBpOLX/xkLN06Sr
 eCcz7UZcj0uFbFG6d4gFLAmm+SIYVAjPMyuu6y2myAMGorJr/ufmuBhzwsT+/b8YhzE3K
 Hhcx0NSjSZB3BrBNpZUheQFbQNssLv/FY04TEH/K+G7OBC4AbuPfwQ07+qXc8GsyLAqhz
 1SAnXWsKJRGWv3AgvIEPBDUMNBHkSkkPOKPEzPbjbXJD3hLvaqzKFmqx5qtnAz5x86vO8
 CJcm3LZnbxpWWz4vtR+YFOWk35PcWF5n5k2pXXAIc3j0dNB+Q0akwv7jwUSqf7Vsb9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095554;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=EWucT0w+IEB0U1En0KI6Fb5cgDfP0zw8zp0d8nfDV3o=;
 b=abfCPwGtzZHcekj4VYQFAw0tYfki4JEnzURAMrdhC9Y5noUcPvACSSugfZpDEi/vn2TV
 JPr6fWGvMHGswaFlNvr91hTd2N/E8qa0LQ1vmaEJUuoiKkqzNk2I/JKwZf0RnVerjgsF5
 KO4G8ZI6z2aQ7yCNC8ZR+kf/qE+KcpgAse1wLZxJGV/cPvDqY6krtySpy8c/A2Rt5PVIx
 BvJ3iA3uA8q81mHes2WI9GhTqaWztHbzhaDy+0Ce0VIWBWCeyIKM6d+ltbrBuDxHskovP
 0f9nqV+CubY75R4MBWZPxU5vUkkDoZw7nVxfTOFL2F6+s6cqcn1rvvyySO+adop/QYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=CTAiO9De; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=CTAiO9De
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FA0E80B89
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EWucT0w+IEB0U1En0KI6Fb5cgDfP0zw8zp0d8nfDV3o=; b=CTAiO9DeCnLQ+lAFQZA54P1i3y
 62nwZYQiIZpYk38M/EuSCoZrOm2dHFac9T/BrjGll57PWikoETil5FegoH5ogMWpdO7t1mbFGE/vu
 ki9MM1Ea5lleX608KHXUt1LSpoW6fGE58vQlfqk6JIzu8WrvnPlRISnfYVGpNBnpG83xKA3JqkfUY
 8oWBE/pqkZZYOaxsECi+iW9q6Dl0XegtLXWzmX9oN9Wbv17OCeefLL4POGP8viFqywqTEr54rO3V7
 g+7+QK1kw0eMztBEzVcCfMKM2fOKBp5GRr97zKV85PSydPLIaoFrLUiL/wTU3R1paPQop9gfVAPaU
 VDY0aamg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3z-000C19-1r; Tue, 27 Oct 2026 11:05:51 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfH-00022y-2a; Tue, 27 Oct 2026 10:40:19 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 14/16] usb: ehci-mx6: force HSIC ports to HS mode during port
 enable
Date: Tue, 27 Oct 2026 10:39:11 +0100
Message-ID: <58776e65db3591995642f85205addddca1453562.1793091394.git.nora.schiffer@ew.tq-group.com>
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

This workaround is required to allow HSIC ports to connect again after a
reset - without this, only the initial `usb start` will be successful,
but after a `usb reset` no devices are found anymore.

A similar fix was introduced in Linux commit fc6b68ba4990
("usb: chipidea: add work-around for Marvell HSIC PHY startup").

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/usb/host/ehci-mx6.c | 12 ++++++++++++
 include/usb/ehci-ci.h       |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index c804af8ab45..aa0d8174103 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -454,6 +454,17 @@ static u32 mx6_portsc(enum usb_phy_interface phy_type)
 	}
 }
 
+static void mx6_ehci_enable_port_power(struct ehci_ctrl *ctrl,
+				       uint32_t *status_reg, uint32_t reg)
+{
+	struct ehci_mx6_priv_data *priv = ctrl->priv;
+
+	if (priv->phy_type == USBPHY_INTERFACE_MODE_HSIC)
+		ehci_writel(status_reg, reg | PORT_PP | PORT_PTC_HS);
+
+	ehci_writel(status_reg, reg | PORT_PP);
+}
+
 static int mx6_init_after_reset(struct ehci_ctrl *dev)
 {
 	struct ehci_mx6_priv_data *priv = dev->priv;
@@ -499,6 +510,7 @@ static int mx6_init_after_reset(struct ehci_ctrl *dev)
 }
 
 static const struct ehci_ops mx6_ehci_ops = {
+	.enable_port_power = mx6_ehci_enable_port_power,
 	.init_after_reset = mx6_init_after_reset
 };
 
diff --git a/include/usb/ehci-ci.h b/include/usb/ehci-ci.h
index bc980934585..2d513b338c7 100644
--- a/include/usb/ehci-ci.h
+++ b/include/usb/ehci-ci.h
@@ -26,6 +26,7 @@
 #define PORT_PTS_HSIC		(1 << 25)
 #define PORT_PFSC		(1 << 24) /* Defined on Page 39-44 of the mpc5151 ERM */
 #define PORT_PTS_PHCD		(1 << 23)
+#define PORT_PTC_HS		(5 << 16)
 #define PORT_PP			(1 << 12)
 #define PORT_PR			(1 << 8)
 
-- 
2.55.0

