Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0CBC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA92560768;
	Mon, 20 Jul 2026 18:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JzJV7oDS5qWJ; Mon, 20 Jul 2026 18:10:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB46C60710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571004;
	bh=ZBjRfHJbz9Q/kmRkMpUXsMifrLHINDzDRdGOoNnVEfM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kTumd8Ab8yJzudlT93kXpUb0XylqsX3gMxKkM2MzlfT2+ihpWl5MPe5EpLb//dDFC
	 ppOvJGUtrYEvkFHRJtpAEOhySA5VFNQNn+SOglE4GivBL85j+fjB5N9Hyo7ZvVqlcB
	 YHWNu7xrKWbxoUVHo6+vNEeeHT8aMID7b7RWkjzMTZ0S4IclpWHVXz/mCd28s/ED+E
	 MgThRZ04A83jP4jDbeEy6H5LvFvMBqKh4Rngcq0Y4tPgsFsKNzYJw16g9GQBDNjzBC
	 9QqXhMNr/Ib6UBA3ya42XR7Y/S1+4IYno4zyc/PrDVpjzJCS+OR574aUiHsxH0JlEk
	 rb/JGDrPWV8ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB46C60710;
	Mon, 20 Jul 2026 18:10:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AF3B1EA5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5A6940159
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8eRxuNhnLqcP for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4278640136
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4278640136
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4278640136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85B084974; Mon, 20 Jul 2026 18:41:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3B6849A1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:21 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso13761305e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565681; x=1785170481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZBjRfHJbz9Q/kmRkMpUXsMifrLHINDzDRdGOoNnVEfM=;
 b=SBR2APLgCTKw9JPF4Gyw3GI+/QA/3gEMu4BLq8WWhBUfnA+bBPL9Ci/fQznjQWiCIG
 14hC1irOVWZvB+Con0npbdGksjKlb6zrvHoPAMdHKaf2MtGkTHizoD7aPYYWgpxS9YjR
 LHyHJocvs5FEI0czDoVhpcB1krJ8Z8VqCuSK7gRhhZH7nSKm6AcE9shrYsP9v+o5SZsV
 F4q+p5DT+Q2G2KgW0L5wx/QFEshg7KwcKWDd3m7q7jfQnnY1Zg29MGalBO12wUjUJMoZ
 93CP9oXQMREzmndAFJF8N4+XwmuxjWUi41CczpmqtESnGp7K9a3OEKrDEOIkNj3erbaJ
 AqOA==
X-Gm-Message-State: AOJu0YyYiXOM2fXZh7BPAAOY3/ucuqyi4QsFp9oFm8NVnbc+KM5heieU
 dNUQPTbnQuBPsm5wAHJ+8m6Q5rrjDqIncAd86vXCk66OkDmCPx3Xru3pXK6zfCSlQNo=
X-Gm-Gg: AfdE7clZT2VA9u5uz2FpvfIWsfKwNOPhDchXfe5srQoH9NDiO8B8WR9uYXVa1PcEonC
 TvZOuMuWL/+yya9GkMc0M9DUhGJwSVUQs07CFYz2n5pnflys+F/vjOezSniInrmPGLSVUiinspO
 9yGMC3X6MGrTOLJLrEMJ5oLrXn66vW1QtbeI3B11mbSscOSP/cveJ0OpWoC5lql6CkSUN8mTfAl
 auiK8Pz8a3DInVt/WJegtGXXo6x6i7BmLY1u6PjGHl0mXNJRagpqOAK/mNkarHWEd4n1FWHgSxW
 wBOb1DmWiVIt1ziZDqEK6amsOLqobz7/9vNKvMtxZffws8iT5bYce5agAcUyTlMGZmirjQCh0O3
 obpkgXEFDbo2q7tLHFSd1izjsIY5RUa2BWc6qCRyn8jJEd1vYYUuOrFT/E+KDW42bnaovf+MaI7
 j5pubTAfJjkF3ZDHLw3EpJ/tRAWJ+PQw==
X-Received: by 2002:a05:600c:4f84:b0:495:4f81:336a with SMTP id
 5b1f17b1804b1-4954f813462mr147884565e9.19.1784565681152; 
 Mon, 20 Jul 2026 09:41:21 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:20 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:40 +0100
