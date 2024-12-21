Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CFCE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 21:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3798480586;
	Sat, 21 Dec 2024 22:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fyM/9Xo6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DjtnHAaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB06805E7; Sat, 21 Dec 2024 22:48:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4508D8056B
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 22:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YFybQ0Zk4z9sWm;
 Sat, 21 Dec 2024 22:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734817730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/M7detQZo5TksNhr+HULhnwvZ4O9EF+MXGdX0cEAqhc=;
 b=fyM/9Xo67+eAPNlAYty2sFkPSfm7uwp7Q2cxqr0ijRIf15jWnZ33dYy/U1P+GIMrKiSMj8
 bzwNcrNNHvpbryawc5lnQ9QhIMm7c+zbvdOF38SCQzwUsaqUjgrITz5H3ZVX5KH5NoH0p8
 2tyxvNTkg1JQ5e5by5kMqAv0Wgcf7jW3wJ/iOo2596fpJADrTJTZi05XvoLpdmLrSu4bNm
 8jDl4DAD1rHA/STMnj0Ek1zlczL46vZ9WcS4BD+WxR6+JPstbeR8DkWo+wdWbrDuvqhUxA
 wQdrRrAcIr+82t/XEcVsU3U9cXfZ272JMf2dfiPM208ekvRF0sviErjwyePW/w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734817728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/M7detQZo5TksNhr+HULhnwvZ4O9EF+MXGdX0cEAqhc=;
 b=DjtnHAaPVJRUODGeUJBbpsdsePyRF7FnsJfAZT5JytW+C1AEe/+RcbX3bkgHVr0tMOWTaR
 OFs1FNECGJTzW7z2ZHPaMVKGIQ0MKmBC6Pxf5SUmpHC2fqGF96RES8DHWGV8PyxQX8iZqw
 n3r2hrHLgeYJbghq6OZA4u1OfRXVa5RFGR31vuBH34gKjoGyir0NKY0SZIPNHkLRJP8irT
 4O0fAYQgMwGrM3lZW8PLV9SOvPkrAuvU3Ggbz2mbWUYaT+kRI3gMSG+N8P1b0fK0x0Ll8c
 AXFdxAZtEEnEe4jJnQIvcoaG8AKLFXNveHQ6OV7q0yOpZyVFR0uRThGX2RlC5w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: rswitch: Do not register disabled ports as ethernet
 devices
Date: Sat, 21 Dec 2024 22:48:19 +0100
Message-ID: <20241221214837.173194-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ctgji4r3mrfb5q1e17fn6y45j6fzpw7c
X-MBO-RS-ID: 2beb7dc570179263b23
X-Rspamd-Queue-Id: 4YFybQ0Zk4z9sWm
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

In case an rswitch port is described as disabled in DT, do not
register it as ethernet device in U-Boot. This way, such ports
cannot be accessed from U-Boot command line.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index 97b5d1b75c1..57eff748c90 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -1113,6 +1113,9 @@ static int rswitch_bind(struct udevice *parent)
 		return -ENOENT;
 
 	ofnode_for_each_subnode(node, ports_np) {
+		if (!ofnode_is_enabled(node))
+			continue;
+
 		ret = device_bind_with_driver_data(parent, drv,
 						   ofnode_get_name(node),
 						   (ulong)priv, node, &dev);
-- 
2.45.2

