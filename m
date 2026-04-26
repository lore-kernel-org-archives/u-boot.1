Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43F2FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A096C8407E;
	Sun, 26 Apr 2026 14:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pCIWuiqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 498D584099; Sun, 26 Apr 2026 07:47:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B22D84011
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 07:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 743E1403E0;
 Sun, 26 Apr 2026 05:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A467C2BCAF;
 Sun, 26 Apr 2026 05:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777182467;
 bh=zJefbpZJ8y6quXIrJVdDocSMdt+1kd6ogYwZX9/qfZo=;
 h=From:Date:Subject:To:Cc:From;
 b=pCIWuiqWGItrT/6fbgsEE/U3V73shPveREc1zvo5NOGZad8xnEgSw9n2vhphpbSUP
 i5RTBs0DNOrIQzShjlkHFg/F/A7qVK5EdTng7m/bfkylMln1vp8PNg1Ua44xrSfLxi
 IvnjtRQShjpvuhvK11PWHdcqEN2qS5789zeYbwn0kX+1P+uVcpyAGZsxApZLB20tkd
 1Oh0iRPZLbWS+ygFeMdzh6GjLKmQhJKRRxcRImtTilKnD5OJVEcQEJgCtYrGzznQHS
 /kfZLSMfONcQ3sAzoI7v/oHykZTOowmz8YURt9s7x6IPJh3FmDFLRdkZpgXE/+oIOI
 rmnv3wSZ6Zm/w==
From: Eugen Hristev <ehristev@kernel.org>
Date: Sun, 26 Apr 2026 08:47:39 +0300
Subject: [PATCH v2] MAINTAINERS, mailmap: Change email for Eugen Hristev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-maintainers-v2-1-aa9a6d5fa6ea@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPqm7WkC/22NywrCMBBFf6XM2kgS2oiu/A/pok2m7fhIZVKDU
 vLvJnUrw10cuPfMCgGZMMCpWoExUqDZZ9C7CuzU+REFucygpTay1o14dOSXHOQgnOvRDAd0R+k
 gL56MA70326X9cXj1V7RLUZTGRGGZ+bO9i6r0/pujEvlUPShtUZrGnG/IHu/7mUdoU0pfYIm/2
 bkAAAA=
X-Change-ID: 20260425-maintainers-ddbe6f7ed90d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Eugen Hristev <ehristev@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10494; i=ehristev@kernel.org; 
 h=from:subject:message-id;
 bh=zJefbpZJ8y6quXIrJVdDocSMdt+1kd6ogYwZX9/qfZo=; 
 b=owGbwMvMwCXWkjcnuXne3fmMp9WSGDLfLmdkdXZ6LWwqtNzybFIcw7dvN0TOGOwweZDyfeVWl
 ufr6m6qd5SyMIhxMciKKbJUm/yrFe7f4X7S1VIFZg4rE8gQBi5OAZjIkd2MDEtOdYb7lP5kcnu1
 1Hj9tL2XfU4wTo9ffnXldQkPN8bDX7cyMpzkWnx9o3vIYoHyS9tf7bypcfHmq0Lel2sOzs3ue/x
 h/QVWAA==
X-Developer-Key: i=ehristev@kernel.org; a=openpgp;
 fpr=AB184498D27A77B65D7852C81EB31E020EAC2FC8
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

Replace old bouncing emails with ehristev@kernel.org

Signed-off-by: Eugen Hristev <ehristev@kernel.org>
---
Changes in v2:
- changed email in the boards MAINTAINER files
- Link to v1: https://patch.msgid.link/20260425-maintainers-v1-1-114f12ce0656@kernel.org
---
 .mailmap                                   | 5 +++--
 MAINTAINERS                                | 2 +-
 board/atmel/at91sam9m10g45ek/MAINTAINERS   | 2 +-
 board/atmel/at91sam9n12ek/MAINTAINERS      | 2 +-
 board/atmel/at91sam9x5ek/MAINTAINERS       | 2 +-
 board/atmel/sam9x60_curiosity/MAINTAINERS  | 2 +-
 board/atmel/sam9x60ek/MAINTAINERS          | 2 +-
 board/atmel/sama5d27_som1_ek/MAINTAINERS   | 2 +-
 board/atmel/sama5d27_wlsom1_ek/MAINTAINERS | 2 +-
 board/atmel/sama5d2_icp/MAINTAINERS        | 2 +-
 board/atmel/sama5d2_ptc_ek/MAINTAINERS     | 2 +-
 board/atmel/sama5d2_xplained/MAINTAINERS   | 2 +-
 board/atmel/sama5d3_xplained/MAINTAINERS   | 2 +-
 board/atmel/sama5d3xek/MAINTAINERS         | 2 +-
 board/atmel/sama5d4_xplained/MAINTAINERS   | 2 +-
 board/atmel/sama5d4ek/MAINTAINERS          | 2 +-
 board/atmel/sama7g5ek/MAINTAINERS          | 2 +-
 board/radxa/rock5a-rk3588s/MAINTAINERS     | 2 +-
 board/radxa/rock5b-rk3588/MAINTAINERS      | 2 +-
 19 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/.mailmap b/.mailmap
