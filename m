Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283A4C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E53B680D58;
	Mon, 20 Jul 2026 18:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMBQzBIoHSgQ; Mon, 20 Jul 2026 18:09:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D672180D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570995;
	bh=JeAGNJWMrw5Exle1NK4OypNjvUkCc3w2k6WuYdU89Lk=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y+DwuviGjS5uGoxxJ8g3GiD4GVmJGzrkrec2N08ibFVkZMsCm4iAp9JbPnoDwHhrX
	 2L+wOWDPkT+WrfbzDkUvHklK7fkeV/QmcejvYXbV7fgQs1v+rvE8CEo8y1em7u6VMZ
	 Qa43z/1i41sSGQ8pQ2mkstMevyfwWx02J5bi6XVyl6bxP5yeXDTfaI3pLEd1/kcBaC
	 SZ0L9gL8ZOn4p3zD/y1IZo0+y8G5TjjE36qyeEB71X/ni0u6ZAw0fl9d20BW9K5cqz
	 CzbW0GYbGDxt+t7tCV29sw/YEOYZxm87ss+9cMxNIBXg1aGY+RF5GFeywVwMWHgVXP
	 i5BimBGCUn5uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D672180D32;
	Mon, 20 Jul 2026 18:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D76341DC9
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCAF3406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-bxTuGGQdQa for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8A862406BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A862406BE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A862406BE
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9FA84A4B; Mon, 20 Jul 2026 18:42:20 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB878493F
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:17 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso13768785e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565737; x=1785170537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JeAGNJWMrw5Exle1NK4OypNjvUkCc3w2k6WuYdU89Lk=;
 b=UPsffV5AAa/cct8DwUraJVNyJHMUnLfreoN7x6GXMuF6VVtTFY2YLN/R7wZllw0oAw
 MC8rZjEx9o+CpEOdwjbAaxVj8dUGpRTETPbtAItl1azdg5XPLJwwIRSZPh4U+8w/7ZgX
 bi2pehq7D2C9prpSTHIgCAiJ73rB1HJMozA/Q4l3Mzge2gkAeoTMXfYrrgcONweR75KJ
 dm6qHL4IW682ZY3NViN038CNWaeJx2LfhfEQmjDTjiF/jFen3r4AcwpylUDGaPGLlyz5
 VWCaqQ+GIO7+pyodv9dZ52B1M8L/QwzT+LuRyV1Ex7D1w1lUGt0OzRHsDHweXBm/SF3U
 DFnQ==
X-Gm-Message-State: AOJu0YxubllE0LXigT2Pb28x5g8wQ55kx7Gj9YIA0uhuKjsdlrdu+3BF
 37iZxR2eiTGeSBilgAEZzG2Sp6c3jvoE277/WUfkfumyHoVwnDjmj502Yaea7/mM+No=
X-Gm-Gg: AfdE7ckuQFB/zAWODiadND5rpNQP2fANgNNtLlQUVB5V7hFv7Yo0sFBvnN5pTE3ouZq
 4Sqq9z8HfQXOA7cu3ink4WEgvUnEeVM0rd7gZddjGFBquzHTBenVvJKqrjB8dedVN5FNblzDS/1
 1z+AnkEczRIVBYKTRM0Ra8C3gkfAdGa7BBhRyHG30+yM0ZwyCnbnO6UAHsu47po8VeEIp4B0wda
 V2RtOs2Po8wpeqBv3To9rmKcUdEk6WDcTZkbvMERZ+6C9zugTBc6xH6Nt+Z7VUZAOUP0QwUDCiQ
 rIhW9GMoS8QE6JFAG44Kw9JIK5p/Wv6vG8KccXZ/engdrJDPbBjt9l0rysqmu2o0Yn/Rig/gvlc
 fB6gkzwhzkZZtoFj/IAV356yDJZdjgHHRP/AEt7LnEqZGPDlH9OERuY1tHcsWrgir2tHDLGcVNS
 BSaxGm/irQppHwaXwcVUdBLN0YDhAPrg==
