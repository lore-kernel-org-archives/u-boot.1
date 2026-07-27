Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B785C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA8554069F;
	Mon, 27 Jul 2026 09:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j6RX4YZTHn7P; Mon, 27 Jul 2026 09:09:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96A9640694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143380;
	bh=NMjdcBxzj1F4r5YmxA43emDB7SryaFf979J3DzuZHh8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RHK/tskgxmum6TM1p4F7bP4XU1MZWjLBrHY0OHHdGkBHrpohAjN+exUwQYx69ixLt
	 0k6Em6gfzQRj3rpwo0xhyEDa4zuRCkRbqeTBy3ji6ovXy4FPMLUjiZF9spWBOW8sZk
	 6TS3q8454OFFh7b0YavZ9mU/pk8G45Td11udKRsVSEvPM2UZuffJskSUf/5K9WCTRs
	 wid/yaeGwNPcSHZteyNqI/QD/Rl06df6mtuGUGEOh4uMty1EGwPqqor/il0hIqRQZN
	 lYEOgmu0cdcDLdM5q4Pwo8KUFcM1XvSd4YTNcwQZ2ZGBhqT4ZXHZn6ePYch8Dq3eMg
	 uiuKjItp7uMBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96A9640694;
	Mon, 27 Jul 2026 09:09:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4202E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF22D4009A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vIo4FRCbjI1b for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:09:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D24BC4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D24BC4008E
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D24BC4008E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135185; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W0qGfKmeae+/G6F5Gf/emod0tKk76hxwaeiVUjqbNgyvMz/FY5Xa9AmjTejEZ4XIygMt+KVQqiw3ggogRyoBE1xlosB0+avNAHySGMIobe2ff8dqXzAZcQjBNdxU5zm17xdCr0p9ago8igpZf3i8MpOCM4eAE9uegHjQXGHDHTw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135185;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NMjdcBxzj1F4r5YmxA43emDB7SryaFf979J3DzuZHh8=; 
 b=OXoq7IMRfcXZxELNZj2AXLiMqCxrsdZXmQKyWC4tHOfgxMBmnVcMfJrfOaol8Na4zGAcsY3tJ7utydv0G++zSc2/sCUgNzEuLI/dhPm2puE6le5grMirvsTt9EG9JC/DaRTvw6VRQBrPS5ZTsExrx7BKpgopCgnRZWqKSpKP7tM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135182692462.8134556142671;
 Sun, 26 Jul 2026 23:53:02 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:11 +0800
Subject: [PATCH RESEND v2 2/7] mmc: cv1800b: Add SG2002 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-2-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122788f2f70d52191f6a6856156400003adefdb2a5bc01fd0e3fe5e79069f2c0a55f349387b2e638b7:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135185; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=NMjdcBxzj1F4r5YmxA43emDB7SryaFf979J3DzuZHh8=;
 b=QamfVBpiLHnfQL1zxyCwhJ/zCg1faHygci9W/dJ8AT+gzozXXp0zcVstImd0aZvB
 4GdlbTfxFMcXUCqyInH3sYLUI8KtbywqNlfCeA2gwM1b108QB+7CjXtDt+2iZQrbBx9
 ctgAuGxYU0Yy1KQIsj59ahQH5RK991bU+lHT7o7s=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=QamfVBpi
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The upstream SG2002 devicetree uses "sophgo,sg2002-dwcmshc"
for the SDHCI controller.

Add the compatible to the existing CV1800B SDHCI driver.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/mmc/cv1800b_sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f..f8d94232170 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -110,6 +110,7 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 
 static const struct udevice_id cv1800b_sdhci_match[] = {
 	{ .compatible = "sophgo,cv1800b-dwcmshc" },
+	{ .compatible = "sophgo,sg2002-dwcmshc" },
 	{ }
 };
 

-- 
2.55.0

