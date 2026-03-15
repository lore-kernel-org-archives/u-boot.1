Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A59F3027F
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 23:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 968C3844C1;
	Mon, 16 Mar 2026 00:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EY2ybcl0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iUCB2QaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A53844C3; Mon, 16 Mar 2026 00:58:22 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A16844C0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 00:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fYwCc1XDCz9t8m;
 Mon, 16 Mar 2026 00:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Aehqg9VA4NpUnaWBTrWtO2o0VFBODSPCWiiLz0bvYTg=;
 b=EY2ybcl0xZ88W9k0620iAfoeSGQpn5/PWfj7tObNb+HRGpCdcFMPnP0ySxs57Q8Vj7KH+h
 4kPYReEJcpQKJtiO4AUNmO8yqszkiLHgNIe6sVVc5ovnhK0BFhALSeqUIV31+wt7JVZKQL
 xZlVguoKQS5oRcagDvbSP2dnPMKvOd3JDdzUhqX3Vh2IKyWHMCEDUcVKIM7s7EyVkFm/Hh
 xx3UInP60xse5u5Ccph2CPVbs/Zo9sR8OnoWhgXnlvzGN6GPk4/QFPAfsWzpBelqVTo7W+
 CxT+PCOkJ4gjfl51mM+XPbWipWxCHGlHzv4Lmvy+TZffgVMbJw773Ouy7/KWZg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iUCB2QaP;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773619099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Aehqg9VA4NpUnaWBTrWtO2o0VFBODSPCWiiLz0bvYTg=;
 b=iUCB2QaPaFf1NyUvRkr2BM330SfMjUGZZC7An18xxbkOzjN/1yNrU2XDqKiwAovfCkOwIe
 V+50t0pqwHYs/jAFZdiaONy4JS9qlmx40P13XYV0GSOkWtx+2ZeVeGGTx5o9aFKH7SNR+u
 TAbujn6l2krhg4dK1sJCc++55ZYgXLQUQm7schPg3h8wiD/+R7ps/TvlnvjGXihugGCApY
 SYC6j/o690D9Aff72A3lOz+eRl9KvlR/3Y9UkqNZz7miFBL9QDwoHrcVeS7vVz68af4X9u
 uzGJjZwVUlL06Nuvtp+lvc6LSVeVCqzfGDTP/x+kb019vqvtFQ91fJeLK/n4RQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: bcm: Include missing errno.h
Date: Mon, 16 Mar 2026 00:58:06 +0100
Message-ID: <20260315235816.305016-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qaox19y6tjj1633gh3rjwmb47sa48ji9
X-MBO-RS-ID: 555e1a174c3848b69f6
X-Rspamd-Queue-Id: 4fYwCc1XDCz9t8m
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

The msg.c file uses EIO macro defined in errno.h , include errno.h
to avoid build failure:

"
arch/arm/mach-bcm283x/msg.c: In function 'bcm2835_power_on_module':
arch/arm/mach-bcm283x/msg.c:73:25: error: 'EIO' undeclared (first use in this function)
   73 |                 return -EIO;
      |                         ^~~
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-bcm283x/msg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
index 4993c0bdb81..05e1a02e80f 100644
--- a/arch/arm/mach-bcm283x/msg.c
+++ b/arch/arm/mach-bcm283x/msg.c
@@ -7,6 +7,7 @@
 #include <phys2bus.h>
 #include <asm/arch/mbox.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 
 struct msg_set_power_state {
 	struct bcm2835_mbox_hdr hdr;
-- 
2.51.0

