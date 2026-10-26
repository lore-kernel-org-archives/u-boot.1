Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD5606A328
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LdRdjOa7;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=pE46Jl3v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADE73605EF;
	Mon, 26 Oct 2026 21:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fQmC0FSrG04b; Mon, 26 Oct 2026 21:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D17960607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050294;
	b=Bn8F/WAOgdvNRCdOSULwQ+S/rumvZClSm1Cqatx550nhxK9IB/QAYncpYPjTEbPjaFs5
	 t5HaZv/7Xt302KUrEDAsxaIv/qgaiFOWVflbOLlCzb0HL4EYr9JnOUJ1mfWjDvGTq8V4r
	 C8fuuDpqOiwNCYr1q0QBLiw8/NjgphAO8YNCHoqSrnKpv4J5y3I3WScuFQhmRrRZUe7bW
	 ypkSIbC6Ck0moM7aTEEQMI5zlFl0rfMbi0JYuDM+2YzwGgWVK/oliWU0nWiuTrWstGH+V
	 yib2F+d+ExOc1Zpgxhyne0JuD6pTGCQtTQzik2wRHYbFTInpD3bF5SpDvQvs18jro5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jn20dXGMuiV9UZfmzYFPx1X2Fc/wqR/d9h5Xs2gpM2k=;
	b=mNOtCpLDhssLtx517WBaQzYD1CKC1ehsaEk8R3sema6g7bIoGHvIkLCo4G11bzmcFajQ
	 iQ32zLsBpzwAup9it9JGMVx4xpFFuOaoRvgJlrtgwqv65qZEOQspYLzMhMEZMT+2Jqgjd
	 uy88KifgFrqcniWa4vjLkQbGRMDDwkPqKXH+rUTdpk5pjluke0vAzkD5q805vEjCdkpSR
	 aTm8mTlVn2XRPdER2eJDYYtfPTtreHb8I8RSWuSSZwVyUF1nkPioKhnTeWplC5gUahlBh
	 OuHMFw1cIzESgQ4QQKw3ydnPhUXXeYqZrEuQeAYVY6QmWZqSvmwqxYjRH/A6RSDsX+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050294;
	bh=jn20dXGMuiV9UZfmzYFPx1X2Fc/wqR/d9h5Xs2gpM2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LdRdjOa7YFb3Qr6jcZ2z1jmuPEKF6G9p10+9GoTJg2R11hW5WVifnbIkLjdbyA0Mu
	 HAtEGfsEjGzbC885OBBe8FaPiOMNaPaz6J9MBdunXoV2Gf/4dH+yrGQyh4c1u5qlEA
	 +oqKxuH+xNhF6rVKdCtEe79Qr52yL9SbP+E4akT6nPWlDg3ahmJYvCf37NlxDBMcLf
	 /Lk3oc7OgwnE4zhOto0Eb4AhOPUQYaj5SuLvClv3O2+zxBCJToXR09Spsy96nVnVn4
	 OXc4XhNg5SU1aKNLTyWzmcAII/49gvrsw/KZTtPhaD5Dcdwh+OM/T4LikSspZYmq/i
	 tqNr8Esfkyeag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D17960607;
	Mon, 26 Oct 2026 21:31:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A5E23421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35D1340604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0As_lLELJxO7 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EE6040603
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050287;
 b=TU4z/hmGr71F/e6ba1XdKCuLoxXUF/8G31c2FH480fVi/a11qKXiCUD/IbXe1guof/MC
 YzhMziqFvpbGKEiFmbnyVs/yQhLEc2MD7l7UH2cdfOt6+vh5u1BD1s8JPBwZinbocjNny
 R5URheJ1oJvIZrgl5dunV/XrkcPHiL1v+QaR3cBBpnsCd4+/THl8ADpk/o515II/OuBMU
 Vp/RcFJLXjkgyQu186B8TAKkufpl8D4x95OF6fWiHQIfoUtzhVUw/krfPKOAb217QURy+
 jxvxIyWBPzUma8qevS5l/dvDMcbCXm2oDP7I5+jBdPSyuH8CMDbh/SGkKUcCWU6riGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050287;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=jn20dXGMuiV9UZfmzYFPx1X2Fc/wqR/d9h5Xs2gpM2k=;
 b=sc3cjqMrTIo/zBa/5iezfbqFU1DeolsjET+QeQVNAOZT7ro1cbJugbss0AoZDtzZEe7+
 yNqvips7EhmCtmjjxRqdyBKF/EAbEzzPFiMCtop6mQG0TTEnvlGxlywjtGh2fyehw3J7U
 /NjEh33gDWgvqbRVPsS4yFMAo28kFxsFvgQD/qoQPv8eccwotgMBANdIrz9/kvD8v8a3x
 rH+DK3yXDOkZusreiKd0qrcQMK4TrZeDzaO6yu3tWl1Ur3sRb9hNTDwToFxbA+Lil3zk3
 /7/lR+ylceJyAc6wKpRpxyyDWIgfsonR/O81aEoqTig2WUc6GIdIiiZ6cdUolDJR9Pw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pE46Jl3v; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pE46Jl3v
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EE6040603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:26 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jD6JB633bzKnD3;
 Mon, 26 Oct 2026 22:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn20dXGMuiV9UZfmzYFPx1X2Fc/wqR/d9h5Xs2gpM2k=;
 b=pE46Jl3vlWpGVNArjHnh7O8a/m+egby8xHenZqwMece+6wSe3b442RzVRl8gaaU+HsLtPC
 Cba5ABl6k4uFsUM9oiTM2fYa5kROfTtMb7B4NVAa90J7ycdFthvXxfauFquCtFbiL3d6Qt
 orRIl5FaiZyEyR/7DkGZ8fCf4dPosNGZ5oNUipNZ9OdJCeRfqbAgKUI2MkRMd+Xn8MT5ha
 WyI+VGbj71t+7c4k8hceva2bATYz+rQRTswynKZHmPV6W+ZAkrnd4yAtR2kiTu1t8jKp5Z
 m/PDbdL2/T4qwdlRqAym5qzX2yFNCDbcmxSMSzyXlz01G378StoBSkMgS3yMXw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] clk: renesas: Minimize R8A77951 H3 clock tables
