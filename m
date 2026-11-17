Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E12606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BUdtwcp9;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=fXtOdGBk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD2856087E;
	Tue, 17 Nov 2026 11:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cr7jp1bZ2d-Q; Tue, 17 Nov 2026 11:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D95EB6085F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915459;
	b=pniCp505ip56Erobuh1e9SeQasbrM7dtO5pYsXHAr/7z5HwnrTWB1/Gft9JNoeAqbkvB
	 aQSc9N51U2gffQF6+LuPLr3NynIk26SdJXwBzMONgJkg7lUCE5xF2S2n5ATldp5Iz0fhM
	 tlGWLOMiLDn8fR7JuYsTqikwAz/ha77JU8vnXjsd1XAIkJRlCBJ7EdPLOvRm3siL2n3Sm
	 TZEOi15/IYgqIyb7Z1AeADPEQ+31X1InHWyT1T72OX+9JGeTZiOxsuRVvhdsJG/D5gNiz
	 DpxgOF3aU94vFRSwBDdx9SS8byB5B+yX18ldp+gkk6yjTB7SZbcw+AmQkA0SN97eUNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QZ1yqR+KThymYO8GLtmFqWsV44/Szjh53r77mnlkICQ=;
	b=Ziv17i4+DVKG3rest6VGydHtb1AnKaPhBc35Jr6wv+oOyGVdry2EZzV+TMf8l1TDsh8F
	 G6n1a8aiHrydqY9rzOakmb9wdGxOorsSXTscA2NKJPRwBtHQPIy7jDemTauRLtJGLsFTC
	 Dvlq2O5QwmpSs/kWtLZSAZyCyW69PblOdPAKJqG9PJQxzaGVucBFbO+WqpR1993WwrVHp
	 imrorsiwlZVD5FwC9vSc6cDk+h4mb1c4BbLq464U4L88S4ThsLEbCmvTDh1ZAY4f42bM0
	 /Pm7vcgr7Ml/xYU2PNS9YnI7uacCmExplRxxdVacV4Z+Bok81d07sA0BR+wGjVQYsBA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915459;
	bh=QZ1yqR+KThymYO8GLtmFqWsV44/Szjh53r77mnlkICQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BUdtwcp9o+5bke+T5s9XMCidZHfZ8s7DfAa1dzzuzTiBV+caTKsQJFHBBTHabv2Cd
	 p9WJ57NsXTNySksEL+m8qNlbvnwXX3Hyi4OaCuNStdrk9YGZKO7uC34KCvrdA/XDiN
	 aqBGEHTrn0Lpw+fjRyHDeCLafaqjetYQViRr9Fg+PYOzafMfztbLO+CgeYfrFV1kWW
	 zsyLzXVMUAqgtn8HMS43aIyi08dya89BJInGZnosnR5GvLZQuvLy5RM8G8eIerAVon
	 c3X4bvZ2pENJc0a7CX9dJAbbmcWVy9O15u6ZQa3FG9dixlXMywsHarFi6XSDZPeXNS
	 iBH2ihumFDgGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D95EB6085F;
	Tue, 17 Nov 2026 11:37:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68FA0977
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BED1810A1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ct_ReQ7TPU6A for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EB6181027
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fXtOdGBk
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EB6181027
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:32 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4l6R5xzmPy;
 Tue, 17 Nov 2026 12:37:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915447;
 bh=QZ1yqR+KThymYO8GLtmFqWsV44/Szjh53r77mnlkICQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fXtOdGBk4zkkBEyrXqJMBSyrAaxrd/28B27NkLONqBrShGTZ3XP5raycl7GHFEr05
 MMYjGzRlzBwdOEP3LJB3HcSgi1FQTUb52iw26LSP/NJZBLJSyEuWtl4ZfKAN8j44WT
 Clw7N0S4zVdyGtsDXDhH0gKf6ci9FA18n7sg8j5CqZJyxzAwf9Gbz3urtAtaaMe7KQ
 d/gGFVASiGO4mpgc+pj6okJORMM5bz0EyC6WYC3OoxuHm48xDLjBFTVNnri8fR6V+A
 1+J/LbeN6xL6v4nK4mYrPA23cDuVfUrL7K32SSEvpsTCRm3lQ0YNYnXufXrSyMpOMq
 mrNH0pRit21aA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4k5JNdz8j0; Tue, 17 Nov 2026 12:37:26 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:12 +0100
Subject: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
In-Reply-To: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
lookup the header file to know what exactly this refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
 drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
index 9ddd6215fc53..331b100ced54 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
@@ -48,7 +48,9 @@ struct pll_rate_table {
 #define RK3506_SOFTRST_CON0		0x0a00
 #define RK3506_GLB_SRST_FST		0x0c08
 #define RK3506_GLB_SRST_SND		0x0c0c
-#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
+#define RK3506_PMU_GPLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
+#define RK3506_PMU_VPLL0_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
+#define RK3506_PMU_VPLL1_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
 #define RK3506_SCRU_BASE		0xff9a8000
 #define RK3506_PMU_CRU_BASE		0xff9b0000
 #define RK3506_PMU_CLKSEL_CON(x)	(RK3506_PMU_CRU_BASE + 0x0300 + (x) * 0x4)
diff --git a/drivers/clk/rockchip/clk_rk3506.c b/drivers/clk/rockchip/clk_rk3506.c
index b0c9f311461a..ddfb96ddeb36 100644
--- a/drivers/clk/rockchip/clk_rk3506.c
+++ b/drivers/clk/rockchip/clk_rk3506.c
@@ -58,11 +58,11 @@ static struct rockchip_pll_rate_table rk3506_pll_rates[] = {
 };
 
 static struct rockchip_pll_clock rk3506_pll_clks[] = {
-	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3506_PLL_CON(0),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3506_PMU_GPLL_CON(0),
 		     RK3506_MODE_CON, 0, 10, 0, rk3506_pll_rates),
-	[V0PLL] = PLL(pll_rk3328, PLL_V0PLL, RK3506_PLL_CON(8),
+	[V0PLL] = PLL(pll_rk3328, PLL_V0PLL, RK3506_PMU_VPLL0_CON(0),
 		      RK3506_MODE_CON, 2, 10, 0, rk3506_pll_rates),
-	[V1PLL] = PLL(pll_rk3328, PLL_V1PLL, RK3506_PLL_CON(16),
+	[V1PLL] = PLL(pll_rk3328, PLL_V1PLL, RK3506_PMU_VPLL1_CON(0),
 		      RK3506_MODE_CON, 4, 10, 0, rk3506_pll_rates),
 };
 

-- 
2.56.1

