Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B15C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:13:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21C0560A46;
	Thu, 23 Jul 2026 15:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGlO7lB_LbL2; Thu, 23 Jul 2026 15:13:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ED7760A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819638;
	bh=9OjOZCEth1UBaPS+ia5OChpYRGF186exxipG0yufS8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=da3H0QbQao58n1kVDgPnn+CM26cazq0N29MUrZ6UO+hixnBgfPeuUwdocsOSKBrSi
	 B+jbhPV98cO5Su9ZuXeh+avsRhRfLMNRCawC7cngXRWSn1U6ilJE0dYkMz5eiIXZoi
	 WfLcg0bayzBxbrx5L3oqj9z84I1mZnwHn3ZhaOtJMqSvbYctTnWIiGKn76hGLh3h1J
	 Ps0lQLk3usq+dKU2n+DJOOKyTW5OTnUiqy3WM93tkZ4RIEq5TVbR8qRhxWn/CfoJPE
	 10rVVzAl1CZGxRH/jDil7XfLiLCfAses/MsxyPlsp82wmLMOSPQmU15bHhzdt6xyvT
	 wA1aXdwqbdhnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ED7760A3D;
	Thu, 23 Jul 2026 15:13:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE653B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8227D409B6
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cnDIKaloCruZ for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2DC8E409B2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DC8E409B2
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DC8E409B2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:37 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso4512595e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813435; x=1785418235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9OjOZCEth1UBaPS+ia5OChpYRGF186exxipG0yufS8A=;
 b=ITqMdZOj3m4xycHZNiSpEsoWc8Y7xwI12YNXwNC86J7HPHdXaAnX7RM5wFQi8RuUpH
 CpZN6IvLZon2E7m9JrXedYepUhn2xCnZLKho+X8TlhdIWBy9OLZaX3hR9BjvXevP6+wm
 rA9B/cVrDpJ0ywlun3SPOw2pjD8G+2hHs9qzp8WexjHiMJL4CV9fqzKe0hkEaPGWkVQ3
 pzjvH5tbqOI/uhTqwEI+4XT3ByUjAIREVSIkqWvFZ8vwA+2MEmO73iZ8dDJAWbNzeKPq
 HMizn8Jkdm4byMnBarZUC64Pt4fAnhegjpgLHEqMAAt5iGFpxxBsxh7obERHFEOegW7X
 dpXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUEf+16/cJF53nKhRN08UJTR3un7yIX/SWusU42OK/cYe2MW+OHi7h7qhS9x7ZCh5UUWLAed8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwYwCwHaCCA2IS4p4/iRlnVEEJy0qTDLudU+7BVrgEwkzzpuoOp
 VWMFqC/gZzX9BIBYlcguwCaBx7SRja5ZES8kr7Rlx94Yc8JmN0jgP8/UDvNTpTgd/AQ=
X-Gm-Gg: AR+sD11FCUucv0jJQLtQSChlbax5QVXfkZA0TVKJ68wI9n+0phPL40PH2xCq90CxPsv
 NVQDBn76URyWabBe5k27mE+qVjJhrNNs8PnXdwTzdVbiAsZcnQS2igdToxHkelcI35tLnazcXIf
 NfXPS9XKMGfIBNouRdq4wdkBqcMIuxWU1DCFUdHlKBGWknRAK4aCt6ByhbUKgFSSkx09odpYnbd
 D61lLobBxzMpUAGt99iXUL0+MhJInqfLXhdxl0ErtOK2uVtZnGAew3Y4gBCcM9+bzRJruYDLuSE
 i7d1U9GdYqg6HNmXZ2fkuJ8BHQDrAH8HyZ7umEOlqOtYxupUZ8a3sKcf0/GyqUP81nTZGDmKVhU
 RG7TQ4gO/8ONA0pEWEJYT489Kfw2Brhlh5RI7GN+ucGllr8rjwawdpXbeYdUDUsTIqhFSu/9q42
 k=
X-Received: by 2002:a7b:ca4a:0:b0:493:b56b:c45c with SMTP id
 5b1f17b1804b1-49573cf09f4mr22330435e9.30.1784813434683; 
 Thu, 23 Jul 2026 06:30:34 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:34 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:04 +0200
Subject: [PATCH 3/8] arm: dts: hpe-gxp: enable GXP EEPROM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-3-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=1744;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=Q+0cH8GBGSBkz8iErs3m0rEdaDhKB2H18DJLWL/IdLI=;
 b=FWhWkK03AmkhjM748qYr+PesCi+v2jmkblV/xpCNrSv5njWVA1J9o7wPVclkL8H7cZZBozUX8
 +Z1Bk3o4ztlD3fmNwlOHNfboU30mBvmnyCcO9rz4UwrFHo1jJurTJux
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813435; x=1785418235;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9OjOZCEth1UBaPS+ia5OChpYRGF186exxipG0yufS8A=;
 b=D1Fexp1tqp/UfMEt/XLqSVZiF4TZTOAxvtpDcFFKUtGPvW41DJxSxNZ46Vqv8/MIfw
 uRHz6qpn4w3kOwnNGYYKmiXfuV3ddEGITo/DLReEgM5C68Zznsbow0JSl0KseZckLhfA
 jS0bmFu+R0JIM4CqLLUi9G9A7xzqvkizIsp3ivX32wm3KQaAv1/YkJelZK9tkF6RQ6LK
 +HgXrYwhU0AKWjlH0SIlucLfPgZkFCuQJErU0RlD1Cpz9HDPAZYLupwDQkXphf1HeoAO
 +bKks5tcCZUuDk+qUs/fPxhsaOgnl1jN+EO5GehTiH+4EStbOlgOEL+TsAMxM1WzuPxo
 t+wA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=D1Fexp1t
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

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Enable the board information EEPROM in the GXP device tree to collect
the MAC address, as well as the serial- and part-number.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 arch/arm/dts/hpe-gxp.dtsi | 32 ++++++++++++++++++++++++++++++++
 configs/gxp_defconfig     |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/dts/hpe-gxp.dtsi b/arch/arm/dts/hpe-gxp.dtsi
index cf735b3c4f3..fa174bdc582 100644
--- a/arch/arm/dts/hpe-gxp.dtsi
+++ b/arch/arm/dts/hpe-gxp.dtsi
@@ -45,6 +45,38 @@
 		ranges;
 		dma-ranges;
 
+		eeprom: eeprom@a0017f00 {
+			compatible = "hpe,gxp-eeprom";
+			reg = <0xa0017f00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bootph-all;
+
+			serial_number: serial-number@1 {
+				reg = <0x01 0x10>;
+			};
+
+			part_number: part-number@6d {
+				reg = <0x6d 0x10>;
+			};
+
+			mac_address0: mac-address@84 {
+				reg = <0x84 0x6>;
+			};
+
+			mac_address1: mac-address@8a {
+				reg = <0x8a 0x6>;
+			};
+
+			pca_serial_number: pca-serial-number@90 {
+				reg = <0x90 0x10>;
+			};
+
+			pca_part_number: pca-part-number@a0 {
+				reg = <0xa0 0x10>;
+			};
+		};
+
 		L2: cache-controller@b0040000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xb0040000 0x1000>;
diff --git a/configs/gxp_defconfig b/configs/gxp_defconfig
index 7821759f83d..2369b4cd07d 100644
--- a/configs/gxp_defconfig
+++ b/configs/gxp_defconfig
@@ -39,6 +39,8 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_NETCONSOLE=y
 CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_GXP_EEPROM=y
 # CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y

-- 
2.53.0

