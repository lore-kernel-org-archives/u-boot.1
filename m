Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118DFCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C61586B1B;
	Sun, 17 Sep 2023 16:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MuDDGWIr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uRbUC4Y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DAF86B1B; Sun, 17 Sep 2023 16:13:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0560D86AEA
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RpVKG5f6Tz9sm6
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0O1g5yT3SWgghJN4L64l9GE3sl/xkpDg50nZ7IMQFQ=;
 b=MuDDGWIrtKBWkGBaV4vD+uvjDgbBaDg4JIy/FtheOXm1zhmGJ3vV5VZmUD3tCj3SxeF0/q
 Ye+/uvTusOlUxGz6QDkY8DgcpcgHfOgqLb+SEcQOCmor91ti0vmV/fsff3gI2St7pRasol
 867vXwaeoPeZOKAx0+heR/Nc4iZDJf8nZGeJETGdeewxWOh1IN32AZeCgvwmTzpeUOyr+L
 5IO8EremOEpTMJl09X5D/777c/DoAyi9jIfXxQv28F6x0IiD8nsYW3zI63USjAGp8lizu7
 cEpb8SXmnG56FN+f5lbHB2x9e9gq5JKEoePThtC7Y7tALk5CpOPwtlpKdvbWNg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694960033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0O1g5yT3SWgghJN4L64l9GE3sl/xkpDg50nZ7IMQFQ=;
 b=uRbUC4Y9ZZ8zOhsskiXd7rmCkogr2bK+1K0j81R6JsG3iwiVK9Pf21sPmraGJ+zLl4bY+U
 Uv+m/Z+0nVbq0fUOmK09vSKxC4o0BnWOXYV4IzfT/UkijPr9eQsX4GSTptwiZD7akcm1k2
 ScWI2NSKIchleH9r5p7Wm2w1fKk+5vJnBRvcyH905ful3dQ6IEYTw9rNHI2wPTyitnY+qn
 bx9KgYAJf9FEZgmVlDlESKv8GqtY5rGN3MAYwe8DODEzwyHkxtUWBhBHW7cZEo1XuGffgV
 Cwa8boOwPNEn8xrww2p7pBslXdmBq10GipH1/814lRpjKa/FOifIXIptGuJvFQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/19] ARM: dts: renesas: Synchronize R-Car R8A7794 E2 DTs
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:13:03 +0200
Message-Id: <20230917141319.379939-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
References: <20230917141319.379939-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cd02288f852914061a0
X-MBO-RS-META: ui5ahjkmmd7ynw6b5ir8mwhrgk3nx9kj
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

Synchronize R-Car R8A7794 E2 DTs with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a7794.dtsi b/arch/arm/dts/r8a7794.dtsi
index 7aa781ff3bf..371dd4715dd 100644
--- a/arch/arm/dts/r8a7794.dtsi
+++ b/arch/arm/dts/r8a7794.dtsi
@@ -955,7 +955,7 @@
 
 		rcar_sound: sound@ec500000 {
 			/*
-			 * #sound-dai-cells is required
+			 * #sound-dai-cells is required if simple-card
 			 *
 			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
 			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
-- 
2.40.1

