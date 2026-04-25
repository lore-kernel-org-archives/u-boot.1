Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AE3FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B63184399;
	Sat, 25 Apr 2026 18:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lXiynJBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04E0C840CB; Sat, 25 Apr 2026 18:55:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7097F80077
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 969BA60052;
 Sat, 25 Apr 2026 13:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FC1C2BCB0;
 Sat, 25 Apr 2026 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777123038;
 bh=P2lsIsKkqxthTgxHz58KHYCLqp+cv/zWaHP1JbqK+as=;
 h=From:Date:Subject:To:Cc:From;
 b=lXiynJBpjBlOE4lrDCZZQRq6TWmxk5v3hq5RYcUc0gDDLzo3nviDk/MhQ7VBU3zf6
 y5ybYGmyi1ftAZDoVoLHCB9sFLudLGAwqN03Q2ZbXdK7rtAXBZTwUAlIMC8usypShK
 39aE631WV1XFG6rCK4tVlxfocMpxn1XqnSRC0BsDZNWyueK9tHZue6qiVNcD33PU6W
 c+EXtVxlLCDznpRU+o77y3G7xEzBXSKvdc71WA8+kX3hpxIA+G+/J2YP4uJWOnNs1+
 L9WFZNg71rw7Igu+AV69DeuBSB/gZw+8ubH5XGW+75LDusMDENejT+fXBS+F6+nN7T
 xLaxEPNCi4bjw==
From: Eugen Hristev <ehristev@kernel.org>
Date: Sat, 25 Apr 2026 16:17:12 +0300
Subject: [PATCH] MAINTAINERS, mailmap: Change email for Eugen Hristev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-maintainers-v1-1-114f12ce0656@kernel.org>
X-B4-Tracking: v=1; b=H4sIANe+7GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNT3dzEzLwSIE4tKtZNSUlKNUszT02xNEhRAuooKEpNy6wAmxYdC+E
 XlyZlpSaXgIxQqq0FAP/yYJlvAAAA
X-Change-ID: 20260425-maintainers-ddbe6f7ed90d
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Eugen Hristev <ehristev@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=ehristev@kernel.org;
 h=from:subject:message-id; bh=P2lsIsKkqxthTgxHz58KHYCLqp+cv/zWaHP1JbqK+as=;
 b=owGbwMvMwCXWkjcnuXne3fmMp9WSGDLf7Lsj3BvI/yQl7dmyx8tWb4yxfv/P6r3DzYm7Qv75y
 dhvUMwL6ihlYRDjYpAVU2SpNvlXK9y/w/2kq6UKzBxWJpAhDFycAjARjsMM/11MXk+NYLg0jXHD
 4xcO5nPyHsxXmrRTt3KybEY1j3WE1S1GhvNMXg0/Sif9+peYo9RysmpZinzoK5uGvfdXHGnQOPl
 BmwkA
X-Developer-Key: i=ehristev@kernel.org; a=openpgp;
 fpr=AB184498D27A77B65D7852C81EB31E020EAC2FC8
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:32 +0200
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
 .mailmap    | 5 +++--
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

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

---
base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
change-id: 20260425-maintainers-ddbe6f7ed90d

Best regards,
--  
Eugen Hristev <ehristev@kernel.org>

