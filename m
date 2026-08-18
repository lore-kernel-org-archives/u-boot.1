Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D42BC5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 00:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 257DD60611;
	Tue, 18 Aug 2026 00:21:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vz2RXK0fSKzV; Tue, 18 Aug 2026 00:20:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA0886063A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787012457;
	bh=3MDYWdAgjHmhpGGLWyWf1wjrn7FB3AnCZkDKWgw0ajU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zgtoTIHnnwHXchLZAVcT60YyI3VM0D7vvepGkIzFXC96xu9Lf6WxhzjzjaNdBv+pa
	 6WaCn/VdHp3qrSG+V+E5+UIm7punrDB7ZeyhrvQ6cokKKeopnsrccdbyh7JWvQ+L1J
	 zfJCNIfpb/V/2osx3wXAmqadoU3YKxelPeCy3chV/6F8PjRQtUZqGIGkRpi/qe5RX/
	 WNkBrOWMFj8ovk0uzRHWOb/naX/P0fsgPkXN0xMBuJU2/kTV+4sQlqDK8CJm59FyxC
	 N31LFhOaWbYOGY5G/lEiqYf8qKoNo10oY4zG1MB1TbwoEbZCNXS3snqTuNbp3MmW5Z
	 HED3lTWSVvtQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA0886063A;
	Tue, 18 Aug 2026 00:20:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6510F282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 00:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49A144085D
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 00:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bVyGiVWxz5eb for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 00:20:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 206F340857
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 206F340857
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mludvldI
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 206F340857
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 00:20:49 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7eb5bdb50fcso2583358a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787012448; x=1787617248;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3MDYWdAgjHmhpGGLWyWf1wjrn7FB3AnCZkDKWgw0ajU=;
 b=mludvldI9OZ7jcYgbYLMYh8TtVbAzLxndd0NJW+nBflF+gPISBGUxa7pREyE5JVuRK
 7xeZ7Tbibh89kzRigYD8L47NteYw24t7yxzbbs/l5JKAUTjogwhP2c3cmip6WRg08VRk
 b/7l1gM0Ixm2CCLRHK3t+hqPvjRfP1Q97BCYr9t2pUBD4D9FpaGYVsfI4TWKrBzXdGWQ
 I5wFT0OY8Oxpo3y2lkt58QIu5pccGM0wlVE/RC9IC4gKidOuyv4PwNkwJRLCLm4vBMP8
 cVIJ4GaJmxzIa1K/uMUTr9HlEnY825PBmRMJU/Ho++LlmQllj/8Fz+ukSVRof+SDI11R
 4BaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787012448; x=1787617248;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3MDYWdAgjHmhpGGLWyWf1wjrn7FB3AnCZkDKWgw0ajU=;
 b=dMciKIejiY2TqFQ+WvHkOdmOegK5iocMMtqp0ULYX2cHsCBYhCZVLZCPNv+LHru3zz
 1HB5/xALHsYueAD/o8oFfbwlLc35xAAFqJHge3Kc/rTl+DjAZLdctFAvatOesjw3I/He
 PzQGvBJYd81jcTen7hElZ2i0/2oEqIY9gB0Au0T9f4mtjezYjuecJ/ulQ6ytF7PnPWoB
 B5zEeK+1gkUzbBcHTjNgjWQ+nsn6/ErQX0ZSRZjP+OKMAUt1wOKkxKNHZwvWBIgjjgL+
 sboG7h+pEHnX5kuqdWprzHQHGGNbZqxXZMJe/xy+Xxz36ObKZ8p3kMSg5J4aUSlc5L2s
 PZEQ==
X-Gm-Message-State: AOJu0Yzd90HA+aCtS6fmjM2QCYqtKK4vXvojKcmpXEPj+9ibFbqgi3hF
 kdzKTMYD27//eBkjQC5qDsrd/kOkBy3yhsr30KCoREIwiY4FAMQ6kM6sgU7VzHzjlsw=
X-Gm-Gg: AR+sD10RAVqEI/GUlUILW5vmVzOBROn3V7pmUsSaAvlBfi4HLgOUr8k0EdDdPdc4Mde
 8RnBeoOC+mj6hSTvviqMi6jNfLEa7pSUlAnp5Qci1MRK930H32D6t2s7Y7WBNbEncGI5SF5gaRW
 Nus7h2P6hPvS0HfhtsaRV08YiOVvuPp00MMPeHdPf/q+tVrqH/tiuMTb4Fv435m3x4FRfz7P6W0
 WHjC//pzyffDIBdKQemZGHiEHFM9inzHRni49pC+xj0TVB4kmg9oYgDWr4PDW/OQ6NOK9Fm5QgL
 +PB9pHYTL97q4F4mwAFPVUSm3CyrvOYRl5piHYtvQ4GsrB6UpMXbZbPFVoO9gqkqwTvP/gZAqlf
 XNP0E9brhxcIKTYKGpk8tZFEVBn41Vf66o2ZNmF8daFAIfHaeM0qLiWO6cxwdfbMN2g5oKGXT5l
 RcMmlTxx+ZPATEtjA35ZgadOGiss97BiSok2ewHHrI19g8KuBVDDDYFiEbAfOf3qnTng==
