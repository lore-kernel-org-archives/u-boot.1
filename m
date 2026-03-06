Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A62F01815
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B48083F00;
	Fri,  6 Mar 2026 09:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="15wpnL08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE75483F98; Fri,  6 Mar 2026 09:58:38 +0100 (CET)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF28839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1772787515; x=1773046715;
 bh=jUq2vNFlPu3bE4GhMbUBk5esknqh9OTPtDMoaqwb8fU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=15wpnL08FACkjySjXk2AO8JhnhZk+zEbURC7KaBxoawXlwuCKQEk4NynP3Obca/l8
 STrDdApbmDRsmyfeqYrAWCKlT71oOEQ8RC5uV8VsXmPFT+XRZ1Xp4XjS8YfUtvclSA
 jS11RUdNcCQNqRvJsYZRrzxdb/lUI/b4MzSXTG7ivgjQ4TRLD985hTyiBb0A2TImNh
 QtK0Mv9b8Ki/RLhIjq9cUcGlyPINLVSi9hnWXkpzaPgY/oKPoCXyBlj4Yvgsb7QZE3
 jzLo8Ie7w8kpo2aVlszHtc10V6XGvrStd4ueM0m1+m1Q28W+HfR+c5Tky1EtJ8WKEW
 FAmOecHnQWH4A==
Date: Fri, 06 Mar 2026 08:58:31 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] ddr: imx: Remove duplicate includes
Message-ID: <20260306085824.886254-2-philip@philipmolloy.com>
In-Reply-To: <20260306085824.886254-1-philip@philipmolloy.com>
References: <20260306085824.886254-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: fd06d94be05ec47df6eba16dc72db4448bf68e63
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

Signed-off-by: Philip Molloy <philip.molloy@analog.com>

---

 drivers/ddr/imx/phy/ddrphy_utils.c | 1 -
 drivers/ddr/imx/phy/helper.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrph=
y_utils.c
index 8e350de8315..b406418840c 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <log.h>
 #include <asm/io.h>
-#include <asm/arch/ddr.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index b0dfc3a0b4f..7b590ef397b 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -9,8 +9,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
-#include <asm/io.h>
-#include <asm/arch/ddr.h>
 #include <asm/arch/ddr.h>
 #include <asm/sections.h>
=20
--=20
2.53.0


