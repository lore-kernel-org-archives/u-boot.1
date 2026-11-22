Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01110606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KhCCpgvT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHpKwtQj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF7A960611;
	Sun, 22 Nov 2026 16:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52ZbmFwkl9hL; Sun, 22 Nov 2026 16:50:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B16276060D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795366212;
	b=H+ZPLY86WMpuxmT8Vi4a+BhlrXcTy3Hx7ismdq/DIF9KegGhcztLjot1kNSOqxj3GxqH
	 PVqvA2ytSjrr12SPKsCNKFpJaxJWIDhjuWLyHz1wf/CzUvvNtpY9/tUQDVaxIOqZL2RqV
	 Z211BQZz/mcPxW2++slsuWRJjcT+rpTeze4EdjEStAbxFGZDMhWtEQYARQAcbq/96+l66
	 6Vai7rgjzqpPKLW1j6TZJdcG0vZqSJ+5mWQLGhMdQVXzLeXkNlYA5iO4aqSUGovqbyy/I
	 OJBZOwMdMWtgNM2Su51UkmPrDQv40Fk0flJ9pjYmc5aaDG1idOcM6WsKrc3Q3V+YNpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795366212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=/9ohXBpf1Nwf39QPdWWgrLMutGh/Qy1uOyI0RwU3ldc=;
	b=CxvWX6Cv8YGt7+pbyVVlUN7QlQZtLfH5h1JgBqHPibz5Pf/9N+OJbKqudVJPUimazPCy
	 KycZuodF3me9JwtzhWODtvXnl26r2jSM+AoO/cxVpf/Pyg4fWDUbEvMgDpC21YNNARbuw
	 vPZ9GDFZi5wQ3EFdi7ouULiDpYi7m443hLxAfG4FPAOzERnQiIkw1vbtdq6kM8H8DbxW+
	 kIwF36c5nSwbctZdjkKMwL97mw7WMfcJOEZast0rlabH6LlFdWpBbqVP3GGKVvhv4FM1H
	 CEmTkpFYLDroG2wW2jmxs0ZyuXxTTvFGcQJrcZ7jrdrnRaSRftGORiW7LemISh53r3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795366212;
	bh=/9ohXBpf1Nwf39QPdWWgrLMutGh/Qy1uOyI0RwU3ldc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=KhCCpgvTXXZeWbZvEN28gqMIF2kSjCYd9V8WsaFF+Tg42O8X9sSoyemSYcW0RmypS
	 es7UCthC+eocUIgY4gqKtfuHg6r+ZzWGQ5rOfuM+tjX6EIboocsEnWTZE3MOD9jp3l
	 ddSmYpeOeBxzigzHwwWpeR3xHj24AneKbRB2/68h7l0zDuyzYeswMplOiBNTMb8QiG
	 wC6I6uwV13y1LOFqtubW9LD0W63lZwgdidYMIOYAUCkHNrH07WaLtBN7pkqzlccUcN
	 lsQ6mBv0Z7EgKbJQIJQ/NYFPWjSzBxIOyNMURurOVBBXpJfT1GlPLhphxEnsiEq1W4
	 enVjbtA2D4BtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B16276060D;
	Sun, 22 Nov 2026 16:50:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A42B722B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9628B80BCE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:44:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C58tqr_O-gdE for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 16:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D0B080BBE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+jerome.berclaz.proton.me@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WHpKwtQj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D0B080BBE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:44:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 230A342A45;
 Sun, 22 Nov 2026 16:44:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A94631F000C4;
 Sun, 22 Nov 2026 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795365878;
 bh=/9ohXBpf1Nwf39QPdWWgrLMutGh/Qy1uOyI0RwU3ldc=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=WHpKwtQjlDE+jazfrKi2A3YwZMCE+CsLjQ5c8mp8z4im/bo2yCz7Iv6CKzu6Q2CHe
 58E5CzzZrlWdOz0mMtB2KdN8ccuLQqeP8s/v+o9mHiAChecYwzqEmp7V/H9b9AXBvf
 WWSRVNjTeOvZb3lvj6sptetJjCRl1bsrzjj3A1nrIdFf5kNIdgok1Zk8VkhOsldClo
 Xe5R0S64k5Kg/fPxAUPzMHWbHrR5ePtwtfB0k+D3E6sTRy4dXmbIc5BgFGXIf8TU75
 Bh5S23HtQBfG775JYyENX/v75WE04WK4udF92o+oVIkMZYXFChwlOwnAYHsfB7z6d3
 7VkJsO/AmiFfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 0A3CB4C119;
 Sun, 22 Nov 2026 16:44:30 +0000 (UTC)
From: Jerome Berclaz via B4 Relay <devnull+jerome.berclaz.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 08:44:12 -0800
Subject: [PATCH] board: microsoft: surface-rt: clear VDDCTRL EN1 assignment
 before enabling VDD_CPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-surface-rt-en1-vddctrl-v1-1-2e60fd8db38b@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMAyA4VeRnBdoI4jbq4wdujZqxugkqTIQ3
 32dHr/D/29grMIGt2YD5VVMPrnCXxqIU8gjo6RqIEed90Roiw4hMmpBzh7XlGLRN15D27eOXAo
 dQY1n5UG+x/j+OG3L88Wx/G+w7z/vymkMegAAAA==
