Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F5DCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C254A849A1;
	Mon,  1 Jun 2026 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="c2D2mtf0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4328466E; Mon,  1 Jun 2026 10:27:25 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7D2A846D3
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WtusKnms1mkse/wiMjCwhDjxNgoKxXhNRR9DI9bgRi0=; b=c2D2mtf0vVXEEDUYMMcNc7ghJK
 2bhrvnElhy6lQgxdXgoX1sz6/PaPLCN1BkPwZt0E2p3oQZjZnx5l3exsGkHtMmO4iBbpuiS70txjU
 0UIehMVFvbanC1lbyPccoj6EHt3D37i1gsRwy5tmrJBDpsP0xWNK/t35sfvCOwYyqbuwBWpL5LC2C
 AQbxItkCsh9Gk3lwwT+XXZPKRxbcy/UiUepv6X86grqDe5SZ2yW1J4neZ3ZnVgeCzXo5mMXKoKy5W
 4/Moe8NXUxUIW0GX8w1pkhWHSIdddhhGu5UPuuiOlv609jqSs6c4UR4RIIFIBBnqwCo60dbR5SM2H
 J9nfQ+aQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxzX-0005U1-1h; Mon, 01 Jun 2026 10:27:23 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxzX-000Pug-2p; Mon, 01 Jun 2026 10:27:23 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 2/2] usb: usb_onboard_hub: add support for USB2517 hub
Date: Mon,  1 Jun 2026 10:27:15 +0200
Message-ID: <20260601082717.239518-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
References: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

This hub is compatible to the already supported USB2514.
Add its USB PID/VID.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 common/usb_onboard_hub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index e7bd0b9ccdd..9eea18a3066 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -293,6 +293,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
+	}, {
+		.compatible = "usb424,2517",	/* USB2517B USB 2.0 */
+		.data = (ulong)&usb2514_data,
 	}, {
 		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */
 		.data = (ulong)&usb5744_data,
-- 
2.43.0

