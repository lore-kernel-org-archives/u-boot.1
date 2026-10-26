Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB76606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P+gzwyn+;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jm07rcm5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A63F680D97;
	Mon, 26 Oct 2026 21:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EDmF6KW6HU04; Mon, 26 Oct 2026 21:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DCFE80D7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793050297;
	b=siaSnXyXtVtPSziz/eoa7KGPWzU8m9Ob2I6kd/UvcTqrjfXuLW75uect6ae+4KsGIA19
	 T3ES1p3rZtAbzMT2W3GAGVmG2xyukdbxpySP04a2ys4FiYkFXqcYvsKxSscatiYhPlo9y
	 M39yQ6zWt1dAVb+aH1FBPwY7ceuUxGScH4ocJmNeJHW39RMc53jy9QQZobxrpuLtbrYkQ
	 xiyBbfX7eaZ4+5fHWbnD2+NmMQbjAJjlUpIkXnduq7nj1zX6726gBOo6A7nwK1V+kcLzn
	 s8GTEM6IfYKPxPMHbaZefbGql/SEEFzG5GREHL9gyjRSPM6bRIq4KsMAuJLXT5qky8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793050297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NdCdxV0vt4EfuLGQ/xxxOcQvxK2r3yVgQoMq97iXjtA=;
	b=BKB3p7V7gLTrhwfvZOEJ8SHaU5De2RJQgMY+Q81bSBqUhcdYLwzuLZ6JntdzxEnNlNFS
	 LhHQZ7C8beOv/EROchUlYr2nO0VJnAw7O8caegFJCj40KVwmJBcm5YEBMDBhfhrUrPD9f
	 gqhDfe2o8PjMbrRAv5EvV8LxYZl7jnJ8Q4k0+tavDCme98UGUzg/IvkFtfJz6izHuEq3T
	 CI5qRia7bBmj5wXTG4o8w01KI6CqHUaXm9Lgs9/1PuU9TvjdMipIpVAMG+WAUGtXxeMGl
	 dnuDt147+YSYxvEvH+7jneDo1o80R75bhnQJATbTONuIhl15MR2aMT/kMoUyOkMhZYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jm07rcm5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793050297;
	bh=NdCdxV0vt4EfuLGQ/xxxOcQvxK2r3yVgQoMq97iXjtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+gzwyn+mIPF/jUMuHbojfifoZstUQnBKfQX+sG/4a9MGuU3cq9Lvw1zGX5mLQjZb
	 XESz3303/F8ESAuXeME1n59ULw1UNvf7ErDAyT39Fm6wTlTkZLHSca2w7Jx+D2png4
	 3+8xP58VmbFN9ylV1RzmzVUoa7TtKIQ3IiKh2S2kp3rOMkC3u9UZ6zQICN5u/zfjvr
	 pmVvVwXIRb/BaSgKqCEOgCU16m6yK2TKg9S1vNaF2wFwDwtU22VXAUH8QHqTXQ7Yk5
	 P1F1Slbe4FG5zW2RkuLIPdWWFwFKug5sflRnvOCK935+asbU/fZo4oQUjtmNFV2Rza
	 SFtj5zRL0AIfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DCFE80D7F;
	Mon, 26 Oct 2026 21:31:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 61BD53421
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F5AC80CCC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V51ypf3tKXN7 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 45E4980970
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793050288;
 b=Txd91oR6xEKF4RBwiSv6Ry+RHwXLk3RwI/ttmg1KVhcyGhvi1a4f6jUfgE6Fn9tulCzf
 uY7Fu6M8pth7Z5CHFog1i7lZC187w8QOPqhfWOK9/hjXGL0DXDLtC0XBXeYzRpx6sLuGv
 AsjFB5in4pR9ZtIM4nw6DINfYe7N6UlaOiSuDg1i5YpLurYkNM+uTH7DtB2EVKxV1tEY/
 rR0i8OXvY7RddEuPMz90ouCX92dW/QYbrrV4c94V7tgW4y/2slF5OQ0cEBsvAZZONPJlk
 WCu/aVZDdgXyRpQs9HwvF5Lfd20I9+C0lpcvoZpqbiMahuqmb7vnPtS8cALNV5jOEyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793050288;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=NdCdxV0vt4EfuLGQ/xxxOcQvxK2r3yVgQoMq97iXjtA=;
 b=ee3rpdmA1/tGF4jFd5lSsP9vB6XSxlZZohDFvkvfmYUXQ1sQXOmg9SF2qQ50p2jVfaan
 BM0hZowip0UaskAbMS+9KwwIlWo81DK8X20ITct9qEo2zW+r2q7kw/feC/npEfAv8VYO2
 OLyk2/yOshVQivjOvKIjNgMA2oorFk2OPzLV0OP12p+VYPvBFnE8lfpHxjMcNTaroDrA6
 JIPcY94s184aLVa80dqfk2WAjHrn58gfYcamyqh/WM8/3sseOgAmf1uVcntqW37yRcJjC
 4rN1TMWufsNrHBTBUbd3yMalv/gPMJsZLg0RJlnBG807Hd1Q6u7RCaJFRb0piSJ7ivQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jm07rcm5; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jm07rcm5
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45E4980970
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:31:27 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jD6JD2tHqzMlWn;
 Mon, 26 Oct 2026 22:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793050284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdCdxV0vt4EfuLGQ/xxxOcQvxK2r3yVgQoMq97iXjtA=;
 b=jm07rcm5kIZ407pBaHOsQvuxwG1ygQA7cdm+ZzeXLt/UJnMQ6By7tIpgEqC2H71EphhCNf
 CUjGjMM02Os7reJ+C86zeUybZnOpSCiHrTt/yPzaFQwXccJoxuqOv2qIGTBRD8m1HFd5Qg
 l1ediF/G7ZlhXYqQpkUFogBuw5nVpZwji++vfNAhIaTysnypOt8hs/hD6PlcDYFLQyCvgS
 SkLXW0DK1m/DvNx17CA+zv1HlfE3mQAnTr5PrGzvmiWKNJqVDSaPzKOgRgxQVr8TAhjdO5
 0s74ARrN604RkeswtjuFWVhtao8CK6RYHsBP3+GE6SSpDHAGG+gZO1hQZy8wbg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] clk: renesas: Minimize R8A77965 M3-N clock tables