X-Change-ID: 20261122-surface-rt-en1-vddctrl-9a383020da62
To: u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Jerome Berclaz <jerome.berclaz@proton.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852;
 i=jerome.berclaz@proton.me; h=from:subject:message-id;
 bh=HSSoZSlKsMYdiGqKvQP5da+Ymx6Ab63Lv8j3V4haIKo=;
 b=kA0DAAoWM75tse0VEHIByyZiAGsDG+2hmHUaxGcon9ES7d3E49QJCcU+TmNUHMG2cx79255VU
 Yh1BAAWCgAdFiEEBYAxZZ/IBlBxL57CM75tse0VEHIFAmsDG+0ACgkQM75tse0VEHIizQD/bqV0
 Xpo/k2a6Qz7+daJRQGl/xVotm9grmWNd08e/ZpMBANZeBzAtjHlqr0Pz6CECMeQ4kkfJ7+Fel36
 3IUCMopcK
X-Developer-Key: i=jerome.berclaz@proton.me; a=openpgp;
 fpr=058031659FC80650712F9EC233BE6DB1ED151072
X-Endpoint-Received: by B4 Relay for jerome.berclaz@proton.me/default with
 auth_id=1608
X-Original-From: Jerome Berclaz <jerome.berclaz@proton.me>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 16:50:11 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: jerome.berclaz@proton.me
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jerome Berclaz <jerome.berclaz@proton.me>

Linux's tps65910 regulator driver assigns the CPU rail (TPS65911 VDDCTRL)
to the EN1 input, which is driven by the Tegra CPU_PWR_REQ signal, with a
0 V sleep voltage. A PMC warm reset (PMC_CNTRL MAIN_RST, used for example
to reboot into RCM) does not reset the PMIC, so U-Boot and the next kernel
start with that assignment still active instead of the cold boot state.
About half of such boots then hung right after "Starting kernel...", with
no output from the kernel.

Clear EN1_SMPS_ASS before setting up VDD_CPU, so every boot starts from
the same PMIC state as a cold boot. Linux assigns the external controls
again when the regulator driver probes. The SPL I2C helper can only write,
so the whole register is cleared; on the Surface RT only VDDCTRL is
assigned to EN1.

Tested on a Surface RT: 6 consecutive PMC warm-reset boots with U-Boot
loaded over RCM all reached userspace (about half hung before), and LP1
suspend still works afterwards. Normal reboots go through the PMIC restart
handler and were not affected.

The problem was investigated, and this change and its description written,
with the help of an AI coding assistant (Claude); I reviewed the change and
tested it on my device as described above.

Signed-off-by: Jerome Berclaz <jerome.berclaz@proton.me>
---
Sent here as suggested on the libre-tegra tracker:
https://codeberg.org/libre-tegra/u-boot/pulls/8
---
 board/microsoft/surface-rt/surface-rt-spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/board/microsoft/surface-rt/surface-rt-spl.c b/board/microsoft/surface-rt/surface-rt-spl.c
index f327a80ef..7a8c38395 100644
--- a/board/microsoft/surface-rt/surface-rt-spl.c
+++ b/board/microsoft/surface-rt/surface-rt-spl.c
@@ -18,6 +18,8 @@
 #define TPS65911_VDDCTRL_SR_REG		0x27
 #define TPS65911_VDDCTRL_OP_DATA	(0x2400 | TPS65911_VDDCTRL_OP_REG)
 #define TPS65911_VDDCTRL_SR_DATA	(0x0100 | TPS65911_VDDCTRL_SR_REG)
+#define TPS65911_EN1_SMPS_ASS_REG	0x46
+#define TPS65911_EN1_SMPS_ASS_DATA	(0x0000 | TPS65911_EN1_SMPS_ASS_REG)
 
 #define TPS62361B_I2C_ADDR		(0x60 << 1)
 #define TPS62361B_SET3_REG		0x03
@@ -30,6 +32,14 @@ void pmic_enable_cpu_vdd(void)
 
 	udelay(1000);
 
+	/*
+	 * Linux assigns VDDCTRL to the EN1 input (CPU_PWR_REQ) with a 0 V
+	 * sleep voltage. A PMC warm reset does not reset the PMIC, so drop
+	 * that assignment to start from the same state as a cold boot.
+	 */
+	tegra_i2c_ll_write(TPS65911_I2C_ADDR, TPS65911_EN1_SMPS_ASS_DATA);
+	udelay(1000);
+
 	/*
 	 * Bring up CPU VDD via the TPS65911x PMIC on the DVC I2C bus.
 	 * First set VDD to 1.0125V, then enable the VDD regulator.

---
base-commit: e578056c766d653270b14557c2a9d8daec414c17
change-id: 20261122-surface-rt-en1-vddctrl-9a383020da62

Best regards,
--  
Jerome Berclaz <jerome.berclaz@proton.me>


