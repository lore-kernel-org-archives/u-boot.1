Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A1606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zjSSxI9/;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=PPMvyOr8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 283C0810C1;
	Tue, 17 Nov 2026 11:37:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oupvwhyri0qS; Tue, 17 Nov 2026 11:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BDD2810BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915462;
	b=kyuXDFOlioYybR+/tM4PcZ0tuzWY9oZV2xlpIK8rDKeS04gQbLjWgmqEK/dxDTJFG0yT
	 MDQHgWntP+8+CtE214Q70Wj5D7UAV7yCd/vkcGPffR42s2F3+VpJGFKvR2CpaoXx58OtX
	 2cMQPrIrYsmrL2/xtTPs3YpoXh7zZTWAaj1cgaLqokbxDYmcxW0tNVd5D5BE2yvRJxzFi
	 BGllYfu7L6+96//AWNVmpV/bMXaiDCJKyKKNh4NgNbHOtjY7bCcRLPwkxPAGROIqfvYWC
	 FkybylXnqyxS4Yy0gugTrF3Q1iaf44CuTKnCarxXyMx1F56hZe5q+4226qh6M/KByoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sMOJuBSX0HUQD6XF/r6F2OJDXqY/8zSWMaFGvk3289M=;
	b=iksSM6Il5j+nXIg3XuRY36OWAT2X2pTxkJyCl/YRYu863sYnTTpbwJmaZ1CcGeHURaE8
	 RvX8DcRAeKd9w7WfwuAU0qtIvEtAiGP5gOGciP4Fvh0Yn7QEE21lKnX/gM/T1HSgBw/Wy
	 rczlm+otpW9fOklvO9OakWf392C7sZSjne4t+WCVY1gPggvAM+4klKUIvrRZ6iIeGp6+P
	 cwISyB7iWQlJ4BympZm1fNCVlm+GsPHjompyX6DsEkGWxLcu7LKldMcMdetBQ0O/qlcSH
	 MLihpRQ7/FBrPUMYX9KqQ2tzrkt7hpELFMHkhAJu5kHepSaDvo2+FApbZMDF6jeiJDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=PPMvyOr8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915462;
	bh=sMOJuBSX0HUQD6XF/r6F2OJDXqY/8zSWMaFGvk3289M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zjSSxI9/tfmqetxwnXLjEqaXzeg5EffYOKERoz+T816Q4mM5QRPz9Q23qZ3b0eVL5
	 nJLhvD9LnMNjxOPnBjqXmplPz2Z6BBaIodfOIU7Vf7e0dcAVeUOscsbjBStqIpLyc+
	 QtC5fk6vu5q8SimwDixmRswVhChFD3M9dlLlDa5F9jRKYjq9Rx6vz8OYt37MuS/mJZ
	 EaI0yupQLqrn1RGqdzzPu+rqL814YsmdqSL/o9Avdk4o4xJWBLaUxP/a7mP0djuMo8
	 nMJERjkxiuJBA1QlST6NSuOXQwbyk2qmQy7UNZe9A1GaFiMjz8qzgrViKkmF64mvwe
	 E/O3r8CfgucuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BDD2810BC;
	Tue, 17 Nov 2026 11:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DE34977
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B11F810A1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49x6R7izHACJ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FD018109F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=PPMvyOr8
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FD018109F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:33 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4q0Y92zwK;
 Tue, 17 Nov 2026 12:37:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915450;
 bh=sMOJuBSX0HUQD6XF/r6F2OJDXqY/8zSWMaFGvk3289M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PPMvyOr8q1DL9+bIrdAnALNugrU9Q9YqQYUGjNcIl4+Yg/WqvyZf6WD+UvE2abq+Y
 g5APaOnBoHxem77Xq9toHBA3vWNMWS4HDTOlid/zgPC4SChvlpzWvBqApcrbTYB2Jx
 R5zu5aMxxeHK2dATZ7uzUdUZklE9K2fH3hyF2NWSVHgjHp3C2n2RES7NY5+SctWJNf
 dB5tZu2Hp4lDT4UJAjDk4L9NbxhsmlgUYOFXPsfulsN2sGDx0BZSHi7prFouPFW6ts
 Vl7xICkIQqBCCZvwpgyj5s/InRbmC9GAC1LgEKrivBmOLWkdko7LEZvOyOaXmFEqzV
 F0Cc1w+1IF+NQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4n4yNlz7PY; Tue, 17 Nov 2026 12:37:29 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:15 +0100
Subject: [PATCH next 6/8] clk: rockchip: rk3576: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-6-25521d4e37c3@cherry.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

There's no PLL_CON88/96/97/104/105/112, PHP_PLL_CON128/129 or LPLL_CON16
in the TRM so one needs to do an additional lookup the header file to
know what exactly this refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h | 10 +++++++---
 drivers/clk/rockchip/clk_rk3576.c               | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
