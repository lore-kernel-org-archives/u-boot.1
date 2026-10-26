Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D334606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j/+/Scch;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=g6soWjIJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 297E480CD9;
	Mon, 26 Oct 2026 21:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nxXaQI0OXdXm; Mon, 26 Oct 2026 21:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 594E080C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050289;
	b=dokLRxy/T+ia6OyYpHEyxnU+bUiF2tELIHT/k73j06a+ePqtKtpb6qXKconr3HuZ0hDU
	 /P5nu+eoQ+YbWpd9AMNJRWmBWHqHHn8/eKyf9rpNgxmZkrgEWgoqbtgcuFPJrM3H8StSa
	 axAZoO2txqKktA8Ll64jLms8NZo8eA74K+Tu0zPsZhqcUhHQ8DrYBoGykkRktZehTELjA
	 g5WoIXqws7xmgvf2RF5yZHRMmhjTX7/+ojaPXY8USAkQbiHJYeTQaQFywUatttAdKScdt
	 4zL8TtKg03Ro6iZY5tnXpLKUAxqfipj1uuBPR5cjKhLV6QAKUyc/PQqqO2XdmGJOblg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WhvMwsu462RSdDsVRMwa1bqvi/LaacPobZ4bOIiuXpE=;
	b=eZPm+Vot9qrx6W80tvqqU+7KF2hLiE49146CfBsQG/qQ1r5MFQPaRsVSOG2G2FuJZVDJ
	 FafOVkGg3dQxFmXOe6SjVwzcrKvoEAtEGaq0Sd+sTTWvAdMY71CuuUD3uTxnmetfN47Vu
	 fBdkZ6vRaxww6Db3dEg2Ttb/76mRVn5imZhZKPZ5LOgPNo0CUBnmR+MuemyVDqnbSyyrv
	 GOQyz+VEjOSqt6MUfbYvAaQanVy2Y5aO7axc8MyF6mcBJSV0Tw1pHLF1nEKZL5QzE5EZO
	 3lRh1X5D+lq0NjoCmr3FhbAzvjC1fiEgTrfYTjESn5CK8XpPUhEeCN/639EdrLFIgfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=g6soWjIJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050289;
	bh=WhvMwsu462RSdDsVRMwa1bqvi/LaacPobZ4bOIiuXpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/+/ScchyP2RJKUwC/hG5/JkoNEoOjKsglkw4MGooN5AcZo8K7AT6nX1eOlFplhvP
	 aHj6m7gAUdssPJgQw2Hhn4JcqNuk8kVQydg7WWA7rPApkmvxqgLXJF2j5OxQm1Hjf4
	 TF9K6qnANhUqEmPJTcZFWEUecNw4fjA7MmqzCCIY9HEBWADREevHYmayq8gK+PU8G8
	 r+UNUqInOE9L8Ahfxwwp1scU392US9LgoSJ6BkV6S/guKediCoESiqIT/5Vk6Ef6L6
	 BFJsjfE/Y+cE1BODmoGSBoLII9uS82CT+ctHbeNSxOMO0ZNLHiibqB+reGto/+nuAv
	 iNo6CWythHwnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 594E080C68;
	Mon, 26 Oct 2026 21:31:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12B9E2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 102FC80C34
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GZNG-NKoA10E for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 463F280970
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050287;
 b=CO+5RQN3OtxH/eW1NvNXgDxrd9yemy0cC9oodZVfYSjo2NR2Ku0+yHrGqYfe9A9GFLuV
 +9OmR09uYEwDkl/Z/ZsSuxrQMg1HXgJ56Wv0lo1f+dIfvBdcKlyILjnEqXQ6zlXA5Gnzw
 Bjlb9vGu1vMmq/qSmgt9V9cd/j7mQHT2rVnmUbghllw3LFaunx64dmUU4opH9I8kSETWt
 Hrk1MCMYv0UoLHDtm8mVTN9cje/o5cq/41KA/ax0rwhujdw0j93oMjO0fiN//WTv7xIVe
 487mptewDTcrIHN981QRYe6CD+krloTf3PxVbTDbOENEnbxzFwYgcuooun5Oytl7AqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050287;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=WhvMwsu462RSdDsVRMwa1bqvi/LaacPobZ4bOIiuXpE=;
 b=DmG1x2eCgt1npumfqiB8pcDaJ+b8wEhkbW2OOW57He/W0U/6YQUU9CfG7rru/41McIfV
 wXN7c1ef6Vk3k3Hils/gqQV46YjFecKv6th1pYDu2uJXm6RPllrmiRqE0XJlopmHjer4X
 jffXCWODfJlKyAzEVsEyCkKUo3KcLCEAew+h80lEO49aNqAIdJCIGMxeGfOsLEU70lD9g
 1sdI9ubx4AvsCGP+PM5GN4ROR0wanrzXJFEgdeQqoYw0PGdx4CB07m0y4iEtE+ZvAUMMi
 z+2gujbb58Z+zVsoZQujz2zXz+3V6dFmjzqAX+6wUAirbmrFP14cq+EglUPo8BtD4rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=g6soWjIJ; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=g6soWjIJ
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 463F280970
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:26 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jD6JC3jVkzKngK;
 Mon, 26 Oct 2026 22:31:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhvMwsu462RSdDsVRMwa1bqvi/LaacPobZ4bOIiuXpE=;
 b=g6soWjIJ+qPm1VxtYS55bLmwmVSOuWmVxp/cAQBuQHN6GyfRQmwBl+3SytUDNKPlq9C2W+
 DVFkj0Sze2rDDCt6r4GoNnBuNRIBOSBNdOdn5zdA0v8Drv5kZ0FY5KxwPhfzmabj0Ku+6b
 aSScquyx7RqfoJnWqp1fOkr5zKQFLb9LWEZrFkARg9KS9sSMJPIaIKQVSmwQqlps9eTVKs
 g41bqDSGX6tlB2Tn+onYoIGVxzXiyWi18rTyvumeyZ22h95u+DWbyKWonjgCwQFTTJDPNO
 sAYyvp5gYa9v9OZnrCEK2gWH4FWCpB3A7QsXrVHCHsWuxmMH4GTgcqgpt50dNQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] clk: renesas: Minimize R8A77960 M3-W and R8A77961 M3-W+
 clock tables
