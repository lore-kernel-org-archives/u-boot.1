Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F77FC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 15:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7575C86F56;
	Fri, 17 Nov 2023 16:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Df6arIKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66C686FBE; Fri, 17 Nov 2023 16:00:48 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC8786EE2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D8E82000C;
 Fri, 17 Nov 2023 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1700233245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BFYgt3YSwc3c7zwmUHoXs2tB4th1gjHzbfPcaB3KVlQ=;
 b=Df6arIKCOvr7YCMNZEic6HcU6Bjkjm4qeE7MLZkwoCNVPd3u77e/bWzszh9ifSRmHYtUuu
 jJIYKIVpM9V8PH0SH4zB4IgKGQqnJv3z4YTkIjy+5HOroxaver7llLqA4MRRHYZ1o6dXB2
 UAWUjyLiS5J3JAi0Vp7EE6dHCq9Us1NlyN9ixYJgilHAJYyPisSMMmERPfOC4xmQRGKUaS
 imoUG9Y4bTfcHLzQbRyrcpNM1P8yBxrBJtwgN2IXYmt5PeY2qchOE8eO6EtBKTO6V7iMmG
 QdZNdO7bEDitoGDBt88iU2OAUVzuTxyGhpnS8mdx7lNZ+ABTwTJNI3a1nU+ufA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Niebel <Markus.Niebel@tq-group.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] tqma6: Fix DDR configuration
Date: Fri, 17 Nov 2023 16:00:44 +0100
Message-Id: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

Initially investigating a Linux network issue causing a lot of drop and
poor network performances on a custom system based on a TQMA6A module
(based on an iMX6Q), [1st link below].

I eventually correlated my observations with a contention at the NIC
level when in concurrency with the graphics pipeline. Troubleshooting
this in the kernel lead to disabling DMA bursts accesses made by the IPU
in order to avoid triggering the QoS at the interconnect level, reducing
from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
worked on my setup but not on others, which still suffered from
abnormally high drop rates even with this "fix".

After looking a while into TQ Systems BSP I figured out a number of
differences in recent U-Boot out-of-tree patches they had in their
repository [3rd link]. Parsing the differences one after the other lead
me to this final solution.

The reset pad of the DDR controller was apparently misconfigured, Bit
18-19 picturing the "DDR select field". The current value b11 is
reserved. The only defined value as of version 6 of the iMX6Q manual was
b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
spotted after changing this configuration but all issues tracked thus
far just vanished. All previous fixes have been proven irrelevant. Just
clearing this field solved all our network issues and the drop rate as
measured by iperf3 felt back to 0%.

Link: https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
Link: https://lists.freedesktop.org/archives/dri-devel/2023-October/428251.html
Link: https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916c28467b85485911dad3da6bc
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 board/tq/tqma6/tqma6q.cfg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
index a49489aed3f..a345c4de93d 100644
--- a/board/tq/tqma6/tqma6q.cfg
+++ b/board/tq/tqma6/tqma6q.cfg
@@ -36,7 +36,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
 DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
 DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
 DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
+DATA 4, MX6_IOM_DRAM_RESET, 0x00003030
 DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
 DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
 DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
-- 
2.34.1

