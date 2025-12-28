Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC67E784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC7F83DA6;
	Mon, 29 Dec 2025 02:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="NeliazyJ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jPPIMc57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D30383B72; Sun, 28 Dec 2025 23:08:03 +0100 (CET)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9812F83B63
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 23:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niklas.soderlund@ragnatech.se
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8FB207A0387;
 Sun, 28 Dec 2025 17:07:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sun, 28 Dec 2025 17:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1766959675;
 x=1767046075; bh=7X5UPOqZevKrfx0ejdIV5RJg9XKILOqsbbu8X0l/86I=; b=
 NeliazyJ2K1xoqnjUHRnfiSlxdfHNnoVGRkNHWUO1/43Cn/vxN+MQlDiBPM6FtjU
 g0ec7yWWxu88u24T4w8xdlx5ZJ0eIAWrU6jtQI7MkbMZUs9bxrIPFhu1LgbY7dU8
 VUuxgwu200kWRKtTdFBzU2x6sQ6fnQicXh8oaz+vVTZhE79GMPR+0b7S5L/UGhPX
 PGG/iwkfQNwEkEcdsuOzEoBRWuKFECfz/Oft9uUTAOEo1Ggnfq3NVBbitgE50jdH
 9f3/tgCPgJYD4RxafPtCA6n+yyZdfvcAHGdFtBgu8EaY8X8jBbpSwWwbNsizTeZa
 +S9AKfvYWCcDyLTQ2RHIBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1766959675; x=
 1767046075; bh=7X5UPOqZevKrfx0ejdIV5RJg9XKILOqsbbu8X0l/86I=; b=j
 PPIMc57FyWM62vA5VZO9RefLKGwZhyUqH1qe1CG8Z8m5JGi5UMAjCsE2PQqImOms
 f9auqmkmhOmXoC1ftcvH/JDm75sSsrkosYdA+eAyeTjgDlv2x74PJjjyqQzIA7P0
 Zououy71LliyB1z5dakjL2skNoBQjs5cUaSaG3xohdCFN75fQrStloM9REFx9uSp
 A7TmG0hzbbiamYb8T6j/kodGlFe1Nnd11n0NitO5X/6AVp537TMxkiiwsBL93qLM
 HhBFk/oVRxJBj2QwligugASW7Kes3DAGYyS8fw+y2niyv1HP8naEHPNXtRr4U9G7
 TNAFS6evHZP6ZAJifgLoA==
X-ME-Sender: <xms:O6pRaZtufb7_6B-01SkpKc_Np_4pUsNjXCczqr6ZBbeU4kmhwXv1BA>
 <xme:O6pRaWKbHCVsaXgh3AuxQIzFU7JTBHrP5jnLlXoy9YeXt4RICe7jzkNyko9JJ8AxI
 1NWdv8VCz0BVZvkNutnopcw9yZXlvqC_6wuEClvgx5lBbKGGWNHvDY>
X-ME-Received: <xmr:O6pRaWmP4wOifpj2iN_fioW0DQmOmnTPGoCHVHvFXEehn35pwsBfhq2leOFIGbqwXsmqQDJPpXR9pPDEPHJJ5R6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejheegvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheppfhikhhlrghs
 ucfunpguvghrlhhunhguuceonhhikhhlrghsrdhsohguvghrlhhunhguodhrvghnvghsrg
 hssehrrghgnhgrthgvtghhrdhsvgeqnecuggftrfgrthhtvghrnhepheeigfeuveeutdef
 hfehgeekvedtleeuueekveefudehhffhjeffgfegffelfeegnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhhikhhlrghsrdhsohguvghrlhhu
 nhgusehrrghgnhgrthgvtghhrdhsvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgr
 ihhlsghogidrohhrghdprhgtphhtthhopehifigrmhgrthhsuhesnhhighgruhhrihdroh
 hrghdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepthhrihhn
 iheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrd
 guvghngidruggvpdhrtghpthhtohepnhhikhhlrghsrdhsohguvghrlhhunhguodhrvghn
 vghsrghssehrrghgnhgrthgvtghhrdhsvg