Date: Mon, 26 Oct 2026 22:30:19 +0100
Message-ID: <20261026213111.453322-4-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
References: <20261026213111.453322-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9338389d33d6c2bc9ae
X-MBO-RS-META: w1th17xgekk9untrujo769fdmtsan5ai
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
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 037861eb9b4..d7f203f0268 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -125,7 +125,9 @@ static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("3dge",			112,	R8A77965_CLK_ZG),
+#endif
 	DEF_MOD("fdp1-0",		119,	R8A77965_CLK_S0D1),
 	DEF_MOD("tmu4",			121,	R8A77965_CLK_S0D6),
 	DEF_MOD("tmu3",			122,	R8A77965_CLK_S3D2),
@@ -163,6 +165,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("usb-dmac1",		331,	R8A77965_CLK_S3D1),
 
 	DEF_MOD("rwdt",			402,	R8A77965_CLK_R),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("intc-ex",		407,	R8A77965_CLK_CP),
 	DEF_MOD("intc-ap",		408,	R8A77965_CLK_S0D3),
 
@@ -176,12 +179,14 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("drif10",		513,	R8A77965_CLK_S3D2),
 	DEF_MOD("drif01",		514,	R8A77965_CLK_S3D2),
 	DEF_MOD("drif00",		515,	R8A77965_CLK_S3D2),
