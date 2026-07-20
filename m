Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA7BC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD586607DB;
	Mon, 20 Jul 2026 18:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlJ70gvlEje1; Mon, 20 Jul 2026 18:10:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5041C607C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571025;
	bh=cCrV6Hbfa+eSf55s9Z50KjUrwBR086QEfwahZGmioac=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZCoe2GUVY5qxPj+5HGtKWLK/2juTVaNeWbZ3BwFzK9kJB5d7Uxvdm+9ZC1jc8bu5d
	 0JpCGOytCGMegNIon780QU+TQgL9MnMhpectlYMcjH9aIAvZxMGdh0oZ4E1hkC/WeB
	 z7RFfvnKBbwR41tiYcSbJhIQweDjc4CXxe4EUH3tCnEFfX3ZJizZuluCujEBV1dI1C
	 2C8/obEKmQzClFgY8BneC279A6sxouneR7zD2+eq1275BBCW0E3WxL+PLIFOM3e9da
	 quYMHcMpQ9jqwzYJz/2mJCKy5cXeQE0e6EqeMqDBjG/PjVarWh4sTjF+DsthNCcWpQ
	 zU+TcM4NPoCxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5041C607C6;
	Mon, 20 Jul 2026 18:10:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70FF41332
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62AF5406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pok4NqBfZjSy for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 214F6406A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 214F6406A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 214F6406A3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912138494B; Mon, 20 Jul 2026 18:41:13 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59ADE844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:11 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so16701085e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565671; x=1785170471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cCrV6Hbfa+eSf55s9Z50KjUrwBR086QEfwahZGmioac=;
 b=Zj3d1+J/sbcnphk661R5AW5wpRuPPj83ZBMm9NUuCTUDraUKrVs+NSpqgIHEcWOr5B
 6huFSOYXhqmLlvAiLOlz3+yIz+Yg0RSv0go62tdepeFxorJz86Pri/Mq+eRcHQLhvv4z
 YanqhEZciOLUA8ATYOuSaMlad+9ai3K3esA5oeQ6sIIfZZwMe1rCVRqNZcoK6Mzg40Ac
 tFsHd8W/ymqUILh1322fiD6rjN8EWL7KAr9CSaKzWhmdAdW+ECZegdfSjXSzveyrvfRS
 vzT42aRSde4SXeGX34tDj4eK/JfwYYHocc/ai7uHdiHcHr+yADR+hjOfPLyrnAdHCORf
 RV9w==
X-Gm-Message-State: AOJu0YxpbhbfQRJZsyWtKr7mXiGTus2tYqwB//Td+i/r4UlB9oK19tp0
 Iu5q2KYSNLVh5aSIxAY7Z3krtA3StJxa+u9EKQ5/P6It5qLc+oSUEphGSWSu5NdAUUo=
X-Gm-Gg: AfdE7cmANYmE54ArR/uD5PZzMYhk1vO1tm569Y/XEZdRm9XSTDTjD63I3ZSY2ea//m6
 f+p8Cv1OU9GDbQjUq9aUfjybdkilm9zMtX3BZOgjBSaTN3jC2PP0lUXYr2bFlrOavCKPYIo/qQE
 0uPkT4gDHBZxDVhMAZKWMhL3F9/hYzvJBkGDdLudSx7Vba1uB0DeLb48icxzwp65opZru6jBq6E
 MYESepMgBLLyojAPk0HNIJGELyoaj731Ni/1hSENN03TSn7DzVRaPHzz3EqyBGnqA0C1SuTqdBw
 1svWmQn0tiFwQWp0PqVJuAnURenNm9iP9Jfv+mbT9ad9U6AtMJF7mut4BXmaQVUkB0VsLZPA9Rp
 YrfpuqmhZ2NFfrWM3WYGlBJP+SXo6d1Co6Pq6D7OPvABhYosgCoX3xbi5edai7hHMIwFn9/sl4O
 HaEbjcTtzIA4dUhgUEQAneHBbNgXNjjw==
