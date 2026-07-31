Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6407C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18A5480E5E;
	Fri, 31 Jul 2026 16:36:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCBvs-VU7Kbm; Fri, 31 Jul 2026 16:36:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 923CE80F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515760;
	bh=a1fra90j2IW8Hdb7vDpot23gmlHCXRleR4+W0aKrjUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KXYAUq6aV11wX2bzG0JIrKV4c4d5rqn3N7bOZKllOwMW2I/DY4SBHeNohXkLXe6v+
	 IRH9Fy5WKzrOFpXGJha1bqa/FpMPj+LyfQ9YGHtdEiqHOfMnGShFzrY7pqt8utoA4J
	 W4FkTG01wy/UsHS6gbdvny6XZbaGuZoUnFhhj6BDEOrJzObYN6f9zZ1ROeeofx+/AL
	 iwTJGloUtfOi1gGL2KtfZ/22pE4eOP2y+5J83D9gywPV7da9/JQ7KbHZyOV4eSl6fB
	 AZvkikPuz6lvzsjCLW7cVrsEYuRr11PSDz/RNK6WeA/rOJghhZ9Q82Uh8l4y4renan
	 FmNLbO9ch7kfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 923CE80F52;
	Fri, 31 Jul 2026 16:35:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16B1337F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F072180D1A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZRuxmepI5xX for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 30F0580DC5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30F0580DC5
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30F0580DC5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:10 +0000 (UTC)
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-754ac74c495so415014137.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515649; x=1786120449;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a1fra90j2IW8Hdb7vDpot23gmlHCXRleR4+W0aKrjUQ=;
 b=hYr97rqCJXHUvbpsCS5vpGmot2NbXqGDVJmLFqYqscmq0hTxzDqhcGQU3GODRQqrTV
 xrlnF+emhQSaFcUOyb96JFcMpBSnwzBeNHdN6JWvmdJU+kV6Cisz9KaUs6JZT8JOZVtK
 GjRZvcTAzH4s5uKijvcAbUOeahwrHgDXffDr2VqHXQfwX+YflLwNoajIJZ05taLQjgai
 6RH1OAypsmr9YZ97kNlO7vUN8P0XhoJo0RzIAVfuRp6Dducyid5i9O1pX5GZ2JEFED+d
 w+rUGP1zngN5LbtoOvYvCOk4JiRxZXgUW40Abdmr0BzyxBsbgL1W9SfW2vKr5yh+hEHH
 HISA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwdz5U8Sdr+DELLAvpDAYmWT4rmhBTSPD0I+lwghS4QgPy3oMlLbJC9CvpZ5AUh2C2sqd9+ec=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzubIWdV8IJ8geuN5ri1wPLZMD8dBlYfMoi1Ewx6Tpr/E0bo0c4
 HCwubF0t97OE67Q5jtbZdD3Orfw5/IfeTXRw1g2LzZiJuJFfvr6Gp15jIAofMOjhKdg=
X-Gm-Gg: AR+sD12IjYnHcYONRXyrkmDX8OR7pa8zEgBcF+W6P4uE44GOkNnEHLiIu8srBNX8bOc
 xlTqE7biSXHLaxuZRKtVNL8LaZ195Wc/uOAyBBIT0Wg+etxKNbtgmdmNV7jhyd33qNBpL1vPMDW
 frP1aaOx5xAtptyVUEg43qmppk8U7oojex8LHvlAkLqrv3Yb4Rbssq5TeS72+7QBY1/qnChp57o
 G2807bpp+BXkYTorIqSZd07Bk21FN5mgccEM5jVvKOAZKg+s9Pj7ktRjlaKrHptS59gCG4FBeyO
 04cG+GrT2ivCZ+L4fDU6Bi6Y3vcEjOS6kN3sWKayFt9PEmTgEnulvOkCfCkIGKVxuKLV9NqVKeJ
 YnqID2fPTDalRkJeIUXTIaZ/YO6oS5ADfiW6LlH3S+KymfKg63vqljAp8OEBotbzaKeZN7TdgIE
 RpyNrKOwuTITiH4KvmcpFH5KFKY7k5SwDuUiy0tLsPfBAiEsAPVcE4T5TpgiEeeN0Rm8va2FvYi
 pjptFRjAESoFOiVhjqDAw4SGfHgcCsREoPIgEZNhPfHkhteB+uDzVUT6+Ih3IfyMC64Z5Q=
X-Received: by 2002:a05:6102:3749:b0:729:65e:f08c with SMTP id
 ada2fe7eead31-75b1e931611mr856918137.0.1785515648625; 
 Fri, 31 Jul 2026 09:34:08 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:08 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:37 -0400
