Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A488606A33F
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oVxA6Mft;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=HRoT8WQE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF6E680DBD;
	Mon, 16 Nov 2026 21:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id blA71ZcKNgKV; Mon, 16 Nov 2026 21:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D091180D17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864923;
	b=XXFgQl4Dlo3PoQ7UWNlbIeKuTMc3RjfSpuQ8osE4CIgb9ZFMKC1A4sM3wvrEJXLKzphE
	 pvS8Qe5uvrA+2a1eT19DPYxw/GR9o0iUKbg3tdRfUijqgDwZhhbLqds4qWBYjeumt4jJF
	 JVj2I0mLOzBvnaQv+4Q3PaoGrS9LCoqB4BcO30pcjw4F9nZRxMv6nwGWzLHS6oy9p7ABi
	 eutX2fwSQD9CGL4te9YjuAaOWncAtHSKRINmsobB02U7x6G/a4ZgVxvJa3hbJL0rpeUOQ
	 N/waaBZjZNFH1rQyqQzB2hk5Mj82q/QZr0ASI4ZQcnIFjK+viUi7q/NGpD5pgeICIJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gQs5cosshZ9Xbj7tIctgjBlYuREAfJAoJk2FirmWh3A=;
	b=O+68Yai73gLrniJdAVPLAml2HYoPr/1trJHocDsOfSQ3MyXfvteaUjbFaloYQbEpAnyP
	 kzAN287hSHDB0l7G0y+5SCbKv4VvR/BEBU5YFrvf9BaZin0ra+jc/za6lGpfMrV0gzAtl
	 9TOj0W4c6C6iA+2C+0tfJLK1g0oosiKzlW+7rekZiIKcCliyIL44DMyXj51KcXNbgyUMN
	 g5jiOCCvEnPa2yTxtyNjGG1UimYuRCku20TmQ5+/6MmbVww0NHJLB1bA2+7VeO/AGcjwT
	 PRYfrIpoJtB4ogRrkcKFSPg32X00DPmZ3nMby1VMSDoCp7a5b5Chrql5SiIiAD2bifQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864923;
	bh=gQs5cosshZ9Xbj7tIctgjBlYuREAfJAoJk2FirmWh3A=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oVxA6MftAy//r7ym/OtHAr7XnjrWb6xbF+WsOMv1KQLDmSkA7Ycq4p1nzQlrgzrQi
	 hOMISfwjR1ftRjAiGyxB6d46uonI8dhIXxQ+NOBNPr1y/dgYuqoEHTZHYftkAkxIPl
	 AItIRioCb3+9puP2+IlD9pK3stVlst1SKEVD6nLV0hHrLi/DRPzP7av2N/CRmPYBvf
	 4FjzM+3oG7ufHpAYRTTMlDB7CQm9xgS1kHrq6/IMow9PdD8dwu5xKA/2yxiDolqoRi
	 qgAzQE3NQ9I2xa+kAr8M420w4+APrN+6E6rfWPgpuSWQovb3zqt2q/KtowCcY5janM
	 w+1MalS7HeEfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D091180D17;
	Mon, 16 Nov 2026 21:35:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD9CA1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA62740612
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1QcRee5V3gi9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 534E9405F0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=HRoT8WQE
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 534E9405F0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:19 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2208256f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794864917; x=1795469717;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gQs5cosshZ9Xbj7tIctgjBlYuREAfJAoJk2FirmWh3A=;
 b=HRoT8WQEkx7hrMPrYjh1PaQX1+AKhYCQ8Z9U11oxgBCbFOQ4T7Z97FSKaORPnQjutF
 uSXMWaGFlKaSeEMq3ISd+D3nSbCJAa3HT1+0cGVMK9QWzEKJYAh9/g/oRrRfpuvKnoWE
 JbHfcn6NkJG25hHvnbBqAc8xmAkbq4RscLzAesRy6K6cUW8h8OTUcPVx9bOzvLDywoTE
 1DDHuD8Wt3LXpQ+Tnpu7Lb7v/ZON9rwbFUnNqmCB/QXLim9evucqCelyVPpgVBxN5gbB
 Ky1Edzf8YsGFcuoAGgRhCwKq5Fg2F2FPPNRdFF3/mtLarGMall1MXAJ0gnjTF0yJTSiM
 jttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864917; x=1795469717;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gQs5cosshZ9Xbj7tIctgjBlYuREAfJAoJk2FirmWh3A=;
 b=nnQ5UwYnhK6WkVMPQ31DVBnd+nbFTuRXna7e4Wkj+T6VRbG+nsArO6OEwwCwtrbf8p
 TkuO44UfwMrQYnkg2cShuPVeCDYuJx5Qadd4CWE/2IkyKznV6NwRPUyhah8+QClpAOiL
 /NeQftMGNJITP0bPzCl/ezgomUnidgw6BZ93gWE1R5SR6OKmmW5OpBxk3bPq5dPPRDj6
 BS/iLfi9N6nVWwttQgfzihsYPYZnh+tjMtotXIEu7yBvJIVbBDbx2Xanj0sPXCUVM94f
 0xob3DTRsRsRIrjCR00IzHx2laS1Wo5JgDSxGLprRwcnNLQABrlbexCbVS835X31w3T1
 qJ3g==
X-Forwarded-Encrypted: i=1;
 AL+hErFX8GWLlrMeEE98QxahUc2wmOY4vayiPa5HEeJN28/XDyNKPSng7y1qyYpPfAQmkLQWWMj+Z0c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+1QJtlenJE7imhVmnBtupPajdLQeejoOd16GlsfApzuiDlzXs2
 OLRzHdOz1DhaV+mRN+PPI0OEf21Hp1N0TSZBfR7yryvIO8laDRzawfEkVqPDMHuSutQ=
