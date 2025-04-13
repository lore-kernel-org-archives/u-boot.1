Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8351C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 13:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4BE82A9E;
	Sun, 13 Apr 2025 15:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RiSvP14k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uq20vCfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA3982AA3; Sun, 13 Apr 2025 15:11:42 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9FA382A87
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 15:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Zb9mW55l1z9sck;
 Sun, 13 Apr 2025 15:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1744549899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c7y4hMkNE8GyavCxx5KHHg3iEkH9hBkxmyluqfSYHYo=;
 b=RiSvP14kHhQQBxsEPtxzXoxyxH9QqcEi/gCuxkYXaCk+/p8t8upl9FJL1enRHJ8EM2qUlE
 YGTPh8Qb82DeBwKSokeDWaeAJovFfQRQnVUamuhw2/OYlJvD2xCdq6R/opE6lBsGAiVfx0
 11YN+is8jEu+P3+ezbdk4dkGBlQuquldhwjO1wammNgMbaKmSvJXbyXsOVVzz50k86/1zy
 hvNhTRg0dRjyFgl8Kl2Cg8lJzmIj3vLCOFFt/HEOTeL5MgxuDsiivYN76CQM31OumZxLII
 1LDcA5VwVlixSBun/PD7/PdE7pDB3H3eX8pKpEPBrB8/tRluymZSt2jfMxhb8A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1744549897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c7y4hMkNE8GyavCxx5KHHg3iEkH9hBkxmyluqfSYHYo=;
 b=uq20vCfRl0QRqGwBKqLzZegvEn9e2/R0XHeRY0ShFgiNofh6J+eAbuZF7fFmgCafS0QWjn
 04vUXJ2ZF/LoadG2C3hmli8MVcJEVgSJV9ajc2ZArJSx4VOLTtL9Dwe1TX3l+cotVZbQzB
 ADhC8o3B11IKG0rU9Va9PAIBXUIyw2RDi0QOKrlEPkBy3nnCXi8sJ6k8F5SzduIBlZTxi6
 WlGmMv9WJsmusXqgKmEKXPLj28dw5BZHxdLzmfnRkEdmqEek0nTxlRuK8ZK+oP8OqjyTVu
 nfS//CJwH6X1Kkuj7uz8BLPYgJPWg8J2UiDxbKV8BF47m5Ff0HcJtOiWzpZ7ng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: ravb: Fix RX error handling
Date: Sun, 13 Apr 2025 15:11:19 +0200
Message-ID: <20250413131129.68990-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ae3df5aa2e356ea31a3
X-MBO-RS-META: thqd9nibc5d9qp3kubnkuqxmx6wdqhxr
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

Correctly handle RX errors in ravb_recv() by returning 0 instead
of -EAGAIN on RX error.

In case the RAVB driver detects an RX error in ravb_recv(), it must
not return the -EAGAIN, but instead must return 0. Both error codes
are handled in eth-uclass.c eth_rx() and -EAGAIN is rewritten to 0
at the end of eth_rx(), but negative return code from the .recv()
callback does not trigger .free_pkt() callback, which would clean
up and re-enqueue the descriptor which holds the currently received
corrupted packet. The .free_pkt() must be called for this descriptor,
otherwise the follow up received data become corrupted too, even if
those packets are correctly received. Returning 0 from the .recv()
callback assures the corrupted packet is not processed by the network
stack, but is skipped instead.

For TFTP loading, an RX error produces the timeout "T" output and
resumes the TFTP loading operation shortly afterward, without any
data corruption.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/ravb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 539fd37ee59..da3e9dbeacd 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -192,7 +192,7 @@ static int ravb_recv(struct udevice *dev, int flags, uchar **packetp)
 	/* Check for errors */
 	if (desc->data.ctrl & RAVB_RX_DESC_MSC_RX_ERR_MASK) {
 		desc->data.ctrl &= ~RAVB_RX_DESC_MSC_MASK;
-		return -EAGAIN;
+		return 0;
 	}
 
 	len = desc->data.ctrl & RAVB_DESC_DS_MASK;
-- 
2.47.2

