Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA21C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBFA040A1C;
	Thu, 10 Sep 2026 06:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JP0ujTnhnLk4; Thu, 10 Sep 2026 06:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C12EE408E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023459;
	b=Xqe6OhUGzbY7MODJdcqENbs/RmGAWH0bXm6FOLi7wbUleI74vmdXen2nSr70xAyyLVvt
	 rgPS/NBgwjd/EbMIiQRhi2Hx2fM4ukiSBamGEDcIwmDLmg1+EijFNrxfbdvlN9wLyZcbJ
	 yL8o6mJtZMbbCjZowvoyRGrO64wPC2Lmro9N3JDiof69pPz15uJFeDhT6Gx4n05NFm8xi
	 74djr8ppVMgFcP48DoIq7rWPrHdfoJIfhvGhij0VstQWrlfvzehbG6hc6coAtsCSYeTHc
	 EisoWoCYDP64O5zLtBgx4WSD+0wXbAfAsxWijSn5Z72XYxOIboMN6LMKyFYS14iERiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A7pULn+N/qSva4Kmn+uWKD/VP5Gn/UpPo/cNN/W5Dd0=;
	b=NSNP58bLB3rYwwUofRVBaOW8p0+8GlkVm82Z2cFyndEU+eaxsP+lRwdTOzcBINnEeUvm
	 atPjlc/xSEMaXVk+Pj3Me2S1glraBEyY7HPkzJ9exmvnSXWFahUTSrPD4wdXiEB2bCGgC
	 bCjDMvQGy2r8fMYiwT9DTBOlFwCu41ETO6NkrgejkoK/Vxef3TzOXVBSY49B/lxUFM24d
	 SFly72enPdianJxlZQk2HhkRt1t/aQV5skRowhAkbXEs5RaoYvuoyxRfrXTKxdpT0yTHl
	 9yxH3QjZclcTt12SObQqzcqCdru+KogtZNnJtLlsi17XO8dySzSRzy8v8XAadnwzsWA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023459;
	bh=A7pULn+N/qSva4Kmn+uWKD/VP5Gn/UpPo/cNN/W5Dd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLk2rG/rRKvCBkQ+g4IOgNe1pXxEBIGKxM+//2FqriXYxBPlCtHb0CiIWob93aNq7
	 ee7dNwmhlFdOivnTn23VqppkondRgKxI9rnXych7fyUkX9XmGs8IJW12sEIUApeojK
	 42uN01RR7I3lttIhq1EHKygGvHFuTXsUBTawHQnhc/lSJ8PVV11wpUNHjVR1VsnMMS
	 +Tn8kEG/9ynwdJLFKPFY01g28Brvg8jvxG5dQLBhM1PXD9YYWL+WWRhDSjxS74G6Ta
	 TqiU0L4m2yA0QxtYPxWZdxKfiuYdxQopPSBCUHxxB4iGja2nsZqs38jw42chhGAWCn
	 iMdk3FzU/DZlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C12EE408E9;
	Thu, 10 Sep 2026 06:57:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 31EC21F07
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14FF180F00
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UnGKFKSdFAsi for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 85C5380F11
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023449;
 b=J7AD1RuQbAzjQ4BBzF4LhpfUl4u5fcfFxhSBTMbiGetp0AaBMhpV4u7Ex8o4isfCSfp0
 MTRFE/ZSrU6xzfLDKEDWFNRQqrZK0PDcxGRmn4Dse8Z91pVEr13iHAJsX8beQUEmmidAg
 vvz4FHeemoWoIKKevdcqWTKeBhbyRS9IU8m60ZpNp7cn699VjWXHXoxbHAXqG1c/5qTJU
 aQGV8Z+1JA7DOvRIgEOAYkinCfzQDBkzDV0+IYBKTP1BaLBtD7K1JoyXe5h7QvU5lihAN
 rbu088nkOzwokNRV2ZPP22vmqeLVDEm91xDetWEdTa6gG46em2xseUJGwEJOd7RX1fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023449;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=A7pULn+N/qSva4Kmn+uWKD/VP5Gn/UpPo/cNN/W5Dd0=;
 b=jnDtRGpcDkJlIOaHEm0pZye39+IZTr/JaDtkXbTecsTaVaai6zpnQLGuWZPaMTDWHm8o
 rImqkgJDFNvrEK9ikgcYyYfFwS6U7ToPxe5iEsNoT1NMeoBmn8EmLi04V2H8P1aZMEvjZ
 B1o4opdAiSR/8eCpQpKEaBgAqVIjNVFxiCc/TdWcszAVkP8YrZek6KcBYC2SgNazJyxrA
 Ox0HRLOIm6B5/svQtjBBAwebtrpkDx70IOSckC3ZDAuOMIEsr7Qv60R+TvitAD7El4cMu
 DVQ1QMH+5DCwTRjsWz1K1MDWYFejlw6gZT5ECR36Pp6vzBxdLbSsQHOGm+MWVwzz0/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=tcaslj9N; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:29 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=tcaslj9N
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-202609100656247c8fea99dc00020724-xzco3a@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85C5380F11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202609100656247c8fea99dc00020724
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=A7pULn+N/qSva4Kmn+uWKD/VP5Gn/UpPo/cNN/W5Dd0=;
 b=tcaslj9NiYHyu4CRfbniiatt2HGdDFkoROD2MD2cCSPVjhwpbVbTy9IydZ4ycMEMOYfAN9
 i/JRhwTYHXthofhBtOHasAHeSNbiimpuLoUNlJ8Kj6HIpkqGkCSQh/VmE8AnPrqU0KkoYcJU
 60HDz2g9EDrPeTRoCIrSw1iF0Uhokejg+rcPsJJnBLutgyj3sewXxGPT3orKSV10pXGinGIi
 xI8+y4xdzz6YE0kyOWog799Xr5Qt8kqax8GYV+e0ZY88YoGXJBG8gQCx5McL9Q5/+iYdJ0ys
 2/yQmb742KLZD+d3oheWcP2oko43pB1TREAPYO1jbHs7ho5jKf+koFAQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 6/6] mmc: Make "MMC Device not found" a debug output
Date: Thu, 10 Sep 2026 08:56:21 +0200
Message-ID: <cabbf5bb428068d97cbc76c4739dac2392413eca.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1789023381.git.jan.kiszka@siemens.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Callers of find_mmc_device are generally processing and informing about
errors already, e.g.

=> mmc dev 2
MMC Device 2 not found
no mmc device at slot 2

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

---
CC: Peng Fan <peng.fan@nxp.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/mmc-uclass.c | 2 +-
 drivers/mmc/mmc_legacy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index 698530088fe..cd930807802 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
 
 	if (ret) {
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-		printf("MMC Device %d not found\n", dev_num);
+		debug("MMC Device %d not found\n", dev_num);
 #endif
 		return NULL;
 	}
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be71..2a4a8a83fb3 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
 	}
 
 #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
-	printf("MMC Device %d not found\n", dev_num);
+	debug("MMC Device %d not found\n", dev_num);
 #endif
 
 	return NULL;
-- 
2.47.3

