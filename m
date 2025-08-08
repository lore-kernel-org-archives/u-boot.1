Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C43EC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 14:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042A183D92;
	Fri,  8 Aug 2025 16:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ifz6x166";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEFC483D9C; Fri,  8 Aug 2025 16:05:06 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD34783D90
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 16:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03156c240e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578E3KQF030517;
 Fri, 8 Aug 2025 16:05:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 EEM849Yo2Mqsjq3SrGzdgzi87FOW3pyOdFanCsMeS7c=; b=Ifz6x166IueflBAL
 PxwE7cZyBzjJIImtdnzwhfIAy2Rz8SVREUMLUwWjI6Uw+nc+dbTFjNiY4kj8K5Yz
 07JQdhWKA4AXnlR+9iUlAkdP2bS9c6rd/IPp6Szo8WWnYQBOuYTErnKCUsy3aspA
 tbDoNx0aRhs6+fVBoKl1xO30jAiFk4s7pet0f3Lr3TogEYUNobjPVPKSggA1uoj3
 54GZKAINIvlpjpv0smLY0hq3YwYuaNK8w6WoqWs0nmzp4tw97L4p/7CDRividXMg
 qwsanRjMhagWoW7/cw9tcerjNVSGlKy2QXMpV92+k6QH9Sjn/AN8l7YBqoC7tmE4
 erWViA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48bpx0chg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 16:05:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5C5AC40046;
 Fri,  8 Aug 2025 16:04:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 865317269F6;
 Fri,  8 Aug 2025 16:04:05 +0200 (CEST)
Received: from localhost (10.252.12.105) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 16:04:05 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: stm32mp: fix RIFSC semaphores acquisition
Date: Fri, 8 Aug 2025 16:03:56 +0200
Message-ID: <20250808140358.53164-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808140358.53164-1-patrice.chotard@foss.st.com>
References: <20250808140358.53164-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.105]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
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

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

Fix RIFSC semaphores acquisition by not returning an error when the
current CID already possess the semaphore. Also fix an incorrect mask
for the CID value in the SEMCR register.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
index 50dececf77b..136ed68bba1 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
@@ -73,7 +73,8 @@ static int stm32_rif_acquire_semaphore(void *base, u32 id)
 	void *addr = base + RIFSC_RISC_PER0_SEMCR(id);
 
 	/* Check that the semaphore is available */
-	if (!stm32_rif_is_semaphore_available(base, id))
+	if (!stm32_rif_is_semaphore_available(base, id) &&
+	    FIELD_GET(RIFSC_RISC_SCID_MASK, (readl(addr)) != RIF_CID1))
 		return -EACCES;
 
 	setbits_le32(addr, SEMCR_MUTEX);
@@ -171,7 +172,7 @@ static int rifsc_check_access(void *base, u32 id)
 			return -EACCES;
 		}
 		if (!stm32_rif_is_semaphore_available(base, id) &&
-		    !(FIELD_GET(RIFSC_RISC_SCID_MASK, sem_reg_value) & BIT(RIF_CID1))) {
+		    !(FIELD_GET(RIFSC_RISC_SCID_MASK, sem_reg_value) & RIF_CID1)) {
 			log_debug("Semaphore unavailable for peripheral %d\n", id);
 			return -EACCES;
 		}
-- 
2.25.1