X-ME-Proxy: <xmx:O6pRaXLVdUHpAJZrqLUFe-F2wzXoUcGTR6ddddUJIdVnyrkKvc6zUA>
 <xmx:O6pRab4cfsSqhsRYDNMNonhYxVedF8RdYzFBJJUMjIgVVcp-1xHtiA>
 <xmx:O6pRab0P3clj89jAR-UY7Y2RhK5dDJcauu7SODuVzPdRVUyI4YC1Cw>
 <xmx:O6pRaRf4hwVvKpUm4-4bj0On1FXkf9K63JdUTL8qotuf77LBW4ePJA>
 <xmx:O6pRaS7qmga4Sbv3px3Xv3S-QBpxqb_MpwY-ElbkCQb0ogf8eweQRP2d>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Dec 2025 17:07:54 -0500 (EST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] clk: renesas: Do not disable realtime modules on
 R8A77995 D3
Date: Sun, 28 Dec 2025 23:07:17 +0100
Message-ID: <20251228220717.3630713-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
References: <20251228220717.3630713-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:49:04 +0100
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

Later versions of the datasheet makes it clear D3 do not have any
realtime module stop control registers (RMSTPCRx). Remove the
manipulation of them from the module clock table to match this.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Add check in renesas_clk_remove() to avoid any RMSTPCR access for D3,
  thanks Marek!
---
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
 drivers/clk/renesas/renesas-cpg-mssr.c  |  3 ++-
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index 309b0aec8e2a..53b098eae61d 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -216,18 +216,18 @@ static const struct rcar_gen3_cpg_pll_config cpg_pll_configs[2] __initconst = {
 };
 
 static const struct mstp_stop_table r8a77995_mstp_table[] = {
-	{ 0x00210000, 0x0, 0x00210000, 0 },
-	{ 0x03e01000, 0x0, 0x03e01000, 0 },
-	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
-	{ 0xc00014df, 0x400, 0xc00014df, 0 },
-	{ 0x80000004, 0x80, 0x80000004, 0 },
-	{ 0x40d20004, 0x0, 0x40d20004, 0 },
-	{ 0x08c0008c, 0x0, 0x08c0008c, 0 },
-	{ 0x09941c18, 0x0, 0x09941c18, 0 },
-	{ 0x00801087, 0x0, 0x00801087, 0 },
-	{ 0xf143dfc0, 0x0, 0xf143dfc0, 0 },
-	{ 0x063e1820, 0x0, 0x063e1820, 0 },
-	{ 0x00000000, 0x0, 0x00000000, 0 },
+	{ 0x00210000, 0x0, 0, 0 },
+	{ 0x03e01000, 0x0, 0, 0 },
+	{ 0x000e2fdc, 0x2000, 0, 0 },
+	{ 0xc00014df, 0x400, 0, 0 },
+	{ 0x80000004, 0x80, 0, 0 },
+	{ 0x40d20004, 0x0, 0, 0 },
+	{ 0x08c0008c, 0x0, 0, 0 },
+	{ 0x09941c18, 0x0, 0, 0 },
+	{ 0x00801087, 0x0, 0, 0 },
+	{ 0xf143dfc0, 0x0, 0, 0 },
+	{ 0x063e1820, 0x0, 0, 0 },
+	{ 0x00000000, 0x0, 0, 0 },
 };
 
 static const void *r8a77995_get_pll_config(const u32 cpg_mode)
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 39ff4541c1e4..4b07dbb3277e 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -127,7 +127,8 @@ int renesas_clk_remove(void __iomem *base, struct cpg_mssr_info *info)
 				info->mstp_table[i].sdis,
 				info->mstp_table[i].sen);
 
-		if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4)
+		if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN4 ||
+		    renesas_get_cpu_type() == RENESAS_CPU_TYPE_R8A77995)
 			continue;
 
 		clrsetbits_le32(base + RMSTPCR(i),
-- 
2.52.0

