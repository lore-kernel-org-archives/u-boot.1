Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812C8C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B2D87F5E;
	Sun, 17 Mar 2024 12:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZcM9Lmqk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0FB87F06; Sun, 17 Mar 2024 12:07:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCFA87D06
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3683060ACA;
 Sun, 17 Mar 2024 11:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A91CAC43394;
 Sun, 17 Mar 2024 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710673632;
 bh=0MDL0O1Q+D9xw9b8OoY1YqL+uKOIl5JdJAVqSUDHArc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZcM9LmqktCFcroNeZscspo2Qa9VWaAHxWkmHHdxGYf0yxT1stFFfBStrso/GQSsqo
 kzfOogCgcXym3Eq8n4/kW9eM9pppN/xpfN7b9TzbXlHJgXKK4NfCiNVlGK70woSZOQ
 vN+LDCHs6Ng2syYqY081hsPsxY1OasYmnijyqRiyLEuj4S+W1plZTs8lnjrFvMuZYC
 eVpo6JlhF7ENNdE7U5x6no9LpHArk7NGLSkGfDTfTl19FIql/fsBhTPzWhFzA//kyZ
 jldGB/Evb7dbi5UTaBAqCQ/SYvNsWl9rn1+S104z9qukTXUKiJOwAJmD37P1n4v7aQ
 fVF2g2cjYptrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7CC54E68;
 Sun, 17 Mar 2024 11:07:12 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 17 Mar 2024 12:07:05 +0100
Subject: [PATCH v2 3/6] usb: xhci: Abort transfers with unallocated rings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240317-asahi-keyboards-v2-3-d3f4b8384f68@jannau.net>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
In-Reply-To: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=j@jannau.net;
 h=from:subject:message-id; bh=rfyJgmyypzdbBLsMLHEmhtOKmCsRDrgbc5J2IB8i/as=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRv5+65X9PfcOnGN/lC2/I3py7cMTjnlWil/vhZD7Nrj
 duju45aHSUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACay15SRYUuL1qwX8460HC2O
 +cvV3Vi+58zDlBZd1bev3j+UfvJ9mw3Dj9t8sVPfNO+S56i8soNhv1jVquyFJv+PlZ1445LyUHY
 yGwA=
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

