Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2A9C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB78C8802D;
	Tue, 27 Feb 2024 17:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eo0hhjI+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s2A8EC1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 776B08801F; Tue, 27 Feb 2024 17:10:17 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE2B88028
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkjBG1Ltzz9t2Z;
 Tue, 27 Feb 2024 17:10:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRzxNM7ViScOekdlU9mk8DwV3h4rL9A1blpnF8rslUs=;
 b=eo0hhjI+wKp2lV+moUbB43+1w45au+3vOFE8mexvwQ6dBvdHH9a3qDDyGNs1Gi9P6IT/GC
 EocYhBd1MH8/MErj0mwdC6zPefNLVDdeIPjYdPS++gfqFhq+kP/pQkXCBr0HAFjlNf7dQ4
 ln443tmEBf9kmPaZDormH1uaRx6afXkVFlkKYXNWICamXmToA75JcN5xTI8Alp+BtucuHD
 myQXss8uLjUKCRjwfOOx09fqyajY/HA1ty6iHC36IWWgCqGhCreCvYhXfIAljln76a43Uo
 FRZI/88pNq+rP1MFFiflQJPRqwEe9gUiOETpGgPLFGA0BYH6z3DBC0ZF4EiAtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRzxNM7ViScOekdlU9mk8DwV3h4rL9A1blpnF8rslUs=;
 b=s2A8EC1DfvI+IFw6h4LXWdJu5Yi7hyrQs+ZQzOW9RlKoF/o9LAWbOHrmBLnd3eqWEMbdZI
 +rh/ezRfFqusAkBFOOA3C3f4FceHMRcWOe5NmiPL9kTM8YZd/5wYWdUdLnZiY10GY4RJ8j
 x7SJEufCaRoSApJWw9NNYdwgwFCSRS6b08+hHZa6eBTVEIeoyfcF0E6c8WZZXAZtDTt7Mo
 DmYfZyy2hikDNvQ9+BC7Tey45uDYIrsu5jS3NA1FqS501Pqul0fQaHNDtKu+3TcpwQAkic
 S49Ll+IkVej4z2lK5N/gApjYrAXah1XU6VRsALopOy2a6B/bPWekDCl+RR70DQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/19] ARM: renesas: Rename RMOBILE_CPU_TYPE_* to
 RENESAS_CPU_TYPE_*
Date: Tue, 27 Feb 2024 17:05:47 +0100
Message-ID: <20240227160912.412181-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cddd9aae20e71a3b83a
X-MBO-RS-META: gcdwsxji83n7yo6r6846n86d8tkphqtk
X-Rspamd-Queue-Id: 4TkjBG1Ltzz9t2Z
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

Rename RMOBILE_CPU_TYPE_* to RENESAS_CPU_TYPE_* because all
the chips are made by Renesas, while only a subset of them is
from the R-Mobile line.

Use the following command to perform the rename:

"
$ git grep -l '\<RMOBILE_CPU_TYPE_[A-Z0-9]\+\>' | \
  xargs -I {} sed -i 's@\<RMOBILE\(_CPU_TYPE_[A-Z0-9]\+\)\>@RENESAS\1@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info-rzg2l.c       |  2 +-
 arch/arm/mach-rmobile/cpu_info.c             | 34 +++++++++---------
 arch/arm/mach-rmobile/include/mach/rmobile.h | 36 ++++++++++----------
 board/renesas/salvator-x/salvator-x.c        |  6 ++--
 board/renesas/ulcb/ulcb.c                    |  6 ++--
 drivers/mmc/renesas-sdhi.c                   | 34 +++++++++---------
 drivers/net/ravb.c                           |  4 +--
 drivers/spi/renesas_rpc_spi.c                |  8 ++---
 8 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
