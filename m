Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C99C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B7B8780BB5;
	Sun,  9 Aug 2026 01:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ACwNnMkC62o; Sun,  9 Aug 2026 01:31:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF2B680D6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239101;
	bh=16Gp3jHsI0I/HzI0lyRFQvGcy1Sn8bztlvgGF43xaPo=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=JjDNhDIlakeO/C1ETAmKwUa7+nG5M/kNnnRNB4YF3CJxlDADS2ku4T6f7RPJRdZbN
	 6a8SabhlCGHGeZRoGdx+4JnltncHho0dmghzQhQMP0HU/uapH3JhvJoLpfo1QzDgAE
	 Baxrm7IkRooTkP7crL5+oILrO6Xg6IqN5SwCABaUlVWqPdWgbxqRORPCFxhZktI0r8
	 0SZukRwWaegcmHVQ0MPhVhiJ1N98zE/kdNmwN/+NkppA2SKX33WK0sLgspDcn3qG/8
	 veXmVuoK8Eq0cNQwF39lLDeSq27595t4P6OiWyPw6VwNyu94PpPzZ6w6pJHrYGN407
	 l8Bx5kAl233GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF2B680D6F;
	Sun,  9 Aug 2026 01:31:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 84BED2B6
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7677280BB5
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLE1of08Gk1n for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:31:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B202E80B53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B202E80B53
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B202E80B53
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:38 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgMr3VMzzMlFZ;
 Sun, 09 Aug 2026 03:31:36 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] arm64: dts: renesas: r8a779g3: Drop generic SPI NOR
 support on Retronix R-Car V4H Sparrow Hawk board
Date: Sun,  9 Aug 2026 03:31:00 +0200
Message-ID: <20260809013130.444086-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mpc4r1cegngexdrf64m9uu3wr4yd1mb9
X-MBO-RS-ID: 026512f71e674f8e199
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=16Gp3jHsI0I/HzI0lyRFQvGcy1Sn8bztlvgGF43xaPo=;
 b=inHxbH9oEPaKKvk8tYwxw7DSoyrMpD2mjJBZwcahziiOFxrOk86fJZ7Sixx5CTeng1vvZi
 hPEAhjr0M+VprPO2+HehPHoiHGS9AepXQgN077/wKMuYfhaYCkznrjSw2jvcvCI3MFkH6y
 bvz8ktdEtjH0gP/G6miMcLHqA7aBW+MrvA0Qpdxqee9cWXBCNa7G/UZ+yNyygMiPjIU0eU
 b47ycqA7fSGAB8zJwJT6lGJI4VlHjDd2hOO7NFePb1bIHbySQZDTA06PDHgwq4LOtq4cyb
 4v/JH5/fDWMVtGtyG/bYf5tibMvwWEcPLUNJ8Qcg7rqQRbxPXSvQjAyf7yMxFw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=16Gp3jHsI0I/HzI0lyRFQvGcy1Sn8bztlvgGF43xaPo=;
 b=gA9sE8J3YqjCCcDa7neYV1Qit3OANKKVZoOS/vU1y6i8GJ/pSxzxC/TKKBLm47xgAZJS3x
 cxopPT0Z3EL503xCjI83PeDbp4Gk10cXr/injdtHaoff2SMh3SifLTXJZujlC+/UgwyqcF
 OJZbs+WTxisfm6g2blGQum7z+ZjzHTOXtIW+06Y3sF2B+QsM8cqnBHoUcmd+aN1lW9nRzH
 vCocmSD913TlfeQapsQgrAJdq03nv6g4tbWIrrzf3OZPI1Ol1vbnwfPUPGg3c5PHIdPu6f
 s/IWRKaLpAuzemuHwZ1XPbhYgzBQB4koorC+NaA4iBS3aI+k6CVtH6N0frm4HA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=inHxbH9o; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=gA9sE8J3
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

This reverts commit 797255d897d635799fbb878262b7491e07ceac9e.

This change is part of Linux 6.18.y DTs as commit
95319aaa3ffc ("arm64: dts: renesas: sparrow-hawk: Describe generic SPI NOR support")
Drop the duplicate change from U-Boot DT.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index dff0355150d..cdf5c9cdd64 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -51,11 +51,6 @@
 
 &rpc {
 	flash@0 {
-		/*
-		 * EVTA1 is populated with Spansion S25FS512S
-		 * EVTB1 is populated with Winbond W77Q51NW
-		 */
-		compatible = "jedec,spi-nor";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
-- 
2.53.0

