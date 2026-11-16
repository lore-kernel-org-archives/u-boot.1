Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65453606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=owkY/+Uh;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dvZKMZ2F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3513B40737;
	Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0QP_h4c9nGz; Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E9E94075D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850562;
	b=Mer8N+zNgCvqYp6o9dYW07suOTXtOCk8hNqg+emcuxn2reQOKJXu8kjqHGReycfX7p2R
	 5s159aoVjjSrDO3DSaKzjufp3iIMCDQXG5IKm4RkBP1Fr2uLB7O4uaF6xeD1U0ISUkkk5
	 4qrsrH+jdm+wVcC1Vwj/NWpy1PWVsSb+A5Y3ZvfEEkioxJbhRZabK3icQ2qqnCkJpIDGR
	 EzdVRdfKFr8X70om3mgjrE4tavh8S9Lfq8X5dJ/C0MW58ndURgADBc1dy2ICbjayaqkBB
	 4uQ1Nbiy7dqRKMts+2wvvDHwVAaCbAufPeAri0AKRpemz8Q3UuG5tk9VPcidXAmThbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tq4hNP6xlqjmSb7INr28JIPpsQc4sZ8NOsHQh8QUdhY=;
	b=ikwpO26KwAfK8yItuRWVk2r6YFUnEGVufQa3oFqyT1Oa/C+o36HsYdOALDa4A4V2kygQ
	 7Jjgg5hRob3f5G8ILIiVMUfqbVrBLkUlUlNwFPQHeM1Imf6ZK3RjS16WBrNAB8TD6Uc/7
	 nQ2KP72Ucl1iFUBHQoipJL1nFuQ4lYE15D/Cwx9dJQvCGT26dHbPPvqndSTa/UsoTY6bg
	 aEQqRc+Pv7xHkUbkAabG0mobX2Dhm+fSNQBsKCwWbxQ9etnU+ZZHUwNyJhE3KgZyOQj5D
	 u85W6vV2575p18KZbBXANTfPJw0YUjpvxfqh+wd1F+94yCO4O9UHkhvee5hlKNSZw9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850562;
	bh=tq4hNP6xlqjmSb7INr28JIPpsQc4sZ8NOsHQh8QUdhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owkY/+UhOpAdD4pIZbrJ1MgT2g9CjTA+vkvuqHg76YCeto7WNorKmIolgUu1t1w1Y
	 ubW49v6KenHhpCtpeJ7MHrKPYuHCLV1Y6afFAGXwMkm15xor3hFP1WIOJxp8zreuw5
	 fBBfCiUbZNvX8wze/+35uKtLdNb4L7tTRUtfoHoiN38r0ZvK7kTS8JrX11rh0bKCfc
	 N7SVwKYRxrTaeAJnk0jdMY0+z4M4N99sApF1vzm/lHhytLJG+ZNzlaIquzOIR5Sa1R
	 COIGqUMpumyf5URgWV47hv1PdBebwN9lITVhpg/TJvARO2uF9PsNdqdyHAfTsP3Yay
	 szB2y5WtdSxKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E9E94075D;
	Mon, 16 Nov 2026 17:36:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AB6781E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 840396080A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CBvv6nXpOKSu for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B661607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dvZKMZ2F
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B661607E4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:56 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSw4m16GMzKr65;
 Mon, 16 Nov 2026 18:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tq4hNP6xlqjmSb7INr28JIPpsQc4sZ8NOsHQh8QUdhY=;
 b=dvZKMZ2FE05L05uf78t02hnURLlWqL5AiGbGFqj1MvGLjZnZXP8VgKXD+vSGebKeXH1AnH
 eEscuC0QELlgV8Wzc24ZaR1Nv9JP7E/hLUUqn1n6EW9Lb8iyoE26KKdRqVv57xRnLgQSDy
 Nvd4CqFImafd6PNGhcUzHVenQod7/ktcuD9c39hVH7f18DsA4h7z8zaeCDBNNLfVXF++rq
 /jzm2ceQnjhofJ1Wkbf1YIcZqpfo9ZC3MCuD1XgGJqZ1loQq2de+jdXAiT5Yvpr0hyb4m3
 3mIQLKw60929p49wV1k7jsAerpdJQDg09YHAE+uaQmrGzR4HawoPcYTnIt/JmQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Eugen Hristev <ehristev@kernel.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/20] clk: at91: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:41 +0100
