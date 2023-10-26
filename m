Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245F2C25B6E
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 23:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34ED687BC5;
	Fri, 27 Oct 2023 01:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="EmHAo7lp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A02875E7; Fri, 27 Oct 2023 01:17:09 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB8287BC6
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 0F673425D6;
 Thu, 26 Oct 2023 23:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698362223; bh=osD9rg0bjYw9lXQ2Uxqt2h9MY9Ub/gkxD4kjyc0wFWc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EmHAo7lpkR6C4oeXRRNl57jyYDffnkre8kT5661lDyjEn2Po3CvFa8qe4WwlRLXbl
 JvXYqlQ0dWQweVQbjG8MwlQ6BBiAUy3ShkJAe9EilmxTBKCkdeZDCHiflJsMwBWLZi
 LBgkD/yHKtGGQ0aOdZ+jFvrNWpGpgjCh86jJB9alz3hRRUCgq1mSQi46k18bJTdsTq
 zi0Fup5SdZxhtbpXFd5h+j/NIMFH8k4CEv+tYjp/25OUp/HwwmQ95mN+eDzJBpRtFH
 PlqQizaa+Xd5m7LpY/TuUzqLIul111fPx8xcRK2QBtsNXU2qp1UpxVUqpy94DaBKid
 MYVmoJSZvHOww==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 27 Oct 2023 08:16:47 +0900
Subject: [PATCH 4/8] usb: xhci: Recover from halted non-control endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-usb-fixes-1-v1-4-1c879bbcd928@marcan.st>
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=marcan@marcan.st;
 h=from:subject:message-id; bh=osD9rg0bjYw9lXQ2Uxqt2h9MY9Ub/gkxD4kjyc0wFWc=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlSrz4n3G4KVzF/yON5NNkgqvLWx98ahbu3V7oZGE1qSd
 a8cvx7RUcrCIMbBICumyNJ4ovdUt+f0c+qqKdNh5rAygQxh4OIUgImY3WX4H/b0e9HlC1YnlIsW
 WS5m+chR3/hX7YvI0vOptx/PktjMnsrI8INlVeSz6rXrHrG1bVu+Rv/dhGTJO9NtlrHt9YvarmR
 wlg0A
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
index 5c2d16b58589..60f2cf72dffa 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -669,6 +669,14 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 
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

