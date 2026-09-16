Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B498C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 22:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27B6D80EA0;
	Wed, 16 Sep 2026 22:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbNm_Z0Vp6dx; Wed, 16 Sep 2026 22:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9B35480E79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789596858;
	b=bL1fQjcm3GMy1gb7aRf9KlU2pKFmI2hBIifeNfCBbA+lChqtsE2BnbLivCERrR16H5am
	 yfy5e3cNs4U7ZtXXPdKUe0Y86s6zb1JS+17IWgSmeauracpc9EeSOVyPzqeGdx5ZJVI5H
	 kzZ6ozhjRCXkGpuT+dDLJZlMrqYAyUVvcJ49h6HfEzKLyklLHhypYlTTiogYc4lOVItcQ
	 bfGVPdsss3irZwiEph4mUav5xmBZyiNxk7DzAi+WSFnAtk2azX12a2k0ubT7IhsD9WJ2J
	 f/uDUX7GdXt6jr88P3P2tcudX1LbvJA1I9dAFp1niBUwTtY/Ndgs+pLMyzNTdflxvIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789596858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TT0oK5AyuxFfnuem+sBvdH6itf5tfgHNSa+Q9imqWDg=;
	b=DJylj1U6AFDQ2JKRTvSSitfhqFEFRfjpl5o0QxE9MoXNPDhDPj/Sq25Cjn9zQRKfzHpZ
	 2IdzHdwA9e6xwlrvsj4Rexv/npL4HDnxd40ituau89ZB3DI6ZZQL6M/lo11qAb9fzMSzs
	 BxUzdw9AAPYKI4t4tcqIpvRuPQhXj+SmcJI19RmvZQZWij6rf4Ul3/SpKObXmNhv6+aeD
	 9sfNU70iziz1/CwrAkSpokyRZoN7jEFJkZ39BZyAPe5ZQ9zHTbknDZT4bIhMVL4qKg0Q7
	 dNJUpoz0fWE1ARlptttz7Lguo9HqfIXubIYq6Y4Tyi7pWBSXVswbI2OPAhju+w45uKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789596858;
	bh=TT0oK5AyuxFfnuem+sBvdH6itf5tfgHNSa+Q9imqWDg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mt9iad8XQyfDSBE2dCFJMmiFKDUBEBhsa8g9vNESeawt3GKjmIi5jxUHinDOTXPoc
	 1RDj/CwkEX3fQHBX9WGP2U4QlH9rznYhEeSgnpRqMtBOgFuq9tPGqRe1hVfwTfF+o+
	 ArRbj/SRO2xvNIN9JFQZjzJj5ItT0QjFWc4Q8tt/lRWgW88v81cPAs6GGobhYJG55i
	 9z/fL90hEoqARLhvHPwh12ijO9Z3YfPDrsjyvYYVj581l8HbB/kLNJdCMBe2qQBaXd
	 BJrAd5TVhqo9Ju0NagCZiHs7qaqWL97XK8Iu6vdu3IpbpLILx6z+bSe7mKOHYiYGtv
	 X0KgjagPM8Ueg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B35480E79;
	Wed, 16 Sep 2026 22:14:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDC822E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B38E5405A7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFQP5Jz8WRjU for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 22:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 684C540565
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789596856;
 b=m93pLh51qFcWFWFVUCZSJmXfscb0EAStK65Q8YG1xcQ2x2VsZ4W0/Ibjnf7ZhwMRWDAo
 ZUQC/cbB6JwOG7n4QIIAY4JZiVvY3MEsJPLDAWgvFMj96Ds5/KvjpD1dtUCmnWYxMgjMh
 HgBBcNWo+yaaenO/JOWi6USDbRAtqJKazwLs1dnTvzIeO0LH+Ryg8ECl6xVDbN917GHTd
 R5j+Z5fqsCo1eR+roxOFbcAZbut8iJt26mF97YHqLuMN2nK9Bu6huRdzw6/S/6Pw/GPdy
 siZrc+dBP9IqH112JxZg1XKV7HOaHH/8wASc0Lqoatm3Fn71fyoLprGAT7/sYqWW+eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789596856;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=TT0oK5AyuxFfnuem+sBvdH6itf5tfgHNSa+Q9imqWDg=;
 b=mam+AjREzJ31zhseuJI2M+CjHMnPG56gbygfMcScbWOy6ZTNR/fb7B1zVXMq359g1Cwh
 llpQ9ZmarxWy6hcUsASZc1OhdgXIXP4pR6Qt4fuyzdwTWl93u1yqwnfYM04jmikNaOC4c
 NKAd+yYBFnGhJEw3xs/TodVUkTtySha3i9wuR00IjK4acoHK8fOFPzq73f2WHFgVdrz9Y
 PfIoVkZGHEhZwEssxQZIuIX/QTw6DpbxOlT+uaw2rYOluhsJQ5A8LUy3QRUizQ7DWE/R7
 j6HG2YSCWO2z0xuTONVgccuZg0Hwq6lD41zQLS8o/j+fmgalW7yhdUEKYGVUi8xzQLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=uUNKppz+; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nWJA4g9c; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=uUNKppz+; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=nWJA4g9c
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 684C540565
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:14:15 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hlY8556NWz8v0M;
 Thu, 17 Sep 2026 00:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789596853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TT0oK5AyuxFfnuem+sBvdH6itf5tfgHNSa+Q9imqWDg=;
 b=uUNKppz+6ODfYviNMmi6yFgI//lIbJX1ibUCa0fMBgPpp8Us9nG72wfN+9NtqKblGKxDGx
 iLT0NhpvTkMMG7BJwmil4EssdFsAIVCqxFCj2tr8fLje5XvP63ovecBqubcRXOAY8h/PvB
 lMJX3UQk1JgGFGLD6X4e575gsPsEvk8pew8v7H9veb0LSadceGN9FskNUy0apmKePsbHbs
 hhrpV5FRS1MRqtgFTpJcW5KiSjLZXA8eusryDsZnSHuJ+Nh71W1C4Xlv9ul3UaWalIRfDO
 P9MtLG/3d/R9YFqgbmo10PTUzvlUkAgoOG9Baq6dzE4Wgo7BgmgjG7sAME2//w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789596851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TT0oK5AyuxFfnuem+sBvdH6itf5tfgHNSa+Q9imqWDg=;
 b=nWJA4g9czpMPHivXdHQqsLDCc+kjW3stdE7olJO437NrPU1fy0so8uvRmpg2K+6SIijQyW
 +ek43BxaiPhUCpPTR9FhUG/2QL7V/STow7ncnh/8RFmjFXPTGauGbICHDeBoqROWLNZ12x
 zZ2xjG8EPuO6FCe4z4hyWa4QxSp/asxu3dDu81CYuQpdcTSnM3LIhVTqONOA7ZzeTSND7k
 yfzFiZGl5fBdxBraFuWMZQQkpiyNedA5Cr+ep+J3QhWnbYgcNaeCBtGb+gMLcRPzYV8oqq
 TcgnynQLZIdPag4EUkmdVa+eH9Ld65GNzHlRWkdI8tjA26acaYypxPfGWmnbAQ==
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: renesas: ironhide: Align inline ECC carveout
 sizes with bootloader settings