+#endif
 	DEF_MOD("hscif4",		516,	R8A77965_CLK_S3D1),
 	DEF_MOD("hscif3",		517,	R8A77965_CLK_S3D1),
 	DEF_MOD("hscif2",		518,	R8A77965_CLK_S3D1),
 	DEF_MOD("hscif1",		519,	R8A77965_CLK_S3D1),
 	DEF_MOD("hscif0",		520,	R8A77965_CLK_S3D1),
 	DEF_MOD("thermal",		522,	R8A77965_CLK_CP),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("pwm",			523,	R8A77965_CLK_S0D12),
 
 	DEF_MOD("fcpvd1",		602,	R8A77965_CLK_S0D2),
@@ -194,10 +199,12 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("vspd0",		623,	R8A77965_CLK_S0D2),
 	DEF_MOD("vspb",			626,	R8A77965_CLK_S0D1),
 	DEF_MOD("vspi0",		631,	R8A77965_CLK_S0D1),
+#endif
 
 	DEF_MOD("ehci1",		702,	R8A77965_CLK_S3D2),
 	DEF_MOD("ehci0",		703,	R8A77965_CLK_S3D2),
 	DEF_MOD("hsusb",		704,	R8A77965_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("cmm3",			708,	R8A77965_CLK_S2D1),
 	DEF_MOD("cmm1",			710,	R8A77965_CLK_S2D1),
 	DEF_MOD("cmm0",			711,	R8A77965_CLK_S2D1),
@@ -218,10 +225,13 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("vin2",			809,	R8A77965_CLK_S0D2),
 	DEF_MOD("vin1",			810,	R8A77965_CLK_S0D2),
 	DEF_MOD("vin0",			811,	R8A77965_CLK_S0D2),
+#endif
 	DEF_MOD("etheravb",		812,	R8A77965_CLK_S0D6),
 	DEF_MOD("sata0",		815,	R8A77965_CLK_S3D2),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("imr1",			822,	R8A77965_CLK_S0D2),
 	DEF_MOD("imr0",			823,	R8A77965_CLK_S0D2),
+#endif
 
 	DEF_MOD("gpio7",		905,	R8A77965_CLK_S3D4),
 	DEF_MOD("gpio6",		906,	R8A77965_CLK_S3D4),
@@ -231,13 +241,17 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("gpio2",		910,	R8A77965_CLK_S3D4),
 	DEF_MOD("gpio1",		911,	R8A77965_CLK_S3D4),
 	DEF_MOD("gpio0",		912,	R8A77965_CLK_S3D4),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("can-fd",		914,	R8A77965_CLK_S3D2),
 	DEF_MOD("can-if1",		915,	R8A77965_CLK_S3D4),
 	DEF_MOD("can-if0",		916,	R8A77965_CLK_S3D4),
+#endif
 	DEF_MOD("rpc-if",		917,	R8A77965_CLK_RPCD2),
 	DEF_MOD("i2c6",			918,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c5",			919,	R8A77965_CLK_S0D6),
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("adg",			922,	R8A77965_CLK_S0D4),
+#endif
 	DEF_MOD("i2c-dvfs",		926,	R8A77965_CLK_CP),
 	DEF_MOD("i2c4",			927,	R8A77965_CLK_S0D6),
 	DEF_MOD("i2c3",			928,	R8A77965_CLK_S0D6),
@@ -245,6 +259,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("i2c1",			930,	R8A77965_CLK_S3D2),
 	DEF_MOD("i2c0",			931,	R8A77965_CLK_S3D2),
 
+#ifdef CONFIG_CLK_RENESAS_FULL
 	DEF_MOD("ssi-all",		1005,	R8A77965_CLK_S3D4),
 	DEF_MOD("ssi9",			1006,	MOD_CLK_ID(1005)),
 	DEF_MOD("ssi8",			1007,	MOD_CLK_ID(1005)),
@@ -272,6 +287,7 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("scu-src2",		1029,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src1",		1030,	MOD_CLK_ID(1017)),
 	DEF_MOD("scu-src0",		1031,	MOD_CLK_ID(1017)),
+#endif
 };
 
 /*
-- 
2.53.0

