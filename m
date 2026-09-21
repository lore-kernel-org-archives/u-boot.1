Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F6C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A6BF80D66;
	Mon, 21 Sep 2026 12:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CVcUbQ29TGxp; Mon, 21 Sep 2026 12:54:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C417580D60
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995273;
	b=Gjg3wdW+i4jqj/59NYSixP080MIb7sayeWNVDedxoCxW2r/oZkgT46SjMgxMa88kcB74
	 cxAHZ8y5obHwNONofChG7u5QCqofokClS/phbr7PGAKepvd8UaAXeDstQXdqJ29jFkRb5
	 rxWcs8r2D047ChCUsy/jxLxQMi10cMx/Z2cYCbtz7tf5EGoebxUW9l3xn64BNo51Vh1Pq
	 U5OxlJ2ske4fMQ4mxU8QTOZmV6ihIjk//qL4cJbip7UP5OKrT5wtW2FQ/pud0diopEVj5
	 a2pXVHQsrUkFKsouvT4qn4yJ0HiiTF57+Rwv38DuPUDqUR0b8nHXiUJo86D0+EFzYyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	b=Or0FAHQnx3U+tsLmWLbwzbdwjrLMo5n6dReDn43lrNl1Z4zns/m3w1bVJJkp2whUeJ90
	 ConV0x8HEVmWN3TgL5THsvvvdc/SniCEVB9eGS6daqsL7d7gRWf/oVL//esxZrsWdDoqY
	 b2/4oktuZ2vxbvfdKX7d+K7/ggc3roJZTBJE7/VGEuGFJDMZgpAHvzFjOwsYK3/MH4ZgY
	 9Erm/k9065RJgwKx+Y4bLaaIpU1UgpAZHKHtgxE11S5aQusimADPQJNca1jeTeyu91Qhs
	 iMQ00ZARhhzgwV5elbv3YswpuwoZEpWo+qNTR3fa4umVJqmYBe032RLhaGONB7uxOqQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995272;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RloOWquRSCTgkJQLp6RS+ybv5+q/hKMZyCOPKwAuhmdxBVXl3U8Ca+uUx+bET94hN
	 IXCkhA4UnR7Z2RTRaeE3/NH+zPR8IQGwgDOxlPLkb5jpevWv/vp5O4pyuKwXgvO0Ch
	 5ZcC0yJ22iy5dpCrZ5Iq5lFYY9lm6+BLQmvZcQRXXT0KUWDI+Sp5mBxTSBF7b0D7No
	 ozk70z0qUmqSWL5F0ELNumPGlxjDXdjLaFMjCbkmx8tFkcZXijdEZX2YTJQyXowL1X
	 InFv+O4hfU64R2QtmEK2deLLRQPOWxnZHYYWqsHr6h4OTNpQPmopim9YlH041BH83s
	 XCmMmJkPHVeOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C417580D60;
	Mon, 21 Sep 2026 12:54:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4311528C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28F2240073
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:12:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcrAFtIuWhOS for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 08:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 85E7D40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=43.240.192.165
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789978346;
 b=sg9hW4x0QU90j6DB1aNh92lckrwNASxgifBCmMiEzcfVNEcRTCYwwO1LTC3Z5VDhtDcI
 f2N1zfEqALHtu7RF/3g20WvcFXF6TtIGOqCufx2ZaCHbPTWshT3YvgftoZBcNl/L0msir
 VHygY6qQYDaTPmXQYrmj3/h125TUk+KZiD9mUxCXRs4Vi8he1E06HIyOyn8XDKGGlyvFQ
 rb7twEog0WuZTSmMBK//8HjO/sZsUEWI20OufJY9n/aLeZaQYcvaUvNRsSN8unMNJ0IiV
 GbgjkRQx3xo/xRFREHGSFJ1JC/6W0ia7XL6BHWFx9gq471hGf5MiBu8Qu6vbjagsBwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789978346;
 h=X-Greylist:Received-SPF:Received:Received:Received:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
 b=NekHkg6JkXuhK4Hehc9wwDkCoWJMx1yb8gyGXBoU16s9RmEOTOiDX7nLYMXq8M7IB/QS
 34I891h32dVxIgXJspwih6ecQZtt9WLIBfPKC93rs86tTVsgi1Yhp8N7XZo6rar2BV8ti
 fiDZr0l/cjv/09hNOw6qQlggh3TxS0qbKfm0kp+m2sKk+aBypd+yV3E5HcORLzx8xsdbZ
 6vlz34x+OEnrto5R6rICZnmuQlprPmhWAxWIbVKZUC3ZHbrAwQwDY4J2w73kpd7C/C7y3
 76MD2cOZxv1cJPyH3bvV+qevJQzJq6m8lG/3x95d2+S5P3ads/FSc+PUwzd1RKnhzYQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=siengine.com; 
 arc=none smtp.remote-ip=43.240.192.165
X-Greylist: delayed 910 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 21 Sep 2026 08:12:23 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=siengine.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.240.192.165;
 helo=mail03.siengine.com; envelope-from=lucas.liu@siengine.com;
 receiver=<UNKNOWN> 
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85E7D40050
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 08:12:22 +0000 (UTC)
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
 by mail03.siengine.com with ESMTP id 68L7vSkj032899
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:57:28 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
 by mail03.siengine.com with ESMTPS id 68L7uhcG032791
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 21 Sep 2026 15:56:43 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com
 [10.8.1.33])
 by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4hpFsN6lbqz58pt;
 Mon, 21 Sep 2026 15:55:52 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 15:56:43 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:56:43 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <trini@konsulko.com>,
 <tanmay.kathpalia@altera.com>, <eric.chung@riscstar.com>
Subject: [PATCH] mmc: dw_mmc: Add the missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
Date: Mon, 21 Sep 2026 16:07:23 +0800
Message-ID: <20260921080723.43779-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-MAIL: mail03.siengine.com 68L7vSkj032899
X-Mailman-Approved-At: Mon, 21 Sep 2026 12:54:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

In the mmc_select_hs400es function, mmc_set_card_speed(mmc, MMC_HS,
true) is executed.
The third parameter is set to true, but the judgment branch for the
hsdowngrade parameter does not include MMC_HS400_ES_SUPPORT.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
 drivers/mmc/mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2bc36c1405c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1007,7 +1007,8 @@ static int mmc_set_card_speed(struct mmc *mmc, enum bus_mode mode,
 		return err;
 
 #if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
+	CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) || \
+	CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
 	/*
 	 * In case the eMMC is in HS200/HS400 mode and we are downgrading
 	 * to HS mode, the card clock are still running much faster than
-- 
2.34.1

