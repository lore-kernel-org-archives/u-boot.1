Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31231E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 10:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D169805EA;
	Thu,  9 Jan 2025 11:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="avs0QU9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD28B80601; Thu,  9 Jan 2025 11:20:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B412A8036B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 11:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3104a8932e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5096CD0A026474;
 Thu, 9 Jan 2025 11:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nPvQ2HJEev8A8W2Vlt4kOE7MqJYgx3Zamu7ClCBmRIo=; b=avs0QU9YbWDmiJ9+
 HMGtz3yAkJqJRR0h27FOPBnj7VJbaNF/DkyW6oT5AR43s5hFbK/NwdhS1G1SqZdf
 PpnzFaedY86XW46vSOdcQuIMvAM/RItaUqA+XVgUcUnpoWWghPv8260XaxQbKw9J
 fcPuAv3/owuiFLyljkOpY6S0jqbFOMMKDUvezIjjKtnMs7QRmfbF0YgFkh11saAI
 4v2yUcHxd5mkkBzMun7eQ9hkiYJIUeN8ZpNAWs7BdyWfD8SXvXFYz8s6GCfjbJXQ
 QeXKf1nv3Fji0UGsWzcTtKN8+0i4JiGKIWiDXezRc0CORuGBsKgD8zF/8VfadKQa
 gq0j8Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4428yvs5aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 11:20:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46D0E4004A;
 Thu,  9 Jan 2025 11:19:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97341229BD2;
 Thu,  9 Jan 2025 11:18:41 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 9 Jan
 2025 11:18:41 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] stm32mp: Fix board_get_usable_ram_top()
Date: Thu, 9 Jan 2025 11:18:37 +0100
Message-ID: <20250109101838.1733468-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
References: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
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

mmu_set_region_dcache_behaviour() parameters must be aligned
which is not always the case.
For example for STM32MP2, we stayed stuck inside
mmu_set_region_dcache_behaviour() in an infinite loop because
set_one_region() always return 0 due to start parameter which is
not aligned.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/dram_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index b06105768b3..34b958d7afd 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -81,7 +81,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	/* add 8M for U-Boot reserved memory: display, fdt, gd,... */
 	size = ALIGN(SZ_8M + CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
 
-	reg = gd->ram_top - size;
+	reg = ALIGN(gd->ram_top - size, MMU_SECTION_SIZE);
 
 	/* Reserved memory for OP-TEE at END of DDR for STM32MP1 SoC */
 	if (IS_ENABLED(CONFIG_STM32MP13X) || IS_ENABLED(CONFIG_STM32MP15X)) {
-- 
2.25.1

