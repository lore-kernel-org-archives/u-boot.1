Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AF8CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1A5848D8;
	Wed,  6 May 2026 14:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Owh6VR2o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA098484F; Wed,  6 May 2026 14:36:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D66848F5
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0E3643568;
 Wed,  6 May 2026 12:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E9BC2BCB8;
 Wed,  6 May 2026 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070970;
 bh=NF4ioLgIPecSP9IKJC04sirPsPoOo5mF6AgbVlqK7cM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Owh6VR2odobUHXbbOCV5YiA6i6G1JS5izlAqnNOi7nV4CjUL8WmLOlCmgpagr7k/m
 v3pVXaSD59bIovRGOGnS62Ih8Pm5WYI61PAhclUFgkULEqNrZyZWPHsHcVJ/VmDVOe
 ZRo6QA1rS3nIaYejXOEeVJpN15UfOnnQoWtp4l/0/JWmbL02B90jc4xrlZlfvzrp8J
 eqoKNkGa3uT6+t3UastCCxmxrWh9qI33ML2qhWX0fqARKihPiEFU3DAUgToVzfs43U
 Ten1W0YaQzdS6S+ppmL78Y9ISx6ftiJhF2rej7LrsDrEpdjBOtyAHlhZcLR4NqFd+T
 bTIVZO/JqdenA==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 03/11] spi: fsl_espi: fix read transactions
Date: Wed,  6 May 2026 14:34:12 +0200
Message-ID: <20260506123507.2081751-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
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

Since commit 7917c2e35604 ("spi: fsl_espi: fix din offset") MTD is
basically broken because any read transaction will get wrong data. While
the commit in question will fix simple transfers (where both
SPI_XFER_BEGIN and SPI_XFER_END is set), it will break the most common
case, where opcode and address is send first and then data comes as a
second transfer.

This basically reverts commit 7917c2e35604 ("spi: fsl_espi: fix din
offset") and make the fix particular for this simple case. Instead of
providing two buffers for reading and writing, just malloc one which is
used for both. This will work because the data is first written on the
SPI bus and then it will be read (and overwite the written data) into
the same buffer.

Suggested-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Fixes: 7917c2e35604 ("spi: fsl_espi: fix din offset")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/spi/fsl_espi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index 117e36376b7..c5bc603b5c0 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -216,13 +216,13 @@ int espi_xfer(struct fsl_spi_slave *fsl,  uint cs, unsigned int bitlen,
 		break;
 	case SPI_XFER_BEGIN | SPI_XFER_END:
 		len = data_len;
-		buffer = (unsigned char *)malloc(len * 2);
+		buffer = (unsigned char *)malloc(len);
 		if (!buffer) {
 			debug("SF: Failed to malloc memory.\n");
 			return 1;
 		}
 		memcpy(buffer, data_out, len);
-		rx_offset = len;
+		rx_offset = 0;
 		cmd_len = 0;
 		break;
 	}
@@ -275,7 +275,7 @@ int espi_xfer(struct fsl_spi_slave *fsl,  uint cs, unsigned int bitlen,
 			}
 		}
 		if (data_in) {
-			memcpy(data_in, buffer + rx_offset, tran_len);
+			memcpy(data_in, buffer + 2 * cmd_len, tran_len);
 			if (*buffer == 0x0b) {
 				data_in += tran_len;
 				data_len -= tran_len;
-- 
2.47.3

