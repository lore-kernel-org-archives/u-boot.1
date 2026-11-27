Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589F0606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QajfkFvp;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnKi8G4Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D037A81325;
	Fri, 27 Nov 2026 18:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id neAWODK1h5an; Fri, 27 Nov 2026 18:00:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E143F81316
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795802426;
	b=YECN0F+d6fSnhoMYA8wttlvguCUtcaxdouHa88ba7OQBRDg2u6DcBZHllSGbedwbBukW
	 a/O6C8bh4fe0TmBiv+0fKo8N4hWx7vpWbfzjz1fPYl7Gqjwh2ap/QXhJJAZbnRM4YJioH
	 qj0/f8ZUNab3A6dwzievfr5K3e8M6Ra3tp2kSNV7hQShwnX0aoTMxm/8iR+hlwPcEmpyQ
	 WP0TDogOefIQpIUAvT0lP5g247wpj5toNeeHH9kIkt6kavoq4hhazFnbUlwCDVEgJJ2RA
	 LBFFVvZ0Me8Sl1qHO0yuHrg64PDTZx+jtPerffpQh33TcWwps1g7OKtVHhNHUH1i+aA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795802426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m9NAn33astKaI4977c9tK1/TyDo/41VznUsUhXBC8Xc=;
	b=YXVyRC/FREEQsY2TLhLGy9BsrU0MfAt8COns546T5sYJbHu8GkWK5ELuN8eKlRJLJKNv
	 gLfCbSTbEcZ2inn+vkZEhO02X6eEVsbB4LxQMNaxx1/RM79h3o1qv4WXpUHlA7fnldxYm
	 okw/TMYGob1Ad2LkhG040Mo9YzLLS9yQjTE7AnsTC5X9g7xX6E6P0qHYvx7zxpJwwKbEJ
	 3mfWGKGk4MQG6QeJlORIru78RfRJx4YS5BWtQpy7IOOdvYnjv8bQM9zBudQTAr7z1J0ip
	 g8fXSSERfd8XP+Tu57TtvveGYdwaMBlcg6LoWNiNAFMsRVcoxq6rXk1kPVRpCDZYGUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795802426;
	bh=m9NAn33astKaI4977c9tK1/TyDo/41VznUsUhXBC8Xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QajfkFvpYYlzbrac4ckjshyElfBQI0OBxMfapCAgduQ/4rIi6aYOfnnDHIUEqJ5av
	 zW+cMHMYhjaVpGB8Y41WQgSolbazZvJfYOT5Bwe3KJ4oa49k4QtqTK09qOwqK5/N8b
	 TZgsrCjG2zokkhe1eY9nQzpakyltWrh7z6gaJzNcKZDRgfwqs+SvU2rtpNyppDKPSJ
	 QTzOEGRgEZKxqlUu3cPG2CQ+esUMtV8cFytIzay5iYuIMCiL+edJvZpsowJMnq+MIx
	 T06D5qWdwLku7Rrm4Zm0cCT5AaH+FJQfkj+NVCj34wNA4l8E8892/o/hHzrv2K/m0j
	 5G+X5Jk/wHN3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E143F81316;
	Fri, 27 Nov 2026 18:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD0163D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F121409D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8TQzLCPWLR5 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:00:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 937B2400BC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WnKi8G4Q
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 937B2400BC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:00:19 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so55105425e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795802417; x=1796407217;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m9NAn33astKaI4977c9tK1/TyDo/41VznUsUhXBC8Xc=;
 b=WnKi8G4QhciTMqLXjQ5d/RBZg72H47WW5WIOwysbg8Q5SFnRdqXkZV8mXs0H0fmAYp
 Bya43mmskI3sXtQDSN2xwcaDnyLDWMJiIXU6wK5ZdUq+0TrZAyr1K64jkd+F0ogVkoAx
 rC+mmWz2IxquEqHcG65kmby4IraQrPp71JvEAp6o0FUaWnashsfs9uf5YyoQkZAl9VpU
 c+eL9xuXGjQ9fmm6aXgBg3heDQoXlzO1NzeFMhGbGmrY+RYabUHhCDrSaqtZH+LfXWe1
 0FNJYMOJiNVNVUds/Tr0XIdNnXlhV9yZY7LrfIk1hG7omZ8fuWsX4NIx/qoxLTzxtCtI
 sSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795802417; x=1796407217;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m9NAn33astKaI4977c9tK1/TyDo/41VznUsUhXBC8Xc=;
 b=Xny5Gwlp34F5J+Gbn3ofJqIymTWnfjwwdqxCR0KR0BdXC3KXryCcvWJhu3gayVEacp
 Jk5/tsHRA7IalmJTDGtZhAJxnKuza6s6EL8Fquh4xvFuGaLRKLQKdVdFoh7E7CrDLPhI
 J+foi5m2JM07Fj0wP52eEkj5BByotJooM+empw6T9S5SIXEzoc6X1I8PNTdgAvMVAQtz
 Lo1B7PUjyrSfPoCzvi/XPs4pdiE2ibHAlJmEbhva1hQ5w+HprF4NaPBl3XFnajvq1N8i
 TbAS21OWcd8PiKfC53Khf/k/FUIe6znsXpt2/qXNcsC+Rsgj0pFcN3C+tuEzRgW8a71N
 6liw==
