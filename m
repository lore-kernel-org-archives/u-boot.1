Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECCFD2E9C9
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C2D8931A;
	Mon, 11 Nov 2024 10:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PtnxIfQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BFB8930E; Mon, 11 Nov 2024 10:50:44 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097C089345
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4AB5A3F3A6; 
 Mon, 11 Nov 2024 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731318640;
 bh=/1HGnErUniJVf84Z113+thubvgM5TQU+XtjslWIn92s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PtnxIfQjjGTP5lAd+tbjSdDKjVWmbDrX4ideA2fpnTLq6KCWxz6mHYmY56QrH7DLX
 47EHHpvw97DzC/0CRj+k4eQrGa2jbxRTmGgCVnrTVsFfCPU08Mo/OZswCgD6VqWzMA
 Fz3sl5P8r5CWxTbO2nAuXwK0VErxoBHMOm+Is6/WAN7kjTZ+lbJofifIL7+Cl9izYF
 3ANL2mLAksdXrgBUobi89yOP4dnHuyu2GQ+Iw4ddRkO9ouI/NIzxy27V84ew8GFJOK
 cSCzSFz0utMkyxODXq9MB45XgQno6zGnVjEIgMjM4yVstyNlrfQSDHnfWl4Khs9Q9z
 tZz5Swc1fwdwQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: improve description of the cdp command
Date: Mon, 11 Nov 2024 10:50:35 +0100
Message-ID: <20241111095035.35319-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Users might not know what 'CDP' refers to. Provide basic information.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 636833646f6..c55a39600c3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2016,7 +2016,9 @@ config CMD_PING6
 config CMD_CDP
 	bool "cdp"
 	help
-	  Perform CDP network configuration
+	  The cdp command is used to announce the U-Boot device in the network
+	  and to retrieve configuration data including the VLAN id using the
+	  proprietary Cisco Discovery Protocol (CDP).
 
 config CMD_SNTP
 	bool "sntp"
-- 
2.45.2

