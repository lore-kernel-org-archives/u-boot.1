Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0978CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 05:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3608834A;
	Sat, 27 Apr 2024 07:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="0N/NKsxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FF55882D9; Sat, 27 Apr 2024 07:41:55 +0200 (CEST)
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9246487EDC
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1714196513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1ZFPHSWtbvT0D3Hi7Fc3Av0CZZT7HZ5I8iL6UbCVSg=;
 b=0N/NKsxRZBe4Ol4GBHyPuRCWGNkkXsmChhsith2GTyQ9eCcHJON6A8eVGstWYOWg0w+5kC
 7LQgiwO3inbgysebMCVb/bSJT9iC/0W2WsHemHgGOoUkdMGZqO9ONqlsv/kEWS16QCWAwi
 nGZE112CKF8mXJct6+1U8MFF16r/8Fcem3rW5IRU/l0LKNiFyxcCOMxHhtNqdVe8nE2HDw
 TcteQdupoRZqI4KQ8dFL1MF2C47dTG00/bPAn5AGKN/qnxeDMfkHg38TifBNzGr+pOoDdM
 8EQMx6csezmFpzRVYqpyvbdpXKxcc8/P348+d4k/LH3s+ywy8V8MpV993ytzJw==
From: John Watts <contact@jookia.org>
Date: Sat, 27 Apr 2024 15:40:43 +1000
Subject: [PATCH 4/4] spi: rockchip_sfc: Select BOUNCE_BUFFER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-spikconfig-v1-4-8a54772522f4@jookia.org>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
In-Reply-To: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1714196454; l=585;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=q6E7Zide73bbCLU2Enk7aHFd0dW77QIC7PxeRPSs7oc=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAreakbhq3v4BzYwIrFzlcdbF
 2f+S7VGQyH2A+0pO2/usEJjYNaJpOi5uettng0gJDPsfLevkv+6yu92GvKsP7AQUAAOsh
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This is required for compiling.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 025c81adc9..f1c6a838ae 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -417,6 +417,7 @@ config RENESAS_RPC_SPI
 
 config ROCKCHIP_SFC
 	bool "Rockchip SFC Driver"
+	select BOUNCE_BUFFER
 	help
 	  Enable the Rockchip SFC Driver for SPI NOR flash. This device is
 	  a limited purpose SPI controller for driving NOR flash on certain

-- 
2.44.0

