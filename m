Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8904109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C1284285;
	Fri, 20 Mar 2026 00:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aqURvq5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58FBA83FDE; Thu, 19 Mar 2026 21:58:41 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1019183F8A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b40003d13so893296f8f.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953918; x=1774558718; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQumiPbp80hZWkFmcR45v5xw5x/cMV2c5oqDMRtP4WA=;
 b=aqURvq5escQ8Uh/j/63QBtSGq0DD0JHOWjQd+UhkyUB5RsCtJAiuc239mrG3O1/6dc
 drCzEhbBDLMWIx/85rwncyv34jzTXPuqmKglgX+Sd3rUsFaKLFjt6f8zkjMlP2/siwKI
 UzRdZwZ4jCCYHr4gaVnhKVRd7YaXpaQ+iODpfhamP41CFj6hsb3D4MkUHdSyMy/eOycz
 VGHDaQRMgJb88o48PSo59v/HDdlA/EUMh87SVgRRztewCgHV6GUjJj+SMwcM3dVUWAii
 J9iOVO4yGF5M2/d/EVrZtt6B1G8oXmg9T7SBAQ+KosqD+5hqGLi0B8JXNiGJKGzbvs/q
 jbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953918; x=1774558718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hQumiPbp80hZWkFmcR45v5xw5x/cMV2c5oqDMRtP4WA=;
 b=FNmbfYZosUMYO3OwUAxwMETUnNAo7VHPktuw6D24TZM9i6Oqvqz6HKCPQkwFBWlXNb
 wj+eTkWKpCARI2wGjYUE+UbWpnbEEbbUdsYPtOO9EquHqoLGA46i2BalNoIRopeUr8y0
 TNCX/C8sqjiEMkBW2AIeu6j0HJ2iTz/0FsDKtOQrOx50koucQinrlB7QebkyYJO45BFq
 O4rFJ2IpajQzAQWizgoJjiwBvEfsHAMdONitDup0bRDIGZfeR9/yA6hi2LgQrXLfAw8L
 K8BvwYzD2keiiBQIHGF561h/AZeSoiwmjlbyXAMWpWdrRDROvwEyfN42dGObJ/bdmOLc
 Jwow==
X-Gm-Message-State: AOJu0YyYowlghVgWVKjLhI/KTxXmMGzl/DOg0bfPKMRfqlQb7kip8xPv
 zgev3D03l5GOsoHR1Z04/Yey4IKN0Ncg5+tc9HmHIxXYDtpPeOnyYWqJPvhZD1VnMfE=
X-Gm-Gg: ATEYQzwLvZkC+SOeo5iCiaGNYoIuzSdzKt+Wss5NmQvK1dv0LUyNzbCjQ8k4SHiUfkK
 5mgN/9XypjNjJh0XyoMH+zaQUXTflC+BjpkFUNSP0NTUoWgHlRqSAZpkfaKCiitXXMkcsYwvvnd
 BGYIMFKCsDFNBHr8ld7vaVVK6WeBX99QxiWszf3H/jbaqA6f6hT00t6VdlcFFp6YdMKExIy15rl
 NpbpD4oqCVLQU58pL1OTDWftbJVbdmMtv0P5QY2pRGF551HreHRt8RQb++ywnWpFELEvezr2fXE
 MsfaRk7DREi8HvqScw3TEi2NaKX+7cmmF7LbipMB6Go313ev1kza2IxcPAxeWGhmpBKtXvSuXjj
 g3/PeomJ4q8Dpy9yhUUC+qD6BlrvrzHZiVYjXcs56Uu5yZLz7xLrQvyDWpaTWpmzP1+AovdUv10
 bE61KFDQIEpJxCKsbY6i6DW0WTNDK1TwdXJ9T9LKYe0WsptDFtXiPS6T477VfbLMDq2Zg=
