Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E0606A32E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o4hLTOTR;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hY7dVHfJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D59014093F;
	Fri, 23 Oct 2026 10:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ORdIGGikNuZQ; Fri, 23 Oct 2026 10:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AA7D54092B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792750219;
	b=ToploNXlHpZ/SHruykqShaSV2Ds3t0YNqVtqEo9sjKLVcPrFYHDayIUoqOvlGOnwpNAm
	 1CHTdE5vZH4wY/1XDaIsDDhuFVPPa2X/Uu1apCTEALSncqEEaRnHnavx67qtBv6SuyvEL
	 2VoM+ynKxtKCytlD15R4KbKy6XEZUPNPvbiyKdlfGYm8r7K6d4K4H9beoSl1oM6maH/zr
	 +GTvjk2tKP3Avuqp8btbUzwlMM/I93Dq9nqcWBrTbVZmNWS1GvabWMmQ3FTJlR5S8OCa9
	 +Qz7N1fCTUmC/LYlfHRP6YZ9IimAQz7Jlwwg2vLJpy5JymQAwQaTyuhdC/2TgElPWdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792750219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bZcYOjHWlNivyX1fzrWoDlBI9wJ9ds6veVTmGd7507Q=;
	b=P+Vc5MUpar7t132cHrcOHpzgIppFTyNsonxQHDzNim4MeFEu4ZDY7QcFv7jYLI4nN+9l
	 CJ9Z0RGS9Xd4QVQxSvhSzT8mdM2BU8EIHQlU1J5aBylyN/mUO+OSr2kkZDp7Sp6VQ6EEo
	 /eLO0goZxguO1fVzdEg0hS7ZypQaKxVGpAVdwyiyu0kTfudHRsU333abXVBWRZBUqyFmb
	 +EloWePbrnua9OsYvW5ipWFQOXvDhoCqyZ7BzLatqaFxNXZtbvVbhv0LfT6WjOKD2p4vZ
	 pnZSAlJDrPVRuDEa4NKo2BDTW0kNmCvXVutEemXBiI+fSmi9KAI0cAWhR22FpLMvfPw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792750219;
	bh=bZcYOjHWlNivyX1fzrWoDlBI9wJ9ds6veVTmGd7507Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4hLTOTR4gFEO04pf3lQSWzxVZ2gO5XDcOJIQcMUzibtgVFfxgZ0gzz74U3Xd09ZH
	 M4jjUkRJ6/5nO3MbWobbvMGPvEOjVSnxDdAO29C361nI2kg9vT81+JQV2pjoTpYtzP
	 28slsz3kvZFvYufAlXZawmzegOD0rTbf0d7WHzX/EAynzTom+a8m1QFw0qtdoBwD0g
	 jKkzrLl8Z4+LOPINLK7EC43KiiUycZy3cIJUxgXpKS4FOUrMH2BZujo8AoHz7DZ2Hm
	 WRNcf4chzGtn2AKNcESZMIVLpXkHYiEKdU53W1v8TKmXm2FbHlLO/xcPDwzpJu+R2d
	 RKtWp1+QqfuMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA7D54092B;
	Fri, 23 Oct 2026 10:10:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 190393C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AE9D80FA3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6x3CSWZv6ARH for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 326648116A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792750215;
 b=WUE+diQXWPE/zDUqQmU59+yLkY6juMwCHPgsc+5V/WGC2sqYv0946yUsGi9HiNaoNMaE
 YUM+9yprOnGPMDZISvc0m4Wiy9HBKmF1NowXD0jGo/NAvugNk2HPGIXHNbOx+BMfFoL1h
 W+iluh9hMKCdnni8Z8xuX+sjVhzcQTzPKBUIHZ/rvoNc1bSTbi37hDmYmv+wCqqeLOLYc
 3VY1DuO0Rj4TNCuHsb0eHn5dt0/h9n0Hihs4ko9G8576NS+QOh1FQrGhhVJgQSSHCQ0UW
 LefqLJdd/vkCfLvV2VRXJ7PmB5Q+DBrbVqFfpG4S38ms7AomOWSKJZJMYtKFbJTu/fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792750215;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=bZcYOjHWlNivyX1fzrWoDlBI9wJ9ds6veVTmGd7507Q=;
 b=b0uut5zX3JedhphuESKouLmwDLoLzIYbpEpLbaRW2NrJYXKcnICA0WA5V81aJ+HYp9ZD
 gBq70f5CtiWnBtlJw9geBHZZfu1R9QKlu8SGmP6zphjTUwBZFkvf7AfsMirX49G8WNH6X
 p4nWkl4TniRZXbCoriNgdVQjCYidgjlCx9z4ybSrxPOxU/sUKqYlTsrUYV20LXVr9/MFR
 LMGRfHlEy3jjWQN/en9rReWSMTK98827ALmL0DxWAcFufwDa1EY6WHtUl5u5HzqjA9ORs
 DIrk2k9C+VjRFXIJwldj6V8kc5QtF6t9E19AG5i8bJDmpG0DVioNsa957LHJJaQ/NOQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=hY7dVHfJ; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=hY7dVHfJ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 326648116A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C12801A12F4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 95D0E60398;
 Fri, 23 Oct 2026 10:10:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 135E010328FE8; 
 Fri, 23 Oct 2026 12:10:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792750211; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bZcYOjHWlNivyX1fzrWoDlBI9wJ9ds6veVTmGd7507Q=;
 b=hY7dVHfJJSco1Boh8lC+KN7ctvF09fa3CJRI1Wv+EM/lkJK0/TE6z+ZgjIMUdJlbpU5iD1
 q939zl9ZGRIP8p3CIcCqs88CsaNwSG0Pb+nWGcloXkNpoZvYtmc+GRqVgF70OcD6gh0zcC
 mB5C+gs/ineGcX/+7ETtSPh4lnlfc7DD/frC1ezIIMP8QHTFluQzP6gqiJ1wYx3wtce6n6
 LASFtuKElpO+xS4j7qh7+wKfPpQei7dcRKFamJltERxGrZF1dnfr78hM/SeHf666IkLRI2
 npo4SZjYLvGMTq0hwDipcaowniBodFH2B+vo2Y4YlUNX1oR9qqiJfeWEF71hDQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Fri, 23 Oct 2026 12:10:08 +0200
