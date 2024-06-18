Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B5AC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B31988335;
	Wed, 19 Jun 2024 00:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718751475;
	bh=mHdGbAfL7loFwPRWsGcPODHrjm6hndIyYhu9UP1rfQw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ahWuwmsAQMptkOB9yp6KsguKp3+zWh4/M9GuxUqCX/ZXrupSzPVosK3AqiDkIY3X+
	 2MS7b3FO2aK+liDoG0vYcjhnjl8YWJzbw7Ctq8vvRcl2R62vHfSZxd2lMfkhjYM3ZO
	 /3wIN5UePL7NCEgY1XdQoC0rB5k+psBGEidydhu7oUJB+KpXtRgPPB9hgSFwEy+LiS
	 Sj8PmrjeQZyO36TZpG8UAvaJAH8CpMdOQjP/GcRoK/SN77eYF9cstG1LzPfN+PL15t
	 D1Ykt0R4fxdiaGk5+UTghNQ/U4+PS7fRRj7fBdkmgtYR5uJatmhw+jHlcKe07acdgl
	 34Lab/12kEAzA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 08F8987B1A;
 Wed, 19 Jun 2024 00:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718751473;
 bh=mHdGbAfL7loFwPRWsGcPODHrjm6hndIyYhu9UP1rfQw=;
 h=From:To:Cc:Subject:Date:From;
 b=AtZBfWII4DbI6Zllq53rxDR27cFjLow36BgOL/j6WMZ9PiMzclbnlwzXhbj3BaAud
 /T5foupZV0EnT8N5RcpnjaP611NbdC0QBrd5taoJStrPm3gtjhORnn7WsyKnfeD1YO
 woVzi9AIvRAS3jY84MSJAvRfU/V6Yc3r0DkEtTHWbJ9OYfU97rMgTiUxhIMXzRiaFc
 JNqPNRTxHbJBLmVqwBucbR9JddPSLEYD9kQbKSpXNM11PAv454gjw+TZg56YeOYIt1
 Q2ZqcEEudTiSEg6nxD7ez+ZHrzfXxkuF2Cu9ji9MzdKD8b/1MlbAkfB1LChIYNokvb
 w3N1DxC+2MAsA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Fix TAMP_SMCR BKP..PROT fields on STM32MP15xx
Date: Wed, 19 Jun 2024 00:57:25 +0200
Message-ID: <20240618225736.154959-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update the TAMP_SMCR BKP..PROT fields to put first 10 registers
into protection zone 1 and next 5 into zone 2. This fixes use of
boot counter which is often in zone 3 and has to be updated from
Linux, which runs in NS.

Fixes: 73f7fc944cf6 ("ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on STM32MP15xx")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
index f096fe538d8..ca202bec8ee 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
@@ -148,8 +148,8 @@ static void security_init(void)
 	 */
 	clrsetbits_le32(TAMP_SMCR,
 			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
-			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
-			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
+			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x0A) |
+			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x0F));
 
 	/* GPIOZ: deactivate the security */
 	writel(BIT(0), RCC_MP_AHB5ENSETR);
-- 
2.43.0