X-Received: by 2002:a05:6000:2203:b0:43b:45a0:9df8 with SMTP id
 ffacd0b85a97d-43b642781a8mr1368024f8f.35.1773953918329; 
 Thu, 19 Mar 2026 13:58:38 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:37 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:48 +0100
Subject: [PATCH RFC 26/40] clk/clk-uclass: adapt for CCF_FULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-26-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=10143;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VQ+UwRkFHsmDi4X2J1U5vDc1dvKFNcSZwLk2BRRq0g4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yQKsz67p7ikwPL0wb62c2JLLgau+fbWKdv6W91TlO
 P/rpmTDjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRLwsY/kd3RyZPDuZ4N3WN
 uOJRwf0RfgIqHA/1vzVM25gsVlyUNo/hf12zKrelG0vhhn+nJvRs5v2y3d72wnGObcvv/7P8EbP
 0wHUA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

When building U-Boot with CCF_FULL support, most clk operations
are implemented in clk/ccf/clk.c, so we can remove the conflicting
definitions in clk-uclass.c.

Additionally, registering clock consumers works quite differently, so we
adapt clk_get_by_name() and similar functions to call into CCF. Notably
while in Linux the struct clk handle is allocated inside CCF (since
it's an opaque cookie), in U-Boot struct clk is public and typically
allocated by the consumer driver, so we need a small adjustment to allow
CCF to populate an already-allocated struct clk.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c | 297 +++++++++++++++++++++++++++--------------------
 1 file changed, 172 insertions(+), 125 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 095329e25f15..d54d76745560 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -23,8 +23,11 @@
 #include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 
+#include <linux/clk/clk-conf.h>
+#include "ccf/clk.h"
+
 static inline const struct clk_ops_uboot *clk_dev_ops(struct udevice *dev)
 {
 	return (const struct clk_ops_uboot *)dev->driver->ops;
 }
@@ -74,9 +77,9 @@ static int clk_of_xlate_default(struct clk *clk,
 
 	return 0;
 }
 
-static int clk_get_by_index_tail(int ret, ofnode node,
+static int __maybe_unused clk_get_by_index_tail(int ret, ofnode node,
 				 struct ofnode_phandle_args *args,
 				 const char *list_name, int index,
 				 struct clk *clk)
 {
@@ -115,47 +118,30 @@ err:
 
 	return log_msg_ret("prop", ret);
 }
 
-static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
-				   int index, struct clk *clk)
-{
-	int ret;
-	struct ofnode_phandle_args args;
-
-	debug("%s(dev=%s, index=%d, clk=%p)\n", __func__, dev_read_name(dev),
-	      index, clk);
-
-	assert(clk);
-	clk->dev = NULL;
-
-	ret = dev_read_phandle_with_args(dev, prop_name, "#clock-cells", 0,
-					 index, &args);
-	if (ret) {
-		debug("%s: fdtdec_parse_phandle_with_args failed: err=%d\n",
-		      __func__, ret);
-		return log_ret(ret);
-	}
-
-	return clk_get_by_index_tail(ret, dev_ofnode(dev), &args, "clocks",
-				     index, clk);
-}
-
 int clk_get_by_index(struct udevice *dev, int index, struct clk *clk)
 {
 	return clk_get_by_index_nodev(dev_ofnode(dev), index, clk);
 }
 
 int clk_get_by_index_nodev(ofnode node, int index, struct clk *clk)
 {
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL)
+	struct clk_hw *hw;
+
+	hw = of_clk_get_hw(node, index, NULL);
+	return clk_hw_create_clk_uboot(clk, hw);
+#else
 	struct ofnode_phandle_args args;
 	int ret;
 
 	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
 					     index, &args);
 
 	return clk_get_by_index_tail(ret, node, &args, "clocks",
 				     index, clk);
+#endif
 }
 
 int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 {
@@ -189,8 +175,86 @@ bulk_get_err:
 
 	return ret;
 }
 
