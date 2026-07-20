Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB85C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81F3280D6E;
	Mon, 20 Jul 2026 18:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKv4KitBsdO9; Mon, 20 Jul 2026 18:09:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D06280D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570999;
	bh=EqqplItuGUTYXwbcu9hBiOK817zlYDt9SADhW3PlCMw=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ui3Oi75I+1xebkYEZGQ8TUcnAV9a//kVbET1lzeH2/AHWehmyoHQxQgBFQp095Ax9
	 ThIFlJ0vTZz7FfmjjRVCR80mZvgSV/A5c4v0P+dV5WZ3otjcpeb691Wp7jKBStokPS
	 8OQFSbResGvgq5U0Ce/kmd9lmm9xLTM41nAzHd3ggViT7hx+lCqLPYPbSkDbKfwLVr
	 1rBeR3ECon7LB1UGIbZqcRDYNVVzZeaXI3zfm38MtE2BGM6HXa7WyR9D7wXXRbeVA2
	 Z/mve7ArsyogEeBd20WkOWX8PMY+0Qm3ezVjoEnwn3lak04wiyOVkwDqE4MfCQLTLh
	 cORc2eEMv8hRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D06280D4B;
	Mon, 20 Jul 2026 18:09:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DE8CD1DF6
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC72D406B0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNve2Z6iRO2w for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 345C7406A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 345C7406A3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 345C7406A3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55E28488B; Mon, 20 Jul 2026 18:40:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB70844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:40:56 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so11223845e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565656; x=1785170456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EqqplItuGUTYXwbcu9hBiOK817zlYDt9SADhW3PlCMw=;
 b=A4s+NDNeMDbgM5x+t3x0hAzEBHr3ki6niZMZuOcd+BhccdG0W9fW5uDHGUmhiQ9WYr
 pEfJlZUC2TAKeFbnAmNufRgPUoRQCmk+67/owpCGl1SheojupUB67K5+ZAjF1+/z7g8A
 HV3aJ3jVN3yUlIxq77YBV+VxIB3FE2ULNDa79Q/o7m5i248mUdfXTq7ecn1ZIlDumO8j
 ssiPduItDHBt0QGE6+kvp96I69pDJMvhZA1qywyGODpcGaUyVYroX52+RASm4KEw5asP
 erAnVnqSlK7H8Jpuo7dM3roDLhroaMHkUVOjPF46npRXzWjKYWsNlrtkYkB5wXLDN6vR
 GDtQ==
X-Gm-Message-State: AOJu0YzF4BHoy6+0t+cJ/48cT/0MTeYGzeKfaja/jmnmGxw04HepFUsb
 n/kigZqLK7MfzUmetMkiCq33WEb4ygHRhaGH3KX0xtU8pEdscSPpEYNXKikDkWaj5+/p5k3QziT
 69Wf5rAE=
X-Gm-Gg: AfdE7cn/8re2JlZj7yy/oHXM8lq5+tjs7gtqCoZNa0SvhdpdghdUp4/DlDk6hOV4YzG
 5ryBbQ7tG8mRA27VQOZTzbMHoyfCKKQT+43ooeNWu5QEOm9t4lxCxsYVwRqanWjz/1K6JB1SO2G
 ijzTDv01j2/WEjDhZbTQXhYvGS1EdEdCGAASoy0SAZADmpPP8H5nbGZsGnt+F4TgeVAJezbw/US
 vbYYABVgcnC2RKhm3nac9eYTcZucDYwiD8XzO+mvhltjfTzV8FcUHr3zvSO36vGYWwtIySqrtOs
 xN7oEjvG+RtMGwEme+EZiFvagQF4kOArPP1KJGuwfxa4fxxD5UoOCpkOr7GF+eci5XWLyhiNY6a
 X4Uavi3dP8AAzC1z/Q3zCGVn6QSzLlLo5BixbJM5UUyS7ZAbmj5q+fQH7wE/ZnWDJ+yA3NtWCs7
 GyI2dfduHoe5/wvKTRVhtyUPWUmns7M8lkamFeqhif
X-Received: by 2002:a05:600c:354e:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-4954a3eabb6mr183088735e9.17.1784565655806; 
 Mon, 20 Jul 2026 09:40:55 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:40:54 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:32 +0100
