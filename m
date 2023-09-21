Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1663DE7D0A0
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D5E86BDF;
	Thu, 21 Sep 2023 19:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="zXkGlTnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128BA86466; Thu, 21 Sep 2023 19:08:54 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB8686264
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695316129; x=1726852129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fFLuUZevtPUiNE1yjj4wgSdLtlimdghO9ftbvIY48uA=;
 b=zXkGlTnIW7ryf202fFhCOG3vz3KRWo5BzzHUi55z/UjATjXd7o+Xu3pQ
 Zv72MTsPFM2IIlgU3uQa+H+BKJmMzW10LidjcKgcc0rmfjZG7E8ZKQcoq
 I2n8CYrZsw+BqZfSmbqL0VbfKFcbQQK7dE/CEtL37u1KVifortvSlmGir
 C/yHV7OuDDFSJSmPPNF0tkJ1Ha83EJ6hOGOW21RRrokXatxoZjUEKS6qH
 Lgah4yD29oaUdPr2CU2BXhK26xjhHkDXQgdhb+flRwMdNuS5b1supISF/
 WeTi4dbjba7OEpLyhqqaAAe0fbSj50+Ou4zmXg71e+ZgzWAeU6+6l8jA/ g==;
X-CSE-ConnectionGUID: DZ84ouTZT5GgoiamJNptxA==
X-CSE-MsgGUID: Kb+nFvFUTJOR/7aYqbEQiw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="172908489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Sep 2023 10:07:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 10:07:07 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 10:07:04 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <u-boot@lists.denx.de>
CC: <durai.manickamkr@microchip.com>, <hari.prasathge@microchip.com>,
 <varshini.rajendran@microchip.com>, <cristian.birsan@microchip.com>,
 <nicolas.ferre@microchip.com>, <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 4/4] ARM: dts: at91: sam9x60_curiosity: fix eeprom compatible
Date: Thu, 21 Sep 2023 22:36:31 +0530
Message-ID: <20230921170631.45752-5-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921170631.45752-1-durai.manickamkr@microchip.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 21 Sep 2023 19:18:38 +0200
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

The EEPROM memory on this board is microchip 24aa025e48 which is compatible with
at24c02 with a page size of 16. Fix the compatible accordingly.

Fixes: a79714f268 ("ARM: dts: Add device tree files for sam9x60_curiosity")
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/dts/at91-sam9x60_curiosity.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/at91-sam9x60_curiosity.dts b/arch/arm/dts/at91-sam9x60_curiosity.dts
index 0d09679bd3..b06e0d9046 100644
--- a/arch/arm/dts/at91-sam9x60_curiosity.dts
+++ b/arch/arm/dts/at91-sam9x60_curiosity.dts
@@ -31,7 +31,7 @@
 					status = "okay";
 
 					eeprom@53 {
-						compatible = "atmel,24c32";
+						compatible = "atmel,24c02";
 						reg = <0x53>;
 						pagesize = <16>;
 					};
-- 
2.25.1

