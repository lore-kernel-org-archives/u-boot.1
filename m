Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D71C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0E3160746;
	Mon, 20 Jul 2026 18:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id siDWMwtrRcOU; Mon, 20 Jul 2026 18:10:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BA0560762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571017;
	bh=a+3em/KMzmuNchjuwGAeE7p22HFTXLOyF921/W89MGk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EKuXLoPA38AlgZU6nTXKEaCb6xOurj6n9x9r4py/FaBxhWBHWh+oiL5hZkL/rpjvS
	 o5Fo8eNXWf6Q8H1iuuXCfgClq7b48VvrADyOb/4gfrHGkcPvTN4onLNbZTemBw3bg1
	 muYiubeYVllckjQHveYkmFA/gIHEW4NXHsHJ0cptmQ93SXM1o1m1CS6QGBmkiLHVlJ
	 Vx5fq+CX2RqULTxeWxPjWkTt7geSeiaH1wao2bLJ2TUay1aLE+mKaj7E4GG5jUL/0/
	 dJlSOdM44K3mtoDKBR8w/PdggQAHT+xzyLGuBCyDufeH3mnrWIMK1AqRbsUtg+OzE/
	 XqgRIPXUgmjyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BA0560762;
	Mon, 20 Jul 2026 18:10:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C69D81531
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABFA980D0B
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItitTUsQMvCs for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 30D2A80CED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30D2A80CED
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30D2A80CED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3CDE84A0B; Mon, 20 Jul 2026 18:41:30 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D86C68484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:28 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495590ba856so13464515e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565688; x=1785170488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a+3em/KMzmuNchjuwGAeE7p22HFTXLOyF921/W89MGk=;
 b=tEBpRgbwg3jIDL/jX7OvSV5Nvudqb3GzZDIQWy0W9/lndThBjO9piYHGr2I7S+rPyK
 gDAttnsc4opYBksy4Xjv/+56eWzXSmbT+OFdpzdKvgzeIg0cfxJcKN6A/Pbi5Q15ST7U
 X1CZ6MeDwcj/Za8aHCE4EQATSetZjv8K9V1h3hw/5DEx7x5LWBfEWBxo5GGLApIYaSjH
 vErJFaFeCFeuS1TErEp5ccDeysQEc0pNDUCYi6MWLorhNGlC6lmBvzR0UVngMfh1R5Oz
 vmCIGS/XdkrkDzO8MPW/TyW3fTU2bfKg90Clta4eYbBcMZKQa7Q/t8YU1bVSsnDEUths
 gW3w==
X-Gm-Message-State: AOJu0YwY7BWevUgaWv+S6ghFLcczgP2GE/B2p23mMSj1bBv3ANrOGPo9
 O1+X4+AndR/c7eyUiQ1SahNpdcDnlLyHe15ZVUOmh1uNKmYHL+9SL8FNwQVjt92SXIo=
X-Gm-Gg: AfdE7ckBZ0juMd+XfjhSfkkVVAz4Z9IxJjJWKi09uOCVgbXWIziNEcO5qxYD3UAZvxX
 HSLoQjY4Pxii4v2ZL+jb6/AkAhgBJW1RItPkDfDAad67KpiEUNzLgOu3BDxafnd2PlTecd77kdE
 ScLJXnN1TycQ3a+pSAcmjyLvupr4V7i38z6lTPRH7yGozIah2Y7oh5g21G0iaHylaa6POJZ6HYy
 cNaNFhxDlGpVKOngbez1/3pV/D4UewtIpTIrY7+2g47eBxXkIrKXXYJ31Dd0uAyD0RqrLqOdTex
 9Pd7/0JU3srHHsnEbxsDfTTrKS3QxtxMqhb8I2x1TCrdwvtiTIrvjsoT9rxwPbmwtSlnsZd/bAq
 DyoLhiyvydrnIpT5M1I3JbnnPjfKVXBFKf8bbDhxb0BTPTjgpsDnJyZWYEjWe7dzsutMWlUSWRq
 NIKuJZQXTnIqwdWPwsxH9451/oGN9G1A==
X-Received: by 2002:a05:600c:4755:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-4954a51590fmr182461205e9.38.1784565688299; 
 Mon, 20 Jul 2026 09:41:28 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:43 +0100
