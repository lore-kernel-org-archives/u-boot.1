Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5685606A882
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=czB7gx9d;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pqckRfLG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9805605B1;
	Mon, 16 Nov 2026 03:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpALSHGyr84C; Mon, 16 Nov 2026 03:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C696C6060D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794799449;
	b=hxxICATbDiVwtGavEufvxSpo80k0PT+VHXSl0OHS7L6EJSBL1hzcJNMx9uzUikPP/dwc
	 OmlJw7j8T3lWWm/FFYYZb416c+ixzpLgzJqeuiWEFV8yLzvf3hbxlFdvaVb5/AuZ4QlTM
	 TA1Q6fDLZkZgP3dpAgrkgmUtqHkcog7qCVq5UaUwK+2yIlcwdqhnuSI21zkhYIVut5cD2
	 fwjmGR1UD4KmpaF+PSPUUCh5uCGzXMTwPcdfOhdioCbFLq81cnGsubs3CasVm8/7KZLIC
	 7qnswNhDL9Ch/tHVnq7OQEuAcyk1KubCWt13CcUtip2hl2aI1sMcetSve3xVyVoX+Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794799449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YVHMKnMrJg4FDVGBtogczf9QTQm2U3XoSTnu1a2Q+9Q=;
	b=ffM1S9XHiTtmDHq/mvrF/N+PqWlAMS0TCBaZqvGA0CoHA+D1vzIdXnBrVwwSBlK5drPV
	 0GrdjfJ5VRKK+NULr6QC+0u/sD4W0o3krUXionzYOiKruLNj+TFrf4fIe50mC8ezuREld
	 oJ2viaoV6tb+hdGTWAaFYMPfylucT4FGxOjhctoEE/oYoJDObtDGhgX5+D+Y4MAuXnrUP
	 +McveplrZmvTYyDFhqXOD2s2MGqxohw5QICgUHW42rW0WpIHcZI/8w5fBiNZD6RoSFNcZ
	 yCblU/PQ/h7LqrOiqH42xzrztQry5aVIhj4G7K8HCPEChPn6rRUtpQGrhi2sgF3Re9w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794799448;
	bh=YVHMKnMrJg4FDVGBtogczf9QTQm2U3XoSTnu1a2Q+9Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=czB7gx9dkrvIx+fjobE5V1LoCuo7ngcUF+66a0xNaCAQCcp51HVhiKwUw337PtfKb
	 etcCAszCpIxn9RNNwfnet6A1VlpcgJ+9QoKRNlYz7htjMjVATp0Rvx6nD0nhcgmvKP
	 Vez1VFlYOOlsnY+lwOr3lN30SZ8EyWJ3iIOPgH48fVlTh8/cTqpBptHzUf6Ri073Ok
	 R4VK/pWTQLfPfd2LD9dP0MJTAHZP/KwuRkoHBsKXz4mc2Cd3kqqDQiBg5VbN5vaasL
	 p1CQPrXTRp27uGl8F6TSnNq/OJxmFfJSX8AoRX7L8FiwXoC5m3ZKAxauPavXcceZBH
	 YAhGC9Si0/WmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C696C6060D;
	Mon, 16 Nov 2026 03:24:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D9881A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 101274008B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kUAvqmxI7_0x for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 03:24:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1796B40012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pqckRfLG
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1796B40012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:24:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSY9v6F9Fz8vBb;
 Mon, 16 Nov 2026 04:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794799443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YVHMKnMrJg4FDVGBtogczf9QTQm2U3XoSTnu1a2Q+9Q=;
 b=pqckRfLGfFRGTS2OV9zeDwrosn7CqW6bD4lC74DJjUb4CQcRuRWKIQbHhDg0rF/NL7wJxy
 cGTlGGNHZpX7ME9iRvY2Nr3NgYbaRe4jCGtkgMiYdGYD/EXTRPNgzzn+FURBMB6HIg2gjN
 48NUAFWG0BuAYcE6W3yB87aE7CDml/+iIrsHOm4zMPdEdFVXetfp1FpvzCKE+bHXIJhJxL
 SlPVXXgLCZq9vIDd3Nvi7jH7cdTVWylVnSE6ptCZAGmxiOATd16uYGD4VyCOvYnMs8WIXe
 WEbpqjMMK4D/sh9kQErAD2+slbQpfCiOah7tRuHztjeJSCCqwHfy7+nQdD02Sg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: r8a779g3: Set counter frequency on Retronix
 R-Car V4H Sparrow Hawk
Date: Mon, 16 Nov 2026 04:23:53 +0100
Message-ID: <20261116032401.3144569-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2f245441a77250cf97c
X-MBO-RS-META: r96qzdmtu44zfw7w9nawrb4x9cnc8dji
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

The counter frequency is currently set correctly only for Core 0. In
case U-Boot is configured for multientry, then the counter frequency
is not set correctly for the other cores. Set the clock frequency to
16.6 MHz for all cores to assure consistency.

This currently does not affect any existing setup, but would affect a
system which would start the other CPU cores using the U-Boot built-in
PSCI provider, once that PSCI provider is extended to support start of
the other cores.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/r8a779g3_sparrowhawk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 8513fe4f040..8c87e1b4390 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARMV8_PSCI=y
+CONFIG_COUNTER_FREQUENCY=16666666
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_OFFSET=0x3f80000
-- 
2.53.0

