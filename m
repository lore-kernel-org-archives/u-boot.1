Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE0606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DRTVO2Vx;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=RIOWFKd4;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=I5LvTMuA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C8DD808C9;
	Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOHKwGSxjFNi; Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD66F80898
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055311;
	b=Bl7kq+j9Hfm2ZUReN0x+Q9JeqfS7ecSXFDS/XDSTnQZdx7IoOJYdkIK9MvUeOP5ImS4b
	 eA76quB7qmDdOyW7fqkCUQoLIDFVZ6ePvp7eztx6T/ielCSpr9UW8cdoLLFD0xoQ+BTld
	 HVDufWsxtnKMxeLjnxqk5ljATbtauY7nh9Xzxc9c/BK652dQzacBdpPQFTJvRkLvbS9te
	 TqNqutkEDZBoPL3J/wDt1/11uRE7nv8EUF1KuQspTYVBzxG8Cx1vvN3iz5EkLYUXulVti
	 7jcZI0W4NCIDMHYxoDQ/XuJsI0DPNICTLqkm0Y1bBe9yXNvFDHSc+ci9jedhKXm28sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oH1d+xpweC1twGc+A3mETmvQItFKKBEMWEcGJBJG1XU=;
	b=N55twTOdYmVWYKVMb6W0qgEo86VpSXAvBH964FC2T5XD/ivZBEEBvjHFQrWgbR3Ix7vs
	 go1INdwMfYdLPyRkHY9j7hmqvt40GDS7MwJ6UTlTpfPVQXuoPr/MmGZkpurFpUyy8xo3n
	 55w7/+VfqEnuYHyUQiectodXPRmH6sLRxNSQTxJIqGxwUF32IaBnGUJa3PyLezkLL+fTX
	 DT2VCbo0JNN61p2X05EAtaqunMn9d9wh8L6XvwNK5bAYPzXQGIHU65qQRiSEbv9sdubwu
	 /5U8/u2oxP0mnc5Poma8Ock+3mOk9zaaqXJ+I29rn6QiWytDtcQ4NSj3IO3QdPSJvnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=RIOWFKd4;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=I5LvTMuA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055311;
	bh=oH1d+xpweC1twGc+A3mETmvQItFKKBEMWEcGJBJG1XU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DRTVO2Vx0SN7wNsZ/wDPk5gQpqLjKTYxzxInMdmYwApS7PpOXpMweSbc3H/PgIlU/
	 IZXOvwuMiIGGRFmKhhK5twmX7DowxnIbLgTerymrZq/bKaLUy6bfHg2OYglgzjrWcP
	 uoIGNXN9f8dFi6Qr0YJD7kMetoe13nXDjR39ZENCJq7hvcp3EkdggBdhfwUweBo3h8
	 8wHZZ9VavI1c6w+R/sC9C0WOMd1tnuF4vALsysrMLhU9/zBVtxz5E8ATdxUNoRUZT0
	 gXSWZwWoBpsTNl8FeOQdBYRP0frCOhosPfwv8TrdaFS8Nul5asRFOIt/DCtCtYEDQ9
	 M+AUbRi7tRYuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD66F80898;
	Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D1831120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B752480963
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5tr7GCdRxq5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D505780898
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055306;
 b=NihdUI8iSVYYx6tnwBNsOuE6752bx9r/UTotwfBGH4pur7AJ2sE/722Im0F7KlJ5vs2h
 v4ks8d9Kes2hJ6LtTOQWJCtdDFs7eO/w4Z7YPsmzFVukAM8deA3ZNjuueZ3khYH5atBqj
 LpS87szqMtlTY7lsg4zWYzPDVGlso9r2VIDwIGNWS7FuCdhauRY6KSQpYrvk/dT86Qnem
 dwVYjpO64pE8GAwvPrR12xwd76r0gmc5t1iObHTwwiXPhQLfymqkpHqjWtMoitPpWN0yf
 M4rKFaRkdRf7lXZn4rUXIuhq/w9hNXJAyN1zmOiRPV2Qz/CAkO26Hnejq7JtR5PJkuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055306;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=oH1d+xpweC1twGc+A3mETmvQItFKKBEMWEcGJBJG1XU=;
 b=NFDioVVk+rDmiVUCcldsGhwjPCwFIc7y24LKI2zVffMZovWErgU8erzf9cn+HhOnyYWV
 ENT1moNVJ0RfpqnObOV80YcgyvUUMwSB0xGQyPncTIST+XPDu5VMIM7HqDpwDFzDzg9ql
 eQpzaHllNlnou+9nAyYX1MTWWmpCpgSsVRDdq7rIplCP2IXkR5Sw+09qSnOrs6nHA0/vg
 8G2wdakiRlAnWrJu8EaJBgnwjCnUIuDsg4ne9EM9ubkRg5E3rh/+/q940gbkJVUHXNMgs
 U4W8F9DrcDZshQ7vZO7dkgBOeRTcTa71SwKGRBM8+Pk0YDyClesdtiyWim3m1vi1H1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=RIOWFKd4; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=I5LvTMuA; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6ca634-0e4a0647-cad2-4a73-8d60-ebba65a6ee46-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=RIOWFKd4; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=I5LvTMuA
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D505780898
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055303;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=mbGCFwuUzO9EyM7ZVXGpOUqrxqAyC8dLuRemTc3/Omw=;
 b=RIOWFKd4jdcxYzfml0+GjjvzixfNKrdesPtCLRZEPYrWIgsgR9aDAlugir52/0oA
 ae3kJWDX4vVPEWvdQ813s0ACso7DbosbU0yIqIGYLbRwNUPc/HojF9HztfHHGu5IZ2K
 az/FXQ96KFly0lWDgGfFQ9r06Ash3pWxsk8Coy3uT2zyvyx4ba2n6JDv50fFz37CvAw
 8Tln7BjHvsjFrlu5bz1tzHyr0/cLKq3lbcLyeWrMMRofGIgr8AQSkmXAtn5VmuCYrDk
 DiTOpQX8R/IS+LLf77IWoRC6IaQoFc4thGmo9+qCOoCmwAccXSE4qHvCJI5ZIjH/y0z
 ov8WtJN+dg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055303;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=mbGCFwuUzO9EyM7ZVXGpOUqrxqAyC8dLuRemTc3/Omw=;
 b=I5LvTMuAgFbN1sE6efBiNdOGSQEAP4gJH4AYXS2cvXayteAQWV2up0/Xp721wXlk
 yHXMd+IeEMqAjO4tKlBjUlZhvLWbR2NeSP0MJTKigV0LgVUaMy8P/OCnFaUtxRUOq2V
 CllG13geJo7Li3So3xF0HYvUsD7nqPUXjYo9NhHU=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:03 +0000
