Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FF5C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8559D4066E;
	Mon, 20 Jul 2026 18:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OC9i48IjJMf5; Mon, 20 Jul 2026 18:10:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F01D640707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571023;
	bh=D3AlHdiYSL6VJWWkYTDBsECcn24qaXE5oBvz5keOQWQ=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=k0RgKsfOjPkH1FHUeES/zXnRhbrz13/DdDsYlHOV835rjge4u676cDTYvoZpwhHik
	 +eZ3F14eHMdDLANNxesXV9v2bB+/Nd6PZgnWJYHLqn8sijBk5ou3TISWdjjMOOGvn4
	 solgTsF4SXIpKsHRJFGv1+9PLsEai58m6R211s9PfdOrqO2wNMOleUnnEfWl/M/+jK
	 ADs8uMuGHRsJic0ZXdSrVBa2YitJQdJfjuJ1S3s0m2yWgn8Kx8869zBLi7q8cvJqzi
	 qgKdSIhik6Ziq44pJoUMbh5W3QCv9BhXcOGleQPKq9YrvmwJS3NC1G+MxOd4EYw8Zc
	 xiPcnfERqmF6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01D640707;
	Mon, 20 Jul 2026 18:10:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61BFC1DF3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5436160716
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZ7hmSOszMeF for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 399746071F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 399746071F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 399746071F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3666A849BC; Mon, 20 Jul 2026 18:41:26 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19F678484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:24 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso17635205e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565683; x=1785170483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D3AlHdiYSL6VJWWkYTDBsECcn24qaXE5oBvz5keOQWQ=;
 b=DqPXIdTACFB8s2OqKPHju5DauCT0ayBj/L0WKldHfFWTnUohtUsf+TfN98yY3mxCtv
 hl2EctDVOB0LC24UNxpcfnB4euN/Qp3FcMnmKTa86OVprqDOSiDBi07syRvwScxdrYSM
 gIcidMh54cWNcMfoR0EEKDaYmql+2qrUsgnM7Ae3uCEleotkDX+JePm5WnG2wTfnTaAm
 zGSIWGT93iKGaiUmpIppvOA81h49JIeHRD1oSUCG1SOpSgbRtbD+ZIekpc1qKVnbzgeL
 eV4iqsKs2UXQMTT58Pj7FOCrkicVbfxAKS8gPqJjuKISt1CCHDXKMlEZdQioHrR//RAu
 h3BQ==
X-Gm-Message-State: AOJu0Yw/knbrU25qrzsCrHjhJ/08j8N/hOCp/WBHTQjx9WaliuXhDB98
 VyExdl/Ltm8EbkCZMa4Y1ma4U9oxFhvldgXaj0eJdwoGL9UVlp92+A3+SlyUaBk57jw=
X-Gm-Gg: AfdE7cliYRKsLtT2cugym8nyZ44lmMzNjQBIPzLgrg5+1ISOBr0yj8E0tEm3T+9ndol
 YcMbwPJBK0gfhRrj+Ddg+yMd6JkWO88iKQiaxmrpGWPEuMD2wwTmhHKL2QZIItXTDdxJbPjEJmK
 f9ieGz22GkdA69GOrIOakx7uNzJlUcgPosOXu73OUsrPRbd0SIJJf5oomWa1tevjXj4qZ0WFx67
 kydUfHNuZZjQmAiSoa8IlNo58N1oTrdxTS298hkZ3OLupiz3i2bogPMcIRh1XYphtmKrqMi1eGF
 ZtOq7TvnKXyrNIihhMs/Qqa7m3nGp41RFWGLkntMIqyVsmpxXk9ihuq+wcZMOZRittM7tSZzTCX
 3AS2HmuNeghPwQXeQWSgz/xAvlphQno+0WsJ81bhMqoRStV9ecDrQ8dRHQGAns/5j/m95vicNC1
 tgTMn8LBGoeCS2N9cDKIc0Zb2tB/FjmQ==
