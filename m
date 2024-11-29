Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8163FD6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D39889400;
	Fri, 29 Nov 2024 13:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nb9BdUDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED78B89023; Fri, 29 Nov 2024 13:28:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FC7893EC
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 13:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=20631dcf42=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATB2oaQ032279;
 Fri, 29 Nov 2024 13:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 eXSserzT2BCTGuekCIpBKpjDqr1Cvv7bwrpmOTy+Nzo=; b=nb9BdUDjdZLREp8D
 45SR2vv6nba+96yBoJAnrmQkZ6af+HwVZ1uqiIB+Bz5XlkhI9zK0tY1e+lKvRbSk
 8GaXIDGdetkmn1ibYMiujaZodaqrSqc4SGHbIUU8i3vK3KuynHSKlCh1Zk7li+NR
 4pBE9ER+JjbxIRBP60yZufAiU9E6nsBdNX2pZDRjm4pGwaMoY/bwu0ttS7gkpSem
 OWpF0ez3NijA95pD/JmitLEYiewMunf137jFbZPPOkJl0ovx1ZFpHmnAsGJ0BEaL
 p4LKBHZMhF1swN/V9yhYXgTJ9flYGskvbV0fcrXSh3Edl8XB0yMTb+djJoeHYYsH
 L7vzZg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 436713sr6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Nov 2024 13:28:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C9C0040047;
 Fri, 29 Nov 2024 13:27:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC28028C109;
 Fri, 29 Nov 2024 13:27:19 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 29 Nov
 2024 13:27:19 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/6] arm: stm32mp: stm32prog: fix warning when
 CONFIG_SYS_64BIT_LBA is enable
Date: Fri, 29 Nov 2024 13:27:07 +0100
Message-ID: <20241129122711.411917-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129122711.411917-1-patrice.chotard@foss.st.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

If CONFIG_SYS_64BIT_LBA flag is enable, following warning is triggered:

../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c: In function 'init_device':
../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:27: warning: format
'%ld' expects argument of type 'long int', but argument 8 has type
'lbaint_t' {aka 'long long unsigned int'} [-Wformat=]
  793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/log.h:157:21: note: in definition of macro 'pr_fmt'
  157 | #define pr_fmt(fmt) fmt
      |                     ^~~
../include/log.h:182:33: note: in expansion of macro 'log'
  182 | #define log_debug(_fmt...)      log(LOG_CATEGORY, LOGL_DEBUG, ##_fmt)
      |                                 ^~~
../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:17: note: in expansion
of macro 'log_debug'
  793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
      |                 ^~~~~~~~~
../arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c:793:42: note: format string
is defined here
  793 |                 log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
      |                                        ~~^
      |                                          |
      |                                          long int
      |                                        %lld

Cast block_dev->lba to u64 and set the length specifier to %lld which
is ok with or without CONFIG_SYS_64BIT_LBA flag.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
index 393f9a1b411..f0e019e8da1 100644
--- a/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
+++ b/arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c
@@ -790,8 +790,8 @@ static int init_device(struct stm32prog_data *data,
 			last_addr = (u64)(block_dev->lba - GPT_HEADER_SZ - 1) *
 				    block_dev->blksz;
 		}
-		log_debug("MMC %d: lba=%ld blksz=%ld\n", dev->dev_id,
-			  block_dev->lba, block_dev->blksz);
+		log_debug("MMC %d: lba=%lld blksz=%ld\n", dev->dev_id,
+			  (u64)block_dev->lba, block_dev->blksz);
 		log_debug(" available address = 0x%llx..0x%llx\n",
 			  first_addr, last_addr);
 		log_debug(" full_update = %d\n", dev->full_update);
-- 
2.25.1

