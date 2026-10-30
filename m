Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654E606A33D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UznwFTTk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EF0740AC9;
	Fri, 30 Oct 2026 08:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCLwSZ3hOXsL; Fri, 30 Oct 2026 08:08:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A13940AC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793347682;
	b=ZDrc9fokPqsDRnIczbPQfKG43kErjmA2FHDZWzAk6vA85tKMNe3VN9Xf3inZpbhlN7cF
	 3Uq6n6bffDLPAyXbxNQR0Ao+zpw5cfeKLBFuI3BQh0cn5MK0JkSgJoqj4gN23XkqRHlx3
	 jrb06UrzcOLthZcpUby7uFtAQRra7jsv099wZGpB4CSg3wT7fN3fUkkNvKnsyZKTv42n5
	 11A/SWXg84ojdmSp1CFmxU+hWtvbaqF3Qe2D/zyyOhhPf9Pa6DnsBmTUGChK/5Mf3t0N1
	 VJqrbCpvsh7ECkM9ppyPC/kxFQTp0THRaOHdFoHfgQpxpWlqbMeRjsv2aUz17zvv5UA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dERook27kB+rG45EdqQwn1ZvV88FwLUxOy+2vdmkOxs=;
	b=q5VHXtzusei3akZCIkFWF4voOCjj+F+qBOdMsnFQtb2cvZfEExsv0JYr60VWWKobVovX
	 k+l4BUbe2JdLIQx1Xm3WM7GEy4w99pgw9TCq3fxFlvb2vrptXwDFiLXW8bYCXJY20Ygh1
	 aCNJVuX3AbHgLNRByMLLSGE4OecKl31P3KwdWgkES8qLGOXtLdfsangnr6UjHsMdebGsB
	 bjgXq0/u0akcdgppAtYaGv4hUwx2y+bWLuVR5AQlTXUcfPPwQqpARthsatiPoYzBVSTJl
	 oyObjz2k8H3hvzjkgg6dwglJpZu+iS5gztAaO+15xUF4vYtFagW5CF/nw0Bi7Kf1Z1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793347682;
	bh=dERook27kB+rG45EdqQwn1ZvV88FwLUxOy+2vdmkOxs=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UznwFTTkvITb8/mosP7WVdvQsn7DfOZ3uSvXvKnGFbQ6TqOIvzUOYtsyCoFATJ2Zd
	 sN/oiT1EyjH16rXhkyI3dLQMfHlWPulgJJJ4JUHlSDTPcea6aoRSGNaGtSD1PMB+nQ
	 fX8UriLe9FlzFLx57JdjUuth0vjjToAzW6MHXzIEA7fy1YYW4q8lqpLMsbIUE8ZXR1
	 tAjQijeAie5uDUZQAbHG3EUlVA+9SU7zdCGEJ1tMfrcZGmQYd7vWo9RoTahZb1eA23
	 vGPzLEFlqby/bekUy+mlLPPj/n2memtcDD7MFq+wrOdEJfZaCYVh8t0s2Cx5+4KG0T
	 TzFsRebVwCdNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A13940AC1;
	Fri, 30 Oct 2026 08:08:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E251B2AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D42D940329
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:08:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAr2Qlk-QNcP for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:07:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 22190402F6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793347679;
 b=s0cgIo2LGFL0pdaDhWm2LoWm/Y+fKoIDj5F0JJWbMdoN19FYW3eYwM+aNjnAHeQ4wImx
 MuXWyYJSaj9uLeVlHLGbE4Ex7m0SjbGqDujLAbrwNUYPT1YUlo5o44wMpBSwx5NppRcYI
 Cn+wZTLFPgR+Kx6/i7aIJzqR6DNOTPBWfVYfQ3Wc+rA23mdnaQIlde2sfifcCC9N3LwZ+
 6NQEik3wGSMNgvYSy2HNXwfdw37E9aKATjHAr17ZdvllIJ5VGrpXiJTCDvXO4f24bQOKx
 G9wugrjqxkCalKgoD86de/iik7sYRicodUVDS8dR5OvL+bHooqDzj7tWON6O7owdAQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793347679;
 h=X-Greylist:Received-SPF:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=dERook27kB+rG45EdqQwn1ZvV88FwLUxOy+2vdmkOxs=;
 b=cWpvp24SeGCiZx4WALxpX1M6ZTAX5+Q/E4MYorlvhm/S31gUghQ0R393Fa3Q08x1ueJ1
 6Q0IrspkrakRtXyD7IgqahSS9RwKXEfMkLV+o6/DxSeMNqrT/qCDgHa+b0wBuAcV7QZAt
 xax9D4xW1GhXMtPw3rPgv4jcYHENl/2jodA+mpr6Jc19TWmR/z+pPgsAvwjB0/iJVs7/y
 k5SL+SDmMgA99zCdX/u0KOIJoRSy9DNNxU27Kmygl37sLQPr7BPDSZ9AAZ/WSleqpTdKX
 JL9qTvgNXemLa/YXCPi68EhJaBW7ZKbm0pD9uf2w0scUMD0AfC3VmbRIInqFjRrCcTA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
