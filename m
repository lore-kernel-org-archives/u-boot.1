Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE76606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RfXSq6m3;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=djqWIzuI;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KxQIPtxy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04EAD40506;
	Mon, 26 Oct 2026 22:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmb8KkayXA-v; Mon, 26 Oct 2026 22:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A3AEA40500
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055313;
	b=GvhHiKMVviG0UUfjD1KLNmkgZ+Y1pgyobdILNg6z+1O71lANPWReXW2xmt+2WcWEm3b1
	 71Mim2e6AggZSRs/w0YvjlTO7i+wLPtTu0CcNn8qS4pJOUZVg5g8tJmxUfr0H62tOJ2Uc
	 N+jq/9Tor9Rjvv62Dj/zUKlYWMZ1eKls6Vl3Cbu3Fz6w0UYkRJDEa3KeWO7Ps/eCLqgt8
	 /oQ/lBPrXTRB0Jsi/WGac6DbVB/SCZu5ltUwC5vWW2bcxA+kTnybToEDCViRj+d/S0y9a
	 JhOL2jwagWMkGaD4DdJm/KN/cTJl8UHQ//ErOccQoNnSCmQGhUbw2EZDzNN7loOhJYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h58D7hvWEwuoc/+KGiueKyw/ns1nCGlhrDyV34z6o/U=;
	b=LuSlzOflHYpYKB1UJl3H93wbxWHIYU+JAKC+Go0MXA7y1H4+ef+yNOaFk4mib0WiqFeu
	 FtG1UJ7R4CS5Glp6g+Jtdk7tttZ7az5zSgvSNwdB489ozKKoQ7Ol67syBiqGYpPxkTUpK
	 gQV8XoSOfatMECifD1zrXMhwfjYrRFSGAjHWrab4E5QqCOkFjSfgh1DRo38YuK5XIApfQ
	 foAX0Qy4HqQZVrO1f1CP42q3D/3enY/WOK0pgIC+fqjoU5xOAxCYJGvlxC7DOydZEI1Rf
	 YY+YtrCF7gEmOdv4x4amlDU8p1hMP2J0nj0JQFpym9fK8Y1ILsz+9E9TGFDvNddHI7g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055313;
	bh=h58D7hvWEwuoc/+KGiueKyw/ns1nCGlhrDyV34z6o/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfXSq6m3V2z0B31bP44MDmJ4TdGeChx3GLd0LFIo/+q087MXzgPeekLaOpAf5fpiI
	 yhx/eIWZAMAdExbsmtYIEmOekc3R0iZKJux6Bi4WmJfW4Czz6R5KoxAf2FcS3PhHOw
	 S6X+7EADAaVRQrRgzf6MAo5U6Y1eS3c2vcaf2kfj2ksWn0agFCeQWDFE7zs46LxkGp
	 3O/+/ok4RvqahhY7qdx3K4UMnE1ZE0V9SjHrjOWH3ADyRsluAjtGm5yg+2as9SS3F0
	 Sv3ajhkFHZ2qh/So7Vc95LLdzJ6vSvCG0mavTLCeBf70As/6AqsDBu0gmUQ5mRgjNm
	 QGI5I5R6+dIjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3AEA40500;
	Mon, 26 Oct 2026 22:55:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C75B2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3116F40205
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWxtHuiy4y9z for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 97DDE40075
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=69.169.224.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055307;
 b=B2sLN8d3fPZmapGQOlf2NN7OLGhzymnoYeoZtTGw3ecKIKBRC2cuPjD+wd2ZqaAVCydc
 mRxn90QjxuWH64PaIthKaIVCqgi0nM+FEgKIdvDuXm+0NEExWeYTs10RmsxpR7N4YyXWT
 DautlK95pU8DRvvi77dVI0hPrLxt2cmU8KFuBHK5gHCM1YpBmnjz+QshtOtnjQ1yJDGSI
 JBP6kKb5iy82qSYE5yI1xMtKNB0PLtjaCaIKTSJ9nUkDkYTDWt27e/S/MPB+PHgGfqyk9
 22x/5mUnahyApBL2DdwHt2UOPI6n4m5wzERoQ7303jiEwHuwGLgK1EHb9WqPeNEUjkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055307;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=h58D7hvWEwuoc/+KGiueKyw/ns1nCGlhrDyV34z6o/U=;
 b=ZDdSeHj5XUuBUkqBysGo/BnI/0/J8wduVWSXyzE/w66C3Aox7sDnAzLhZjun1wihPpCX
 swCAsaVN5Y1Y/qVA8PZ+WK6C3iXSyDhmbjcD1JNuFdyubA7uRqk9IxTR/uFgFbsf4ddbJ
 gPl046vFL7Tke2wZy23fRXni6fYiYOeH/wb7wUBYiunXTzvS1WYfIV+TPwy/FH+bvkeIF
 TaIe+kjxCDzIEqaiTe1BwSp05vYHK5i5WrbUYDOnhemxdURJzfjXIv7o3DL+LOs9bBIui
 z5DFAFCBf32AIhZ0oklcUTFFTkb1KZxVQMcvti5D/hMUqtM6EwJJSX9SHz5c2glLQiQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=djqWIzuI; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KxQIPtxy; 
 arc=none smtp.remote-ip=69.169.224.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.8;
 helo=b224-8.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6ca917-f82354d1-1e8e-41a8-b262-3561e8dbc69c-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=djqWIzuI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=KxQIPtxy
