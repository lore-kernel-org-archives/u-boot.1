Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA65CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2FD78460C;
	Mon, 11 May 2026 22:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="WjCSMCxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB4484669; Mon, 11 May 2026 22:13:19 +0200 (CEST)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 855F383FEC
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20260511201315a5a68be4e00002078a for <u-boot@lists.denx.de>;
 Mon, 11 May 2026 22:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sEpt/n8bC5havOuUQUiqO0NKgjnLYrAwPdgsPyjRVXQ=;
 b=WjCSMCxlSy7bfsiWvRBElkPfraBrDq2mB8vs5YfqAETYLV3ct9GY9ZQ+XCw4QxukRnaNTb
 Hq7tR/4W6/hNMX9xdrEW1u2doHsZVgA3nQIHyM5xU+VnLu/ThKNb4LzD9f4hK3c9EEt0lIIN
 NM1O8wZT9hqhH8gnM20SQr10/jlCtQaUYSbEj19dfMSyqac1xkYiBxXjsYORUXop1QIqqkwS
 OfIHapWfjfyFhbjHdVbH0Lr077NnHfc3frrkKuMTuYfU7jGnBPQxkZBbV7vHvTXC0IXtzevp
 9VO+Ok6yTg60jL4fCzO+Om6E2RbMhRuNgY8P4vLHy+/J5SRAlG7WwXOQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Ji Luo <ji.luo@nxp.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/4] nxp: imx9: rename get_reset_reason() ->
 print_reset_reason()
Date: Mon, 11 May 2026 22:12:31 +0200
Message-ID: <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Rename get_reset_reason() into print_reset_reason() as the latter better
describes the functionality. get_reset_reason() can now be a global symbol
providing a reset reason as string.

No change in behaviour expected.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h | 2 +-
 arch/arm/mach-imx/imx9/scmi/soc.c          | 2 +-
 board/nxp/imx94_evk/spl.c                  | 2 +-
 board/nxp/imx95_evk/spl.c                  | 2 +-
 board/toradex/smarc-imx95/spl.c            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index dead7a99a66..e9483d0d090 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -21,7 +21,7 @@ int m33_prepare(void);
 int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
-int get_reset_reason(bool sys, bool lm);
+int print_reset_reason(bool sys, bool lm);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..9142f847f6c 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -618,7 +618,7 @@ static char *rst_string_imx94[32] = {
 	"por"
 };
 
-int get_reset_reason(bool sys, bool lm)
+int print_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
 		.flags = MISC_REASON_FLAG_SYSTEM,
diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index 6eb0fff99f4..45348b5eb84 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -84,7 +84,7 @@ void board_init_f(ulong dummy)
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
-	get_reset_reason(true, false);
+	print_reset_reason(true, false);
 
 	xspi_nor_reset();
 
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 761a1a4a0f6..e57d10aa169 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -72,7 +72,7 @@ void board_init_f(ulong dummy)
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
-	get_reset_reason(true, false);
+	print_reset_reason(true, false);
 
 	board_init_r(NULL, 0);
 }
diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
index ce8da89410b..b4aa5da71c0 100644
--- a/board/toradex/smarc-imx95/spl.c
+++ b/board/toradex/smarc-imx95/spl.c
@@ -111,7 +111,7 @@ void board_init_f(ulong dummy)
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
 	ec_boot_notify();
-	get_reset_reason(true, false);
+	print_reset_reason(true, false);
 
 	board_init_r(NULL, 0);
 }
-- 
2.52.0

