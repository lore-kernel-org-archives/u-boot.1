Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E08C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DEB89094;
	Fri, 26 Apr 2024 01:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086220;
	bh=QP3TVNfwAPVdsuaOefp7j8M1h7nqsLH+PGLkDHqFibw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWqqrkNrlq7/Pw0UkIEpHVkJ1AuxorW3t5TovEwuGMGRLb+BXcoFaX72ZYKTXHkpb
	 XH+1yOyK/fzVrIcsw5nWTOKs2sWcOH+YD5x63xY6/fkFOKOON0BSFXRNNJn4tsZf/n
	 DoxewzN/o8N4Y/Kj4YU5Es28l1zUQBJ0vPCV91JH70fgqbrKxmXOU9HwvrPSiVbnph
	 sAv2/exqPAzQfBKnSm8elCJ0qApKFUPjnt7KNCVCw2NUFyJK1t+i16QIYL/pjLzqDX
	 iF3VHgCg6NpfxRem42AaHjuB4rGsX4L+iwFJeSPkJqVLU+5kZUFwhoGTXxnHd0vmNC
	 M4QGTBX2nDCbQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7DF678907F;
 Fri, 26 Apr 2024 01:03:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086219;
 bh=QP3TVNfwAPVdsuaOefp7j8M1h7nqsLH+PGLkDHqFibw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fBzJZCkv74dzY0FSS1ZwZUrXef2msvDAy6mDRydz1nB2YS6V4amtOFVR9mzenDjUm
 9YD41aLNvIP73DgdDaAQqKVfQnQXEh0P6MlNrTc50+FfKGcwrc0k+uvadibWiiYH7H
 xJU2FMTty854J2/GWwPOBrTEzXwd81TwXxJN6uux8ter5lWtgMWk7C1U9XVv0g76qP
 sL8iWB0buylb4WyM6Y12WSFnMOEwSVJwyq2+i609bEfPUYzYrE0GfuxAuhlQwExriQ
 bKpjQMERAvDSnWmK9RTf896YbUo+LOozetxbrMwQUU5ot1LQBBScVVdy5DcG8fc4EM
 nCQFgJ3QHpjCw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
Date: Fri, 26 Apr 2024 01:02:08 +0200
Message-ID: <20240425230314.497203-2-marex@denx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425230314.497203-1-marex@denx.de>
References: <20240425230314.497203-1-marex@denx.de>
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

Add SPL variant of SPL_FSL_CAAM_RNG so that the SPL_FSL_CAAM_RNG can
be disabled in SPL if necessary. This may be necessary due to e.g.
size constraints of the SPL.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/crypto/fsl/Kconfig  | 7 +++++++
 drivers/crypto/fsl/Makefile | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 294e1c8a44e..9f58731bb67 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -78,6 +78,13 @@ config FSL_CAAM_RNG
 	  using the prediction resistance flag which means the DRGB is
 	  reseeded from the TRNG every time random data is generated.
 
+config SPL_FSL_CAAM_RNG
+	bool "Enable CAAM Random Number Generator support in SPL"
+	depends on SPL_DM_RNG
+	help
+	  This option is an SPL-variant of the FSL_CAAM_RNG option.
+	  See the help of FSL_CAAM_RNG for details.
+
 endif
 
 config FSL_DCP_RNG
diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
index 7a2543e16cc..4fbce519a0b 100644
--- a/drivers/crypto/fsl/Makefile
+++ b/drivers/crypto/fsl/Makefile
@@ -6,6 +6,6 @@ obj-y += sec.o
 obj-$(CONFIG_FSL_CAAM) += jr.o fsl_hash.o jobdesc.o error.o
 obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) += fsl_blob.o
 obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
-obj-$(CONFIG_FSL_CAAM_RNG) += rng.o
+obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) += rng.o
 obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
 obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
-- 
2.43.0

