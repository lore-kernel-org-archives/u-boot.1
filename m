Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB0606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yN7pWhnU;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=U5FSDK3z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41D140ABB;
	Sat, 21 Nov 2026 12:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6r4Y0YTm7IVc; Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A7D240E30
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264536;
	b=moPJlKYGLQjRQjCvURvx35mPFzLVw1G/9GGjgKioa7sqhFTckC5lbc7O1+BGajWfl5jV
	 8qVzgc/yLAahEJWF5clUSGJdlvJcoa4moZriEMYMIj98LuvSiziuC+WPhsSFWnjbV+LP6
	 2YGGUNtKOwWPt3xz/s+fD6ck2hS1KxdxkmpX0n/SLKBmB7AU3LmsJH66p42YOqxCIU6m6
	 Qwnl1wTm7V89z86TrXnUW1mw/USThHbCjbUoUnXcF55KIpz8D56eAkkYcmokXT6QEdTS7
	 lA0XTg9c0xJE03dDaMPhmZWcM1g/beubUXj6vmwiHjYTAWMyQ+ZL8g8Km10r0pENOxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=j1HCAYoYh+vqUm2c3fTDbTb0oiKPVG2Nfb1gIHjtQYY=;
	b=hD+h9ZJfKNaredf+gvO5lz2YguDwkTo18fZLsOXU5LOkS/5zFXo5Pe+L2eZGtym0DaKu
	 sUanc8a2A3xegMFpnWHTgSZsfx92fk23wYpdWgxAbD0AW/TQ7wRcFAvoc4F3ltkp/ceXn
	 AgPAIoFqEn35Y3oLsnmG4QPz7ryATeev2RZm0z2HMEaTpQxtPFcodVfe/m4ahtw08AOhv
	 QewsX+k+9VwWHxWR3tGNXEh+0wNKETsbSAAqpMpy37bdpv8PoXGj+KOyWn8HehmOgrR+X
	 SH8ZBK/63W7UP+efXhZsl5JT56X8eOTdL/oAzAYqiToS7mbzPgtcdJrA3cMtWsRDWBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=U5FSDK3z;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264536;
	bh=j1HCAYoYh+vqUm2c3fTDbTb0oiKPVG2Nfb1gIHjtQYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yN7pWhnUHoae0JQ8cuTscjGbu5Z0oXUEgP6aue0MfhcrwUQXgFG5yS7J6OusQ03gS
	 MHVn4H6oAwAY/OcUKr3t5hEf+UZJ5lDQ08SWC3G7JahshA/76XuVDCzf6u1iOHeJzU
	 LdBp5cEhjE6jt5e8wrK+KUTXIWuWce7aIjCOUBM3Ve750uZxbIikyiyoeJMwM1L1vE
	 EACJ1hMqBE3gkY5y/3iGyLMTPTGJeSszt4Skp5zgML+WwSVBpkr8hxDjxZ+P1Bi8ca
	 ADki+SMZqUMXlvcrQNbDqMQ/tpn80++gIJUABOsF8GY/+8MNYCYWpa3E6+BNkDo+/C
	 DqaX8Ir/CdxRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A7D240E30;
	Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C20C9C1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1CC9D40DE7
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0K94qhMq3Yyq for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB2F0407CF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=U5FSDK3z
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB2F0407CF
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:24 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso973966f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264523; x=1795869323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j1HCAYoYh+vqUm2c3fTDbTb0oiKPVG2Nfb1gIHjtQYY=;
 b=U5FSDK3zuScvtkmuuNdz3IY3a7SHD1xsOkvjNqzNphdOS7QhTP9NS7hZxwYIrU6Vz5
 KDoVdYx4gv9IMgTfru7beuHGeT6mSL+UTQv3fkHnphdW2qY+ImxWVgpvMYd5YltZhWXb
 uRiguktMhKWPxxYjkrAwlB2EHRs1h3sBeYWgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264523; x=1795869323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j1HCAYoYh+vqUm2c3fTDbTb0oiKPVG2Nfb1gIHjtQYY=;
 b=RNoDQmuoYqOKPlys4h2sQ/FOOSqc8ydhKbsJ75QGcMdGy4LkFlNevQJ7LHDmUpoFCh
 RqinGwf/mZxfP1T8OBXOhtlpIFCN75cayo3HAr5KrLxA/yZ9AMawvwMneaaJJkIFIrEu
 JHzh1NjI+DwpYskUMF5xS4VLXuT09aqIzGZ8NmURgYAFlgYSeao6eHIPU/iEhyhbl3kt
 KQjcOaNMnxJfaHQl5X3ATIcqCChRG5Nzs9WPkwunY/1SQVD1sGtRWWWcl4M1Q3Oscx+t
 Yt/gQgQAX/A+mECOr/CYGJJ5Xo05rXDZx2Gfdy3SecKKxvckyOkItFjvILIU8Bid57my
 /AQw==
X-Gm-Message-State: APuU4Z/0exG7axlw/78kvCAIv1T77qcpYdyMFuW0HrmNEzCC1xJ6a/0m
 ckqra5P9KQb/iFYJ7HaCfFiXUu43XzZjRcHWOYfDch+dDus1BEOBcEA4lSwbG7975c9iOE06jyV
 ZIvrv
