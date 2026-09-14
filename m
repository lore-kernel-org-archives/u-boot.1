Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E024C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 13:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46BBA80DE9;
	Mon, 14 Sep 2026 13:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id COQKmpcT3C3r; Mon, 14 Sep 2026 13:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 104B780C06
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789392969;
	b=DtWiMIQMcP9e+2QjTQmvZ+VxqidUpHdiRdnz1mQYnJaIkKNkQR5uVTgrm+lXzvI4d3Nr
	 SS2w+LXihWkz3Sea14u0Dcm7DtjeUPdHswK1ns01d8fhRx5ZLZQ5MIK0++cqPl4ZDdhpw
	 4jUvFDvnCRRpW4u89ETsV4sdG7R89OMQIrEcAsWUB4sCstd1RvXle2D5B/I8R/xm1bsiw
	 MWF7s2oN//Tj6lM0Gy8ncBH4TJxCfhvVuuEzvzvKU+N8d23qvR+sLaOWpCxHo1L7Rl+Ee
	 sPJFI/yhEh1BmcHuXFNZaUZgANS+F+SGpBxlwG7JW5X+8MHwhyVamlsBBCtDao/fBgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789392969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H+P/6H0vHByfhAifNKAI1WZUAR9D2zGJC8PCQjZz4vo=;
	b=keZtpszZgt1xFYEHORYvKOrdvJZK7G+qN9a8Vl6OsZ3XG0nO7HMZEd5tpE+or5i62mR3
	 gkaC2F/BL3jnvI0hSQvnhauaNcrDSXeofoH6KZsZ+jbV1EmGfMcbWWibyhfPqfBvB9bDs
	 V0TTqka+/0QvR6SjOHvwSkpn9KQzC7wl0lQhNCLsBDjrkCWCxYS7/nikAp442pESwVcjD
	 WcUhIbkzfvObXVimrf81kJJRLil/sjf6yY3Uw3cW6cl5cwchLtEn82BcHAWHRVWtfU3Sd
	 VHbhgvoxjKbCd7MN474ijMf/L16o+B1He+Pu8f4I8rYM0RyTptxnnQ1mLGBt1lswwxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789392969;
	bh=H+P/6H0vHByfhAifNKAI1WZUAR9D2zGJC8PCQjZz4vo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twA8flzBwwO4Y4B+6/vpIhBWWH4RKM4yeoRjx9EPReRImDUktHUwMaaD77/wFGVja
	 2LO7ANoTCYQlvGDf38xby/mNL5ip6ONIWTzHF2kJVsGQ/grCxUO961FR+G17L/MmkY
	 KDeyIjco8ZRawIiGuYAUoCC17Pla63dOwnLhj5WNwjcm0iGM6+CPVg6kMcSqCs+pdB
	 G/DJNcyFk5Yj2Hq6Q8T9CcCYajhndbOzETYx2IRakFbK3EBXTPl87h04I+BneIPk2X
	 4CpQhRBkwZ6SaalCiYtYy3wTQYPJTi/TtlYSHwUXZRMmBKd3GBS9NFAmPwBYgIB5EH
	 AefFPr1t8tmyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 104B780C06;
	Mon, 14 Sep 2026 13:36:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C2BB224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A46540071
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlTVx9jRhmOp for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 13:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EF2CB40026
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789392964;
 b=nITNVY4LIFvNYEhzYHCV2mPVtv3c78gNwHqg0fd/LOtxFHri9z87iqMCLLAJc5zm6v6w
 iK6SV7AKjZq6B8KRxBhI6NrlBF4IoDL8vfgcUPlxsKwF7Ca+0j3RQzqOwH0f1eblxvI/D
 YAjtumW6CilR7s3LfGS6zoK1nosPRe7is+s4N2PzdG/watd7vwjkX8JGVGl4TnTDWyT9N
 7X4wG/ZwfSiOVJKRTjSLkPHDoT/zL/hoDZWbp4+drs4en3/r5nInhbFpV1DV9YLKg3+d+
 nyl9uVSrbBULWPAVQEajW7Ong8nEQ6ONNOTx4aiAOEZcK5iM3MaBdWeSGB/mhwgV28Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789392964;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=H+P/6H0vHByfhAifNKAI1WZUAR9D2zGJC8PCQjZz4vo=;
 b=HiIxNG65n0+S/vLZ5AIWBGNohxZQWtRar+4aONC/uNsyB3fpCz7SDFGdV7pA1ZS4qZ9I
 w9a9zkrsBKiI4Q/eExRJ7e/IsBZhQ0dtBPSfgM55zCER0xv2IiVTFqg06V3xlKNXKkxZx
 UaZskYDF02L/niOWtNqzXLrobQC6DdamiIl14dEiWSut5mkChd/ypEwovyzYfrho2Sm4Z
 A85FHW3hxCFgleTjLtoYMllNk/QKN8EngNTIlnBEQgXBZrZFKrGp7bk9Y3MjuY8g/tHQ1
 +GJwxcLpqjN/az0wI/2fw7n59hQGa6inHUM8qIBMDbSIYcOBs4Ps/j24xWxZ79M/7NQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NKv18bu+; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NKv18bu+
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF2CB40026
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:03 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so11620755e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789392961; x=1789997761;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H+P/6H0vHByfhAifNKAI1WZUAR9D2zGJC8PCQjZz4vo=;
 b=NKv18bu+jW/4parNptXgw37Cbir4CMPk6KlNtdmifN71t0zGcuc23xrndfXkaRBJ6p
 ljIKUIAJ+dqXWNENJDzVF4Qb+Y/zoYwETfwsVFFZk6xZw4+6IGwJbl6Nj5TDN2nWeu2J
 /nQjMMg+NuC6SiUtwapmuI+x9feIeqKUr2DHsiSJh354YScCRAqHxIDjVZMKaVnQBIK5
 FRcDpTqvBUxAr6AIQ6GDmeAlJ944gKNQ4lNM0fX5VTT64NmlcqoewMikt468X6LDIwYF
 z4/MlutdoYefep63vpSKkBWQEvJzy4miYg2fabrfgaO+ulcT9wMNSd79ZVkXT3IWg2cT
 U5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392961; x=1789997761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H+P/6H0vHByfhAifNKAI1WZUAR9D2zGJC8PCQjZz4vo=;
 b=imzmfPQNRButPYUrJV63BjJegsm0dVUqSWjT3KvX620HM5u8PVTn39A1f9FAAhGeSt
 mNg3BBYdfcJzfWiEPDc3aB+5qfSUiwvLe71Mw6Cb4E7+35BtAoYmMkMfwcv+8mZb7a7c
 GXVI8wauuNQ6gRhUfZw8Z80U4zIa0x4XUbmBcCWBE8S832FjxD3BUqgVew2J+l4Vdo6W
 KpzIUABuWqZeVIKDTJU/bfPp/Q7FIPxsmLCIiwR9ZR90W73y31nR7OBUU/53tXV1j49x
 +/MjM3louUvLuYeqMNngzzZiktf6uP7CF9s3et4T2Eqr7Stu1P7r3kRIqPltDwqpNOwG
 1qQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPO3uOGjC3U6Mm84jekLAMERBgfxwxN2qwcTD520/AzaUiWSL4DzTvnD+qIzzae3/gbFKZP0c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nLrbDZNiBBG81J2YHbRA3C2kRgpyfk5cxe0FQumFzhUv3GXowF
 BVzz1niXz4s6PPBt02XYdXgRasmSAavxrRns7F3xqoJ3ZjCips8sXc89QN4OClZ90ME=