X-Received: by 2002:a05:6830:348d:b0:7ea:b8c:4198 with SMTP id
 46e09a7af769-7f3de5410fcmr32761300a34.8.1787012448651; 
 Mon, 17 Aug 2026 17:20:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7777:83a7:41ea:5906])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41beef430sm2877557a34.5.2026.08.17.17.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 17:20:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 17 Aug 2026 19:20:30 -0500
Subject: [PATCH] arm: dts: mediatek: remove mt6357.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-mtk-dts-drop-mt6357-dtsi-v1-1-fe6ce3fdf1c0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5DQBCA4VeROZtkaVjtq4gDO0OnTZGdrUjEu
 1scv8P/b6DshRVeyQaeF1GZxogsTcC923FgFIqG3OSlqTKLv/BFCorkpzmifBT2tCA/iSy71pq
 qg5jPnntZr3Xd3NZ/92EXzh/s+wGZqF2CfAAAAA==
X-Change-ID: 20260817-mtk-dts-drop-mt6357-dtsi-e9dd7eca708b
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8917; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TS6zxg+EOVIdxJh6vb8cbZ9UP2L4MVTF4YHLTsLb/z0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqg6VWYqlYPtVTzAs9OHWNsQ2vcVdfA6BNToi/L
 AvCDTN9uQiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaoOlVhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Aqe0IAJN3ao4V8uiDmdwaFJrNrlqHyAE/GmbEa7FhQr1
 sYceTEPsDYCpb+xfXC79WMUSDjdqxdDBunVFoqKDA3x8oFJK18677vLFwVxAkzSucNot/Tx5O4u
 DE+hb+PPwxx5gxZ4NYK+lzZjXm0EwqpvYw2YYAOE24KemNrvquNzLtUKFKKzMb/B1djK9+eKvFf
 3Qb+dNlNzoshZFeTGpOtvwn4eXP7Pc8/6KsQydkaZNT7TGEQWCW/q63wfb40tArpKP20DoNGr3N
 Yqt96iFkG+QJoTnW/k+7bM2CCKHqvn8fiDPu9iWtism7CxcreMnDjEFsSZyqhJgeMIc2mlMws7s
 fwQs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove the downstream mt6357.dtsi file. This is no longer needed since
it is available upstream. The upstream version is more correct/complete
as it doesn't have incorrect `compatible = "fixed-regulator"` properties
on the regulators and has an adc node (not used by U-Boot).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt6357.dtsi | 282 -----------------------------------------------
 1 file changed, 282 deletions(-)

