Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD1BC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AA7580D89;
	Mon, 20 Jul 2026 18:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVtfI2TcNa5v; Mon, 20 Jul 2026 18:10:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4FE880DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571036;
	bh=eDfaGhTvIaZeKnlhK/69QlPp1YArSxor2r1KS5iYRwg=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=s2owpS393o2f5YBvG8SuaTNJyMWRGOguKuu2YeZtw4SI/3gveF9WPn1xNghGz3bBb
	 lSBV9kynmYDWir/dr9gEXf1KHaIvb7YVKvorS3JLgujGaPQLP0itl2rZ9ZI2D9E7TB
	 ZSieb5oAS/TxblUdRNwPZQ0lMmCzWd1wHCq1a7BJyhRruDO8YiecG/RRkRsiMJV47k
	 yPGNNdBcLV+u7DRhm3Kyjvsx70SgiRtAH4Yb28ZDZuK3VKXZ1iB7stRDd/O6Giyw7I
	 DZsNuCEWfScXnkGwpHRNbfmz8a3wtMwN6pUA2eufQWIrpFqupMt24N9Tb/YlviDwBE
	 +LPsWKyGFM50w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4FE880DFA;
	Mon, 20 Jul 2026 18:10:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AD561DF5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C92580BFA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NONDQogzS4yh for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C60C80C04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C60C80C04
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C60C80C04
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04048493F; Mon, 20 Jul 2026 18:42:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E106484A60
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:42:19 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49546c690ffso26773875e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565739; x=1785170539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eDfaGhTvIaZeKnlhK/69QlPp1YArSxor2r1KS5iYRwg=;
 b=XiM07PrqmhTJIHpQ1xt7dsC8Wd4Yw15PjJweY19r/9a91V/bhLcVGYM6j4/lAUEGTJ
 qH2OTmKewdX166+4+2jHlUbUlu/ml9EurCwgHXl9AbHJFEwFEmedwVGJgl5IZbemo7S1
 hoD33CBnyFvm2H8FXZ2IrBqRlPpxJFTwgoCHPrx3vfiHfL5cMX8jkLVmfmXQxK31RAFT
 RO8pO5EVSSecxsKlVY6OEhvwTF/SOmJ/J3Mjer2dyAe9plgUW34mjU7mbJNBfBGMO/rG
 2UucgxOlJL30KOw6tmoYnQ2aFa0xF0hPEWVygZOKSznobxl1IT+35sx4fkFbx3yvomFB
 Tkvg==
X-Gm-Message-State: AOJu0Yzuh++QfrXjlZT2z9Y5he1+2Se9jtAGOhrSHZxJJw4JnYqH+hzx
 kJfRBvwOpmXLigbczzRSd0Uu6/lTMYT34qsLnx3Pru7GB7ldkxenUAN6TYTnAZhI7G8=
X-Gm-Gg: AfdE7cl9g5huQBPoD0wIyh10aKiHq1MFuZlmw8pANjOyo7RfgFba4cRpeJiRfVfYp72
 M0OQTvD8GffHJXqnmWt8GkhBS+kcKpktBYllsSDgqv4Fx6dCHmLgiS45UcmVObzoRoVJ8AfZPvD
 ya1ytZ7x+xp52Gz1k7FrKVad7v5Ozrz6Ksm7VIP4WjzTObWXa0szfj4skzKr07jEJ++qBW502NB
 Xx8jE/AMz1UmDzXB9pOB5LFurroP8bbTMfWheOfMJv5+KudTBUsX99D2vCuR7B7+Yzp+JEeIgKA
 QWo+hbI6suy7bhI/tc+a+S9d4fxPrcJoQnXQL4iNJvdhyEn6xIuxCxSHzDr4vdtRvGzGAMv/EFJ
 LKetFw9SW6Wra2xUF20AFescyy9gf+Wb2bMmfE44X8y/CTI6p9UKK7DCE3KzqCses7U2C8FDaEV
 s8tUHPLE0afKzzvr6v97lbLSXvl3y9CA==