X-Received: by 2002:a05:600c:4f81:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4955b4a5c0amr73026175e9.19.1784565670731; 
 Mon, 20 Jul 2026 09:41:10 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:09 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:37 +0100
Subject: [PATCH 10/36] clk/ccf: adapt clk-conf for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-10-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7465;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=UdXgnhj7uBKGsvGwzyb6ehI9KJmVF6mAYtRQZF689/0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+CSk/xSukJMARB/aeHCxRaqgMDwli+kfw0r
 kF7dRxKrKeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PggAKCRAFgzErGV9k
 tjKOD/wNDmNeXiMW9D9FlR4S+FcHppZhj+28WKvCpYtbEkuv0z1oQ1KD0nnGmEJR2b4kvfRQ0Lj
 1OojA2mX9pFj/7C5eLC8R4Yg2sg2xtcIHsjQJ3f6quqoeDyjEQ+T8ZR3X1g1Ao4QpE4lC5vWndz
 +415N6jk7GN0RD8b9VVEpflTmOPK7j+dOkndU1bbwM1TE084jd6FlypCGKOeInrBn911YUwaTN4
 PMI7ZEy2qjetJjXqFhgimRzsq4p2ppgxsfzsweOqYX7VsEZiJTOFuCJvF5JFRfGWMvLMOxLdE1Y
 iL7/CrciMvT5rZkAUFCzLFjEkX/svndMHDBNlAKftPqboVfJToI5zmsQQStAg5G7lUMDeXomQGJ
 0LQVocTpnHCFSBRDm2eIBSQ6f9G5xAjKzYu18nTmV0KWcGFtGG0d2btsQt9VAS8uNy4pLdcY4DB
 MLyXZ2G8xDlef0LOda3t2aPb9QqOQQht0ZBRza0VfmYHw/Ux68Gyl9Nz3qzoEzl50idXRMQ2JEl
 mSD1POvL2zvwYyuutThqDnixFTtjvTTD+hAiyiK1M46MeYfG4BVLf43pzCs8ltSz3/+KQGZNP14
 EOcL2sF0NUIiIzTUFd0uoda6sIf0KzKosBJKQDF/JqfmTWdUsLCFJEdDFnNOHZWJKQu/5ODdrYL
 IoFvnCopUA00fDA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565671; x=1785170471; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cCrV6Hbfa+eSf55s9Z50KjUrwBR086QEfwahZGmioac=;
 b=frJery1krE7fuGeU3KRvO/dv87sAc96+tWLwu4PAf9/f4Iparsvz6HMDicIrYPvw/i
 2WqfTmcxwEPzekqoqTu6TFyWebfvisLyT+l1j/H7EQ6eAX2gbEs1XixZQzSz4EKm2VPA
 +qJ6E8sLoyHtrjDiIWgxvPVUnJzC4mYmh91fv40vgmjCR3Vf+Bl/yf0B5+8c3DqEAmtl
 Its3XCXKit4W56tMoDNKcp9gUfWdZSkHrpMPaS9R5vgP0tPeL/1xSY41qwi4aLgjEg3g
 ZDX6IV2SyU+zJEOcxdxkGX5A5nQ36OgOsuAE2yeaCzrUTLBo0fZ49LlG/N81LpU0CycH
 4ojg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=frJery1k
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="frJery1k"; 
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

Basic changes to adapt clk-conf to build properly on U-Boot

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/clk-conf.c   | 84 ++++++++++++++++++++++++--------------------
 include/linux/clk/clk-conf.h | 12 +++----
 2 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/ccf/clk-conf.c b/drivers/clk/ccf/clk-conf.c
index 303a0bb26e54..7b29562e297c 100644
--- a/drivers/clk/ccf/clk-conf.c
+++ b/drivers/clk/ccf/clk-conf.c
@@ -3,66 +3,65 @@
  * Copyright (C) 2014 Samsung Electronics Co., Ltd.
  * Sylwester Nawrocki <s.nawrocki@samsung.com>
  */
 
