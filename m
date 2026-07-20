Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F02CC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8E1A406EC;
	Mon, 20 Jul 2026 18:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlcMWwZoDH2O; Mon, 20 Jul 2026 18:10:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA10C406E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571005;
	bh=qARKzzp+sMU4ZbSkbncwaYmd0Gf4tg4X5MM4xPGJtHU=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HuJ/q1PF24xflUszm9+8bFqKn8IaltICL2+q2rOS8uqtKBX7BNI7GBdonLs5KzZpF
	 Nag30WCbtokIK5YJNmguqRRoW8mAvLEenkhR2d9X+NyEgT8vAWUkUoNILo99Z9F6Yi
	 Aze1IQR1hWn8NQRNlp9XuPPGUJp6Otd3uYPxl2yyf9zfQbER3wlI5/BE/fJJREpRyP
	 cH3LgWohhtq5RsoQnRQvK76OaUmoT8xohsq8Z/avIWAxxDMDVHfNm1qnWNGsKEDI6U
	 K9f0WAk4O+yAf6cVgiPOSdWeu8RkYY6cTgDop0zUV77j6ZzEXD85EJpvTgiap6T6AW
	 zfeUGraMD4dow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA10C406E3;
	Mon, 20 Jul 2026 18:10:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 023DF132D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3A54606C6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yvjAVDRDCkOj for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C86F26060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C86F26060E
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C86F26060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD5F848A1; Mon, 20 Jul 2026 18:41:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260BF844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:40:59 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so20535165e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565658; x=1785170458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qARKzzp+sMU4ZbSkbncwaYmd0Gf4tg4X5MM4xPGJtHU=;
 b=qth0RX4aTqmSj1XQ0tHms+FGEpsGjIjtia6UVIlILH8YqsdWwHgoJz0TAtQV4GBskB
 JPVAVrnq+OlP7K7JZtjyG71FQjlBbbpgH1HQlhIACOjBHjI7sSrN1A9Dqyf9pFQt8lKc
 ZVwuccto2f0WgWATXHDK3OnG4bQRbN4T+0Ls4cVeQ1/AUaKiPusPiIb6/TfnV9I7WIW1
 l5vZsu1TKJF0pLMxVXSfj7H9bM8COyFiwDiT9ZQ98tAj9wvrk9zEocxjeHzoQbn91cgw
 iWTC6uvds63PKUbGWMNiugPs/IigaEvtzWfi1WU9Bbory8xdYRYTpHPPx8AYhe4oOwFa
 CE8w==
X-Gm-Message-State: AOJu0Ywo0U1/gf4/ndxDtTIDZj2yi6c0R0PNhlj8ro+1D6dmGPlo7+z8
 4mDuQO4oHfkstKlPEDrrnDV4RbW7a93Uv9cnie27a5yCwsfkaoiae2zsbAVSnIHgO0c=
X-Gm-Gg: AfdE7ckHKgAU8w1+7LimQbmWtwA9ry3tJvIrqP+OP3xCOK7rsUZBuWGDuBpSzKXzjs4
 qiFqk0PGiOtQLYckMW4uHqMV8FFM5jmfqW3SNOqcxYj8s9uPdt2doLogwV7zdbZ1eAEf0qtzkFx
 RTZcCXUrAi6WUlKOI+Y3yWbvbrfPnD87tN1EnQlvB9n9GoNkkqMOcy1XeBEYdlHpkQ2pDCG6FHC
 NVHGf1X3w750+xpz14OqC/TM2z0wxYbvBdtDGJGakjdMHo8lIqCzR9IoBOzNC8QSMOYI15SpUL7
 YnaLTzpxoCY3cnjeXWxAIuiXEnf+5gOuqlAWOyzKGK6lScwKTTD3wov8giWKzStjUmFhibxl28N
 qvFbQ17kutlwsEa8ntWxKdp9EniaC9eSOOFKKxz/cP8zfYDVjgNA9P25246Y03G3oZFIRThaT+C
 QHA4bfPnlUyp3CGfR4fU5oJIhdMLCNSA==
X-Received: by 2002:a05:600c:4ed1:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-4954a402df8mr130504265e9.21.1784565658323; 
 Mon, 20 Jul 2026 09:40:58 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:40:57 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:33 +0100
