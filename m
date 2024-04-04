Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81596CD1297
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 06:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA86A8826E;
	Thu,  4 Apr 2024 08:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PavFuIrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE84882C8; Thu,  4 Apr 2024 08:26:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB60488260
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 08:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AEFAB61240;
 Thu,  4 Apr 2024 06:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E3A6C43399;
 Thu,  4 Apr 2024 06:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712211957;
 bh=+tYFN6+QK3PUW/oMQcTV0dPiASQpRO0mELezzogU4Y0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PavFuIrIKUKQ9A10vp+JP6KXkQ1w9gZj/dHbI2hhc+9obhiHuU6YWn3DarviaPGCv
 KIuFk2rfxVzfYSzemmM+p2OjAn4AovVsdc++8POCtSv7Rc6Ag+cm1w7CeI2eLtp3H6
 5y5VsIWFoTfLxDv3MTJcank+Tk4Vu4See0mt8xtAZEuHICDxkb1wMgf4JXpIN6t+UI
 aK57nzGLSXPj7WCOEojueXRdiTp2jPD6QKbv8eufBaemyGw6sskZrF73jcj4KwQFsb
 dCYTw8eWhPIc9NRBMSCk+s3g0tTjcNcEbWT0brg3fyYkWVpYWA6j5KDFpF8zpF2Dgg
 PFm2MkF3OctKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5546FCD1297;
 Thu,  4 Apr 2024 06:25:57 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Thu, 04 Apr 2024 08:25:51 +0200
Subject: [PATCH v4 3/6] usb: xhci: Abort transfers with unallocated rings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-asahi-keyboards-v4-3-2266033feaff@jannau.net>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
In-Reply-To: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=j@jannau.net;
 h=from:subject:message-id;
 bh=4WL/oK9QHrPZzv/LO0Lx0LR9aR1vioRk0nnmNOFZrzg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhjQ+989rnDuaZ8gfb5dasuBpQOkmtrDew7Pm9x8+sMx4A
 X/xofCcjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABNJ7GP4X/2+0GvZ/0s72/Iv
 sj4WXOlrYyf2Rr7g3JTF/Szyhj5hGxn+2SeF6Ww2rkt/0sChG3feea6rzWrPzUfcRORbjnw+rGr
 IDgA=
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

Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/host/xhci-ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b60661fe05..910c5f3352 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -685,6 +685,9 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 		reset_ep(udev, ep_index);
 
 	ring = virt_dev->eps[ep_index].ring;
+	if (!ring)
+		return -EINVAL;
+
 	/*
 	 * How much data is (potentially) left before the 64KB boundary?
 	 * XHCI Spec puts restriction( TABLE 49 and 6.4.1 section of XHCI Spec)
@@ -871,6 +874,8 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 	ep_index = usb_pipe_ep_index(pipe);
 
 	ep_ring = virt_dev->eps[ep_index].ring;
+	if (!ep_ring)
+		return -EINVAL;
 
 	/*
 	 * Check to see if the max packet size for the default control

-- 
2.44.0