X-Greylist: delayed 305 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 30 Oct 2026 08:07:59 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com;
 receiver=<UNKNOWN> 
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22190402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:07:58 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 30 Oct
 2026 16:02:49 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 30 Oct 2026 16:02:49 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 30 Oct 2026 16:02:49 +0800
Subject: [PATCH] arm: dts: aspeed: Add AST2700 pinctrl device tree nodes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261030-pinctrl-dtsi-v1-1-88beede3e56e@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAClP5GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2MD3YLMvOSSohzdlJLiTN20ZDPDxDRDI0tTCxMloJaCotS0zAqwcdG
 xtbUANqfav14AAAA=
X-Change-ID: 20261030-pinctrl-dtsi-fc61af129584
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
 "Chia-Wei Wang" <chiawei_wang@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347369; l=7901;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=Zk7LbiOmT9mNlf6t4lzz1OSPTpd+FVh33BioqtIeMmg=;
 b=JKuhpwIWQweVwKVjCUVMs6q7BTskZM9Sq9q+NNQTx4R/yyXJLSWSNjvqOW6MI4T4xpWGySqcM
 gDXJ5cglocNCGfl5AkXrimlsh1paMd26y/TMkCj/H9HBPn8HHEHtYzl
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add ast2700-pinctrl.dtsi describing the default pin states of the SoC0
and SoC1 pin controllers and include it from ast2700.dtsi, so board
device trees only need to reference the pinctrl_*_default labels from
the consumer nodes.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/dts/ast2700-pinctrl.dtsi | 340 ++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/ast2700.dtsi         |   2 +
 2 files changed, 342 insertions(+)

