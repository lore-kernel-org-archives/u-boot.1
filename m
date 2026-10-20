Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C660A2604
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 06:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fhXD8Axh;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=h0v1LSFa
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 261B960802;
	Tue, 20 Oct 2026 06:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kskv74vW5hRB; Tue, 20 Oct 2026 06:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E6E3607F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792478246;
	b=PbPh8bBz3BRv1MxdK+YrkHiqv8Qbw7wdIUF8PYIkQ8Avd9bEf+tkeMD8Mk52v967yv/L
	 hB/cwQM6ph6zYM5eFg2y7UK10ytNqcYzpM6uw4gboNd+KjC4Jn+MDBErY7pdYAXR0+kXE
	 Jffo35wQ+TAjdpFn9Fm/P00jCj+Aac1kegrkk7rZ7BFMPq/beE0pwUCqTVfMhE5RK/Ynf
	 h3bo/+Qu09/MEYSjb5Or92ihjITv7UhqHICbT4NynWfMJRo5x0kUDA0FajUAMD+KbaEmT
	 6hD6khFzmgnzkXYzcXTvRZG7uOqVnyFerrKCbhjoxG3qGf64HHYnID4KbI4iGawDAvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792478246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qFBE7KN8VLlYFPITA/evYUVCAfLpF/CA1W3pz33penM=;
	b=klpzFsgk7SPncHWQi4elV30yRaonCVEZGa/AEJe4PwCrP7I7lM71Nn2eDEmF5ZsnVgAN
	 7TXNn0iEqIp404oinH5O/1NTw4VuXWihQaxc9CkmkiNhk4YdXw3gwC342o2qbRtmbwtgZ
	 YCRup6c6VTUAagHBTf02qKSCVC92APBDJHP8XacoMA1BTNxFjQhzwVI/U01pnz5M2JPca
	 u6vRUQ76kpsTY40NOwAKrXJrBD5ffSkPCynwKJgphYqjbZRe5xcB2Iwiu7W/F/kbEux4K
	 sxk4JIZH57VwuVuHCW0IQW2Tc4dX7X4n9uPE3Xy2iBcMcHYPr4pNZktZBr68LnegGXw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792478246;
	bh=qFBE7KN8VLlYFPITA/evYUVCAfLpF/CA1W3pz33penM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fhXD8Axh5t3aACTUo0LogH3Y2TG7jOOVm0pJa8J7DoHaCDO5MbHZ9orgEGOuwxaw4
	 qVtd13UqKgUGqk/0tkvxiBi3w4MuPoay9Ff6mEDUkWkdVEfZw+E5bcZDJYzd7lvOxE
	 C7JLSi14Bv6aVLP9k38ey4Rj593EVN8SBhmEgyQYMTZrL+bugqxBw/K20KegiHkXjk
	 PIWKoZrqBwkrrYRzHqTb3zG1oBLq3w59bBJm+LfiFXoEiUVXz2OuhaCVpsWERMQqcy
	 3JrUzWHLeZGu/m2FQTKRMyCTjqNc0KichPGDvBe6hD6lZYYCNziHH5yAqseyp3OF4q
	 J9BXGdYDyo5mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E6E3607F6;
	Tue, 20 Oct 2026 06:37:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E786F3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6302C40812
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPWp7fQk726d for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 06:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3022340800
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792478243;
 b=KRjWEADXX34XdoNpuYsNLJtF9NiDONMUmQmUQLUuhEwQ/AOZUVmADqXjg995WwviFONC
 nnttE92udQu8+tw/UQn6WJToC8w71j19dOEObCEvimrOqOWkn6gBc3zeJliRU2u/mT6J5
 28BPVjhmsR0xe3P9THowsR0j/X2FUg3fbLE5MVuNycw/X5DP4rT3QHqRBc47rx4f5Pkrj
 ZP793KlhuaKYcrc55dHb/uiExC6VR6eFkklvBFGyb+0Ghl7N6yCkzkIJ0j9+SQWcJJ26O
 030mfeZ6bJ/dFZTx+A8P8D/AmbKyvT313h8JW4LpyESdovjbGIrkZskiLs19zHTdDgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792478243;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned;
 bh=qFBE7KN8VLlYFPITA/evYUVCAfLpF/CA1W3pz33penM=;
 b=P1nqRz0+pff5DDJczTdM9fbY/xgedvfeB57UCbmyxhLJGJnghPD1c+613wKMwgFzFJWY
 TiXTDdSjiT0Fu4Cdi03iJQLR2NH11NbmUTt9OdMwWW/ZOJ4lGfkTCIGz1TWXGCizukVVi
 8/SPdJd/pt6CtkUh/s/Fdm5+CCvtpamMs7EgJ4W9xakYLbx7vSOFUaOhHucUBc5KptOdK
 5J/hEe/gQgE8E1Zg1g41SIPciEEDpK+iNDJ4e/m1LWdP+p7MHXWEJeD4BbGqeThOjCDa6
 l+kcecIov4EvMuRkhd5UI/fk573RX4UOfftaAOkWKnfz5fUfiyimQwA6ljw8VeTYLZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=h0v1LSFa; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.stein@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=h0v1LSFa
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3022340800
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 06:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=qFBE7KN8VLlYFPITA/evYUVCAfLpF/CA1W3pz33penM=; b=h0v1LSFamygWpyw6uz4S8gQZFn
 q9PYpFqkldUIvGTVCDwqgfHjziuvv8wHNwvY5na/Ni1eirYAy1gAPt7+QGBQeOaeY2P9r1UhXGTCe
 sTdDFDDBBs3HJ1dPOP4ghOgRwN/ScLlr4WHtq1HV3vwktXxzRJsG2xMIQqATrl0h/ziJGWbUetZtQ
 5EA+TVdZstdeQTrqt5rykXhe8tLd5EpNkj03WBl/sJ41vTKnpX5varDZGTRk7cDg7kfbmbHYod+p1
 ppYjXiZ7FQnjTFFD69MTEwS7eti8TYUTAqwzZj9T4xv7nRnORYzQPsYnwrQpte3oSgbB6fW5bFUQb
 zYS5kXUg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xJ3TL-0002MO-2r; Tue, 20 Oct 2026 08:37:20 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1xJ3TL-0005Do-0b; Tue, 20 Oct 2026 08:37:19 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] imx9: native: Add missing UART clocks