Date: Mon, 26 Oct 2026 22:30:17 +0100
Message-ID: <20261026213111.453322-2-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
References: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2f6ec0755147a1d8f82
X-MBO-RS-META: iruc3gctqurhha4onuyra8mgrgnk3y89
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

Reduce the clock tables by ifdeffing out clock entries which are
unlikely to be used by U-Boot. This helps reduce the size of the
bootloader in the 3 kiB range. This includes conditional build
of these clock entries:

- Audio
- CAN/CANFD
- INTC/INTC-EX
- MSIOF
- PWM
- SSI
- VIN

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/renesas/r8a7795-cpg-mssr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 4225036a1a9..165ca911029 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -127,9 +127,11 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 };
 
 static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("3dge",			 112,	R8A7795_CLK_ZG),
 	DEF_MOD("fdp1-1",		 118,	R8A7795_CLK_S0D1),
 	DEF_MOD("fdp1-0",		 119,	R8A7795_CLK_S0D1),
+#endif
 	DEF_MOD("tmu4",			 121,	R8A7795_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A7795_CLK_S3D2),
 	DEF_MOD("tmu2",			 123,	R8A7795_CLK_S3D2),
@@ -140,6 +142,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("scif3",		 204,	R8A7795_CLK_S3D4),
 	DEF_MOD("scif1",		 206,	R8A7795_CLK_S3D4),
 	DEF_MOD("scif0",		 207,	R8A7795_CLK_S3D4),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("msiof3",		 208,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof2",		 209,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof1",		 210,	R8A7795_CLK_MSO),
@@ -147,6 +150,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S0D3),
+#endif
 	DEF_MOD("sceg-pub",		 229,	R8A7795_CLK_CR),
 	DEF_MOD("cmt3",			 300,	R8A7795_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A7795_CLK_R),
