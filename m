Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30590606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VZ2haPDj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FEOwjM7H
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CBFB608C8;
	Wed, 25 Nov 2026 11:31:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujnicWIJQkB9; Wed, 25 Nov 2026 11:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 654C8608C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606266;
	b=ihuctTgYRHub7fkNEjYdEDa0CVU2EVYrn36DBlMERvWSThpSXxcj8puf7oMTJeI8Rl/M
	 8gMLsp/610Snaz7hV6NyWv4tp8lIwqRHZz1DGMT9gXDTIR8PxAmcuhXi/PkyDvPtrxgVM
	 GPpZxC440pAPqo7UvuBVyb/h0wkM0W0f/7FENIe4/O28v5YZa4LbD54Yosa5DDSs551hP
	 lxTKbx8LhpiPUCwDPP1eAVJZJdDS2kJvbuG9Z2T0QFrTPfgwODIwetwEkJgEBpxU7X38d
	 KWCUDM826Uf/AGNCtP3zjEdji+7TU4MvQVCfvwwGIczndbKCF+OuREO8/sjQ2uaUf3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Oa0ix+d3qnFe0hBiM2IPNxMm7uEnYwjgGpiwUGh9FFE=;
	b=lmhPpzhKyf0LcdHnB2a22BHGhdG8ZXsZGpPmAwXtzvExPDM0boMnd0qV9r2OR9vNHAFH
	 PKOJ6rSN+58StDAFEm9dGv/upSexwWIiBp0NhBkMAdibM2AqGM9gxre8vDKLo4WqgLp/M
	 yEzgwd0wwRnaEJH7y8b5oTc6olFhW6iaWZn+zIJIyodj0iV6HblUT6t3T4t7p83lr/X9n
	 sx4i+kI7dPuvRKzJPGj2zuZh5srETcH4qTUv+aFeqz8uRY8JeSrvRD6hYmgkN9EUt5Tna
	 eZbQrqlchuxIur17p5wv1Yt8fKZszKBuDV99ou6nmfhkB7VHq80w+ieS5XIuTdUbXWA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606266;
	bh=Oa0ix+d3qnFe0hBiM2IPNxMm7uEnYwjgGpiwUGh9FFE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VZ2haPDjp0LW9cy9TwBm3uSEZLpmVkXehcqpWa9PKALspOOd418qXx6YMl5YA7C8O
	 bY9qPzN6dLDQ44Zi544WPbhkz43jzlMNq8UsP132+Tqqz2LuRp4H9BT2OhhFa0TSqV
	 lItxt6WD1EbITClJWCPQx0NxivMZVY4FokLyB+puQ31URCe8GutmQly+rzlLlnyf4f
	 Qjx6UWRCjkVViXmS7fJI2FFu9ym/u878ONyeGtsWfPKdVdOc3hNlaYyrvrNHDZtflN
	 fr6CtFlETNKd4JmyoZINhVExbkKx/B31ALGnPHMnx4AHWt/DyQFMokH2ILmllJ+5mE
	 Xh4s7/4sIWdPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 654C8608C7;
	Wed, 25 Nov 2026 11:31:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8940E325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EF19405C4
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvt_wUj_qKAI for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6B4F405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FEOwjM7H
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6B4F405BA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:56 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-491971ac844so5091792f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606254; x=1796211054;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oa0ix+d3qnFe0hBiM2IPNxMm7uEnYwjgGpiwUGh9FFE=;
 b=FEOwjM7Hzc6PIQI5hWQZGMFuqlAhsoTDNAQ349yMi1QPdXub+u8rrQI3Xerub5dJRJ
 dAQewWQlmW5u3yBzUfv5wdCtT23E1NPAMehcnmLrDxu83cj6GJekRU+estYdjtv9IpCF
 zZwa4zIDC7C+ZBehXVx55kNfryo2u1Y9+rzNXAU43n2k6TQAfUN76zsMojN/l58Hs613
 1Wp7axzwPI2sZG0ObhABvWZrT6WwUzF8v8J4EBArqJ8/eJHL7nHJUcMW/s1uulDuYNIa
 MfxhR+fbWbfOZfV/LrNYPMEUTtZ/sGa3gXfEOC4cCmoSj3FAn8JfjCGUUthgcLBdmCjk
 L5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606254; x=1796211054;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oa0ix+d3qnFe0hBiM2IPNxMm7uEnYwjgGpiwUGh9FFE=;
 b=tpIanGJPBBZ4wumvuVLSDqCg8eEDZ/qujmdyXVNQ0VmHjHNoL8oeZSQImbWOaOKcsS
 D4unAeePWVfEnTiYo3aqs7hFGOoKPX/hzJA5SjDMSetP/2dhT9yIv1VTxiLDOwz5ewd2
 9Sck2yIolu7LkHtxI4LVYFgJqzrPMh1NuqTBy3Nr9WEizkkS174rlFl6V5lpTxrzYj7n
 YP4N8K9nnHoAJiqG2q76/1FZ8RITGMvBItM6rotrmCRHBLrH5Q/t2QyZaqejDBI+1eNM
 QsT7UXM3KjLl2F0ybAkmHW5OsjAuj59RGWdBJ9yxBnca7eIxuiH0bTik9oEME8/iTBL9
 Q4kA==
