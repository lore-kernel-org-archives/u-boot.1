Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D52606A32E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gGDmw6PU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=C2u6Bo/m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DA2280CBA;
	Wed, 25 Nov 2026 11:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Of68eSufYA1; Wed, 25 Nov 2026 11:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44E2480CA8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795606258;
	b=OjvR3C2xbL7v2uLJfUUVMJtCv7VpoSAlT0nYmehxEQjtsCxHnJsjZZTNGOse1Tqd231u
	 QfjDMIl9cEOOj747PPf1tHPIDYb2+l4Q6cOcwAO5xcb1Lyai3xEPb6csRjgHeSDfwXAyW
	 gJ922jQT4sJ6baMS2JdsfXdmLzCTDWlLrafmEvVt0AGwVIfyh2iJq+qTbvtSCOhyN1Psa
	 lhkWYWWmZza42NyOx8SaGjl689MZUvdWNe1VfjPY8Ppv4ad2klkJjzCJMfNAj5Z/1yr1m
	 wdkeiAWUQL71xNU4IiKh0gd1ChiVoILBzpr/LSsC/iRgwTgs4Bf/xYnehsAlkGUe5Kw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795606258;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y0wTySP9EVQ0X4QtV4VsLcN027J8Fz97rprSpP4JyjE=;
	b=AVuYCRHsi8MZfxzFFR6+PfaQJf4lL2D6q4ktAVrm7RuVHt9SVFxd29J3VZ82EPMkyeWo
	 GsvNMcBGAmcq4MzBeRxZNMTTtv8rJXjZrawxdDgs+hwGfkt1ktSdnTLhZ9SX5oRtY8e21
	 6Cz8dLy76GKi+uJ4Yi+1X3zvG7C7+9wue8VmM99aCm0lwrxA1T5Dzqh6wy0T/fLHMT+Ym
	 bkCecylI+XiyWSB3Pxj5w9gwHOsWH8udwsyyd1Ap7X/GlS6lBxkZvK/j9K0DaHn3U0m19
	 TUju0LWuEgRHmNpIavW0kdqSDyeYBQiRHHH6gDvHRMRcfFG/i9svuIUViuNPj7Xc9AA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795606258;
	bh=Y0wTySP9EVQ0X4QtV4VsLcN027J8Fz97rprSpP4JyjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gGDmw6PUPCI0ZN7eeMyrYClgqpz2g/8cewW9J/qlcgko4Kzw7KyBxEwjFgbK+ePiT
	 3Kgi+dtLrynhatpW43CMuR/DbdMMcs1BP8AblB0QFLbzLBCBZzJPHFksYCIi1OrdaX
	 KSanuzjl03iiX8DrRsYGtUUBRg1qonCRNOqNV6O8kuELLUAgo5wtAi0JOWPHunmWRi
	 Tf5V4OIYCHrksJ28aPldu4EhW6rp233aTDz1FnKM/bsRy6gbSeyTt1oM4a+u0R/4aY
	 e2CKDuVp92KS7+U+5mZwZkufi0KwR9WXdT/AZwC3HUknsdOvmavxxKxSeKof2hgfvU
	 Kxp5ZeQREOWCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44E2480CA8;
	Wed, 25 Nov 2026 11:30:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F20311
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD72260878
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTdDLlhwnRFU for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 11:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6550E60687
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C2u6Bo/m
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6550E60687
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 11:30:49 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so5300335e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 03:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795606248; x=1796211048;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y0wTySP9EVQ0X4QtV4VsLcN027J8Fz97rprSpP4JyjE=;
 b=C2u6Bo/mNMRG/0bVNeos8EKh/prc1hrdL8wdX2g82BWPs+VXTfrzhD3JHXMsqBskTI
 9LfNdqJjOeclLNevO/y6kgqmDF2yEKjaidpVcB8vu7PE7AOnk8GDqvqz/mUJ6l62PgVU
 GXOvgTr3YcCeXm1cSbtolTncDmLyS/m4ZTy8MMV1wmiOkzPjNZKqQHRWe9tr1qlY88HE
 BdA4l+wLxvSGcE5rzhUoQaSBic3xIcTW6FP2KGJA2DmS81PmY5s9gPnHYfjH1PGwNz/o
 Do7j9hqDetFT9nrmIHURui5ylGJBgVBdfTCDZt9H2PYvfwxkZiXXYf6kfEFSfoHABOqr
 tEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606248; x=1796211048;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y0wTySP9EVQ0X4QtV4VsLcN027J8Fz97rprSpP4JyjE=;
 b=qf3+Rpf0aY1YrQoeOOcpUlxp/SJLk/7pbr8jmbPwOBJAXGg2Yq4KkjHO+7QqpI8cih
 7/L4Iu1wAlUX+ypwYPu13V9sdaR5c22L0Gdnq3VxEj4ZLxsG8+C/qGhDH5fi3OkPW1bd
 hQyIgJVmC8kjWriHQUb9sRd3YrfNGuzohn+7ogTIzKFrceYdz2eHV0ACmQz/uCnYItdq
 uQ9WhJdFQjg4kItqaW481fZubJLwXgEflHyQNxrahBTu8OtaTjIdXbaf4SJS53pVJBpQ
 tqmEMuIca2xchwtMfQ4GNsXv+ZQn8+rIlEioxT2RajAuWoKsg5v6cn+pjx/VEMcx/+sC
 qovA==
