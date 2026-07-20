Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE77C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8B0080D91;
	Mon, 20 Jul 2026 18:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmbBhO6cFgIk; Mon, 20 Jul 2026 18:10:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4C1F80D82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571012;
	bh=W1bfgW5KO1zqA/tD2PyiocEnms4V2CBW+DWiOiZOIiA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GKwE4aX/rsujZ5w1Ze5ostXEYBI2eF6TRBU409u8c966XSu+gXJnrofZyIEdjG4wT
	 Brqn2ZHFQH7L4eyVjHHCGk9BWg3z/LkTaCfmXM955gLpYqQG4hXhlleV6KbXcyDuMG
	 XqRqgBGjm8TYGJQXk/cB0Wjm9PxSKCPHFJfKZVW31O/FE0ALpT3jHxZz2QL4JcgUkn
	 wwNRm4rTPUjpJRpQMH/8pWYEHl2xxj3JBekFE2JCeTiV47bGjwie76WnCjtTl1+0Gx
	 IS8JmmNVoiUH6u0LrZc93YwWm8lNKulFt8UO/Z5ZvZ3elXzd1R6PAm/cthvTJ6rgFY
	 feG8OFX7GDucg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4C1F80D82;
	Mon, 20 Jul 2026 18:10:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC131DDB
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30C1180BFA
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YMnlbqE43RzB for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 30F4180D09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30F4180D09
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30F4180D09
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC0F84949; Mon, 20 Jul 2026 18:41:10 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87814844F6
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:08 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso23095635e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565668; x=1785170468;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W1bfgW5KO1zqA/tD2PyiocEnms4V2CBW+DWiOiZOIiA=;
 b=SQjdqdujqAFsFgSa78/tlfK/0yjKIJtnG0uxVeGXGMHNtWRRSU8E/gFx2jl+i5p5rh
 d3tJxIz8H73r0v4bqsell57s48RTT2nk3Ivxa1gz2NSXG7goFnaSfPJygxtLmwrf0aHH
 mEsTUA+uPl5LMF2uEOlgyHhTkoVbv+igLoYRp2+Cm57oYhzDXrojKXAxS5DuqegsAX6D
 mzOQgTcvwm4t5LhPdSNQVQKd9DtDgqJ1HwPeC2asQiqg4wTPkxByjd1OE6KbMh1xAJHI
 gLqaamIsZ/A+HyTYMe6+Qga+AfptXlGvaeJsKAt2OaseupfVWcYT1cFxZsp6zjc/kHbv
 J3JQ==
X-Gm-Message-State: AOJu0YwgUoZlrNy06FdJUsVguAwHx2tie3dOJGW3O8X3bi42oT9LUK8/
 dAFA4Ic3pgqP3jsa1zsry+iadpvLBuYxvX3Qu9is4cArY9vGyBBl8sTjNgSpLXQjHXc=
X-Gm-Gg: AfdE7clT95ZLvtEY3XUV8ozDfNiU1EL9JBA8XkhM7s9VttdlcdBjf/Rtue2oVO3vSFI
 YXVH2zFfMYUkWUEFUmVFkmvCY/h2Nm6za/8rOgDgPkBSn/6SnWTcfgImbcLVT/SUhIv5jL8HzCo
 cd6Sl5sIvgfwUJ8QgA4oWVF9VGyNgjJ8JS3nWIUQ3sW5hQ9yVI9oohVmZ4MSMDYopPYmFehHpXZ
 6W8JTDNoi+/UAbpU44KASpJA1DxIaC3wMwe1MpF5evKn+xZ8ACHWZFetYx2Nu60fe74omJl4W/p
 KUIuNJn+ohQ5E1xoHzDah1/G1T54cBcmE5uWX1B19t/Ix6h4cIHVybEffAKoHhn6tBVp27SB56p
 Oy4O2eHwKDgMZ9Oqr6rIZBNBQ7vlSzf58Ugik5kAV5vg+DRTyJbNCjmv7MSm5lpFSwREMfOa4B3
 izSyiMDKhbytzQjqb4Go2wruwRpCELNw==
X-Received: by 2002:a05:600c:3112:b0:495:472c:208d with SMTP id
 5b1f17b1804b1-4954a41307cmr151953975e9.38.1784565667570; 
 Mon, 20 Jul 2026 09:41:07 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:06 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:36 +0100
