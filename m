Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1113FE77180
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 02:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B3C800B1;
	Sun, 15 Dec 2024 03:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="U4gPpdr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF25800AA; Sun, 15 Dec 2024 03:37:55 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C17F78008A
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 03:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CBBB741227; 
 Sun, 15 Dec 2024 02:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734230271;
 bh=49hhvzjKkypNFbZzEyvJ3+Bf+kLkoVrTCJ6qdbHiCGQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=U4gPpdr/17ZmAjIvu/PxPLSI61fxOzR8C3xb5h+g6HHtwnUmQ/JFwX9kG76O8h+ZS
 j5/OJ+BJZmWBG1ymftj0t0x+dCigDfb+I2XAb1a+433LWtDVTXRCeNWRopxeHLyB/U
 yM0RmF14VIutB3L96RDXlSTqKAHPfWSzR061VyrJ1EDyLP7T75gE6WI6IU6KGulX/X
 J6Bx43hzJBjT5gbKnBMJVg92h9SUnx6DOi6XAYAqm9+ZWKHtQ84EOYn9w0p4riV9km
 Cbop/Zs2sLXWV466BMEeQfWTpRR0SdITdAOsaGUdmH7CDtbyeeZrjcqPNMcctWX+2U
 mJXwvHwL2eHXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] scripts/spelling.txt: add GPL-2.0+
Date: Sun, 15 Dec 2024 03:37:32 +0100
Message-ID: <20241215023732.68902-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
References: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
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

The correct SPDX identifier for the 'GNU General Public License v2.0 or
later' is GPL-2.0-or-later.

Link: https://spdx.org/licenses/GPL-2.0-or-later.html
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 17fdc620d54..61a3e86deef 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -694,6 +694,7 @@ genereate||generate
 genereted||generated
 genric||generic
 globel||global
+gpl-2.0+||GPL-2.0-or-later
 grabing||grabbing
 grahical||graphical
 grahpical||graphical
-- 
2.45.2