index ce7cc2a28db..a1683a26e35 100644
--- a/arch/arm/mach-rmobile/cpu_info-rzg2l.c
+++ b/arch/arm/mach-rmobile/cpu_info-rzg2l.c
@@ -21,7 +21,7 @@ struct tfa_info {
 };
 
 static const struct tfa_info tfa_info[] = {
-	{ "renesas,r9a07g044l2", "R9A07G044L", RMOBILE_CPU_TYPE_R9A07G044L },
+	{ "renesas,r9a07g044l2", "R9A07G044L", RENESAS_CPU_TYPE_R9A07G044L },
 };
 
 static const struct tfa_info invalid_tfa_info = { NULL, "(invalid)", 0 };
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 35cfef2e1ab..9c5ea4e6cd5 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -62,22 +62,22 @@ static const struct {
 	u16 cpu_type;
 	u8 cpu_name[10];
 } rmobile_cpuinfo[] = {
-	{ RMOBILE_CPU_TYPE_R8A7790, "R8A7790" },
-	{ RMOBILE_CPU_TYPE_R8A7791, "R8A7791" },
-	{ RMOBILE_CPU_TYPE_R8A7792, "R8A7792" },
-	{ RMOBILE_CPU_TYPE_R8A7793, "R8A7793" },
-	{ RMOBILE_CPU_TYPE_R8A7794, "R8A7794" },
-	{ RMOBILE_CPU_TYPE_R8A7795, "R8A7795" },
-	{ RMOBILE_CPU_TYPE_R8A7796, "R8A7796" },
-	{ RMOBILE_CPU_TYPE_R8A77965, "R8A77965" },
-	{ RMOBILE_CPU_TYPE_R8A77970, "R8A77970" },
-	{ RMOBILE_CPU_TYPE_R8A77980, "R8A77980" },
-	{ RMOBILE_CPU_TYPE_R8A77990, "R8A77990" },
-	{ RMOBILE_CPU_TYPE_R8A77995, "R8A77995" },
-	{ RMOBILE_CPU_TYPE_R8A779A0, "R8A779A0" },
-	{ RMOBILE_CPU_TYPE_R8A779F0, "R8A779F0" },
-	{ RMOBILE_CPU_TYPE_R8A779G0, "R8A779G0" },
-	{ RMOBILE_CPU_TYPE_R8A779H0, "R8A779H0" },
+	{ RENESAS_CPU_TYPE_R8A7790, "R8A7790" },
+	{ RENESAS_CPU_TYPE_R8A7791, "R8A7791" },
+	{ RENESAS_CPU_TYPE_R8A7792, "R8A7792" },
+	{ RENESAS_CPU_TYPE_R8A7793, "R8A7793" },
+	{ RENESAS_CPU_TYPE_R8A7794, "R8A7794" },
+	{ RENESAS_CPU_TYPE_R8A7795, "R8A7795" },
+	{ RENESAS_CPU_TYPE_R8A7796, "R8A7796" },
+	{ RENESAS_CPU_TYPE_R8A77965, "R8A77965" },
+	{ RENESAS_CPU_TYPE_R8A77970, "R8A77970" },
+	{ RENESAS_CPU_TYPE_R8A77980, "R8A77980" },
+	{ RENESAS_CPU_TYPE_R8A77990, "R8A77990" },
+	{ RENESAS_CPU_TYPE_R8A77995, "R8A77995" },
+	{ RENESAS_CPU_TYPE_R8A779A0, "R8A779A0" },
+	{ RENESAS_CPU_TYPE_R8A779F0, "R8A779F0" },
+	{ RENESAS_CPU_TYPE_R8A779G0, "R8A779G0" },
+	{ RENESAS_CPU_TYPE_R8A779H0, "R8A779H0" },
 	{ 0x0, "CPU" },
 };
 
