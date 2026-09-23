Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F284CC98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 05:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F0C580D89;
	Wed, 23 Sep 2026 05:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oq-KfSQs8Ato; Wed, 23 Sep 2026 05:34:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 03C4280D0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790141698;
	b=iNA1OdAQTQuBndUF/iq8I7301jOjEwNUvy6NOoaxdA9+S7VtfmeiJRGHw/WEOlHJsfLM
	 g4Ighnf83+y1oD/1MIe0VNasBTzIPQeInun9Ujr11JEcYabrVOjcN/1PV2K2dwVVR2TIo
	 4bMplIofxxS9ZMD1E3tNXDtIKFInn4rRpLQnWR6AP+koaYJBEVKhaehBmpqA7V9tsSqqM
	 AvV5WenhRkOjIlWqYpTZuwy/5ZMDKrqYwpCRpvYcmKZZXg6uLwQKtiL96jh/U7Sr3C6HF
	 XVLREs6qwwkhd0ULo78lD1D69BdLjKRs3krGhw+x0q+cLMMZkgAAKYW0DgdhKJhSTkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790141698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
	b=kKihM8dQHSE4Kul7W+bSodobNYBwHKr0IQFw33BhlE4eR6rzZzqqbfbSGDDHm1A3Ck8D
	 GUOVJ0JY836b4X/NyDMqpQ8Pvmhi7ERnZoWLjOI/8axOoN8doluAoA8nW0M6rhUz638Tl
	 EHDfu3f3UTdHZ+EGv6DuQT3gfHfJBdFc34ujw/LQ31hG7UusWBag8LOJNDc4utmEcGL4f
	 vcSkwFY27WmklL35S1xaGsYx12QErrv0yRKxRUc/UhilQpMTVGfAKfEO+MtmQiqV4bqG7
	 cth1cqln5ZKJxyenS85rcomWYoqXOiitxNXAZD7wCUl0Dehvs7PyLQZVfoedfuv3RAA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790141698;
	bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=P2aGtbgWFwxyiT1wOOnrUQ1PMA0iRxY1V9pai/uo+gjXu+Dr31nbUM0ZH91dpUS9f
	 TuQa4RA2ipM2jg/RtBA2NdKX2QniOVzwauRBmoS/oNJT40ibIIlaKn/ovD4s4S8je+
	 s8/DjUYUWXocRRC3PqBU2ZGIfAzcweliexYp14LWYPLOrX7LBlOiiTyvC/WgHOynuw
	 rrGoZusanqZTqUWj7qxm5NdUyH4f9qGab7MCSloNXnQkWw85iwwc6vKnCd9O3rsHbU
	 X7RqkSoT5r7M8RWFCDQfm3nXL81+jb9BMIFGsQhLZHep8gBiqjpExZ1rx+OeMJuuwq
	 xHWDM4r+lk1/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03C4280D0F;
	Wed, 23 Sep 2026 05:34:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 836B335A
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 05:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 804E3406EC
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 05:34:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CxrZ4OLnF5-B for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 05:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8FEDC406CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=43.240.192.165
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790141694;
 b=s4cPWPE6VnWgOErtvTUubLGBXvDRljRA6NuIPZoBuNirXi7bxEiMPuDGaC4SWTlDC5Rr
 X+SkbnO/ismRYMci8GTQkDwpO43BUgLnpvHNGttACINrK7qr5Hk1pfbhQ/nwI2wa45ys6
 VZJa+J5GPJ4z9hktCw4NSNS3a1g8TUgqDlDoj+V+rPn3/3QOwymPji1kiIeFLJCK/lLy8
 yY+Bx8gkyAklU+Qc/89Ln48zsuuzZmdGdKw/0eQMChUsM8y67LMKZ3dSidwI+/7EaEXcr
 aBQWUMBx4VO6XWH43SM0kvyxNCOKhwRpZdYK95GF+Qoo00ftkgmqNUaVitCgOyMfERA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790141694;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:
 X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=enCnLN6COmRxLoo4durm2fBHfJmSGCvOTTxbd7qZEuE=;
 b=YeLzofowMf9NqPUTXnZM8zJF6o1zbb1UVECfiqPbDWb22mA6IBKkP3xJRDk3GNKzrPgk
 Vd9w18OBc6nv6kl7yQpj4T/1hnQU38z87T6BtrrLR5MAYBjQIecJq6bk16NiXdkxlmZoz
 5p1bZzbAoZy2Wdyw1ItGOA7i6i6AL4IkOL83HkA6L6fyU2wNfzfhntPIjtbD9n6i0Zmzj
 YksM0MpTMmd75ltpOqN61vQc4Gf5SLUUayuhLVTUnp+Hjm1twI3uxiuvms6xaKdbF1A/D
 0qwoo3ZAynNQpTfFJURFkAuKh9HCUrjkX0RoOGZ9sPbNgxuFgFZmlpMUydXTE6u5JTw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=siengine.com; 
 arc=none smtp.remote-ip=43.240.192.165
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.240.192.165;
 helo=mail03.siengine.com; envelope-from=lucas.liu@siengine.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=siengine.com
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FEDC406CC
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 05:34:46 +0000 (UTC)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
 by mail03.siengine.com with ESMTPS id 68N5YKKE056595
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 23 Sep 2026 13:34:20 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB03-2019.siengine.com (SEEXMB03-2019.siengine.com
 [10.8.1.33])
 by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4hqQc8199Sz41p3q;
 Wed, 23 Sep 2026 13:33:28 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB03-2019.siengine.com (10.8.1.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 13:34:20 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 13:34:19 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <trini@konsulko.com>,
 <tanmay.kathpalia@altera.com>, <eric.chung@riscstar.com>,
 <lucas.liu@siengine.com>
Subject: [PATCH v2] mmc: Add missing MMC_HS400_ES_SUPPORT to mmc_set_card_speed
Date: Wed, 23 Sep 2026 13:45:00 +0800
Message-ID: <20260923054500.43150-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-MAIL: mail03.siengine.com 68N5YKKE056595
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

mmc_select_mode_and_width() already passes true for the hsdowngrade
parameter when the bus mode is HS400-ES. However, mmc_set_card_speed()
only checks MMC_HS400_SUPPORT in that branch, and if (hsdowngrade)
never checks the mode itself. Add MMC_HS400_ES_SUPPORT so the
downgrade path also applies to HS400-ES.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
Changes for v2:
- drop the dw_mmc: prefix; the change is in generic mmc.c
- mention mmc_select_mode_and_width(), which already passes true for
  HS400-ES
- clarify that if (hsdowngrade) does not check the mode

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

