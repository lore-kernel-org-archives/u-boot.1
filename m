Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED2C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27ACF80BBD;
	Mon,  3 Aug 2026 23:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J2Jt3ckxUYS6; Mon,  3 Aug 2026 23:31:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A769280BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799880;
	bh=4xA8Yqhs2ZTC/Up2tnMnfwqMVEGsAOH9ueUeVdbBrg8=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qonB8UujGFmJ3E+MUzkZXXlrUYOAY50ZspPx3qdyTZ5IxnDIW+ANmKfwmhDOMSW4w
	 nCobnWKx7txmTL643CkH4PKreAc4dD5DFzEFnLCXI391hWOa5ds/VjIIzZ4C8Zn+kH
	 3zMvEz9nXrxaP2cJNMiFSJgQtmpTXB1gfl9rL0H2mkOHOATr8Vh+AE+zOsbzme3NUp
	 U6JueiVRbKbLglTU92DHZXk44MYV+Wiukll90snnhgRATB8DEcLLWYMipsA8swQU56
	 z0s3qZpOrNLUH6PSyd2Z+acfahM7hJrbAQhVoyj7lx35jgoBN/uhLBm1bFItDyDO9j
	 2tTtDlWdkvGGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A769280BA2;
	Mon,  3 Aug 2026 23:31:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB3A5194
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8B5F40195
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nOLJx3lJh5OO for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9BAD0400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BAD0400B4
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BAD0400B4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:31:17 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hDXxH28fwzMlGg;
 Tue, 04 Aug 2026 01:31:15 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm: renesas: Store env in HF on R-Car R8A78000 X5H
 Cortex-M33 RSIP port
Date: Tue,  4 Aug 2026 01:30:32 +0200
Message-ID: <20260803233104.391908-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260803233104.391908-1-marek.vasut+renesas@mailbox.org>
References: <20260803233104.391908-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 66e4740d311eff2baa0
X-MBO-RS-META: qsd5gpqdhgi71egwc5ryf8kta5ba1gim
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xA8Yqhs2ZTC/Up2tnMnfwqMVEGsAOH9ueUeVdbBrg8=;
 b=iY4N6abA/m92TvfRF5g62u3cVyA7iX0JRUZIUp3MAhMlW1RFZ11yZ1WAhtJin8KxAZfvQN
 pLKJnXBh3eqzLP0/1AzexZYZM8InUE6EqjN0blpag0RZRzt9Tj5Yfnhi1SSTHTs9CcZl9f
 eitlsCm6vbkojBM86zELoEEFOqjUsXVOhCfCGpy2XsfxRK1YMQ7Jm6BNHyjVS86z1aWnnN
 qnHN71LWOuu337JEIWpkobfKWP47+V+JureUSEd39INzHv9FiJF8pcAcu3mINv4596TtKY
 Xf+im6XF8FCVasprMW9sakzm+wgIVnmdt6NoPJUN6pRiiw1NbvtFJoz2K5ttbQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785799874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xA8Yqhs2ZTC/Up2tnMnfwqMVEGsAOH9ueUeVdbBrg8=;
 b=uNykS4KSGyyoyA3RZYYkP3tcYi+u6fZ1CUHJEOWCeZcJ7EzzyxeEPlvJr46N5TRNBVur0B
 Osx2P1A3+reL0VGD61W72edXC19xsjBvuT3JYoqweCaqLHPVPKF18kTj1sykwCzV7dyZRj
 hkRXzKgAX8VihyqJrhd0qFDYLEsVCNoJ1c6yrWNnn/4nPrXlzauQrsOFnLe0mflao1XluM
 EYKu9bixtZaYF2yUv8P7pKLp/SeU7Yg3S0SgLZy7k0ows+GMdWQxqkx0geQ1fJ9iBXG213
 3wsdPII0Q+IDpfEEwgpLUIfd0kZ6wjMAiQMyFyHuTCsKl9WIad3oGMlmELPT4g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=iY4N6abA; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=uNykS4KS
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Store U-Boot environment in the last sector of HyperFlash on
R-Car R8A78000 X5H Cortex-M33 RSIP port. This allows the RSIP
port to have persistent environment, which is very useful for
development.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a78000_ironhide_cm33_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 32998a98028..618712385ad 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -33,7 +33,13 @@ CONFIG_DM_DMA=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_DM_MTD=y
 CONFIG_DM_RESET=y
-CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_ADDR=0x37F80000
+CONFIG_ENV_ADDR_REDUND=0x37FC0000
+CONFIG_ENV_IS_IN_FLASH=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_ENV_SIZE=0x40000
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_LAST_STAGE_INIT=y
-- 
2.53.0

