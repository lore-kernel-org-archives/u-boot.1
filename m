Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC6C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C40B80DAF;
	Mon, 20 Jul 2026 18:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4slhkqAKqbH; Mon, 20 Jul 2026 18:10:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 22F2080DBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571024;
	bh=bOkfajR61cSHyYNZXlUUDvIhZZ0v9Bg+atJjrfjpvzQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kHGJ6xa6qT+LV8lluGCNhOcf/co5BK5CfPJdOE8bkGLe7EOq+GcN2WhmV6/4+N8AV
	 Q9NpbrGTaYhXcD2tSO9Y5JwQvKMv4rlK7ylTWQXviafVYM4pov4Agfwma05Az0DJvA
	 F5JkJQhLStzYVit55XBd9PBLwvVX528RlZDGtJGpL3KzvU5PkDVSkzZKbIs/1nXHxY
	 m6IKHm/H2aGPfX0Yh3N683nQU07XU3u6h4LEpsId+yTRyT6nRqZh4xtyM8CZJyB1Fz
	 Si2yGTVfpnQ8qCD5BGpgEWJ/Dt185m/bSFC3cTBVJQuQymhVw+oy2y9sk4Kjy+WlVI
	 2YLV9MEJTNVdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 22F2080DBD;
	Mon, 20 Jul 2026 18:10:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B42F1518
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D1A5406C6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5kUDRonfC-yo for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4AA4C406B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AA4C406B0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AA4C406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A801384A29; Mon, 20 Jul 2026 18:41:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5ED8484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:39 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49557167508so19201525e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565699; x=1785170499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bOkfajR61cSHyYNZXlUUDvIhZZ0v9Bg+atJjrfjpvzQ=;
 b=DHWmOYSKKgnHcrlTSydrUusDec91A91zlif5sXayl6jheMxLXGlttk3JXtw7WWdPT5
 sxxF5dAGE9ZgWT/Ykcw8OAzEsFkVipkMO471zsD8XOkCz2T7alzAFrwoRJY8PTPzU6C5
 QAbmm7OCGRZ6oAoA3yXvJ3IXhnKrDha1vV2LKTAvTC/wzKNazkHXvOIzcWYoP44RjtA1
 kFv24fVC1TD4VyoGh49FrGgtg/fNdWdK1Jlcw14BDcUMFYV2+qUU6cSupgcpfTVlqcqf
 h+BiYV+t491mkHxUKqFJZho9h0dAOYVH+mUW1JqNztceKrBJncjRqm7lCNjJTmBV1CaU
 UWyA==
X-Gm-Message-State: AOJu0Ywb01kY20LzIWyHZqDxmsGo0knPJUszwbi2DU0SVyUQWifGFuyR
 tay70do0cuQ9IiHwlBRgrP0ciN5OOhAGEk9kRMvWhMm2AW2s3yZVVuqgC4rrc9mDzJI=
X-Gm-Gg: AfdE7cmvctG++uO/5Y6PURqc27SZE9AM1XWAkbeSWw25B7jcSXjQz+Q7GjL0pZFVrRS
 mx/WxMs9sKnM0qaRXJemKDJkvXAW8N7z5WQYNYGFuerhgiTWiLQIpE4hz0UifTuGvsRBaNYXoLT
 RaYf6gpBD5w1G0fP23e4iaUKisd3pI1ILKla1CrviO3fBC+DdAnlT3l38ueBC8nnezdVazZaJxb
 zTtF+ghithUvxRwNBUo4EsbQGqLWB4jCr3lemPaCQGfhmuG65KHDDF4WWtFBOQzoQjadqodDN4c
 Pi5FjYs+6ncirjCZQTmWWJNVtLlYyYqzFcG4ojA9tueFwhJJPSNlI5l6lVJMVCp8woq/BGBrZZS
 qTTOEcowrsbsfb9R/5HE1FqhqxVQBXxWSqY+pjMnQPm8qwsLu4IyE9Hw/QXX/+4GWfF6NozCgAG
 sABukC5aHg3luIkEU89dK2DH/qtaSoLQ==
X-Received: by 2002:a05:600c:322a:b0:495:5dcc:52b4 with SMTP id
 5b1f17b1804b1-4955dcc535amr40604345e9.3.1784565698858; 
 Mon, 20 Jul 2026 09:41:38 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:38 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:47 +0100
