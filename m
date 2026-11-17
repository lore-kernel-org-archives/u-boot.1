Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFE606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P2/MTJQm;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=QaV0nHpe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64A9D407B7;
	Tue, 17 Nov 2026 11:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t4cohrZOvhci; Tue, 17 Nov 2026 11:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 858F1407A4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915465;
	b=RoFQqI8gt9eJVH5I7U84Il7Uj2V3CDZo04pOv/1ISsVgIVlbRZ9GvZOnl3jwzEwq7SuQ
	 lVqgaWG+F9DDACMZPWA9tYYeOmga7u1rNOMEylrA1+uuMaIP7t0pGiU4gRF26ik1O+H3q
	 aTA4K6iI8yaCDA/dPkDWhHY5QQR3RoIQHOCyyZfva0wmgSBBYBcL0iiS1MaKNPLQeIU7a
	 Dh0O6cvoUbY5v8IHr6LVLf8iss3wA1pRIwYVPDk70YQFboAnLYMAz8aCSKKMx/114sg9d
	 fOtqb1urGRIytoodbpNio92WwED2KmWRYm49785ZJ2wnjYx5j/myPTmzzhU6kPQO3kQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KMxx0rkJ/oIvfH7TErA64nnW3fqXO+OkEioln5keRQs=;
	b=BXKkeZjxIIXkC8LxJxY2ZnpvZ6l1jp6PS5swnqseGEI64GPcPUFmwsMAAEeBiI0m2v4F
	 m04EABt18kNjpwCUIixYo0AmvZlVbZP9XeZ1q4EENjB2aIZdYrJuGnEG784kFRzxRWyPv
	 BC9aJPrksISiZUKthL+sVKYjjuHQqA+CYqZMTIGoO7g5mQA30hzN80/Wt665u4LtSOSaC
	 /nn4PTwPHsCLe84QX/fbj1oGi1yoc3w5tcA+o24Ao5gEA+W+rCNsvFvy1UdzogyMNk0Bv
	 ngiweNiZdys6o83sbPQc5ExlWVIEmhACrx+DljugW9tzmKwyiz8btdPjZp/g2wxkZ+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915465;
	bh=KMxx0rkJ/oIvfH7TErA64nnW3fqXO+OkEioln5keRQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P2/MTJQmX3coPcsMo5Kv00H11BXy2PSof2C635n6mzpYIW8EUl+fVp0/1bAwj//6t
	 8C4Q5qUGkr56yISf9O+7SYaAqiwZG0I7z6y1zvDh/ovOIE58qlKbaYnQ8ejwgZtT/D
	 vd1j2T8h+LvNCwHgz/PkGCXONSm1Uev7b1N0ZJNFrpVV9ftIsARe2eoMTHQYguCLNL
	 PP/tjM/k3g9c/ShpcSM5EMYkn6FzIxKsgLgGBXFxdmz9ZpifxEDY8A5agx2Svvzx6I
	 s5uEbdfmUmwQVVQh++ZsyN+9kcEiWr5IX/D4V+JNcG+GL9QFd35N5lq/YdKAvwRP25
	 N41IMOjkMyJpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 858F1407A4;
	Tue, 17 Nov 2026 11:37:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C52FB49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B428C40308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJUlAkpR6KeE for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0C25E402CA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:e38::1908"
X-Greylist: delayed 8277 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 17 Nov 2026 11:37:34 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=QaV0nHpe
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::1908; helo=smtp-1908.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::1908])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C25E402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:37:34 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4r07QnzfF;
 Tue, 17 Nov 2026 12:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915451;
 bh=KMxx0rkJ/oIvfH7TErA64nnW3fqXO+OkEioln5keRQs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QaV0nHpe5zDMITtSlrk/T/Fq0CXtckos7yzBLFQCrdPKpPSDouwLY5T52dPykGP/F
 5xDWgqi+JkjvfYu/7pA/tgJLIIth6k0a0BG8ZZLyN2af0Lq/vNHDidYS9AdU1o65/l
 hRms7NHCCCiofucIG74cpXwXkFYdhvEZ3yLGmS7Lqxd2I95JZRpSiPG9xLtHteTOwl
 SQXRNr54d1liwawd68t+qNcZmMb2TmY7Aw2qocTKOPPp440NLgLIji0UNVnV2tZgQQ
 hf/s36MnaYPMUlyhcXhER0kcMuBl+OTuAQPLstcTd7T3MczLPE1pUWD3qD8MmEPS4C
 bkB9asjBgqoXA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4p6M8kz8W2; Tue, 17 Nov 2026 12:37:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:16 +0100
Subject: [PATCH next 7/8] clk: rockchip: rk3588: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-7-25521d4e37c3@cherry.de>
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

There's no B1_PLL_CON8, LPLL_CON16, PLL_CON88/96/104/112/120, or
PHP_PLL_CON128 in the TRM so one needs to do an additional lookup the
header file to know what exactly this refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h | 12 ++++++++----
 drivers/clk/rockchip/clk_rk3588.c               | 16 ++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