-#include <linux/clk.h>
+#include <dm/ofnode.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/compat.h>
 #include <linux/device.h>
-#include <linux/of.h>
 #include <linux/printk.h>
-#include <linux/slab.h>
 
-static int __set_clk_parents(struct device_node *node, bool clk_supplier)
+static int __set_clk_parents(ofnode node, bool clk_supplier)
 {
-	struct of_phandle_args clkspec;
+	struct ofnode_phandle_args clkspec;
 	int index, rc, num_parents;
 	struct clk *clk, *pclk;
 
-	num_parents = of_count_phandle_with_args(node, "assigned-clock-parents",
-						 "#clock-cells");
+	num_parents = ofnode_count_phandle_with_args(node, "assigned-clock-parents",
+						 "#clock-cells", 0);
 	if (num_parents == -EINVAL)
 		pr_err("clk: invalid value of clock-parents property at %pOF\n",
-		       node);
+		       &node);
 
 	for (index = 0; index < num_parents; index++) {
-		rc = of_parse_phandle_with_args(node, "assigned-clock-parents",
-					"#clock-cells",	index, &clkspec);
+		rc = ofnode_parse_phandle_with_args(node, "assigned-clock-parents",
+					"#clock-cells", 0, index, &clkspec);
 		if (rc < 0) {
 			/* skip empty (null) phandles */
 			if (rc == -ENOENT)
 				continue;
 			else
 				return rc;
 		}
-		if (clkspec.np == node && !clk_supplier) {
-			of_node_put(clkspec.np);
+		if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+			ofnode_put(clkspec.node);
 			return 0;
 		}
 		pclk = of_clk_get_from_provider(&clkspec);
-		of_node_put(clkspec.np);
+		ofnode_put(clkspec.node);
 		if (IS_ERR(pclk)) {
 			if (PTR_ERR(pclk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
-					index, node);
+					index, &node);
 			return PTR_ERR(pclk);
 		}
 
-		rc = of_parse_phandle_with_args(node, "assigned-clocks",
-					"#clock-cells", index, &clkspec);
+		rc = ofnode_parse_phandle_with_args(node, "assigned-clocks",
+					"#clock-cells", 0, index, &clkspec);
 		if (rc < 0)
 			goto err;
-		if (clkspec.np == node && !clk_supplier) {
-			of_node_put(clkspec.np);
+		if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+			ofnode_put(clkspec.node);
 			rc = 0;
 			goto err;
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-		of_node_put(clkspec.np);
+		ofnode_put(clkspec.node);
 		if (IS_ERR(clk)) {
 			if (PTR_ERR(clk) != -EPROBE_DEFER)
 				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
-					index, node);
+					index, &node);
 			rc = PTR_ERR(clk);
 			goto err;
 		}
 
@@ -78,40 +77,40 @@ err:
 	clk_put(pclk);
 	return rc;
 }
 
