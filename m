Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6593DC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 368B680CE9;
	Mon, 21 Sep 2026 12:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTmsbTeVIlRg; Mon, 21 Sep 2026 12:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 885B280D3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789995277;
	b=nfIuonQXaLuBLN41/OQNS9MNzGPW6fmRJ+V/VDwL0lqma81BsNKEcI+lPkfNMOE4UFQz
	 7vIMLdZ8KEzeZgp8xro48dteYit0FqeQWCFsuubnOvNtjqBiGJMJf7haLXzzjER98UtGU
	 kyzgQ94aQhZ7YSX5RqiNOYQ1DP/Un+pBDvDDMDY40TudpMG7UMRR+4ky7rXEH/mWLrLVm
	 4LFfZZYCUG5K+XoNP9+mhgiitu/LcEUWT79WdiK/cxhzjYx+qd3CvnjJ+/c6SXjY0bzrU
	 czlAwnS78wLkGqDy9txuLc5XJ6pLnCJDka3qUIoL0OCKfzGMqY/TZ4fHl7YBDULwXHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789995277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:X-DNSRBL:
	 X-SPAM-SOURCE-CHECK:X-MAIL:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	b=r8A1k+mEbPRmx3MKqGAQrpBK/HrbqIrlkCKbCWsWtDcuhJFRUQ1XAaqqJiK830K6EqsE
	 EQOUGKaoiF0PKWZURQ11fIH5Eq+tG0MEUAn8wy4LI/hTkUAvH9sMUVH+YsRRA8Za3mFau
	 96q1Anw8OEEOCGZXJSotV9DWrGslLzpbQSPLxbWMeEp11R2qXkUSC0eM8JdPmmjmu7aLK
	 bcilnS4d3hA+KhJhlzSyVLgufeWqK2VNLkQ7aXXyEX11Hyd/HvG1rxcJj+czPkm9USk7E
	 WTNUqQsITpLi78OKint/wJ50RACahBkgTeAdKTtUlTQJ/puHXHDQ5V+8RxKQC+bXANA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=siengine.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789995277;
	bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=02ndOB9SlbG5g5q5rGfVPMD+gtQXRJXdX2c1+J6ciV/O6ZBIf18j3E27tqZdBkXGs
	 Bab2ey0S1VU2leOJXBV+KVN0efx4QLfpmDNodWERaD7EeDDfvrma1QVwhUDD9+UHl3
	 3wbSjdh/rgin3BordF+E9RpNalT3JRavKm1JOAfyPS3GoxIN+GnKkPHskzod4fqrRa
	 1bU5ZSFvQuxR8FhMBFizSYzRyZcbA5HQb9Ik2fmIzVxx8S2DFlo1701FNSS6UGyTH0
	 MM+AjEpfca4NCdctOu6zp87X2jhgt0Cx6ytBIm6v4c1OLBhFEgU0SPsBfEA6DA/Oni
	 TQuwyUhbZwQZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 885B280D3E;
	Mon, 21 Sep 2026 12:54:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7603C392
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:36:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BE4E80CE8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lBhp9wTcP92u for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 09:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 99591809C2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=43.240.192.165
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789983379;
 b=fY20fd4ZC4W7h/dUKBvSJo7QXAtscQVTPZygVhebuFbO/H3V/YF/aUriUSBsR+b8VqVS
 LKGu8AbT1o4Yv+o7XMrpKAtvClM1w78yuTxn5GGJen98Gi7JjFwFOopCTsnadBptr2zWe
 vR5SI2sXqBfD8TikQrQY/V3PHv4BvtSpEkEwWxz9PLaTYaVAVzX1hBr2Ndfx6UBGJXo0H
 xscRljFBLr1ign7C/tuD6tPQqG1+4YwxciUlHAD+gYGm0rMbljKa7Qbs5YoYwIHKkBU18
 yhpofFf2QWY9vv6sz80o4TY6sN7pC5m/r9LOjDUCTB4wD8rm6fBPgeP3j/5aLXL/tAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789983379;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-DKIM-Results:
 X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=Fw1zlKhf2LGYX7zvhFf/fOgw9DeL6Qq18B6SO7Y5Tww=;
 b=UtO47SypvUKzcxq0TI5Tn+GKQu+lJMkAPn+f32cPE2IbTVBn5ScLzCVYVxL3OIwyk8YS
 HU45zOe5LLtWAae4nUXSTtWOcSRCtvt6Oy7Wo0PkbUA6PH8Ry4oq8uAwW+Umcwkn12Ksd
 tLWc6ZBa/nTbukPMI8yK59mE5Fag2uqMlq3jHJvHzP90pZKWGoRGN96kOgR7OTbsqLkxg
 HE04nb8TlnY34O0s3kC3L9a2P3oHMpW9kqceJnIHmDa4rVTNcLcDkmQoiKsm7Wf4WwEiX
 126C0nAJBaLL0232x6LqCY3DoH1zYAnUxNrFh2jd6rjounSRKHOIGXcuNLJFcgR4nZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=siengine.com; 
 arc=none smtp.remote-ip=43.240.192.165
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=43.240.192.165;
 helo=mail03.siengine.com; envelope-from=lucas.liu@siengine.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=siengine.com
Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99591809C2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:36:12 +0000 (UTC)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
 by mail03.siengine.com with ESMTPS id 68L9ZqYK049941
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Mon, 21 Sep 2026 17:35:52 +0800 (+08)
 (envelope-from lucas.liu@siengine.com)
Received: from SEEXMB05-2019.siengine.com (SEEXMB05-2019.siengine.com
 [10.8.1.153])
 by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4hpJ3n598Cz1T5c;
 Mon, 21 Sep 2026 17:35:01 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB05-2019.siengine.com (10.8.1.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 17:35:52 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 17:35:52 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <u-boot@lists.u-boot-project.org>
CC: <peng.fan@nxp.com>, <jh80.chung@samsung.com>, <trini@konsulko.com>,
 <tanmay.kathpalia@altera.com>, <eric.chung@riscstar.com>
Subject: [PATCH] mmc: dw_mmc: Add the missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
Date: Mon, 21 Sep 2026 17:46:32 +0800
Message-ID: <20260921094632.19215-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-MAIL: mail03.siengine.com 68L9ZqYK049941
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