X-Gm-Message-State: APuU4Z+etjW3GMXQ/Ncq8EezWQ4TxbaHzwiD+ZXpUVU7boR1nXXpMASa
 re0uymXo3WvpRmU80K0olCXQ4YVX2TCTRXYZG4T1NGnKJJU99/rYydkhfsR3DQ==
X-Gm-Gg: AZFdTZfKYfbPjwOxULHnYl7SkhJOYzEwnVOsecaf1LfUB1Br5cEG65wIaooCBjqXSxQ
 /VL0StT7Q66CEgXuOIDQo166uOCu3RfnJd3LqeCge+uP7dwRCPFM4ULNEz6zbmMdQI0PQgmY6Na
 yx9d7wEOMjDEb9koc1Uy5qID28owD0Ej4P9Oeoy5btgV70ZMAacUCYiYvTyGs63al5DsvQcY6T4
 GA1iqtpH66s3hlRfwt9owtw08ZMwPD9ir4lOdo6UbdUA3ZP5AhBf9mMDLShFjV/eb0jicZKm2+v
 i73Bhq+RCl9uyWRfgXZ2BnpNDeNWTh5ySjPvZlwoSPbqyu0jUBrLEziw67apMcqnIemfX5RsflD
 5NLqk3FPUUIQ9LHXgfUhraueVVQfvCUv48ueA4ntR5X57nO26s20wLmfiJ1BCuy/XuoghJpAesD
 3jlwUQJpc+W04fo/Mqz2pl67/GHMYRu1hR71UsSMON6DkvqwSzIxRYYenQuhD2hC9Iqx6BEoLRt
 2Wb+8THUffEB3hrgItZGt/OL8jb0Hi61VpYATLphWB8vW3xunPlQ/noxBA4P6EcdEbfP9h1Quku
 FuljldiqwljuuSDywza/EfHpzXbDBElgEOzljkMj
X-Received: by 2002:a05:600c:46c4:b0:4bb:6a5a:7834 with SMTP id
 5b1f17b1804b1-4bb888106damr531212125e9.20.1795802417211; 
 Fri, 27 Nov 2026 10:00:17 -0800 (PST)
