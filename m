Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60EBC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FEA8803F;
	Tue, 27 Feb 2024 17:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HODCKLsQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xIsdjhC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EB38801F; Tue, 27 Feb 2024 17:10:17 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284CE8802D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBH0Rxtz9sHC;
 Tue, 27 Feb 2024 17:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NY3U5/qa322awZFB1A1IQr8ElDmEQ1psezqS35Bl8mA=;
 b=HODCKLsQlFw23OZyBb1tX3Vjry265gDwRgAipMuiDovdXOnP2U5bbTmJJlYr/g18J0slNe
 19EmIVHw2VQwBuW/N0iLrkKeiFNPi35BcJkkSkDO9AwVdj9jz6i+MvjwRCYQdjM8bpYkAs
 AHIXzJEAUaOG12jL6sLTRMPo8H/bfdL8F5Jejn3ArOunmwXP3ekE9tHV1DNZDcZWXnJLMu
 9rezJc6N+lfxFspGbP6TnCI3T9gFPUJ3cDYI9lwawcbSDAMBOb1ceDOKx8NDrR/AsmGZy5
 N5g/McA3ZojrIj+MbrWXITg4qJvoDD7JZnSJ2U/1nb3sGWW/kbF7cwOQzY5PVQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NY3U5/qa322awZFB1A1IQr8ElDmEQ1psezqS35Bl8mA=;
 b=xIsdjhC85j+aydyqLyTZ+uDw0mk2cJqZpUT2NRv5WJAm3ZuuLhy1jZA6sXBMIP5VXufnFB
 4uU0QqfXelZ3moxilZL1mlUuMMFsLkt27K0ueg/FDm8g9H94YMbEM6URDwKps5nPXJQqcC
 hll3ZhvKAVUNNVY4MMXug1Vt23Epu5T/DfNzXy46mlZwm24osCQACYzIw1CZqhEmVouhpn
 u8AnGVOEfLES1L+2K0eZYKSoPvI2EeEY+GYJ/yuiTJFo0Q8oGmNpNkaEfwD5XpReLH69Zd
 H/h73jVAg5gBwilgktz8c5NJEsPSj/VEFc/16GJM16eQpq//YbSLJovR2Tuj8A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/19] ARM: renesas: Rename rmobile_cpuinfo_idx() to
 renesas_cpuinfo_idx()
Date: Tue, 27 Feb 2024 17:05:48 +0100
Message-ID: <20240227160912.412181-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 55b688e9e18140d856d
X-MBO-RS-META: yaucdxp1qq8wcszuc9obzf1x8iycoyix
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

Rename rmobile_cpuinfo_idx() to renesas_cpuinfo_idx() because all
the chips are made by Renesas, while only a subset of them is from
the R-Mobile line.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 9c5ea4e6cd5..3790ffd0a81 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -81,7 +81,7 @@ static const struct {
 	{ 0x0, "CPU" },
 };
 
-static int rmobile_cpuinfo_idx(void)
+static int renesas_cpuinfo_idx(void)
 {
 	u32 cpu_type = renesas_get_cpu_type();
 	int i;
@@ -104,7 +104,7 @@ static const u8 *get_cpu_name(int idx)
 #ifdef CONFIG_ARCH_MISC_INIT
 int arch_misc_init(void)
 {
-	int i, idx = rmobile_cpuinfo_idx();
+	int i, idx = renesas_cpuinfo_idx();
 	const u8 *cpu_name = get_cpu_name(idx);
 	char cpu[10] = { 0 };
 
@@ -119,7 +119,7 @@ int arch_misc_init(void)
 
 int print_cpuinfo(void)
 {
-	int i = rmobile_cpuinfo_idx();
+	int i = renesas_cpuinfo_idx();
 
 	if (rmobile_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A7796 &&
 	    renesas_get_cpu_rev_integer() == 1 &&
-- 
2.43.0