index df143d7f31b4..0c2e96219f83 100644
--- a/.mailmap
+++ b/.mailmap
@@ -43,8 +43,9 @@ Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
 <duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
-Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>
-Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@collabora.com>
+Eugen Hristev <ehristev@kernel.org> <eugen.hristev@microchip.com>
+Eugen Hristev <ehristev@kernel.org> <eugen.hristev@linaro.org>
+Eugen Hristev <ehristev@kernel.org> <eugen.hristev@collabora.com>
 Fabio Estevam <fabio.estevam@nxp.com>
 Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fc5cd553ec3d..1ad65bf2f4c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -475,7 +475,7 @@ F:	configs/eDPU_defconfig
 F:	configs/uDPU_defconfig
 
 ARM MICROCHIP/ATMEL AT91
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-at91.git
 F:	arch/arm/dts/at91*
diff --git a/board/atmel/at91sam9m10g45ek/MAINTAINERS b/board/atmel/at91sam9m10g45ek/MAINTAINERS
index 54632c36d6e8..4a3dcd402ddf 100644
--- a/board/atmel/at91sam9m10g45ek/MAINTAINERS
+++ b/board/atmel/at91sam9m10g45ek/MAINTAINERS
@@ -1,5 +1,5 @@
 AT91SAM9M10G45EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/at91sam9m10g45ek/
 F:	include/configs/at91sam9m10g45ek.h
diff --git a/board/atmel/at91sam9n12ek/MAINTAINERS b/board/atmel/at91sam9n12ek/MAINTAINERS
index 0d33340d87a4..86781af2e7e5 100644
--- a/board/atmel/at91sam9n12ek/MAINTAINERS
+++ b/board/atmel/at91sam9n12ek/MAINTAINERS
@@ -1,5 +1,5 @@
 AT91SAM9N12EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/at91sam9n12ek/
 F:	include/configs/at91sam9n12ek.h
diff --git a/board/atmel/at91sam9x5ek/MAINTAINERS b/board/atmel/at91sam9x5ek/MAINTAINERS
index 51d2237ee6c6..33c102bf7b36 100644
--- a/board/atmel/at91sam9x5ek/MAINTAINERS
+++ b/board/atmel/at91sam9x5ek/MAINTAINERS
@@ -1,5 +1,5 @@
 AT91SAM9X5EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/at91sam9x5ek/
 F:	include/configs/at91sam9x5ek.h
diff --git a/board/atmel/sam9x60_curiosity/MAINTAINERS b/board/atmel/sam9x60_curiosity/MAINTAINERS
index 0d9369e0272d..519aca696de6 100644
--- a/board/atmel/sam9x60_curiosity/MAINTAINERS
+++ b/board/atmel/sam9x60_curiosity/MAINTAINERS
@@ -1,6 +1,6 @@
 SAM9X60 CURIOSITY BOARD
 M:	Durai Manickam KR <durai.manickamkr@microchip.com>
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sam9x60_curiosity/
 F:	include/configs/sam9x60_curiosity.h
diff --git a/board/atmel/sam9x60ek/MAINTAINERS b/board/atmel/sam9x60ek/MAINTAINERS
index d209249c2eff..5e9edd2265f2 100644
--- a/board/atmel/sam9x60ek/MAINTAINERS
+++ b/board/atmel/sam9x60ek/MAINTAINERS
@@ -1,6 +1,6 @@
 SAM9X60EK BOARD
 M:	Sandeep Sheriker M <sandeep.sheriker@microchip.com>
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sam9x60ek/
 F:	include/configs/sam9x60ek.h
diff --git a/board/atmel/sama5d27_som1_ek/MAINTAINERS b/board/atmel/sama5d27_som1_ek/MAINTAINERS
index ba2f31e6c4d6..9f24c578f9e0 100644
--- a/board/atmel/sama5d27_som1_ek/MAINTAINERS
+++ b/board/atmel/sama5d27_som1_ek/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D27 SOM1 EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d27_som1_ek/
 F:	include/configs/sama5d27_som1_ek.h
diff --git a/board/atmel/sama5d27_wlsom1_ek/MAINTAINERS b/board/atmel/sama5d27_wlsom1_ek/MAINTAINERS
index ff68cf01a348..ea3b4b275791 100644
--- a/board/atmel/sama5d27_wlsom1_ek/MAINTAINERS
+++ b/board/atmel/sama5d27_wlsom1_ek/MAINTAINERS
@@ -1,6 +1,6 @@
 SAMA5D27 WLSOM1 EK BOARD
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d27_wlsom1_ek/
 F:	include/configs/sama5d27_wlsom1_ek.h
