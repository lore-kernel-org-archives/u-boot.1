Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2767BC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90D2980DD2;
	Mon, 27 Jul 2026 11:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xqky13LHaTC6; Mon, 27 Jul 2026 11:57:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C794E80DD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153476;
	bh=SDWQaI7CHtO8JyYR05Xz5USx4t4trQCUQe5diotlz30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZ0V3vAi2Y4mYM6UVHgu8K+Dzgb0EYzeyK1rnFeFad9ltTVhvh6MlKeQDhjVAQT1w
	 MWTCBj5R7/rGrV+fHpbk8gRBl4Y6eKrYgf30jxX0vCEnTXr2ywVL4Jz2hojI6QBsXR
	 9wy5VgeTmyF3gxHToVgBxN+kwwGqjGX0azbYoGVhsKruMp+ZP3zAwaEcdlFDb/Arn8
	 pe1mfa3atna5THb3EaboR8ldKYyI5u6sXV42Lr3wcndvWEuUfYSU1ljF9csBX3Z0/9
	 eSo387hlaBbWOPG8Ls4yN4JEJRLIvr/76+AKft4SJTh/NlNj/Jpy4YExhhR9CQvn/J
	 3ESM4pc80H+Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C794E80DD0;
	Mon, 27 Jul 2026 11:57:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 332B569
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24CF7405DE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbCuL9OIZMpb for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1B536405E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B536405E2
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B536405E2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxr-000EqA-0k; Mon, 27 Jul 2026 13:57:47 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxq-000Fh8-2p; Mon, 27 Jul 2026 13:57:46 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 13:57:40 +0200
Subject: [PATCH RESEND 4/4] boards: tqma6ul: select TQ_COMMON_SYSINFO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6ul-eeprom-v1-4-ad1d4e2fa1ae@ew.tq-group.com>
References: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
In-Reply-To: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SDWQaI7CHtO8JyYR05Xz5USx4t4trQCUQe5diotlz30=; b=cvj/Adc5DLGIXVZpo/ooORycdA
 mj8DLhQH2JyhVGhH6ZoYP1aC4B+tEk1J4OWC5ECW23VFW/xjEJUAjjuFQhtFLCe0nNK45MIE55Mxv
 I4pDy0csc3kzFalvqMDRPpb+XgYJp83klw/gnQ6CCDHMT5+4I/CBRZyvhnW5c+Xx0pP3s08zxbWJP
 l+ej5vl/NToeSLX/E6ZBtIMhknCrRsysGKqkIa9fsLrQMn1RReMx/t/jBOf66JpJMK96G7/hhj7eb
 ufZK4syjLEs9MMoruZ7aPB8VEoiwCvWO8QFmYl5km11BQcFCl+tjNDCLDoY7rkWE6CQZMIcUg61RZ
 04W8AJSQ==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=cvj/Adc5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Select TQ_COMMON_SYSINFO to use the tq_eeprom sysinfo driver
to read and print module EEPROM data.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/mx6/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index a38adfed02b..ffcc05e8683 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -637,6 +637,7 @@ config TARGET_TQMA6UL
 	bool "TQ-Systems TQMa6UL[L]x"
 	depends on MX6UL || MX6ULL
 	select TQ_COMMON_SOM
+	select TQ_COMMON_SYSINFO
 	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
 	select OF_SYSTEM_SETUP

-- 
2.43.0