X-Gm-Gg: AZFdTZeHg0dd9Vqo+KIKSX9lKHBaxz5n/TGoockjrz01O/wu1LTp42kIj3QS+5/qWiQ
 SDBwrfNupzRlFK0MVF37tTdAPZePn6C3QjPD8o9d4c32nnvoU4omUfJxQq2WF8Zx0WVhQ6hU9Q0
 tuMx+pAW/RAmFb/uIUx8iTZaumz63/F4xBmgYjnOrpj7hT1PNwMj0uPQuj3X+Y27e+qpSPUsO/V
 BX5POvS4U16pmbxlEpVS3VZMfl1P8BH2IzPmZZQ1P/YaOE1rKwS1EgWEQsuUUmeYuetvIKCE3BY
 0T5XXSlBo4HS++KOR+6izjksnls198F9h29lGoKafPcMHFtvMvdjy0gF5/Zw2GfiyQHt+IdqR22
 9qQAdcmIVF6SU5u8ar3GSu9WNCmk7EHCBlAqhCKgNryutm2SgGI6prRMMqMtE7vQrd4vTG8A3kT
 Ckz4+ZSpmqtaoEV771XOFx5Y0fZRRRaOuLVf1kwkshuTYXp6dkVzJTjAEDXvFbttxHzfmdKAaaP
 eaWK28UzV9pw59Zvyiyq/TIi2IrjIfQdUQyr+5fb0NUwLdHUnHMytiMWluuhUM/819GHAh+cIjy
 7hYXep/YqtfNkpMY7csKU+deYKP2UrBLIDMN2MHOfsF1ZQVFo1JTt27ljCdXJjuLIqbjvtGVCKu
 SX9r+kit3uEDlCO0QQOgo38r4VZeNIu8TKG6z9qK6PuKuDXfseOmznlAT/YzygQIXmowYhWYzUW
 yhR60KpAKkTuxIsNOu0uyGBZBA/Q==
X-Received: by 2002:a05:6000:4807:b0:490:39ba:4359 with SMTP id
 ffacd0b85a97d-4abb19c16f4mr11212622f8f.23.1795264522788; 
 Sat, 21 Nov 2026 04:35:22 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:22 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Marco Felsch <m.felsch@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/25] phy: dphy: add support to calculate the timing based
 on hs_clk_rate
Date: Sat, 21 Nov 2026 13:34:04 +0100
Message-ID: <20261121123451.2471185-15-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Upstream Linux commit 22168675bae7.

For MIPI-CSI sender use-case it is common to specify the allowed
link-frequencies which should be used for the MIPI link and is
half the hs-clock rate.

This commit adds a helper to calculate the D-PHY timing based on the
hs-clock rate so we don't need to calculate the timings within the
driver.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/phy/phy-core-mipi-dphy.c | 30 +++++++++++++++++++++++++-----
 include/phy-mipi-dphy.h          |  3 +++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index 8fb985a1e682..727c2b040520 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -13,21 +13,23 @@
 /*
  * Minimum D-PHY timings based on MIPI D-PHY specification. Derived
  * from the valid ranges specified in Section 6.9, Table 14, Page 41
- * of the D-PHY specification (v2.1).
+ * of the D-PHY specification (v1.2).
  */
-int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
+				     unsigned long long hs_clk_rate,
 				     struct phy_configure_opts_mipi_dphy *cfg)
 {
-	unsigned long long hs_clk_rate;
 	unsigned long long ui;
 
 	if (!cfg)
 		return -EINVAL;
 
-	hs_clk_rate = pixel_clock * bpp;
-	do_div(hs_clk_rate, lanes);
+	if (!hs_clk_rate) {
+		hs_clk_rate = pixel_clock * bpp;
+		do_div(hs_clk_rate, lanes);
+	}
 
 	ui = ALIGN(PSEC_PER_SEC, hs_clk_rate);
 	do_div(ui, hs_clk_rate);
@@ -74,6 +76,24 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 	return 0;
 }
 
+int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
+				     unsigned int bpp,
+				     unsigned int lanes,
+				     struct phy_configure_opts_mipi_dphy *cfg)
+{
+	return phy_mipi_dphy_calc_config(pixel_clock, bpp, lanes, 0, cfg);
+}
+
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg)
+{
+	if (!hs_clk_rate)
+		return -EINVAL;
+
+	return phy_mipi_dphy_calc_config(0, 0, lanes, hs_clk_rate, cfg);
+}
+
 /*
  * Validate D-PHY configuration according to MIPI D-PHY specification
  * (v1.2, Section Section 6.9 "Global Operation Timing Parameters").
diff --git a/include/phy-mipi-dphy.h b/include/phy-mipi-dphy.h
index a877ffee845d..1ac128d78dfe 100644
--- a/include/phy-mipi-dphy.h
+++ b/include/phy-mipi-dphy.h
@@ -279,6 +279,9 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
 				     struct phy_configure_opts_mipi_dphy *cfg);
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg);
 int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg);
 
 #endif /* __PHY_MIPI_DPHY_H_ */
-- 
2.43.0