index 6adb532a37b4..8af39102ea79 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3576.h
@@ -108,7 +108,11 @@ struct pll_rate_table {
 #define RK3576_LITCORE_GRF_BASE		0x2600E000
 #define RK3576_CCI_GRF_BASE		0x26010000
 
-#define RK3576_PLL_CON(x)		((x) * 0x4)
+#define RK3576_BPLL_CON(x)		(0x0000 + (x) * 0x4)
+#define RK3576_VPLL_CON(x)		(0x0160 + (x) * 0x4)
+#define RK3576_AUPLL_CON(x)		(0x0180 + (x) * 0x4)
+#define RK3576_CPLL_CON(x)		(0x01a0 + (x) * 0x4)
+#define RK3576_GPLL_CON(x)		(0x01c0 + (x) * 0x4)
 #define RK3576_MODE_CON0		0x280
 #define RK3576_BPLL_MODE_CON0		(RK3576_BIGCORE_CRU_BASE + 0x280)
 #define RK3576_LPLL_MODE_CON0		(RK3576_LITCORE_CRU_BASE + 0x280)
@@ -126,7 +130,7 @@ struct pll_rate_table {
 #define RK3576_SDMMC_CON0		0xC30
 #define RK3576_SDMMC_CON1		0xC34
 
-#define RK3576_PHP_PLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE)
+#define RK3576_PHP_PPLL_CON(x)		((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x200)
 #define RK3576_PHP_CLKSEL_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x300)
 #define RK3576_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0x800)
 #define RK3576_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PHP_CRU_BASE + 0xa00)
@@ -135,7 +139,7 @@ struct pll_rate_table {
 #define RK3576_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0x800)
 #define RK3576_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3576_PMU_CRU_BASE + 0xa00)
 
-#define RK3576_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE)
+#define RK3576_CCI_LPLL_CON(x)		((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x040)
 #define RK3576_CCI_CLKSEL_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x300)
 #define RK3576_CCI_CLKGATE_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0x800)
 #define RK3576_CCI_SOFTRST_CON(x)	((x) * 0x4 + RK3576_CCI_CRU_BASE + 0xa00)
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 8fd44138a453..03f5bfb61679 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -43,19 +43,19 @@ static struct rockchip_pll_rate_table rk3576_24m_pll_rates[] = {
 };
 
 static struct rockchip_pll_clock rk3576_pll_clks[] = {
-	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_PLL_CON(0),
+	[BPLL] = PLL(pll_rk3588, PLL_BPLL, RK3576_BPLL_CON(0),
 		     RK3576_BPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
-	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_LPLL_CON(16),
+	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3576_CCI_LPLL_CON(0),
 		     RK3576_LPLL_MODE_CON0, 0, 15, 0, rk3576_24m_pll_rates),
-	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_PLL_CON(88),
+	[VPLL] = PLL(pll_rk3588, PLL_VPLL, RK3576_VPLL_CON(0),
 		     RK3576_MODE_CON0, 4, 15, 0, rk3576_24m_pll_rates),
-	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_PLL_CON(96),
+	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3576_AUPLL_CON(0),
 		      RK3576_MODE_CON0, 6, 15, 0, rk3576_24m_pll_rates),
-	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_PLL_CON(104),
+	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3576_CPLL_CON(0),
 		     RK3576_MODE_CON0, 8, 15, 0, rk3576_24m_pll_rates),
-	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_PLL_CON(112),
+	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3576_GPLL_CON(0),
 		     RK3576_MODE_CON0, 2, 15, 0, rk3576_24m_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3576_PHP_PPLL_CON(0),
 		     RK3576_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3576_24m_pll_rates),
 };
@@ -2454,11 +2454,11 @@ static int rk3576_clk_probe(struct udevice *dev)
 	       RK3576_SCRU_BASE + RK3576_SCRU_MODE_CON0);
 	/* fix ppll\aupll\cpll */
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_CRU_BASE + RK3576_PHP_PLL_CON(129));
+	       RK3576_CRU_BASE + RK3576_PHP_PPLL_CON(1));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_CRU_BASE + RK3576_PLL_CON(97));
+	       RK3576_CRU_BASE + RK3576_AUPLL_CON(1));
 	writel(BITS_WITH_WMASK(2, 0x7U, 6),
-	       RK3576_CRU_BASE + RK3576_PLL_CON(105));
+	       RK3576_CRU_BASE + RK3576_CPLL_CON(1));
 	writel(BITS_WITH_WMASK(1, 0x3U, 6),
 	       RK3576_CRU_BASE + RK3576_MODE_CON0);
 	writel(BITS_WITH_WMASK(1, 0x3U, 8),

-- 
2.56.1

