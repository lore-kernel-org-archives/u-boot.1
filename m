Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AADC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B08904053C;
	Mon, 20 Jul 2026 18:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x533b0ejBsqV; Mon, 20 Jul 2026 18:09:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2ED9406CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570997;
	bh=4E6G8lXEoLYGAWEizsnhrgP2R5ghspqbOjQF5UCDRq8=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fRN3aAfsZaYyY3/NPWtsgiNSGZUiJTQre4VZ1pkXsEvwD171aP1GcLTnhhXgflSBU
	 Gc/lJJgmfzdewjzyQyZyw9sPOts4IwICGG9eidrjfw8G48de6KJGGS8htreMBvEx6N
	 6XPj/futd6r8tiDgqUJFfM9of+53dekrVOLBbZ+LKKE7G/XSx1i/OuQYC548V7jLmu
	 lfU0RiMItauFpFX5ScCa3D9G/0X8aHLuiQupXccAM2oicsV6By5rdI1k+57/TkWnDx
	 Hq0yRJ5dzFFieDwW9TtkTDAL06gIi5s2Gm5C5e0K4DtdxljuuqPK4EzVbDcL4A1PV2
	 1OnsDxnSj9riw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2ED9406CD;
	Mon, 20 Jul 2026 18:09:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBAA81DF4
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B773C60716
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLAbaa2tlkUh for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 908B0606F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 908B0606F5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 908B0606F5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7F5849EB; Mon, 20 Jul 2026 18:41:22 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C22D848BA
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:19 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso7398355e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565679; x=1785170479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4E6G8lXEoLYGAWEizsnhrgP2R5ghspqbOjQF5UCDRq8=;
 b=cQybxK8vgnlhhFNF+BDhY8T+EgzlxowdXkI4hUpK8SL01O2pL6rdwBKRkep+SrgDGR
 OqJlXoedBdrGOWwx0JL7Q6Auw9FYHF+XBVI2hjg5aRc7wa4aY8LP87Z7UqTj3/ZE6gu7
 +nJJ/IUHAvSZSmRMUEyNiuVrPPvJlxslKvVxpF7C5QEEpRZj9v8E4mTFd+10vHmgvxBx
 L7EDV1l/9ORvBhUr3c4RCCZt4N3OwOM6zg2zIVZwRrW2kGisG90UWn9TMbTWdVEGdNLw
 4oneG/PyQPGbp46dqWZnzHyyfq1ikK/ny2g9VwrTsBThb59iHlHY5W5qjr4AOKPPBnIa
 0mDg==
X-Gm-Message-State: AOJu0YxEUM/LB47Twyr7IxgrJfx0oXetOQemLco5BYyKVbzJOhC+WiXh
 PURx0DflsF1/EPJ2iNrgY7SyBftWJFYLrzu4w2+nFJAWnwenc4/tPASn32cebc40wwk=
X-Gm-Gg: AfdE7cm/SQCZOmbFUvDxGyrHx/2pBd/9ah7WMguml7psLEXV5mI5jyYVdF9M7deydwn
 5+OSuLLWL2Y7t4PdU9FYFMMaYQngsmAkOQOY8SNsrCINmxJ5IVY38sbfg5wK63UTpQfoHnIKYEn
 snH9nN4GWOHlead4fhHsfct9HeOZRGWr/+Dp3oa8iC+rG0ahwbWNZl9QzWLQb+u8zZsDmTZEexi
 Ohh1ynV3gKBATWd3DYlLD9xlT/EdC3kpMC4+H8UI3ObZ11KY/uON9+rAxG75p7yFsMFpfxVdsdH
 N+R3bhxKPYKPbT1cQ535MF96PTcEupNhEZpEEOCJbCWM8XAyvP9UO5hdVrUZTJ72UZK4BX3rzN/
 RdLzKirnW6GsQTqbsjDaLGAdmr8kSqSc8OkklD4tdpy78qwRLtyOAz+Pwtp6mzabipZN9gfw7vG
 Etlj2h0U+cbZFDqN1cbLIcOUnE5VAYlg==
X-Received: by 2002:a05:600c:1d18:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4954aa1a264mr167090935e9.9.1784565678576; 
 Mon, 20 Jul 2026 09:41:18 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:39 +0100