X-Received: by 2002:a05:600c:48aa:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-4954a516183mr112981185e9.28.1784565736697; 
 Mon, 20 Jul 2026 09:42:16 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:16 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:41:00 +0100
Subject: [PATCH 33/36] clk/qcom/ccf: adapt sm8650 clock drivers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-33-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10528;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=0/PqxxyD7xiUptUkcTM55hsnDcBzg4URVQ6S4w1SHqU=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+H+acnUUJGJzm//T+/AnTWg4FV9gW3E73jj
 PPgscfevPaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhwAKCRAFgzErGV9k
 tgkdD/9YMAckU/f33orqkGRv9pkqg/ldfrsgYT12wO5K5TcLET68cEzS+XwnJU518nkY/vx1D6+
 DuxKjpS3hrAsiFwo9AFwFdn5/dQo2JwKxiW+t0zfMzAX/OH0tHY96CIhxhDj9DOr2R2C61nWo4w
 rzAy2yTs1xRddKrUk5wo3/NYqE4l/p7Gm03+7l31JZdaypUKVkM1PkDkGT1xXEQaA7SqJv0dNd6
 gtwOHgqrKOMXH0zHlf/tDw56wlirdILjEXau9dqeK2RZiEusutp2amdMarm1v9mvU1CgZZDBiM+
 g4XfZD9oKZlFr6OoeW6awf7Hg4QNV9BICAFUzimqVkD/nbmXuQHYQO6Ep7JXQtZ6q6vkdAVfWDe
 pidRYRrx+iOXqLfop+WzAoelwMjYU73q6rhw692sUGXrHP6buTQJ6ADfBV/JNYfH3zMWRa5DeYh
 2SA1OIcnOFzmIHDu28BHDzHnaxYMrzetnyVxfEkWYPEdD5kRTpVloExDE8G006Dcter3CTSd+MD
 8pjvlscCOutuvZ+NQ+TEPttXMqvm0cM5DOgbi/FhH8scoskONc7ppDM90ykEbRBmH5b5klik0OY
 +sxN+WKwDlCthMZgRli4rbaqxJ6OVFspiJlGOIqNKs6L0P0eQ5xKSs/zZpYS+3FXphc3RXZu2UZ
 LHuERA0ZhmSFUGA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565737; x=1785170537; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JeAGNJWMrw5Exle1NK4OypNjvUkCc3w2k6WuYdU89Lk=;
 b=MAvmwqnN26hYnwmdetpRW/JTrkw5Mzpo+a586MQcewDAtaa/59jaswFC2nIh2myUYg
 3iFxkS7gYVSgFUEYfHaNfEEWXYdvGowmmdTmn0kpZVlLoHZFt/Wsd2nVpM7U3BTHIdbj
 PenyNhLgJ8r8sf0FHQl4edOpWqBsYBKhb0wOHXoOVg90qh5eSSrkXbFTxN6FNXtEuiZz
 pXbVGQiadHor8CXdUNBEhKD6fh6RNofarqyijAm2gDAp2BTRy9wDdbwNUOmXORxyv6/F
 fl4VNCzIr68+Ot54LEpb5+hrKR4p4kHGDFvxqP0HSJFZtTwrYh1k7RU57zPk2bfyhDad
 zf4w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=MAvmwqnN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="MAvmwqnN"; 
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

Make the necessary changes for the gcc, dispcc, and tcsrcc clocks on
SM8650 to work correctly in U-Boot, this basically just consists of
adding a U_BOOT_DRIVER definition and adjusting a few types.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/dispcc-sm8550.c | 51 ++++++++++++++++--------------------
 drivers/clk/qcom/ccf/gcc-sm8650.c    | 46 ++++++++++++++++----------------
 drivers/clk/qcom/ccf/tcsrcc-sm8650.c | 36 +++++++------------------
 3 files changed, 54 insertions(+), 79 deletions(-)

