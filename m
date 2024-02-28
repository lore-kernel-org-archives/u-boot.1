Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F00AC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 08:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D94508796B;
	Wed, 28 Feb 2024 09:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oSqtdiIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3C787DD1; Wed, 28 Feb 2024 09:59:02 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22468785E
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 09:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709110738; x=1711702738;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8LWwcrY36OvUeQQbVD2WYbqPPr8cZiPRDc4s/39bW/k=;
 b=oSqtdiIw7GTvBOYam1q7aUV18kRaonQ3TqXWNRE5a0+rikO19P/xVhhSMWoObLD7
 LtCnuBfx1ZCepWh31OmLIHu2uEv2vndcOcjJ4uAE1TSoShUCL1dO1ETZ0nzm1cqn
 Rs5QRve1Z+s/0EzbJZhv1eoSGeK9IPF5MYPnQPU03Bs=;
X-AuditID: ac14000a-fbefe7000000290d-5e-65def5d20723
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B9.C3.10509.2D5FED56;
 Wed, 28 Feb 2024 09:58:58 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 28 Feb
 2024 09:58:58 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <d-gole@ti.com>
Subject: [PATCH] doc: board: phytec: phycore-am62x: Update artifact names
Date: Wed, 28 Feb 2024 09:58:48 +0100
Message-ID: <20240228085848.1230795-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWyRpKBR/fS13upBrO6FS1a1npYvN3byW7R
 /U7dgdnj7J0djB793S2sHsdvbGcKYI7isklJzcksSy3St0vgyli5soe1YBJ7xc6T3xkbGH+y
 djFyckgImEic7t/H0sXIxSEksJhJYv7yncwQzmNGiad3H7OBVLEJqEvc2fANrENEQEriZedG
 ZhCbWUBfYuqZXWA1wgKeEntXLAKKc3CwCKhKbLqaA2LyClhKHH3pDbFLXmLmpe/sIDavgKDE
 yZlPWCCmyEs0b50NNVFC4uCLF2C2EFD8xaXlLDC90869ZoawQyWObFrNNIFRYBaSUbOQjJqF
 ZNQCRuZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEHhKcLAtYOxb47HIUYmDsZDjBIczEoivDKC
 d1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MBpsbVET
 rIm3KZkmfZJFLoSbbd6egl9/+ULcwxY/VcooUl89nXtj0/W0z2oXmmM0ZMXTX+zSFbwhzrfG
 e/prWTdZm3qF9klT90lJaH3TOh773MQu+33FjYoFam7sB70zm5lkT9x/LSFRcj1W5PeH+nW5
 H2bPUlkU03PkmtT9yM9fDRpa/nkwKbEUZyQaajEXFScCAJgf3tw9AgAA
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

Use proper binary artifact names for HSFS devices.
Do not use the *_unsigned binaries.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/phycore-am62x.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index 1d641a78cf..bc6d524669 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -92,9 +92,9 @@ Assuming the uSD card is `/dev/mmcblk0`:
 To boot from a micro SD card on a HSFS device simply copy the following
 artifacts to the FAT partition:
 
-* tiboot3.bin from R5 build as tiboot3.bin
-* tispl.bin_unsigned from Cortex-A build as tispl.bin
-* u-boot.img_unsigned from Cortex-A build as u-boot.img
+* tiboot3.bin from R5 build
+* tispl.bin from Cortex-A build
+* u-boot.img from Cortex-A build
 
 Boot
 ----
-- 
2.34.1