Subject: [PATCH 12/36] clk/ccf: adapt CCF generic clocks for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-12-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=34475;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=hwo+DWF0R8FJ8571mPzVzSdaNQNcfpgDAfdVeWylaik=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+Dm2izY+jkb6caVuhKSHDzCEJQzmEcHOj1x
 fUyUoXlihyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tvrMD/42mLigQnwPAk5ceWObyfkySO5cJAxtc9nsmoaOlGchDRcAsTERQCfxerEgioCtHH/rhdp
 nxhXxgQW9lBoojW+hHzzdLfcmQ193pcj9KpLDrhWHGOcrEGitm26LjnwLT27QCTUPMfc+Y4aBQH
 JDQ5LlhJyoCftYeu+OlQvRSZHALqdlBvoZ2URXbsK2SeMyiPnAGpSkCLhmuHYRTP170HKMu76pq
 iriZovK52sIE35tB1jxkMYy1ih5WZVcsrUrLw/IFnWW/c1HCs8C1Ygw9+SH0NBQQuxC56j7BqYm
 miZKAO7RrhxUuEIGkUkDIo4eSEMme35HzUHTBQ2ic8DUqTGnYoJWteBEF1iYrlmW814LPuuboXX
 yVXmU/+/gwdxtc4FmozKQ/c0N03hbvxPitP0cP5jN6ooGZwRHP8SVOQklc5do9f7FjnFthg4Srz
 G8KPC9GuaN6THfd4oq1YqE3CLlrXW1pGu8FT4yajSVzga5b26hRz9Rgms5koOdfsoU3D9ETx3Xp
 +zaeao6CZLXdCmL5HJVGme/33KmMdiCHRntYrVcRObm/5z0nBIX2yiHARGyHqW2JnHFPOXCKe94
 IcZHnM8jV+P+g+UTF/uggDmoYzGcdFMwFKOcIJEECzuKb6AlAS87aaF0bYxQF5KmhOt3F7TPNnT
 jojkaG4A3Y2QOjw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565679; x=1785170479; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4E6G8lXEoLYGAWEizsnhrgP2R5ghspqbOjQF5UCDRq8=;
 b=WZA2TpDCo3PTG+22KpNeRhpgW6FlT6+2JAn3RwVFanEUDOWZUGqQG2dWAQlQbs0EBz
 oBj2MLbpbBHZbSEd5AjV4+b9NMWphKHEY5gB64XampgVsfWvbzZPVUh7GaQk7T71Nn2O
 y5bmWk3ikrlhwqLwkQOnQUNv/nTaGKojlWihAD+tOlASWQklDTXSc2Bs0HbDH8kQLy59
 3V4nc4dRfWmxRh9awM0lyOf/VI09NTtWvBNb4kW667TcRP1jpa5dvAWDbH8/6xHTHm40
 3eNNM2xK9yIplHsKYDURb3jUOpbCkyMsWZI9rMuaA/d6CoSrSqlsW6C0m8LB2shawfEN
 kIUA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=WZA2TpDC
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="WZA2TpDC"; 
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

Adjusted the generic clock drivers so that they build and work in
U-Boot. These changes are fairly minimal, big endian support is dropped
as it's unused anyway, and a small hack is added for sandbox tests which
can't use readl/writel.

The unused spinlock is removed from most function prototypes.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/clk-composite.c    |  21 +++---
 drivers/clk/ccf/clk-divider.c      |  45 +++++--------
 drivers/clk/ccf/clk-fixed-factor.c | 129 ++++++++++++++++---------------------
 drivers/clk/ccf/clk-fixed-rate.c   |  93 +++++++++++---------------
 drivers/clk/ccf/clk-gate.c         |  39 +++++------
 drivers/clk/ccf/clk-mux.c          |  31 ++++-----
 6 files changed, 156 insertions(+), 202 deletions(-)

