Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19604606A82F
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1jzBYxR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fbsgPJzs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF8FA80BE9;
	Tue,  3 Nov 2026 11:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrL8BS1pJZKs; Tue,  3 Nov 2026 11:29:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0AD880AB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793705353;
	b=g4duiIx96EfFR0nJQmB/ptwIkthWDxU5a1t3ZOrYgWTXccMRgFUxcn7pS+4deiSBfqFd
	 6oG5mwIcbXmtGILGps2ChJYGsz6ZA2KeXp8loSMx7C93U4bNbTxjb8vkUQQtH4is+zJ3f
	 LL+8Y4BcAjsS58sssRzqwXdgxqUHF/Dq6laEycxHLU9ipfQDXetfJXutQ+5pEvUlKedLF
	 W/YPxImiwk1l2YDFXZVV2gKgEQGjyuW4rf6JgEwcxyNi7bHIc85JZNxM8TM48wpYPJFSM
	 c4si2WjZv1zD6+jIJKyApk0L+YQ1biWg/k8woSSod7qsoHWqEBx8HgNkV8+rkLLYHnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793705353;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xcEw1+dD6NtUCz3XmJdM7cpENtsm7cC8oYwydeWALmQ=;
	b=JxiSTdVzr1oDZv5v8aaLcTekVXyuzQ5B60de73hJXQCyq7+1zLoTiNpjERtExPPDYZqf
	 qswIRzCZV1vbc+AKbAipOiZKErku7UHf1r8uqKKoujtXyIY9Ank6bDQWSs65cBKQ+VN7Y
	 wzFTJpx0m8g2fhkvgkeN9fekO8gs6s50mYNASJI+D8lF1Kkmq56d6kl1bn1oEdYLgBc92
	 xBjNZKGa5dqitxYtGEFbvWcpIeAN2vFxtSBLnKKRAu1GIeyq34k3gURQ/m48irV7bCQXV
	 NntiTmdRD+Jsj4pAsRNsngeprR1Fvap0aFHEjEdGy6OA2K+ib8SEQYJ+L9ECUHbZMoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793705353;
	bh=xcEw1+dD6NtUCz3XmJdM7cpENtsm7cC8oYwydeWALmQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W1jzBYxRhoLjSGWTgmrfx69l+0aB63MbfyWXh7zWcUfGR5vqADaXoWZcv+gc0XcqB
	 ndyMT1kLC8IPdO7km37mYptv0FGFwZ8gro69OipyYSx90pRZKC0/PRLupXtVk0IAtV
	 YVWWRET6EsxVbXDTfBUGAOVM/kR36630c7hKbdLX3QN9RCBu3T9uGyBK9Uf/y38PIr
	 OeIYmA8bjA45KaafLTrSafo++6KgtJr7hhQdMsYBEJplyjiqnKe2tE3RZkuhX3R8Ez
	 PtONrBqb9w/NPW8zkhDEol0mcNBL4KJc92ygrXi9k7lciIQwvIX7QbmgB5zfEPNrzG
	 Y8Ma0H+RBDdsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0AD880AB2;
	Tue,  3 Nov 2026 11:29:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C0B4356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D7E8605DF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZjAxwseqkQb for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 11:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33A55605D8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::931"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793705350;
 b=ZtW3sG7rL2yW7hn0JPE/N+t2flMQQ3GXwkqZgijpxHZWiWWbxYxbC7X8vwsZobchMm6F
 c90ZCRj168/4LD1ohDdLplPMcSg6YJosTPAzj81WkaA6L0EhVMRRJTXkJm0W+h8M0+u7Y
 iLZRORU5vu/AoBMDYWmquEqWtxTzahR6ZaEItPAkUlSZPFNdhEDj6LtBGGGSFARk/AKAx
 8gbsYg4dQeP8bVpWhg48+TVX2aPIEpGbtoKcNkSE7RpyrfIntEXHXE1vPLgwk8raCNNzH
 koqvEu2W1+qvN5KOxQSix5fAGMPxSu+5nJwvSGlcJwcU+4GqFq0P99hdsG6dwqrjYMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793705350;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=xcEw1+dD6NtUCz3XmJdM7cpENtsm7cC8oYwydeWALmQ=;
 b=qyGelZQhMYVwpsoBcsJKmAdQ5kEaj6/kWG3bSKydD+9/Z9GmaaDik8i13U6gr4Lv5xAG
 sgzhkc42MKBVSQAa/HuLoyQyhzkMJ3x6ecutAaCSpBJWyr95HHSNhJxjl0crJqIem6nGd
 hyxjzEo6whdSqXoFcL6AQVZU+lrwgucF27e6fqZbv5bSeI5mz+3BPIqgLgzQlNB76Pad/
 kOUxjQwr4djn6HPLsN5dxwYyXOBENliVyEBlfiU5TwLdNQuX14QrGPs7OTyx0W9B2xGTd
 /xwVVy5bXxuGh65UWQ+ujtMDTDG0VTnrEoHU0GM9i9nmtsi93zGH8Hl89tttAfRotMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fbsgPJzs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::931"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::931; helo=mail-ua1-x931.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fbsgPJzs
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33A55605D8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 11:29:09 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-98febe968deso1880470241.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793705348; x=1794310148;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xcEw1+dD6NtUCz3XmJdM7cpENtsm7cC8oYwydeWALmQ=;
 b=fbsgPJzsk7lSg9maF0wh5WCjX2LV2TcNQT0t39znKsfxJaNuxMgZM8quJ8akkFSJWx
 RD03V8e9gYJUz3vsSZajngSHC3t6xNzWDqy8MQw0RNm0b7xzJCJYtV2OIohuZs8laFGT
 B/AL2PnKKTYe88c2crrHWkGaMS1x5ZQGXdF88spTOh/vphGfpbhhosDRHkioSOqh6Lnp
 8vFSyvJ6K5Ru95OWFKTdymP/lrdi/uyEW4t5ro3rjTfybGdV5Lw/50j1ReoIr+NcqMG6
 c6n+I58R4I7qRVGsoNl4jENv6TpDq9GI690rioQOvAr/FsUfruux1VhQQs1oC9KJIf+U
 ZdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793705348; x=1794310148;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xcEw1+dD6NtUCz3XmJdM7cpENtsm7cC8oYwydeWALmQ=;
 b=EF+9li1tnamQgeW9ISuH4Nk621RlJJ7Z5tMB5Rhr4JNOf8BFfGTYGQV2iEriO3aX6E
 1ENmgLNGLOcMfmjAwISmQknkPd/honuOw0fsIl9AXDrq2wh/FRQIN49vspjq3HrDO7Yn
 FKwCizyV/QdmHGy+Ws0qpJmNX7RNlBR19Y27rANTX0y0DxyM/BA1uB9ZdL2a0wNYoi5L
 g/hWIo6DL5115oaEmCpZ5/LnlSx+yXMI6hXRAs+LBKPq4HuU0MRWhRoKdCfhHsrko6Hd
 9u7vA+EuC4T3I6v3lm63UqdxCLwbUalJgLquP8LYrizyNPbSYdFrbgEYZw43JBtU/oBt
 eHNA==
