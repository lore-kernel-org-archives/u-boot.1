Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E9A606A7D7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B9svhFZN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeGPaF9g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6C6C812E4;
	Tue, 10 Nov 2026 13:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ew2CiTH1aNp5; Tue, 10 Nov 2026 13:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED17281301
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315948;
	b=bhp1UwuIITrT9DH8uM5hELBDvUT/PZ6EFBSIM+enkSHPEI5oHQu+12xL0NBDUckg6ORt
	 HFvqLZNTdS5nUmEGXJwamxufDLFwpwjuR8Le50BpaMvs6KTszs2ZqM95uf6Wa0n9Dgw+h
	 J/BZIhGjIyiGB3S/pDFCE/wuK4Bc2ODFAfYM7qRQODuJOza5JbUVpfOAGU0R/Ah8GTsHS
	 0gXlRVDkAtgM0q1lvzPY0fa0o6NzzCTnI8SyPtBHz09raH42Pai25RjRSNdchrsaG90ua
	 ZPxVVwGLcvIPIPNt/MIhfVyvwNIcyiDzAcCkv5idLln2CJEqLeA/syBjWPqTqFc8UYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315948;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ngMKtJkww7FZR7m7RhxmC5Q+1niO9SjT81KtNlPVGB4=;
	b=bCJR6oeC3ynkI85WjDxo0AMbJkJiLJNGirYDuxDt/NcKkee4aiThi2UzFlUkbefHgyzB
	 Lwq8EnjxIV0vNo7TZNjs5lefTIENKTWeZ5gYGfriNbJ/2/CeOEJXMo4izfOncd3F7rRpo
	 hiDqf/7gM8U/sgN21qilmWn9iaOG1FQK68oSIoGxGbeU5n36Vx3SPIXg5c1T7wKxfFKy3
	 ecsY2+JaNn8xfvN7Xr0I3BgiscfQq1J74GTOfuvvN/S7AacAM1uNfLUww5hx3ZsyeiceL
	 0MPEO5hm5dk/0aT9ORhpirOygpo1JnjdHp9QMdkO/JRVTb7UttZKRZo1sRYezfS6M9g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeGPaF9g;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315948;
	bh=ngMKtJkww7FZR7m7RhxmC5Q+1niO9SjT81KtNlPVGB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=B9svhFZNXU09yZg7O8CmWSpHvQZdxBUPKZfet6P6VI+gRjeeWKjUaQRnKDun5AzfC
	 cQFxdLD1vz0k4ctdxwQ70mbia1TFBwEVB3L5blNHPA9V+8Zjb6rIEP8iTGaSnOjFxC
	 I3yyDjG7h1rbht7XNvwxpgJWYXgPQxdGTsBo3R8qyaQ7myWbAgS+O9aYxr96NgzvbW
	 6LX02YKlve2126+inorFqx9VN+wCHO9278ux/2RIWW/6LGYdpMyN2dArLZGKl+2Z09
	 nPV0ACJXMnEx/RU0l+VcKLBaB+34f3NHBP3B9O24p5cRJobdjyUuQerClk3kRgtz6t
	 O9z7U1CPj401w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED17281301;
	Tue, 10 Nov 2026 13:05:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B4D831F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3085F80F36
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wRigCY-7vf6 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 06:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 884AC80F1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+aiyengar1990.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jeGPaF9g
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 884AC80F1B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 06:20:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 709A64017D;
 Tue, 10 Nov 2026 06:20:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BADF81F008A1;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794291611;
 bh=ngMKtJkww7FZR7m7RhxmC5Q+1niO9SjT81KtNlPVGB4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=jeGPaF9gqulI2tu9fU/jpn6/ISGuRBdKB6QHaIT59FelPxgf1j+m943RuKxR9O8KN
 xypD9YPfU+LkK0lXxdVeDibIjJaR+TOtgSVzLMN81YER0Jj/xkGBnYXNwQVGiATj+H
 tlbNZRGT3v3+i2yyo6JnR4AwNdi2LXw2SC0jywxXgVPDDz0aMHbdbAc2NBiXUAN4Nj
 A/Rg9QpIEb2mjFvIcKJmgLjREFSA/c5vwLyDed1QdSmKByxrIgJMVxfH4ZWIoeKCnt
 c8NTaQCUWIlgIjNw4JfYHFSeP5NjlAfa7Ha7B5YLHVfwrPugtH/D/CLPK3+NGQbqCD
 WxITJqIW+x9pA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4D207488F9;
 Tue, 10 Nov 2026 06:20:10 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:20:10 +0000