diff --git a/drivers/clk/ccf/clk-composite.c b/drivers/clk/ccf/clk-composite.c
index 66759fe28fad..90d8a18f8ce0 100644
--- a/drivers/clk/ccf/clk-composite.c
+++ b/drivers/clk/ccf/clk-composite.c
@@ -2,12 +2,15 @@
 /*
  * Copyright (c) 2013 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <dm/device.h>
+#include <dm/devres.h>
+#include <linux/bug.h>
+#include <linux/compat.h>
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/slab.h>
 
 static u8 clk_composite_get_parent(struct clk_hw *hw)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
@@ -233,9 +236,9 @@ static void clk_composite_disable(struct clk_hw *hw)
 
 	gate_ops->disable(gate_hw);
 }
 
-static struct clk_hw *__clk_hw_register_composite(struct device *dev,
+static struct clk_hw *__clk_hw_register_composite(struct udevice *dev,
 			const char *name, const char * const *parent_names,
 			const struct clk_parent_data *pdata, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
@@ -350,9 +353,9 @@ err:
 	kfree(composite);
 	return hw;
 }
 
-struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
+struct clk_hw *clk_hw_register_composite(struct udevice *dev, const char *name,
 			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
@@ -364,9 +367,9 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 					   gate_ops, flags);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_composite);
 
-struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
+struct clk_hw *clk_hw_register_composite_pdata(struct udevice *dev,
 			const char *name,
 			const struct clk_parent_data *parent_data,
 			int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
@@ -379,9 +382,9 @@ struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
 					   rate_hw, rate_ops, gate_hw,
 					   gate_ops, flags);
 }
 
-struct clk *clk_register_composite(struct device *dev, const char *name,
+struct clk *clk_register_composite(struct udevice *dev, const char *name,
 			const char * const *parent_names, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
@@ -397,9 +400,9 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_composite);
 
-struct clk *clk_register_composite_pdata(struct device *dev, const char *name,
+struct clk *clk_register_composite_pdata(struct udevice *dev, const char *name,
 			const struct clk_parent_data *parent_data,
 			int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
@@ -441,14 +444,14 @@ void clk_hw_unregister_composite(struct clk_hw *hw)
 	kfree(composite);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_composite);
 
-static void devm_clk_hw_release_composite(struct device *dev, void *res)
+static void devm_clk_hw_release_composite(struct udevice *dev, void *res)
 {
 	clk_hw_unregister_composite(*(struct clk_hw **)res);
 }
 
-static struct clk_hw *__devm_clk_hw_register_composite(struct device *dev,
+static struct clk_hw *__devm_clk_hw_register_composite(struct udevice *dev,
 			const char *name, const char * const *parent_names,
 			const struct clk_parent_data *pdata, int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
 			struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
@@ -475,9 +478,9 @@ static struct clk_hw *__devm_clk_hw_register_composite(struct device *dev,
 
 	return hw;
 }
 
-struct clk_hw *devm_clk_hw_register_composite_pdata(struct device *dev,
+struct clk_hw *devm_clk_hw_register_composite_pdata(struct udevice *dev,
 			const char *name,
 			const struct clk_parent_data *parent_data,
 			int num_parents,
 			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
diff --git a/drivers/clk/ccf/clk-divider.c b/drivers/clk/ccf/clk-divider.c
index 2601b6155afb..111b025fbd45 100644
--- a/drivers/clk/ccf/clk-divider.c
+++ b/drivers/clk/ccf/clk-divider.c
@@ -6,12 +6,15 @@
  *
  * Adjustable divider clock implementation
  */
 
+#include <dm/device.h>
+#include <div64.h>
+#include <linux/bug.h>
 #include <linux/clk-provider.h>
+#include <dm/devres.h>
 #include <linux/device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/log2.h>
@@ -27,20 +30,18 @@
  */
 
 static inline u32 clk_div_readl(struct clk_divider *divider)
 {
-	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
-		return ioread32be(divider->reg);
-
+#if CONFIG_IS_ENABLED(SANDBOX)
+	return *(u32 *)divider->reg;
+#else
 	return readl(divider->reg);
+#endif
 }
 
 static inline void clk_div_writel(struct clk_divider *divider, u32 val)
 {
-	if (divider->flags & CLK_DIVIDER_BIG_ENDIAN)
-		iowrite32be(val, divider->reg);
-	else
-		writel(val, divider->reg);
+	writel(val, divider->reg);
 }
 
 static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
 				      u8 width)
@@ -473,21 +474,15 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
 	int value;
-	unsigned long flags = 0;
 	u32 val;
 
 	value = divider_get_val(rate, parent_rate, divider->table,
 				divider->width, divider->flags);
 	if (value < 0)
 		return value;
 
