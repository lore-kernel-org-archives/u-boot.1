Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFB606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1OxUquvo;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=qRVQdT4r
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90740605B7;
	Sat, 21 Nov 2026 12:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0Mhg6xiN5xP; Sat, 21 Nov 2026 12:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC18E605DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264508;
	b=XwAP9nRdkFAK8et131b08p8nH1MOqfYX26TE/WVsdEbnoAAiE4iwZYsJsQceHOzna2X5
	 5avoLkjDzCjvWScEE+R8HhjHFNwaCqbfCgkPYR/NFleSk4PZezeWCYtidrUreMuxYZUPP
	 q+DyMqbSHcZs0leva0CPNUMMF1Fyr6w7WWQtVKDc/JZSaTUuVQM6XCJExYftL/dIzEg3u
	 G+fYnzj7zLruDu9jyg/ADcRJjvKku2SMvNLXwJ4XcEl0w+VpMgaVC0ApjbyPCfieqk5Fo
	 hDBl22AWLbuF3m4Ax4syMgkbDYZGV+28fc2OsIFlJ0lPFF2B++ZOTF4Io3iQIwC7HEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264508;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=haAIv4NlvV2KsOLxgOUX6sTSJB1gz1CYLEQMibqpB9Y=;
	b=FgX6jH/1neqSVY6UYQOj69wjBlxTkjh63kMzCQ4MM//n/QP9tvzZnvdq6mnHJTdMj7qh
	 rvLqToswmqlFWlnviPSUETFiDnYBhaof22ZfxDUfKwBuZF53B2/quo0KRoExpGNn0089J
	 YI0gVLALa8alDJGh9DeMf5m3esy7Gaq7lDWSLkqYhYvpl9QO7BV5op7atJzSK5SlEkrfk
	 m2IU7YHnQ1vYiC9aOneE6tIUL+F3MtPW1SubG+FgHEBni/XG75V7AIAPiuUlpZUEq7xqq
	 i2YxTi51IOWpB6DAPDrGYz4QnU08Y9/TcQHPTH4SNMIC5n8V8oThRvTgViMNsXWPovA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264507;
	bh=haAIv4NlvV2KsOLxgOUX6sTSJB1gz1CYLEQMibqpB9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1OxUquvoymOdARFrM1SrkyxWwezI4pSzWyzmMqtzW0Z/0ITynooIazT4D3LOQFUNi
	 I07nmhLmv2ETxNurOCWrTTKfxKU1fuAWEZSn3VLcwgDC1QlpHzYPKYZ7W/Y/IaPGUs
	 VUTMQzrLUEPyMRkeN+p0Jrp2dBmVUSWByTpGxK+9L1OvKUsB9J8CXKdUxbKEEYmC+3
	 Ge+xQrwsoVJQmD+Q9hrx9f3uPEY5iPWHSHmxMpBEhHFAaUD5VOnJiqZx4h3oOUldgt
	 gaVR8niqzX2ut+QxGDtgNShHGK7Kny3q4R5rXmKhdxBCMD0gjob8na4EDbbauuBmGv
	 Hm9k//7F0tNFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC18E605DA;
	Sat, 21 Nov 2026 12:35:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C910759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1224A80E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zOKCJef-P6_2 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B81B680E18
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=qRVQdT4r
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B81B680E18
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:02 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so1795805f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264500; x=1795869300;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=haAIv4NlvV2KsOLxgOUX6sTSJB1gz1CYLEQMibqpB9Y=;
 b=qRVQdT4rDP2SrR2qPjhk4ItxFLSTgww+JjHCBFBm5Ks7ya2hluG7RL4I32Jgc3flRI
 Nxiitg1Lmc0+yTXJzEh/cFvZQ1HoiiiTCKnSPGgyW2zNCmwpHYCY3uqaKj5IhlJ/68Nc
 4tc4QcsStprwoOUGFD16GMTGXRsqVac1svb4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264500; x=1795869300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=haAIv4NlvV2KsOLxgOUX6sTSJB1gz1CYLEQMibqpB9Y=;
 b=AChz7vqcOciCG9gRLl6Ulwd8rMxQU0yp0MJ3ATdZphgv1Pj6DReDa3oxzEwv2yc6cy
 +PPfho0NX4QHMOHM08NLgTvoOqPFSFF9om4dI60YiGJ64Z9vFqTTAEN+UW2yKLjx+G1B
 YMoR4wCP+WCwevG4HW3dbfdzjkKK9e69Wp/rRGtAL25HzgZqoeHTtnq5r1peqH5g33ep
 2BKWH9U+iEy+xcgS5rApxIhpxLkn3WqC6XsXvKdGUk4U6rmdknRnP/rmMYjfygowNqTB
 TFRAM/UUVYcNXdtaLvRvFMgmdN8vSNlqL+5ooun3rS2KOEFtNWFwdlLgLubSeTnREXSC
 wUwQ==
X-Gm-Message-State: APuU4Z/cwwEexkCcnCyfLywTrsfm5/z84wamnxISgGbLCWDk7DqUCNfg
 K/ey93KVHLnP3t1GSa0b1MFEn93uJn16vXwmCbfXACBfSCo3WyE+SlPLhJq0UKsAc0ziGIYJvCp
 N0K21
