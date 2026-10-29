Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DA606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lvRy8cDq;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=FExs/8+/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B66596079B;
	Thu, 29 Oct 2026 00:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N_1hDYns8fpc; Thu, 29 Oct 2026 00:17:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DDFB56070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793233039;
	b=N038qNqjjDbji8rwl2hwo5i6OoH0weRjGk5Ws4y7CqkUaCFrNH0y05BP0UFC0Hctknlu
	 /HW6g+wVlm+JqMM4COV3vPl/KpJ4cuQ3Pnm+XfDbdcRmo8w59nNhnWJ7IdCDvKG+bg45G
	 WXudqdjd55f8wU2dMDMM8oFgjXpFbxbdEUUhmq2rerskgPV4QmfTrY+9I4KUBFqDaZyQP
	 +JJI52jn7+QlvRMFpyvFf58qCn1jqP+h3tG9UE0AR9nvQx4aAS4c/QavoucHLJFnB3ecd
	 Itc1ltcwHCvoIm+W+CCelzQwjOoDRq3rE4RIG/EzxqMXTXlWgyRhJ448hVjCLTJeLWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ubkkcmtBmF7H4a+qBaTjYA2J3JZVIhTQ+x4G9OMnJvg=;
	b=FmcKezXpHI9sCMpJItKad6QtN/kvwoOyIQua4nWD4xcZKmY2/7yuxD/zLSoEXvJAsasU
	 kMM1SHvxggvp71liddN8BZ7aFBNVBP6AHlai9qaUsMxzFmtrV8ZBrQ3cnc7vQJK5rIntN
	 G9vNqKPOwcmjvFkzPovwIFo+xqtOHWETX3C7/1dgpjPF8QgQsoZpMiufRm2qwnSKcikBA
	 Z+vxYkiGIc/mq5nzI1WLmGlRP52UpyK4BWJo032wCTgjT96I67pnQUj8ssQAK+3FzRQaC
	 +hKyJSLMpZSq75SYmZM+gGg3rwUJiyj/wrJqMcwoGKY3hPGvSYo6r2ZS1p2M2cEQm/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793233039;
	bh=ubkkcmtBmF7H4a+qBaTjYA2J3JZVIhTQ+x4G9OMnJvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvRy8cDqq102u1s39xZAh4NHdXZSiNqxI3iKhyTd1NYQYUbfsL0F2jNj0Mq2tYn8h
	 ENi7N07zB8ojoHqujf32R/HwxOXwBE1M2ur70t8uQRgMH71aIcUBwhaL6HLsKn24gv
	 l/ADS8do+q8TwR0vxnosZDoR0KIbColBy0b5oOO0np/SF4/EBgQ7fCyM7s6YHEi5We
	 XR2tEh3MFMOjYHzlaUE4mWsauAW8MoGAwF1d+A7G8IDqilFcu6xW+r0XqTRV5Qed35
	 KCRxMlxO3cViJXNfOmAayg32AzqD8tK7Z5q1puJ+fLTCXlg4aTNmnQLFiBg7nC78Vt
	 6fUPta0VLRNIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDFB56070C;
	Thu, 29 Oct 2026 00:17:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 94ED72E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A546401FD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3Kj-rubeP0q for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9B834402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793233035;
 b=L5Y/RS3UCcHXGX2p+BI8K5mgE7uEmlk4jiX5a0qPJxjIhYfaFMCij75U496bVNH3AnH0
 kpdfekxihR9qcSr8hdIvH9nmLjrW5wkGe7hH+UM06Uhy4T6XHXVayfItK/1MXkxmc23l8
 4kgl5/BP8Us/0bpADCh8HyIKIeq2esmNgQvoQVqm3iOdnKVrXQZQlsCn48qs8m9KUPGyu
 TPfx64Cc+CsN+yzKefAYQ4SlebT5Kw9zz3N16wPk3mrvMqjv+eFwsks8CVCTjoZjXa8zu
 zoAs88hubrLr5qSg84B+WBim8nvWyWnrYI1wPCA+GgloVhiBbfPSTg+/CZmF6/2D9eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793233035;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ubkkcmtBmF7H4a+qBaTjYA2J3JZVIhTQ+x4G9OMnJvg=;
 b=UQxPPAcTY0/Rk4rEcKC9JCw1rMeSIkuAKU6zmQekIsXK41DLMt9Y8mFB2eFgJ8S1QbA+
 +I3JUzSYzhCSArP19FG3cM/mBAWJzjPBCaJ/73rKf95HZnRMK8hO9reJ385faJfzUuXTp
 J+RQODafw9LtPpORZ4SLg7eAGfh1LiS/WG0WIvNGFhM7RaDVVAWxAOf5ubcvfNeHcd48v
 dkUd41MrxTLsTH7lBpd9LaT7qtevurw6YWMfqhHyhx3/GNkP75eBSysqdfupm9FDCNO9z
 SAt4U+PYfkxAVbosmp/TzPECrFJ3cfX35KZehrnOfgXW7ew6UxEQ0ovGPhbRetVJPTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="FExs/8+/"; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=FExs/8+/
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B834402F6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793233015;
 bh=ubkkcmtBmF7H4a+qBaTjYA2J3JZVIhTQ+x4G9OMnJvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FExs/8+/1E3NMklixbkOGiwnv+OCuOIVt5umM9tZZ+gFiARL9gVkxAoKYotIzdj9J
 Jm/6v1JTBtwBoWyZlaeIooVgBffzyXITdPyEi0re9zPaBj2RxjKvVqZVA8PwAb6dhB
 +tGyjc7NfG2MfyHdF807lv4bSx1T+CZcoRVU6qsMC/7IhA7LSU9oRvKcxP2RNUFHEm
 XE2YBp/gKndfjG+JK8Q/yWu8a9ijaeBaCfoIn8gLdpzuYirOnaMWvIxnzr+PJHoPsz
 pzY0r4DSfYMmBIvy7WkpPIN0uMEsNAYI9Yv4o63Ld75W/iSyxT12ibXKINeKh9dboA
 9UtI0JgYMdR2Q==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 60260B2208C1;
 Thu, 29 Oct 2026 01:16:54 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <eshattow@users.noreply.github.com>
Subject: [DNM PATCH v1 7/7] reduced SpacemiT K3 vendor BSP: set uart
 compatible for mainline OpenSBI
Date: Wed, 28 Oct 2026 17:15:55 -0700
Message-ID: <20261029001555.1890775-8-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029001555.1890775-1-e@freeshell.de>
References: <20261029001555.1890775-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: E Shattow <eshattow@users.noreply.github.com>

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.

"The compatible order makes OpenSBI select UART_CAP_UUE and preserve
UART_IER_UUE (bit 6); matching only 'ns16550' writes 0x00 to UART_IER and
stops serial output." from [1] OpenSBI mailing list series
"platform: generic: spacemit: add K3 platform support"

1: https://lore.kernel.org/opensbi/20261028-spacemit-k3-v6-0-01d984f60941@linux.spacemit.com/
---
 arch/riscv/dts/k3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/k3.dtsi b/arch/riscv/dts/k3.dtsi
index 8c374519fcde..88bb60be404f 100644
--- a/arch/riscv/dts/k3.dtsi
+++ b/arch/riscv/dts/k3.dtsi
@@ -259,7 +259,7 @@
 
 		uart0: uart@d4017000 {
 			u-boot,dm-spl;
-			compatible = "ns16550";
+			compatible = "spacemit,k1-uart", "intel,xscale-uart", "ns16550";
 			reg = <0x00000000 0xD4017000 0x00000000 0x00000100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
2.53.0

