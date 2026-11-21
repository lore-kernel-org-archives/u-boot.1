Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAB606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HZbxgFHc;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=IFx0hYCo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8128D605DA;
	Sat, 21 Nov 2026 12:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fhk5aRMGilav; Sat, 21 Nov 2026 12:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B7EE60666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264514;
	b=spETOsX+V2khTt/aPCUNHid5brzbv6ry87lORhfowEYr3itN4pbtRWtpVI3P0CaH76K6
	 2nbJCgtD/tnHwm3t9RGVUo3KfKtAGx01t9lnheiRwjTKQRim/XPW9M4n93SiFkK0sj50L
	 ZvOmNUMRZZ7fQDeovhyYG6pSMHy2rgYZMVj72s5rNcfTFXyoY9Olj78UTaOM46Ehq25BO
	 IIwInLN6XldBwvXiJxWL5lCRD3VaA5hNNe5B/izNI9Y0xN6WAbGn+ct1qMZGdzQED1daP
	 oDFiC9seaHFY7yXsnPG4bSuDHGUCm962Chq5ULzuPRF3PdTHz+bmBLKF0jlkO8wIk0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=77kIEgiI6d7RrULza7Llng8bW0oKJKR8KP0yjr0/kEA=;
	b=I78pYSs2pibQ4LMLbZBF18WK5YpaG95/m3rWBQTlzLJ07QsMRVmUSGPy7i/93SlNZXHE
	 2c9zrRjrbsoRR9bbKEQIsRaeFpZ+T1uKKujUJB3BeaM8L+wXKqzxBsmUYWcGhiMTwmLAV
	 UE05aUR9/2oGdfcmG9YXIubmx8cCFfVi038Ldj38SjPm8bVqRBMKnXm3KJBpjC198xkzi
	 RxPS1LiNHIvkLNMkbvOg5prMByUO55/6FpVLCx+WjoaySLl7Jo5eCoRo55laIzbDIA6zH
	 Si2TIeLpr5NHwni8xBKeNSlxPa/V6nware7fosXnqGYgRHepFjheAqSeDULha+4fRAQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264514;
	bh=77kIEgiI6d7RrULza7Llng8bW0oKJKR8KP0yjr0/kEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HZbxgFHcGtSefqtSfe2258y1vfjwipoFwY9RBwX7nAbNKnJMwjznU+WaArw7r38Gp
	 3YuiHSYbfn1uts1OPvzK7cM06X7cYWepL3qlFQISYSz38EsIXosTtZQhKv+GEjehGM
	 27dmSM9MUkzBNA+HuQs2jwWWKT1DxFKeN8i/7G4lSGXB9Wyan8wib9wc87mlNHAZ/H
	 KQ19odrzEt0jjaOUb49GkTjIO5ZamnREx6yYQoo737WHQRDqlPbM/juSya/p6RKAOB
	 53J9kWlTbpphnqvJAffhmrvbISDGvG29bmkBzX7B+lEhhasHuRPvJs7SuqtFl6L2NA
	 nq3IpNxRDYIcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B7EE60666;
	Sat, 21 Nov 2026 12:35:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B07D39C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 968FB40012
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X06kCHQ3qi4I for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 80DBD40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=IFx0hYCo
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80DBD40070
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1002515f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264506; x=1795869306;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=77kIEgiI6d7RrULza7Llng8bW0oKJKR8KP0yjr0/kEA=;
 b=IFx0hYCoPfFUzzOLPnMmUFfR9Ymad4Qu0GPNUGkDeYzxzP+3jEyJhcMU7xKCyB7HTz
 k1lIYtPgM1ouFA+qzKKud+7DdvIM0mE+Gy3o//ud7dkbFK+zvlsmk0JvApbMBmcm50ce
 HP0WX/WbXkCMSiDIuvryAg50BsHGq8iOWmxBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264506; x=1795869306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=77kIEgiI6d7RrULza7Llng8bW0oKJKR8KP0yjr0/kEA=;
 b=LaCYSkqLrae3JiGt/02rD5q0bpFzEEy806GqTn/JQXkxm4dTGZlPp8VPeUpsXb1FZW
 QgypINW2LFhqdkeoFmZHPIufF6jCnueMorKRDAUb/7cZlBHF/koOVuCnNzLHQ8b+sLco
 PUklqNd6zJkefzAsbz3kK62fXJN6j+esvj0e2cQDh5mYpUUDb/6hyxObJvsXSTq1dF5S
 +A8fCj8Tp6xKd6dR7t7Y1VnXokUGJbKc51aPMWSp6m+QY+OFbPJCQhDK0Sh4iiI/GP3n
 z+eRZK0Q5SwixGCOag6ATFtAekiBuz6B+5FJh5kDXVx1QGe1X5g4rCkn1A0Kd3EVulVt
 lYdQ==
X-Gm-Message-State: APuU4Z980Br3PxS5ocFzjp9IZPXuRd6M/NYRPB2u6XZXgwPKzvH2xsAo
 Am6JPl/nmrsuon4BlmTJQTTweu8s0d00G3UWeY4ggN/Gjy6hHvxY/KYwTu/JzQfcfY6C2tyAFCE
 kV/n4