Subject: [PATCH 1/2] omap4_var_som: extract MAC address from EEPROM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mac-eeprom-v1-1-f7a5817d455b@bootlin.com>
References: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
In-Reply-To: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The board's MAC address is stored in a Variscite custom blob in the
EEPROM.

Enable the I2C bus hosting the EEPROM in the device-tree / pinmux.
Enable EEPROM support in the defconfig.
Extract the MAC address at initialization to populate the ethaddr
environment variable.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi       |  7 +++++
 board/variscite/omap4_var_som/omap4_var_som.c     | 37 +++++++++++++++++++++++
 board/variscite/omap4_var_som/omap4_var_som_mux.h |  2 ++
 configs/omap4_var_som_defconfig                   |  4 +++
 4 files changed, 50 insertions(+)

diff --git a/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi b/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi
index 431a02b2ffd..2750ef97b6d 100644
--- a/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi
+++ b/arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi
@@ -41,6 +41,13 @@
 				status = "disabled";
 			};
 		};
+
+		/* I2C3 (eeprom) */
+		target-module@60000 {
+			i2c@0 {
+				status = "okay";
+			};
+		};
 	};
 };
 
diff --git a/board/variscite/omap4_var_som/omap4_var_som.c b/board/variscite/omap4_var_som/omap4_var_som.c
index f2fc790dd4b..8348cad4f9b 100644
--- a/board/variscite/omap4_var_som/omap4_var_som.c
+++ b/board/variscite/omap4_var_som/omap4_var_som.c
@@ -7,10 +7,13 @@
 #include <asm/global_data.h>
 #include <asm/mach-types.h>
 #include <asm-generic/gpio.h>
+#include <dm/uclass.h>
 #include <env.h>
+#include <i2c_eeprom.h>
 #include <init.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <net.h>
 #include <serial.h>
 
 #include "omap4_var_som_mux.h"
@@ -113,6 +116,37 @@ void emif_get_device_timings(u32 emif_nr,
 	*cs1_device_timings = NULL;
 }
 
+#define VARISCRITE_BLOB_OFFSET	0x600
+#define VARISCITE_BLOB_MAGIC	0x43535256 /* VRSC */
+struct variscite_eeprom_blob {
+	u32 magic;
+	u32 rev;
+	u8 eth_mac[ETH_ALEN];
+};
+
+static int extract_mac_from_eeprom(void)
+{
+	struct variscite_eeprom_blob blob;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_I2C_EEPROM, &dev);
+	if (ret)
+		return ret;
+
+	ret = i2c_eeprom_read(dev, VARISCRITE_BLOB_OFFSET, (u8 *)&blob, sizeof(blob));
+	if (ret)
+		return ret;
+
+	if (blob.magic != VARISCITE_BLOB_MAGIC)
+		return -EINVAL;
+
+	if (is_valid_ethaddr(blob.eth_mac))
+		eth_env_set_enetaddr("ethaddr", blob.eth_mac);
+
+	return 0;
+}
+
 /**
  * @brief misc_init_r() - VAR-SOM configuration
  *
@@ -147,6 +181,9 @@ int misc_init_r(void)
 
 	writel(altclksrc, &scrm->altclksrc);
 
+	/* A failure in the MAC extraction must not prevent from booting */
+	(void)extract_mac_from_eeprom();
+
 	return 0;
 }
 
diff --git a/board/variscite/omap4_var_som/omap4_var_som_mux.h b/board/variscite/omap4_var_som/omap4_var_som_mux.h
index fe0b99daf75..ac72a2b03db 100644
--- a/board/variscite/omap4_var_som/omap4_var_som_mux.h
+++ b/board/variscite/omap4_var_som/omap4_var_som_mux.h
@@ -14,6 +14,8 @@ const struct pad_conf_entry core_padconf_array_essential[] = {
 {GPMC_NWE, (PTU | IEN | OFF_EN | OFF_PD | OFF_IN | M1)},  /* sdmmc2_cmd */
 {I2C1_SCL, (PTU | IEN | M0)},  /* i2c1_scl */
 {I2C1_SDA, (PTU | IEN | M0)},  /* i2c1_sda */
+{I2C3_SDA, (PTU | IEN | M0)},  /* i2c3_sda */
+{I2C3_SCL, (PTU | IEN | M0)},  /* i2c3_scl */
 {UART3_RX_IRRX, (IEN | M0)},  /* uart3_rx */
 {UART3_TX_IRTX, (M0)},  /* uart3_tx */
 };
diff --git a/configs/omap4_var_som_defconfig b/configs/omap4_var_som_defconfig
index e906b98025d..1f3557dc1c4 100644
--- a/configs/omap4_var_som_defconfig
+++ b/configs/omap4_var_som_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_SPL=y
 CONFIG_CMD_ASKENV=y
+CONFIG_CMD_EEPROM=y
 CONFIG_CMD_BIND=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
@@ -65,6 +66,9 @@ CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 # CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 CONFIG_MMC_OMAP_HS=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_REGULATOR=y

-- 
2.56.0

