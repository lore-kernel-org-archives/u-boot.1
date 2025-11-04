Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FFCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1F38004F;
	Tue,  4 Nov 2025 11:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="H6lKZIV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43D2808AF; Tue,  4 Nov 2025 11:46:07 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8F48003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0714AC0E608;
 Tue,  4 Nov 2025 10:45:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D490A606EF;
 Tue,  4 Nov 2025 10:46:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0BE1102F1CE8; Tue,  4 Nov 2025 11:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762253164; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=pc37e1/44/mzdWfTrEmy3iZwzdjDDHoHEWt0JXY31k0=;
 b=H6lKZIV9pwWPzCy0JJfCcfoh9XBTTYZ9DhpaI5wwJS5T2ybDJK1EbnFyuEDB8ag3zgmC7E
 x6+r+t+YpiMCewuHIkcNCu/w4Tdsd7GXwcNoVIC5sSzgWpwJyQ6C00C1kMXZgmJ/5zCjmi
 5v1uCffBwY/aMRijJiyBJf3dyRTilwgJRekXs6ZuMDeeMeMW9W9kcrbnJWLlaoVwyIrxkv
 fdMMGQ1nfUNnPP2WORdnuIC0F2C2jzI2urUI3iZFku/BP4OyhXXx0XDXSqnTkuRGGjJWW9
 11AuWBi2VDSMyAqrEE2NFwca8Vc78zwtkAX78TYF8+zBL0QC2b1qkvM+N/1Tmg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH] doc: bootstd: Describe the optional extension_overlay_addr
 environment
Date: Tue,  4 Nov 2025 11:45:28 +0100
Message-ID: <20251104104530.1064647-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

Add extension_overlay_addr description to the list of environment
variables that can be useful during the standard boot.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 doc/develop/bootstd/overview.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 6cf3b48efca..d3dba2a3405 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -261,6 +261,9 @@ fdt_addr_r
 fdtoverlay_addr_r (needed if overlays are used)
     Address at which to load the overlay for the FDT, e.g. 0x02000000
 
+extension_overlay_addr (needed if extension is used)
+    Address at which to load the extension FDT overlays, e.g. 0x02000000
+
 kernel_addr_r
     Address at which to load the kernel, e.g. 0x02080000
 
-- 
2.43.0