X-Gm-Message-State: APuU4Z/i9MiTQlJ8LVZrh7hhbP+YNFQCe212pVyUi/cLBk8WEymPdx0l
 zxYJSPdOjuIZD0UJznDF/xTi16XnxzhH6FGI44Rd6CszpG2XNxFe3lcTM0iKlqmqwAY=
X-Gm-Gg: AZFdTZdnybnCbij8uyaRJXg9pShyovnYgiJjZsLInuGIHi8l2WhCvF6y0eb3RFlbb4S
 iB/bezfs6zDm1eIa+0ne/4LopEql4s6LKH/6hGBIIl9dUXIM6e7UnERbwV5bxhb9YzGvGHvFDj1
 PR2tSOV+NQuIF8kTgefkcdIMhI8c76QA0k0Ef+2XyQwp1jEFgCU3yjTPuEwn/M7yZycJz8TIKCH
 QR6z6UGR24FphjmDwEhSnEnLnF5tH4aR4rTmElm3Eqh1RiORxNTDSFtp8Rp3hNtQoT4za5dOrbX
 zmqi3ziYERW8BfvFMU48OGXWicTEarDVoDfDYq/c5SVvX7MXhhmvo8VMmdq5q2Phz43dFUfrXBZ
 iQKiUH/WGisiie6hHD+VGc+R/bwxfeSc+xWGWKQXnNsfTQJ+oWgVgjLBkCt/Q4pBrsPhmh0dlhq
 R9vYdyfDoIlU+3GLPGPTT9bEftwwcFPJkCgP19wJOWJuVh/zJpaTd6EGJBmGCY+3SnsE/8jv0A2
 IL04NasRx2z+jVXYZqphkPQjESoNGd8ikDws5s+5jSiLhDwGd635l2ZRiEfuDl5oG8vs2hp3BJA
 istyvkMlcIVcHMlQoYFVdOYb6Z6hb7mpq79KQoy5qc3Leju3KIdfZ4JToEsFtnP/XkXH3uGV9YU
 lPRW4rKxs3a+1I8DAdQ==
X-Received: by 2002:a05:6000:470e:b0:4aa:323a:d7b7 with SMTP id
 ffacd0b85a97d-4abb16e310bmr33985716f8f.23.1795606254048; 
 Wed, 25 Nov 2026 03:30:54 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:53 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:33 +0100
Subject: [PATCH v3 6/7] configs: am43xx: Switch to upstream devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-6-7f5c72c1116b@baylibre.com>
References: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
In-Reply-To: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-0-7f5c72c1116b@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 "Julien Panis (TI)" <jpanis@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Andrew F. Davis" <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Nikita Kiryanov <nikita@compulab.co.il>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=19328;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=1UO3rT55szq/73x8uWmJjNYKwq/5xQ/eZQZNQ2MVTwg=;
 b=G/jMWok+kCTBMhEKvzQkZ09xghueJbCELuoLuDUOCeFhOWAEW2KipyJb2uUkjlscEKqqbKlNF
 8LVIJ5GJbOrAvT7hN+Sz2rKwPqB7/3mqH/td09lUQmtqB02xrk+S2r6
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

Switch to OF_UPSTREAM using the upstream devicetrees instead of the
uboot ones. This change requires updates for u-boot.dtsi and defconfig
files.

*-u-boot.dtsi needs to be updated to reflect the new label names of the
upstream devicetrees.

The defconfigs need to support multiple new drivers/frameworks to have
the boot working.

The qspi variants have no SPL config options enabled as the boot ROM
executes uboot directly from the flash.

With upstream devicetrees i2c0 is within a ti,sysc device node and
depends on clkctrl clocks and PRM power domains. The QSPI configurations
read the board EEPROM in U-Boot before relocation. Mark their nodes with
bootph-some-ram to be able to probe i2c0 before reading the EEPROM.

