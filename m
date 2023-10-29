Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0998C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F758756F;
	Sun, 29 Oct 2023 07:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="v3szJg+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B9F87550; Sun, 29 Oct 2023 07:38:45 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E337F8758F
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 92E074269B;
 Sun, 29 Oct 2023 06:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561521; bh=cTK2n4nJfIjhYgrfnO7KnHAERQlBK/UrEyzwgBcEO6g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=v3szJg+o8SkecUdDH1JrL+PYIRmw9vlnqoRfgA/a44tsgG3gyflWFo7Djo1TkDoWE
 lTS90Sjtkspvu2eXhNVuNawtP+NIwvpqdzUGfbhSw+5OfeBFedonKgrPUfy6YG8gmV
 qEe7DpLepC46Qq5KBxkBhC/E6yjcj5Zo3lq2+3pZC2+MCS3rujCGQQzAoYmFQU6Rpm
 pDHfkzQpFAagq/gdH16rtlC90TKvk5qBpUtfp4nbrbc+GDZpiFZHhsYVh49uz7nQWE
 UylLxkx+BKYO3iy9B7eU7X7PGMfnbc5z60DqgqApoOk9fmD7gWbRUyc7y0HXHCJ+Z2
 CaEGTKpKeKo3w==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:41 +0900
Subject: [PATCH v2 4/8] usb: xhci: Recover from halted bulk endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-4-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=marcan@marcan.st;
 h=from:subject:message-id; bh=cTK2n4nJfIjhYgrfnO7KnHAERQlBK/UrEyzwgBcEO6g=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv/eXpU16sq9V09/S6o1MeOUz5SQHxjmnlrL877Bd4
 fHnHTtrRykLgxgHg6yYIkvjid5T3Z7Tz6mrpkyHmcPKBDKEgYtTACaSupLhr2BJ+MzKO/wROVoK
 xvw8+cvO3ufa112bW++a3NSyrFJIlOEP/5bQFwyLeY8at55y3bG0kPfCOlsrZnkHo22r9MPvXmb
 kBgA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

There is currently no codepath to recover from this case. In principle
we could require that the upper layer do this explicitly, but let's just
do it in xHCI when the next bulk transfer is started, since that
reasonably implies whatever caused the problem has been dealt with.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index e02a6e300c4f..db8b8f200250 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -671,6 +671,14 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 
 	ep_ctx = xhci_get_ep_ctx(ctrl, virt_dev->out_ctx, ep_index);
 
+	/*
+	 * If the endpoint was halted due to a prior error, resume it before
+	 * the next transfer. It is the responsibility of the upper layer to
+	 * have dealt with whatever caused the error.
+	 */
+	if ((le32_to_cpu(ep_ctx->ep_info) & EP_STATE_MASK) == EP_STATE_HALTED)
+		reset_ep(udev, ep_index);
+
 	ring = virt_dev->eps[ep_index].ring;
 	/*
 	 * How much data is (potentially) left before the 64KB boundary?

-- 
2.41.0