X-Gm-Gg: AZFdTZe/4NJIeLIjM9P/p3cHvwETyE2MOFL/ati3qBV8G+n8aGneNssEP4hIP9kJFhH
 PTTfVWxSBFplHufuun3EqvudllQIIE5ohX9jzH/0xrTksfzA30sEjnmJii2JiRLteztt1oz24Ei
 VF6MhhJCdEgi8sjbP1d4WetAV/SlY2y7q/oasM0J2hefBlhBiUPTBLFc+76dVbsfpxczcLc3wQu
 +AORdCOoBNNxrbP+PyQ+DUDyoWiNCw57esnoOlAxzpR5dyHQ/KOaVjnFhwR4oXQAgeXeD2oXcoa
 cgVFNZkxh1SN34aYNKnOJa8+owf1oDcLAsjvQJpT7+bUYAcEmkKwKLlt+BVfvKwBULb+qEQ+NrA
 KONrREjqLTqG3kctQQJQO3bjtT5QdnlpaTGtryEHtEvZNj3HeXSv0VJJC2NaUk2FUvSxwY2T5WA
 SiKLcq+6awFwpIZ9DT/l7EQkgvPuvJ9q43L6v0KM02lI2mgpWxuL9xFBA05wiGA46xQ3H3Rwtj3
 d+xeygJtUv5ClI5ZZPpDcnvuXVA3ahRp+sL6XOYKy4xuXxxkkilbpSKloSF7gHqrDqSCg56qpim
 PU0FGvGmPD3v+sIWuyxbu1qWSajN340yT45l8429FnAsTyet+XONLj6QxdrF54xLKz1hcmJbHnQ
 zyw5y8Bt64s4w+iRXw+zEnUnDakVGkf+GQx2n+wyraDtcudfM4zLaOrJIM7H//f8zYmBW1Kb5zs
 EASjYzazA3RwMPDfNCgbhaUdbXZw==
X-Received: by 2002:a05:6000:1789:b0:491:971a:c568 with SMTP id
 ffacd0b85a97d-4abb3861356mr12524483f8f.10.1795264506108; 
 Sat, 21 Nov 2026 04:35:06 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:05 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/25] clk: imx8mn: add video clocks support
Date: Sat, 21 Nov 2026 13:33:55 +0100
Message-ID: <20261121123451.2471185-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Add clocks support for the video subsystem.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx8mn.c | 80 ++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 56d44192e35e..229760ce931e 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -17,6 +17,7 @@
 static u32 share_count_nand;
 
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
+static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
 static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
 static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
 static const char * const sys_pll1_bypass_sels[] = {"sys_pll1", "sys_pll1_ref_sel", };
@@ -47,6 +48,39 @@ static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m",
 						    "video_pll_out", "sys_pll3_out", };
 
 #ifndef CONFIG_XPL_BUILD
+static const char * const imx8mn_disp_axi_sels[] = {"osc_24m", "sys_pll2_1000m",
+						    "sys_pll1_800m", "sys_pll3_out", "sys_pll1_40m",
+						    "audio_pll2_out", "clk_ext1", "clk_ext4", };
+
+static const char * const imx8mn_disp_apb_sels[] = {"osc_24m", "sys_pll2_125m",
+						    "sys_pll1_800m", "sys_pll3_out", "sys_pll1_40m",
+						    "audio_pll2_out", "clk_ext1", "clk_ext3", };
+
+static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out",
+						      "audio_pll2_out", "audio_pll1_out",
+						      "sys_pll1_800m", "sys_pll2_1000m",
+						      "sys_pll3_out", "clk_ext4", };
+
+static const char * const imx8mn_dsi_core_sels[] = {"osc_24m", "sys_pll1_266m",
+						    "sys_pll2_250m", "sys_pll1_800m",
+						    "sys_pll2_1000m", "sys_pll3_out",
+						    "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_dsi_phy_sels[] = {"osc_24m", "sys_pll2_125m",
+						   "sys_pll2_100m", "sys_pll1_800m",
+						   "sys_pll2_1000m", "clk_ext2",
+						   "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m",
+						   "sys_pll2_100m", "sys_pll1_800m",
+						   "sys_pll2_1000m", "sys_pll3_out",
+						   "audio_pll2_out", "video_pll_out", };
+
+static const char * const imx8mn_camera_pixel_sels[] = {"osc_24m", "sys_pll1_266m",
+							"sys_pll2_250m", "sys_pll1_800m",
+							"sys_pll2_1000m", "sys_pll3_out",
+							"audio_pll2_out", "video_pll_out", };
+
 static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
 						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
 						    "video_pll_out", "clk_ext4", };
@@ -168,6 +202,10 @@ static const char * const imx8mn_usb_phy_sels[] = {"osc_24m", "sys_pll1_100m", "
 						   "sys_pll2_100m", "sys_pll2_200m", "clk_ext2",
 						   "clk_ext3", "audio_pll2_out", };
 
