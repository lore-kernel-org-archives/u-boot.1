Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B311C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 05:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC0D88323;
	Sat, 27 Apr 2024 07:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Br7L7xZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 424058831F; Sat, 27 Apr 2024 07:41:32 +0200 (CEST)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com
 [95.215.58.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A9FC882D7
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1714196489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4vqEXc/iwAXPTkFJKImD3nwGJNd9p7VfoPoLDvrmh4=;
 b=Br7L7xZuYp5qDdB4bWn0fU7C2trtrQJPebN0UMx6bWSYpRc2aEnx7YwCHwDcjCEa1uMTM3
 dOT4j5L1wiAboVCLtmuuoQnuwt0THFb/Pk4MmmICwdQc0X0Kib6JyM/pxztLeWK58o+92t
 mo80HydqfqDuV4C4gf9vslH+VJV/gT7KmCcvAEtka75RBYA1FracX9ymo7Gpz4AB8MPW9E
 vn/UcAqAmIPflzRt68oywuQ0Oq6xHx7sqgxFDb9hr+Mcd3FXcS/gcvBX45LYp+LZDTFyWW
 v204zPZNx3ArDekZN4hZXsBeL/0bFvFF9rIp9Or7Zfazcyqffiy46/hJ18CIiw==
From: John Watts <contact@jookia.org>
Date: Sat, 27 Apr 2024 15:40:41 +1000
Subject: [PATCH 2/4] spi: mtk_spim: Remove completion.h include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-spikconfig-v1-2-8a54772522f4@jookia.org>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
In-Reply-To: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1714196447; l=548;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=fJzGTs10WruvZ06FuwDTDlWFqCed7gr7ouUKV/zgNPQ=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAyT0v/Vop8JH9qMK77LxBiNV
 8DV1JflY3UtHf5AiittAOqeYK39Rzu81tNpAysZQUc9KmTYE1l+oyZKqxCOsxAgUAAOsX
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

This created a conflict when linking.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/mtk_spim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index 90f4c3cecb..2979487fff 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -18,7 +18,6 @@
 #include <dm/devres.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
-#include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>

-- 
2.44.0

