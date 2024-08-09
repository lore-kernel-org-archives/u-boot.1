Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2EEC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2BC88B99;
	Fri,  9 Aug 2024 02:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LnFK9lBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD460889AF; Fri,  9 Aug 2024 02:48:52 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9AF889AF
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso15462141fa.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164530; x=1723769330; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WeB0Cm2W/GZwIb0moyk3gPKAho6BYi/88ETKZb3h7ew=;
 b=LnFK9lBbdWVxWL6vU2dZETAmDQ7Ypz6Z1n73eW5DvVUvJYnpKJOeFcrSoBKiwm74fi
 OanrNDFlQDOx1RnxDjNtW1/c9rzI6uTCO0SRFXl6zubBI3rltNbzZ1/oEOqo7Bwysgzw
 Dq0VUadcFBPG+xeNmieot3tPdBnjBtv5lyV9Eu9FnIA2wCzV0PSelf+XOGtTRCOYP6bo
 j24ESWiNWgGwQZyqRqDe/GGlsLa9pK+24kl+YVxijVuBrJh2cZ5ROGyi69TBpuX/QQSV
 Q4o+WXFyldSlkqBEb6CzDAwDzTH0Jt5cDDQXnthT8uYdDzSKi3NFSl8aoEiHV3WJkMB4
 8FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164530; x=1723769330;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WeB0Cm2W/GZwIb0moyk3gPKAho6BYi/88ETKZb3h7ew=;
 b=upfdxyiqcPHp4eaL/DbTTMtcaW/lzyCpbB7kv9jGUfSYly6CFyYHzRT46YK+uMDYRd
 tm4yoNN4xC5l2BApQF6adwD4IPSlxUFoWcPk1m7mpKrIXz1IFjUNnCkg1IWOjUp15vYH
 IzEbWMdO7OuUnwv+Fk5zRG8SfIByrBc73qdaKNRl2sltCesb6ROFlJqrrwLEnZO6KB6W
 KGeWixDhb1OT/QimbUZtYRPN6apEjTzvWu1xozSF6Z/18VvwBT3WbSxVjvw59tFndsIm
 djnSl2eeIFoy5B3iQE+LP8mHgUQyPf7SyuTxdl0inqNm5amOOOGpONV7S6poZoymyUqn
 ZOzQ==
X-Gm-Message-State: AOJu0YwMyeZtDCkKvFb9HOaYNQc2MH2X/ZPZGxFQu+i3H7aiMttuntdt
 kBDFiJsE6g/1BKyQUDlDXHLL0UmUGjIyPmcqK3O37p847TfSXzCVLu1lPw7RRtM=
X-Google-Smtp-Source: AGHT+IG5Um3VpTwU9JviUhGPyfU0DM8wkzuOzJK+Tnwn9V1yKxjZmh1hzckIhR/jL0iEEMKUIl3iTQ==
X-Received: by 2002:a05:6512:3a84:b0:530:ab68:25e6 with SMTP id
 2adb3069b0e04-530e58900aamr2266616e87.48.1723164529704; 
 Thu, 08 Aug 2024 17:48:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/7] Qualcomm: add support for SC7280 and the RB3 Gen 2
Date: Fri, 09 Aug 2024 02:48:43 +0200
Message-Id: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtntWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3SQT3aIk4/TUPCNdC/OkFAszs8SklFRDJaCGgqLUtMwKsGHRsbW
 1AEOsv3BcAAAA
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1709;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=78vwYtanK5DXcjOQHy7PEYcHYJLmE+3C72d/MoOz5rY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdv4hFxYXddb6NoCbaG95XXlJdVMWMZp/PnF
 o5ZzUcBkcOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVnbwAKCRAFgzErGV9k
 tnJKEACfjQ0dSaPA6vSD+HWwMNhjrjDdEkONl4k0BXhmeEmWikluDRfQbKGcQaQ0l3goHPnUXQ7
 ED8LZ2D1cUoQRM09KwKoThNl2hR5QfTSZBnn8gpckAvGLFjCRW8vVq4BoF1V17UXEOmCcvoOTeS
 fkFi64Q0MmklOJc6d56ghZrJ07x9UmsvtVLTTGQ1cGnj55dTChJtLyjv6wDmKM95hiHcOyDDDSC
 VHnipxfFyp+ot5Nn5NloUICkr0KmBt2WOtBIHcrSSDF/TLLJdX3bbgmgc8VZ1KixDUxACMy3+yu
 y/5/BDQOStrtlyybXqhGodVO8LMaFBNA/3pFLE/ZeBF5K+LUjeLVHw8y32FgcOqn/wB3DQR/537
 siJLzHRa4v4jlPnOmo1SDqRee/4eka5mpHKwvVRRhYQI2FTo74NVMrFuaX0wnPLaYoGDwTqxaZx
 Qqbg+MqcKD+VGoAG9nCCj/pYRbY1/iHjlR0WXv9HEmJWCw1WQ5Vc46qwzR29uSNLE8QSHUVjyk6
 hgc5tTx7H/4yf3RshxOSiLzcg8N47CI9fX7UmWoOEi9WBQltFERYakugHWzqa0zD++IeO8HgJez
 YwpBbz2iiDGudv8uLiMa0Lj9w1T12LWDkHURE94UlSmE+tcNCOKIRERVZIxR/g7VIVaeZNm1zcv
 H1FHsXn5ta2Yd2g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Introduce support for the SC7280 platform and specifically the RB3 Gen 2
development board.

The RB3 Gen 2 is the latest robotics board from Qualcomm, featuring a
QCM6490 SoC (the same SoC found in the Fairphone 5), 6GB of RAM, and
128GB of UFS storage, as well as a whole lot of I/O.

Most of the I/O is attached via a custom PCIe bridge chip, and as such
is not yet supported. However it is possible to boot from USB via the
Type-C port, which is hardcoded to host mode for this initial support.

USB support additionally requires this patch:
  https://lore.kernel.org/u-boot/20240423141551.2410199-1-caleb.connolly@linaro.org/

---
Caleb Connolly (7):
      clk/qcom: add initial clock driver for sc7280
      dts: qcs6490-rb3gen2-u-boot: add override dtsi
      dts: qcs6490-rb3gen2-u-boot: USB host mode
      iommu: qcom-smmu: add sc7280-smmu-500 compatible
      qcom_defconfig: enable SC7280 clocks
      configs: add qcm6490_defconfig
      doc: board/qualcomm: document rb3gen2 building/flashing

 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi |  28 +++++++
 configs/qcm6490_defconfig                |  18 +++++
 configs/qcom_defconfig                   |   1 +
 doc/board/qualcomm/rb3gen2.rst           |  53 +++++++++++++
 drivers/clk/qcom/Kconfig                 |   8 ++
 drivers/clk/qcom/Makefile                |   1 +
 drivers/clk/qcom/clock-qcom.h            |   1 +
 drivers/clk/qcom/clock-sc7280.c          | 132 +++++++++++++++++++++++++++++++
 drivers/iommu/qcom-hyp-smmu.c            |   1 +
 9 files changed, 243 insertions(+)
---
change-id: 20240809-b4-rb3gen2-87bd866abde1
base-commit: 428e11e6e36aa0a13f85961c64af24751c4d1bb7

// Caleb (they/them)