diff --git a/arch/arm/dts/mt6357.dtsi b/arch/arm/dts/mt6357.dtsi
deleted file mode 100644
index 3330a03c2f7..00000000000
--- a/arch/arm/dts/mt6357.dtsi
+++ /dev/null
@@ -1,282 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (c) 2020 MediaTek Inc.
- * Copyright (c) 2023 BayLibre Inc.
- */
-
-#include <dt-bindings/input/input.h>
-
-&pwrap {
-	mt6357_pmic: pmic {
-		compatible = "mediatek,mt6357";
-
-		regulators {
-			mt6357_vproc_reg: buck-vproc {
-				regulator-name = "vproc";
-				regulator-min-microvolt = <518750>;
-				regulator-max-microvolt = <1312500>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <220>;
-				regulator-always-on;
-			};
-
-			mt6357_vcore_reg: buck-vcore {
-				regulator-name = "vcore";
-				regulator-min-microvolt = <518750>;
-				regulator-max-microvolt = <1312500>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <220>;
-				regulator-always-on;
-			};
-
-			mt6357_vmodem_reg: buck-vmodem {
-				regulator-name = "vmodem";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1193750>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <220>;
-			};
-
-			mt6357_vs1_reg: buck-vs1 {
-				regulator-name = "vs1";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <2200000>;
-				regulator-ramp-delay = <12500>;
-				regulator-enable-ramp-delay = <220>;
-				regulator-always-on;
-			};
-
-			mt6357_vpa_reg: buck-vpa {
-				regulator-name = "vpa";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3650000>;
-				regulator-ramp-delay = <50000>;
-				regulator-enable-ramp-delay = <220>;
-			};
-
-			mt6357_vfe28_reg: ldo-vfe28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vfe28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vxo22_reg: ldo-vxo22 {
-				regulator-name = "vxo22";
-				regulator-min-microvolt = <2200000>;
-				regulator-max-microvolt = <2400000>;
-				regulator-enable-ramp-delay = <110>;
-			};
-
-			mt6357_vrf18_reg: ldo-vrf18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vrf18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <110>;
-			};
-
-			mt6357_vrf12_reg: ldo-vrf12 {
-				compatible = "regulator-fixed";
-				regulator-name = "vrf12";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-enable-ramp-delay = <110>;
-			};
-
-			mt6357_vefuse_reg: ldo-vefuse {
-				regulator-name = "vefuse";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcn33_bt_reg: ldo-vcn33-bt {
-				regulator-name = "vcn33-bt";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
-				regulator-name = "vcn33-wifi";
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcn28_reg: ldo-vcn28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vcn28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcn18_reg: ldo-vcn18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vcn18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcama_reg: ldo-vcama {
-				regulator-name = "vcama";
-				regulator-min-microvolt = <2500000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcamd_reg: ldo-vcamd {
-				regulator-name = "vcamd";
-				regulator-min-microvolt = <1000000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vcamio_reg: ldo-vcamio18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vcamio";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vldo28_reg: ldo-vldo28 {
-				regulator-name = "vldo28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vsram_others_reg: ldo-vsram-others {
-				regulator-name = "vsram-others";
-				regulator-min-microvolt = <518750>;
-				regulator-max-microvolt = <1312500>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <110>;
-				regulator-always-on;
-			};
-
-			mt6357_vsram_proc_reg: ldo-vsram-proc {
-				regulator-name = "vsram-proc";
-				regulator-min-microvolt = <518750>;
-				regulator-max-microvolt = <1312500>;
-				regulator-ramp-delay = <6250>;
-				regulator-enable-ramp-delay = <110>;
-				regulator-always-on;
-			};
-
-			mt6357_vaux18_reg: ldo-vaux18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vaux18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vaud28_reg: ldo-vaud28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vaud28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vio28_reg: ldo-vio28 {
-				compatible = "regulator-fixed";
-				regulator-name = "vio28";
-				regulator-min-microvolt = <2800000>;
-				regulator-max-microvolt = <2800000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vio18_reg: ldo-vio18 {
-				compatible = "regulator-fixed";
-				regulator-name = "vio18";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-enable-ramp-delay = <264>;
-				regulator-always-on;
-			};
-
-			mt6357_vdram_reg: ldo-vdram {
-				regulator-name = "vdram";
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1200000>;
-				regulator-enable-ramp-delay = <3300>;
-			};
-
-			mt6357_vmc_reg: ldo-vmc {
-				regulator-name = "vmc";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <44>;
-			};
-
-			mt6357_vmch_reg: ldo-vmch {
-				regulator-name = "vmch";
-				regulator-min-microvolt = <2900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <44>;
-			};
-
-			mt6357_vemc_reg: ldo-vemc {
-				regulator-name = "vemc";
-				regulator-min-microvolt = <2900000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <44>;
-				regulator-always-on;
-			};
-
-			mt6357_vsim1_reg: ldo-vsim1 {
-				regulator-name = "vsim1";
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vsim2_reg: ldo-vsim2 {
-				regulator-name = "vsim2";
-				regulator-min-microvolt = <1700000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-
-			mt6357_vibr_reg: ldo-vibr {
-				regulator-name = "vibr";
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-enable-ramp-delay = <44>;
-			};
-
-			mt6357_vusb33_reg: ldo-vusb33 {
-				regulator-name = "vusb33";
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3100000>;
-				regulator-enable-ramp-delay = <264>;
-			};
-		};
-
-		rtc {
-			compatible = "mediatek,mt6357-rtc";
-		};
-
-		keys {
-			compatible = "mediatek,mt6357-keys";
-
-			key-power {
-				linux,keycodes = <KEY_POWER>;
-				wakeup-source;
-			};
-
-			key-home {
-				linux,keycodes = <KEY_HOME>;
-				wakeup-source;
-			};
-
-		};
-	};
-};

---
base-commit: 7581a12eb96c8b8825b65a9c597696cb28cb6155
change-id: 20260817-mtk-dts-drop-mt6357-dtsi-e9dd7eca708b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

