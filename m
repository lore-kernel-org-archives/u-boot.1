Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD424C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2B2888055;
	Tue, 27 Feb 2024 17:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Bfu7o9X4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WYzo+GeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8667088026; Tue, 27 Feb 2024 17:10:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FB388026
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBK6NxTz9sl6;
 Tue, 27 Feb 2024 17:10:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4EdXYyLO2atBR2DhKwmXwoZlLm6HX3ITsQAxjfGO6k=;
 b=Bfu7o9X4cDtx/sw77dwh3+jrS/3RDBKwdyHYG2VIQt0he4Dn+KvgGr+ciynQqX/KWZ4V/a
 rt9OhrRqMP/NbLMzfMnbKI1Av2wHTf6IybCbsWQGsLRR52kTXYd3C3l03sdHNHZVAwJYdp
 PndiAhKfvRbk52Q+tgzHB3YEXzGs3MM/9JBk4L+2XiIXAPY6sH9xaNeuXyt97394AL6LNN
 9fEcEU4ePOQ6FViWeQVkViZva0EipIDdcUCmR02nSLRS2WG4GhIogjV62nu/ZYWOz6k9WH
 3G2EjYERK/EQ5ku3MNk5m9x/l1pht7ZTXPlgxg6TYfhFfL1Ff/nnE1pxHoAIDA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4EdXYyLO2atBR2DhKwmXwoZlLm6HX3ITsQAxjfGO6k=;
 b=WYzo+GeJiuYThFJg0WXtoBsp0KBiWqo9hyAnmh6o1V5l5U9XcvE2/0XlJS9ab3H3fngXfV
 yOhnHM2BTlUEOGQjwNiHdXdBjkF3vx/pHgM2Ya1FXFjxatbTG/vL5BQv83uXGabJ2jkfzF
 e6AiBTY+0TYST/4pojx2dQmGYc0BwrOXRD0bOgznX4Netbv9WDHxa2+sfAzlUunn5foQUr
 BwRWD+xMzwxq1l62hhxvH2hOHPX1xQZ2OEtL70ehG0ACGl+Zl2ubXkeG+zDp0ZW9gqJD5E
 9/z8jYA0hnF80g68bnhMl/JHFNQnO3jJYmt3AH3kstIbk9YOFkTcokJyVSNVMg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/19] ARM: renesas: Rename rmobile_get_prr() to
 renesas_get_prr()
Date: Tue, 27 Feb 2024 17:05:51 +0100
Message-ID: <20240227160912.412181-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rge4qaf1s9w7aiyh44uhwaidsbepo4bp
X-MBO-RS-ID: f9663536adf66f0eba9
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

Rename rmobile_get_prr() to renesas_get_prr() because all the
chips are made by Renesas, while only a subset of them is from
the R-Mobile line.

Use the following command to perform the rename:

"
$ git grep -l '\<rmobile_get_prr\>' | \
  xargs -I {} sed -i 's@\<rmobile_get_prr\>@renesas_get_prr@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-rmobile/cpu_info-rcar.c
index 4c439adfdd6..94188362155 100644
--- a/arch/arm/mach-rmobile/cpu_info-rcar.c
+++ b/arch/arm/mach-rmobile/cpu_info-rcar.c
@@ -13,7 +13,7 @@
 #define R8A7796_REV_1_3		0x5211
 #define R8A77995_REV_1_1	0x5810
 
-static u32 rmobile_get_prr(void)
+static u32 renesas_get_prr(void)
 {
 	if (IS_ENABLED(CONFIG_RCAR_64))
 		return readl(0xFFF00044);
@@ -23,12 +23,12 @@ static u32 rmobile_get_prr(void)
 
 u32 renesas_get_cpu_type(void)
 {
-	return (rmobile_get_prr() & 0x00007F00) >> 8;
+	return (renesas_get_prr() & 0x00007F00) >> 8;
 }
 
 u32 renesas_get_cpu_rev_integer(void)
 {
-	const u32 prr = rmobile_get_prr();
+	const u32 prr = renesas_get_prr();
 	const u32 rev = prr & PRR_MASK;
 
 	if (rev == R8A7796_REV_1_1 || rev == R8A7796_REV_1_3 ||
@@ -40,7 +40,7 @@ u32 renesas_get_cpu_rev_integer(void)
 
 u32 renesas_get_cpu_rev_fraction(void)
 {
-	const u32 prr = rmobile_get_prr();
+	const u32 prr = renesas_get_prr();
 	const u32 rev = prr & PRR_MASK;
 
 	if (rev == R8A7796_REV_1_1 || rev == R8A77995_REV_1_1)
-- 
2.43.0