diff --git a/drivers/clk/qcom/ccf/dispcc-sm8550.c b/drivers/clk/qcom/ccf/dispcc-sm8550.c
index f27140c649f5..46fb0abbdd01 100644
--- a/drivers/clk/qcom/ccf/dispcc-sm8550.c
+++ b/drivers/clk/qcom/ccf/dispcc-sm8550.c
@@ -3,30 +3,27 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  * Copyright (c) 2023, Linaro Ltd.
  */
 
+#include <dm/device.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
 
 #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
 
 #include "common.h"
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
-#include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
-#include "clk-regmap-mux.h"
 #include "reset.h"
 #include "gdsc.h"
 
+#include "common-uboot.h"
+
 /* Need to match the order of clocks in DT binding */
 enum {
 	DT_BI_TCXO,
 	DT_BI_TCXO_AO,
@@ -1736,9 +1733,9 @@ static struct gdsc *disp_cc_sm8550_gdscs[] = {
 	[MDSS_GDSC] = &mdss_gdsc,
 	[MDSS_INT2_GDSC] = &mdss_int2_gdsc,
 };
 
-static const struct regmap_config disp_cc_sm8550_regmap_config = {
+static const struct compat_regmap_config disp_cc_sm8550_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x11008,
@@ -1754,41 +1751,38 @@ static const struct qcom_cc_desc disp_cc_sm8550_desc = {
 	.gdscs = disp_cc_sm8550_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sm8550_gdscs),
 };
 
-static const struct of_device_id disp_cc_sm8550_match_table[] = {
+static const struct udevice_id disp_cc_sm8550_match_table[] = {
 	{ .compatible = "qcom,sar2130p-dispcc" },
 	{ .compatible = "qcom,sm8550-dispcc" },
 	{ .compatible = "qcom,sm8650-dispcc" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, disp_cc_sm8550_match_table);
 
-static int disp_cc_sm8550_probe(struct platform_device *pdev)
+static int dispcc_sm8650_bind(struct udevice *dev)
+{
+	dev->driver_data = (ulong)&disp_cc_sm8550_desc;
+	return qcom_cc_bind_pd_reset(dev);
+}
+
+static int disp_cc_sm8550_probe(struct udevice *dev)
 {
 	struct regmap *regmap;
 	int ret;
 
-	ret = devm_pm_runtime_enable(&pdev->dev);
-	if (ret)
-		return ret;
-
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
-	regmap = qcom_cc_map(pdev, &disp_cc_sm8550_desc);
+	regmap = qcom_cc_map(dev, &disp_cc_sm8550_desc);
 	if (IS_ERR(regmap)) {
 		ret = PTR_ERR(regmap);
 		goto err_put_rpm;
 	}
 
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,sm8650-dispcc")) {
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,sm8650-dispcc")) {
 		lucid_ole_vco[0].max_freq = 2100000000;
 		disp_cc_mdss_mdp_clk_src.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src_sm8650;
 		disp_cc_mdss_dptx1_usb_router_link_intf_clk.clkr.hw.init->parent_hws[0] =
 			&disp_cc_mdss_dptx1_link_div_clk_src.clkr.hw;
-	} else if (of_device_is_compatible(pdev->dev.of_node, "qcom,sar2130p-dispcc")) {
+	} else if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,sar2130p-dispcc")) {
 		disp_cc_pll0_config.l = 0x1f;
 		disp_cc_pll0_config.alpha = 0x4000;
 		disp_cc_pll0_config.user_ctl_val = 0x1;
 		disp_cc_pll1_config.user_ctl_val = 0x1;
@@ -1803,9 +1797,9 @@ static int disp_cc_sm8550_probe(struct platform_device *pdev)
 
 	/* Keep some clocks always-on */
 	qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
 
-	ret = qcom_cc_really_probe(&pdev->dev, &disp_cc_sm8550_desc, regmap);
+	ret = qcom_cc_really_probe(dev, &disp_cc_sm8550_desc, regmap);
 	if (ret)
 		goto err_put_rpm;
 
 	pm_runtime_put(&pdev->dev);
@@ -1817,16 +1811,15 @@ err_put_rpm:
 
 	return ret;
 }
 
-static struct platform_driver disp_cc_sm8550_driver = {
+U_BOOT_DRIVER(dispcc_sm8650) = {
+	.name = "dispcc-sm8650",
+	.id = UCLASS_NOP,
+	.bind = dispcc_sm8650_bind,
 	.probe = disp_cc_sm8550_probe,
-	.driver = {
-		.name = "disp_cc-sm8550",
-		.of_match_table = disp_cc_sm8550_match_table,
-	},
+	.of_match = disp_cc_sm8550_match_table,
+	// .flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-module_platform_driver(disp_cc_sm8550_driver);
-
 MODULE_DESCRIPTION("QTI DISPCC SM8550 / SM8650  Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/qcom/ccf/gcc-sm8650.c b/drivers/clk/qcom/ccf/gcc-sm8650.c
index 9067bd05f8f7..31d70c9c40b2 100644
--- a/drivers/clk/qcom/ccf/gcc-sm8650.c
+++ b/drivers/clk/qcom/ccf/gcc-sm8650.c
@@ -9,8 +9,10 @@
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-gcc.h>
 
+#include "common-uboot.h"
+
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
@@ -3766,9 +3768,9 @@ static struct gdsc *gcc_sm8650_gdscs[] = {
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 	[USB3_PHY_GDSC] = &usb3_phy_gdsc,
 };
 
-static const struct regmap_config gcc_sm8650_regmap_config = {
+static const struct compat_regmap_config gcc_sm8650_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x1f41f0,
@@ -3784,20 +3786,27 @@ static const struct qcom_cc_desc gcc_sm8650_desc = {
 	.gdscs = gcc_sm8650_gdscs,
 	.num_gdscs = ARRAY_SIZE(gcc_sm8650_gdscs),
 };
 
-static const struct of_device_id gcc_sm8650_match_table[] = {
-	{ .compatible = "qcom,sm8650-gcc" },
+static const struct udevice_id gcc_sm8650_match_table[] = {
+	{
+		.compatible = "qcom,sm8650-gcc",
+		.data = (ulong)&gcc_sm8650_desc,
+	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, gcc_sm8650_match_table);
 
-static int gcc_sm8650_probe(struct platform_device *pdev)
+static int gcc_sm8650_bind(struct udevice *dev)
+{
+	return qcom_cc_bind_pd_reset(dev);
+}
+
+static int gcc_sm8650_probe(struct udevice *dev)
 {
 	struct regmap *regmap;
 	int ret;
 
-	regmap = qcom_cc_map(pdev, &gcc_sm8650_desc);
+	regmap = qcom_cc_map(dev, (struct qcom_cc_desc *)dev_get_driver_data(dev));
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
@@ -3820,29 +3829,18 @@ static int gcc_sm8650_probe(struct platform_device *pdev)
 
 	/* Clear GDSC_SLEEP_ENA_VOTE to stop votes being auto-removed in sleep. */
 	regmap_write(regmap, 0x52150, 0x0);
 
-	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8650_desc, regmap);
+	return qcom_cc_really_probe(dev, &gcc_sm8650_desc, regmap);
 }
 
-static struct platform_driver gcc_sm8650_driver = {
+U_BOOT_DRIVER(gcc_sm8650) = {
+	.name = "gcc-sm8650",
+	.id = UCLASS_NOP,
+	.bind = gcc_sm8650_bind,
 	.probe = gcc_sm8650_probe,
-	.driver = {
-		.name = "gcc-sm8650",
-		.of_match_table = gcc_sm8650_match_table,
-	},
+	.of_match = gcc_sm8650_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init gcc_sm8650_init(void)
-{
-	return platform_driver_register(&gcc_sm8650_driver);
-}
-subsys_initcall(gcc_sm8650_init);
-
-static void __exit gcc_sm8650_exit(void)
-{
-	platform_driver_unregister(&gcc_sm8650_driver);
-}
-module_exit(gcc_sm8650_exit);
-
 MODULE_DESCRIPTION("QTI GCC SM8650 Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/qcom/ccf/tcsrcc-sm8650.c b/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
index 3685dcde9a4b..3f158a923203 100644
--- a/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
+++ b/drivers/clk/qcom/ccf/tcsrcc-sm8650.c
@@ -5,11 +5,8 @@
  * Copyright (c) 2023, Linaro Limited
  */
 
 #include <linux/clk-provider.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm8650-tcsr.h>
 
@@ -132,9 +129,9 @@ static struct clk_regmap *tcsr_cc_sm8650_clocks[] = {
 	[TCSR_USB2_CLKREF_EN] = &tcsr_usb2_clkref_en.clkr,
 	[TCSR_USB3_CLKREF_EN] = &tcsr_usb3_clkref_en.clkr,
 };
 
-static const struct regmap_config tcsr_cc_sm8650_regmap_config = {
+static const struct compat_regmap_config tcsr_cc_sm8650_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = 0x3b000,
@@ -146,45 +143,32 @@ static const struct qcom_cc_desc tcsr_cc_sm8650_desc = {
 	.clks = tcsr_cc_sm8650_clocks,
 	.num_clks = ARRAY_SIZE(tcsr_cc_sm8650_clocks),
 };
 
-static const struct of_device_id tcsr_cc_sm8650_match_table[] = {
+static const struct udevice_id tcsr_cc_sm8650_match_table[] = {
 	{ .compatible = "qcom,milos-tcsr" },
 	{ .compatible = "qcom,sm8650-tcsr" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, tcsr_cc_sm8650_match_table);
 
-static int tcsr_cc_sm8650_probe(struct platform_device *pdev)
+static int tcsr_cc_sm8650_probe(struct udevice *dev)
 {
-	if (of_device_is_compatible(pdev->dev.of_node, "qcom,milos-tcsr")) {
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,milos-tcsr")) {
 		tcsr_ufs_clkref_en.halt_reg = 0x31118;
 		tcsr_ufs_clkref_en.clkr.enable_reg = 0x31118;
 		tcsr_cc_sm8650_clocks[TCSR_USB2_CLKREF_EN] = NULL;
 		tcsr_cc_sm8650_clocks[TCSR_USB3_CLKREF_EN] = NULL;
 	}
 
-	return qcom_cc_probe(pdev, &tcsr_cc_sm8650_desc);
+	return qcom_cc_probe(dev, &tcsr_cc_sm8650_desc);
 }
 
-static struct platform_driver tcsr_cc_sm8650_driver = {
+U_BOOT_DRIVER(tcsrcc_sm8650) = {
+	.name = "tcsr_cc-sm8650",
+	.id = UCLASS_NOP,
 	.probe = tcsr_cc_sm8650_probe,
-	.driver = {
-		.name = "tcsr_cc-sm8650",
-		.of_match_table = tcsr_cc_sm8650_match_table,
-	},
+	.of_match = tcsr_cc_sm8650_match_table,
+	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static int __init tcsr_cc_sm8650_init(void)
-{
-	return platform_driver_register(&tcsr_cc_sm8650_driver);
-}
-subsys_initcall(tcsr_cc_sm8650_init);
-
-static void __exit tcsr_cc_sm8650_exit(void)
-{
-	platform_driver_unregister(&tcsr_cc_sm8650_driver);
-}
-module_exit(tcsr_cc_sm8650_exit);
-
 MODULE_DESCRIPTION("QTI TCSRCC SM8650 Driver");
 MODULE_LICENSE("GPL");

-- 
2.55.0

