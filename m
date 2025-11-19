Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644B6CF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B65983E57;
	Wed, 19 Nov 2025 10:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CODc1eyJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9049683E1B; Wed, 19 Nov 2025 06:14:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0036983E0E
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BFAC44195;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA6EEC113D0;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=/kZVXWJpt8D9N3+8vmeX4fvDIrO0+K7OK+MsmAV5fMc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=CODc1eyJix0Ee/U7S2/B7UkNKCKx9958P81PKuxKPe+Dbfuh0/V9ET/AIxGkE9V7F
 DnIvD6ejkNyHc8Da3d+VmGxgXCzfEw1oouv6JGwDUUC+i4Lfqu3mXSOg1gGI6QUy7T
 R95PQdOXYjOFW7AcG/GijOlLX6ZuZKtZPNsQWoT4L/tDMUIR+lRBn370tUi+nF8ok4
 9PvcGOBDg8Sh7d1hBbWMOjDBCi5ksY/RrUunioQTywbLUxs1ayAP0o605MjgxGJHWZ
 kaJ0jvTi3PCvGkL4uqF3hXTkYnGQxFiXZ9lq44KIZcJs+gifDRy3YftVpSJGY9TKVx
 daZxkfwxzGnog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92ECF2583;
 Wed, 19 Nov 2025 05:14:15 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:01 +0900
Subject: [PATCH 02/11] spi: zynqmp_gqspi: Remove reference to
 SPI_XFER_LOWER flag.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-2-c555bd85e6e4@infineon.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=1582;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=VNUuewgVolvHFP3F2HRpZhcnlgOZR8fV/mUTRvu645U=;
 b=FFfXTMgppHDZdzBcotbasNSqvAK4XA9HP2omVqXVYpnO47BqHiTdHGnXvclMHyxosFOzEKxQY
 aBJaTFPvHztDHhzPQACP2yGUSBMnfe2iEANhEe21J4PEC1rpYv+F06F
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SPI_XFER_LOWER is set in spi-nor-core for reading ID, SFDP and BAR.
The flag is referenced by AMD controllers only. Controller drivers can
intercept the opcode and change its settings accordingly.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/spi/zynqmp_gqspi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 4a25ee0c459..143b957516b 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -823,6 +823,23 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
 	return 0;
 }
 
+static bool zynqmp_qspi_is_lower_only(const struct spi_mem_op *op)
+{
+	/*
+	 * This is a list of opcodes for which we must read only from lower chip
+	 * in dual parallel mode.
+	 */
+	switch (op->cmd.opcode) {
+	case SPINOR_OP_RDID:
+	case SPINOR_OP_RDSFDP:
+	case SPINOR_OP_BRRD:
+	case SPINOR_OP_RDEAR:
+		return true;
+	}
+
+	return false;
+}
+
 static bool zynqmp_qspi_update_stripe(const struct spi_mem_op *op)
 {
 	/*
@@ -870,7 +887,7 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	priv->bus = 0;
 
 	if (priv->is_parallel) {
-		if (slave->flags & SPI_XFER_LOWER)
+		if (zynqmp_qspi_is_lower_only(op))
 			priv->bus = 1;
 		if (zynqmp_qspi_update_stripe(op))
 			priv->stripe = 1;
@@ -889,8 +906,6 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
-	slave->flags &= ~SPI_XFER_LOWER;
-
 	return ret;
 }
 

-- 
2.34.1