X-Received: by 2002:a05:600c:e548:10b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-4954a40e11dmr117107625e9.18.1784565739414; 
 Mon, 20 Jul 2026 09:42:19 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:42:18 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:41:01 +0100
Subject: [PATCH 34/36] ufs: qcom: use clk_prepare_enable_bulk()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-34-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=y6OLVub7ZzJsvm9t0SIo7RimQsbVTY/xJjXd8t8dM1w=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+Htiz6Mr2siQsVRTN1kqkH8C9It91RKoTej
 lJC0osd4COJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhwAKCRAFgzErGV9k
 tlJ/D/0UD2Tn91GVHaccFivkCONzgfAUqLwG7poligyUOeMf15jSo/8qnOnFzI2Hti7cHlQExb5
 rZ3RzMSEpxbW7FqpTISVV2sa0i/fmZVh/JboP6j+7Cl+XwtiC7QG4EV86OgpLcDjP8Ac7VS1uVq
 atG1bBw3PjYHIC1Ck4STGAjwBRt+kdXVjICusuKW3lrMZdoV64ZgBHGjhV71kbkb3H94q4scsww
 l6r6cZEaGKCuQBuxFwpqcyyt+tKL1xb+yL44HppRqQ+vW9Lw0dSbeZAmm+wnpFHMCFdMozbYpBM
 40ekmh4aHQDCkqdMuj5Q6kfSmS3Jpf6tc9ngEVdTiEs0oMC7mPoTTcDMTtGuDi4WzK7QUhzVGXj
 z24F9lj1V8n4YG3j7BS0+IciYajZFaPwIwRGdeu8a8GlDC4WT7lnNEHQXCqA2fJzjL4Sn5ob1Ld
 Y1TwkAL4YUGc9l5qmcC/CcjUDnP4NG6n4IqptBfvzhtG5l9jk/I3txsb7+9bt00pPrXAA7gAZlL
 oXC6PDtMN4V8+/MDf1auODL+C8Kz0cfdMCPr0Sl+eYKDQdBbv9L+rqQRC47kHL6apI7xmr3e5Pn
 Jmp5N5cnOSACYpNEI6xDSnICj35TxXlleBk6yv6sKJDnX932g1rpaj9CPGJn2er93Hfps5gLMpE
 OfT939j0BOo9Bhg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565739; x=1785170539; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDfaGhTvIaZeKnlhK/69QlPp1YArSxor2r1KS5iYRwg=;
 b=CiuasS8LIlnTklqWSIjywEhm+5DPH58y5dIb5QP+Wr0R7X/Pl9sLdIWIb8cdlHyxmE
 oo4S03a0g8hN9lWaqaf4PZ0ecTX/z3NUc71m5oX+Ttlg2tfT4FhT4hhVZ43vq1mQvc/I
 b8n2CmEK0mBeDxU0SK6RWdpa4YxoN6qo/Tfg8WyXnySTKpqkwvL2/Q94elb2El6GJpOZ
 F2lxXr21eARLuuoTbBYinLmoTATvzfQ+C7r1WWHf1qjlDDFDac69B1o7B+VoM96lblHd
 hIelKNU+3U6z1pxCXtw94bm6u7JOc6mjXvXkA5+HIA9xkmxPCkc5Mfv0pUIhIc3aLVKM
 2ofw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=CiuasS8L
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="CiuasS8L"; 
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

With CCF the clocks have to be prepared before enabling. The CCF core
will do this for us but it's much better to be explicit.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/ufs/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
index f5f5a6eb110c..3656c3861cb5 100644
--- a/drivers/ufs/ufs-qcom.c
+++ b/drivers/ufs/ufs-qcom.c
@@ -38,9 +38,9 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
 
 	if (priv->is_clks_enabled)
 		return 0;
 
-	err = clk_enable_bulk(&priv->clks);
+	err = clk_prepare_enable_bulk(&priv->clks);
 	if (err)
 		return err;
 
 	priv->is_clks_enabled = true;

-- 
2.55.0