Received: from [127.0.1.1] ([151.71.203.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm695638385e9.1.2026.11.27.10.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:00:16 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 27 Nov 2026 19:00:11 +0100
Subject: [PATCH v4 2/4] ram: rockchip: add DDR3 SDRAM type config option
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ddr-multi-v4-2-c66608f3e06f@gmail.com>
References: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
In-Reply-To: <20261127-ddr-multi-v4-0-c66608f3e06f@gmail.com>
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add new RAM_ROCKCHIP_DDR3 SDRAM type configuration option and drop the
PX30 RK3399 and RV1126 SDRAM drivers' fallback behaviour, which consists
of assuming DDR3 as default type when no RAM_ROCKCHIP_XXX type config
option is selected. Instead, the drivers code now raises a compile-time
error if none is selected. The default value of RAM_ROCKCHIP_DDR3 is
true if all other RAM_ROCKCHIP_XXX SDRAM type options are false: this
preserves the overall default behaviour avoiding impacts on defconfigs.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 drivers/ram/rockchip/Kconfig        |  8 ++++++++
 drivers/ram/rockchip/sdram_px30.c   |  4 +++-
 drivers/ram/rockchip/sdram_rk3399.c | 14 ++++++++++++--
 drivers/ram/rockchip/sdram_rv1126.c |  4 +++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index fc948e82993..0d4470c8ede 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -24,6 +24,14 @@ config RAM_ROCKCHIP_DEBUG
 	  This is an option for developers to understand the ram drivers
 	  initialization, configurations and etc.
 
+config RAM_ROCKCHIP_DDR3
+	bool "DDR3 support for Rockchip SoCs"
+	depends on ROCKCHIP_PX30 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126
+	default y if !RAM_ROCKCHIP_DDR4 && !RAM_ROCKCHIP_LPDDR2 && \
+		!RAM_ROCKCHIP_LPDDR3 && !RAM_ROCKCHIP_LPDDR4
+	help
+	  Enable DDR3 sdram support on Rockchip SoCs.
+
 config RAM_ROCKCHIP_DDR4
 	bool "DDR4 support for Rockchip SoCs"
 	depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
index 37e62120504..0b6d3723409 100644
--- a/drivers/ram/rockchip/sdram_px30.c
+++ b/drivers/ram/rockchip/sdram_px30.c
@@ -130,8 +130,10 @@ struct px30_sdram_params sdram_configs[] = {
 #include	"sdram-px30-lpddr2-detect-333.inc"
 #elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
 #include	"sdram-px30-lpddr3-detect-333.inc"
-#else
+#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
 #include	"sdram-px30-ddr3-detect-333.inc"
+#else
+#error "Please select a DRAM type via a CONFIG_RAM_ROCKCHIP_* option"
 #endif
 };
 
diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..5bc6f3a39fd 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -26,6 +26,12 @@
 #include <linux/err.h>
 #include <time.h>
 
+#if !defined(CONFIG_RAM_ROCKCHIP_DDR3) && \
+	!defined(CONFIG_RAM_ROCKCHIP_LPDDR3) && \
+	!defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#error "Please select a DRAM type via a CONFIG_RAM_ROCKCHIP_* option"
+#endif
+
 #define PRESET_SGRF_HOLD(n)	((0x1 << (6 + 16)) | ((n) << 6))
 #define PRESET_GPIO0_HOLD(n)	((0x1 << (7 + 16)) | ((n) << 7))
 #define PRESET_GPIO1_HOLD(n)	((0x1 << (8 + 16)) | ((n) << 8))
@@ -1632,7 +1638,9 @@ static void set_ddr_stride(struct rk3399_pmusgrf_regs *pmusgrf, u32 stride)
 	rk_clrsetreg(&pmusgrf->soc_con4, 0x1f << 10, stride << 10);
 }
 
-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
+	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
+	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
 static int data_training_first(struct dram_info *dram, u32 channel, u8 rank,
 			       struct rk3399_sdram_params *params)
 {
@@ -3068,7 +3076,9 @@ static int conv_of_plat(struct udevice *dev)
 #endif
 
 static const struct sdram_rk3399_ops rk3399_ops = {
-#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+#if !defined(CONFIG_RAM_ROCKCHIP_LPDDR4) && \
+	(defined(CONFIG_RAM_ROCKCHIP_DDR3) || \
+	 defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
 	.data_training_first = data_training_first,
 	.set_rate_index = switch_to_phy_index1,
 	.modify_param = modify_param,
diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/sdram_rv1126.c
index b371f597d23..2d101d6af3a 100644
--- a/drivers/ram/rockchip/sdram_rv1126.c
+++ b/drivers/ram/rockchip/sdram_rv1126.c
@@ -83,7 +83,7 @@ struct rv1126_sdram_params sdram_configs[] = {
 # include	"sdram-rv1126-ddr4-detect-784.inc"
 # include	"sdram-rv1126-ddr4-detect-924.inc"
 # include	"sdram-rv1126-ddr4-detect-1056.inc"
-#else
+#elif defined(CONFIG_RAM_ROCKCHIP_DDR3)
 # include	"sdram-rv1126-ddr3-detect-328.inc"
 # include	"sdram-rv1126-ddr3-detect-396.inc"
 # include	"sdram-rv1126-ddr3-detect-528.inc"
@@ -91,6 +91,8 @@ struct rv1126_sdram_params sdram_configs[] = {
 # include	"sdram-rv1126-ddr3-detect-784.inc"
 # include	"sdram-rv1126-ddr3-detect-924.inc"
 # include	"sdram-rv1126-ddr3-detect-1056.inc"
+#else
+#error "Please select a DRAM type via a CONFIG_RAM_ROCKCHIP_* option"
 #endif
 };
 

-- 
2.34.1