X-Gm-Gg: AZFdTZcMU6F4XHgT2VK1uGsv1SejEtO3Mwdv6F6HhGw3LyRDmoKf4o5FiEFnuCMLi+L
 w28Uj4xmZRc67eep0pp2oOMttdY6EXdMHWIX4/32M0kOpdrg8f1/6DBbb65GzxpdjacHWUFgq3Z
 /bSufPqBqpeAPOtoj3REs5lCkYj+WKNvJFx/uBhi2OUo9srWu1ASI7+IvPwlZnbOFPUpzHtCuH+
 oH6czJhHVYXREKqcR8a0bPQ/GWmIxRGDp7p67ZteWTiydLBqjyN+xsjpktQ6LDjVgWFwLK64LQm
 y5aFeWB7Atl+JNFcMEMRcBG0j8gCeRaJ8nPNnDlTPQpo2hL2vVUqIRIXj7s/tGEYtyi1h6vhWmh
 JM+L+VPZw/2nO2NgVm9aDbBu13th14soVDC8z3DQbQe4gj66nNH4EVp5OM+E+zsfTk3CtP1USp9
 3iomHBD9anTVeMkHWTuf95ijppVhcB/lcaYQTd/b5WJlNEH2nR7QI1Mswy3bC9aj0iT863N8sTo
 gwkPbT5WQYPLILBvTmvBEB3eoMc5N3oWUzvSJ/jZ4Yf1qvKE3LVJ1YLMVOdIKp1fdqqP6kJsrY9
 JIPYRnMc0nVPOU2a/WVBkxYmqDXBNu8q+okoD44ClTS/fJVESv0jzhCv1nwlhinltdRhFOTgAM2
 kdSAhS3QOK80igjbO+w==
X-Received: by 2002:adf:e18f:0:b0:48e:bf0:30f with SMTP id
 ffacd0b85a97d-49c73bf0532mr25364862f8f.34.1794864917160; 
 Mon, 16 Nov 2026 13:35:17 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm26314066f8f.0.2026.11.16.13.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:35:15 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v4 0/4] Enable USB host support on the Genio 510 and 700 EVKs
Date: Mon, 16 Nov 2026 22:34:59 +0100
Message-Id: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43OzW7CMBAE4FdBPrPV+id24MR7VD14nQVcCEF2E
 oFQ3h2HHkBVJXocafTN3ETmFDmL9eImEo8xx+5UglkuRNj7044hNiULhcpKVCsIwZcKw3DOfWL
 fQtsfYOcQYcgETivrcIsYvBHFOCfexsvD//z6yXmgbw79jM6Nfcx9l66PA6Oce//dGiUgWMKm8
 aoi1vWG/PUYKfFH6Foxz43qCUo070BVQKqbYCsyTjv9B6hfQKnfgbqArqaqMhYNEf0Cp2m6Ax6
 LLcSBAQAA
X-Change-ID: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the USB-C PD host port on the MediaTek Genio 510 and 700 EVKs
using the existing MTU3, xHCI and T-PHY drivers. Both boards share the
same USB controller, PHY, onboard hub and connector wiring.

Two supporting changes are needed before enabling the boards: the PMIC
wrapper must recognize fallback compatible strings, and the onboard-hub
driver must initialize the TI TUSB8020B hub's power and reset controls.
The remaining patches provide fixed-host settings in the shared U-Boot
device tree and enable the required drivers in the MT8188 configuration
fragment used by both boards.

This enables the USB-C PD port for normal boot. USB0 remains enabled as
a peripheral in download-agent builds; the USB2 M.2/header controller
remains disabled.

---
Changes in v4:
- Fold the TUSB8020B speed-comment correction into the hub-support patch.
- Add a REVISIT comment explaining the missing Type-C/role-switch support
  behind the fixed-host controller overrides.
- Explain the DRVVBUS pin configuration and lack of Type-C attach checks.
- Link to v3: https://patch.msgid.link/20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com

Changes in v3:
- Rebase the complete series onto mediatek-staging at 60f6d41e23ad,
  immediately before the V2 patches were applied.
- Correct the reversed TUSB8020B speed comments in a standalone fix.
- Explicitly enable USB0 in the download-agent override for both DAs.
- Drop CONFIG_USB_XHCI_MTK; the host controller is handled by MTU3.
- Select USB1 DRVVBUS on GPIO87 instead of driving VBUS as a GPIO.
- Link to v2: https://patch.msgid.link/20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com

Changes in v2:
- Remove the redundant PMIC compatible-property lookup and pmic_name.
- Update the MT6366 comment to retain only the regulator-support caveat.
- Drop CONFIG_USB_MTU3_HOST, which is already selected by default.
- Link to v1: https://patch.msgid.link/20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com

---
Carlo Caione (4):
      power: pmic: mtk-pwrap: honor fallback compatible strings
      usb: onboard-hub: add TI TUSB8020B power and reset support
      arm: dts: mediatek: configure Genio 510 and 700 USB-C hosts
      configs: mt8188: enable USB host support

 arch/arm/dts/mt8370-genio-da-u-boot.dtsi     |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 30 ++++++++++++++++++++++++++++
 common/usb_onboard_hub.c                     | 12 +++++++++++
 configs/mt8188.config                        | 13 ++++++++++++
 drivers/power/pmic/mtk-pwrap.c               | 14 +++----------
 5 files changed, 59 insertions(+), 11 deletions(-)
---
base-commit: 60f6d41e23adb1fd52a3d0e9c9423803bf07e4e6
change-id: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

