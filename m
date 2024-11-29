Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6F3D6EC04
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329FF893F7;
	Fri, 29 Nov 2024 13:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="s+0Uklyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A96788B64; Fri, 29 Nov 2024 13:29:56 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C495891B0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 13:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=20631dcf42=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATB2pqa015591;
 Fri, 29 Nov 2024 13:29:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iyTzFxJrPnhGUN4Nioc5XPcWD7rPiiLKQFSd3nnpCzA=; b=s+0UklyprIMUM58u
 vFo1rhgJpdJ71lhl6AIf3ED+vqnC0vCooUxfQlxqH7GcoakDIHjQnPZtBqtEvMMc
 r4hHCXW4hCr98NGKoFE1of8atJGmzcvKcAkmGqZGj0OzJ19G/ftXUowEdpeInWVT
 ksJceKDLw4lDmhJEWlKfKjjdrL4/nACxCI5Vy5g6t2U5nIa8iKQ0nac+wPD5cqKg
 AAcK4TYp1+p4gAI+MyTOvVSgGBRKCSXlGcc/Sy7oB04/tWoFa5VhLh7LQUPw7gf5
 XCl26byrhzZy2CNl3VI6lJmJypZ85oHe9K4l58xH93EThCu8aU4Y4keEE10Lfnxs
 NfwcqA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 436719hr9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Nov 2024 13:29:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BE43C40044;
 Fri, 29 Nov 2024 13:28:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F6FE28C10A;
 Fri, 29 Nov 2024 13:28:23 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 29 Nov
 2024 13:28:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 6/6] configs: stm32mp25: enable CONFIG_SYS_64BIT_LBA
Date: Fri, 29 Nov 2024 13:27:11 +0100
Message-ID: <20241129122711.411917-7-patrice.chotard@foss.st.com>
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

In arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c, in init_device(),
in case of RAW_IMAGE, part->size = block_dev->lba * block_dev->blksz.

  _ part->size is declared as u64.
  _ block_dev->lba is declared as lbaint_t which is uint64_t
    if CONFIG_SYS_64BIT_LBA is enable, otherwise ulong.
  _ block_dev->blksz is declared as unsigned long.

For example, in case block_dev->lba = 0x1dacc00, block_dev->blksz = 0x200
then part->size 0x5980000 which is incorrect as both are declared as ulong.

To fix this overflow issue, enable CONFIG_SYS_64BIT_LBA, block_dev->lba is
then declared as uint64_t and part->size get the correct value 0x3b5980000.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp25_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index d3f0c088157..073172c3804 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_NO_NET=y
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
-- 
2.25.1

