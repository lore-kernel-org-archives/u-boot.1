Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C66E77180
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 09:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED35B893EB;
	Tue, 10 Dec 2024 10:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qwlenem0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF66E89403; Tue, 10 Dec 2024 10:16:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB1889220
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 10:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BA9GnWH001056;
 Tue, 10 Dec 2024 03:16:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733822209;
 bh=uUnUWLYniFdA75BvNVtajdMBj6mnDPSYmoxXSpElvUw=;
 h=From:Date:Subject:To:CC;
 b=Qwlenem0xKnLzE/Tz974gcgaOL9tXS9KsLABl3DoEvFPUAyQVFEKcWmKS7sn4YSli
 EeHIi/X/JZylMT0zc9Uv3FDRNTdU9VIWB9XjSUF7qaZ6kDiM2pouXnc4X9Eb9NNx2L
 TIVfVW2rWeKsyxh7oU8naMOwGiTF8mOh//eTWo50=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BA9GnHm016198
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Dec 2024 03:16:49 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 03:16:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 03:16:49 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BA9GkEG079833;
 Tue, 10 Dec 2024 03:16:47 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 10 Dec 2024 14:46:45 +0530
Subject: [PATCH] Makefile: Match the full path to ccache for filtering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241210-b4-upstream-fix-ccache-v1-1-778d07f6d8ba@ti.com>
X-B4-Tracking: v=1; b=H4sIAP0GWGcC/x2MuwqAMAwAf0UyG2hacfBXxKHG1GbwQasiiP9uc
 TyOuweyJJUMXfVAkkuzbmsBqivg6NdZUKfCYI1tyJLBscFzz0cSv2DQG5k9R8G2dWFiR4EpQIn
 3JMX+43543w/3gb40aAAAAA==
X-Change-ID: 20241210-b4-upstream-fix-ccache-663fdc31fc1f
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
CC: <u-boot@lists.denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733822206; l=1281;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=0uNY+vnn4eILxLops8kOkv+1yCfANgUY3HLTD5TXI1g=;
 b=e+BRsQspMekIdBp69iNC4vVBTxmhXL8SrTeLY+hJ5MWuP1aQflTf1sYNcb0olTBmZdpl4B9OW
 u87R3oZEeBSBjBBgsrFTNKhKyqEu+xeVFuaSjRRWF8zyo1DzFVU8S25
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

One can use ccache by keeping ccache in PATH or by providing the full
path to ccache as well. Providing the full path to ccache fails as the
current regex tries to look for ccache being the initial token during
filtering.

Do a greedy search to remove anything before ccache for regex matching.

Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2e49f6088ccd7d281ace651a011149418e1d5c9b..70ed4983aa4a1a45fa32b5718705e3936b6d428d 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
+  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(.*ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))

---
base-commit: b841e559cd26ffcb20f22e8ee75debed9616c002
change-id: 20241210-b4-upstream-fix-ccache-663fdc31fc1f

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