Message-ID: <20261116173546.3487841-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82fdb84d8f02f082c5a
X-MBO-RS-META: mzeejozhfge9j6si13dmbo7i6bx44edz
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Eugen Hristev <ehristev@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/at91/compat.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index 2449ac9fae6..25ddfff4578 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -153,7 +153,7 @@ static ulong at91_slow_clk_get_rate(struct clk *clk)
 	return CFG_SYS_AT91_SLOW_CLOCK;
 }
 
-static struct clk_ops at91_slow_clk_ops = {
+static const struct clk_ops at91_slow_clk_ops = {
 	.enable = at91_slow_clk_enable,
 	.get_rate = at91_slow_clk_get_rate,
 };
@@ -176,7 +176,7 @@ static ulong at91_master_clk_get_rate(struct clk *clk)
 	return gd->arch.mck_rate_hz;
 }
 
-static struct clk_ops at91_master_clk_ops = {
+static const struct clk_ops at91_master_clk_ops = {
 	.get_rate = at91_master_clk_get_rate,
 };
 
@@ -210,7 +210,7 @@ static ulong main_osc_clk_get_rate(struct clk *clk)
 	return gd->arch.main_clk_rate_hz;
 }
 
-static struct clk_ops main_osc_clk_ops = {
+static const struct clk_ops main_osc_clk_ops = {
 	.enable = main_osc_clk_enable,
 	.get_rate = main_osc_clk_get_rate,
 };
@@ -251,7 +251,7 @@ static ulong plla_clk_get_rate(struct clk *clk)
 	return gd->arch.plla_rate_hz;
 }
 
-static struct clk_ops plla_clk_ops = {
+static const struct clk_ops plla_clk_ops = {
 	.enable = plla_clk_enable,
 	.get_rate = plla_clk_get_rate,
 };
@@ -324,7 +324,7 @@ static ulong at91_plladiv_clk_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static struct clk_ops at91_plladiv_clk_ops = {
+static const struct clk_ops at91_plladiv_clk_ops = {
 	.enable = at91_plladiv_clk_enable,
 	.get_rate = at91_plladiv_clk_get_rate,
 	.set_rate = at91_plladiv_clk_set_rate,
@@ -431,7 +431,7 @@ static int system_clk_enable(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops system_clk_ops = {
+static const struct clk_ops system_clk_ops = {
 	.of_xlate = at91_clk_of_xlate,
 	.get_rate = system_clk_get_rate,
 	.set_rate = system_clk_set_rate,
@@ -527,7 +527,7 @@ static ulong periph_get_rate(struct clk *clk)
 	return clk_get_rate(&clk_dev);
 }
 
-static struct clk_ops periph_clk_ops = {
+static const struct clk_ops periph_clk_ops = {
 	.of_xlate = at91_clk_of_xlate,
 	.enable = periph_clk_enable,
 	.get_rate = periph_get_rate,
@@ -633,7 +633,7 @@ static ulong utmi_clk_get_rate(struct clk *clk)
 	return UTMI_RATE;
 }
 
-static struct clk_ops utmi_clk_ops = {
+static const struct clk_ops utmi_clk_ops = {
 	.enable = utmi_clk_enable,
 	.get_rate = utmi_clk_get_rate,
 };
@@ -694,7 +694,7 @@ static ulong sama5d4_h32mx_clk_get_rate(struct clk *clk)
 	return rate;
 }
 
-static struct clk_ops sama5d4_h32mx_clk_ops = {
+static const struct clk_ops sama5d4_h32mx_clk_ops = {
 	.get_rate = sama5d4_h32mx_clk_get_rate,
 };
 
@@ -842,7 +842,7 @@ static ulong generic_clk_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static struct clk_ops generic_clk_ops = {
+static const struct clk_ops generic_clk_ops = {
 	.of_xlate = at91_clk_of_xlate,
 	.get_rate = generic_clk_get_rate,
 	.set_rate = generic_clk_set_rate,
@@ -967,7 +967,7 @@ static ulong at91_usb_clk_set_rate(struct clk *clk, ulong rate)
 	return 0;
 }
 
-static struct clk_ops at91_usb_clk_ops = {
+static const struct clk_ops at91_usb_clk_ops = {
 	.get_rate = at91_usb_clk_get_rate,
 	.set_rate = at91_usb_clk_set_rate,
 };
-- 
2.53.0