Subject: [PATCH 05/36] clk: make clk_get_parent_rate return signed long
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-5-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=3/WLlwjCYUvDXFgio7oQu16Kl9nMxwKRVq9n7IDJIng=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AiT37Zl2oYjd7MtL+Fd3YCIhuSlPfb5dVc
 YJadQdK0w+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 tiZUD/9QK2/OPmsoRrg/CNgawl8MEiXUD1gaO8ithKekIxL58R9a0jBmS5c5j9P3RRg5+RKbtYu
 ojKpKWpOsMYI3Cwuq69sF2TdBXLyir3zsRGgx+5Pz6qQF9YmZHK4NUH/KKgAURi5B7sWteJkEu7
 EYvtc4nphPeZdNPUpeJMbubTXSy6dQmUh6nppFWFrZ4G4v/cA7g9xvRNk2skng2KAxYme4axWam
 Ejt3ZaF7GfGjd8/a3XCUSjpLvuco3v259UQQmKqHjY6RPxugn53L3hCECJ6yaILyUGWoYoM8zSP
 z4iwB1VeeW7OPz8lPjjOTy23N5O8OJfre5/cULx3EGaXK4sDtAv3jR+f5UFjZXBGQtpmB0nOXIa
 OOWQvdwLRXwDn7UFwgoSV69Vxk8VNpfS3JjhGPG5i6Jbp94wZHk3pO/cQmc1ga4OGpgkXMYaBKk
 tKrbWxtrKR+bSVwsX9IQcyllfAT3/PteOzL1mreyiVC43rHrpz0Wwz/Bm7wHPtkagRF4v5/ZOYy
 3Y0ICibOCUfX1iyK7EpPCbpB1U8R7gkFJIlUiYaif+HKzc/MA8UDo8BCrGNwraqOl7r3iRvEubB
 WN0UXAq3P4yc94WKJHfPSPtBseFzk2Nk8ExF057Ox7DgDRpOT8jk7WWwyqVbvLSqx+BgzjATO9p
 GbigNzcw/W6fztg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565656; x=1785170456; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EqqplItuGUTYXwbcu9hBiOK817zlYDt9SADhW3PlCMw=;
 b=m+9gl7s1RldLvlFNapFqdE4n85apjEtfZBrSSo/CwkGRkhyiRu4r6EFFqj4f4oNE8F
 pSJGDeHTbCTLqLiYg5w7i1toidGqYug9bOpSq2vPeBzl2iXu0z5Ppf/vSGN2lKZdiZwc
 vMtTqprbQTJ2iD1ZiGEvLJFIQJzZf4hp2fc+wc8EuyjeBVcnXHYxHdBz8ktPlIm6CdSq
 1koojfSV8cfnLuamhT2gKMdXU7lHJJCNy3gxFHkgl2iMNYusOegyiXma2sx4LhFmbPXq
 YjfGRpqrl7cKRrWEepjJRh/onAhbcU7BkG3vRiYaPD85Owd3VjFJN0kgknZ2UJIoJdzI
 WloA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=m+9gl7s1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+9gl7s1"; 
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

This function can return negative values, update its prototype to
reflect this and avoid potential underflow issues with error conditions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 include/clk.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index db4f056e4816..095329e25f15 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -514,9 +514,9 @@ struct clk *clk_get_parent(struct clk *clk)
 
 	return pclk;
 }
 
-ulong clk_get_parent_rate(struct clk *clk)
+long clk_get_parent_rate(struct clk *clk)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *pclk;
 
diff --git a/include/clk.h b/include/clk.h
index 3cd080b43264..0520032f692c 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -468,9 +468,9 @@ struct clk *clk_get_parent(struct clk *clk);
  *		clk_request/get_by_*().
  *
  * Return: clock rate in Hz, or -ve error code.
  */
-ulong clk_get_parent_rate(struct clk *clk);
+long clk_get_parent_rate(struct clk *clk);
 
 /**
  * clk_round_rate() - Adjust a rate to the exact rate a clock can provide
  * @clk: A clock struct that was previously successfully requested by

-- 
2.55.0