+#ifndef CONFIG_XPL_BUILD
+static unsigned int share_count_disp;
+#endif
+
 static int imx8mn_clk_probe(struct udevice *dev)
 {
 	struct clk osc_24m_clk;
@@ -191,6 +229,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3_REF_SEL,
 	       imx_clk_mux(dev, "sys_pll3_ref_sel", base + 0x114, 0, 2,
 			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
+	clk_dm(IMX8MN_VIDEO_PLL_REF_SEL,
+	       imx_clk_mux(dev, "video_pll_ref_sel", base + 0x28, 0, 2,
+			   pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 
 	clk_dm(IMX8MN_DRAM_PLL,
 	       imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel",
@@ -207,6 +248,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_SYS_PLL3,
 	       imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",
 			       base + 0x114, &imx_1416x_pll));
+	clk_dm(IMX8MN_VIDEO_PLL1,
+	       imx_clk_pll14xx("video_pll", "video_pll_ref_sel",
+			       base + 0x28, &imx_1443x_pll));
 
 	/* PLL bypass out */
 	clk_dm(IMX8MN_DRAM_PLL_BYPASS,
@@ -219,6 +263,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 				 arm_pll_bypass_sels,
 				 ARRAY_SIZE(arm_pll_bypass_sels),
 				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MN_VIDEO_PLL_BYPASS,
+	       imx_clk_mux_flags(dev, "video_pll_bypass", base + 0x28, 16, 1,
+				 video_pll_bypass_sels,
+				 ARRAY_SIZE(video_pll_bypass_sels),
+				 CLK_SET_RATE_PARENT));
 	clk_dm(IMX8MN_SYS_PLL1_BYPASS,
 	       imx_clk_mux_flags(dev, "sys_pll1_bypass", base + 0x94, 4, 1,
 				 sys_pll1_bypass_sels,
@@ -239,6 +288,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_DRAM_PLL_OUT,
 	       imx_clk_gate(dev, "dram_pll_out", "dram_pll_bypass",
 			    base + 0x50, 13));
+	clk_dm(IMX8MN_VIDEO_PLL_OUT,
+	       imx_clk_gate(dev, "video_pll_out", "video_pll_bypass",
+			    base + 0x28, 13));
 	clk_dm(IMX8MN_ARM_PLL_OUT,
 	       imx_clk_gate(dev, "arm_pll_out", "arm_pll_bypass",
 			    base + 0x84, 11));
@@ -413,6 +465,34 @@ static int imx8mn_clk_probe(struct udevice *dev)
 
 	/* clks not needed in SPL stage */
 #ifndef CONFIG_XPL_BUILD
+	clk_dm(IMX8MN_CLK_DISP_AXI,
+	       imx8m_clk_composite(dev, "disp_axi", imx8mn_disp_axi_sels, base + 0x8a00));
+	clk_dm(IMX8MN_CLK_DISP_APB,
+	       imx8m_clk_composite(dev, "disp_apb", imx8mn_disp_apb_sels, base + 0x8a80));
+	clk_dm(IMX8MN_CLK_DISP_PIXEL,
+	       __imx8m_clk_composite(dev, "disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500,
+				     CLK_SET_RATE_PARENT));
+	clk_dm(IMX8MN_CLK_DSI_CORE,
+	       imx8m_clk_composite(dev, "dsi_core", imx8mn_dsi_core_sels, base + 0xbb00));
+	clk_dm(IMX8MN_CLK_DSI_PHY_REF,
+	       imx8m_clk_composite(dev, "dsi_phy_ref", imx8mn_dsi_phy_sels, base + 0xbb80));
+	clk_dm(IMX8MN_CLK_DSI_DBI,
+	       imx8m_clk_composite(dev, "dsi_dbi", imx8mn_dsi_dbi_sels, base + 0xbc00));
+	clk_dm(IMX8MN_CLK_CAMERA_PIXEL,
+	       imx8m_clk_composite(dev, "camera_pixel", imx8mn_camera_pixel_sels, base + 0xbd00));
+
+	clk_dm(IMX8MN_CLK_DISP_AXI_ROOT,
+	       imx_clk_gate2_shared2(dev, "disp_axi_root_clk", "disp_axi", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_DISP_APB_ROOT,
+	       imx_clk_gate2_shared2(dev, "disp_apb_root_clk", "disp_apb", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_CAMERA_PIXEL_ROOT,
+	       imx_clk_gate2_shared2(dev, "camera_pixel_clk", "camera_pixel", base + 0x45d0, 0,
+				     &share_count_disp));
+	clk_dm(IMX8MN_CLK_DISP_PIXEL_ROOT,
+	       imx_clk_gate2_shared2(dev, "disp_pixel_clk", "disp_pixel", base + 0x45d0, 0,
+				     &share_count_disp));
 	clk_dm(IMX8MN_CLK_ENET_REF,
 	       imx8m_clk_composite(dev, "enet_ref", imx8mn_enet_ref_sels,
 	       base + 0xa980));
-- 
2.43.0