Received: from b224-8.smtp-out.eu-central-1.amazonses.com
 (b224-8.smtp-out.eu-central-1.amazonses.com [69.169.224.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97DDE40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=++k47lIWZevGZqhvvGbpmuvr6CKZlchttvt4+8HrnwA=;
 b=djqWIzuImLZW+UXBx1lHUVw/oV99i1Rgkp9BxDN28xAIfeQHBeCHmJF4PloieVhL
 juVE0DMySk9Yj5tNak4YEFtOrUwUMxXXkF3H927FoIKd10ImaqyNGH1fmLsv7Zak5ou
 O+mnRu7/eDZKZkITjFcewCbeeLlCGWVjgpw8Onr8MCbHIXn/uOvobw/QveTc/hQRpRw
 Rbb+4NM77DXhQOkptYyZ0iemtpOfEMc0oG+WmpeLtnQk+NyNBToYbvcPU5oMPcKGO9O
 2xHocDLDFXjdPSjYr6y278UqRoO31p/H7w1HvWaRMgtd8fP4xTT56lWU1Kon+0zf+wq
 PQ/b4+/4ng==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055304;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=++k47lIWZevGZqhvvGbpmuvr6CKZlchttvt4+8HrnwA=;
 b=KxQIPtxyHljXt1OipbDUnZCv+bUxb4Yr4iCI6ukaU1+yKzLkMQtaE4OTqmrdoLkb
 FBoH40UL0BCdfCrOWxe42NwWERFIy3wfon9B9cXSYCkAXYpT4TZ2PkZA5Ox7O9I+6aP
 oBjhfhtYdjjCaFDu6qExIWRKT93W8LSMuBUWY310=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:03 +0000
Subject: [PATCH v2 02/14] ARM1176: Add support for CONFIG_POSITION_INDEPENDENT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6ca917-f82354d1-1e8e-41a8-b262-3561e8dbc69c-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=1864;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=++k47lIWZevGZqhvvGbpmuvr6CKZlchttvt4+8HrnwA=;
 b=hKtN8jBNuUDIQ3sLWphn7GDSfUNw5hGvkTHUTy+mZZ3kLEDhH+j5y3mWtXyN51e0kC5yI6JAD
 +N0eCiNQ7uUA7VUZYUyaFYtQUTFZbWAbp9Zu3rY+ci61GwipLNqKFeW
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.8
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

Copied from armv7/start.S. Tested on an ARM1176JZF-S SoC.

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/cpu/arm1176/start.S | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
index d3ab5928eee..7bdcb5fb97b 100644
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
+	adr r0, reset   /* r0 <- Runtime value of reset label */
+	ldr r1, =reset  /* r1 <- Linked value of reset label */
+	subs	r4, r0, r1  /* r4 <- Runtime-vs-link offset */
+	beq pie_fixup_done
+
+	adr r0, pie_fixup
+	ldr r1, _rel_dyn_start_ofs
+	add r2, r0, r1  /* r2 <- Runtime &__rel_dyn_start */
+	ldr r1, _rel_dyn_end_ofs
+	add r3, r0, r1  /* r3 <- Runtime &__rel_dyn_end */
+
+pie_fix_loop:
+	ldr r0, [r2]	/* r0 <- Link location */
+	ldr r1, [r2, #4]	/* r1 <- fixup */
+	cmp r1, #23	 /* relative fixup? */
+	bne pie_skip_reloc
+
+	/* relative fix: increase location by offset */
+	add r0, r4
+	ldr r1, [r0]
+	add r1, r4
+	str r1, [r0]
+	str r0, [r2]
+	add r2, #8
+pie_skip_reloc:
+	cmp r2, r3
+	blo pie_fix_loop
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

