Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F6CCD182
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32012836B4;
	Fri,  3 Oct 2025 14:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zE3eBfuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963A2836D3; Fri,  3 Oct 2025 14:15:59 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44DDC83693
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 14:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 593CFsOw3484808;
 Fri, 3 Oct 2025 07:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759493754;
 bh=uV9SDi3HsY0NhRbI87T0M/6LPFlcNQOg1HfadHondCE=;
 h=From:Date:Subject:To:CC;
 b=zE3eBfuOLt3QrB/iUot7qyW7u1EYs2pS28YwxhCIGBaFvfdRTrerdSyUkHARE4KE6
 Y1YsRmubV8SFcDd8e0dyJp9LuoK+52f8eAxDAmWiO9NgM66SRD+qUSvqha9hA03NSD
 Yb6JR66Jqyzq4bfvFuaxcqWm71cPpobAgcdwOT+w=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 593CFsr91164955
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 3 Oct 2025 07:15:54 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 3
 Oct 2025 07:15:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Oct 2025 07:15:54 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 593CFsvo3362628;
 Fri, 3 Oct 2025 07:15:54 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 3 Oct 2025 07:15:45 -0500
Subject: [PATCH -next] arm: dts: k3-am654: add vin-supply regulators for
 DDR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251003-654-next-fix-v1-1-55d803b07d6e@ti.com>
X-B4-Tracking: v=1; b=H4sIAHC+32gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMjXTNTE9281IoS3bTMCl1LC9O0ZEOLFGNzgyQloJaColSgMNi4aCW
 wMqXY2loAiLg7q2UAAAA=
X-Change-ID: 20251002-654-next-fix-985fc18d370b
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=bb@ti.com;
 h=from:subject:message-id; bh=2vHQu2SSFVE4DFMptcCYiZANAbyeaaMiBd9ZHL0bXSE=;
 b=owNCWmg5MUFZJlNZ62Dd0QAAan///37L133zr/batUcv/v8fuaL73N3X/e//7+8v977Zz2awA
 RtYDtQAxAA0NAaANAaaBoNAGgA0GgDQMmjJoaaADQGgGTIDTQMGgDQj0npEGjRo0DQNBoAGgyHq
 NPQhoGmmgGIaDCMj1A0B6gADJoZBpoPUAMmE0ZGQNDIDoNHlNB5JoyABozUaDQAHqeo0DJoGgaA
 DQAaANA0Gj0EGgNGhkNAaD1BpkDQJk7AotP0jwCkAADQPQxbMj5syCYn39YFohPz2SgNeCCZEm0
 y5YjbztL7NtXch50nwD20LHm4Q4pgE4BDP7TBeTE7jvuW2+XAA+XASQEMC6x6iebhdc0fTiEY1M
 bHEwlt0xNfccKRICjCtaMP2s9+dWJNz3EA/CDfCHkVxqSrB7JkCJh6vK0q2vwSUG6HLKAoQyGND
 ND7e1/eCCRc7IZbfLF/eO38gPE+w1fZIsJi2Ock+1mDMOVbkaOTIWJJ+Fmb5cHFtx9aaPFadKCC
 3TQjQEJkV70+ivYoDiupwHJlAvdKpYCNlzBgY9MHRZmtrF+Oqdmlt4oBg9idvXH8KYFTxciRJLX
 JZ22ONjQ0M7Sm+5Hf+rMeye1wDgIJK4CAIXam6RojpaZLisQMQBPhieli1djtcRSNjHW/hCWZyK
 EEdgcZTkJ/4u5IpwoSHWwbuiA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

As of f98d812e53534 ("power: regulator: Add vin-supply for GPIO and Fixed regulators")
we must ensure the parent nodes of a regulator are present in DT if
they are described in the vin-supply property

For the am65x reference board the DRAM chips are fed by the 3v3 rail
which is fed by the main 12v rail. Add the bootph properties to these
DT nodes to prevent them from being pruned during the SPL build so we
can enable power to the DRAM chips

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-base-board-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
index 4fd188fa191b469d69b461b49b17635f914eb53e..baf5dd562f99310f3c8fe1d272cea2fd85164be0 100644
--- a/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-am654-base-board-u-boot.dtsi
@@ -17,6 +17,14 @@
 	bootph-all;
 };
 
+&evm_12v0 {
+	bootph-all;
+};
+
+&vcc3v3_io {
+	bootph-all;
+};
+
 &vtt_supply {
 	bootph-all;
 };

---
base-commit: aff68c8514858ddd8d2e508d47bede566511521b
change-id: 20251002-654-next-fix-985fc18d370b

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