X-Gm-Gg: AZFdTZfgrQ0pGOQ/RszpXn2sVpa8RrkPlqGOE0E1qzhE1D1L5jC0K/FjUsR5TAPNNGe
 M5cR/q7ARm3eBbjiTy6tAO89EX6ZpmSazf9hp9h2LuS5jPdWLtfg9P3qFPOCFxWip8K0vZ4k7Hl
 R4uGn9Pwz8DBM9vD5AmZvoca0Y4D0UVPx5Scipil/+/7DTlE2xHGtSzdOQnrO3rrU8ttANKo3ym
 vtHtxlWEvAuG59+am57viRySdm+kW/ydflNnhvMIaZALaHXxIbzJVzYjTtWOxPpQyruHBSdlJGC
 sEVv37FQbypI8GcAmABdr1cRVgB77wVdfKQ1LmvP+Eg0ay81Q+a4Dac7/a11ZXSEcMkfwiI4b07
 ZIGh7FGkIfBa+HIGMJtkp7Znis+zoipHTo6td2Ke+DhWZ8QK9sE3wjqdJCZA0hGue6EhBLGTAZS
 B835hT0e2JMxodt7M3uyE3bbibeg654Sgefs+R/4YiF4sToaB8S9WC4PZy/URsknWT/TzJJ//Qr
 x5k3/SDyacOHUHRykkatb+CMJv3HEO1CB/fvSuoilrcDUzEUvIyML0HbMBfAzJSWD+Ab8SjsgGI
 M3zCMk5W2rXwcTzXNCVmsc84Qe5DNtf5qseNugnsw0pIotxIH+AmIGcr/PPEdlnVGtcwsCI27BP
 sfqySr2F+Oc8Khz+5SpZjv5PFTXFPpJWZzg36WGCuffmS72kLiGvlp6WtPG2DPCyTm4Rk0e4ewO
 yrOHgx6POF4VDEypE28lUfwYX5TA==
X-Received: by 2002:a05:6000:2484:b0:49a:94e6:378d with SMTP id
 ffacd0b85a97d-4aa5b41e24amr20026419f8f.30.1795264500043; 
 Sat, 21 Nov 2026 04:35:00 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:34:59 -0800 (PST)
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
Subject: [PATCH v2 02/25] clk: imx8mn: register the main_axi,
 noc and gic clocks as critical
Date: Sat, 21 Nov 2026 13:33:52 +0100
Message-ID: <20261121123451.2471185-3-dario.binacchi@amarulasolutions.com>
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

The main_axi, noc and gic clocks feed the system interconnect and the
interrupt controller, and must never be gated. Register them as
critical, as Linux does, so that their parent PLLs are kept running.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Reword subject and commit message to describe the change
- Fix the coding style of the new clocks

 drivers/clk/imx/clk-imx8mn.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 2dfa860bf375..56d44192e35e 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -29,10 +29,19 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
 					       "sys_pll2_1000m", "sys_pll1_800m", "sys_pll1_400m",
 					       "audio_pll1_out", "sys_pll3_out", };
 
+static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
+					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
+					       "video_pll_out", "audio_pll2_out", };
+
 static const char * const imx8mn_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
 					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
 					       "audio_pll1_out", "video_pll_out", };
 
+static const char * const imx8mn_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
+						    "sys_pll2_250m", "sys_pll2_1000m",
+						    "audio_pll1_out", "video_pll_out",
+						    "sys_pll1_100m", };
+
 static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
 						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
 						    "video_pll_out", "sys_pll3_out", };
@@ -67,6 +76,10 @@ static const char * const imx8mn_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "s
 						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
 						  "audio_pll2_out", "sys_pll1_100m", };
 
+static const char * const imx8mn_gic_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
+					       "sys_pll2_100m", "sys_pll1_800m", "clk_ext2",
+					       "clk_ext4", "audio_pll2_out", };
+
 #if CONFIG_IS_ENABLED(DM_SPI)
 static const char * const imx8mn_ecspi1_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_40m",
 						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
@@ -302,6 +315,11 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	clk_dm(IMX8MN_CLK_IPG_ROOT,
 	       imx_clk_divider2(dev, "ipg_root", "ahb", base + 0x9080, 0, 1));
 
+	/* BUS */
+	clk_dm(IMX8MN_CLK_MAIN_AXI,
+	       imx8m_clk_composite_critical(dev, "main_axi",
+					    imx8mn_main_axi_sels,
+					    base + 0x8800));
 	clk_dm(IMX8MN_CLK_ENET_AXI,
 	       imx8m_clk_composite(dev, "enet_axi", imx8mn_enet_axi_sels,
 				   base + 0x8880));
@@ -311,6 +329,9 @@ static int imx8mn_clk_probe(struct udevice *dev)
 					    base + 0x8900));
 	clk_dm(IMX8MN_CLK_USB_BUS,
 		imx8m_clk_composite(dev, "usb_bus", imx8mn_usb_bus_sels, base + 0x8b80));
+	clk_dm(IMX8MN_CLK_NOC,
+	       imx8m_clk_composite_critical(dev, "noc", imx8mn_noc_sels,
+					    base + 0x8d00));
 
 	/* IP */
 	clk_dm(IMX8MN_CLK_USDHC1,
@@ -422,6 +443,10 @@ static int imx8mn_clk_probe(struct udevice *dev)
 	       imx_clk_gate4(dev, "pwm4_root_clk", "pwm4", base + 0x42b0, 0));
 #endif
 
+	clk_dm(IMX8MN_CLK_GIC,
+	       imx8m_clk_composite_critical(dev, "gic", imx8mn_gic_sels,
+					    base + 0xb200));
+
 #if CONFIG_IS_ENABLED(DM_SPI)
 	clk_dm(IMX8MN_CLK_ECSPI1,
 	       imx8m_clk_composite(dev, "ecspi1", imx8mn_ecspi1_sels, base + 0xb280));
-- 
2.43.0

