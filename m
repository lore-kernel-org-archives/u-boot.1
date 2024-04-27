Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7691DC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 05:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79D28830D;
	Sat, 27 Apr 2024 07:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="zFcGNU/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8A687EDC; Sat, 27 Apr 2024 07:41:41 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D69EC88310
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1714196499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5J8uOOfX1f0ZgZ6wwhEyqJsqFc4c0b1suQD/OySuoU=;
 b=zFcGNU/OiyVJnXjvcQTzeQWrHJsNjCcLxeULTJGaX9aopH66k06EIBYG0umIpCSIkpYrO8
 wVPJkt4qvwkKUb5/qA8G80Ax8ia6Pht3+S9QEa5R3ktLY+4kamTW1BvUaFK4qxbWTv9d9c
 KOSDAqvYLELpXMKC19EujqwUUsK/6oxens3scguHxGEm2rzKPTzcjd26Cau4cdFho3D5zp
 ToncVZVmi+BTWp5y2rXCCF/sZRT5u/qlspkULif7xNJcDzDuNf1dl9YZJavxFfnFXHXN8u
 tfoDXLkDukrwFFGAlhXTIi6ziaxna8NW3vD6HgH0KH77ikjpRZbVEA8lYzQEjQ==
From: John Watts <contact@jookia.org>
Date: Sat, 27 Apr 2024 15:40:42 +1000
Subject: [PATCH 3/4] spi: ca_sflash: Add missing dm include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-spikconfig-v1-3-8a54772522f4@jookia.org>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
In-Reply-To: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1714196451; l=544;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=P8WMx9EBLoWmCwgvinqe8d9ySIORStePI4N/esvK6RY=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAVQ/5EzAFKcDiwbz63guK4pK
 3wORVUOmOzzyRZrrFetozbokzu8xK+Zc3FzFnHM1OccHs2DWFEpjaKBx8STDHAQUAAOse
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

This code uses dev_err which is defined in dm/device_compat.h

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/ca_sflash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/ca_sflash.c b/drivers/spi/ca_sflash.c
index 38bddd3861..78e442cac9 100644
--- a/drivers/spi/ca_sflash.c
+++ b/drivers/spi/ca_sflash.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <clk.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <linux/compat.h>

-- 
2.44.0