On the AM437x GP and SK EVMs, disable MMC3 as its slot holds the WiLink
WiFi/BT module, which is SDIO and non-removable. The old local DTs kept
mmc3 disabled.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 arch/arm/dts/am4372-u-boot.dtsi           | 60 +++++++++++++++++++++++--------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    | 13 ++++---
 arch/arm/dts/am437x-sk-evm-u-boot.dtsi    |  5 +++
 configs/am43xx_evm_defconfig              | 22 ++++++++++--
 configs/am43xx_evm_qspiboot_defconfig     | 14 ++++++--
 configs/am43xx_evm_rtconly_defconfig      | 22 ++++++++++--
 configs/am43xx_evm_usbhost_boot_defconfig | 22 ++++++++++--
 configs/am43xx_hs_evm_defconfig           | 22 ++++++++++--
 configs/am43xx_hs_evm_qspi_defconfig      | 14 ++++++--
 configs/cm_t43_defconfig                  | 17 +++++++--
 10 files changed, 179 insertions(+), 32 deletions(-)

diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 67a1b5ebd6e2..2b18650e720f 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -14,14 +14,6 @@
 	};
 };
 
-&am43xx_control_usb2phy1 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
-&am43xx_control_usb2phy2 {
-	compatible = "ti,control-phy-usb2-am437", "syscon";
-};
-
 &ocp2scp0 {
 	compatible = "ti,am437x-ocp2scp", "ti,omap-ocp2scp", "simple-bus";
 };
@@ -42,10 +34,6 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy1 {
-	bootph-pre-ram;
-};
-
 &ocp2scp0 {
 	bootph-pre-ram;
 };
@@ -62,14 +50,26 @@
 	bootph-pre-ram;
 };
 
-&am43xx_control_usb2phy2 {
+&ocp2scp1 {
 	bootph-pre-ram;
 };
 
-&ocp2scp1 {
+&prm_wkup {
 	bootph-pre-ram;
 };
 
+&prm_per {
+	bootph-pre-ram;
+};
+
+&prcm_clocks {
+	compatible = "simple-bus";
+};
+
+&scm_clocks {
+	compatible = "simple-bus";
+};
+
 /*
  * Some boards boot directly to U-Boot without SPL. In this case we need
  * support for reading the EEPROM before relocation.
@@ -77,3 +77,35 @@
 &i2c0 {
 	bootph-some-ram;
 };
+
+&l3_clkctrl {
+	bootph-some-ram;
+};
+
+&l4_wkup_clkctrl {
+	bootph-some-ram;
+};
+
+&prm_per {
+	bootph-some-ram;
+};
+
+&prm_wkup {
+	bootph-some-ram;
+};
+
+&l4_wkup {
+	segment@100000 {
+		/* PRCM */
+		target-module@f0000 {
+			bootph-some-ram;
+		};
+	};
+
+	segment@200000 {
+		/* I2C0 */
+		target-module@b000 {
+			bootph-some-ram;
+		};
+	};
+};
diff --git a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
index 6393170ad22e..98a8126d0ddf 100644
--- a/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-gp-evm-u-boot.dtsi
@@ -23,19 +23,19 @@
 	bootph-pre-ram;
 };
 