diff --git a/arch/arm/dts/ast2700-pinctrl.dtsi b/arch/arm/dts/ast2700-pinctrl.dtsi
new file mode 100644
index 00000000000..b56c32df344
--- /dev/null
+++ b/arch/arm/dts/ast2700-pinctrl.dtsi
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 ASPEED Technology Inc.
+ */
+
+&pinctrl0 {
+	pinctrl_emmc_default: emmc_default {
+		function = "EMMC";
+		groups = "EMMCG4", "EMMCCDN", "EMMCWPN";
+	};
+
+	pinctrl_emmc8bit_default: emmc8bit_default {
+		function = "EMMC";
+		groups = "EMMCG8", "EMMCCDN", "EMMCWPN";
+	};
+
+	pinctrl_dacedid_default: dacedid_default {
+		function = "VGADDC";
+		groups = "VGADDC";
+	};
+
+	pinctrl_usb2ad_default: usb2ad_default {
+		function = "USB2AD0";
+		groups = "USB2AHAP";
+	};
+
+	pinctrl_usb2ah_default: usb2ah_default {
+		function = "USB2AH";
+		groups = "USB2AHAP";
+	};
+
+	pinctrl_usb2bd_default: usb2bd_default {
+		function = "USB2BD0";
+		groups = "USB2BHBP";
+	};
+
+	pinctrl_usb2bh_default: usb2bh_default {
+		function = "USB2BH";
+		groups = "USB2BHBP";
+	};
+};
+
+&pinctrl1 {
+	pinctrl_i2c0_default: i2c0_default {
+		function = "I2C0";
+		groups = "I2C0";
+	};
+
+	pinctrl_i2c1_default: i2c1_default {
+		function = "I2C1";
+		groups = "I2C1";
+	};
+
+	pinctrl_i2c2_default: i2c2_default {
+		function = "I2C2";
+		groups = "I2C2";
+	};
+
+	pinctrl_i2c3_default: i2c3_default {
+		function = "I2C3";
+		groups = "I2C3";
+	};
+
+	pinctrl_i2c4_default: i2c4_default {
+		function = "I2C4";
+		groups = "I2C4";
+	};
+
+	pinctrl_i2c5_default: i2c5_default {
+		function = "I2C5";
+		groups = "I2C5";
+	};
+
+	pinctrl_i2c6_default: i2c6_default {
+		function = "I2C6";
+		groups = "I2C6";
+	};
+
+	pinctrl_i2c7_default: i2c7_default {
+		function = "I2C7";
+		groups = "I2C7";
+	};
+
+	pinctrl_i2c8_default: i2c8_default {
+		function = "I2C8";
+		groups = "I2C8";
+	};
+
+	pinctrl_i2c9_default: i2c9_default {
+		function = "I2C9";
+		groups = "I2C9";
+	};
+
+	pinctrl_i2c10_default: i2c10_default {
+		function = "I2C10";
+		groups = "I2C10";
+	};
+
+	pinctrl_i2c11_default: i2c11_default {
+		function = "I2C11";
+		groups = "I2C11";
+	};
+
+	pinctrl_i2c12_default: i2c12_default {
+		function = "I2C12";
+		groups = "I2C12";
+	};
+
+	pinctrl_i2c13_default: i2c13_default {
+		function = "I2C13";
+		groups = "I2C13";
+	};
+
+	pinctrl_i2c14_default: i2c14_default {
+		function = "I2C14";
+		groups = "I2C14";
+	};
+
+	pinctrl_i2c15_default: i2c15_default {
+		function = "I2C15";
+		groups = "I2C15";
+	};
+
+	pinctrl_di2c0_default: di2c0_default {
+		function = "I2C0";
+		groups = "DI2C0";
+	};
+
+	pinctrl_di2c1_default: di2c1_default {
+		function = "I2C1";
+		groups = "DI2C1";
+	};
+
+	pinctrl_di2c2_default: di2c2_default {
+		function = "I2C2";
+		groups = "DI2C2";
+	};
+
+	pinctrl_di2c3_default: di2c3_default {
+		function = "I2C3";
+		groups = "DI2C3";
+	};
+
+	pinctrl_di2c8_default: di2c8_default {
+		function = "I2C8";
+		groups = "DI2C8";
+	};
+
+	pinctrl_di2c9_default: di2c9_default {
+		function = "I2C9";
+		groups = "DI2C9";
+	};
+
+	pinctrl_di2c10_default: di2c10_default {
+		function = "I2C10";
+		groups = "DI2C10";
+	};
+
+	pinctrl_di2c11_default: di2c11_default {
+		function = "I2C11";
+		groups = "DI2C11";
+	};
+
+	pinctrl_di2c12_default: di2c12_default {
+		function = "I2C12";
+		groups = "DI2C12";
+	};
+
+	pinctrl_di2c13_default: di2c13_default {
+		function = "I2C13";
+		groups = "DI2C13";
+	};
+
+	pinctrl_di2c14_default: di2c14_default {
+		function = "I2C14";
+		groups = "DI2C14";
+	};
+
+	pinctrl_di2c15_default: di2c15_default {
+		function = "I2C15";
+		groups = "DI2C15";
+	};
+
+	pinctrl_mac0link_default: mac0link_default {
+		function = "MACLINK0";
+		groups = "MACLINK0";
+	};
+
+	pinctrl_mac1link_default: mac1link_default {
+		function = "MACLINK1";
+		groups = "MACLINK1";
+	};
+
+	pinctrl_mac2link_default: mac2link_default {
+		function = "MACLINK2";
+		groups = "MACLINK2";
+	};
+
+	pinctrl_mdio0_default: mdio0_default {
+		function = "MDIO0";
+		groups = "MDIO0";
+	};
+
+	pinctrl_mdio1_default: mdio1_default {
+		function = "MDIO1";
+		groups = "MDIO1";
+	};
+
+	pinctrl_mdio2_default: mdio2_default {
+		function = "MDIO2";
+		groups = "MDIO2";
+	};
+
+	pinctrl_rgmii0_default: rgmii0_default {
+		function = "RGMII0";
+		groups = "RGMII0";
+		drive-strength = <8>;
+	};
+
+	pinctrl_rgmii1_default: rgmii1_default {
+		function = "RGMII1";
+		groups = "RGMII1";
+		drive-strength = <8>;
+	};
+
+	pinctrl_rmii0_default: rmii0_default {
+		function = "RMII0";
+		groups = "RMII0";
+	};
+
+	pinctrl_rmii0_rclko_default: rmii0-rclko-default {
+		function = "RMII0RCLKO";
+		groups = "RMII0RCLKO";
+	};
+
+	pinctrl_rmii1_default: rmii1_default {
+		function = "RMII1";
+		groups = "RMII1";
+	};
+
+	pinctrl_rmii1_rclko_default: rmii1-rclko-default {
+		function = "RMII1RCLKO";
+		groups = "RMII1RCLKO";
+	};
+
+	pinctrl_sgmii_default: sgmii_default {
+		function = "SGMII";
+		groups = "SGMII";
+	};
+
+	pinctrl_fwspi_quad_default: fwspi_quad_default {
+		function = "FWQSPI";
+		groups = "FWQSPI";
+	};
+
+	pinctrl_spi0_default: spi0_default {
+		function = "SPI0";
+		groups = "SPI0";
+	};
+
+	pinctrl_spi0_cs1_default: spi0_cs1_default {
+		function = "SPI0CS1";
+		groups = "SPI0CS1";
+	};
+
+	pinctrl_spi0_quad_default: spi0_quad_default {
+		function = "QSPI0";
+		groups = "QSPI0";
+	};
+
+	pinctrl_spi1_default: spi1_default {
+		function = "SPI1";
+		groups = "SPI1";
+	};
+
+	pinctrl_spi1_cs1_default: spi1_cs1_default {
+		function = "SPI1CS1";
+		groups = "SPI1CS1";
+	};
+
+	pinctrl_spi1_quad_default: spi1_quad_default {
+		function = "QSPI1";
+		groups = "QSPI1";
+	};
+
+	pinctrl_spi2_default: spi2_default {
+		function = "SPI2";
+		groups = "SPI2";
+	};
+
+	pinctrl_spi2_cs1_default: spi2_cs1_default {
+		function = "SPI2CS1";
+		groups = "SPI2CS1";
+	};
+
+	pinctrl_spi2_quad_default: spi2_quad_default {
+		function = "QSPI2";
+		groups = "QSPI2";
+	};
+
+	pinctrl_sdio_default: sdio_default {
+		function = "SD";
+		groups = "SD";
+	};
+
+	pinctrl_pcie2_perst_default: pcie2_perst_default {
+		function = "PCIERC";
+		groups = "PE2SGRSTN";
+	};
+
+	pinctrl_usb2cud_default: usb2cud_default {
+		function = "USB2C";
+		groups = "USB2CUD";
+	};
+
+	pinctrl_usb2cd_default: usb2cd_default {
+		function = "USB2C";
+		groups = "USB2CD";
+	};
+
+	pinctrl_usb2ch_default: usb2ch_default {
+		function = "USB2C";
+		groups = "USB2CH";
+	};
+
+	pinctrl_usb2cu_default: usb2cu_default {
+		function = "USB2C";
+		groups = "USB2CU";
+	};
+
+	pinctrl_usb2dd_default: usb2dd_default {
+		function = "USB2D";
+		groups = "USB2DD";
+	};
+
+	pinctrl_usb2dh_default: usb2dh_default {
+		function = "USB2D";
+		groups = "USB2DH";
+	};
+};
diff --git a/arch/arm/dts/ast2700.dtsi b/arch/arm/dts/ast2700.dtsi
index 3dd6826fd0c..a62850ca238 100644
--- a/arch/arm/dts/ast2700.dtsi
+++ b/arch/arm/dts/ast2700.dtsi
@@ -691,3 +691,5 @@
 
 	};
 };
+
+#include "ast2700-pinctrl.dtsi"

---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20261030-pinctrl-dtsi-fc61af129584

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>

