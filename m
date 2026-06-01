Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCCDCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC468499A;
	Mon,  1 Jun 2026 14:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="aqYysz+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DFC84701; Mon,  1 Jun 2026 10:27:25 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D208466E
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=1Mu55AR5aQClFA5sNzCLbsf7ipNaJWIbrvWQ1qENdW4=; b=aqYysz+9CalkQiOODsJtPdlQ/Z
 TjtpW2v3+H21i8Dh6GU+Hui5BqTfV+yo7K90MPfOmYru4lb5vXWhdbSl6wEOEJMX+AxWghVrE8V6/
 cBUCoLZoVlWMRUgz2FYg3Ac2GI9bYLVYnr9RaK9hyO7lCBer9613R5sqoZXNh6xHXGk4XT5Xzaa5L
 dwtubei3AtzoPCxc/jNCc+io610/UY+7rpPbVxXp09iN0pbGT2/Usib0/xT3AWGUD9kcb1gBjZfOJ
 l8yHqAs5qajmhS+6S2Bq3dQpogXvwoQkWElaC98gkmgcnJKu5FPgCiVXs59/c06klnmWr9vDj/dbM
 l7ucvhQg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxzX-0005U0-16; Mon, 01 Jun 2026 10:27:23 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wTxzX-000Pug-2C; Mon, 01 Jun 2026 10:27:23 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/2] usb: usb_onboard_hub: add support for TI TUSB8041
Date: Mon,  1 Jun 2026 10:27:14 +0200
Message-ID: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

Add support for the TI TUSB8041 USB3.0 and 2.0 Hub. A reset duration of
3ms is specified in the datasheet.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 common/usb_onboard_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6fc34489a98..e7bd0b9ccdd 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -277,6 +277,12 @@ static const struct onboard_hub_data usb5744_data = {
 	.supply_names = { "vdd-supply" },
 };
 
+static const struct onboard_hub_data tusb8041_data = {
+	.reset_us = 3000,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct onboard_hub_data usbhx3_data = {
 	.reset_us = 10000,
 	.num_supplies = 2,
@@ -293,6 +299,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb451,8140",	/* TUSB8041 USB 3.0 */
+		.data = (ulong)&tusb8041_data,
+	}, {
+		.compatible = "usb451,8142",	/* TUSB8041 USB 2.0 */
+		.data = (ulong)&tusb8041_data,
 	}, {
 		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
 		.data = (ulong)&usbhx3_data,
-- 
2.43.0