X-Gm-Gg: AYBFou3DD9vY3pVysQcAH658nJgiucN0LuR99apiEhLZ92KfoLtyddTmyqxcXn4u09w
 +PMWVzN9KtoY8tOAXFHJoNT9Al07pdBuAF1ItWKxtBv1BiTIfRY1H7ZeI1FjoZRG1GlphtZ5Vtf
 E19YE8V6pweDZqoGnP/XbnubOdh6miPHQfh4clOQLhMlTZbl+GWFG/7KRXCIWuKjFgji4qUaPwF
 YcjZJF9LATMAIH5B0e8dHOEAVlQGlsBXkwyFQZNevHvAX/3ph/wZaS7mdPsUsaovCiJ10v6jbiT
 TS5FeVcH+uBiacJaD4EiRagfb9LSRAkvXd1uowfi9H6Xunb5W45q66lD5sLl/2YevPRTJ+/nWZ4
 86rrweT0qTqhmP0WIEQu5WxwdqHEEPWmigKcwNdG8lifal+BEuH4PriV04oJqxUfFo1WQ/yyURh
 2CwuB7p1+v2PdpW5Ek9p848xwZwHqOdd8JU9WXq3FJTcHzX3VETe0NdRICL5cBbhrqkuyIU/Y2p
 W27v25U/4z1yR4IbevfDdSbTxL8cWY6TM8VdwPHhMKTtUBtARQAcZGsFkb9VJkAdKhsjgTwI0AL
 OL8qhCh79I8EQ4BMDxPFvqdzew==