Date: Mon, 26 Oct 2026 22:30:18 +0100
Message-ID: <20261026213111.453322-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
References: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 569352a3b596da8afcf
X-MBO-RS-META: gdsj73ixso9yzpjywr8cpq3zzxyw9dmh
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
 drivers/clk/renesas/r8a7796-cpg-mssr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 02b078ad3df..ec1f62c3fb0 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -129,7 +129,9 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 };
 
 static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("3dge",			 112,	R8A7796_CLK_ZG),
+#endif
 	DEF_MOD("fdp1-0",		 119,	R8A7796_CLK_S0D1),
 	DEF_MOD("tmu4",			 121,	R8A7796_CLK_S0D6),
 	DEF_MOD("tmu3",			 122,	R8A7796_CLK_S3D2),
@@ -165,6 +167,7 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("usb-dmac0",		 330,	R8A7796_CLK_S3D1),
 	DEF_MOD("usb-dmac1",		 331,	R8A7796_CLK_S3D1),
 	DEF_MOD("rwdt",			 402,	R8A7796_CLK_R),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("intc-ex",		 407,	R8A7796_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A7796_CLK_S0D3),
 	DEF_MOD("audmac1",		 501,	R8A7796_CLK_S1D2),
@@ -177,12 +180,14 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("drif10",		 513,	R8A7796_CLK_S3D2),
 	DEF_MOD("drif01",		 514,	R8A7796_CLK_S3D2),
 	DEF_MOD("drif00",		 515,	R8A7796_CLK_S3D2),
