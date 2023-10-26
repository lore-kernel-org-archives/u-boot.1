Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA8C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 23:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF1287BB8;
	Fri, 27 Oct 2023 01:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="ZgAaKE60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F78A87BBC; Fri, 27 Oct 2023 01:26:55 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D338749B
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id C0FB5447C4;
 Thu, 26 Oct 2023 23:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698362811; bh=SdiV/7FhtiTzACsBQea/7xEAQjxS2za4REQySPONCTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZgAaKE60qrB4BK3Gu2Sq5GDEw4PlCKIt9R1N4xV+9Ly+7JwHyO+wrh/OzHJz8Ypmb
 JMoz/ywUY3S+mGd7lpNZ4/26+mB806txm3uS3SS10jTfeoMnfrA0xEi5sV9Z2wsTUk
 r/H0zr4MTd7yYgm+ag/1Zta9VBSd/zutCn46JLBoEIIjQyXcQbkF5B2UOl03fGxFUG
 CqNokuZB+O/pYz6hT8B5KBU+jvX1v1yqljOArJb14HLZHqYeePzXOO+V0xMavrDxkg
 UjY9WLwVjjeXmwCPLjlZpkPLQJ/ZOvE1L4UarkTYJk2gBrUZTV7iPB0QbExyx+M8US
 H7vQkYToxavzg==
From: Hector Martin <marcan@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.de, Hector Martin <marcan@marcan.st>
Subject: [PATCH] fixup! usb: xhci: Guard all calls to xhci_wait_for_event
Date: Fri, 27 Oct 2023 08:26:42 +0900
Message-ID: <20231026232642.16668-1-marcan@marcan.st>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
References: <20231027-usb-fixes-1-v1-1-1c879bbcd928@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Gah, I should've paid more attention to that rebase. Here's a dumb
fixup for this patch. I'll squash it into a v2 if needed alongside
any other changes, or if it looks good feel free to apply/squash
it in directly.

---
 drivers/usb/host/xhci-ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index e2bd2e999a8e..7f2507be0cf0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -532,6 +532,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
 	if (!event)
 		return;
+	field = le32_to_cpu(event->trans_event.flags);
 	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	xhci_acknowledge_event(ctrl);
 
-- 
2.41.0

