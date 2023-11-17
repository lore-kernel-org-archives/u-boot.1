Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25309C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 17:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6616C86F1F;
	Fri, 17 Nov 2023 18:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Idci3TnV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFDB386EEE; Fri, 17 Nov 2023 18:01:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7AFF86F7C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 18:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=968596d76e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AHFxjsP007511; Fri, 17 Nov 2023 18:01:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=mqknBeT
 RL8BHSk0QspU5guqei8NhggzIyvbbShRwJho=; b=Idci3TnVWJ5uZVVndnV/GAY
 +x5GcBJ1Ww+Ww5zZnR3wCmL75ruTvd1xb//eDJjtrBCbi0ITqELgH7uZu2AIWifb
 8tW2X6thu6DeGg1YmS5/EpAzX3gmHrharHAKDHh9Y2TXoAw3hIRX9GNEe+Yku9Rh
 79bz6tVp371Q6j7KFmcNQYtM0NPDvjykar93T0/2JEsWDKcYlT+lckF6KqzsXD1G
 MkTTP43b+wc8GWjD27mC3jLHNaH0eEiwu4a7PnlBwD1vYyugrAewxqro9Q9CpYfw
 N8LIVcsjxGlqJbLZ7nwSl4hm8KKUfH2OLSfZLAfz3WpcekylOtAv9rtfV8BPSkA=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u9ym94q7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Nov 2023 18:01:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 156C510002A;
 Fri, 17 Nov 2023 18:01:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3567257AA6;
 Fri, 17 Nov 2023 18:01:09 +0100 (CET)
Received: from localhost (10.252.0.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 17 Nov
 2023 18:01:09 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/2] board: st: common: Fix board_get_alt_info_mtd()
Date: Fri, 17 Nov 2023 18:01:06 +0100
Message-ID: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.0.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_16,2023-11-17_01,2023-05-22_02
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

Since MTD devices are partioned, we got the following
error when command "dfu 0" is executed:

DFU alt info setting: done
ERROR: Too many arguments for nor0
ERROR: DFU entities configuration failed!
ERROR: (partition table does not match dfu_alt_info?)

Fixes: 31325e1b8b9c ("stm32mp1: dynamically build DFU_ALT_INFO")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 board/st/common/stm32mp_dfu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index a8eb8d5cae2..ded3bf81961 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -73,7 +73,6 @@ static void board_get_alt_info_mmc(struct udevice *dev, char *buf)
 static void board_get_alt_info_mtd(struct mtd_info *mtd, char *buf)
 {
 	struct mtd_info *part;
-	bool first = true;
 	const char *name;
 	int len, partnum = 0;
 
@@ -86,17 +85,13 @@ static void board_get_alt_info_mtd(struct mtd_info *mtd, char *buf)
 			"mtd %s=", name);
 
 	len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
-			"%s raw 0x0 0x%llx ",
+			"%s raw 0x0 0x%llx",
 			name, mtd->size);
 
 	list_for_each_entry(part, &mtd->partitions, node) {
 		partnum++;
-		if (!first)
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, ";");
-		first = false;
-
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
-				"%s_%s part %d",
+				";%s_%s part %d",
 				name, part->name, partnum);
 	}
 }
-- 
2.25.1