Subject: [PATCH v2 01/14] ARM920T: Add support for CONFIG_POSITION_INDEPENDENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6ca634-0e4a0647-cad2-4a73-8d60-ebba65a6ee46-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=1772;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=mbGCFwuUzO9EyM7ZVXGpOUqrxqAyC8dLuRemTc3/Omw=;
 b=lDoAMrAUfJiwHhZRcLg1DuXiwQXRav7cCkWHu38iFQdZy28oEwRbbgbSm5RWV5pVc9lgklCC7
 DQ2Oh8Nb2HPCm2W8yT1XyJ3VwjVBYKgwAKMVo/R1JDGr4+rCy5Vvxvx
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.7
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

Copied from armv7/start.S. Tested on an ARM940T SoC.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/cpu/arm920t/start.S | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/cpu/arm920t/start.S b/arch/arm/cpu/arm920t/start.S
index e792e8e795e..3d1f210af05 100644
--- a/arch/arm/cpu/arm920t/start.S
+++ b/arch/arm/cpu/arm920t/start.S
@@ -26,6 +26,42 @@
 	.globl	reset
 
 reset:
+#ifdef CONFIG_POSITION_INDEPENDENT
+	/*
+	 * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
+	 * executed at a different address than it was linked at.
+	 */
+pie_fixup:
+	adr	r0, reset	/* r0 <- Runtime value of reset label */
+	ldr	r1, =reset	/* r1 <- Linked value of reset label */
+	subs	r4, r0, r1	/* r4 <- Runtime-vs-link offset */
+	beq	pie_fixup_done
+
+	adr	r0, pie_fixup
+	ldr	r1, _rel_dyn_start_ofs
+	add	r2, r0, r1	/* r2 <- Runtime &__rel_dyn_start */
+	ldr	r1, _rel_dyn_end_ofs
+	add	r3, r0, r1	/* r3 <- Runtime &__rel_dyn_end */
+
+pie_fix_loop:
+	ldr	r0, [r2]	/* r0 <- Link location */
+	ldr	r1, [r2, #4]	/* r1 <- fixup */
+	cmp	r1, #23		/* relative fixup? */
+	bne	pie_skip_reloc
+
+	/* relative fix: increase location by offset */
+	add	r0, r4
+	ldr	r1, [r0]
+	add	r1, r4
+	str	r1, [r0]
+	str	r0, [r2]
+	add	r2, #8
+pie_skip_reloc:
+	cmp	r2, r3
+	blo	pie_fix_loop
+pie_fixup_done:
+#endif
+
 	/*
 	 * set the cpu to SVC32 mode
 	 */
@@ -95,3 +131,10 @@ cpu_init_crit:
 #endif
 	mov	pc, lr
 #endif /* CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT) */
+
+#if CONFIG_POSITION_INDEPENDENT
+_rel_dyn_start_ofs:
+	.word   __rel_dyn_start - pie_fixup
+_rel_dyn_end_ofs:
+	.word   __rel_dyn_end - pie_fixup
+#endif

-- 
Git-157)