+#endif
 	DEF_MOD("hscif4",		 516,	R8A7796_CLK_S3D1),
 	DEF_MOD("hscif3",		 517,	R8A7796_CLK_S3D1),
 	DEF_MOD("hscif2",		 518,	R8A7796_CLK_S3D1),
 	DEF_MOD("hscif1",		 519,	R8A7796_CLK_S3D1),
 	DEF_MOD("hscif0",		 520,	R8A7796_CLK_S3D1),
 	DEF_MOD("thermal",		 522,	R8A7796_CLK_CP),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("pwm",			 523,	R8A7796_CLK_S0D12),
 	DEF_MOD("fcpvd2",		 601,	R8A7796_CLK_S0D2),
 	DEF_MOD("fcpvd1",		 602,	R8A7796_CLK_S0D2),
@@ -197,9 +202,11 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("vspd0",		 623,	R8A7796_CLK_S0D2),
 	DEF_MOD("vspb",			 626,	R8A7796_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A7796_CLK_S0D1),
+#endif
 	DEF_MOD("ehci1",		 702,	R8A7796_CLK_S3D2),
 	DEF_MOD("ehci0",		 703,	R8A7796_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A7796_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("cmm2",			 709,	R8A7796_CLK_S2D1),
 	DEF_MOD("cmm1",			 710,	R8A7796_CLK_S2D1),
 	DEF_MOD("cmm0",			 711,	R8A7796_CLK_S2D1),
@@ -219,9 +226,12 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("vin2",			 809,	R8A7796_CLK_S0D2),
 	DEF_MOD("vin1",			 810,	R8A7796_CLK_S0D2),
 	DEF_MOD("vin0",			 811,	R8A7796_CLK_S0D2),
+#endif
 	DEF_MOD("etheravb",		 812,	R8A7796_CLK_S0D6),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("imr1",			 822,	R8A7796_CLK_S0D2),
 	DEF_MOD("imr0",			 823,	R8A7796_CLK_S0D2),
+#endif
 	DEF_MOD("gpio7",		 905,	R8A7796_CLK_S3D4),
 	DEF_MOD("gpio6",		 906,	R8A7796_CLK_S3D4),
 	DEF_MOD("gpio5",		 907,	R8A7796_CLK_S3D4),
@@ -230,19 +240,24 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("gpio2",		 910,	R8A7796_CLK_S3D4),
 	DEF_MOD("gpio1",		 911,	R8A7796_CLK_S3D4),
 	DEF_MOD("gpio0",		 912,	R8A7796_CLK_S3D4),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("can-fd",		 914,	R8A7796_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A7796_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A7796_CLK_S3D4),
+#endif
 	DEF_MOD("rpc-if",		 917,	R8A7796_CLK_RPCD2),
 	DEF_MOD("i2c6",			 918,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c5",			 919,	R8A7796_CLK_S0D6),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("adg",			 922,	R8A7796_CLK_S0D4),
+#endif
 	DEF_MOD("i2c-dvfs",		 926,	R8A7796_CLK_CP),
 	DEF_MOD("i2c4",			 927,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c3",			 928,	R8A7796_CLK_S0D6),
 	DEF_MOD("i2c2",			 929,	R8A7796_CLK_S3D2),
 	DEF_MOD("i2c1",			 930,	R8A7796_CLK_S3D2),
 	DEF_MOD("i2c0",			 931,	R8A7796_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("ssi-all",		1005,	R8A7796_CLK_S3D4),
 	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
@@ -269,6 +284,7 @@ static struct mssr_mod_clk r8a7796_mod_clks[] __initdata = {
 	DEF_MOD("scu-src2",		1029,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src1",		1030,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src0",		1031,	MOD_CLK_ID(1017)),
+#endif
 };
 
 /*
-- 
2.53.0

