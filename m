Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770B2C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 18:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D121681ED8;
	Fri, 14 Mar 2025 19:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wwwdotorg.org header.i=@wwwdotorg.org header.b="HClmTLW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC46181F0D; Fri, 14 Mar 2025 19:10:42 +0100 (CET)
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [104.237.132.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F07681E92
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 19:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=wwwdotorg.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swarren@wwwdotorg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wwwdotorg.org;
 s=default; t=1741975839;
 bh=wrk1jxSk11b6J2NSiRJzlpuWRTadYjMe9V4tnY6wp8o=;
 h=From:To:Cc:Subject:Date:From;
 b=HClmTLW5pBIBaLDTSoC69/isZ+yQ7YfqBJrhls6hVo4hIVjvD60Z7Ewz46OQRzC3C
 OnopsGruF5i7APpVVgf76xUVhSI7vLq0QF2d5y05ebltjOYKlvOlWngAecpPb/vVOs
 4BHoqmgJP+i6iuzK5yWfhoOfFYqGJdcNlWlUTMfANu/B1rdRbB4bsB61gU+Pyf67+p
 YFY8QHRdkZZAMF26pX3p/Ed2HooywtuEzztSdE02uQ6JuppgzGdqtwPuwHDcOHhyN3
 E9y09niYLIIJO1/l8lo6iJlZC1CPNYa3Y7LkwYSqcg0anXf4hWk6G64TFtaYph1MQ8
 Dom4TiTU1rfhA==
Received: from sprint.hsd1.co.comcast.net (c-76-25-134-221.hsd1.co.comcast.net
 [76.25.134.221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by avon.wwwdotorg.org (Postfix) with ESMTPSA id ECF601C0121;
 Fri, 14 Mar 2025 12:10:38 -0600 (MDT)
From: Stephen Warren <swarren@wwwdotorg.org>
To: trini@konsulko.com
Cc: twarren@nvidia.com, sjg@chromium.org, u-boot@lists.denx.de,
 Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] disable mail for swarren
Date: Fri, 14 Mar 2025 12:10:31 -0600
Message-ID: <20250314181031.7978-1-swarren@wwwdotorg.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-NVConfidentiality: public
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

From: Stephen Warren <swarren@nvidia.com>

I haven't been involved in U-Boot development for quite a while, so
CCing me on patches isn't currently useful. Add a .mailmap entry that I
believe will turn off patch CCs. This can always be removed if I become
active again! Remove myself from a few MAINTAINERS failed and the git
mailrc file too.
---
 .mailmap                             | 2 ++
 board/compal/paz00/MAINTAINERS       | 1 -
 board/compulab/trimslice/MAINTAINERS | 1 -
 board/nvidia/beaver/MAINTAINERS      | 1 -
 board/nvidia/jetson-tk1/MAINTAINERS  | 2 +-
 board/nvidia/p2771-0000/MAINTAINERS  | 2 +-
 board/nvidia/ventana/MAINTAINERS     | 1 -
 doc/git-mailrc                       | 2 +-
 8 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index ff85151702f8..250edffc0729 100644
--- a/.mailmap
+++ b/.mailmap
@@ -124,6 +124,8 @@ Srinivas Neeli <srinivas.neeli@amd.com> <srinivas.neeli@xilinx.com>
 Stefan Roese <sr@denx.de> <stroese>
 Stefano Babic <sbabic@denx.de>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
+No generic patch CC mail please <noreply@example.com> <swarren@wwwdotorg.org>
+No generic patch CC mail please <noreply@example.com> <swarren@nvidia.com>
 Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
 Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
diff --git a/board/compal/paz00/MAINTAINERS b/board/compal/paz00/MAINTAINERS
index ee2b2e95458d..ba174cd190db 100644
--- a/board/compal/paz00/MAINTAINERS
+++ b/board/compal/paz00/MAINTAINERS
@@ -1,6 +1,5 @@
 PAZ00 BOARD
 M:	Tom Warren <twarren@nvidia.com>
-M:	Stephen Warren <swarren@nvidia.com>
 S:	Maintained
 F:	board/compal/paz00/
 F:	include/configs/paz00.h
diff --git a/board/compulab/trimslice/MAINTAINERS b/board/compulab/trimslice/MAINTAINERS
index 85b120017f7f..4eb868c0c838 100644
--- a/board/compulab/trimslice/MAINTAINERS
+++ b/board/compulab/trimslice/MAINTAINERS
@@ -1,6 +1,5 @@
 TRIMSLICE BOARD
 M:	Tom Warren <twarren@nvidia.com>
-M:	Stephen Warren <swarren@nvidia.com>
 S:	Maintained
 F:	board/compulab/trimslice/
 F:	include/configs/trimslice.h
diff --git a/board/nvidia/beaver/MAINTAINERS b/board/nvidia/beaver/MAINTAINERS
index 26bcacc8ec95..20d5836b9ec8 100644
--- a/board/nvidia/beaver/MAINTAINERS
+++ b/board/nvidia/beaver/MAINTAINERS
@@ -1,6 +1,5 @@
 BEAVER BOARD
 M:	Tom Warren <twarren@nvidia.com>
-M:	Stephen Warren <swarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/beaver/
 F:	include/configs/beaver.h
diff --git a/board/nvidia/jetson-tk1/MAINTAINERS b/board/nvidia/jetson-tk1/MAINTAINERS
index a5c687d149f4..f0d8f5eb8e52 100644
--- a/board/nvidia/jetson-tk1/MAINTAINERS
+++ b/board/nvidia/jetson-tk1/MAINTAINERS
@@ -1,5 +1,5 @@
 JETSON-TK1 BOARD
-M:	Stephen Warren <swarren@nvidia.com>
+M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/jetson-tk1/
 F:	include/configs/jetson-tk1.h
diff --git a/board/nvidia/p2771-0000/MAINTAINERS b/board/nvidia/p2771-0000/MAINTAINERS
index cf4913a9a1db..1a49e63231de 100644
--- a/board/nvidia/p2771-0000/MAINTAINERS
+++ b/board/nvidia/p2771-0000/MAINTAINERS
@@ -1,5 +1,5 @@
 P2771-0000 BOARD
-M:	Stephen Warren <swarren@nvidia.com>
+M:	Tom Warren <twarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/p2771-0000/
 F:	include/configs/p2771-0000.h
diff --git a/board/nvidia/ventana/MAINTAINERS b/board/nvidia/ventana/MAINTAINERS
index 285b84dbdcbf..ba65a2bfc2fb 100644
--- a/board/nvidia/ventana/MAINTAINERS
+++ b/board/nvidia/ventana/MAINTAINERS
@@ -1,6 +1,5 @@
 VENTANA BOARD
 M:	Tom Warren <twarren@nvidia.com>
-M:	Stephen Warren <swarren@nvidia.com>
 S:	Maintained
 F:	board/nvidia/ventana/
 F:	include/configs/ventana.h
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 1177e42df2f5..a29155224eae 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -74,7 +74,7 @@ alias samsung        uboot, prom
 alias snapdragon     uboot, mateusz
 alias socfpga        uboot, marex, dinh, simongoldschmidt, tienfong
 alias sunxi          uboot, jagan, apritzel
-alias tegra          uboot, sjg, Tom Warren <twarren@nvidia.com>, Stephen Warren <swarren@nvidia.com>
+alias tegra          uboot, sjg, Tom Warren <twarren@nvidia.com>
 alias tegra2         tegra
 alias ti             uboot, trini
 alias uniphier       uboot, masahiro
-- 
2.34.1

