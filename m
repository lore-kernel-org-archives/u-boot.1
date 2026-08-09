Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88C1C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A44B5405AD;
	Sun,  9 Aug 2026 01:31:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6J1UAOm-L1WL; Sun,  9 Aug 2026 01:31:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C30C40592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239108;
	bh=oqRSVPjXDucNgbOYiTw00dh6WJEgLVTTah7+7FpPA+o=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wMocNMNX0DXZWW/MKh8anrN5nSwkXY6HazuWiduxV6+qlXHgBRhP+iTvQIWEN5yMQ
	 OnFK14QwszBOzle68NmSAwXAYEZe5sBM6v66zoY7RWmXEMhg6kXT+usfoBH4y7MElf
	 TuNT7AejSGt8UbVWgbkAWrrFyGq3T/SBVlIs+cvHF1/L1lR5wjQIDmqzcxQSHIpzZD
	 cWBk+EZVxllVl68rN+g+tdOulJk/xyh+HoXHOn6jTmMfhYNqBQKW4UxFpVKwU9KuvM
	 zmrlJ95JIWm/H8vE3d3Nc0QJKyvFxo2+ZJWh8Sa4PMm9BV8y7fApVlHSDgjYZZkHFn
	 ntc6yIxOZ9frw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C30C40592;
	Sun,  9 Aug 2026 01:31:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F62E144
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76012400D3
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEx3EJy7YGSm for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:31:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DC71540068
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC71540068
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC71540068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:31:42 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgMt6LNwzMlG0;
 Sun, 09 Aug 2026 03:31:38 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: dts: renesas: r8a779g3: Drop set VDDQ18_25_AVB
 voltage on Retronix R-Car V4H Sparrow Hawk EVTB1
Date: Sun,  9 Aug 2026 03:31:02 +0200
Message-ID: <20260809013130.444086-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809013130.444086-1-marek.vasut+renesas@mailbox.org>
References: <20260809013130.444086-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: edsoiswh3gfymmytfdrqwnt4zoe7pr33
X-MBO-RS-ID: d80f013aa89c9dfd91e
X-Rspamd-Queue-Id: 4hHgMt6LNwzMlG0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqRSVPjXDucNgbOYiTw00dh6WJEgLVTTah7+7FpPA+o=;
 b=XoIXP2JVjKSs8QoMv7anKdlEJrfEAkxrV7y54yyHrEXZwHZnLtdWt9aBKRmXcqIt23pJqC
 yv6UlEiSReLGy8Wkpmko5QJo9gt2TMhm4MwRJyYI0aNFKeuqvHbSUYro0K5TeKWjBtFRMJ
 H//G74bkKCgT+fDEDj7bDQ/bKfyPaX9QfC6ui91pXToNAUc1V16jIYgQZx8EzQtiMp8eL1
 CHcIXrD60OTiMmHY441WyaHz7/4PCs72Zp1ijnIQsFlS+MCPP+4lSQGlZ4wTzG2ELUfH7/
 +yhl1X3RDnlQK2EKTx4klVl/3xK3hYNTMhmTWC/36VnkbyDbEvY333Mcy6LpPg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqRSVPjXDucNgbOYiTw00dh6WJEgLVTTah7+7FpPA+o=;
 b=EjbcmMt+J3J4Nym5hre3fcnmRQsu1GjQRNePIqbyl+6zaPvNxobE5lQ5WUkvqyxIPQGkWv
 OgWLE4pi/BZ1/9w3dmUs/MadJFCa89oYKhiyAs+1izBU/zvAE3iWafhpasQzuseP+ZHGbX
 +U/kKfyEM5a9BLoN8S85tJuAnbvnJeCobnOCBdazBs5jgsmVizhwb7XVkS1WqQ5d/u4f61
 Wobm0lYL3o0OJfxevlS6GtZc5eXuNX0JuMjfTVyKPB5OgW8JR6gFzM5YWkpisORjHWOkba
 //uGwirux85zmTWVei4guzWmfIETj5N5Oj+BpMVJDB+scQ4pGtreMQltJgKbhA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=XoIXP2JV; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=EjbcmMt+
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EjbcmMt+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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

This partly reverts commit 1df2880e9512f4760f615668e5d06aa5f44b778a.

This change is part of Linux 6.18.y DTs as commit
7d1e3aa2826a ("arm64: dts: renesas: sparrow-hawk: Set VDDQ18_25_AVB voltage on EVTB1")
Drop the duplicate change from U-Boot DT.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
index 53c1be3fae4..c9f302799f1 100644
--- a/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi
@@ -7,13 +7,6 @@
 
 #include "r8a779g0-u-boot.dtsi"
 
-&avb0_pins {
-	pins-vddq18-25-avb {
-		pins = "PIN_VDDQ_AVB0", "PIN_VDDQ_AVB1", "PIN_VDDQ_AVB2", "PIN_VDDQ_TSN0";
-		power-source = <1800>;
-	};
-};
-
 /* Page 31 / FAN */
 &gpio1 {
 	pwm-fan-hog {
-- 
2.53.0