Date: Thu, 17 Sep 2026 00:13:44 +0200
Message-ID: <20260916221408.252996-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ct1s9xbw7fbuqnhgiyk818dze3rpdidw
X-MBO-RS-ID: ccc1c032bc8e5f0402d
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

The DBSC5 DRAM controller protects DRAM content using inline ECC. The
current set of carveouts follows SoC documentation, which describes the
three trailing carveouts as larger than the rest.

Both the downstream IPL and mainline U-Boot on RSIP configure the ECC
carveouts to the same size for all eight carveouts. Align the carveout
sizes with the controller configuration set by the bootloader.

This makes 1638 MiB of DRAM available for each of the three carveouts,
which adds up to a total of 4915 MiB of newly accessible DRAM on this
platform with this fix.

Making this memory available does not pose a danger, since the current
set of carveouts were carefully set to a larger size to prevent any
possible issues until a confirmation from the hardware team become
available, that it is safe to apply these less restrictive settings.

Equivalent Linux kernel fix is posted at
https://lore.kernel.org/linux-arm-kernel/20260916220801.240796-1-marek.vasut+renesas@mailbox.org/

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index 2dc8ad7aa6b..cfa39f7858d 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -95,18 +95,18 @@
 			no-map;
 		};
 
-		ecc@1a66660000 {
-			reg = <0x1a 0x66660000 0x0 0x999a0000>;
+		ecc@1acccc0000 {
+			reg = <0x1a 0xcccc0000 0x0 0x33340000>;
 			no-map;
 		};
 
-		ecc@1c66660000 {
-			reg = <0x1c 0x66660000 0x0 0x999a0000>;
+		ecc@1ccccc0000 {
+			reg = <0x1c 0xcccc0000 0x0 0x33340000>;
 			no-map;
 		};
 
-		ecc@1e66660000 {
-			reg = <0x1e 0x66660000 0x0 0x999a0000>;
+		ecc@1ecccc0000 {
+			reg = <0x1e 0xcccc0000 0x0 0x33340000>;
 			no-map;
 		};
 	};
-- 
2.53.0

