Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED32AC87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546E882BCD;
	Wed, 30 Jul 2025 14:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QHhJ45sG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E76982F00; Wed, 30 Jul 2025 14:54:59 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A1081D6A
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0306251bd0=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCCUAC017878;
 Wed, 30 Jul 2025 14:54:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=kCXCNc95KaGljLg+wkAMMg
 zgJy8lIS6GiLyrlOxDAgk=; b=QHhJ45sG7+78bLypFHXx6We29xCftkepX8jp4m
 MbChxkvO0+3ARlsVKN/AtUZ4B83s1TLoEL3tcY868FX9lW9LzUop1X+8Jm14a0NG
 EfwCg/t40Xmgg9DAEtfAG7bnFA/xu1i884On6iZXjxstr7eHm16hBud7YxQIJIOO
 C/Zqo1Z31yM6TuH+F08BNmAbcnF2tdGJhEVr43M+DQlZbU04J/AHNLnNsPyAseSD
 qPkeLFPMV28ZwYd3+s9yUH8AYFbWDxlxmAC1CErqyDomj6Il5u7bbmdklzf9nkD2
 R+nK062zxqQxJP+iEDxKFak66EgltPwAJBcDFZZOlDVA22vA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484nwgsftc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Jul 2025 14:54:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3DAF140044;
 Wed, 30 Jul 2025 14:54:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16791768F38;
 Wed, 30 Jul 2025 14:53:47 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:53:46 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH] reset: stm32: Fix set_clr field
Date: Wed, 30 Jul 2025 14:53:44 +0200
Message-ID: <20250730125345.27273-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
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

STM32F4/F7 and H7 series doesn't have a clear reset register, so
set_clr field must be set to false.

Fixes: 0994a627c278 ("reset: stm32mp25: add stm32mp25 reset driver")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 drivers/reset/stm32/stm32-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/stm32/stm32-reset.c b/drivers/reset/stm32/stm32-reset.c
index 918e81e588f..024f15cb25e 100644
--- a/drivers/reset/stm32/stm32-reset.c
+++ b/drivers/reset/stm32/stm32-reset.c
@@ -19,7 +19,7 @@ static const struct stm32_reset_cfg *stm32_get_reset_line(struct reset_ctl *rese
 
 	ptr_line->offset = bank;
 	ptr_line->bit_idx = offset;
-	ptr_line->set_clr = true;
+	ptr_line->set_clr = false;
 
 	return ptr_line;
 }
-- 
2.25.1

base-commit: 05bacd747c8eef2dd6b8081bc917dedd6c983b72
branch: fix_reset_stm32