-&mac {
+&mac_sw {
 	bootph-pre-ram;
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	bootph-pre-ram;
 };
 
-&cpsw_emac0 {
+&cpsw_port1 {
 	bootph-pre-ram;
 };
 
-&phy_sel {
+&phy_gmii_sel {
 	bootph-pre-ram;
 };
 
@@ -58,3 +58,8 @@
 &ethphy0 {
 	bootph-pre-ram;
 };
+
+&mmc3 {
+	/* SDIO WiFi module, not supported in U-Boot */
+	status = "disabled";
+};
diff --git a/arch/arm/dts/am437x-sk-evm-u-boot.dtsi b/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
index 580ba3512bdd..895a2ef917c4 100644
--- a/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
+++ b/arch/arm/dts/am437x-sk-evm-u-boot.dtsi
@@ -22,3 +22,8 @@
 &mmc1 {
 	bootph-pre-ram;
 };
+
+&mmc3 {
+	/* SDIO WiFi module, not supported in U-Boot */
+	status = "disabled";
+};
diff --git a/configs/am43xx_evm_defconfig b/configs/am43xx_evm_defconfig
index 743ef0a88f2b..aac7d0d46dda 100644
--- a/configs/am43xx_evm_defconfig
+++ b/configs/am43xx_evm_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -32,6 +33,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -42,7 +44,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -52,10 +55,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -75,8 +89,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index e612dde93ee0..73f7ac29e027 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-sk-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-sk-evm"
 CONFIG_AM43XX=y
 CONFIG_ENV_OFFSET_REDUND=0x120000
 CONFIG_DISTRO_DEFAULTS=y
@@ -30,7 +30,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -42,6 +43,13 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
@@ -51,6 +59,8 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am43xx_evm_rtconly_defconfig b/configs/am43xx_evm_rtconly_defconfig
index e4102c902485..06fbd2401ee5 100644
--- a/configs/am43xx_evm_rtconly_defconfig
+++ b/configs/am43xx_evm_rtconly_defconfig
@@ -6,10 +6,11 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_RTC_DDR_SUPPORT=y
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -29,6 +30,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -39,7 +41,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -47,9 +50,20 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -65,8 +79,12 @@ CONFIG_PHY_GIGE=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_evm_usbhost_boot_defconfig b/configs/am43xx_evm_usbhost_boot_defconfig
index bbf57a8ed797..12891bffd7b4 100644
--- a/configs/am43xx_evm_usbhost_boot_defconfig
+++ b/configs/am43xx_evm_usbhost_boot_defconfig
@@ -5,10 +5,11 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_SPL_TEXT_BASE=0x40300350
 CONFIG_SPL=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
@@ -28,6 +29,7 @@ CONFIG_SPL_FALCON_BOOT_MMCSD=y
 CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
 CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_CMD_SPL=y
 CONFIG_CMD_SPL_NAND_OFS=0x00100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x40000
@@ -47,7 +49,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
@@ -59,9 +62,20 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_MTD_RAW_NAND=y
@@ -80,8 +94,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_defconfig b/configs/am43xx_hs_evm_defconfig
index af93fecc8e9d..79c57f017528 100644
--- a/configs/am43xx_hs_evm_defconfig
+++ b/configs/am43xx_hs_evm_defconfig
@@ -7,7 +7,7 @@ CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=48000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-gp-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-gp-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -16,6 +16,7 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_TEXT_BASE=0x403018e0
 CONFIG_SPL=y
 CONFIG_SYS_MEM_TOP_HIDE=0x4000000
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
@@ -33,6 +34,7 @@ CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NET=y
 CONFIG_SPL_NET_VCI_STRING="AM43xx U-Boot SPL"
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_NAND=y
 CONFIG_BOOTP_DNS2=y
@@ -40,7 +42,8 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:256k(NAND.SPL),256k(NAND.SPL.backup1),256k(NAND.SPL.backup2),256k(NAND.SPL.backup3),512k(NAND.u-boot-spl-os),1m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup1),7m(NAND.kernel),-(NAND.file-system)"
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-gp-evm am437x-sk-evm am43x-epos-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-gp-evm ti/omap/am437x-sk-evm ti/omap/am43x-epos-evm ti/omap/am437x-idk-evm"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
@@ -50,10 +53,21 @@ CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
+# CONFIG_SPL_DM_I2C is not set
+CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
@@ -73,8 +87,12 @@ CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
+CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
+CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index ad84ee36cc48..8b74e9a53914 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x110000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="am43x-epos-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-sk-evm"
 CONFIG_AM43XX=y
 CONFIG_TI_SECURE_EMIF_REGION_START=0xbdb00000
 CONFIG_TI_SECURE_EMIF_TOTAL_REGION_SIZE=0x02000000
@@ -32,7 +32,8 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="ti/omap/am437x-sk-evm ti/omap/am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
@@ -44,6 +45,13 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
@@ -53,6 +61,8 @@ CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/cm_t43_defconfig b/configs/cm_t43_defconfig
index ba898b119537..fe2988243d9e 100644
--- a/configs/cm_t43_defconfig
+++ b/configs/cm_t43_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am437x-cm-t43"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am437x-cm-t43"
 CONFIG_AM43XX=y
 CONFIG_TARGET_CM_T43=y
 CONFIG_SYS_MONITOR_LEN=524288
@@ -23,6 +23,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="mmc dev 0; if mmc rescan; then if run loadbootscript; then run bootscript; fi; fi; mmc dev 1; if mmc rescan; then run emmcboot; fi;"
 CONFIG_SYS_PBSIZE=1050
@@ -41,7 +42,7 @@ CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_POWER=y
+CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
 CONFIG_SYS_PROMPT="CM-T43 # "
@@ -63,6 +64,7 @@ CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -70,6 +72,15 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_SYS_RX_ETH_BUFFER=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_SPL_SIMPLE_PM_BUS=y
+CONFIG_SPL_TI_SYSC=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_TI_AM3_DPLL=y
+CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DM_I2C=y
 # CONFIG_SPL_DM_I2C is not set
 CONFIG_SPL_SYS_I2C_LEGACY=y
@@ -93,6 +104,8 @@ CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_PHY_ATHEROS=y
 CONFIG_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_I2C=y
 CONFIG_DM_SERIAL=y

-- 
2.43.0

