Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFACD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB5584C06;
	Fri,  8 May 2026 01:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CYyFx2iz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xL5frup0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F7884B92; Fri,  8 May 2026 01:24:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DFE84B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBSyM31bbz9tqc;
 Fri,  8 May 2026 01:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g5AKep5UP1LVf1nrGvYGVCgziErvPrjsOwmXPKR+Wc=;
 b=CYyFx2izolWhRdtf6wg9O5W35DCLTsfU6ALP64t07GZnf8jYdlrdkxCPgYUz86lXiMIbPA
 2Btr22pWm94bH65yzSIJxSXnMMP5Ixl9kI7AqMNfQv2eAgpu5++1fXJ1/Au+fzsUgLAUxY
 DMkKIDXE+MPDd3x0mfovHrSJ+zEtDYwBh1D4W5vZIZ1lzUQmsPbGrrWXtzrq3+UCEgwPjx
 XWIisqpTTMpiF97p5HQgJ5/lF3M4LD2zCj4JMjH5L4OfGDfmbZyZwyq53d+Hov+mWpfdxZ
 GVICtPsirYVqEPxkZWiGtCTpxyoM814WcgVK3WBPROx0n3fSaF528xTlcHL8gg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g5AKep5UP1LVf1nrGvYGVCgziErvPrjsOwmXPKR+Wc=;
 b=xL5frup0Fws9tJaFSBXrdZBsm8lSTd5trajEFeBDj6NIbfPLd9BMHYuPZEkW+HZLQdX+JH
 PRocDjebKUh04AFW3hnqlUsLDcibmKNw+/RqHTWsBmOMBaDMNj/M2MDg0NKkHEUK179w+p
 YFaLCWNbEi03d2JM8h/dCH/BtYw9A7sg8GRhqjw4c63SpkyoRm8b8Unluvi5ShtX0wZtze
 mzpiVTG4pMLdg3lTbHHB/fsdDjgJkuW9Bm+qy95hDzZ/hQwzfRjkW1w1j0ObKj2FdrfL0N
 Pz35avQuin2xhCTNOl2Igw8h/meTR3aqSDftF1r9KXhwuTskzB/Ib/HHE6prfg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] arm64: renesas: Select R-Car Gen5 R8A78000 X5H CPG clock
 driver
Date: Fri,  8 May 2026 01:23:29 +0200
Message-ID: <20260507232424.304154-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
References: <20260507232424.304154-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o7ob41dqt9f7n7nbuukauu1euxzpzqmy
X-MBO-RS-ID: 5c902265491b37dd06c
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

Select the R8A78000 clock driver on R-Car Gen5 X5H SoC by default.
The clock driver is used to remap DT clock IDs to SCMI clock IDs,
which is necessary to support multiple SCP firmware versions with
varying SCMI clock IDs across versions.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Clément Le Goffic <clegoffic@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Kconfig.rcar5 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
index 0e0e43c08e4..a9a9137f5be 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar5
+++ b/arch/arm/mach-renesas/Kconfig.rcar5
@@ -13,6 +13,7 @@ menu "Select Target SoC"
 config R8A78000
 	bool "Renesas SoC R8A78000"
 	select GICV3
+	imply CLK_R8A78000
 	imply PINCTRL_PFC_R8A78000
 
 endmenu
-- 
2.53.0

