Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46FECCF9F6
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 06:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB94838EE;
	Thu, 30 Oct 2025 07:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="ZXS/SfoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3273983849; Thu, 30 Oct 2025 07:26:10 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61652838EE
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 07:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1761805476;
 bh=VuuGsaRqGLFTL2NzYbXd0buPHdbgQAN19fQV85jzeNk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZXS/SfoTk5ScrO9Xzn/9rliJtpChBRh0m5dzgAwdeRX8jbPxnQA7K5XBowVCt8enQ
 WLJ0xbKqmSEOZ2zDOmmvIld6LkSrJOOdCs1Xltc1+5L7oiHIqL0e4v3KF7yp0rSuHh
 Xm2PDNmj/YovIliLxk8TTDrQGwe10HS/y+fjOygAPJRd47PWdfkh1ym2q8Mc++Rw6O
 47mvaSSoDzCWotYS0V+mm2VZJ4riGFicshoc8kqeKXSd8uBBwu7xfkvFOkX7DUR95j
 +eR3zYL4mWHVGrQPvfuz7QCR0Usj6LkRj/CGjIoVsDSWCtqB+49a3A7wbCTrAT2kWj
 HV01RU5vnYxog==
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 87162B220320;
 Thu, 30 Oct 2025 07:24:34 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	E Shattow <e@freeshell.de>
Subject: [PATCH v1 2/3] ram: starfive: use SZ_8G for 8GB memory size
Date: Wed, 29 Oct 2025 23:23:33 -0700
Message-ID: <20251030062354.35413-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20251030062354.35413-1-e@freeshell.de>
References: <20251030062354.35413-1-e@freeshell.de>
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

Replace numeric literal with SZ_8G consistent with other uses of types
from linux/types.h

Signed-off-by: E Shattow <e@freeshell.de>
---
 drivers/ram/starfive/starfive_ddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ram/starfive/starfive_ddr.c b/drivers/ram/starfive/starfive_ddr.c
index 9e902f03ee9..f030192f6f4 100644
--- a/drivers/ram/starfive/starfive_ddr.c
+++ b/drivers/ram/starfive/starfive_ddr.c
@@ -43,7 +43,7 @@ static int starfive_ddr_setup(struct udevice *dev, struct starfive_ddr_priv *pri
 		size = DDR_SIZE_4G;
 		break;
 
-	case 0x200000000:
+	case SZ_8G:
 		size = DDR_SIZE_8G;
 		break;
 
-- 
2.50.0