@@ -121,7 +121,7 @@ int print_cpuinfo(void)
 {
 	int i = rmobile_cpuinfo_idx();
 
-	if (rmobile_cpuinfo[i].cpu_type == RMOBILE_CPU_TYPE_R8A7796 &&
+	if (rmobile_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A7796 &&
 	    renesas_get_cpu_rev_integer() == 1 &&
 	    renesas_get_cpu_rev_fraction() == 1) {
 		printf("CPU:   Renesas Electronics %s rev 1.1/1.2\n", get_cpu_name(i));
diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/mach-rmobile/include/mach/rmobile.h
index d41b737d6b1..67c480048de 100644
--- a/arch/arm/mach-rmobile/include/mach/rmobile.h
+++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
@@ -25,24 +25,24 @@
 #endif /* CONFIG_ARCH_RMOBILE */
 
 /* PRR CPU IDs */
-#define RMOBILE_CPU_TYPE_R8A7740	0x40
-#define RMOBILE_CPU_TYPE_R8A7790	0x45
-#define RMOBILE_CPU_TYPE_R8A7791	0x47
-#define RMOBILE_CPU_TYPE_R8A7792	0x4A
-#define RMOBILE_CPU_TYPE_R8A7793	0x4B
-#define RMOBILE_CPU_TYPE_R8A7794	0x4C
-#define RMOBILE_CPU_TYPE_R8A7795	0x4F
-#define RMOBILE_CPU_TYPE_R8A7796	0x52
-#define RMOBILE_CPU_TYPE_R8A77965	0x55
-#define RMOBILE_CPU_TYPE_R8A77970	0x54
-#define RMOBILE_CPU_TYPE_R8A77980	0x56
-#define RMOBILE_CPU_TYPE_R8A77990	0x57
-#define RMOBILE_CPU_TYPE_R8A77995	0x58
-#define RMOBILE_CPU_TYPE_R8A779A0	0x59
-#define RMOBILE_CPU_TYPE_R8A779F0	0x5A
-#define RMOBILE_CPU_TYPE_R8A779G0	0x5C
-#define RMOBILE_CPU_TYPE_R8A779H0	0x5D
-#define RMOBILE_CPU_TYPE_R9A07G044L	0x9A070440
+#define RENESAS_CPU_TYPE_R8A7740	0x40
+#define RENESAS_CPU_TYPE_R8A7790	0x45
+#define RENESAS_CPU_TYPE_R8A7791	0x47
+#define RENESAS_CPU_TYPE_R8A7792	0x4A
+#define RENESAS_CPU_TYPE_R8A7793	0x4B
+#define RENESAS_CPU_TYPE_R8A7794	0x4C
+#define RENESAS_CPU_TYPE_R8A7795	0x4F
+#define RENESAS_CPU_TYPE_R8A7796	0x52
+#define RENESAS_CPU_TYPE_R8A77965	0x55
+#define RENESAS_CPU_TYPE_R8A77970	0x54
+#define RENESAS_CPU_TYPE_R8A77980	0x56
+#define RENESAS_CPU_TYPE_R8A77990	0x57
+#define RENESAS_CPU_TYPE_R8A77995	0x58
+#define RENESAS_CPU_TYPE_R8A779A0	0x59
+#define RENESAS_CPU_TYPE_R8A779F0	0x5A
+#define RENESAS_CPU_TYPE_R8A779G0	0x5C
+#define RENESAS_CPU_TYPE_R8A779H0	0x5D
+#define RENESAS_CPU_TYPE_R9A07G044L	0x9A070440
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 01571625e71..ca05285a09b 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -78,15 +78,15 @@ int board_fit_config_name_match(const char *name)
 	/* PRR driver is not available yet */
 	u32 cpu_type = renesas_get_cpu_type();
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7795) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
 	    !strcmp(name, "r8a77950-salvator-x-u-boot"))
 		return 0;
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
 	    !strcmp(name, "r8a77960-salvator-x-u-boot"))
 		return 0;
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A77965) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A77965) &&
 	    !strcmp(name, "r8a77965-salvator-x-u-boot"))
 		return 0;
 
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 5d7ebbd922f..6addf2bc8b4 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -69,15 +69,15 @@ int board_fit_config_name_match(const char *name)
 	/* PRR driver is not available yet */
 	u32 cpu_type = renesas_get_cpu_type();
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7795) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
 	    !strcmp(name, "r8a77950-ulcb-u-boot"))
 		return 0;
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
 	    !strcmp(name, "r8a77960-ulcb-u-boot"))
 		return 0;
 
-	if ((cpu_type == RMOBILE_CPU_TYPE_R8A77965) &&
+	if ((cpu_type == RENESAS_CPU_TYPE_R8A77965) &&
 	    !strcmp(name, "r8a77965-ulcb-u-boot"))
 		return 0;
 
diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
index 03e360ec1a2..82237ef3dbd 100644
--- a/drivers/mmc/renesas-sdhi.c
+++ b/drivers/mmc/renesas-sdhi.c
@@ -885,28 +885,28 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	struct tmio_sd_plat *plat = dev_get_plat(dev);
 
 	/* HS400 is not supported on H3 ES1.x, M3W ES1.[012], V3M, V3H ES1.x, D3 */
-	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7795) &&
 	    (renesas_get_cpu_rev_integer() <= 1)) ||
-	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 1) &&
 	    (renesas_get_cpu_rev_fraction() <= 2)) ||
-	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970) ||
-	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77980) &&
+	    (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77970) ||
+	    ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77980) &&
 	    (renesas_get_cpu_rev_integer() <= 1)) ||
-	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
+	    (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995))
 		plat->cfg.host_caps &= ~MMC_MODE_HS400;
 
 	/* H3 ES2.0, ES3.0 and M3W ES1.2 and M3N bad taps */
-	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7795) &&
 	    (renesas_get_cpu_rev_integer() >= 2)) ||
