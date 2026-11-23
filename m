Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82F606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PiBCh6tY;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NXNE4Ht0;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=n7tueZyC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7292C406F7;
	Mon, 23 Nov 2026 15:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LETW8qDirwm3; Mon, 23 Nov 2026 15:07:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BFF414070F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446429;
	b=WRI22+g4MDjGorNVzr9UlBvI6f21wUrpw0RZrPHRsZ2gtvz3C3rIvAFSTPEiwTpqZJ28
	 vx6BtPhIGhpGY87RQLW6WfVhurPS4XX665U+yHFYJarlBejU6Z135kRs62rRjjUEFkYcb
	 1410FhDp4YmNal8fkwLO1HDtTJdmY6n9mAB3KHZsPbUlts4yDz0jwNzvHcUGynnHUaUD6
	 y+7rAA3NeD7BYmsk09SualZ38tyX5cXW1DynQN/yO+WtkZBAYXSkKIf1ZhmCdzoxh0pfA
	 7DDxyBp37UdVXVLOZIjEm8oCt66Kl3w0nGvpQBZ5p2pNSA1LaxSn9KGKLDIgEDQFzbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EW1tMJMkLRIOfUQIzKURbXCtoOSa210BnHWBkxS07xA=;
	b=KApTw7v6QrYGI/AuKimSB7tupGqRUjEC63Fwa3kLBjG6DYtbpYY9l9DY3DJsrRitD1AJ
	 /Rpo0p+A+8ZrzDwoW73MedMDHxdyxTJLCZqqxxe68VA/XmqLuoXDBvyZGpFGYpLMgpGPA
	 K8KzxfI1u+5YNHm3cLnOmu6hG5IEBtnDpSW9xi3DURgYalh1vHpFLpj5P+icr9qoVqd5C
	 v0BjZ+HnF1NSqSICDXkSm1TYZqM6Ufa9mxd33E4MdT5hmF8maENV94hOs9M24V/Xa9vFr
	 uMaXLan0W5Leq64/ZD7FM/lpIqglK3nqKx93bHw7pZEQhGsSvWTP8lOFcuhjbBt/4Sw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446429;
	bh=EW1tMJMkLRIOfUQIzKURbXCtoOSa210BnHWBkxS07xA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PiBCh6tYq2VKsaE03FfKg97rxuOdGryx+JDVH4l7sdYJ4zIrETvoNSmJKfxdgljrn
	 9a11UivArOUYg3Mz5JJXGksVpe4FIIUBBYWjPaBNuRcVbAkbUXWcpMyicuWDHHckb9
	 4iyKQDoXdTTi2yi9kniYBL0MAwuoX/Me7SE6l4Nq30CcQdcmY8tPViyx3Trr/pDmFg
	 YJj/DAds56WDIkK51VNeITDIhjCxMTAAq0wU9eEzUBPaEMcleJYRFSnldlhJflgJhk
	 iFUtgNJjJ4gRWKbxn02sSm13DP84ITuIDeqEphfbPx1fzGkalYprlG54UX7EW4rPgZ
	 PUz1MyBV7Ec6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFF414070F;
	Mon, 23 Nov 2026 15:07:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D72F01AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C807D80DD6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VY2oHXPCZksH for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:07:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D9AF80DCB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=eede=jn=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=NXNE4Ht0; 
 dkim=pass (1024-bit key) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=n7tueZyC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D9AF80DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=fe-e1b5cab7be; t=1795446424;
 bh=EW1tMJMkLRIOfUQIzKURbXCtoOSa210BnHWBkxS07xA=;
 b=NXNE4Ht0vbugrr9SJaP6seetPyEFgASoaeTioBYRpn/xUuti3HdjikffHSxNxMb8VgmaavjLg
 gEnQLHYHuT3Z3GrC/SjnJ8Gsh+a03kibjSUWaRFUWUIi68TiQBerl3OchRN836/Gsxce8c7ZFdM
 JEWML9jkQejfDEG3P3hZNdNudD+mloj91AEwLZMFFn92pNVjkusJpBnRWaSRIusi+/tg96gmOlw
 2QBk7TR10MamKCATxJbCa5AjjzmgF3AHGB4Tja9zxvQqNDh57bed5O8suMoBUagzRe5TsU7S1Ne
 e/24bse65aPRGYiuqkaQgLkQ4zHH4NtIBbHKCsVBffMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From: CFBL-Address: CFBL-Feedback-ID;
 q=dns/txt; s=default; t=1795446424;
 bh=EW1tMJMkLRIOfUQIzKURbXCtoOSa210BnHWBkxS07xA=;
 b=n7tueZyCwSJgnj0hBKvMyXwyWLobCK/AdoK80ONqtvKn6oLrYXKq5RXFik/ggIG+qjOY+C5Fe
 O5ZPL6PE7KdLZd5hPCOuJQyzq2SxDqg83V/t3xvQJXgcirtOmI43mRnV5wBL+4/N2h5MNvdulir
 elYuF4MfcLoqv9mECjBxt7o=
CFBL-Feedback-ID: 6b04569731d91c9369aee18a:80e4feee3b419c95d0b2cce76a28ac68
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6b04569731d91c9369aee18a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.37
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] rockchip: spl: Fix use of ROCKCHIP_SPL_RESERVE_IRAM on
 ARMv7
Date: Mon, 23 Nov 2026 15:06:52 +0000
Message-ID: <20261123150655.1397175-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123150655.1397175-1-jonas@kwiboo.se>
References: <20261123150655.1397175-1-jonas@kwiboo.se>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Traditionally the SPL image is loaded to start of DRAM on Rockchip
platform. However, vendor OP-TEE or TF-A blobs for a few newer RK SoCs,
i.e. RK3506 and RV1126B, are expected to be loaded at or close to start
of DRAM, something that would overlap SPL.

The IDBlock v2 format used on these SoCs can instruct BootROM to load
an image to a specific load address. However, mkimage currently lacks
support to configure a non-default load address for the SPL image.

The Kconfig option ROCKCHIP_SPL_RESERVE_IRAM can be used to create
enough free space at beginning of DRAM for OP-TEE/TF-A to safely be
loaded without overwriting SPL. However, this is not working on ARMv7.

Users of ROCKCHIP_SPL_RESERVE_IRAM started to be removed with the commit
5ce94c74a6b5 ("rockchip: rk3399: defconfig: no need to reserve IRAM for
SPL") in v2020.01-rc2, and since the commit 49f8131e5594 ("rockchip:
rk3399-gru: Use TPL with common bss and stack addresses") in
v2025.04-rc1 there is no more users of this Kconfig option.

Move the .space statement prior to the _start label to fix use of the
ROCKCHIP_SPL_RESERVE_IRAM Kconfig option on ARMv7.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/include/asm/arch-rockchip/boot0.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
index edb2a31c3481..eaa49635d9de 100644
--- a/arch/arm/include/asm/arch-rockchip/boot0.h
+++ b/arch/arm/include/asm/arch-rockchip/boot0.h
@@ -44,6 +44,11 @@ entry_counter:
 	b reset
 #endif
 
+#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
+	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
+	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for TF-A/OP-TEE */
+#endif
+
 #if !defined(CONFIG_ARM64)
 	/*
 	 * For armv7, the addr '_start' will used as vector start address
@@ -53,8 +58,3 @@ entry_counter:
 _start:
 	ARM_VECTORS
 #endif
-
-#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
-	(CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
-	.space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM	/* space for the ATF data */
-#endif
-- 
2.56.1

