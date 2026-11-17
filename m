Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788E606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F+7XlFVH;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=TW3+sGNq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F39980D93;
	Tue, 17 Nov 2026 11:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMU8_v6Xp_me; Tue, 17 Nov 2026 11:44:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A968080D96
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794915867;
	b=dwKbcc6xzAEwYn2n+KxuHSXVXKMDyL5fuJ5UdFo3QDk8b/2hlIp9jKMyclIeCzhi7Vj5
	 7PyW18SZ7fT8F+wSkb7JY29p+S2kacv7zSUidlUNkD3Md4/9V+SOrVAz0sn04HQSLoqgS
	 gWmw0g05a4E0asfzQeYAA7pVcwop7R5zSvsnnVUH/nfNfPy50FpwTLoO4uglvsWr8BbFc
	 yL4UI1jWCBAMHVg3JY/JIh15dA2oEEujfjxYHqIBIiDp6b/fhwf55yF0I3hPcreJOVaVO
	 n6T0xkeFqjcD67/tVZBxCHpBtGa36j+NafFFIKsPnwPxGs3vNTFMRcwhWgmirEuGG6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794915867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EF1SfhACwwvh3GnOTGc06S/lxN1JwzOCVLFOoaquAjI=;
	b=TtTQ8ETj/8j/VCUBFAwMr1PnqHwXpTUv7RlAYTZV43GwQ9Qq2/37w476eAzpT4NuYHeu
	 8VtfVkGYAFWAmg5ZR2E8w/w29wHjxDm3+TiifVDuFMGgkK8CoKFaqvMumsWsMyC3x0XEV
	 5D7ihQGwQqbuiY0lXWgWapbGZQ1J5f0PBwSrICqWDtg5Ehc9fNQL6u97J/llDJrlvNTX0
	 p10Y3NnX3gTb4625Pw7FdmEXuU53yo9e2MGDrbLazIy/Zm39i6ef9Bbf7pe5RR0MXwfSx
	 qd/b3JE2+f1sYhpDPTWHzbyR0JSECmZa2yxAKJRDWQRYAbONhqa04gwBlA6REOEMIfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794915867;
	bh=EF1SfhACwwvh3GnOTGc06S/lxN1JwzOCVLFOoaquAjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+7XlFVHkmgH+TqjJGHbbD/pOfVd4/NH2tf3+vjq4OtqiznUzLjG6nzpuar36YeNy
	 +EZspaKlpqq60TTnHKvoh8K6J8Cooe/wkd4X8s3qhTWGO9bkf5M9ZvludeFi/sFrqD
	 v51COTPgmTPHO0yTJbM9rzLNruKoTxoLJf6P65Pna/qMny+t9pep1mIJdRVanTS5m5
	 r9PW+vV3AGK9U6nBdvhQxoEr6I72yVyZGisMN5n8yJUVPzo7dlng5RnpQngHSH25Y7
	 bX0nOcYK6MKB37Wp8LLJX+ibo7Papvvu/TiOv6ktj6F7FHdY9fY1exYqnIDf0nDqIi
	 6RUYWnyE+RZbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A968080D96;
	Tue, 17 Nov 2026 11:44:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 41B0A13C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E9FE40308
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4BHAdOieCaM for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:44:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 424B5402CA
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.125.25.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.11;
 helo=smtp-190b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=TW3+sGNq
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 424B5402CA
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:44:24 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTN4n0wGrzkc9;
 Tue, 17 Nov 2026 12:37:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794915448;
 bh=EF1SfhACwwvh3GnOTGc06S/lxN1JwzOCVLFOoaquAjI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=TW3+sGNq7DD+wCjiX+dXc8u7fRHsxM02aL45I9WvP35rR3nFT5He87/p3ZQ/HvN25
 p/S2sPdI95VnyB3gcMCIrVRpbnY4QifwKgcH44y6xx+kOFcyUPLHFpcu1NFGG9R3G5
 FuWEoBbMdft2rd8/cclO4+tKjsSDjive+r9ZaOjE+GENXl9/vMr+PrxlARLsHvwcwF
 RcZVDJ32K6FoDKne6Hq9DEzocQGrTgKH7++iQG1wyV75zcO0wOgrlffxt4J7SopNV7
 dKpiGl2fnAvYRm5tIZe3OZuQEAitR0YLZfb8/FxYk3nxNEif0g5YC8r8g1lE7ra8DZ
 kfoTTx5widDNw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jTN4l5DQRz9TQ; Tue, 17 Nov 2026 12:37:27 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 17 Nov 2026 12:37:13 +0100
