Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CEEC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 05:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D03882D9;
	Sat, 27 Apr 2024 07:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="MOcoL0Ix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C4B882DD; Sat, 27 Apr 2024 07:41:11 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E559F882D7
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1714196468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yBVRj0345YE2M+HBbhk3QXon76mvGRotycYQL3kerdQ=;
 b=MOcoL0IxGBi9BAenc6cxZm68MZhemziaEDyVvfbe5r477QhYuK4xHmELBRujf9rwtaGZVT
 E4c4DoO0MjVkmM+Ys/nHLlMYe9zf9pRDxSFRIRFNAI3XIaYJ37IaM9Qn0BIwusU/LXRJc/
 acWUHPtSnV+It7pezCmeK1wDcvLM+0fv8ImAQNneSIqHIOf830FVHvoSOY1x+OOeBc5WB3
 DfHQ2VWUNgLZRPi0uF/ceX91my6xcuwTHHoTqYzjyKXUzWJe6/3zKEDeOg9Ajk+cwnvVde
 iOMJ9zuHagKl4AH2v0tAHdXQwyTOYytriz11+NJdEtwNFmJS8BDaTuiXqDUn5A==
From: John Watts <contact@jookia.org>
Subject: [PATCH 0/4] spi: Various Kconfig fixes
Date: Sat, 27 Apr 2024 15:40:39 +1000
Message-Id: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANePLGYC/x3MQQqAIBBA0avIrBNUBoSuEi3SRhsCFYUIxLsnL
 d/i/w6NKlODVXSo9HDjnCb0IsBfR4ok+ZwGowwqNFa2wrfPKXCUBrV1zgf0GmEGpVLg959t+xg
 fdkjwZ1wAAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1714196440; l=771;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=sxDxLxxXiFBZEYf3TKLB+mNB648nu1S+Z5WqVoJZsVo=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAMFju+3NGcegh/HaoDaU4K3t
 V48AL6ZNnji9kx2lhr/9nyUlSZw7Flnplibm/TRQRTyL54TIOBgy1MqJwH1+9AgUAAOr6
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

I'm doing some SPI work so I tried to compile all the drivers on my
sunxi board to try and avoid some regressions. This failed, so here are
some fixes for this.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (4):
      spi: Kconfig: Add some required arch depends for drivers
      spi: mtk_spim: Remove completion.h include
      spi: ca_sflash: Add missing dm include
      spi: rockchip_sfc: Select BOUNCE_BUFFER

 drivers/spi/Kconfig     | 17 +++++++++++++++++
 drivers/spi/ca_sflash.c |  1 +
 drivers/spi/mtk_spim.c  |  1 -
 3 files changed, 18 insertions(+), 1 deletion(-)
---
base-commit: 174ac987655c888017c82df1883c0c2ea0dc2495
change-id: 20240427-spikconfig-2417bbcf4c14

Best regards,
-- 
John Watts <contact@jookia.org>

