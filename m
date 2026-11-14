Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A87606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ik4vDIQ+;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=hXnJpWD8;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=iikueT85
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8A13606C4;
	Sat, 14 Nov 2026 16:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpLhlPRTou0q; Sat, 14 Nov 2026 16:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B4700606F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673311;
	b=PVBrLIPdAfztZmFqnNJyZxSsYw8Qo22Y4qlVuqqS9Ho/xGeF/ZWT4K1qw2d6lFH9hdgM
	 NgfyDLaW9xBGoJ+aDMdG7VDXTvaOBO1VLGV9Xcdtif6GF3gzC15RTpDKRojxJiXe7aC4H
	 1cH0Qwzyuz2GXLmaTDhik9Q5eu8UMAZt4hVXOTt4KZQhKKZ/joQpoHvFCdWHsJlI3rd0t
	 7JQgYM9NuuMNq82ACa6KQBk4fVZgnUYHbE96sb2RKT/3O8aVQDP6kciSaTwKmv8uyjNcw
	 nLDiu+3sz24YnoJKjHxAeMKa5r4aMrKMzYQizlZ1tibP+zDqCxRSCkSi/Wh49yVP+Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/enk4eGhfoZs2GGxrfVBirth6aejuaCnUHE1GLqRp3g=;
	b=AiTNuZ0fs6BAdHaOfCZDdI/qULwV0IRcMC1BPnQNhYeOsskmrjC+BwSbZeDS12oPaKn7
	 rHSqBrLsdwYnpQ95NRk0UEOT8/oQOnfJbOQMAXsoEbedhOuikZefY005r7iMwRFRRN5th
	 hVvldE6aRjMVJDzxJAo0yh2qKAF+EZrkKINRM+/01P7llkuMx1kyC8duUSJ65S/8S/rYv
	 QihYnYA3+Lt29L8msnH+7+hVURJ6U8/x8oCgleojsguIACNNYjrpPcwa82FYp5bw1uvNr
	 yOCBvRVMbPQcQMQqzWnF7+cEFmoOpW/5QbWeKooTvQfGH6Bl677xb24DiRal31Kvjeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673311;
	bh=/enk4eGhfoZs2GGxrfVBirth6aejuaCnUHE1GLqRp3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ik4vDIQ+HJscaPRxB1qtc9hxtZPCROeTPDZrb5nU7LE2mzCK+eZ3pzS4NffRdt9Qw
	 KUN3BG2XD2TI7jDyoo884XxXGK1rd/T+qgZuQ/l4T6gwI81wW11wBPSlUwGRpKy1R/
	 YzCiEJdmIJhYupvdBNxBy6koeeVWzdDGIYned7azz17WHzyZBHaw059j3H66kVq7Bf
	 Hx0+iNhk1dJpQc6k3dJkXsSS8yhD9XffT5mAmYXGkaNosCp0TBa7rg+dkxGjMQMymO
	 xlfLbJDO3ir/wwtuiL2LKyQjxOtMNbQ6U7p6dlww/Jl6n3aaIFdgwt8KH0PfVmlhup
	 MFID/oYooOEFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4700606F0;
	Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D13128C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 521AF814A0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAjEWbufeJ2y for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BBF3814A1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd60ca-f1052c05-5c74-406a-b3f1-b5ef07e4a42e-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=hXnJpWD8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=iikueT85
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BBF3814A1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=w3rSdQ6G9NcvPTiy5lF1Pmznj0iDRIDH6ugP3vhUWAU=;
 b=hXnJpWD8jAeJFGGxkx3cHX4v1Rz2+ofauL4HyQdVPC2oGGzr7BDomOm9yk8FZrwV
 bvCM5IgiNQa7klJhh76Jf8YITpd5jA0ZcioWvjXLr+P+eUDPN3104tWGAO3qIA4ES+j
 8fbiKjwQpQFfKynUanRLnoYytUkDcvj0rfzHOOLssbu2oCs7XsiE3pST0VOGGkm0aHy
 yyHYgT46wIPNNYSfy/2bf27i8oV9Hygke+Wvb+1zERReGrfGFK9nQf1dLJ2xVwDq34Y
 dB+BwrqSX0m2wa0HXk7hQQgVsQ6PsnGb93GvOIAK0kh7LtQEYFqNZbyB1wkoldot70F
 7dTvD7rM1A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=w3rSdQ6G9NcvPTiy5lF1Pmznj0iDRIDH6ugP3vhUWAU=;
 b=iikueT85Yfx/PAq+CGOemvpmKYUmFTHvwAru8CR0Cj2sTauqTSna7j6DajWjnQqX
 8IevjIsKVH5JX4aWuwro8AlQxSivlFYwmt9jQichQJvlLY72yP8PX6oE62QXPcavCnF
 wieQ80jEPFPKMpz0o76a3tod7jXm8FFHSiR51Kn8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:43 +0000
Subject: [PATCH v3 02/13] ARM1176: Add support for CONFIG_POSITION_INDEPENDENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd60ca-f1052c05-5c74-406a-b3f1-b5ef07e4a42e-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=2444;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=w3rSdQ6G9NcvPTiy5lF1Pmznj0iDRIDH6ugP3vhUWAU=;
 b=B5oS0ffRP8u26eVbRawUGirkVGWShq7NpriuM0sPWEH+594/ljWK69sx33FZSjAKu4ORVVKPw
 3YRYcgXonrXDsDhEasXowHMLHhHjwH3b0OOhAJje93v/n6UohqNOHdW
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.12
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

Copied from armv7/start.S. Tested on an ARM1176JZF-S SoC.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/Kconfig             |  2 +-
 arch/arm/cpu/arm1176/start.S | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dde41e59d15..4b05a4d561b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,7 +42,7 @@ config COUNTER_FREQUENCY
 
 config POSITION_INDEPENDENT
 	bool "Generate position-independent pre-relocation code"
-	depends on ARM64 || CPU_V7A || CPU_ARM920T
+	depends on ARM64 || CPU_V7A || CPU_ARM920T || CPU_ARM1176
 	help
 	  U-Boot expects to be linked to a specific hard-coded address, and to
 	  be loaded to and run from that address. This option lifts that
diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index d3ab5928eee..b041faba5f4 100644
--- a/arch/arm/cpu/arm1176/start.S
+++ b/arch/arm/cpu/arm1176/start.S
@@ -37,6 +37,41 @@ reset:
 	b	save_boot_params
 .globl	save_boot_params_ret
 save_boot_params_ret:
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
 
 	/*
 	 * set the cpu to SVC32 mode
@@ -115,3 +150,10 @@ c_runtime_cpu_setup:
 WEAK(save_boot_params)
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+#if CONFIG_POSITION_INDEPENDENT
+_rel_dyn_start_ofs:
+	.word   __rel_dyn_start - pie_fixup
+_rel_dyn_end_ofs:
+	.word   __rel_dyn_end - pie_fixup
+#endif

-- 
Git-157)

