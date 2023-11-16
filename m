Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A8C47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B1987465;
	Thu, 16 Nov 2023 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Qv/8i6zL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F64787465; Thu, 16 Nov 2023 10:10:48 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3850D864E7
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 440CE3FBFC; 
 Thu, 16 Nov 2023 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700125842;
 bh=KmU0GeqiKMKVsxEqBdRj7PE4koIRJMPpE3n6DXHMIRE=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Qv/8i6zLoYZiZ4xRM7Y+5oVlGd0WgB5tx9xBiZL62cfNrmDilf5c3xlv55LJvr8Qa
 DVWxAtxOWd6K4FIYfREG4J0875qLb93wkopQCvmT2EHC5doZEe2tdAAxAimEWS6N3w
 VqORdUiPhIcqnXDvr/BHL3fOuJ+m54V7jtNXHz8yPFPiXnQkbVXoqic5aiDpOHnBKg
 iYm+2uQnV6RFG3o0BqsSetuvIQILmSehW+9D0/OdbKwT+/nN4uyjRYKzeYX6Rh8xhG
 rpg6PHMTKM6xwbO0/hVpeyy0jGJQQ2rzGxyinqXAwinlgsyxNmWzlfEO83tk20aEIO
 En/OVlK14SZlQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: typo fdtaddr_addr_r
Date: Thu, 16 Nov 2023 10:10:33 +0100
Message-Id: <20231116091033.20770-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

%s/fdtaddr_addr_r/fdt_addr_r/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/bootstd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index 51cd573662..496e24bc7a 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -247,7 +247,7 @@ fdtfile
     Name of the flattened device tree (FDT) file to load, e.g.
     "rockchip/rk3399-rockpro64.dtb"
 
-fdtaddr_addr_r
+fdt_addr_r
     Address at which to load the FDT, e.g. 0x01f00000
 
 fdtoverlay_addr_r (needed if overlays are used)
-- 
2.40.1

