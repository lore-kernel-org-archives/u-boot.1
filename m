Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DDEC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 09:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B5D87F56;
	Tue, 20 Feb 2024 10:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="Seqg3BQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA1D87F9C; Tue, 20 Feb 2024 10:01:27 +0100 (CET)
Received: from mail.fris.de (unknown [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF9287D2F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4E7CBFB8C; Tue, 20 Feb 2024 10:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1708419679; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=BJQjQRy3jEltrP4p8/iVKOGrjE0pYpLoSwcjw7C/cSU=;
 b=Seqg3BQIEl4PsMaJCPUKQQq9iucTyHkG5656vnNSbQJ4oSsH0Nz/UlF8382QCgHVJAMHdm
 /NPx76w7kXL/HPI3xpSNzi0d2Wr+WUjzaFQbhxt+Nim3X89LT4HJ1rXUbX/KpL7Vqv5NQH
 wIpftxGDLGM8OdUx/2YkhC19cl+C/3kRmVm0pQIH9jD2FO+d3UKI/bNy8iEzVx6olIpv+G
 ofsTChlGVac2NNwbdVTPBxSzb0LGFmOuIvlTSAA2hM+zchWu3fu57wHrNlqVoBeM/CHXW6
 a6lRkn1e9lPo6yCWzBsFiJBCSWhOlh2BNDV/nG4F18LqHPUzRg9r/yUwundOIw==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] board: imx6dl-sielaff: spl.c: Remove multiline string
Date: Tue, 20 Feb 2024 10:01:00 +0100
Message-ID: <20240220090102.32932-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Remove the malformed multiline string and fix the checkpatch warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 board/sielaff/imx6dl-sielaff/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/sielaff/imx6dl-sielaff/spl.c b/board/sielaff/imx6dl-sielaff/spl.c
index 64a84fd5122..6815952c0fb 100644
--- a/board/sielaff/imx6dl-sielaff/spl.c
+++ b/board/sielaff/imx6dl-sielaff/spl.c
@@ -93,8 +93,8 @@ int board_mmc_init(struct bd_info *bis)
 			usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
 			break;
 		default:
-			printf("Warning: you configured more USDHC controllers \
-				(%d) than supported by the board\n", i + 1);
+			printf("Warning: you configured more USDHC controllers (%d) than supported by the board\n",
+			       i + 1);
 			return -EINVAL;
 		}
 
-- 
2.43.0