index 1058fbc19dc2..89aa5c99d9f3 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
@@ -109,7 +109,11 @@ struct pll_rate_table {
 #define RK3588_BIGCORE1_CRU_BASE	0x52000
 #define RK3588_DSU_CRU_BASE		0x58000
 
-#define RK3588_PLL_CON(x)		((x) * 0x4)
+#define RK3588_V0PLL_CON(x)		(0x0160 + (x) * 0x4)
+#define RK3588_AUPLL_CON(x)		(0x0180 + (x) * 0x4)
+#define RK3588_CPLL_CON(x)		(0x01a0 + (x) * 0x4)
+#define RK3588_GPLL_CON(x)		(0x01c0 + (x) * 0x4)
+#define RK3588_NPLL_CON(x)		(0x01e0 + (x) * 0x4)
 #define RK3588_MODE_CON0		0x280
 #define RK3588_CLKSEL_CON(x)		((x) * 0x4 + 0x300)
 #define RK3588_CLKGATE_CON(x)		((x) * 0x4 + 0x800)
@@ -124,7 +128,7 @@ struct pll_rate_table {
 #define RK3588_SDMMC_CON0		0xC30
 #define RK3588_SDMMC_CON1		0xC34
 
-#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
+#define RK3588_PHP_PPLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x200)
 #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
 #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
 
@@ -137,12 +141,12 @@ struct pll_rate_table {
 #define RK3588_BIGCORE0_CLKSEL_CON(x)	((x) * 0x4 + RK3588_BIGCORE0_CRU_BASE + 0x300)
 #define RK3588_BIGCORE0_CLKGATE_CON(x)	((x) * 0x4 + RK3588_BIGCORE0_CRU_BASE + 0x800)
 #define RK3588_BIGCORE0_SOFTRST_CON(x)	((x) * 0x4 + RK3588_BIGCORE0_CRU_BASE + 0xa00)
-#define RK3588_B1_PLL_CON(x)		((x) * 0x4 + RK3588_BIGCORE1_CRU_BASE)
+#define RK3588_B1_PLL_CON(x)		((x) * 0x4 + RK3588_BIGCORE1_CRU_BASE + 0x020)
 #define RK3588_B1_PLL_MODE_CON		(RK3588_BIGCORE1_CRU_BASE + 0x280)
 #define RK3588_BIGCORE1_CLKSEL_CON(x)	((x) * 0x4 + RK3588_BIGCORE1_CRU_BASE + 0x300)
 #define RK3588_BIGCORE1_CLKGATE_CON(x)	((x) * 0x4 + RK3588_BIGCORE1_CRU_BASE + 0x800)
 #define RK3588_BIGCORE1_SOFTRST_CON(x)	((x) * 0x4 + RK3588_BIGCORE1_CRU_BASE + 0xa00)
-#define RK3588_LPLL_CON(x)		((x) * 0x4 + RK3588_DSU_CRU_BASE)
+#define RK3588_LPLL_CON(x)		((x) * 0x4 + RK3588_DSU_CRU_BASE + 0x040)
 #define RK3588_LPLL_MODE_CON		(RK3588_DSU_CRU_BASE + 0x280)
 #define RK3588_DSU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_DSU_CRU_BASE + 0x300)
 #define RK3588_DSU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_DSU_CRU_BASE + 0x800)
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index f6144d1f96b8..a70a24e02d18 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -45,21 +45,21 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
 static struct rockchip_pll_clock rk3588_pll_clks[] = {
 	[B0PLL] = PLL(pll_rk3588, PLL_B0PLL, RK3588_B0_PLL_CON(0),
 		      RK3588_B0_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
-	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(8),
+	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(0),
 		      RK3588_B1_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
-	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(16),
+	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(0),
 		     RK3588_LPLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
-	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_PLL_CON(88),
+	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_V0PLL_CON(0),
 		      RK3588_MODE_CON0, 4, 15, 0, rk3588_pll_rates),
-	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3588_PLL_CON(96),
+	[AUPLL] = PLL(pll_rk3588, PLL_AUPLL, RK3588_AUPLL_CON(0),
 		      RK3588_MODE_CON0, 6, 15, 0, rk3588_pll_rates),
-	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3588_PLL_CON(104),
+	[CPLL] = PLL(pll_rk3588, PLL_CPLL, RK3588_CPLL_CON(0),
 		     RK3588_MODE_CON0, 8, 15, 0, rk3588_pll_rates),
-	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3588_PLL_CON(112),
+	[GPLL] = PLL(pll_rk3588, PLL_GPLL, RK3588_GPLL_CON(0),
 		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
-	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
+	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_NPLL_CON(0),
 		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
-	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
+	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PPLL_CON(0),
 		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
 		     rk3588_pll_rates),
 #ifdef CONFIG_XPL_BUILD

-- 
2.56.1