Subject: [PATCH 20/36] clk: sandbox: fix set_rate and move to clk/basic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-20-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5186;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=RzbZbSmgEkBaTOKE3Jgr8iYwsexiOgJAx0HltXWV5x0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+E/eXu4iEBx5129CWNAMeCBsk5P8qhfEl8R
 qAK2xXUm8SJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 tiSuD/0bbOZjcXj9LRpf6FMYQ6wIGYC0QUrV+mSaXxKqfxkbKRzBAlrRRWoli/3b9jWzXk7VOe4
 9UqYL0iWYz39crLUhxXZe7kfwTdcS/qq+37EPYFpDBSD+S8Pa+5nE+X7hZ3r0jU80/CXkXUkwAK
 BIJsGdX/2PX8WzWdMv654IBbALlre9KmDy9ZEg+YvwvKhsEPGY19f1zZhNFpl7b2K58y0K0r6Gd
 eZIWX2Q4RntPOQq9fUJygs0g0b/yP/yvMnEZ1Y4Grb8Ob52VVZwYWEdoWxwr82e3U9wW++c6Ucz
 Ob9Zsa4xz9BUSXnEdNL2ohMIcqTn14ikKCJyu2RQ7FIuXED8AMLhr5LVo+u0LWBb0LC8+5YEtzR
 LQCc0Da1GfgAmuLh2LJHJhhV0GUs7BEIqlRFU4UlLi8ATUok/LlH68egQXygamul0df2+pAo7/8
 zh1yX+6GM3K+MLo8O61T2ieegAehLv6ETjA6MCsf+OF5kFmk7JubNpTxJ7kNT12N8jZa1l5MuWh
 3JiPDchUds4HGz4ZYv5CFHBWXhM98GDZ7DpVoapE/+vayoSm8Uz1IlJuUdQbSqlnKwC0yS4PiJf
 uV7MuwOQtdj9A5Zl5kGqC0JyL60dm4ruc4kol2bkBgIiqLEdzthsTvEy1cZQZgony9CImaDRvzV
 XwH91tgoDiH/3ig==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565699; x=1785170499; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bOkfajR61cSHyYNZXlUUDvIhZZ0v9Bg+atJjrfjpvzQ=;
 b=Ka9RNEV1Tty5PGgGzg+K/A0J6dvVYdFTl+L7sKkJOPwRdhmiotefgakVVWsn7q3TTB
 TAoSCHpVKzaNNB/9R/IrGT/rJGVpXIyLaplwjaOH1esYgUD63cqFj/Y/artT/3ro9EPF
 EPKKd4QZV90JX+yad++ozSYVVNuXnVA1Qk75qKgl4SLRH1U0vMYZBVjQNIdPBue2MAyy
 Q6mJ2yLBTYk2pJlUQ2KLsT3MMiumrEnwk+ywlS1hh7rvv9b+ON5lt/ZtUiytN7UXvqS8
 H1I5Ts9rIbVG8ItpVoqB1nppY2CIGYBbXNJ391/k/p4cNVRTRlF8UnuDCi9raMVxKwXt
 GXqQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Ka9RNEV1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ka9RNEV1"; 
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

Prepare for adding a CCF version of clk_sandbox by moving the existing
version to clk/basic. Additionally fix the clk_set_rate() tests which
erroneously expect set_rate to return the old clock rate, this doesn't
match the documentation nor any real implementations or users. Adjust it
to return the new rate instead.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile                  |  1 -
 drivers/clk/basic/Makefile            |  1 +
 drivers/clk/{ => basic}/clk_sandbox.c | 47 ++---------------------------------
 test/dm/clk.c                         |  8 +++---
 4 files changed, 7 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4bec2e4c61a8..52a9fc01106c 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -64,6 +64,5 @@ obj-$(CONFIG_CLK_XLNX_CLKWZRD) += clk-xlnx-clock-wizard.o
 obj-$(CONFIG_CLK_ZYNQ) += clk_zynq.o
 obj-$(CONFIG_CLK_ZYNQMP) += clk_zynqmp.o
 obj-$(CONFIG_CLK_ICS8N3QV01) += ics8n3qv01.o
 obj-$(CONFIG_MACH_PIC32) += clk_pic32.o
-obj-$(CONFIG_SANDBOX) += clk_sandbox.o
 obj-$(CONFIG_SANDBOX) += clk_sandbox_test.o
diff --git a/drivers/clk/basic/Makefile b/drivers/clk/basic/Makefile
index 4cf9469d2312..bc0282d4e247 100644
--- a/drivers/clk/basic/Makefile
+++ b/drivers/clk/basic/Makefile
@@ -4,4 +4,5 @@
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_rate.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk_fixed_factor.o
+obj-$(CONFIG_SANDBOX) += clk_sandbox.o
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/basic/clk_sandbox.c
similarity index 80%
rename from drivers/clk/clk_sandbox.c
rename to drivers/clk/basic/clk_sandbox.c
index 36ca128892b5..1092a5a085fc 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/basic/clk_sandbox.c
@@ -43,9 +43,8 @@ static ulong sandbox_clk_round_rate(struct clk *clk, ulong rate)
 
 static long sandbox_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
