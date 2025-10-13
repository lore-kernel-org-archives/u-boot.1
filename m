Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3069CCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D9B0838C1;
	Mon, 13 Oct 2025 17:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="fBDWLdqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C00883835; Mon, 13 Oct 2025 11:32:52 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9215D83741
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 11:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=37475b72b=Dharma.B@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1760347970; x=1791883970;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ZM7o9D4w41IdAS9WH8WIXAsdMHKyLPStgGpHhCv0HCg=;
 b=fBDWLdqXKxly6/YBgKRsC9RoZYrHr1IIAVkUr19toMkPUIfCzsOd3M5H
 tQ9azJQ4jB5bzhe0GNqGCgg9az90cjBwd3XOMoZFozqBXMIZXuzr4GhQk
 XxwBN7VU/bCzspmi25nVRf8phw2kjOwJIiTXeCv4Cy9O5fi4RSjfmQmah
 lU1ipTaaeWOQr114jUVTmALM6To80O8qjzGZNtzocCZ3mHSUfH5xHqm7R
 rc5r2bSKrWTg0j2mTPgfcIgNkNv2QAz04+E3J+FrBuTvQa8WSykwKUi2M
 gHEOk7uTkKH5rLIXauIGXbbeI40qzs/Y9L1jKPL4nPy2suFDkrlp+o2JK Q==;
X-CSE-ConnectionGUID: 3JXCmaLLTQesVdpj+bVk8g==
X-CSE-MsgGUID: iHbKtj1oQae9pL1oo/DjDA==
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="279054317"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Oct 2025 02:32:48 -0700
Received: from chn-vm-ex1.mchp-main.com (10.10.87.30) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 13 Oct 2025 02:32:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Mon, 13 Oct 2025 02:32:27 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 13 Oct 2025 02:32:24 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <u-boot@lists.denx.de>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v2] ARM: dts: sam9x60ek: select PIT as tick-timer
Date: Mon, 13 Oct 2025 15:02:18 +0530
Message-ID: <20251013093220.32833-1-dharma.b@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 13 Oct 2025 17:40:45 +0200
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

U-Boot currently enables the UPLL during boot, which triggers a udelay()
call that depends on the system tick timer. Since no explicit tick source
is defined in the device tree, boot stalls on this board.

Define the "tick-timer" property under /chosen and point it to the PIT
node, ensuring U-Boot uses the PIT as the tick source.

Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

---

Changes in v2:
- Moved the 'tick-timer' property to sam9x60ek-u-boot.dtsi.

 arch/arm/dts/sam9x60ek-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/sam9x60ek-u-boot.dtsi b/arch/arm/dts/sam9x60ek-u-boot.dtsi
index fd2afa8a2fa..ef329b33b7e 100644
--- a/arch/arm/dts/sam9x60ek-u-boot.dtsi
+++ b/arch/arm/dts/sam9x60ek-u-boot.dtsi
@@ -8,6 +8,7 @@
 / {
 	chosen {
 		bootph-all;
+		tick-timer = &pit;
 	};
 
 	ahb {
-- 
2.43.0

base-commit: eea470fd7f6a0db9fbdf8ab187a8b522dbb49c10
branch: master