-	if (divider->lock)
-		spin_lock_irqsave(divider->lock, flags);
-	else
-		__acquire(divider->lock);
-
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = clk_div_mask(divider->width) << (divider->shift + 16);
 	} else {
 		val = clk_div_readl(divider);
@@ -495,13 +490,8 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 	val |= (u32)value << divider->shift;
 	clk_div_writel(divider, val);
 
-	if (divider->lock)
-		spin_unlock_irqrestore(divider->lock, flags);
-	else
-		__release(divider->lock);
-
 	return 0;
 }
 
 const struct clk_ops clk_divider_ops = {
@@ -516,10 +506,10 @@ const struct clk_ops clk_divider_ro_ops = {
 	.determine_rate = clk_divider_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 
-struct clk_hw *__clk_hw_register_divider(struct device *dev,
-		struct device_node *np, const char *name,
+struct clk_hw *__clk_hw_register_divider(struct udevice *dev,
+		ofnode np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		unsigned long clk_divider_flags,
@@ -560,9 +550,8 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 	div->reg = reg;
 	div->shift = shift;
 	div->width = width;
 	div->flags = clk_divider_flags;
-	div->lock = lock;
 	div->hw.init = &init;
 	div->table = table;
 
 	/* register the clock */
@@ -590,17 +579,17 @@ EXPORT_SYMBOL_GPL(__clk_hw_register_divider);
  * @clk_divider_flags: divider-specific flags for this clock
  * @table: array of divider/value pairs ending with a div set to 0
  * @lock: shared register lock for this clock
  */
-struct clk *clk_register_divider_table(struct device *dev, const char *name,
+struct clk *clk_register_divider_table(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		unsigned long clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
-	hw =  __clk_hw_register_divider(dev, NULL, name, parent_name, NULL,
+	hw =  __clk_hw_register_divider(dev, dev_ofnode(dev), name, parent_name, NULL,
 			NULL, flags, reg, shift, width, clk_divider_flags,
 			table, lock);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
@@ -638,15 +627,15 @@ void clk_hw_unregister_divider(struct clk_hw *hw)
 	kfree(div);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_divider);
 
-static void devm_clk_hw_release_divider(struct device *dev, void *res)
+static void devm_clk_hw_release_divider(struct udevice *dev, void *res)
 {
 	clk_hw_unregister_divider(*(struct clk_hw **)res);
 }
 
-struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
-		struct device_node *np, const char *name,
+struct clk_hw *__devm_clk_hw_register_divider(struct udevice *dev,
+		ofnode np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
 		unsigned long clk_divider_flags,
diff --git a/drivers/clk/ccf/clk-fixed-factor.c b/drivers/clk/ccf/clk-fixed-factor.c
index de658c9e4c53..14ddeea348e7 100644
--- a/drivers/clk/ccf/clk-fixed-factor.c
+++ b/drivers/clk/ccf/clk-fixed-factor.c
@@ -1,14 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  */
-#include <linux/module.h>
+
+#include <dm/ofnode.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+#include <dm/devres.h>
+#include <div64.h>
+#include <linux/compat.h>
 #include <linux/clk-provider.h>
-#include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
+
+#include "clk.h"
 
 /*
  * DOC: basic fixed multiplier and divider clock that cannot gate
  *
@@ -77,9 +82,9 @@ const struct clk_ops clk_fixed_factor_ops = {
 	.recalc_accuracy = clk_factor_recalc_accuracy,
 };
 EXPORT_SYMBOL_GPL(clk_fixed_factor_ops);
 
-static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *res)
+static void devm_clk_hw_register_fixed_factor_release(struct udevice *dev, void *res)
 {
 	struct clk_fixed_factor *fix = res;
 
 	/*
@@ -90,9 +95,9 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
 	clk_hw_unregister(&fix->hw);
 }
 
 static struct clk_hw *
-__clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
+__clk_hw_register_fixed_factor(struct udevice *dev, ofnode np,
 		const char *name, const char *parent_name,
 		const struct clk_hw *parent_hw, const struct clk_parent_data *pdata,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		unsigned long acc, unsigned int fixflags, bool devm)
@@ -161,15 +166,15 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
  *
  * Return: Pointer to fixed factor clk_hw structure that was registered or
  * an error pointer.
  */
-struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
+struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct udevice *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = index };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, &pdata,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, NULL, NULL, &pdata,
 					      flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
 
@@ -185,43 +190,43 @@ EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
  *
  * Return: Pointer to fixed factor clk_hw structure that was registered or
  * an error pointer.
  */
-struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct udevice *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1 };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, NULL, parent_hw,
 					      &pdata, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
 
-struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct udevice *dev,
 		const char *name, const struct clk_hw *parent_hw,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1 };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, NULL, parent_hw,
 					      &pdata, flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
 
-struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
+struct clk_hw *clk_hw_register_fixed_factor(struct udevice *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1 };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, parent_name, NULL,
 					      &pdata, flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
 
-struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
-		struct device_node *np, const char *name, const char *fw_name,
+struct clk_hw *clk_hw_register_fixed_factor_fwname(struct udevice *dev,
+		ofnode np, const char *name, const char *fw_name,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
 
@@ -229,10 +234,10 @@ struct clk_hw *clk_hw_register_fixed_factor_fwname(struct device *dev,
 			&pdata, flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_fwname);
 
-struct clk_hw *clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
-		struct device_node *np, const char *name, const char *fw_name,
+struct clk_hw *clk_hw_register_fixed_factor_with_accuracy_fwname(struct udevice *dev,
+		ofnode np, const char *name, const char *fw_name,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		unsigned long acc)
 {
 	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
@@ -242,20 +247,20 @@ struct clk_hw *clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *
 			CLK_FIXED_FACTOR_FIXED_ACCURACY, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_with_accuracy_fwname);
 
-struct clk_hw *clk_hw_register_fixed_factor_index(struct device *dev,
+struct clk_hw *clk_hw_register_fixed_factor_index(struct udevice *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = index };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, &pdata,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, NULL, NULL, &pdata,
 					      flags, mult, div, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_index);
 
-struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
+struct clk *clk_register_fixed_factor(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	struct clk_hw *hw;
@@ -291,21 +296,21 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw)
 	kfree(fix);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_factor);
 
-struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
+struct clk_hw *devm_clk_hw_register_fixed_factor(struct udevice *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1 };
 
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL,
+	return __clk_hw_register_fixed_factor(dev, dev_ofnode(dev), name, parent_name, NULL,
 			&pdata, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
-struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
-		struct device_node *np, const char *name, const char *fw_name,
+struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct udevice *dev,
+		ofnode np, const char *name, const char *fw_name,
 		unsigned long flags, unsigned int mult, unsigned int div)
 {
 	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
 
@@ -313,10 +318,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_fwname(struct device *dev,
 			&pdata, flags, mult, div, 0, 0, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_fwname);
 
-struct clk_hw *devm_clk_hw_register_fixed_factor_with_accuracy_fwname(struct device *dev,
-		struct device_node *np, const char *name, const char *fw_name,
+struct clk_hw *devm_clk_hw_register_fixed_factor_with_accuracy_fwname(struct udevice *dev,
+		ofnode np, const char *name, const char *fw_name,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		unsigned long acc)
 {
 	const struct clk_parent_data pdata = { .index = -1, .fw_name = fw_name };
@@ -325,40 +330,40 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_with_accuracy_fwname(struct dev
 			&pdata, flags, mult, div, acc,
 			CLK_FIXED_FACTOR_FIXED_ACCURACY, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_with_accuracy_fwname);
-
-#ifdef CONFIG_OF
-static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
+static struct clk_hw *_of_fixed_factor_clk_setup(struct udevice *dev)
 {
 	struct clk_hw *hw;
-	const char *clk_name = node->name;
+	const char *clk_name;
+	ofnode node = dev_ofnode(dev);
 	const struct clk_parent_data pdata = { .index = 0 };
 	u32 div, mult;
 	int ret;
 
-	if (of_property_read_u32(node, "clock-div", &div)) {
+	if (ofnode_read_u32(node, "clock-div", &div)) {
 		pr_err("%s Fixed factor clock <%pOFn> must have a clock-div property\n",
-			__func__, node);
+			__func__, &node);
 		return ERR_PTR(-EIO);
 	}
 
-	if (of_property_read_u32(node, "clock-mult", &mult)) {
+	if (ofnode_read_u32(node, "clock-mult", &mult)) {
 		pr_err("%s Fixed factor clock <%pOFn> must have a clock-mult property\n",
-			__func__, node);
+			__func__, &node);
 		return ERR_PTR(-EIO);
 	}
 
-	of_property_read_string(node, "clock-output-names", &clk_name);
+	clk_name = ofnode_read_string(node, "clock-output-names");
+	if (!clk_name)
+		clk_name = ofnode_get_name(node);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL,
+	hw = __clk_hw_register_fixed_factor(dev, node, clk_name, NULL, NULL,
 					    &pdata, 0, mult, div, 0, 0, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
 		 * attempted again from probe function.
 		 */
-		of_node_clear_flag(node, OF_POPULATED);
 		return ERR_CAST(hw);
 	}
 
 	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
@@ -369,56 +374,36 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	return hw;
 }
 
-/**
- * of_fixed_factor_clk_setup() - Setup function for simple fixed factor clock
- * @node:	device node for the clock
- */
-void __init of_fixed_factor_clk_setup(struct device_node *node)
-{
-	_of_fixed_factor_clk_setup(node);
-}
-CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
-		of_fixed_factor_clk_setup);
-
-static void of_fixed_factor_clk_remove(struct platform_device *pdev)
-{
-	struct clk_hw *clk = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-	clk_hw_unregister_fixed_factor(clk);
-}
-
-static int of_fixed_factor_clk_probe(struct platform_device *pdev)
+static int of_fixed_factor_clk_probe(struct udevice *dev)
 {
 	struct clk_hw *clk;
 
 	/*
 	 * This function is not executed when of_fixed_factor_clk_setup
 	 * succeeded.
 	 */
-	clk = _of_fixed_factor_clk_setup(pdev->dev.of_node);
-	if (IS_ERR(clk))
+	clk = _of_fixed_factor_clk_setup(dev);
+	if (IS_ERR(clk)) {
+		printf("%s: %s: err %ld\n", __func__, dev->name, PTR_ERR(clk));
 		return PTR_ERR(clk);
+	}
 
-	platform_set_drvdata(pdev, clk);
+	dev_set_priv(dev, clk);
 
 	return 0;
 }
 
-static const struct of_device_id of_fixed_factor_clk_ids[] = {
-	{ .compatible = "fixed-factor-clock" },
+static const struct udevice_id clk_fixed_factor_match_table[] = {
+	{
+		.compatible = "fixed-factor-clock",
+	},
 	{ }
 };
-MODULE_DEVICE_TABLE(of, of_fixed_factor_clk_ids);
 
-static struct platform_driver of_fixed_factor_clk_driver = {
-	.driver = {
-		.name = "of_fixed_factor_clk",
-		.of_match_table = of_fixed_factor_clk_ids,
-	},
+U_BOOT_DRIVER(clk_fixed_factor) = {
+	.name	= "clk-fixed-factor",
+	.id	= UCLASS_NOP,
 	.probe = of_fixed_factor_clk_probe,
-	.remove = of_fixed_factor_clk_remove,
+	.of_match = clk_fixed_factor_match_table,
 };
-builtin_platform_driver(of_fixed_factor_clk_driver);
-#endif
diff --git a/drivers/clk/ccf/clk-fixed-rate.c b/drivers/clk/ccf/clk-fixed-rate.c
index 6b4f76b9c4da..da1f3d22e1ca 100644
--- a/drivers/clk/ccf/clk-fixed-rate.c
+++ b/drivers/clk/ccf/clk-fixed-rate.c
@@ -6,14 +6,16 @@
  * Fixed rate clock implementation
  */
 
 #include <linux/clk-provider.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <dm.h>
+#include <dm/devres.h>
+#include <log.h>
+#include <dm/device-internal.h>
 #include <linux/io.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
+
+#include "clk.h"
 
 /*
  * DOC: basic fixed-rate clock that cannot gate
  *
@@ -48,9 +50,9 @@ const struct clk_ops clk_fixed_rate_ops = {
 	.recalc_accuracy = clk_fixed_rate_recalc_accuracy,
 };
 EXPORT_SYMBOL_GPL(clk_fixed_rate_ops);
 
-static void devm_clk_hw_register_fixed_rate_release(struct device *dev, void *res)
+static void devm_clk_hw_register_fixed_rate_release(struct udevice *dev, void *res)
 {
 	struct clk_fixed_rate *fix = res;
 
 	/*
@@ -60,10 +62,10 @@ static void devm_clk_hw_register_fixed_rate_release(struct device *dev, void *re
 	 */
 	clk_hw_unregister(&fix->hw);
 }
 
-struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
-		struct device_node *np, const char *name,
+struct clk_hw *__clk_hw_register_fixed_rate(struct udevice *dev,
+		ofnode np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
 		unsigned long fixed_rate, unsigned long fixed_accuracy,
 		unsigned long clk_fixed_flags, bool devm)
@@ -100,9 +102,9 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 	fixed->hw.init = &init;
 
 	/* register the clock */
 	hw = &fixed->hw;
-	if (dev || !np)
+	if (dev || !ofnode_valid(np))
 		ret = clk_hw_register(dev, hw);
 	else
 		ret = of_clk_hw_register(np, hw);
 	if (ret) {
@@ -117,9 +119,9 @@ struct clk_hw *__clk_hw_register_fixed_rate(struct device *dev,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(__clk_hw_register_fixed_rate);
 
-struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
+struct clk *clk_register_fixed_rate(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
 {
 	struct clk_hw *hw;
@@ -155,25 +157,27 @@ void clk_hw_unregister_fixed_rate(struct clk_hw *hw)
 	kfree(fixed);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_rate);
 
-#ifdef CONFIG_OF
-static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
+static struct clk_hw *_of_fixed_clk_setup(struct udevice *dev)
 {
 	struct clk_hw *hw;
-	const char *clk_name = node->name;
+	ofnode node = dev_ofnode(dev);
+	const char *clk_name;
 	u32 rate;
 	u32 accuracy = 0;
 	int ret;
 
-	if (of_property_read_u32(node, "clock-frequency", &rate))
+	if (ofnode_read_u32(node, "clock-frequency", &rate))
 		return ERR_PTR(-EIO);
 
-	of_property_read_u32(node, "clock-accuracy", &accuracy);
+	ofnode_read_u32(node, "clock-accuracy", &accuracy);
 
-	of_property_read_string(node, "clock-output-names", &clk_name);
+	clk_name = ofnode_read_string(node, "clock-output-names");
+	if (!clk_name)
+		clk_name = ofnode_get_name(node);
 
-	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+	hw = clk_hw_register_fixed_rate_with_accuracy(dev, clk_name, NULL,
 						    0, rate, accuracy);
 	if (IS_ERR(hw))
 		return hw;
 
@@ -185,54 +189,29 @@ static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
 
 	return hw;
 }
 
-/**
- * of_fixed_clk_setup() - Setup function for simple fixed rate clock
- * @node:	device node for the clock
- */
-void __init of_fixed_clk_setup(struct device_node *node)
+static int clk_fixed_rate_probe(struct udevice *dev)
 {
-	_of_fixed_clk_setup(node);
-}
-CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
+	struct clk_hw *hw = _of_fixed_clk_setup(dev);
 
-static void of_fixed_clk_remove(struct platform_device *pdev)
-{
-	struct clk_hw *hw = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-	clk_hw_unregister_fixed_rate(hw);
-}
-
-static int of_fixed_clk_probe(struct platform_device *pdev)
-{
-	struct clk_hw *hw;
-
-	/*
-	 * This function is not executed when of_fixed_clk_setup
-	 * succeeded.
-	 */
-	hw = _of_fixed_clk_setup(pdev->dev.of_node);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-
-	platform_set_drvdata(pdev, hw);
+	if (!IS_ERR_OR_NULL(hw))
+		dev_set_priv(dev, hw);
 
 	return 0;
 }
 
-static const struct of_device_id of_fixed_clk_ids[] = {
-	{ .compatible = "fixed-clock" },
-	{ }
+static const struct udevice_id clk_fixed_rate_match[] = {
+	{
+		.compatible = "fixed-clock",
+	},
+	{ /* sentinel */ }
 };
 
-static struct platform_driver of_fixed_clk_driver = {
-	.driver = {
-		.name = "of_fixed_clk",
-		.of_match_table = of_fixed_clk_ids,
-	},
-	.probe = of_fixed_clk_probe,
-	.remove = of_fixed_clk_remove,
+U_BOOT_DRIVER(fixed_clock) = {
+	.name = "fixed_clock",
+	.id = UCLASS_NOP,
+	.of_match = clk_fixed_rate_match,
+	.probe = clk_fixed_rate_probe,
+	.plat_auto	= sizeof(struct clk_fixed_rate),
+	.flags = DM_FLAG_PRE_RELOC,
 };
-builtin_platform_driver(of_fixed_clk_driver);
-#endif
diff --git a/drivers/clk/ccf/clk-gate.c b/drivers/clk/ccf/clk-gate.c
index 4746f8219132..ec4bc6ca4724 100644
--- a/drivers/clk/ccf/clk-gate.c
+++ b/drivers/clk/ccf/clk-gate.c
@@ -5,12 +5,11 @@
  *
  * Gated clock implementation
  */
 
+#include <dm/devres.h>
 #include <linux/clk-provider.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/string.h>
 
@@ -25,20 +24,22 @@
  */
 
 static inline u32 clk_gate_readl(struct clk_gate *gate)
 {
-	if (gate->flags & CLK_GATE_BIG_ENDIAN)
-		return ioread32be(gate->reg);
-
+#if CONFIG_IS_ENABLED(SANDBOX)
+	return *(u32 *)gate->reg;
+#else
 	return readl(gate->reg);
+#endif
 }
 
 static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
 {
-	if (gate->flags & CLK_GATE_BIG_ENDIAN)
-		iowrite32be(val, gate->reg);
-	else
-		writel(val, gate->reg);
+#if IS_ENABLED(CONFIG_SANDBOX_CLK_CCF)
+	*(u32 *)gate->reg = val;
+#else
+	writel(val, gate->reg);
+#endif
 }
 
 /*
  * It works on following logic:
@@ -123,10 +124,10 @@ const struct clk_ops clk_gate_ops = {
 	.is_enabled = clk_gate_is_enabled,
 };
 EXPORT_SYMBOL_GPL(clk_gate_ops);
 
-struct clk_hw *__clk_hw_register_gate(struct device *dev,
-		struct device_node *np, const char *name,
+struct clk_hw *__clk_hw_register_gate(struct udevice *dev,
+		ofnode np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
@@ -167,11 +168,11 @@ struct clk_hw *__clk_hw_register_gate(struct device *dev,
 	gate->lock = lock;
 	gate->hw.init = &init;
 
 	hw = &gate->hw;
-	if (dev || !np)
+	if (dev || !ofnode_valid(np))
 		ret = clk_hw_register(dev, hw);
-	else if (np)
+	else if (ofnode_valid(np))
 		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(gate);
 		hw = ERR_PTR(ret);
@@ -181,17 +182,17 @@ struct clk_hw *__clk_hw_register_gate(struct device *dev,
 
 }
 EXPORT_SYMBOL_GPL(__clk_hw_register_gate);
 
-struct clk *clk_register_gate(struct device *dev, const char *name,
+struct clk *clk_register_gate(struct udevice *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
 		u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
 	hw = clk_hw_register_gate(dev, name, parent_name, flags, reg,
-				  bit_idx, clk_gate_flags, lock);
+				  bit_idx, clk_gate_flags);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 	return hw->clk;
 }
@@ -223,15 +224,15 @@ void clk_hw_unregister_gate(struct clk_hw *hw)
 	kfree(gate);
 }
 EXPORT_SYMBOL_GPL(clk_hw_unregister_gate);
 
-static void devm_clk_hw_release_gate(struct device *dev, void *res)
+static void devm_clk_hw_release_gate(struct udevice *dev, void *res)
 {
 	clk_hw_unregister_gate(*(struct clk_hw **)res);
 }
 
-struct clk_hw *__devm_clk_hw_register_gate(struct device *dev,
-		struct device_node *np, const char *name,
+struct clk_hw *__devm_clk_hw_register_gate(struct udevice *dev,
+		ofnode np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data,
 		unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
diff --git a/drivers/clk/ccf/clk-mux.c b/drivers/clk/ccf/clk-mux.c
index fa817c317c2a..2d84d389a3a1 100644
--- a/drivers/clk/ccf/clk-mux.c
+++ b/drivers/clk/ccf/clk-mux.c
@@ -6,12 +6,11 @@
  *
  * Simple multiplexer clock implementation
  */
 
+#include <dm/devres.h>
 #include <linux/clk-provider.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/io.h>
 #include <linux/err.h>
 
 /*
@@ -25,20 +24,18 @@
  */
 
 static inline u32 clk_mux_readl(struct clk_mux *mux)
 {
-	if (mux->flags & CLK_MUX_BIG_ENDIAN)
-		return ioread32be(mux->reg);
-
+#if CONFIG_IS_ENABLED(SANDBOX)
+	return *(u32 *)mux->reg;
+#else
 	return readl(mux->reg);
+#endif
 }
 
 static inline void clk_mux_writel(struct clk_mux *mux, u32 val)
 {
-	if (mux->flags & CLK_MUX_BIG_ENDIAN)
-		iowrite32be(val, mux->reg);
-	else
-		writel(val, mux->reg);
+	writel(val, mux->reg);
 }
 
 int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned int flags,
 			 unsigned int val)
@@ -145,9 +142,9 @@ const struct clk_ops clk_mux_ro_ops = {
 	.get_parent = clk_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk_hw *__clk_hw_register_mux(struct device *dev, struct device_node *np,
+struct clk_hw *__clk_hw_register_mux(struct udevice *dev, ofnode np,
 		const char *name, u8 num_parents,
 		const char * const *parent_names,
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
@@ -193,11 +190,11 @@ struct clk_hw *__clk_hw_register_mux(struct device *dev, struct device_node *np,
 	mux->table = table;
 	mux->hw.init = &init;
 
 	hw = &mux->hw;
-	if (dev || !np)
+	if (dev || !ofnode_valid(np))
 		ret = clk_hw_register(dev, hw);
-	else if (np)
+	else if (ofnode_valid(np))
 		ret = of_clk_hw_register(np, hw);
 	if (ret) {
 		kfree(mux);
 		hw = ERR_PTR(ret);
@@ -206,14 +203,14 @@ struct clk_hw *__clk_hw_register_mux(struct device *dev, struct device_node *np,
 	return hw;
 }
 EXPORT_SYMBOL_GPL(__clk_hw_register_mux);
 
-static void devm_clk_hw_release_mux(struct device *dev, void *res)
+static void devm_clk_hw_release_mux(struct udevice *dev, void *res)
 {
 	clk_hw_unregister_mux(*(struct clk_hw **)res);
 }
 
-struct clk_hw *__devm_clk_hw_register_mux(struct device *dev, struct device_node *np,
+struct clk_hw *__devm_clk_hw_register_mux(struct udevice *dev, ofnode np,
 		const char *name, u8 num_parents,
 		const char * const *parent_names,
 		const struct clk_hw **parent_hws,
 		const struct clk_parent_data *parent_data,
@@ -240,18 +237,18 @@ struct clk_hw *__devm_clk_hw_register_mux(struct device *dev, struct device_node
 	return hw;
 }
 EXPORT_SYMBOL_GPL(__devm_clk_hw_register_mux);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk *clk_register_mux_table(struct udevice *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, const u32 *table, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
 	hw = clk_hw_register_mux_table(dev, name, parent_names,
 				       num_parents, flags, reg, shift, mask,
-				       clk_mux_flags, table, lock);
+				       clk_mux_flags, table);
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 	return hw->clk;
 }

-- 
2.55.0

