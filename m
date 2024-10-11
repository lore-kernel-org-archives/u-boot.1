Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC56BD0D7BC
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 192ED89374;
	Fri, 11 Oct 2024 17:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bwcqhFDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10D489372; Fri, 11 Oct 2024 17:36:27 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB66B89331
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCC0rI016431;
 Fri, 11 Oct 2024 17:36:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 TVQdj362OKL0WYqKwv4nDwPXkKeHwM7h1lGY9OuQBmw=; b=bwcqhFDgKws2dQa3
 MFtulqra82FIz60B9S8pIoY9Qxl5C7soVah0dcdK//9QWttrPwMYk8SoL1nWY2iv
 5zvc+c/Irv9FjpBGcx7C3Ew11Thj4frw1WAiIYp94Gcszh6ycTwb8bfMleqrovJA
 iHgPyemYL12aEEdD5cXXVX7VqQDIGivOeOtVX4+qUaprprjikA28fECLKV96Afc3
 oZEqx+KykxsHPHjV5eICdvZnhXMNEj/SvQmE3o5QA6SMqbr6AKjYCqTmFjbF2VFk
 9JX3dFNOEiAASQlqKiVV0YZaWXHePK+f8SNZF9wR4u5JYRGkjFGObOskqwVgHKQs
 BacESg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xjkbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:36:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 99F9D4004A;
 Fri, 11 Oct 2024 17:35:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ADAC5289F1D;
 Fri, 11 Oct 2024 17:32:22 +0200 (CEST)
Received: from localhost (10.48.86.243) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 17:32:22 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Etienne CARRIERE <etienne.carriere@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 1/4] stm32mp: compute ram_top based on the optee base address
 only for STM32MP1
Date: Fri, 11 Oct 2024 17:31:48 +0200
Message-ID: <20241011173140.1.I5df2535b9afa16b2649399c208ea0e05cafffce5@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
References: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
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

Reserved memory for OP-TEE is located at end of DDR for STM32MP1 SoC only
(STM32MP13 and STM32MP15) and the OP-TEE reserved memory is located at the
beginning of DDR for STM32MP25 SoC, before CONFIG_TEXT_BASE and
with reserved memory for companion coprocessor. So the ram_top is limited
by OP-TEE reserved memory only for STM32MP1 SoC.

This patch solves an issue for ram_top value on STM32MP25 SoC because the
generic reserved memory management, based on LMB, is no more used before
relocation.

Fixes: 8242f14a3e6f ("stm32mp: compute ram_top based on the optee base address")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/dram_init.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index 198785353f13..58290105d127 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -62,7 +62,6 @@ int dram_init(void)
 
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
-	int ret;
 	phys_size_t size;
 	phys_addr_t reg;
 	u32 optee_start, optee_size;
@@ -75,10 +74,17 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	 * if the effective available memory is bigger
 	 */
 	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
+
+	/* add 8M for U-Boot reserved memory: display, fdt, gd,... */
 	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
 
-	ret = optee_get_reserved_memory(&optee_start, &optee_size);
-	reg = (!ret ? optee_start : gd->ram_top) - size;
+	reg = gd->ram_top - size;
+
+	/* Reserved memory for OP-TEE at END of DDR for STM32MP1 SoC */
+	if (IS_ENABLED(CONFIG_STM32MP13X) || IS_ENABLED(CONFIG_STM32MP15X)) {
+		if (!optee_get_reserved_memory(&optee_start, &optee_size))
+			reg = ALIGN(optee_start - size, MMU_SECTION_SIZE);
+	}
 
 	/* before relocation, mark the U-Boot memory as cacheable by default */
 	if (!(gd->flags & GD_FLG_RELOC))
-- 
2.25.1

