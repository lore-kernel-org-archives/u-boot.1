Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F431D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEC583DC9;
	Mon, 29 Dec 2025 13:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CZFfj4lL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE8283DCA; Mon, 29 Dec 2025 13:33:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E39B83B82
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 13:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C16FC413C1; 
 Mon, 29 Dec 2025 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767011628;
 bh=Y9Mqu9NspriPQGbK1yjwc9FU8sT2SiGYku1I5GEgFpQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CZFfj4lLXDY0Yse18QRPZKOG+8JCFl36GC5RBoHq16SRc/OXnhth8ScztnrTAYq9c
 FEzesiVbExu48kXSjmlanlBcw31QmnXTsRXZtO64StdTCx4kkch6SFcQWA8wjAcVF5
 Or5hYsuVd8zgIP2DXupZorTT9yx4fTkRcLbnTSUm+tNAl0usppR3Vpo3CCVKTDcnM6
 V4m4zloakQf6hU3WcP5qeLD6AXjqiigFzDxYjEzTmCdLc+6j6C+B9OTNYHLFMFK1Ad
 HcHnFhUYIpUcgqizOGSgrvbI3qRIWtvYtB/f4ysjpUDHweJDnnpc63dVJUJTEebWbA
 C3PEGnZoJMoKNxvYbDURTWSJK1L+DLqSI5l3jockHSqFp+/qL8yPZLzkj4plPNPuvG
 xyI42f0fV9vhRzYxZlvSe0FtiPTxINaiI4YTl5ioGEoowZURwt0WkGwIzfbkLCJOUl
 DQD7Y3Xn+pATJRdsmy8CmFMfPojXMyggzopEPkrgDW6hxlBI6GZa68t4gKwu3tDvJN
 nO9vWIKVNMJ96xdSLFXIpX259TlKUOm5uRgc3X42MsA548A64HBRKPfCjVvdB92WJo
 WjnpIsaN5FVCkWKfgiIRR0NfmOJVUmp8iMiguHWR9UORsSbIU314YD0WSnv4O3tsrT
 ddh9wgnnZ56Ziy6Z+sWONXOg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Manjae Cho <manjae.cho@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] Fix typo "addtional" -> "additional" in pflash section.
Date: Mon, 29 Dec 2025 13:33:44 +0100
Message-ID: <20251229123344.7365-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

From: Manjae Cho <manjae.cho@samsung.com>

%s/addtional/additional/

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove unrelated change
---
 doc/board/emulation/qemu-riscv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index b5948d9affc..229a7700ac7 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -43,7 +43,7 @@ qemu-riscv64_smode_defconfig instead. Note that U-Boot running in supervisor
 mode requires a supervisor binary interface (SBI), such as RISC-V OpenSBI.
 
 To create a U-Boot binary that can be utilized with a pflash device in QEMU
-apply these addtional settings to qemu-riscv64_smode_defconfig:
+apply these additional settings to qemu-riscv64_smode_defconfig:
 
 ::
 
-- 
2.51.0