@@ -166,6 +170,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("usb-dmac0",		 330,	R8A7795_CLK_S3D1),
 	DEF_MOD("usb-dmac1",		 331,	R8A7795_CLK_S3D1),
 	DEF_MOD("rwdt",			 402,	R8A7795_CLK_R),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("intc-ex",		 407,	R8A7795_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S0D3),
 	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S1D2),
@@ -178,12 +183,14 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("drif10",		 513,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif01",		 514,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif00",		 515,	R8A7795_CLK_S3D2),
+#endif
 	DEF_MOD("hscif4",		 516,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif3",		 517,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif2",		 518,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif1",		 519,	R8A7795_CLK_S3D1),
 	DEF_MOD("hscif0",		 520,	R8A7795_CLK_S3D1),
 	DEF_MOD("thermal",		 522,	R8A7795_CLK_CP),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("pwm",			 523,	R8A7795_CLK_S0D12),
 	DEF_MOD("fcpvd2",		 601,	R8A7795_CLK_S0D2),
 	DEF_MOD("fcpvd1",		 602,	R8A7795_CLK_S0D2),
@@ -202,12 +209,14 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("vspbd",		 626,	R8A7795_CLK_S0D1),
 	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S0D1),
+#endif
 	DEF_MOD("ehci3",		 700,	R8A7795_CLK_S3D2),
 	DEF_MOD("ehci2",		 701,	R8A7795_CLK_S3D2),
 	DEF_MOD("ehci1",		 702,	R8A7795_CLK_S3D2),
 	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A7795_CLK_S3D2),
 	DEF_MOD("hsusb3",		 705,	R8A7795_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("cmm3",			 708,	R8A7795_CLK_S2D1),
 	DEF_MOD("cmm2",			 709,	R8A7795_CLK_S2D1),
 	DEF_MOD("cmm1",			 710,	R8A7795_CLK_S2D1),
@@ -231,12 +240,15 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("vin2",			 809,	R8A7795_CLK_S0D2),
 	DEF_MOD("vin1",			 810,	R8A7795_CLK_S0D2),
 	DEF_MOD("vin0",			 811,	R8A7795_CLK_S0D2),
+#endif
 	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S0D6),
 	DEF_MOD("sata0",		 815,	R8A7795_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("imr3",			 820,	R8A7795_CLK_S0D2),
 	DEF_MOD("imr2",			 821,	R8A7795_CLK_S0D2),
 	DEF_MOD("imr1",			 822,	R8A7795_CLK_S0D2),
 	DEF_MOD("imr0",			 823,	R8A7795_CLK_S0D2),
+#endif
 	DEF_MOD("gpio7",		 905,	R8A7795_CLK_S3D4),
 	DEF_MOD("gpio6",		 906,	R8A7795_CLK_S3D4),
 	DEF_MOD("gpio5",		 907,	R8A7795_CLK_S3D4),
@@ -245,19 +257,24 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("gpio2",		 910,	R8A7795_CLK_S3D4),
 	DEF_MOD("gpio1",		 911,	R8A7795_CLK_S3D4),
 	DEF_MOD("gpio0",		 912,	R8A7795_CLK_S3D4),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("can-fd",		 914,	R8A7795_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A7795_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A7795_CLK_S3D4),
+#endif
 	DEF_MOD("rpc-if",		 917,	R8A7795_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A7795_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A7795_CLK_S0D6),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("adg",			 922,	R8A7795_CLK_S0D4),
+#endif
 	DEF_MOD("i2c-dvfs",		 926,	R8A7795_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A7795_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A7795_CLK_S0D6),
 	DEF_MOD("i2c2",			 929,	R8A7795_CLK_S3D2),
 	DEF_MOD("i2c1",			 930,	R8A7795_CLK_S3D2),
 	DEF_MOD("i2c0",			 931,	R8A7795_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("ssi-all",		1005,	R8A7795_CLK_S3D4),
 	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
@@ -284,6 +301,7 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("scu-src2",		1029,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src1",		1030,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src0",		1031,	MOD_CLK_ID(1017)),
+#endif
 };
 
 /*
-- 
2.53.0