Subject: [PATCH 08/17] mmc: zynq_sdhci: support Renesas RZ/N1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-8-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=3738;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=K2nAkWeI5QAgzwymq0eFNPvd3XXH2M2YfdZ6mUZZds0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAtcEUAKOGrcVDxvS4dladWCWtbBf9/7PFNI7hj/mNDIoTsgBhwAdkb2qBEXedhwCeMS5Mig60r
 djbC/1VcEVgs=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515649; x=1786120449;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1fra90j2IW8Hdb7vDpot23gmlHCXRleR4+W0aKrjUQ=;
 b=YrkbUUnk0L0R2OKWr0hXK3Wum3R3vWCr91slNp+peN6vVduH2+aoftZI6zCV5fSFXd
 7ZJxH6bsX01Gkefy0D7A2mnzF36QJIlpBY9IdwNZ+r+wxfYbJXTvHzCV5+0sYAH1RzC4
 3spqZP8/+8xgPycsPH7C+113J/MvQRdEwnlVGH0eidV/R5rm7bz9qjOhaz7Rw0WRne2E
 S52AwBkzp+Qxyubl4dszzz22bQcQlwa+OlUHlRvxtWdNhCU2F+26afem0fKHGfx8svQh
 Oq97fhXzv1GOyx1LGnIn8Au+qYKX7WKNr9DafqxFtid7xaNts31pYiEF+1rcrM90gjf2
 RPUw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YrkbUUnk
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Renesas RZ/N1 SoC contains a MMC controller using the Arasan IP.
It is supported by the exisitng driver, with the following changes:

1) Multiple clocks need to be enabled. This is handled using
   clk_get_bulk() and clock_enable_bulk().

2) It is necessary to defer the sdhci_probe(), similar to what is
   done in drivers/mmc/am654_sdhci.c

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/mmc/Kconfig      |  2 +-
 drivers/mmc/zynq_sdhci.c | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f9f7aa5cf97..7649fc8f53f 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -778,7 +778,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
 config MMC_SDHCI_ZYNQ
 	bool "Arasan SDHCI controller support"
 	depends on OF_CONTROL
-	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on ARCH_RENESAS || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	depends on MMC_SDHCI
 	help
 	  Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs platform
diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
index eda95b72f49..351e7d56569 100644
--- a/drivers/mmc/zynq_sdhci.c
+++ b/drivers/mmc/zynq_sdhci.c
@@ -1012,6 +1012,31 @@ static const struct sdhci_ops arasan_ops = {
 	.config_dll = &arasan_sdhci_config_dll,
 #endif
 };
+
+#elif defined(CONFIG_ARCH_RENESAS)
+/*
+ * It is unknown whether the IP in RZ/N1 supports these clock phase
+ * adjustments. The devicetree does not include these properties.
+ * So this is a no-op for now.
+ */
+static void arasan_dt_parse_clk_phases(struct udevice *dev)
+{
+}
+
+/*
+ * Renesas RZ/N1 needs deferred sdhci_probe(), otherwise the
+ * first CMD_00 fails with "Timeout for status update"
+ */
+static int arasan_sdhci_deferred_probe(struct sdhci_host *host)
+{
+	struct udevice *dev = host->mmc->dev;
+
+	return sdhci_probe(dev);
+}
+
+static const struct sdhci_ops arasan_ops = {
+	.deferred_probe = arasan_sdhci_deferred_probe,
+};
 #endif
 
 #if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_ZYNQMP_FIRMWARE)
@@ -1110,7 +1135,7 @@ static int arasan_sdhci_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct arasan_sdhci_priv *priv = dev_get_priv(dev);
 	struct sdhci_host *host;
-	struct clk clk;
+	struct clk_bulk clks;
 	unsigned long clock;
 	int ret;
 
@@ -1152,13 +1177,13 @@ static int arasan_sdhci_probe(struct udevice *dev)
 		}
 	}
 
-	ret = clk_get_by_index(dev, 0, &clk);
+	ret = clk_get_bulk(dev, &clks);
 	if (ret < 0) {
-		dev_err(dev, "failed to get clock\n");
+		dev_err(dev, "failed to get clock(s)\n");
 		return ret;
 	}
 
-	clock = clk_get_rate(&clk);
+	clock = clk_get_rate(&clks.clks[0]);
 	if (IS_ERR_VALUE(clock)) {
 		dev_err(dev, "failed to get rate\n");
 		return clock;
@@ -1166,9 +1191,9 @@ static int arasan_sdhci_probe(struct udevice *dev)
 
 	dev_dbg(dev, "%s: CLK %ld\n", __func__, clock);
 
-	ret = clk_enable(&clk);
+	ret = clk_enable_bulk(&clks);
 	if (ret) {
-		dev_err(dev, "failed to enable clock\n");
+		dev_err(dev, "failed to enable clock(s)\n");
 		return ret;
 	}
 
@@ -1239,7 +1264,7 @@ static int arasan_sdhci_of_to_plat(struct udevice *dev)
 	priv->host->name = dev->name;
 
 #if defined(CONFIG_ARCH_ZYNQMP) || defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET) || \
-    defined(CONFIG_ARCH_VERSAL2)
+    defined(CONFIG_ARCH_VERSAL2) || defined(CONFIG_ARCH_RENESAS)
 	priv->host->ops = &arasan_ops;
 	arasan_dt_parse_clk_phases(dev);
 #endif

-- 
2.55.0