diff --git a/board/atmel/sama5d2_icp/MAINTAINERS b/board/atmel/sama5d2_icp/MAINTAINERS
index 4a65c65ec3b8..d668aa26260c 100644
--- a/board/atmel/sama5d2_icp/MAINTAINERS
+++ b/board/atmel/sama5d2_icp/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D2 ICP BOARD
-M:     Eugen Hristev <eugen.hristev@microchip.com>
+M:     Eugen Hristev <ehristev@kernel.org>
 S:     Maintained
 F:     board/atmel/sama5d2_icp/
 F:     include/configs/sama5d2_icp.h
diff --git a/board/atmel/sama5d2_ptc_ek/MAINTAINERS b/board/atmel/sama5d2_ptc_ek/MAINTAINERS
index 9f82d9a3d82f..95a57b2a996c 100644
--- a/board/atmel/sama5d2_ptc_ek/MAINTAINERS
+++ b/board/atmel/sama5d2_ptc_ek/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D2 PTC EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 S:	Maintained
 F:	board/atmel/sama5d2_ptc_ek/
diff --git a/board/atmel/sama5d2_xplained/MAINTAINERS b/board/atmel/sama5d2_xplained/MAINTAINERS
index 88e327f81cd8..0c4e74b2dd42 100644
--- a/board/atmel/sama5d2_xplained/MAINTAINERS
+++ b/board/atmel/sama5d2_xplained/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D2 XPLAINED BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d2_xplained/
 F:	include/configs/sama5d2_xplained.h
diff --git a/board/atmel/sama5d3_xplained/MAINTAINERS b/board/atmel/sama5d3_xplained/MAINTAINERS
index 69b4ee8a33b5..4979545dbc96 100644
--- a/board/atmel/sama5d3_xplained/MAINTAINERS
+++ b/board/atmel/sama5d3_xplained/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D3_XPLAINED BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d3_xplained/
 F:	include/configs/sama5d3_xplained.h
diff --git a/board/atmel/sama5d3xek/MAINTAINERS b/board/atmel/sama5d3xek/MAINTAINERS
index e8ec275d71db..a1c96bfea84a 100644
--- a/board/atmel/sama5d3xek/MAINTAINERS
+++ b/board/atmel/sama5d3xek/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D3XEK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d3xek/
 F:	include/configs/sama5d3xek.h
diff --git a/board/atmel/sama5d4_xplained/MAINTAINERS b/board/atmel/sama5d4_xplained/MAINTAINERS
index 9fd0ad7bc2b7..43fc23ef8145 100644
--- a/board/atmel/sama5d4_xplained/MAINTAINERS
+++ b/board/atmel/sama5d4_xplained/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D4 XPLAINED ULTRA BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d4_xplained/
 F:	include/configs/sama5d4_xplained.h
diff --git a/board/atmel/sama5d4ek/MAINTAINERS b/board/atmel/sama5d4ek/MAINTAINERS
index f715af6401b5..757be21b96ac 100644
--- a/board/atmel/sama5d4ek/MAINTAINERS
+++ b/board/atmel/sama5d4ek/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA5D4EK BOARD
-M:	Eugen Hristev <eugen.hristev@microchip.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 S:	Maintained
 F:	board/atmel/sama5d4ek/
 F:	include/configs/sama5d4ek.h
diff --git a/board/atmel/sama7g5ek/MAINTAINERS b/board/atmel/sama7g5ek/MAINTAINERS
index eac972968d70..4d1c6f666c0b 100644
--- a/board/atmel/sama7g5ek/MAINTAINERS
+++ b/board/atmel/sama7g5ek/MAINTAINERS
@@ -1,5 +1,5 @@
 SAMA7G5 EK BOARD
-M:     Eugen Hristev <eugen.hristev@microchip.com>
+M:     Eugen Hristev <ehristev@kernel.org>
 S:     Maintained
 F:     board/atmel/sama7g5ek.c
 F:     include/configs/sama7g5ek.h
diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
index a569efa74e3e..afc9bf5706c9 100644
--- a/board/radxa/rock5a-rk3588s/MAINTAINERS
+++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
@@ -1,5 +1,5 @@
 ROCK5A-RK3588
-M:	Eugen Hristev <eugen.hristev@collabora.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/radxa/rock5a-rk3588s
diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
index c8a43769105e..2910d9bed3d5 100644
--- a/board/radxa/rock5b-rk3588/MAINTAINERS
+++ b/board/radxa/rock5b-rk3588/MAINTAINERS
@@ -1,5 +1,5 @@
 ROCK5B-RK3588
-M:	Eugen Hristev <eugen.hristev@collabora.com>
+M:	Eugen Hristev <ehristev@kernel.org>
 R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/radxa/rock5b-rk3588

---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260425-maintainers-ddbe6f7ed90d

Best regards,
--  
Eugen Hristev <ehristev@kernel.org>