X-Gm-Message-State: APuU4Z+e8Io6MMmC01zx40jchwSjULgem2VcuvgVVsUN6QvnmQHlhMBl
 RX+hNPNvB01mlYkZWVsn+riMdGG1eRwLrnaS1lyAs9SFZVDgvM8kkfmxsoiR/lGyX58=
X-Gm-Gg: AZFdTZf/BGrS8s9qpB+S6EXxu9megtoB0m64gn3zZES3NPgHJiVbG7yVY1H3dyGjero
 M9QfHLpp/xbdtvaFpRwGnishWCGU6Oi4xvyA/d1t7j2EzXE+J64/hYQcuO/6LbQ4mTHFtMGEvUQ
 mY7dAy+I19yDKr3Y0ZYfkvdEabebNxldVCgzmGP6FJEDPZxhVOZ7ZHR+fKvE0TFXv39fYzbTamu
 oDqMgK3iqfdgYvf3ZxkDMYhRLZqDloqHc09ECMB3H45ThGniS1Sc7Zsb1lEZODD6UxAXUmOQNQk
 nJtS8wGXPLFSREOOI7N3b25uYG2k4ShZOCE7PT5zOjRiKW2D5AyJNnsbQrbNXkof8uKk6Pam1Vt
 4gyYYhzoVVj2gg82i7k7/rzVeYFN9Ja7jqinNaQBVgXdUBr0Ek3tvetzNwhb9ejvixZRghN0tfW
 IZznzLwo7s0qtxXu1jbWyyWPjFHxgPxvXHjWVu7IJ2YqB/3fT/aD0iSpj/2GNXcWoXDiuglnsln
 NlEb5XLTap0iDBmMNRqKcp2fmEql7wEx8ufeZ+vt8jlJOYItmdxYtjjCyfH1UMFNdTQqvnKEBEy
 ZsoLoNcD7+IsOf8OU2LiCNoa9f+DV369zDp5Xjjtn8WGODChiMN565vr+oKn/RKRViujMwQnHMb
 9n4R3JySvbI6g0G1M
X-Received: by 2002:a05:600c:4f48:b0:4a6:44b:2593 with SMTP id
 5b1f17b1804b1-4bb8893ab9cmr373576545e9.29.1795606247857; 
 Wed, 25 Nov 2026 03:30:47 -0800 (PST)