-	ulong old_rate;
 	ulong id = clk_get_id(clk);
 
 	if (!priv->probed)
 		return -ENODEV;
@@ -55,12 +54,11 @@ static long sandbox_clk_set_rate(struct clk *clk, ulong rate)
 
 	if (!rate)
 		return -EINVAL;
 
-	old_rate = priv->rate[id];
 	priv->rate[id] = rate;
 
-	return old_rate;
+	return rate;
 }
 
 static int sandbox_clk_enable(struct clk *clk)
 {
@@ -165,9 +163,8 @@ int sandbox_clk_query_requested(struct udevice *dev, int id)
 		return -EINVAL;
 	return priv->requested[id];
 }
 
-#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
 static int clk_fixed_rate_of_to_plat(struct udevice *dev)
 {
 	struct clk_fixed_rate *cplat;
 
@@ -196,45 +193,5 @@ U_BOOT_DRIVER(sandbox_fixed_clock) = {
 	.of_to_plat = clk_fixed_rate_of_to_plat,
 	.plat_auto = sizeof(struct sandbox_clk_fixed_rate_plat),
 	.ops = &clk_fixed_rate_ops,
 	.flags = DM_FLAG_PRE_RELOC,
-};
-#else
-static int clk_fixed_rate_probe(struct udevice *dev)
-{
-	ofnode node = dev_ofnode(dev);
-	const char *clk_name;
-	struct clk_hw *hw;
-	u32 rate = 0;
-	int ret;
-
-	ofnode_read_u32(node, "clock-frequency", &rate);
-
-	clk_name = ofnode_read_string(node, "clock-output-names");
-	if (!clk_name)
-		clk_name = ofnode_get_name(node);
-
-	hw = clk_hw_register_fixed_rate(dev, clk_name, NULL, 0, rate);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
-	if (ret) {
-		clk_hw_unregister_fixed_rate(hw);
-		return ret;
-	}
-
-	return 0;
-}
-
-static const struct udevice_id sandbox_clk_fixed_rate_match[] = {
-	{ .compatible = "sandbox,fixed-clock" },
-	{ /* sentinel */ }
-};
-
-U_BOOT_DRIVER(sandbox_fixed_clock) = {
-	.name = "sandbox_fixed_clock",
-	.id = UCLASS_NOP,
-	.of_match = sandbox_clk_fixed_rate_match,
-	.probe = clk_fixed_rate_probe,
-};
-#endif
+};
\ No newline at end of file
diff --git a/test/dm/clk.c b/test/dm/clk.c
index 790968e64774..67d9a2bb4815 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -99,24 +99,24 @@ static int dm_test_clk(struct unit_test_state *uts)
 	ut_assert(IS_ERR_VALUE(rate));
 	rate = sandbox_clk_test_get_rate(dev_test, SANDBOX_CLK_TEST_ID_FIXED);
 	ut_asserteq(1234, rate);
 
-	ut_asserteq(0, sandbox_clk_test_set_rate(dev_test,
+	ut_asserteq(1000, sandbox_clk_test_set_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_SPI,
 						 1000));
-	ut_asserteq(0, sandbox_clk_test_set_rate(dev_test,
+	ut_asserteq(2000, sandbox_clk_test_set_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_I2C,
 						 2000));
 
 	ut_asserteq(1000, sandbox_clk_test_get_rate(dev_test,
 						    SANDBOX_CLK_TEST_ID_SPI));
 	ut_asserteq(2000, sandbox_clk_test_get_rate(dev_test,
 						    SANDBOX_CLK_TEST_ID_I2C));
 
-	ut_asserteq(1000, sandbox_clk_test_set_rate(dev_test,
+	ut_asserteq(10000, sandbox_clk_test_set_rate(dev_test,
 						    SANDBOX_CLK_TEST_ID_SPI,
 						    10000));
-	ut_asserteq(2000, sandbox_clk_test_set_rate(dev_test,
+	ut_asserteq(20000, sandbox_clk_test_set_rate(dev_test,
 						    SANDBOX_CLK_TEST_ID_I2C,
 						    20000));
 
 	rate = sandbox_clk_test_set_rate(dev_test, SANDBOX_CLK_TEST_ID_SPI, 0);

-- 
2.55.0