+int clk_get_by_name(struct udevice *dev, const char *name, struct clk *clk)
+{
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL)
+	struct clk_hw *hw;
+
+	hw = of_clk_get_hw(dev_ofnode(dev), 0, name);
+	return clk_hw_create_clk_uboot(clk, hw);
+#else
+	return clk_get_by_name_nodev(dev_ofnode(dev), name, clk);
+#endif
+}
+#endif /* OF_REAL */
+
+int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
+{
+	int index = 0;
+
+	debug("%s(node=%s, name=%s, clk=%p)\n", __func__,
+		ofnode_get_name(node), name, clk);
+	clk->dev = NULL;
+
+	if (name) {
+		index = ofnode_stringlist_search(node, "clock-names", name);
+		if (index < 0) {
+			debug("fdt_stringlist_search() failed: %d\n", index);
+			return index;
+		}
+	}
+
+	return clk_get_by_index_nodev(node, index, clk);
+}
+
+int clk_release_all(struct clk *clk, unsigned int count)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		debug("%s(clk[%u]=%p)\n", __func__, i, &clk[i]);
+
+		/* check if clock has been previously requested */
+		if (!clk[i].dev)
+			continue;
+
+		ret = clk_disable(&clk[i]);
+		if (ret && ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Full CCF has its own versions of these functions */
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
+static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
+				   int index, struct clk *clk)
+{
+	int ret;
+	struct ofnode_phandle_args args;
+
+	debug("%s(dev=%s, index=%d, clk=%p)\n", __func__, dev_read_name(dev),
+	      index, clk);
+
+	assert(clk);
+	clk->dev = NULL;
+
+	ret = dev_read_phandle_with_args(dev, prop_name, "#clock-cells", 0,
+					 index, &args);
+	if (ret) {
+		debug("%s: fdtdec_parse_phandle_with_args failed: err=%d\n",
+		      __func__, ret);
+		return log_ret(ret);
+	}
+
+	return clk_get_by_index_tail(ret, dev_ofnode(dev), &args, "clocks",
+				     index, clk);
+}
+
 static struct clk *clk_set_default_get_by_id(struct clk *clk)
 {
 	struct clk *c = clk;
 
@@ -371,62 +435,8 @@ fail:
 	free(rates);
 	return ret;
 }
 