-static int __set_clk_rates(struct device_node *node, bool clk_supplier)
+static int __set_clk_rates(ofnode node, bool clk_supplier)
 {
-	struct of_phandle_args clkspec;
+	struct ofnode_phandle_args clkspec;
 	int rc, count, count_64, index;
 	struct clk *clk;
-	u64 *rates_64 __free(kfree) = NULL;
-	u32 *rates __free(kfree) = NULL;
+	u64 *rates_64 = NULL;
+	u32 *rates = NULL;
 
-	count = of_property_count_u32_elems(node, "assigned-clock-rates");
-	count_64 = of_property_count_u64_elems(node, "assigned-clock-rates-u64");
+	count = ofnode_count_u32_elems(node, "assigned-clock-rates");
+	count_64 = ofnode_count_u64_elems(node, "assigned-clock-rates-u64");
 	if (count_64 > 0) {
 		count = count_64;
 		rates_64 = kcalloc(count, sizeof(*rates_64), GFP_KERNEL);
 		if (!rates_64)
 			return -ENOMEM;
 
-		rc = of_property_read_u64_array(node,
+		rc = ofnode_read_u64_array(node,
 						"assigned-clock-rates-u64",
 						rates_64, count);
 	} else if (count > 0) {
 		rates = kcalloc(count, sizeof(*rates), GFP_KERNEL);
 		if (!rates)
 			return -ENOMEM;
 
-		rc = of_property_read_u32_array(node, "assigned-clock-rates",
+		rc = ofnode_read_u32_array(node, "assigned-clock-rates",
 						rates, count);
 	} else {
 		return 0;
 	}
 
 	if (rc)
-		return rc;
+		goto out_free;
 
 	for (index = 0; index < count; index++) {
 		unsigned long rate;
 
@@ -120,29 +119,30 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 		else
 			rate = rates[index];
 
 		if (rate) {
-			rc = of_parse_phandle_with_args(node, "assigned-clocks",
-					"#clock-cells",	index, &clkspec);
+			rc = ofnode_parse_phandle_with_args(node, "assigned-clocks",
+					"#clock-cells", 0,	index, &clkspec);
 			if (rc < 0) {
 				/* skip empty (null) phandles */
 				if (rc == -ENOENT)
 					continue;
 				else
-					return rc;
+					goto out_free;
 			}
-			if (clkspec.np == node && !clk_supplier) {
-				of_node_put(clkspec.np);
+			if (ofnode_equal(clkspec.node, node) && !clk_supplier) {
+				ofnode_put(clkspec.node);
 				return 0;
 			}
 
 			clk = of_clk_get_from_provider(&clkspec);
-			of_node_put(clkspec.np);
+			ofnode_put(clkspec.node);
 			if (IS_ERR(clk)) {
 				if (PTR_ERR(clk) != -EPROBE_DEFER)
 					pr_warn("clk: couldn't get clock %d for %pOF\n",
-						index, node);
-				return PTR_ERR(clk);
+						index, &node);
+				rc = PTR_ERR(clk);
+				goto out_free;
 			}
 
 			rc = clk_set_rate(clk, rate);
 			if (rc < 0)
@@ -152,8 +152,14 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 			clk_put(clk);
 		}
 	}
 	return 0;
+
+out_free:
+	kfree(rates);
+	kfree(rates_64);
+
+	return rc;
 }
 
 /**
  * of_clk_set_defaults() - parse and set assigned clocks configuration
@@ -166,13 +172,13 @@ static int __set_clk_rates(struct device_node *node, bool clk_supplier)
  * listed in its 'assigned-clocks' or 'assigned-clock-parents' properties.
  * If @clk_supplier is false the function exits returning 0 as soon as it
  * determines the @node is also a supplier of any of the clocks.
  */
-int of_clk_set_defaults(struct device_node *node, bool clk_supplier)
+int of_clk_set_defaults(ofnode node, bool clk_supplier)
 {
 	int rc;
 
-	if (!node)
+	if (!ofnode_valid(node))
 		return 0;
 
 	rc = __set_clk_parents(node, clk_supplier);
 	if (rc < 0)
diff --git a/include/linux/clk/clk-conf.h b/include/linux/clk/clk-conf.h
index eae9652c70cd..93bb6c582b4e 100644
--- a/include/linux/clk/clk-conf.h
+++ b/include/linux/clk/clk-conf.h
@@ -6,19 +6,17 @@
 
 #ifndef __CLK_CONF_H
 #define __CLK_CONF_H
 
+#include <dm/ofnode.h>
 #include <linux/types.h>
 
-struct device_node;
-
-#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
-int of_clk_set_defaults(struct device_node *node, bool clk_supplier);
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL)
+int of_clk_set_defaults(ofnode node, bool clk_supplier);
 #else
-static inline int of_clk_set_defaults(struct device_node *node,
-				      bool clk_supplier)
+int of_clk_set_defaults(ofnode node, bool clk_supplier)
 {
-	return 0;
+	return -ENOSYS;
 }
 #endif
 
 #endif /* __CLK_CONF_H */

-- 
2.55.0