X-Gm-Message-State: APuU4Z+8//lR1Uqe30hDLJGDGq1Gvv/xsD/5nSzQDIWn006tcmTvccGv
 2VOVC0SAyM+Ra1V84G26ArrWagKwKkW/xizrTwBoH53HblursjoUfsH8bWf101H8
X-Gm-Gg: AYBFou2JKm5+fzM25zSrP1HqEFkqSJoy5HIyUidfK8VdmGJxnP14tv0Cm6yPEXiQbrX
 OtRQmJKEtxpTt4oXxlyK39kTMtmY3k2w8inZoAx426EDc8Gy6UAUhN8WIB+g6GAPBo9aoCM9MUR
 7E1ylZZOYxnlTNE2mPnPI2v27eIIof0l/BgVKJO/7ER40sc5cowAvrruDF8ft6teAkAlajLIplq
 fW1ZRpk2X2wxD0wAM2q8ooo5v78upObuOK+IYS8QW8I6PvfHL69JPZtN2MCWG1GIaZPtVpWvPhP
 d47M7lCOltwn+l6ahMv5WUMVvLDlRP4RssbHeSxaG97O7gatNMTRaLJSO3fOggZQLFYM2XwXVDt
 FwBNe7Sa/oaMi/UHOAUqtaeDy76s+NaKXk5FS58/Zh1AmBni6+GRfKgHR2JupSN9CoXL18ITSmO
 eNYfFmK7lgx7ukl/VtOFrsNndivXSUmrUxqQeOYSRTpX2n1k0VqcKJdAMDLyd3iC7BntB5JZqTK
 B+KEevVkeAn/IA+rzIFmVx80/hGDj7EkoIFqjjL3maXZ8s3KTFYLuBd3+N3J2an5QmvzrQIMPQW
 FvKUGfOoDQ85ggX4pnephOsDENzcJhdnnDNd/7prBLQPdirAaYvRYOEjtrxsk29qLisTcqrx+fM
 tibWsmeUEeUwwWRtKM6YY84UVAoRubq5YfQbc
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id
 ada2fe7eead31-7d07273b428mr4542184137.27.1793705348348; 
 Tue, 03 Nov 2026 03:29:08 -0800 (PST)