Subject: [PATCH next 4/8] clk: rockchip: rk3568: improve PLL_CON() user
 friendliness
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-rk-clk-better-con-names-v1-4-25521d4e37c3@cherry.de>
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

There's no PLL_CON8/16/24/32/40 or PMU_PLL_CON16 in the TRM so one needs
to do an additional lookup the header file to know what exactly this
refers to.

Use new macros that reflect the names used in the TRM.

No intended change in behavior.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h | 10 ++++++++--
 drivers/clk/rockchip/clk_rk3568.c               | 16 ++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
index 8af2c5be1ba4..7afa884fa42a 100644
--- a/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
+++ b/arch/arm/include/asm/arch-rockchip/cru_rk3568.h
@@ -120,8 +120,14 @@ struct pll_rate_table {
 };
 
 #define RK3568_PMU_MODE			0x80
-#define RK3568_PMU_PLL_CON(x)		((x) * 0x4)
-#define RK3568_PLL_CON(x)		((x) * 0x4)
+#define RK3568_PMU_PPLL_CON(x)		(0x0000 + (x) * 0x4)
+#define RK3568_PMU_HPLL_CON(x)		(0x0040 + (x) * 0x4)
+#define RK3568_APLL_CON(x)		(0x0000 + (x) * 0x4)
+#define RK3568_DPLL_CON(x)		(0x0020 + (x) * 0x4)
+#define RK3568_GPLL_CON(x)		(0x0040 + (x) * 0x4)
+#define RK3568_CPLL_CON(x)		(0x0060 + (x) * 0x4)
+#define RK3568_NPLL_CON(x)		(0x0080 + (x) * 0x4)
+#define RK3568_VPLL_CON(x)		(0x00a0 + (x) * 0x4)
 #define RK3568_MODE_CON			0xc0
 
 enum {
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index fd7e69ee338a..1fd974dac970 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -71,21 +71,21 @@ static struct rockchip_pll_rate_table rk3568_pll_rates[] = {
 };
 
 static struct rockchip_pll_clock rk3568_pll_clks[] = {
-	[APLL] = PLL(pll_rk3328, PLL_APLL, RK3568_PLL_CON(0),
+	[APLL] = PLL(pll_rk3328, PLL_APLL, RK3568_APLL_CON(0),
 		     RK3568_MODE_CON, 0, 10, 0, rk3568_pll_rates),
-	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3568_PLL_CON(8),
+	[DPLL] = PLL(pll_rk3328, PLL_DPLL, RK3568_DPLL_CON(0),
 		     RK3568_MODE_CON, 2, 10, 0, NULL),
-	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3568_PLL_CON(24),
+	[CPLL] = PLL(pll_rk3328, PLL_CPLL, RK3568_CPLL_CON(0),
 		     RK3568_MODE_CON, 4, 10, 0, rk3568_pll_rates),
-	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3568_PLL_CON(16),
+	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RK3568_GPLL_CON(0),
 		     RK3568_MODE_CON, 6, 10, 0, rk3568_pll_rates),
-	[NPLL] = PLL(pll_rk3328, PLL_NPLL, RK3568_PLL_CON(32),
+	[NPLL] = PLL(pll_rk3328, PLL_NPLL, RK3568_NPLL_CON(0),
 		     RK3568_MODE_CON, 10, 10, 0, rk3568_pll_rates),
-	[VPLL] = PLL(pll_rk3328, PLL_VPLL, RK3568_PLL_CON(40),
+	[VPLL] = PLL(pll_rk3328, PLL_VPLL, RK3568_VPLL_CON(0),
 		     RK3568_MODE_CON, 12, 10, 0, rk3568_pll_rates),
-	[PPLL] = PLL(pll_rk3328, PLL_PPLL, RK3568_PMU_PLL_CON(0),
+	[PPLL] = PLL(pll_rk3328, PLL_PPLL, RK3568_PMU_PPLL_CON(0),
 		     RK3568_PMU_MODE, 0, 10, 0, rk3568_pll_rates),
-	[HPLL] = PLL(pll_rk3328, PLL_HPLL, RK3568_PMU_PLL_CON(16),
+	[HPLL] = PLL(pll_rk3328, PLL_HPLL, RK3568_PMU_HPLL_CON(0),
 		     RK3568_PMU_MODE, 2, 10, 0, rk3568_pll_rates),
 };
 

-- 
2.56.1