X-Received: by 2002:a05:600c:6090:b0:49c:fa21:1c7e with SMTP id
 5b1f17b1804b1-49e7a68c9bamr26484545e9.19.1789392961138; 
 Mon, 14 Sep 2026 06:36:01 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6c0cb676sm236400905e9.14.2026.09.14.06.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:36:00 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 14 Sep 2026 15:35:45 +0200
Subject: [PATCH 1/3] arm: mediatek: enable SPL fastboot DAs on Genio 510
 and 700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ccaione-upstream-mt8390-da-v1-1-b76f9e30ac38@baylibre.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

From: Julien Masson <jmasson@baylibre.com>

Genio 510 and 700 need a provisioning and recovery path that remains
usable when eMMC is blank or its boot firmware is unusable. Add a RAM-
based fastboot download agent so boards can be flashed through the
MediaTek BootROM download protocol without a working on-device
bootloader.

Running the agent in SPL avoids a dependency on BL31 and U-Boot proper
during provisioning.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8188-genio-da-u-boot.dtsi           | 55 ++++++++++++++++++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      |  4 ++
 arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi       | 16 ++++++
 .../dts/mtk-genio-loader-spl-binman-u-boot.dtsi    |  6 ++
 arch/arm/mach-mediatek/Kconfig                     | 26 +++++++++
 arch/arm/mach-mediatek/Makefile                    |  1 +
 arch/arm/mach-mediatek/spl_fastboot.c              | 65 ++++++++++++++++++++++
 board/mediatek/MAINTAINERS                         |  5 ++
 common/spl/Kconfig                                 |  2 +-
 configs/mt8188-genio-da-spl-fastboot.config        | 15 +++++
 configs/mt8188-genio-da.config                     | 19 +++++++
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 +
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 +
 14 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt8188-genio-da-u-boot.dtsi b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