Received: from MaquinaLab.. ([179.179.238.247])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d07765cae9sm12458784137.9.2026.11.03.03.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:29:07 -0800 (PST)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Subject: [PATCH] sunxi: Limit the PIO power mode copy to SoCs with the H6
 layout
Date: Tue,  3 Nov 2026 08:28:21 -0300
Message-ID: <20261103112845.26721-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gpio_init() copies PIO+0x348 (POW_MOD_VAL) to PIO+0x340 (POW_MOD_SEL)
on the H6 generation and, as intended by commit 4a9e89a3e390 ("sunxi:
introduce NCAT2 generation model"), on NCAT2 SoCs. The NCAT2 half has
never been active, because the guard checks CONFIG_SUN50I_GEN_NCAT2
while the Kconfig symbol is CONFIG_SUNXI_GEN_NCAT2.

Fixing only the spelling would enable the copy on every NCAT2 SoC.
That is right for the R528/T113: the T113-S3 user manual describes
these registers at 0x340/0x348 like the H616 user manual, with each
port's power value bit at the same position and polarity as its
power mode select bit. It is wrong for the A523 family: its power mode
registers are at 0x380/0x388, so the copy would write an interrupt
configuration register at 0x340 instead.

Enable the copy for the R528 explicitly instead of for all NCAT2 SoCs,
and leave the A523 alone until it gets its own handling.

Fixes: 4a9e89a3e390 ("sunxi: introduce NCAT2 generation model")
Link: https://lore.kernel.org/u-boot/20260723105705.3338923-1-fugininsane@googlemail.com/
Signed-off-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
---
Sören Hantel found the misspelled guard and posted the patch linked
above. This replaces it, at his request.

Build-tested only: I have no R528/T113 hardware. In reproducible
builds on next ed869863, the SPL changes only for mangopi_mq_r (R528),
which now has the copy. The SPLs for avaota-a1, orangepi_4a,
radxa-cubie-a5e and x96q_pro_plus (A523), pine_h64 (H6),
orangepi_zero2 (H616) and liontron-h-a133l (A133) are byte-identical.

A Tested-by from anyone with an R528 or T113 board would be welcome.

 arch/arm/mach-sunxi/board.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f9..75aede14b2 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -196,12 +196,13 @@ static int gpio_init(void)
 
 	/*
 	 * Update PIO power bias configuration by copying the hardware
-	 * detected value.
+	 * detected value. This relies on the H6 layout (SEL at 0x340, VAL
+	 * at 0x348, matching per-port bit meanings). Not all NCAT2 SoCs
+	 * have it: the A523 needs different handling.
 	 */
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_NCAT2)) {
+	    IS_ENABLED(CONFIG_MACH_SUN8I_R528)) {
 		val = readl(SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_VAL);
-		/* TODO: A523: keep only the lower two bits? */
 		writel(val, SUNXI_PIO_BASE + SUN50I_H6_GPIO_POW_MOD_SEL);
 	}
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6)) {
-- 
2.43.0

