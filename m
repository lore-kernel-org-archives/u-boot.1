Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F8CC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 07:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 175358803F;
	Wed, 21 Feb 2024 08:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IR1Yx9nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BAF88037; Wed, 21 Feb 2024 08:25:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601F388031
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 08:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D4D4561389;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 827D6C43394;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708500316;
 bh=Y6odlijuKiKQUClQ3ri7K4Ic1LfOLpeOocte5K/8Qu4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=IR1Yx9nQEwPDbXR+KG7CPcdksurBog7eKtzUlAKoXzWAPN7vmkH3S4i1kNxeM1ouo
 g47gAFQmtEheUK+4hGyTZgQnKIKF/KaDfXv5583GE1G9F5+hfPcrx1P9pDPqd4wxde
 7AYpVHOoOYKkHWWMGLbkNHaCyqsIonAfccAxEcOewHfigOPqXxDWexXO5aOBXLx9oO
 cM20slhdLSrmPMiab0aizqNIdaNQ7zHdX+T2y5GAntDweA4qQi19MLZrE2zIhNIkOM
 /dUX6/ijmFR7vrA/3S5GxAj/llO+T4NAB25RfNK7H2KiWI9WM1ltHq4vun5Nd97pHA
 6NeTX2JQXF0zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDDCC5475B;
 Wed, 21 Feb 2024 07:25:16 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 21 Feb 2024 08:25:03 +0100
Subject: [PATCH 3/6] usb: xhci: Abort transfers with unallocated rings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-asahi-keyboards-v1-3-814b2e741790@jannau.net>
References: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
In-Reply-To: <20240221-asahi-keyboards-v1-0-814b2e741790@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=j@jannau.net;
 h=from:subject:message-id; bh=EzgLII75vJWMRf8tU350iE+qgV69Ozl8ArZ4I2u1mHc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtSrS6Mu2N81yt4jqSdY+TbFLk6HsflZifz5wsReDm79P
 N38h/odpSwMYlwMsmKKLEnaLzsYVtcoxtQ+CIOZw8oEMoSBi1MAJmI1k+EXM2ela8XO9qRDs72c
 87LV2T4YzPaoSX+99vHTlTMKJwmHMfwzu7BcKjzZN4NR5GDV/qR/b0xe2p2artIxedLpndkV7Wp
 cAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Discovered while trying to use the second interface in the USB keyboard
driver necessary on Apple USB keyboards.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/host/xhci-ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b60661fe05..4446f5f098 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -685,6 +685,9 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 		reset_ep(udev, ep_index);
 
 	ring = virt_dev->eps[ep_index].ring;
+	if (!ring)
+		return -1;
+
 	/*
 	 * How much data is (potentially) left before the 64KB boundary?
 	 * XHCI Spec puts restriction( TABLE 49 and 6.4.1 section of XHCI Spec)
@@ -871,6 +874,8 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 	ep_index = usb_pipe_ep_index(pipe);
 
 	ep_ring = virt_dev->eps[ep_index].ring;
+	if (!ep_ring)
+		return -1;
 
 	/*
 	 * Check to see if the max packet size for the default control

-- 
2.43.2