new file mode 100644
index 00000000000..e9078f37157
--- /dev/null
+++ b/arch/arm/dts/mt8188-genio-da-u-boot.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-da-binman-u-boot.dtsi"
+
+&ssusb0 {
+	dr_mode = "peripheral";
+	mediatek,force-vbus;
+};
+
+&ssusb1 {
+	status = "disabled";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+&pericfg_ao {
+	bootph-pre-ram;
+};
+
+&ssusb0 {
+	bootph-pre-ram;
+};
+
+&u3phy0 {
+	bootph-pre-ram;
+};
+
+&u2port0 {
+	bootph-pre-ram;
+};
+
+&usb_default_pins {
+	bootph-pre-ram;
+
+	pins-iddig {
+		bootph-pre-ram;
+	};
+
+	pins-valid {
+		bootph-pre-ram;
+	};
+
+	pins-vbus {
+		bootph-pre-ram;
+	};
+};
+#endif
diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 10b9a142f37..608987ca6d7 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8188-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 6230b016ca0..6c6c85e8767 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -14,3 +14,7 @@
 #include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
 #include "mtk-genio-bootloaders-binman-u-boot.dtsi"
 #endif
+
+#ifdef CONFIG_MTK_BROM_DOWNLOAD_AGENT
+#include "mt8188-genio-da-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
new file mode 100644
index 00000000000..ad337bf1784
--- /dev/null
+++ b/arch/arm/dts/mtk-genio-da-binman-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Carlo Caione <ccaione@baylibre.com>
+ */
+
+&binman {
+	da: da {
+		filename = "da.bin";
+		pad-byte = <0>;
+
+#define MTK_GENIO_SIMPLE_SPL
+#include "mtk-genio-loader-spl-binman-u-boot.dtsi"
+#undef MTK_GENIO_SIMPLE_SPL
+	};
+};
diff --git a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
index 2dd13d261a0..503ae06da34 100644
--- a/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-loader-spl-binman-u-boot.dtsi
@@ -12,6 +12,11 @@ ddr-loader {
 	size = <CONFIG_MTK_GENIO_DDR_LOADER_SIZE>;
 };
 
+#ifdef MTK_GENIO_SIMPLE_SPL
+u-boot-spl {
+	size = <CONFIG_SPL_MAX_SIZE>;
+};
+#else
 #ifdef CONFIG_SPL_FIT_SIGNATURE
 u-boot-spl {
 	type = "section";
@@ -31,3 +36,4 @@ u-boot-spl {
 	size = <CONFIG_SPL_MAX_SIZE>;
 };
 #endif
+#endif
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe8571..59489c0fe65 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -249,6 +249,32 @@ config MTK_GENIO_BL31_LOAD_ADDR
 
 endif
 
+config MTK_BROM_DOWNLOAD_AGENT
+	bool
+	depends on TARGET_MT8188 && SPL
+	select BINMAN
+	select MTK_GENIO_IMAGE_CONTRACT
+
+choice
+	prompt "MediaTek BootROM download agent"
+	optional
+	depends on TARGET_MT8188 && SPL && SUPPORT_EMMC_BOOT
+	help
+	  Select where to run fastboot after the BootROM downloads the agent
+	  into RAM. Leave this disabled for normal storage boot.
+
+config MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT
+	bool "Run download-agent fastboot from SPL"
+	depends on SPL_FASTBOOT_FLASH_MMC
+	select MTK_BROM_DOWNLOAD_AGENT
+	select SPL_BOARD_INIT
+	help
+	  Build an SPL which enters USB fastboot after the MediaTek BootROM
+	  downloads it into RAM. The download agent also configures the eMMC
+	  boot partition so that a newly flashed board can boot normally.
+
+endchoice
+
 config MTK_TZ_MOVABLE
 	select ARCH_MISC_INIT
 	select OF_SYSTEM_SETUP
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 35f748a70d6..42b83b82f77 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
 obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
+obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/spl_fastboot.c b/arch/arm/mach-mediatek/spl_fastboot.c
new file mode 100644
index 00000000000..0ba76d47dfb
--- /dev/null
+++ b/arch/arm/mach-mediatek/spl_fastboot.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <dm/uclass.h>
+#include <fastboot.h>
+#include <mmc.h>
+
+static int mtk_mmc_boot_prepare(void)
+{
+	struct udevice *dev;
+	struct mmc *mmc;
+	int ret;
+
+	ret = uclass_get_device_by_seq(UCLASS_MMC,
+				       CONFIG_FASTBOOT_FLASH_MMC_DEV, &dev);
+	if (ret) {
+		printf("Cannot load MMC device: %d\n", ret);
+		return ret;
+	}
+
+	mmc = mmc_get_mmc_dev(dev);
+	if (!mmc)
+		return -ENODEV;
+
+	ret = mmc_init(mmc);
+	if (ret) {
+		printf("MMC init failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable BOOT1 and boot acknowledgment for normal BootROM startup. */
+	ret = mmc_set_part_conf(mmc, 1, 1, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot partition: %d\n", ret);
+
+	/* Reset to x1 SDR, backward-compatible timing for each boot. */
+	ret = mmc_set_boot_bus_width(mmc, 0, 0, 0);
+	if (ret)
+		printf("Cannot configure the eMMC boot bus: %d\n", ret);
+
+	if (!mmc->ext_csd[EXT_CSD_RST_N_FUNCTION]) {
+		ret = mmc_set_rst_n_function(mmc, 1);
+		if (ret)
+			printf("Cannot enable the eMMC reset function: %d\n", ret);
+	}
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = mtk_mmc_boot_prepare();
+	if (ret)
+		printf("MMC boot preparation failed: %d\n", ret);
+
+	puts("Waiting for fastboot commands...\n");
+	ret = fastboot_usb_run(CONFIG_FASTBOOT_USB_DEV, NULL, 0);
+	if (ret)
+		printf("Fastboot failed: %d\n", ret);
+}
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5b0d79320bd..27aeb4dff07 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -21,14 +21,19 @@ MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 S:	Maintained
+F:	arch/arm/dts/mt8188-genio-da-u-boot.dtsi
 F:	arch/arm/dts/mt8188-u-boot.dtsi
 F:	arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
 F:	arch/arm/dts/mt8390-genio-common-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	configs/mt8188-genio-da-spl-fastboot.config
+F:	configs/mt8188-genio-da.config
 F:	configs/mt8188.config
+F:	configs/mt8370_genio_510_evk_da_spl_defconfig
 F:	configs/mt8370_genio_510_evk_defconfig
+F:	configs/mt8390_genio_700_evk_da_spl_defconfig
 F:	configs/mt8390_genio_700_evk_defconfig
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f9b453df766..77da2f4c8aa 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -194,7 +194,7 @@ config SPL_SHOW_ERRORS
 config SPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in SPL"
 	depends on SPL_FRAMEWORK && BINMAN
-	default n if MTK_GENIO_BOOT_IMAGES
+	default n if MTK_GENIO_IMAGE_CONTRACT
 	default y
 	help
 	  This enables use of symbols in SPL which refer to other entries in
diff --git a/configs/mt8188-genio-da-spl-fastboot.config b/configs/mt8188-genio-da-spl-fastboot.config
new file mode 100644
index 00000000000..01b35f1144e
--- /dev/null
+++ b/configs/mt8188-genio-da-spl-fastboot.config
@@ -0,0 +1,15 @@
+#include <configs/mt8188-genio-da.config>
+
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_PHY=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_USB_MTU3=y
+CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_REBOOT=y
+CONFIG_SPL_FASTBOOT_FLASH_MMC=y
+CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/configs/mt8188-genio-da.config b/configs/mt8188-genio-da.config
new file mode 100644
index 00000000000..d47bce044a7
--- /dev/null
+++ b/configs/mt8188-genio-da.config
@@ -0,0 +1,19 @@
+CONFIG_SYS_MALLOC_LEN=0x9000000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
new file mode 100644
index 00000000000..42ca29dfe1c
--- /dev/null
+++ b/configs/mt8370_genio_510_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8370_genio_510_evk_defconfig>
+#include <configs/mt8188-genio-da-spl-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
new file mode 100644
index 00000000000..ca58b131ed6
--- /dev/null
+++ b/configs/mt8390_genio_700_evk_da_spl_defconfig
@@ -0,0 +1,2 @@
+#include <configs/mt8390_genio_700_evk_defconfig>
+#include <configs/mt8188-genio-da-spl-fastboot.config>

-- 
2.55.0

