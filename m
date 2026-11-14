Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386D606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZoDbGtMh;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=dswNCs4c;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=YA4K+ErT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4AA440807;
	Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OcuKXFoGnbtK; Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E164440822
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673309;
	b=RUi9j81d49YvKHupuSKJsUtxfyxYthyw6F/S556k4YuRk9BvXZEmdaUtPgjdkshgZ0me
	 vs0/IgOc5pZznxhvTEOtsQw7zcNorziv6pQAs3VKx9sJtEMOr6b6d2pI4pJvl4YX8oCCz
	 tBG7zqRErZyiJx9Bg/IAAh0jO1We+33QIgRuZktqsQduTEPpHY7RDAxu1ed0QOJPbEm6Y
	 EwFdyJ4eyBLTLvYoL97KW+VtLLa6VsTBvk70IHlwbpVQvleW+hQ0Flkndi5Go5QQgHKvN
	 VGTn+4dbasOPEafqRZsCLzU5F6npA6AtLi0IOWiED0mXlwa/7dl6SqYu24G3WGXqmKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7B1ochTYh68aHen/InxLUXfUhw4HZjVJ0QQvOcoUVCE=;
	b=mi52/CHBq/d3N2qCvpJw1AQrnsieXb5Mz/HkMwc/LP6erXpHJypTWL4Dv+3EoidvwkfL
	 hhdfFrUB1f1sYgCvuJV3Z/nTqkGkeifZ/7XQpS/RyvdDPSR2eQAg4UR1wU5b/b3a6ITLM
	 XJuwJWlHkJYN1i554kXH8pVpKDR6wvETeRloh9CirjXFwO2bA0QDGdMeU3bc7vgRKfZWG
	 WqrfHupT4qdLqirSKxT95MXgytW5PtxisotfRdPHxHWB4BOIOhhf03YmeUJZ7GBXNrMXp
	 Tz96B0a4NbU28weYe+AUnmVXzx+Azda5w2UBmwIcFIAu/U6mCSugL4DKp8lzWZqep+w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=dswNCs4c;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=YA4K+ErT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673309;
	bh=7B1ochTYh68aHen/InxLUXfUhw4HZjVJ0QQvOcoUVCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZoDbGtMhyEHWkLPFmycPb9ke2a9nCrsFykypKqNBuf68AcVwRx7iGRVAeYa9EoSvO
	 gADk9c/n4yzFZdjF59gIU68EJViUo8yppk/UKk5CDZwYrsppBhEdxn4yEnVQZq9mo1
	 SYh/PWEGDjMDVz67/nsZ/rDuZ74Dy+UPpyWNLhcH2N4Buj8nQEg/iQcwuPm8ZoKrLf
	 OhJCblZnv1rudLiaA6uxOF2BMFRuJ3rz4Sk6YrLdNbmnsCBgk3kLD1Ys+RmjDcEbMO
	 SfzH6Mu99XLLBFBcf0UL//q9vDFoSu1ppnEBTI5JG9raCyoisZbuHMqAo3YPTBNLSp
	 R9fneIuIocq7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E164440822;
	Sat, 14 Nov 2026 16:21:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB71F28C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD3A840807
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uycwIhmO8Z8E for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C11D407E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=69.169.224.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.10;
 helo=b224-10.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd5d13-31750064-7f22-4c99-9303-9c19b5da0ac4-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=dswNCs4c; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=YA4K+ErT
Received: from b224-10.smtp-out.eu-central-1.amazonses.com
 (b224-10.smtp-out.eu-central-1.amazonses.com [69.169.224.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C11D407E4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673303;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=tU0Md0jCDTTUuuQhnRN0jgUhXax1y79zt8e0RA9t5Cc=;
 b=dswNCs4ciQNtH8kn0vmGNEJMnaBSGW3lhiYP2ibaxajrt6/hw+uvV3xL4y8CLmwL
 n2ZvgZVcRByRoqJSOvt5JGVftqmeI+n38j/u6A3QzgpRlP51+4hKv189ETJg86rF71G
 ROg6889NrLeFZtuVut3ypqkdf81xfREeFECZbf2m3JqensDtXct5xMZhPjSNU9AUGFL
 PoILEBt+Jg22SD3goCuITwvubix/ghrgiH4b5TxsFxKXwKa4cUjOSR7uhDOHwQfNHnZ
 yd+UReKZ6E1DDpBQwirrWumANvLWkusqmLacN1Pq3tu8fDkWu5EDvJ76DdadpM7++hs
 B7peCPBiNg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673303;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=tU0Md0jCDTTUuuQhnRN0jgUhXax1y79zt8e0RA9t5Cc=;
 b=YA4K+ErTT7mz281yMsrc2W9njXHBq14Pdn7XCKiIVosDyLIebRdMrUoVeRFreRm7
 zbNLBpmK4dMbM4gj08Kwe4kIKbBl4FlKHNRm8MLhRLrmSVPk0rfIfjLHrn7UbapgZGQ
 14LF/5/Surhek7S+euEeLgTKoZSvThw97tO+ggaY=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:42 +0000
Subject: [PATCH v3 01/13] ARM920T: Add support for CONFIG_POSITION_INDEPENDENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd5d13-31750064-7f22-4c99-9303-9c19b5da0ac4-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=2328;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=tU0Md0jCDTTUuuQhnRN0jgUhXax1y79zt8e0RA9t5Cc=;
 b=O10O4hjsmyP8AVvz0/qASsvLdvyRLsCxTeP22Q7p2SeK0579HtpzAjUlbO5azAhv1kQcm/UaM
 kAw03RgKSx3CqPgnqFS1fXmhzEItmaQeele/3nIpCTDXyLEg9p8BMT+
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.10
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

Copied from armv7/start.S. Tested on an ARM940T SoC.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/Kconfig             |  2 +-
 arch/arm/cpu/arm920t/start.S | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3e9f3b51031..dde41e59d15 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -42,7 +42,7 @@ config COUNTER_FREQUENCY
 
 config POSITION_INDEPENDENT
 	bool "Generate position-independent pre-relocation code"
-	depends on ARM64 || CPU_V7A
+	depends on ARM64 || CPU_V7A || CPU_ARM920T
 	help
 	  U-Boot expects to be linked to a specific hard-coded address, and to
 	  be loaded to and run from that address. This option lifts that
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

