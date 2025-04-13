Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD5C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 13:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD222829E4;
	Sun, 13 Apr 2025 15:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ZeIWaudk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 732B982A65; Sun, 13 Apr 2025 13:01:31 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE6D8210E
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 13:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbabic@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5362DFFA36; Sun, 13 Apr 2025 13:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1744542088; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=d+QIycbQFe5Z2a6WGQreAftw3AFlNrncWY+jBoHj4S0=;
 b=ZeIWaudk5Vo8+aL38kyqFD2pLi0SNBNiVgdb+6Y6uw4sIYQGlHUtLiQ+8y15JuR9RgyOqZ
 26YZ7ZKGUcn8enhAUa9Mku5VFAxedv9iGHBiPerkysTKq9x2zhvomnj5BUUj2o1r6rP+cd
 swujpZpGwQ81cZ+pTojYIyH+5t33HAxFZjyrn9vsUgvPaC/jIrQ8xDbAHI1SVfhwT7B7rZ
 TQRWVnOs4Rn5X42CNn4iiD4CgsZ0BxQHn7jUsIhbwnvUvBtpUFymLIExtReCsWKypESAvz
 p8Ro9lvtfj6Gi7FuRb5ZFLmRgCBeo42IzdqpqlixKQvrXYaAGl4IluCbZEx85g==
From: Stefano Babic <sbabic@nabladev.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH] MAINTAINERS: Update email of Stefano Babic
Date: Sun, 13 Apr 2025 13:01:18 +0200
Message-ID: <20250413110118.1027383-1-sbabic@nabladev.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sun, 13 Apr 2025 15:38:24 +0200
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

Replace my old e-mail with the current one to get still involved in the
project.

Signed-off-by: Stefano Babic <sbabic@nabladev.com>
---
 .mailmap       | 2 +-
 MAINTAINERS    | 2 +-
 doc/git-mailrc | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 85086602cd5..493bc84a94a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -123,7 +123,7 @@ Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.
 Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
 Srinivas Neeli <srinivas.neeli@amd.com> <srinivas.neeli@xilinx.com>
 Stefan Roese <sr@denx.de> <stroese>
-Stefano Babic <sbabic@denx.de>
+Stefano Babic <sbabic@nabladev.com>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
 Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
 Tom Rini <trini@konsulko.com> <trini@ti.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 042d3f6160a..a9c0d727748 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -294,7 +294,7 @@ F:	test/cmd/armffa.c
 F:	test/dm/ffa.c
 
 ARM FREESCALE IMX
-M:	Stefano Babic <sbabic@denx.de>
+M:	Stefano Babic <sbabic@nabladev.com>
 M:	Fabio Estevam <festevam@gmail.com>
 R:	NXP i.MX U-Boot Team <uboot-imx@nxp.com>
 S:	Maintained
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 1177e42df2f..6214daeaecf 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -42,7 +42,7 @@ alias mbrugger       Matthias Brugger <mbrugger@suse.com>
 alias monstr         Michal Simek <monstr@monstr.eu>
 alias prom           Minkyu Kang <mk7.kang@samsung.com>
 alias ptomsich       Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
-alias sbabic         Stefano Babic <sbabic@denx.de>
+alias sbabic         Stefano Babic <sbabic@nabladev.com>
 alias simongoldschmidt Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
 alias sjg            Simon Glass <sjg@chromium.org>
 alias smcnutt        Scott McNutt <smcnutt@psyent.com>
-- 
2.43.0