-int clk_set_defaults(struct udevice *dev, enum clk_defaults_stage stage)
-{
-	int ret;
-
-	if (!dev_has_ofnode(dev))
-		return 0;
-
-	/*
-	 * To avoid setting defaults twice, don't set them before relocation.
-	 * However, still set them for SPL. And still set them if explicitly
-	 * asked.
-	 */
-	if (!(IS_ENABLED(CONFIG_XPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
-		if (stage != CLK_DEFAULTS_POST_FORCE)
-			return 0;
-
-	debug("%s(%s)\n", __func__, dev_read_name(dev));
-
-	ret = clk_set_default_parents(dev, stage);
-	if (ret)
-		return ret;
-
-	ret = clk_set_default_rates(dev, stage);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-int clk_get_by_name(struct udevice *dev, const char *name, struct clk *clk)
-{
-	return clk_get_by_name_nodev(dev_ofnode(dev), name, clk);
-}
-#endif /* OF_REAL */
-
-int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
-{
-	int index = 0;
-
-	debug("%s(node=%s, name=%s, clk=%p)\n", __func__,
-		ofnode_get_name(node), name, clk);
-	clk->dev = NULL;
-
-	if (name) {
-		index = ofnode_stringlist_search(node, "clock-names", name);
-		if (index < 0) {
-			debug("fdt_stringlist_search() failed: %d\n", index);
-			return index;
-		}
-	}
-
-	return clk_get_by_index_nodev(node, index, clk);
-}
-
 const char *
 clk_resolve_parent_clk(struct udevice *dev, const char *name)
 {
 	struct udevice *parent;
@@ -443,28 +453,8 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
 
 	return clk.dev->name;
 }
 
-int clk_release_all(struct clk *clk, unsigned int count)
-{
-	unsigned int i;
-	int ret;
-
-	for (i = 0; i < count; i++) {
-		debug("%s(clk[%u]=%p)\n", __func__, i, &clk[i]);
-
-		/* check if clock has been previously requested */
-		if (!clk[i].dev)
-			continue;
-
-		ret = clk_disable(&clk[i]);
-		if (ret && ret != -ENOSYS)
-			return ret;
-	}
-
-	return 0;
-}
-
 int clk_request(struct udevice *dev, struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 
@@ -704,21 +694,8 @@ int clk_enable(struct clk *clk)
 
 	return 0;
 }
 
-int clk_enable_bulk(struct clk_bulk *bulk)
-{
-	int i, ret;
-
-	for (i = 0; i < bulk->count; i++) {
-		ret = clk_enable(&bulk->clks[i]);
-		if (ret < 0 && ret != -ENOSYS)
-			return ret;
-	}
-
-	return 0;
-}
-
 int clk_disable(struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *clkp = NULL;
@@ -769,21 +746,8 @@ int clk_disable(struct clk *clk)
 
 	return 0;
 }
 
-int clk_disable_bulk(struct clk_bulk *bulk)
-{
-	int i, ret;
-
-	for (i = 0; i < bulk->count; i++) {
-		ret = clk_disable(&bulk->clks[i]);
-		if (ret < 0 && ret != -ENOSYS)
-			return ret;
-	}
-
-	return 0;
-}
-
 int clk_get_by_id(ulong id, struct clk **clkp)
 {
 	struct udevice *dev;
 	struct uclass *uc;
@@ -820,8 +784,65 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
 		return true;
 
 	return false;
 }
+#else
+long clk_get_parent_rate(struct clk *clk)
+{
+	struct clk *pclk;
+
+	if (!clk)
+		return -EINVAL;
+
+	pclk = clk_get_parent(clk);
+	return clk_get_rate(pclk);
+}
+
+static int clk_set_default_parents(struct udevice *dev,
+				   enum clk_defaults_stage stage)
+{
+	return -ENOSYS;
+}
+
+static int clk_set_default_rates(struct udevice *dev,
+				 enum clk_defaults_stage stage)
+{
+	return -ENOSYS;
+}
+#endif
+
+int clk_set_defaults(struct udevice *dev, enum clk_defaults_stage stage)
+{
+	int ret;
+
+	if (!dev_has_ofnode(dev))
+		return 0;
+
+	/*
+	 * To avoid setting defaults twice, don't set them before relocation.
+	 * However, still set them for SPL. And still set them if explicitly
+	 * asked.
+	 */
+	if (!(IS_ENABLED(CONFIG_XPL_BUILD) || (gd->flags & GD_FLG_RELOC)))
+		if (stage != CLK_DEFAULTS_POST_FORCE)
+			return 0;
+
+	debug("%s(%s)\n", __func__, dev_read_name(dev));
+
+	if (CONFIG_IS_ENABLED(CLK_CCF_FULL)) {
+		return of_clk_set_defaults(dev_ofnode(dev), false);
+	} else {
+		ret = clk_set_default_parents(dev, stage);
+		if (ret)
+			return ret;
+
+		ret = clk_set_default_rates(dev, stage);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
 
 struct clk *devm_clk_get(struct udevice *dev, const char *id)
 {
 	int rc;
@@ -837,8 +858,34 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 
 	return clk;
 }
 
+int clk_enable_bulk(struct clk_bulk *bulk)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = clk_enable(&bulk->clks[i]);
+		if (ret < 0 && ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
+int clk_disable_bulk(struct clk_bulk *bulk)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = clk_disable(&bulk->clks[i]);
+		if (ret < 0 && ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
 	 * when a clock provider is probed. Call clk_set_defaults()

-- 
2.51.0