Subject: [PATCH 16/36] clk/ccf: debug log enable/disable calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-16-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=viC2UAAVr4NlX2jSodMDcDCo9fNfo/ebCbwz/oZwAq8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+DgweIqyTIDWNzQvoULxgNwTNAk8Jhd5ytK
 yx5wfD+ZaKJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tg7mD/407hy9rtUBlwDJ94Ee+lhJpEAAzJpEiG5JFbd1Ii1YUu/qqZ7pJsZtgzltQIXwX9/VfBJ
 scA6lOMKVSEeaWXCyUPDr7ZcYiFGl/zR3mzhZu5x2GxjCFq0lPL6VxnKOvtULS8eQVDbhmddKgJ
 NGZP4eEBI+B7AlUsK1w3y5fPeHd3zHJlChck7bbeQrTVWQKGkK8HXitFwcWJl4FQw2dWn5ztr0F
 9SUB1CuWaQ2uOaRTfJLmY0IX4YfNJ3gbuhS/FMkKkDfQvJTH8tW1C80SH2y4oCfPR2ZBwsAczsQ
 obyTKV6n0B9ejV1fqKjy54S0Fp0kvaTPGGBNkM4a73RSzhihEIfw9/Kr3snEPlB3Ihfgobka8Ji
 nCDz/4vVSCOXwv73V60LFqXcvq/rYtGkRUoxZnzNQ+vOTGzbdEf5Br3J1P/K9JbMSFYKRVOd1Sm
 NJSfoHzXLLmwPSJdxJMod7wTBNXFfV9rpftWr8iByfjiDj0MIrhb0ej1FtYcKSoKAyCIbncitkg
 hIKLbCDV7HcqKhKh1yvCLPb2oPQKr8vy4C0EjcxS2IO/7em1vDzrTps0yZ+L7RzXFMfH0jK7o5D
 KVwcK9oelUl2fHlHXf2LY642ZliQUTLwSKCA4d2p+zvkWzp9mZHtqiZ09iWqI0DwiV1zr9Oc7NK
 qBxzcYcKeF2xkgw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565688; x=1785170488; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a+3em/KMzmuNchjuwGAeE7p22HFTXLOyF921/W89MGk=;
 b=E5kvHs/WsktzfDblFxbrBLSgXfKhXYPCienArP/5rIvs9Bb+Ehz3fwaliSSxOBV99E
 u2XRZrOdOg+xAsUE61ZJtySEzr5UzKpGcb0zWE9Y/9w4IDBOT3zrPgugwnCBWj3OJeB1
 U1Z7fw/8/b4P3XSWMzy9pSGR8+lhnWycPyCOugmh8lEk8LhaCLeRbaZOiwjALtRASjdH
 Y0sNhcGnBsb8Uv3CqJSYMAo/HwCkHdGof5G2CKi5NchTOLsoADXiL9nHFgIGNbvaWN/R
 DE4T7QAQNAc2+kJxrbVNSRklyCpvDCXa9nn70RLV6OpFu62nm9oSOC306HuPBCiUOA+b
 K7/A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=E5kvHs/W
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5kvHs/W"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add some nice debug logging for enabling/disabling clocks.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/clk.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ccf/clk.c b/drivers/clk/ccf/clk.c
index 28692fbc7798..c648b817a823 100644
--- a/drivers/clk/ccf/clk.c
+++ b/drivers/clk/ccf/clk.c
@@ -717,13 +717,12 @@ int clk_prepare(struct clk *clk)
 EXPORT_SYMBOL_GPL(clk_prepare);
 
 static void clk_core_disable(struct clk_core *core)
 {
+	static int indent = 0;
 	if (!core)
 		return;
 
-	pr_debug("%s disable\n", core->name);
-
 	if (WARN(core->enable_count == 0, "%s already disabled\n", core->name))
 		return;
 
 	if (WARN(core->enable_count == 1 && core->flags & CLK_IS_CRITICAL,
@@ -732,12 +731,16 @@ static void clk_core_disable(struct clk_core *core)
 
 	if (--core->enable_count > 0)
 		return;
 
+	pr_debug("%*sDisable %s\n", indent * 2, indent ? " " : "", core->name);
+	indent++;
+
 	if (core->ops->disable)
 		core->ops->disable(core->hw);
 
 	clk_core_disable(core->parent);
+	indent--;
 }
 
 #define clk_core_disable_lock(core) clk_core_disable(core)
 
@@ -766,37 +769,42 @@ int clk_disable(struct clk *clk)
 EXPORT_SYMBOL_GPL(clk_disable);
 
 static int clk_core_enable(struct clk_core *core)
 {
+	static int indent = 0;
 	int ret = 0;
 
 	if (!core)
 		return 0;
 
 	if (!clk_core_is_prepared(core) && core->ops->prepare) {
-		pr_debug("%s: enable without prepare!", core->name);
+		pr_debug("%s: enable without prepare!\n", core->name);
 		ret = clk_core_prepare(core);
-		if (ret)
+		if (ret) {
 			return ret;
+		}
 	}
 
+	indent++;
 	if (core->enable_count == 0) {
 		ret = clk_core_enable(core->parent);
-
 		if (ret)
-			return ret;
+			goto out;
 
 		if (core->ops->enable)
 			ret = core->ops->enable(core->hw);
 
 		if (ret) {
 			clk_core_disable(core->parent);
-			return ret;
+			goto out;
 		}
 	}
 
 	core->enable_count++;
-	return 0;
+out:
+	indent--;
+	pr_debug("%*sEnable %s\n", indent * 2, indent ? " " : "", core->name);
+	return ret;
 }
 
 #define clk_core_enable_lock(core) clk_core_enable(core)
 

-- 
2.55.0

