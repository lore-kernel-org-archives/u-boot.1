Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE61CC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D961C8494B;
	Mon, 20 Jul 2026 14:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="AVuO67dY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97615847AF; Mon, 20 Jul 2026 11:53:08 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5624780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.bright@imd-tec.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso451783f8f.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784541186; x=1785145986; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j2C9ttgVJrec+77h3Sjd5798XC3C4KbEOgg/Abdddr0=;
 b=AVuO67dYbKHKbIiQ/W5nBzYoX1Zb7L4h/xZwb/yD7WvLFTY1ZYGz6AZMqcXout3NMB
 FmDWGL3sK7Ti5mRbwK/u089QJ2EGYVHp4vAtCbBkHgn0xfSEX9ih0QtWH13ZyADl1yNM
 7+69vevdtkdWX1nDNN5YR5RWTuG3BzI/NorhgwzFa6pcEkufBSF+UQarP4AI8tbwP2o7
 rrcXclDoZh37yHAFufYgVvxtLlp/V1CueqQ98wG4/zVThY2pLbvk8BGR0nbhtuXl+wf5
 2V4lGPeI96pRzhsnuQW71c8nQo1dFx0IAHRuh3a7lhOtpEC4M7w2O9Jvlpt0781DZGmZ
 FpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784541186; x=1785145986;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j2C9ttgVJrec+77h3Sjd5798XC3C4KbEOgg/Abdddr0=;
 b=VosIVuBYtSeUMK/KjLmIg9NO+x3pZG4cdKRNTXU6PLAAxOXSks389scILoEdMH/daB
 ROjtgjluDUeyfP6aS2mnT9yufLY1URHSrjLxDfFsfLqCVMXr7KS/pc9B3zsKsW0x6dK+
 hISNd8eGDEn4Go8Bg+W0OIHenVG3yZlENlgxXJSvm+PNw+OJtmi4Pmh8+/cBGgI+VQSr
 eYEGnXsT7fT4/B1rdDLJfZFTOpVUGKZxfAGLozJwe//x7X9Jy762tPdNzzDrwdwVQPfM
 kQu/BgR5uZ6zxCfgg4QrcgBrw3J7PBBJi2TpfHfbbomRboU/ktC6HAviyTniQO9TUn3V
 JtHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgPVbdcr+mLZ5MLkYlqei21arebRNJm5gS3q9cHiZqA2rALYQV5SurDHBelKbYWHH0BJOGuLE=@lists.denx.de
X-Gm-Message-State: AOJu0YyRyO0OvxAr096ciuKwUqbZiyOmhMcZI/wfgLc5gdlXLRn10aM0
 ZT5qRlgkRQd306HjM7E4XZo+9WkdQUlNNxpxHbxikLE4oATZKJ+hRaEDt3WKdPR1D70=
X-Gm-Gg: AfdE7cm5u0l79LG4Esv0F2982+hkbC6FzNVHIRC8ODtJeda8iAZ8IusWFDjZ+AmuSLP
 MwyA4GFfYl+c2Ow5Vn7k+WEI+jKH+yxEjj34cnNHuYk5fVd8KyYG3qYC+g2BnA53T4OxjKx4qPp
 IUKu0xl4ZscbTCXnAY+aIFckVxwh19xqi9iYbOFx04t6Xw6cRu+4iGbjscDYmsk3om6bKxVsc8T
 11MSdUgIVXxNMKkeccZGrXmGuRV5EIIDBAYNIu9rZHY+2URj68QN7491mKu9BjsG7raZjGLVOze
 mKBBBedQRu7dCbYlJSj7bRU6GOTgy59wvakIhBMuAeBFORuP+fW3rgXK3/Not2HTHnOitq+UldD
 WCoykEIGmv2ttTvVmyWHB7Huh+pRfHXJKGftNMsUpkHfC2G+ALDGpDcdcLri2BAiXS1irq2vWK4
 yswAQbvQv1MlZ7pxYN+/zG9ir3BTkWpeLB4OtJwcvqjdba4lKYe9oF6/fxobgA8knK2Ca76g==
X-Received: by 2002:a05:6000:2991:20b0:472:9bf7:2f58 with SMTP id
 ffacd0b85a97d-47f6232c99emr11598028f8f.36.1784541185764; 
 Mon, 20 Jul 2026 02:53:05 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm32537104f8f.11.2026.07.20.02.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 02:53:05 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Subject: [PATCH 0/3] Add support for SM8550/QCS8550 SoC based platform
Date: Mon, 20 Jul 2026 10:52:10 +0100
Message-Id: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMrvXWoC/yXMyw5AMBBA0V+RWWtSrfeviAU6GOKRDiIR/65Yn
 sW9FzBaQobcu8DiQUzL7BD4HjR9NXcoyDiDkiqWiZKCpzSKpOjNKDLUiQ7qysShBhesFls6v1l
 R/ua9HrDZ3gPc9wOFbG4FbgAAAA==
X-Change-ID: 20260720-sm8550-hdk-9e3731bad643
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 14:28:29 +0200
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

These patches add support for the SM8550 (Snapdragon 8 Gen 2) and
QCS8550 (DragonWing Q8). Both of these share SoCs share the same
codename of kalama and the QCS8550 is a variant of the SM8550 with the
modem removed.

Please see [1] for details about the SM8550 and [2] for details
regarding the QCS8550. The upstream kernel patch that added support for
the QCS8550 can be found at [3].

1 - https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf
2 - https://docs.qualcomm.com/doc/87-61717-1/87-61717-1_REV_D_Qualcomm_Dragonwing_QCS8550_QCM8550_Processors_Product_Brief.pdf
3 - https://lore.kernel.org/all/20240618072202.2516025-3-quic_tengfan@quicinc.com/

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
William Bright (3):
      doc: board: qualcomm: document SM8550/QCS8550 building/flashing
      dts: sm8550-hdk-u-boot.dtsi: Add memory entry to bootup
      configs: add sm8550_defconfig

 arch/arm/dts/sm8550-hdk-u-boot.dtsi | 19 +++++++++++++++
 configs/qcom_sm8550_defconfig       | 20 ++++++++++++++++
 doc/board/qualcomm/index.rst        |  1 +
 doc/board/qualcomm/sm8550.rst       | 48 +++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
---
base-commit: 8dbe57ba648648c4897717cebbc4505a8e0a8c23
change-id: 20260720-sm8550-hdk-9e3731bad643

Best regards,
--  
William Bright <william.bright@imd-tec.com>