Subject: [PATCH 1/2] sunxi: H616: dram: DDR3: use the JEDEC reset and CKE
 init delays
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-h616-dram-retry-v1-1-ccaa6d7a6ef1@gmail.com>
References: <20261110-h616-dram-retry-v1-0-ccaa6d7a6ef1@gmail.com>
In-Reply-To: <20261110-h616-dram-retry-v1-0-ccaa6d7a6ef1@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Arun Iyengar <aiyengar1990@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794291609; l=2506;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Gp0CFoCjE4ys9lGql82Eeni5Jp82PDQ13jSEqGWKAYo=;
 b=wvdPtDLw5kDKVzjTzCqpKN77epuBHFJTSDpCB3vsVCQu2eLXtKMfxxkbDy06MJ1o0oICZX9Xj
 hYBWqjZ9MlJAQdWapQd8qR7ozyRN7m+0YXT+N0lxMo7AQMjmB2YeTjM
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

The DDR3 init sequence of the controller is timed by
INIT0.pre_cke_x1024 (RESET# deasserted to CKE high) and
INIT1.dram_rstn_x1024 (RESET# low time), both in units of 1024
controller clock cycles. The H616 DDR3 code keeps the pre_cke reset
value 0x4e (about 222 us with the 360 MHz controller clock of a
720 MHz DRAM clock) and programs dram_rstn = 0x42 (about 188 us).
JEDEC (JESD79-3F, 4.6.1) asks for RESET# low for at least 200 us at
power-up and at least 500 us from RESET# high to CKE high. The A523
DDR3 timings already program much longer values.

Derive both from the DRAM clock: 550 us (10 % margin) before CKE and
200 us of RESET#. At 720 MHz this gives 0xc2 and 0x47. It costs about
0.33 ms per controller init, about 2.5 ms per boot on a board that
goes through the usual rank/width and size detection.

Tested on an OrangePi Zero2 (H616, 1 GiB DDR3, 720 MHz) together with
the next patch: reboots and cold boots come up with 1 GiB, and 60
hardware watchdog resets taken while the DRAM was saturated (the case
the next patch is about) all came up with 1 GiB. That test does not
show a measurable effect of this patch on its own; it is a compliance
fix.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
index 3faf8d5bd97..44c2018790d 100644
--- a/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h616_ddr3_1333.c
@@ -86,8 +86,15 @@ void mctl_set_timing_params(const struct dram_para *para)
 	writel(0xA100002, &mctl_ctl->dramtmg[13]);
 	writel(txsr, &mctl_ctl->dramtmg[14]);
 
-	clrbits_le32(&mctl_ctl->init[0], 3 << 30);
-	writel(0x420000, &mctl_ctl->init[1]);
+	/*
+	 * JEDEC DDR3 power-up/reset sequence: RESET# low for >= 200 us, then
+	 * >= 500 us until CKE goes high. The INIT0.pre_cke_x1024 reset value
+	 * (0x4e) is only about 220 us at 720 MHz, so program both (with 10%
+	 * margin on the CKE delay). Units are 1024 controller clock cycles.
+	 */
+	clrsetbits_le32(&mctl_ctl->init[0], (3 << 30) | 0xfff,
+			DIV_ROUND_UP(ns_to_t(550000), 1024));
+	writel(DIV_ROUND_UP(ns_to_t(200000), 1024) << 16, &mctl_ctl->init[1]);
 	writel(5, &mctl_ctl->init[2]);
 	writel(0x1f140004, &mctl_ctl->init[3]);
 	writel(0x00200000, &mctl_ctl->init[4]);

-- 
2.55.0


