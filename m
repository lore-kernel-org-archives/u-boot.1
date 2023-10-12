Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7384CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 10:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A556186DD6;
	Thu, 12 Oct 2023 12:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gpLjvE+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77AC86DD6; Thu, 12 Oct 2023 12:19:18 +0200 (CEST)
Received: from mail-m12774.qiye.163.com (mail-m12774.qiye.163.com
 [115.236.127.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10AB686E0F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 12:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhangqing@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gpLjvE+XLOh+rncB9KyOl78V0uE3Ev17vlnzt3WRlsjTilX1Q4YeycthRZPQSM8uKI3IXhKxTIq+LafJ7Qx1gva3lJ5qSiVG+J9cZvl34opXgw1Q1FUA8cayXzf8qZCs1VJmVMoJW47AQEUX+DcOT73hTM3ot5NBuDGNgZuZWFo=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=u8YofGLSIUx51vseZM3JHn1I0aLHcjBly0EnU37V6PU=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id EC864400395;
 Thu, 12 Oct 2023 18:18:29 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: lukma@denx.de, seanga2@gmail.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, kever.yang@rock-chips.com
Cc: u-boot@lists.denx.de, chenjh@rock-chips.com,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 5/5] clk: rockchip: rk3588: fix up the frac pll calculation
Date: Thu, 12 Oct 2023 18:18:28 +0800
Message-Id: <20231012101828.27195-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231011102947.21188-1-zhangqing@rock-chips.com>
References: <20231011102947.21188-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0fS1ZLHRoZTUkYGE1MSh5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b236519712eb3kusnec864400395
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46OQw6GDwyUQsDCjVNT05C
 LTYKCQNVSlVKTUJMSktOQkpLQ0pNVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5KSkM3Bg++
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

rk3588 frac pll:
FFVCO = ((m + k / 65536) * FFIN) / p
FFOUT = ((m + k / 65536) * FFIN) / (p * 2s)
k is the original code, but the K[15:0] is complement code
(6'b1000_0000_0000_0000 <= K[15:0] <= 16'b0111_1111_1111_1111),
need to be converted.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk_pll.c | 102 +++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index d657ef38f3c6..1bb31b3313b5 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -168,13 +168,71 @@ rockchip_pll_clk_set_by_auto(ulong fin_hz,
 	return rate_table;
 }
 
+static u32
+rockchip_rk3588_pll_k_get(u32 m, u32 p, u32 s, u64 fin_hz, u64 fvco)
+{
+	u64 fref, fout, ffrac;
+	u32 k = 0;
+
+	fref = fin_hz / p;
+	ffrac = fvco - (m * fref);
+	fout = ffrac * 65536;
+	k = fout / fref;
+	if (k > 32767) {
+		fref = fin_hz / p;
+		ffrac = ((m + 1) * fref) - fvco;
+		fout = ffrac * 65536;
+		k = ((fout * 10 / fref) + 7) / 10;
+		if (k > 32767)
+			k = 0;
+		else
+			k = ~k + 1;
+	}
+	return k;
+}
+
+static struct rockchip_pll_rate_table *
+rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
+{
+	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
+	u32 p, m, s, k;
+	u64 fvco;
+
+	for (s = 0; s <= 6; s++) {
+		fvco = (u64)fout_hz << s;
+		if (fvco < RK3588_VCO_MIN_HZ || fvco > RK3588_VCO_MAX_HZ)
+			continue;
+		for (p = 1; p <= 4; p++) {
+			for (m = 64; m <= 1023; m++) {
+				if ((fvco >= m * fin_hz / p) &&
+				    (fvco < (m + 1) * fin_hz / p)) {
+					k = rockchip_rk3588_pll_k_get(m, p, s,
+								      fin_hz,
+								      fvco);
+					if (!k)
+						continue;
+					rate_table->p = p;
+					rate_table->s = s;
+					rate_table->k = k;
+					if (k > 32767)
+						rate_table->m = m + 1;
+					else
+						rate_table->m = m;
+					return rate_table;
+				}
+			}
+		}
+	}
+	return NULL;
+}
+
 static struct rockchip_pll_rate_table *
 rk3588_pll_clk_set_by_auto(unsigned long fin_hz,
 			   unsigned long fout_hz)
 {
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
 	u32 p, m, s;
-	ulong fvco, fref, fout, ffrac;
+	ulong fvco;
 
 	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
 		return NULL;
@@ -202,27 +260,12 @@ rk3588_pll_clk_set_by_auto(unsigned long fin_hz,
 		}
 		pr_err("CANNOT FIND Fout by auto,fout = %lu\n", fout_hz);
 	} else {
-		for (s = 0; s <= 6; s++) {
-			fvco = fout_hz << s;
-			if (fvco < RK3588_VCO_MIN_HZ ||
-			    fvco > RK3588_VCO_MAX_HZ)
-				continue;
-			for (p = 1; p <= 4; p++) {
-				for (m = 64; m <= 1023; m++) {
-					if ((fvco >= m * fin_hz / p) && (fvco < (m + 1) * fin_hz / p)) {
-						rate_table->p = p;
-						rate_table->m = m;
-						rate_table->s = s;
-						fref = fin_hz / p;
-						ffrac = fvco - (m * fref);
-						fout = ffrac * 65536;
-						rate_table->k = fout / fref;
-						return rate_table;
-					}
-				}
-			}
-		}
-		pr_err("CANNOT FIND Fout by auto,fout = %lu\n", fout_hz);
+		rate_table = rockchip_rk3588_pll_frac_by_auto(fin_hz, fout_hz);
+		if (!rate_table)
+			pr_err("CANNOT FIND Fout by auto,fout = %lu\n",
+			       fout_hz);
+		else
+			return rate_table;
 	}
 	return NULL;
 }
@@ -533,11 +576,22 @@ static ulong rk3588_pll_get_rate(struct rockchip_pll_clock *pll,
 
 		rate = OSC_HZ / p;
 		rate *= m;
-		if (k) {
+		if (k & BIT(15)) {
+			/* fractional mode */
+			u64 frac_rate64;
+
+			k = (~(k - 1)) & RK3588_PLLCON2_K_MASK;
+			frac_rate64 = OSC_HZ * k;
+			postdiv = p;
+			postdiv *= 65536;
+			do_div(frac_rate64, postdiv);
+			rate -= frac_rate64;
+		} else {
 			/* fractional mode */
 			u64 frac_rate64 = OSC_HZ * k;
 
-			postdiv = p * 65536;
+			postdiv = p;
+			postdiv *= 65536;
 			do_div(frac_rate64, postdiv);
 			rate += frac_rate64;
 		}
-- 
2.17.1

