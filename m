Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD4CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E0988428;
	Wed, 19 Jun 2024 00:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n97Aetpo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wvwq5mdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6F6287B1A; Wed, 19 Jun 2024 00:55:35 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E31CE881E7
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W3htF53YTz9stj
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycEKlwzASMA1AB3aYPs1pMciHC13gfQ1XVqIVpbrgKk=;
 b=n97AetpoEAyXUia4nTtmwg9fpaTHy/NR8Dq4ofkbt65upQJV43ZIKSnKiLLW9xx/fQW6jV
 PUt5WX8/dyesDY9NT2szohUEREeefYdodWg+dKYPGVHMblzvA+XyQEaixjGOLWNnmxtk37
 sWJZahw25Xvojei60mbUKxmFp9nOR0ArSNAWU5ExNlseTSoDQ2LVw+aDww95Z7j9SExD6+
 CzWaDBAE8FfxCGciPB2+1wk5KoKP4G9cvPcNyhgqDILLqMMPN0oSHSwwtfDEQqFXAMSt05
 CHvhxy697VDgX4JmQYg5wc+uJJizujWo8GqWXF9BybG+RvLErQIbJYPlTWzGxw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718751331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycEKlwzASMA1AB3aYPs1pMciHC13gfQ1XVqIVpbrgKk=;
 b=wvwq5mdFqUZTsi8+QItwS0rz3ykOfUqTTC15SAl4yTvNctVH7w7XD2eVYeB8ECL8hh64Mr
 AWaCWWAZiOy1PuolZW+d8RX/WD5KPwxz2yVvifO6yiJtQ9lmZg2ZDWbFHoQiPIMavA+or3
 8DpRLtRQ+GJK9IlP+kz9eQyWlKkkKGDsUkZQRR3lWtGzBTK2cK5I8YC59+c1mC1DnR7+2+
 yf+GRQg3jy2Dh8x43dUzXsViwA86AnLpdowr4gpyhoRP2p2r90US3bLJhcWQKqwVaU1+A0
 hZRKsRWWCgTsCckBAZTotG3xUNaSd2yI7DWd1BBmUgIpPLHgv+9nU5y0/4d1Jw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 6/6] pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC
 tables with Linux 6.9.3
Date: Wed, 19 Jun 2024 00:54:20 +0200
Message-ID: <20240618225505.154437-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
References: <20240618225505.154437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82286d839ef20d07c0e
X-MBO-RS-META: ph8kteew7z8k7hsia9g1nrfpfpzk85da
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

Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.9.3,
commit 1b4861e32e461b6fae14dc49ed0f1c7f20af5146 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 6749c15f4ea..aa58b79c24e 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -2386,6 +2386,14 @@ static const unsigned int scif_clk_mux[] = {
 	SCIF_CLK_MARK,
 };
 
+static const unsigned int scif_clk2_pins[] = {
+	/* SCIF_CLK2 */
+	RCAR_GP_PIN(8, 11),
+};
+static const unsigned int scif_clk2_mux[] = {
+	SCIF_CLK2_MARK,
+};
+
 /* - SSI ------------------------------------------------- */
 static const unsigned int ssi_data_pins[] = {
 	/* SSI_SD */
@@ -2696,6 +2704,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_clk),
 	SH_PFC_PIN_GROUP(scif4_ctrl),
 	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk2),
 
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
@@ -3017,6 +3026,10 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
 
+static const char * const scif_clk2_groups[] = {
+	"scif_clk2",
+};
+
 static const char * const ssi_groups[] = {
 	"ssi_data",
 	"ssi_ctrl",
@@ -3104,6 +3117,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif_clk),
+	SH_PFC_FUNCTION(scif_clk2),
 
 	SH_PFC_FUNCTION(ssi),
 
-- 
2.43.0