Subject: [PATCH 09/36] clk: move clock flags to common clk-provider.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-9-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5656;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=d/3uB9MiQ1FHm7yOyedVgNNiozuNNemxsNlKRMUHV1I=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+CfDhxAIV+54iZqkG996Gn9vIC3MwvT3RCH
 D+CODQlZruJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PggAKCRAFgzErGV9k
 ti4wD/9RlqaCqCGHYSThA49InhfqRDIkjIuFXIWf3nylXmazyJyTUXT0hDb1VN8N+WZHfyqiynx
 TDVGE8MLFm1K6H9Ja55g2bGq1hgdy8IuPI2n78rv7/N4uljS6aPJRosXgCjux3l5Q7tEwRmgFS7
 DcT/vsqUYJAnQweguycI9gtPfIjxE9ZaJk7TLLNyijxPx67Xui7JVMyJaGnzQUWMFlfKRo1KbSy
 mK1hIjAXnjes102hdiUzatmUKky+Ihz+rz2E6bRwr132Hm7wIobzGX022O5HMaKWqp4Fg8iBiUx
 0K4QTGQH1W/UqPzC4pio/KUdUZ1UgiIPfjL6+B2taeXMQ3oGGIrDnSoqRdfn+EVOqcGeDrLyp5r
 fFP7RxDkco4p8ud4/N7LAuLg03Fec+0Xh7WUBBr+pwrnbo5vB9XFS9cad0E5gUmzegzcPRomHNj
 KejPghd3b/IToy5mkm1caL0Rb9+bDpZ4WLXXbVNW6eYhQJ7cewlMGLilMPJBEmxsIVaNI53YyVa
 sBIaEopvZP26zjQRDFxoUhmlmEtBwPIXjJava4aE3fgRSzb1nSmuCuzPWyd/HAIvaZDJ54mn5ix
 tFzR+VBaSGLxA8KPp8YhnDFIVovVSqmH8t/xGIdf1xHDRmlYdYlb8tS4XQA7YD5F6wbQW0az0Xb
 m85gm1411rmnnJw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565668; x=1785170468; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W1bfgW5KO1zqA/tD2PyiocEnms4V2CBW+DWiOiZOIiA=;
 b=h2Yt/llH5xEUr/0+Kx2yDZJDyzrzcxLLuMO3mcfF53UsTGd6UMAPt0l7rZE/9N7nHK
 6cjZgraaMvVZPBMZf9lJ1/kwks0wW3GD4uvpZIb+WLOHtchcma/I0IdrJoB592caZjp5
 TDHUXV4tiR5IbR5BNxAgHU3jr0xyR4JktdaTATInRXlE8FBlKjc9cgb5x7GULLOie859
 GRRf2JJBf9adawZoINxKubbqLfvWNcIJSSOQUL0QdsO0gET6i0xOgjZqpff4Z403YUu0
 2rE776GIZ6jFXvhlUkSRBc6gvY6xbNeYxoFDqPQQ40K+xXjnjmoknN6p40tnwcwBzZME
 rGdQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=h2Yt/llH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2Yt/llH"; 
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

These are the same between uccf and ccf_full, move them out to
clk-provider.h so we can ensure they stay in sync.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/clk-provider-ccf_full.h | 24 ------------------------
 include/linux/clk-provider-uccf.h     | 24 ------------------------
 include/linux/clk-provider.h          | 24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/include/linux/clk-provider-ccf_full.h b/include/linux/clk-provider-ccf_full.h
index dfc2049feee5..0e160b13b3b2 100644
--- a/include/linux/clk-provider-ccf_full.h
+++ b/include/linux/clk-provider-ccf_full.h
@@ -9,32 +9,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <clk-uclass.h>
 
-/*
- * flags used across common struct clk.  these flags should only affect the
- * top-level framework.  custom flags for dealing with hardware specifics
- * belong in struct clk_foo
- *
- * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
- */
-#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
-#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
-#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
-#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
-				/* unused */
-				/* unused */
-#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
-#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
-#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
-#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
-#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
-#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
-/* parents need enable during gate/ungate, set rate and re-parent */
-#define CLK_OPS_PARENT_ENABLE	BIT(12)
-/* duty cycle call may be forwarded to the parent clock */
-#define CLK_DUTY_CYCLE_PARENT	BIT(13)
-
 struct clk;
 struct clk_hw;
 struct clk_core;
 struct dentry;
diff --git a/include/linux/clk-provider-uccf.h b/include/linux/clk-provider-uccf.h
index 2380245b70a9..e9e96b988b91 100644
--- a/include/linux/clk-provider-uccf.h
+++ b/include/linux/clk-provider-uccf.h
@@ -27,32 +27,8 @@ static inline void clk_dm(ulong id, struct clk *clk)
 	if (!IS_ERR(clk))
 		clk->id = CLK_ID(clk->dev, id);
 }
 
-/*
- * flags used across common struct clk.  these flags should only affect the
- * top-level framework.  custom flags for dealing with hardware specifics
- * belong in struct clk_foo
- *
- * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
- */
-#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
-#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
-#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
-#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
-				/* unused */
-#define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
-#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
-#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
-#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
-#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
-#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
-#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
-/* parents need enable during gate/ungate, set rate and re-parent */
-#define CLK_OPS_PARENT_ENABLE	BIT(12)
-/* duty cycle call may be forwarded to the parent clock */
-#define CLK_DUTY_CYCLE_PARENT	BIT(13)
-
 #define CLK_MUX_INDEX_ONE		BIT(0)
 #define CLK_MUX_INDEX_BIT		BIT(1)
 #define CLK_MUX_HIWORD_MASK		BIT(2)
 #define CLK_MUX_READ_ONLY		BIT(3) /* mux can't be changed */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1140c2b10ac2..4fcdb5a86799 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -8,8 +8,32 @@
  */
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+/*
+ * flags used across common struct clk.  these flags should only affect the
+ * top-level framework.  custom flags for dealing with hardware specifics
+ * belong in struct clk_foo
+ *
+ * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
+ */
+#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
+#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
+#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
+#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
+				/* unused */
+				/* unused */
+#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
+#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
+#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
+#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
+#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
+/* parents need enable during gate/ungate, set rate and re-parent */
+#define CLK_OPS_PARENT_ENABLE	BIT(12)
+/* duty cycle call may be forwarded to the parent clock */
+#define CLK_DUTY_CYCLE_PARENT	BIT(13)
+
 /*
  * U-Boot: for compatibility include the correct clk-provider.h
  * for either uccf (U-Boot CCF) or ccf_full (Linux CCF)
  */

-- 
2.55.0