Subject: [PATCH 13/36] clk: split clk-uclass.c into clk-common.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-13-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14730;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cWiRhIED8vJJY0o1/c7J10dnVW0kzaoMttOwg7OIkxI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+Dv2XZeLjX1OHhUCLAgZveWrRf3FA6FOWMO
 kcYEVuHz3CJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tt3WD/9Ul27CEGvXCnkRhckrtj5IYjpOR2NbNw2ut4o8vLIaX07n8NtMIKocj9hZLwwG4/6jrWR
 EVVwMJoW+nBDnYaSzKvilNXRBthG+c1D9iMFy6Q35y3SEsAmRAGNs0jToYIG18QB1SCGvPSI5GL
 sHJLkYT9wX9VG2gQlAnB/7JrsMvzLsR+lR2sl8+bQ8OWf/n7GDOGYaZGzkextUVoU6I8Wj9jK2a
 /LIaP7VE6MZJ0ILgFglLgwZ45CgFFb9/7MlrjRiFCF6I7WtVn5C8UBKT0DqzFSV/OYIKbpiUcMN
 BaqGc/xnm9Dobrbu6nc2JJnnOgsmW8EdW9ld1H+pq59wKgKL2CaIv64XqMLWLjn6G2SiETCPns3
 F1a7udS6WoMhtV8JT1kD7YpkiTehRZ9c9WavrsK+JMZBmfE3MDzE1HNZlw642k6b+bbvUpA/IJ7
 LUlbJOidP60PRGYVZobFVEx9QqJqvcU/92yNZND6trnKtTPrsNqgQ6sFzToJiFuHN4mxeVzBk83
 1yYkrs5DsmUFNSbNTVJ6m2uhcSB13OZqZjzwsF+zLODJJ8IxjqL6fwCaHDy9g4BdNfrIUxrv+1n
 nNZPIbjlRaki+GfaRGJUou6Z8XCpFzS+WptHjfahtwjgmPPNsz5/bNCZNe0I0cbWQC5rd4rgkW3
 8Br7iifdN2dND1A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565681; x=1785170481; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZBjRfHJbz9Q/kmRkMpUXsMifrLHINDzDRdGOoNnVEfM=;
 b=BY0klUTdmUgHdGVCseCX+YV4DvKEixW8tpYkyP/A3nDHd/+wMVISe6pgl1KWK9ZMjs
 VmInLANK3ldUE9vj42ltOlAhTwOPA382LPEfCV4C49VyoapJ0fXDUk44d1GL4vntrVGy
 eJskiA/HKBd1AofVlQsSl3pWfusw0sld2Qf7BSH8KI6tyxQdy2OeLbPmTbDgUC/cwGXp
 ZFhWQEuKcWkBABxghKYq5hJz8cE0oXDtOkfhSdhSAc9dsKm/fu0oOwI/5N+r/nEghlC3
 XnaioW9x3QFWnQXEjUWp0HsnY1BmS4HdA+6p3K4DIayEyzTtX9d4XZw3ltaBCFVJ3HZ/
 1+Nw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BY0klUTd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="BY0klUTd"; 
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

clk-uclass.c contains all of the UCLASS_CLK specific code but it also
contains common clk functionality which is generic between UCLASS_CLK
and CCF.

Split this functionality out so that we can reuse it with CCF and avoid
building clk-uclass.c entirely.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile         |   8 +-
 drivers/clk/clk-common.c     | 220 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-common.h     |  45 +++++++++
 drivers/clk/clk-uclass.c     | 175 ++--------------------------------
 include/linux/clk-provider.h |   3 +
 5 files changed, 278 insertions(+), 173 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dd71d005aada..ee06bffaef72 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -4,19 +4,19 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
 obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
+obj-$(CONFIG_$(PHASE_)CLK) += clk-common.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
 # Full Linux CCF support
-obj-$(CONFIG_$(PHASE_)CLK_CCF_FULL) += ccf/
-
+ifdef CONFIG_CLK_CCF_FULL
+obj-y += ccf/
+else
 # U-Boot basic fixed clocks, full CCF has a
 # different and incompatible implementation
-ifndef CONFIG_CLK_CCF_FULL
 obj-y += basic/
-
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 endif
 