Date: Tue, 20 Oct 2026 08:37:13 +0200
Message-ID: <20261020063714.694164-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28158/Mon Oct 19 08:26:01 2026)
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Only clock for LPUART1 has been added to init_uart_clk().
Add the missing clocks as well.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/mach-imx/imx9/clock.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index cc0a7729d94..ff31cc0fc40 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -592,16 +592,41 @@ u32 get_lpuart_clk(void)
 
 void init_uart_clk(u32 index)
 {
+	u32 gate;
+
 	switch (index) {
 	case LPUART1_CLK_ROOT:
-		/* 24M */
-		ccm_lpcg_on(CCGR_URT1, false);
-		ccm_clk_root_cfg(LPUART1_CLK_ROOT, OSC_24M_CLK, 1);
-		ccm_lpcg_on(CCGR_URT1, true);
+		gate = CCGR_URT1;
 		break;
-	default:
+	case LPUART2_CLK_ROOT:
+		gate = CCGR_URT2;
+		break;
+	case LPUART3_CLK_ROOT:
+		gate = CCGR_URT3;
+		break;
+	case LPUART4_CLK_ROOT:
+		gate = CCGR_URT4;
+		break;
+	case LPUART5_CLK_ROOT:
+		gate = CCGR_URT5;
 		break;
+	case LPUART6_CLK_ROOT:
+		gate = CCGR_URT6;
+		break;
+	case LPUART7_CLK_ROOT:
+		gate = CCGR_URT7;
+		break;
+	case LPUART8_CLK_ROOT:
+		gate = CCGR_URT8;
+		break;
+	default:
+		return;
 	}
+
+	/* 24M */
+	ccm_lpcg_on(gate, false);
+	ccm_clk_root_cfg(index, OSC_24M_CLK, 1);
+	ccm_lpcg_on(gate, true);
 }
 
 void init_clk_usdhc(u32 index)
-- 
2.55.0