X-Received: by 2002:a05:600c:3baa:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-4954a514007mr206346065e9.31.1784565683505; 
 Mon, 20 Jul 2026 09:41:23 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:41 +0100
Subject: [PATCH 14/36] clk/common: add CCF_FULL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-14-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4353;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=DkxGnpemrFJ4DESGb2/CIw06B19pgadx2pvnR5kdV9s=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+DSz9sFzt/GVgPg6XyZSggFTpGKa/WwrIjC
 YaHNvkMphiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tuVoD/0dxY0VCuavqDf/rrgV96bOvW214dW2ppchfcF/v7bG447VypiPJ73nO6SKkOp2QfJFGRy
 oeFhMxMg7djYiHKHoNUzwR+R0P4s7Z0fWRusp2YNv0R3jWAUORMlTMn/RuybPodalE+Qdqw8N4q
 3ouqP4LWLH0epkfbJYp9GR+OGmUdmgHgcG2J/FhmX8xj3cZVvr+E0u8NFQ3YISKIhwYIPz8rL0R
 +f41R2U1cOKb20ZldEJQXa31+rAzqtX4VTdGFfbD3YZLH88IwI73ckGK/aZ+qq8XxSTVBI/Pjhu
 SEt8p0g/mFuf5HmayG3coHjKMqkZ+jUmnNJxGx1SL90XR+arllL83Wn0i1TYWUtb3PUcifllfx+
 BJ51mRCXul63cvve1kvbffFpKvIYzXMAG7vRxrccIwWnmxE1qrvB9YlR02wWt8icRN1dD+MEI5u
 /xAyZ3nh+OgSG7FMRD0jnBk+/gmyTyLsQ+xPoh8q6wUZX6CKHTogHy4Bj69ERVib1iiTUnlChf3
 y4qgsd+DD02ipL/X+3LvYSKIC8PBGbwumCfucL5UpZdTbXOqbIeW1bL8R9ES4F4saUOK2102RWT
 pWDgh8mOwmMocPr6TnfPd5G6L6mrNpZYShAGxIMHkizqgOy2z6rn3NBjxP+n0TG4fDNLZJoonlI
 s9vBsTfUwjV47pQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565683; x=1785170483; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D3AlHdiYSL6VJWWkYTDBsECcn24qaXE5oBvz5keOQWQ=;
 b=bTJebHl+El7rBd1mnHkqYBQN/ufYug9wzEmJ9uOm0foOmhNH5fWyQeyfe1vlm6H4ec
 GRGdxVtDs4HD8nXAa6xPOsPZreuXaNAqmbz2mLqCVadtMWmhcfCDYmtAnMP4ld9Kf5DZ
 gh7fVvaZUX8NXXltf7eJYk/Nlu3eSNAsPks0eOUYHGs7yIJfacMH4d8K4p72nDkmik/c
 ECfrtUcQ+jAENKPxG6he8lYYgzs2B/uR/Ta9sItX3Et6NIHwI8gBRrLEH2myDYcNZb+N
 ieMxwIHwM6oz4m/pQDzFrMpPOl5XdcVbxLGeSGwDh1JuO6gPnNCIxS9BXXESCEg9Jgmv
 kk/w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=bTJebHl+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="bTJebHl+"; 
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

With CCF the implementation of functions like clk_get_* and
clk_set_defaults() changes. Introduce support for calling the CCF
implementations when it is enabled. When disabled this dead code will be
compiled out.

Additionally, adjust the Makefile so that we no longer build
clk-uclass.c when CCF is enabled. This removes all the conflicting
implementations of clk_enable() and friends as well as ensuring that
we don't even try and probe any UCLASS_CLK drivers as they are not
supported.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/Makefile     |  2 +-
 drivers/clk/clk-common.c | 61 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ee06bffaef72..4bec2e4c61a8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -3,9 +3,8 @@
 # Copyright (c) 2015 Google, Inc
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 #
 
-obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
 obj-$(CONFIG_$(PHASE_)CLK) += clk-common.o
 obj-$(CONFIG_$(PHASE_)CLK_GPIO) += clk-gpio.o
 obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
 
@@ -15,8 +14,9 @@ obj-y += ccf/
 else
 # U-Boot basic fixed clocks, full CCF has a
 # different and incompatible implementation
 obj-y += basic/
+obj-$(CONFIG_$(PHASE_)CLK) += clk-uclass.o
 # U-Boot/IMX "micro" CCF port
 obj-$(CONFIG_$(PHASE_)CLK_CCF) += uccf/
 endif
 
diff --git a/drivers/clk/clk-common.c b/drivers/clk/clk-common.c
index 7f30ad496da2..a24878d7302e 100644
--- a/drivers/clk/clk-common.c
+++ b/drivers/clk/clk-common.c
@@ -22,8 +22,10 @@
 #include <linux/bug.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 
+#include <linux/clk/clk-conf.h>
+#include "ccf/clk.h"
 #include "clk-common.h"
 
 #if CONFIG_IS_ENABLED(OF_REAL)
 int clk_get_by_index(struct udevice *dev, int index, struct clk *clk)
@@ -32,16 +34,23 @@ int clk_get_by_index(struct udevice *dev, int index, struct clk *clk)
 }
 
 int clk_get_by_index_nodev(ofnode node, int index, struct clk *clk)
 {
-	struct ofnode_phandle_args args;
-	int ret;
+	if (CONFIG_IS_ENABLED(CLK_CCF_FULL)) {
+		struct clk_hw *hw;
 
-	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
-					     index, &args);
+		hw = of_clk_get_hw(node, index, NULL);
+		return clk_hw_create_clk_uboot(clk, hw);
+	} else {
+		struct ofnode_phandle_args args;
+		int ret;
 
-	return clk_get_by_index_tail(ret, node, &args, "clocks",
-				     index, clk);
+		ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
+						index, &args);
+
+		return clk_get_by_index_tail(ret, node, &args, "clocks",
+					index, clk);
+	}
 }
 
 int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 {
@@ -77,9 +86,18 @@ bulk_get_err:
 }
 
 int clk_get_by_name(struct udevice *dev, const char *name, struct clk *clk)
 {
-	return clk_get_by_name_nodev(dev_ofnode(dev), name, clk);
+	if (CONFIG_IS_ENABLED(CLK_CCF_FULL)) {
+		struct clk_hw *hw;
+
+		hw = of_clk_get_hw(dev_ofnode(dev), 0, name);
+		if (IS_ERR(hw))
+			return -ENOENT;
+		return clk_hw_create_clk_uboot(clk, hw);
+	} else {
+		return clk_get_by_name_nodev(dev_ofnode(dev), name, clk);
+	}
 }
 #endif /* OF_REAL */
 
 int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
@@ -139,15 +157,19 @@ int clk_set_defaults(struct udevice *dev, enum clk_defaults_stage stage)
 			return 0;
 
 	debug("%s(%s)\n", __func__, dev_read_name(dev));
 
-	ret = clk_set_default_parents(dev, stage);
-	if (ret)
-		return ret;
+	if (CONFIG_IS_ENABLED(CLK_CCF_FULL)) {
+		return of_clk_set_defaults(dev_ofnode(dev), false);
+	} else {
+		ret = clk_set_default_parents(dev, stage);
+		if (ret)
+			return ret;
 
-	ret = clk_set_default_rates(dev, stage);
-	if (ret < 0)
-		return ret;
+		ret = clk_set_default_rates(dev, stage);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
 
@@ -217,4 +239,17 @@ int clk_disable_bulk(struct clk_bulk *bulk)
 	}
 
 	return 0;
 }
+
+#if CONFIG_IS_ENABLED(CLK_CCF_FULL)
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
+#endif

-- 
2.55.0