diff --git a/drivers/clk/clk-common.c b/drivers/clk/clk-common.c
new file mode 100644
index 000000000000..7f30ad496da2
--- /dev/null
+++ b/drivers/clk/clk-common.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2015 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ * Copyright (c) 2016, NVIDIA CORPORATION.
+ * Copyright (c) 2018, Theobroma Systems Design und Consulting GmbH
+ *
+ * Common clock support code shared between CCF_FULL and UCLASS_CLK
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-structs.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/global_data.h>
+#include <dm/device_compat.h>
+#include <dm/device-internal.h>
+#include <dm/devres.h>
+#include <dm/read.h>
+#include <linux/bug.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+
+#include "clk-common.h"
+
+#if CONFIG_IS_ENABLED(OF_REAL)
+int clk_get_by_index(struct udevice *dev, int index, struct clk *clk)
+{
+	return clk_get_by_index_nodev(dev_ofnode(dev), index, clk);
+}
+
+int clk_get_by_index_nodev(ofnode node, int index, struct clk *clk)
+{
+	struct ofnode_phandle_args args;
+	int ret;
+
+	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
+					     index, &args);
+
+	return clk_get_by_index_tail(ret, node, &args, "clocks",
+				     index, clk);
+}
+
+int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
+{
+	int i, ret, err, count;
+
+	bulk->count = 0;
+
+	count = dev_count_phandle_with_args(dev, "clocks", "#clock-cells", 0);
+	if (count < 1)
+		return count;
+
+	bulk->clks = devm_kcalloc(dev, count, sizeof(struct clk), GFP_KERNEL);
+	if (!bulk->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		ret = clk_get_by_index(dev, i, &bulk->clks[i]);
+		if (ret < 0)
+			goto bulk_get_err;
+
+		++bulk->count;
+	}
+
+	return 0;
+
+bulk_get_err:
+	err = clk_release_all(bulk->clks, bulk->count);
+	if (err)
+		debug("%s: could not release all clocks for %s\n",
+		      __func__, dev_read_name(dev));
+
+	return ret;
+}
+
+int clk_get_by_name(struct udevice *dev, const char *name, struct clk *clk)
+{
+	return clk_get_by_name_nodev(dev_ofnode(dev), name, clk);
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
+	ret = clk_set_default_parents(dev, stage);
+	if (ret)
+		return ret;
+
+	ret = clk_set_default_rates(dev, stage);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+struct clk *devm_clk_get(struct udevice *dev, const char *id)
+{
+	int rc;
+	struct clk *clk;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (unlikely(!clk))
+		return ERR_PTR(-ENOMEM);
+
+	rc = clk_get_by_name(dev, id, clk);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return clk;
+}
+
+int clk_prepare_bulk(struct clk_bulk *bulk)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = clk_prepare(&bulk->clks[i]);
+		if (ret < 0 && ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
+int clk_unprepare_bulk(struct clk_bulk *bulk)
+{
+	int i, ret;
+
+	for (i = 0; i < bulk->count; i++) {
+		ret = clk_prepare(&bulk->clks[i]);
+		if (ret < 0 && ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
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
diff --git a/drivers/clk/clk-common.h b/drivers/clk/clk-common.h
new file mode 100644
index 000000000000..fbb1bd5b3ba0
--- /dev/null
+++ b/drivers/clk/clk-common.h
@@ -0,0 +1,45 @@
+
+#include <dm/ofnode.h>
+#include <clk.h>
+
+#ifndef __CLK_COMMON_H__
+#define __CLK_COMMON_H__
+
+/* These functions are unused with CCF_FULL */
+
+#if !CONFIG_IS_ENABLED(CLK_CCF_FULL)
+int clk_get_by_index_tail(int ret, ofnode node,
+				 struct ofnode_phandle_args *args,
+				 const char *list_name, int index,
+				 struct clk *clk);
+
+int clk_set_default_parents(struct udevice *dev,
+				   enum clk_defaults_stage stage);
+
+
+int clk_set_default_rates(struct udevice *dev,
+				 enum clk_defaults_stage stage);
+#else
+int clk_get_by_index_tail(int ret, ofnode node,
+				 struct ofnode_phandle_args *args,
+				 const char *list_name, int index,
+				 struct clk *clk)
+{
+	return -ENOSYS;
+}
+
+int clk_set_default_parents(struct udevice *dev,
+				   enum clk_defaults_stage stage)
+{
+	return -ENOSYS;
+}
+
+int clk_set_default_rates(struct udevice *dev,
+				 enum clk_defaults_stage stage)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_CLK_CCF_FULL */
+
+#endif /* __CLK_COMMON_H__ */
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index e960d2ad2383..e6036d880cb7 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -23,8 +23,10 @@
 #include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 
+#include "clk-common.h"
+
 static inline const struct clk_ops_uboot *clk_dev_ops(struct udevice *dev)
 {
 	return (const struct clk_ops_uboot *)dev->driver->ops;
 }
@@ -74,9 +76,9 @@ static int clk_of_xlate_default(struct clk *clk,
 
 	return 0;
 }
 
-static int clk_get_by_index_tail(int ret, ofnode node,
+int clk_get_by_index_tail(int ret, ofnode node,
 				 struct ofnode_phandle_args *args,
 				 const char *list_name, int index,
 				 struct clk *clk)
 {
@@ -114,8 +116,9 @@ err:
 	      __func__, ofnode_get_name(node), list_name, index, ret);
 
 	return log_msg_ret("prop", ret);
 }
+#endif /* OF_REAL */
 
 static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
 				   int index, struct clk *clk)
 {
@@ -139,58 +142,8 @@ static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
 	return clk_get_by_index_tail(ret, dev_ofnode(dev), &args, "clocks",
 				     index, clk);
 }
 
-int clk_get_by_index(struct udevice *dev, int index, struct clk *clk)
-{
-	return clk_get_by_index_nodev(dev_ofnode(dev), index, clk);
-}
-
-int clk_get_by_index_nodev(ofnode node, int index, struct clk *clk)
-{
-	struct ofnode_phandle_args args;
-	int ret;
-
-	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
-					     index, &args);
-
-	return clk_get_by_index_tail(ret, node, &args, "clocks",
-				     index, clk);
-}
-
-int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
-{
-	int i, ret, err, count;
-
-	bulk->count = 0;
-
-	count = dev_count_phandle_with_args(dev, "clocks", "#clock-cells", 0);
-	if (count < 1)
-		return count;
-
-	bulk->clks = devm_kcalloc(dev, count, sizeof(struct clk), GFP_KERNEL);
-	if (!bulk->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < count; i++) {
-		ret = clk_get_by_index(dev, i, &bulk->clks[i]);
-		if (ret < 0)
-			goto bulk_get_err;
-
-		++bulk->count;
-	}
-
-	return 0;
-
-bulk_get_err:
-	err = clk_release_all(bulk->clks, bulk->count);
-	if (err)
-		debug("%s: could not release all clocks for %s\n",
-		      __func__, dev_read_name(dev));
-
-	return ret;
-}
-
 static struct clk *clk_set_default_get_by_id(struct clk *clk)
 {
 	struct clk *c = clk;
 
@@ -206,9 +159,9 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
 
 	return c;
 }
 
-static int clk_set_default_parents(struct udevice *dev,
+int clk_set_default_parents(struct udevice *dev,
 				   enum clk_defaults_stage stage)
 {
 	struct clk clk, parent_clk, *c, *p;
 	int index;
@@ -289,9 +242,9 @@ static int clk_set_default_parents(struct udevice *dev,
 
 	return 0;
 }
 
-static int clk_set_default_rates(struct udevice *dev,
+int clk_set_default_rates(struct udevice *dev,
 				 enum clk_defaults_stage stage)
 {
 	struct clk clk, *c;
 	int index;
@@ -371,62 +324,8 @@ fail:
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
@@ -443,28 +342,8 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
 
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
 
@@ -704,21 +583,8 @@ int clk_enable(struct clk *clk)
 
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
@@ -769,21 +635,8 @@ int clk_disable(struct clk *clk)
 
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
@@ -821,24 +674,8 @@ bool clk_is_match(const struct clk *p, const struct clk *q)
 
 	return false;
 }
 
-struct clk *devm_clk_get(struct udevice *dev, const char *id)
-{
-	int rc;
-	struct clk *clk;
-
-	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
-	if (unlikely(!clk))
-		return ERR_PTR(-ENOMEM);
-
-	rc = clk_get_by_name(dev, id, clk);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return clk;
-}
-
 int clk_prepare(struct clk *clk)
 {
 	return 0;
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4fcdb5a86799..17d6190134dd 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -39,8 +39,11 @@
  */
 #if CONFIG_IS_ENABLED(CLK_CCF_FULL)
 #include "clk-provider-ccf_full.h"
 #else
+/* Forward-declare clk_hw so we can compile code that references it even though it's unused*/
+struct clk_hw;
+
 #include "clk-provider-uccf.h"
 #endif
 
 #endif /* __LINUX_CLK_PROVIDER_H */

-- 
2.55.0