-	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 1) &&
 	    (renesas_get_cpu_rev_fraction() == 2)) ||
-	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965))
+	    (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77965))
 		priv->hs400_bad_tap = BIT(2) | BIT(3) | BIT(6) | BIT(7);
 
 	/* M3W ES1.x for x>2 can use HS400 with manual adjustment and taps */
-	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 1) &&
 	    (renesas_get_cpu_rev_fraction() > 2)) {
 		priv->adjust_hs400_enable = true;
@@ -917,12 +917,12 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* M3W+ bad taps */
-	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	if ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 3))
 		priv->hs400_bad_tap = BIT(1) | BIT(3) | BIT(5) | BIT(7);
 
 	/* M3N can use HS400 with manual adjustment */
-	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77965) {
+	if (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77965) {
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
@@ -930,7 +930,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* E3 can use HS400 with manual adjustment */
-	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) {
+	if (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77990) {
 		priv->adjust_hs400_enable = true;
 		priv->adjust_hs400_offset = 3;
 		priv->adjust_hs400_calib_table =
@@ -938,9 +938,9 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 	}
 
 	/* H3 ES1.x, ES2.0 and M3W ES1.[0123] uses 4 tuning taps */
-	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7795) &&
 	    (renesas_get_cpu_rev_integer() <= 2)) ||
-	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 1) &&
 	    (renesas_get_cpu_rev_fraction() <= 3)))
 		priv->nrtaps = 4;
@@ -948,9 +948,9 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->nrtaps = 8;
 #endif
 	/* H3 ES1.x and M3W ES1.0 uses bit 17 for DTRAEND */
-	if (((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7795) &&
+	if (((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7795) &&
 	    (renesas_get_cpu_rev_integer() <= 1)) ||
-	    ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A7796) &&
+	    ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A7796) &&
 	    (renesas_get_cpu_rev_integer() == 1) &&
 	    (renesas_get_cpu_rev_fraction() == 0)))
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD;
@@ -958,7 +958,7 @@ static void renesas_sdhi_filter_caps(struct udevice *dev)
 		priv->read_poll_flag = TMIO_SD_DMA_INFO1_END_RD2;
 
 	/* V3M handles SD0H differently than other Gen3 SoCs */
-	if (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77970)
+	if (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77970)
 		priv->needs_clkh_fallback = true;
 	else
 		priv->needs_clkh_fallback = false;
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 733f08ad4ea..4764bca7082 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -392,8 +392,8 @@ static int ravb_dmac_init(struct udevice *dev)
 	writel(0x00222210, eth->iobase + RAVB_REG_TGC);
 
 	/* Delay CLK: 2ns (not applicable on R-Car E3/D3) */
-	if ((renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77990) ||
-	    (renesas_get_cpu_type() == RMOBILE_CPU_TYPE_R8A77995))
+	if ((renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77990) ||
+	    (renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995))
 		return 0;
 
 	if (!dev_read_u32(dev, "rx-internal-delay-ps", &delay)) {
diff --git a/drivers/spi/renesas_rpc_spi.c b/drivers/spi/renesas_rpc_spi.c
index 165c0a1351a..8aff2238645 100644
--- a/drivers/spi/renesas_rpc_spi.c
+++ b/drivers/spi/renesas_rpc_spi.c
@@ -212,11 +212,11 @@ static u32 rpc_spi_get_strobe_delay(void)
 	 *       7: On other R-Car Gen3
 	 *      15: On R-Car Gen4
 	 */
-	if (cpu_type == RMOBILE_CPU_TYPE_R8A7796 && renesas_get_cpu_rev_integer() == 1)
+	if (cpu_type == RENESAS_CPU_TYPE_R8A7796 && renesas_get_cpu_rev_integer() == 1)
 		return RPC_PHYCNT_STRTIM(6);
-	else if (cpu_type == RMOBILE_CPU_TYPE_R8A779F0 ||
-		 cpu_type == RMOBILE_CPU_TYPE_R8A779G0 ||
-		 cpu_type == RMOBILE_CPU_TYPE_R8A779H0)
+	else if (cpu_type == RENESAS_CPU_TYPE_R8A779F0 ||
+		 cpu_type == RENESAS_CPU_TYPE_R8A779G0 ||
+		 cpu_type == RENESAS_CPU_TYPE_R8A779H0)
 		return RPC_PHYCNT_STRTIM2(15);
 	else
 #endif
-- 
2.43.0

