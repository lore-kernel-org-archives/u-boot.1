Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC1CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B540687615;
	Sun, 29 Oct 2023 07:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="CKub+lQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEBE870E4; Sun, 29 Oct 2023 07:38:46 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BF287258
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 12683426BA;
 Sun, 29 Oct 2023 06:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561524; bh=omrmzNklgVMvUbEzorKZ9alk9sHxhNw8icvLAtAAbQM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CKub+lQVlubvDweBa47YLnDi+G0EgDgPM/XVH/cUdpBoQcZXdj/fGqMYCH8+klMSd
 HQP+meFxZA5P8X/Mu11pRMIExHTRq9ScYfIlm6OSSe6/H6TlT2hWSlZ1pLXmgDwu7X
 KaCPyXFndOBAJwoLT+iG5yhpN7YWrHflPtdhqUQynCvgmBKGjdXXleHjhWYi5P0D/B
 hMKt7JppqLP9WghObvlsCy7lzQf90cCptLdDuYBQeSfGLOg6IYBDmHwB6GdbJue81z
 YqjBMJDNe687LOt4mLvUSRTXOAEZrM/VPy+UZBStFoUi3C+TSYcq7uCkjXmGSeODcQ
 omPNH2LlF3UCA==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:42 +0900
Subject: [PATCH v2 5/8] usb: xhci: Fail on attempt to queue TRBs to a
 halted endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-5-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=marcan@marcan.st;
 h=from:subject:message-id; bh=omrmzNklgVMvUbEzorKZ9alk9sHxhNw8icvLAtAAbQM=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbvw/MLBwqFoY1RXpV37vlrd+c5nS3ke/qiYNfWNr5f
 +/hE53eUcrCIMbBICumyNJ4ovdUt+f0c+qqKdNh5rAygQxh4OIUgIlMcWL4w6M9J3ZT1fGN3yc/
 CPd8kFI5XU9X5tmjfJMfwd2Sut+zDjMyHDtgviqV/emqBxV/dpxk/H0r1Kxr2akHhTcNL7Yq6ie
 YMwMA
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

This isn't going to work, don't pretend it will and then end up timing
out.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index db8b8f200250..a969eafdc8ee 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -243,7 +243,8 @@ static int prepare_ring(struct xhci_ctrl *ctrl, struct xhci_ring *ep_ring,
 		puts("WARN waiting for error on ep to be cleared\n");
 		return -EINVAL;
 	case EP_STATE_HALTED:
-		puts("WARN halted endpoint, queueing URB anyway.\n");
+		puts("WARN endpoint is halted\n");
+		return -EINVAL;
 	case EP_STATE_STOPPED:
 	case EP_STATE_RUNNING:
 		debug("EP STATE RUNNING.\n");

-- 
2.41.0

