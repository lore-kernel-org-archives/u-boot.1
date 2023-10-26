Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165C4C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 23:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3454D87BDB;
	Fri, 27 Oct 2023 01:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="HlCsTLnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FC787BC5; Fri, 27 Oct 2023 01:17:22 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863DB87BBF
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 958F442603;
 Thu, 26 Oct 2023 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698362228; bh=Uwz6+kZfZJmuB7ysnARjuDoiI+88/kajt+fzm4o9g2A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HlCsTLnZ3GfW4iP/TznKZpQoacIiW9W9ZAlfr4CqTssX7Tu/j4BADCyuHYp9X6fxN
 DQClMyDPZ80bwTUSgnidiGeznKNirqyvvUpCfN/C+DTmpMsLiuGyo3iXdFV+hYTabr
 ttSDgACXelywvnz8RpHkxJ4tNHYDc6t6zAOk7i54eREaY2TXp0mQdR0/MdOo82ydkX
 LbPTuJpW+ekW2GOE4FdQ5BJ9B8UAnb27cHVGDT3LKg99ERrBNNNIt/q/+PANdrbYR+
 2gJOyRVNe0m5gJyqtO4jBP5aL+PCbdU60/Zpt5MpSCrccNl2KIZqCC/kVP7+AzBhkd
 aqOpFiXaF2Vlw==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 27 Oct 2023 08:16:49 +0900
Subject: [PATCH 6/8] usb: xhci: Do not panic on event timeouts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-usb-fixes-1-v1-6-1c879bbcd928@marcan.st>
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=837; i=marcan@marcan.st;
 h=from:subject:message-id; bh=Uwz6+kZfZJmuB7ysnARjuDoiI+88/kajt+fzm4o9g2A=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlSrz0mHdXk47BfN+hTC9fSCVJ7GP8uJzRFL3z9KSlx7u
 a/y4/yFHaUsDGIcDLJiiiyNJ3pPdXtOP6eumjIdZg4rE8gQBi5OAZiItxjD/5DpApVxAVazH4o9
 PHvuYWbpXFvlrz4mnLruD9JiO3TcpBgZ1vS/SFLjnPr0S5WdmKvpG+vPfxfPeCofVP/eLT3m5cF
 bHAA=
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

Now that we always check the return value, just return NULL on timeouts.
We can still log the error since this is a problem, but it's not reason
to panic.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 3ef8c2f14ccc..b95f20642943 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -494,8 +494,9 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 	if (expected == TRB_TRANSFER)
 		return NULL;
 
-	printf("XHCI timeout on event type %d... cannot recover.\n", expected);
-	BUG();
+	printf("XHCI timeout on event type %d...\n", expected);
+
+	return NULL;
 }
 
 /*

-- 
2.41.0