Received: from [127.0.1.1]
 (2a02-842a-aa82-f701-cd04-e538-7ddd-cfa8.rev.sfr.net.
 [2a02:842a:aa82:f701:cd04:e538:7ddd:cfa8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm39870905f8f.21.2026.11.25.03.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:30:47 -0800 (PST)
From: "Julien Panis (TI)" <jpanis@baylibre.com>
Date: Wed, 25 Nov 2026 12:30:28 +0100
Subject: [PATCH v3 1/7] board: ti: am43xx: Remove am4372-generic devicetree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v3-1-7f5c72c1116b@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606245; l=4603;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=v3JwmgXaPggKaPPkCYlwa9ybuhaKC6Ua+HvlcYHFunM=;
 b=pM2Wm/rNcFZJgGRcyn1QPmwgChlK9+/uV8PA7k4aYXJ9rvSaRMt9IPAWascCrAmdBhpAUq0dJ
 2kYzJcmadU0D+XdEZHE5lCRS6QXwog5y5qsHBDRMcZA5clKND3EfIhJ
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

The generic board is a helper devicetree if board EEPROM reading failed
or the board is booting without SPL, e.g. QSPI boot. In these cases the
generic board was used. However there is no equivalent upstream so it
doesn't work with OF_UPSTREAM.

To support EEPROM reading before relocation, we are adding
bootph-some-ram to i2c0.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Signed-off-by: Julien Panis (TI) <jpanis@baylibre.com>
---
 arch/arm/dts/Makefile                   |  1 -
 arch/arm/dts/am4372-generic-u-boot.dtsi | 16 ----------------
 arch/arm/dts/am4372-generic.dts         | 23 -----------------------
 arch/arm/dts/am4372-u-boot.dtsi         |  8 ++++++++
 board/ti/am43xx/board.c                 |  6 +-----
 configs/am43xx_evm_qspiboot_defconfig   |  2 +-
 configs/am43xx_hs_evm_qspi_defconfig    |  2 +-
 7 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b63..76f36b992ed1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -411,7 +411,6 @@ dtb-$(CONFIG_AM33XX) += \
 dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 	am43x-epos-evm.dtb \
 	am437x-idk-evm.dtb \
-	am4372-generic.dtb \
 	am437x-cm-t43.dtb
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
diff --git a/arch/arm/dts/am4372-generic-u-boot.dtsi b/arch/arm/dts/am4372-generic-u-boot.dtsi
deleted file mode 100644
index 40f3756eb3fe..000000000000
--- a/arch/arm/dts/am4372-generic-u-boot.dtsi
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-#include "am4372-u-boot.dtsi"
-
-/{
-	ocp {
-		bootph-all;
-	};
-};
-
-&i2c0 {
-	bootph-all;
-};
diff --git a/arch/arm/dts/am4372-generic.dts b/arch/arm/dts/am4372-generic.dts
deleted file mode 100644
index 2524e0405cd5..000000000000
--- a/arch/arm/dts/am4372-generic.dts
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Device Tree Source for Generic AM4372 EVM
- *
- * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
- */
-
-/dts-v1/;
-
-#include "am4372.dtsi"
-
-/ {
-	compatible = "ti,am4372", "ti,am43";
-	model = "Texas Instruments AM4372 Generic";
-
-	chosen {
-		stdout-path = &uart0;
-	};
-};
-
-&i2c0 {
-	status = "okay";
-};
diff --git a/arch/arm/dts/am4372-u-boot.dtsi b/arch/arm/dts/am4372-u-boot.dtsi
index 0c498bcf085c..06e7380adf64 100644
--- a/arch/arm/dts/am4372-u-boot.dtsi
+++ b/arch/arm/dts/am4372-u-boot.dtsi
@@ -65,3 +65,11 @@
 &ocp2scp1 {
 	bootph-pre-ram;
 };
+
+/*
+ * Some boards boot directly to U-Boot without SPL. In this case we need
+ * support for reading the EEPROM before relocation.
+ */
+&i2c0 {
+	bootph-some-ram;
+};
diff --git a/board/ti/am43xx/board.c b/board/ti/am43xx/board.c
index 431372954b2a..42e2bef8151f 100644
--- a/board/ti/am43xx/board.c
+++ b/board/ti/am43xx/board.c
@@ -826,11 +826,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #if defined(CONFIG_SPL_LOAD_FIT) || defined(CONFIG_DTB_RESELECT)
 int board_fit_config_name_match(const char *name)
 {
-	bool eeprom_read = board_ti_was_eeprom_read();
-
-	if (!strcmp(name, "am4372-generic") && !eeprom_read)
-		return 0;
-	else if (board_is_evm() && !strcmp(name, "am437x-gp-evm"))
+	if (board_is_evm() && !strcmp(name, "am437x-gp-evm"))
 		return 0;
 	else if (board_is_sk() && !strcmp(name, "am437x-sk-evm"))
 		return 0;
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index 86d8389951be..817b97b4b277 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -30,7 +30,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 6b754cdc0ec9..715e2ac4be21 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -32,7 +32,7 @@ CONFIG_CMD_USB=y
 CONFIG_BOOTP_DNS2=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="am4372-generic am437x-sk-evm am437x-idk-evm"
+CONFIG_OF_LIST="am437x-sk-evm am437x-idk-evm"
 CONFIG_DTB_RESELECT=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y

-- 
2.43.0

