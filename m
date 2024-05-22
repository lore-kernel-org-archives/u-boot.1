Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDB2C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B90388858;
	Wed, 22 May 2024 17:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="PpJF8w8I";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXnrtIO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32CB488858; Wed, 22 May 2024 17:35:11 +0200 (CEST)
Received: from wfout5-smtp.messagingengine.com
 (wfout5-smtp.messagingengine.com [64.147.123.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3455787AD2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 6250E1C0017B;
 Wed, 22 May 2024 11:35:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 22 May 2024 11:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392107;
 x=1716478507; bh=SyfO/qDpqlXwbz8kGJnhz6Sm1vKfY4dYGC8PEM21yik=; b=
 PpJF8w8Ioz5hNyuRRiApPwAf4BcWTfGcGhspEkIgfjkWmda/vGa4pUPe3dh7U832
 fOfL2uT5fMRAYPczuCEDcxm28R1AuaMM3YNhUSYUD7UNuc8wx9mXQrDu4SrcnkXL
 ZamDzmuTbpeDuyxZKe9+xn/oFy+saNjNIIUfxbUcFUo2GUGJrbEY6uaKqKhisajS
 5SFDaO4tNFYunxSv0OnTzYOzbnvI8+r++OYGgMrU1BCXMvGodGuvzQtmyzff2Ie/
 uNZzr82LSU6K8kp+vXdmTrgnlHccfP+v08h0XBmh+9sswFvfXObL1w48WWaaDdje
 pJ/lIcKJLzztq4sqclCqkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392107; x=
 1716478507; bh=SyfO/qDpqlXwbz8kGJnhz6Sm1vKfY4dYGC8PEM21yik=; b=c
 XnrtIO6VVrTwSgAeKxMjv7F0ItYqA4Axc53qbVnnlqyixrrFR/DubpZl+Ugd4iFU
 4JITXAJOClAzcbpVOhhwwQ62un5FWWAGtIsuN2skOHkMFe6XyJOdzWMraK0HxWcn
 L8WdfNgTw/N0IoHwrgGXQ7m57A5cd2+S51wtOpLHqLISsVMzrpqJjeiUPLqKvo5l
 +VQE6xo7e0bi2xejcWhcinYdPcJ5Djr3gduuQHn6j96X4S7g425IAFhTv5nVy2y7
 zg7ZajbxIpj5R0HFOFY48J6i7WUF8ujSGeW/QheAOHuxYnotW05BFyxPXzhQ48mN
 DS38+UurBpMhICJDRcT1A==
X-ME-Sender: <xms:qhBOZkBNI99TnJjsF-2q58zWkWEnTCMacoISTccQTV1VsNlvV2a5mA>
 <xme:qhBOZmiAZbhEnOxysPDK7ei8tfqz4yjw-ENLQXAcj5N5dAm43zSNkY1_GzqsSYjAO
 0hicy8JzrE5_SEe8rA>
X-ME-Received: <xmr:qhBOZnl01Tu6YALd0LM2HI_FMTI0Ea7VKqndLXlbLU8srRB74EJ8iZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:qhBOZqy59tLJjwiRzTgqtXl-Lju8LzpYmO2tAmFVwOSWsaNZfSDL_Q>
 <xmx:qhBOZpRasQz02lxpP92JesCVouFmJfAYsbv99rW80kfqFdbBaJJkqQ>
 <xmx:qhBOZlYlOxjz-V7F1laZN3BfEOaR5umPpfZt1sCEB0NTOYbrtnLt8g>
 <xmx:qhBOZiS7n-Yf83MSRATvlL4GiJY5bYZggTGfXzHwIK6dzxG1gJzWzw>
 <xmx:qxBOZoGC_poIzxVIeBNNn-sX039bAAAZrGFQaXUcPW2GOFYhgvdoPQ_5>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:45 +0100
Subject: [PATCH 02/16] linux/io.h: Use map_physmem to implement ioremap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-2-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=djYYs4kbOkIoMpk8/VSpZY8R5qyTqgu0CkC0gl4DHoQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geU+OcWWb6akbhf7L1foEfh067QYm2reluuT99vzX
 7J78n9aRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzE5AfDPzUhyW7noNkXji9f
 kfsoME9ZOLrDhOXehPlJKdwigVqe5xj+O5/lUUpw/d+os1jyekrk43tX494rn8k49E47bBsT7wl
 RTgA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

ioremap API is here to be compatible with Linux drivers,
to maintain compatibility we need to ensure we are using
the same way to determine virtual address for IO devices
from physical address.

map_physmem is U-Boot's standard way for doing the trick,
we should follow that. For architectures VA == PA it has
no impact, for MIPS it has it's own ioremap implementation
in asm/io.h anyway.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 include/linux/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 79847886be95..ada6525a1c6a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -59,11 +59,12 @@ static inline void iowrite64(u64 value, volatile void __iomem *addr)
 static inline void __iomem *ioremap(resource_size_t offset,
 				    resource_size_t size)
 {
-	return (void __iomem *)(unsigned long)offset;
+	return (void __iomem *)map_physmem(offset, size, MAP_NOCACHE);
 }
 
 static inline void iounmap(void __iomem *addr)
 {
+	return unmap_physmem(addr, MAP_NOCACHE);
 }
 #endif
 

-- 
2.43.0