Subject: [PATCH 06/36] clk: compat: add clk (un)prepare and associated
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-6-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3067;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=2eNUSGaMzEC18x6RwfBgQs4ptXe1sjx84PqpjysXILE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AzvUG9TOuHTIdfoFFhqhEiS9eyJguhl4RO
 BgiuHSDvgCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 trt1D/46zSqr1AhUkxS81477DmL/HJ3jSBSAJ4VOztKRz9Kag32JxccwbOKMGawnqTSIUkqEIVa
 lZFFzuiGJz09DsPPDKONbPKpHBF0jnhyP7opWz9YoxyD/FaDmQwMDJQkkVVNsx4bKovzTJeYSz/
 pS6gkb8LU9VOfjYPcMwNVPgpahCLhcmFZ28hfYX8uOglZmKY+raoUyWk8+0izYpYImHgAtl8Rec
 a0FY8J61V/9vBXGBWGRlTluqKn8pjG76MnrnaFP/lyTb56vFR8fdaAdrdQpR/+Zc0vuMqxubfGf
 sfKI+UCnY4O0a+v1wuxm2rhlL9+cKuMR1NVb3DimzIK7NZvzIsruRcZbfyz2+V7K+x/UljfKhW8
 9PN5sbqHd1LdgB5ub9NFhMyywmPGRicoyeQvNlHuR0pQxIjNb1oucpdlIioaeVPZBSxvPa0w2jO
 NeLi8HTIpbUoMWoJodzdeaiN1GZeuE4/hpPIHu3bEPLkSfPFoxJ2RXYRAHgsLJ9R7qWXUtF4BBr
 Pkv839i7lb/bor7VfjCv36Cj8bnA7o04eeIKtaWJyLuP1YtYuuCTVCIGoWsvB1M8Q6B9+jxhuwV
 9sCIf1WrY4Q/HmkbRLdekxRg4OLLHcfMDt6ip4pEJ9MohV9TOR7FuCzn99I9krjEU0K+2htz8Jz
 N91fabWCNTA07kQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565658; x=1785170458; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qARKzzp+sMU4ZbSkbncwaYmd0Gf4tg4X5MM4xPGJtHU=;
 b=rzqykJTYF7Imw4gQ9mLruzIzWh0eQeVF+dg5M7RsAA5XTTCqFmRUOXx1Bm/x94OwVQ
 D+ovWb6rVIpk6NtGXRhWEGPAI5jrSSpatc6ESUSiKqpZIzz1y98rLjfCRS2/ZNkDBWDs
 rSicXfYD3chCxs3Pti92mtLyXupbLrsItj8RiZnPUbcgkrCrC74SwI4PdJYE/ipvHtvo
 vSoATid8JmbRbWdaRe0weO/CgG+4Wc8SqmndNhb7Ci4M1f6OpXDnFjMxHxF+Nrv+2ETS
 ZMVzh10+DxnEEY05DbPAV21fMLeYvFK2i8zkdASSO/tp2Adn2MqSM4CN0rODsFPwV1fk
 GFmg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=rzqykJTY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="rzqykJTY"; 
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

Introduce clk_prepare/prepare_enable as well as unprepare and bulk
associated functions. These are just stubs but will be used with
CCF_FULL.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c |  7 +++++
 include/clk.h            | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 095329e25f15..e960d2ad2383 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -837,8 +837,15 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
 
 	return clk;
 }
 
+int clk_prepare(struct clk *clk)
+{
+	return 0;
+}
+
+void clk_unprepare(struct clk *clk) { }
+
 int clk_uclass_post_probe(struct udevice *dev)
 {
 	/*
 	 * when a clock provider is probed. Call clk_set_defaults()
diff --git a/include/clk.h b/include/clk.h
index 0520032f692c..6ae033259cb1 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -514,8 +514,35 @@ long clk_set_rate(struct clk *clk, ulong rate);
  * Return: new rate, or -ve error code.
  */
 int clk_set_parent(struct clk *clk, struct clk *parent);
 
+/**
+ * clk_prepare - prepare a clock source
+ * @clk: clock source
+ *
+ * This prepares the clock source for use.
+ *
+ * Must not be called from within atomic context.
+ *
+ * U-Boot: this is a no-op unless CCF_FULL is enabled.
+ */
+int clk_prepare(struct clk *clk);
+
+int clk_prepare_bulk(struct clk_bulk *clks);
+
+/**
+ * clk_unprepare - undo preparation of a clock source
+ * @clk: clock source
+ *
+ * This undoes a previously prepared clock.  The caller must balance
+ * the number of prepare and unprepare calls.
+ *
+ * Must not be called from within atomic context.
+ */
+void clk_unprepare(struct clk *clk);
+
+int clk_unprepare_bulk(struct clk_bulk *clks);
+
 /**
  * clk_enable() - Enable (turn on) a clock.
  * @clk:	A clock struct that was previously successfully requested by
  *		clk_request/get_by_*().
@@ -550,8 +577,49 @@ int clk_disable(struct clk *clk);
  * Return: zero on success, or -ve error code.
  */
 int clk_disable_bulk(struct clk_bulk *bulk);
 
+static inline int clk_prepare_enable(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (!ret)
+		ret = clk_enable(clk);
+
+	return ret;
+}
+
+static inline int clk_disable_unprepare(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_disable(clk);
+	if (!ret)
+		clk_unprepare(clk);
+	return ret;
+}
+
+static inline int clk_prepare_enable_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_prepare_bulk(clks);
+	if (!ret)
+		ret = clk_enable_bulk(clks);
+	return ret;
+}
+
+static inline int clk_disable_unprepare_bulk(struct clk_bulk *clks)
+{
+	int ret;
+
+	ret = clk_disable_bulk(clks);
+	if (!ret)
+		ret = clk_unprepare_bulk(clks);
+	return ret;
+}
+
 /**
  * clk_is_match - check if two clk's point to the same hardware clock
  * @p: clk compared against q
  * @q: clk compared against p

-- 
2.55.0

