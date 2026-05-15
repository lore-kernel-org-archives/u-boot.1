Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399B2CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63099846AE;
	Fri, 15 May 2026 20:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GsIGYplF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF418846B5; Fri, 15 May 2026 20:10:15 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC9F8469D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3684a6f3b0bso622503a91.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868612; x=1779473412; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KLC7XibMJT5vyELqGwbdps5j62nIL7LVM4IBI1pmF0=;
 b=GsIGYplFCzRQThH4LvKNSWwBfdyGZPOR/z/GsBpXfqURzXzooDPf5W2OaYkNpE30S0
 r9qP754BkfcN21zMrgjbNOQWUJ2vuDn3QE7/f9RUFH8NYzyhmyoppRR35oHiRCAs0wDL
 BWsP3hPXupT107xdgRxGqNNiojA/qwkHLpTmvO1+ntJQm6to4sxamGFNiw1zgU0m+2gu
 7Lcs5G5Yfrq42UsDIc7chdkyIXsb0oyLYOfTFN+wwhievWlLRq7Yc4lJ69nrbjemIUxI
 IC+lsHYghZip+jnEgQQfk7LO1nvbG/2GXErFjdBASXKsyaRRqD77ZG+EzA1anPHBdIXC
 BeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868612; x=1779473412;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KLC7XibMJT5vyELqGwbdps5j62nIL7LVM4IBI1pmF0=;
 b=PBt4lnQ1cZYZJLTus0oAW87YGmRvOx9AY9taOUICODHwgrtu3zmryjo76DjuiMb7tt
 KpshVkzzQCq7ZnjSX3fYmzotU8ujwMyNKzPb47qthkxqpj10o2sG2KFMRjV3lolZImnj
 8BCH7wz+kbVuZuP5QJKwmXoGkM7dkR6CBvgbfv+iSYkCdfnhLe4+2pI+ScKmsKpVeplf
 6DMMpomxFUtsgzbC2KukHE+a39KHwCPIjB3b50L9tf6MCev/PTX8PCVAOSodw0Ntqhxm
 mz3amgaCLkuQta6eMwAo9spbdxHezp+nYWLpRNZXPqaKGt3qqoPYcg5z3w3j6QhdWflL
 LEzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o2XNfB/IHSjXVzzuZfOMkmgxik/gnj13C9WbtjYPIAfZPqfuQDwfS3FVst/gZ2s8ag5T2viA=@lists.denx.de
X-Gm-Message-State: AOJu0YxqABctZXywtRgdywLaWJSW9GhXhWJ31yh/DvaGA33Aan6BcyKj
 H0dn1DiUK3is5OBbY/Wjab4hiLcg06lBC773r+nyx/PZncZiSeXlie5x
X-Gm-Gg: Acq92OGqQoXmnvGDsnJ/6cB5nU/B4PCcSeIkROtiHdUcEAViqjgtK4kdROpj4KCfAFG
 Aa3WQobO4vBHTtTwghMHJOgKJvrr4GxEhUtEn033eEb5XWzXxdiDLaizQpuatLTZzxDDSaAMYYn
 jG8uUwB2EXjYz/WT5w/uQYcdbQCfhl3JrfvY8s/Gm+EJaf9r1mPYRij995omxdtdp5pm1av848b
 1n8pQOfoe42IA5odY+Qm7Y63LyvELqSOYCC48Bvbo2ljvPL2zm6fRfhrn7gJt8MLLmwcy9kDFGf
 td1nO2/pxCTys3eDVcMJ3VkWu/G4NnUvbyax17Krm8Eq9uhCNX+JMEy3pHaW6MiQQy3kQWL+L48
 JYFxHcU0Mb5oVTFCHGqO37NUBi5CFWFLB4iFXkTXzfovKWT/BZC71PYhMSo8GNECbxQpbbiuBaF
 nJrHKL/Q/NaIiuixsQMUIbgGwhsi2gfHspttxEK5Q=
X-Received: by 2002:a17:903:943:b0:2b2:4bbc:14b0 with SMTP id
 d9443c01a7336-2bd527adb2cmr82931185ad.20.1778868611866; 
 Fri, 15 May 2026 11:10:11 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.88.142])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2bd791e0b11sm42338535ad.18.2026.05.15.11.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:10:11 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Subject: [PATCH v2 0/3] Add SM6125 UFS support, Fix QCM2290 clock, Add
 poweroff command
Date: Fri, 15 May 2026 18:10:01 +0000
Message-Id: <20260515-ufs-sm61x5-v2-0-0a35d083d2da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0JmbU3bpLW48h6GRalTGCNgOkAwp
 HcXcOvyJe+/vwJjImS4FisknIlp6DfQpwJC6/sGBT02Bi21lUZpMUUW3Fm1GIHexvqiauMMwjZ
 4J4y0HLF79WOe6ieGcS/sRks8DulzvM1q9/6GZyWkCFLrEEvn0JW3pvP0Ooehgyrn/AWcM32qt
 gAAAA==
X-Change-ID: 20260512-ufs-sm61x5-ea6fb71b585e
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778868606; l=959;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=+d8iqKgwlKtRt9H/UcXvojvbCQFAuXevjMTZYvlCZLU=;
 b=r8elFDQKnLufbVcwcSzHvOnKTBuDHj8YYJZEJVSqV3zsYIlxhfMZ1cjG/gZF/IcPTBjnv7bKg
 DHfFYWunQwQCIFKI762XllmLFvxSLJjcuV6vbx4opsEBNYPQ+Sqyo0b
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

Changes:
- Add poweroff command in qcom-phone config
- Fix vote_bit of gpll6 clock in qcm2290
- Add SM6115 and SM6125 to QMP UFS PHY driver

Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
Changes in v2:
- Add commit message in clock driver fix commit.
- Link to v1: https://patch.msgid.link/20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com

---
Biswapriyo Nath (3):
      phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
      clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
      board/qualcomm: qcom-phone: Add poweroff command

 board/qualcomm/qcom-phone.config    | 1 +
 board/qualcomm/qcom-phone.env       | 1 +
 drivers/clk/qcom/clock-qcm2290.c    | 2 +-
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
 4 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260512-ufs-sm61x5-ea6fb71b585e

Best regards,
--  
Biswapriyo Nath <nathbappai@gmail.com>

