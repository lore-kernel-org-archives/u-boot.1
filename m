Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B0C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10627884C5;
	Fri,  5 Apr 2024 10:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G4ax8X4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D11884CB; Fri,  5 Apr 2024 10:36:01 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E6F884C5
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e2b137d666so12539935ad.2
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712306158; x=1712910958; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SajZmGeFnBTscM7//JRwmaUT/cXPsI3WI2lY403LRyM=;
 b=G4ax8X4bUGitXXHwRYFiU3FvhwcpC7T2Sscy/4z6UC41xTX0duDv80wwCk9ZKVqFrB
 tJHXxdgDpD5dgW8PNoCCXa43FmXVMfmGXDveS5qj+RvHmNi+gFV7dY61eiEYTWJzQn6d
 ZsY4ewZktyLtg4gqFuDhiBWILx40KncWDaIcA0rilZ2LbJwuyweRkwRSu5L1keMfDYk+
 F+WQgeAVHVwdmmUdZoh6evGHiCsB3D3QhuqkFPaFwtHpmu2qrU8xYY3EEhf6RdTD2fqV
 Y/GyAAgbT4n8GrBYE3X7shS8DaDNSp7c1SxT571WwU4Fd7WfoDwck1DM+ZIg3rzGaeM2
 xB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306158; x=1712910958;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SajZmGeFnBTscM7//JRwmaUT/cXPsI3WI2lY403LRyM=;
 b=WaFNHGkxgCdQnkbb7hdceP4HzD8xB378Nopx99jahzfglW6a7mIb1LB2vx91iENG6L
 jceyBMSadVDG/JaYv0b6kzfD8k87g/mnQBmVdcHuHorqXwDV1WdTM33R+XmA3s+uS3Mk
 nQ231W7bcrilIs3OyB3s7SkYav5IH5Olqcu4VLNJke/LhyDIudFU+Eo4k2H+ao4hHd2q
 MKPAENMFdWSU7KxhmUdCep3VpfGSartSgjSfTmPWTa+OS5+sut5BA519XeueqYWb9QN+
 NbyzP5KBNORBwS7FcQVQ09bGv2U1sh8myTEaJ99S6pxlq3kEFeTDUCesWi4rdi7F9Old
 Tilw==
X-Gm-Message-State: AOJu0YxERgFi1P36+7gMF1em4RJkrCaiKnhX87gzSA6QbYjAtdQenC+j
 8ScR8hKrdcTKoqjlX+3NNEN96JOMos9J9BrwPThigGNbjbdAKj3TqmS4g3GyJ7Y=
X-Google-Smtp-Source: AGHT+IGCRCLFNeQXalER5EPcTUKQ+uvNsmoHFw3OR01u+CMn5FsNB0Ds8KmxylTK3LB/0yquE/58Xw==
X-Received: by 2002:a17:902:e805:b0:1e0:ca47:4d96 with SMTP id
 u5-20020a170902e80500b001e0ca474d96mr956302plg.3.1712306157672; 
 Fri, 05 Apr 2024 01:35:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902650c00b001e27e52a7e4sm1006572plk.285.2024.04.05.01.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:35:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] phy: qcom: add support for the Qualcomm Synopsys eUSB2 PHY
Date: Fri, 05 Apr 2024 10:35:47 +0200
Message-Id: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOO3D2YC/x2Myw5AMBAAf0X2bJNqiMeviEO1iz2g6SKk8e8am
 dMcZiIIBSaBLosQ6GLhfUtS5BnYxWwzIbvkoJUuVQKP3bNFWZu7UnjKiH550KnWtM1Ua1eMkFI
 faOL73/bD+36pUFlbZgAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=799;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=x7bl9MII3cmtrYvEkrTCzM4VoU1HMhUCeU2x1PQL/Qs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7fpgNtpxRo+EtxNestBnbG3zj4z+uzdHaNVY96S
 GvECyoaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+36QAKCRB33NvayMhJ0Ui3EA
 CsU+mcsPVjU6U9Gv0iv9GhFhnUcjfWkT1hz3gTD6qP4jlFWRC3tT0aXF3dVIdSuUtP/uQ3hV1lqErN
 kw7KpVat/X6H9AChL2nBbMoANp26pgUu/cb2XDqvTu3K8NJVMNa3FY5a1odOrEppyTSw1GsHGVh60e
 GvD1+6ub7u0ELI5XE+nhFzq0LW38hu9KDoqrGGiyAVeJKJwE2l/AqMCz/fSGTVxVxyy+nykzCjFeSR
 daQjjy1cjrl+u5fO9VQP20fOkRsGSdX4S5XsMr7EfqrWWOmdWkAVzG4NxxVaDqS0hQ2J1XmbqCuVrV
 MdGMqTpA3pVSKn92ARSSR3gupBi+d+mZ7d4cowEciFd0rfRYP8OT5M6GtDA+AIoo8ITGA3U9ZVksE5
 OmxibiErLo9Uj5DknzUYnM87ob+S8igHq9WiemEFLHCgi0y3NVmhl5o8XWhN+GK5KjJbxEbGqipK6A
 WQUD1y05c0VgIUAcplFBT/ghutXb6Eg83BNpptzbSe9jo3drSjPcE+H+XrOdHdCLbD9iOYopxmtFxM
 I7vCJCdB9AF3XNN1gZmllVz1TnzrBJfVFnKXJvrIQOs/Nv4C6tNTmKJUVVhWQJm39fcAgGDSWb31tC
 pWlQmO/CA8V9DZNMdLSBloit4vE828pKCM4XZkGB9dNramrunv4qz1DOdI5g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for the new Qualcomm Synopsys eUSB2 PHY found in the
SM8550 and SM8650 SoCs.

Finally enable the driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      phy: qcom: add Synopsys eUSB2 PHY driver
      qcom_defconfig: enable the Qualcomm Synopsys eUSB2 PHY driver

 configs/qcom_defconfig                 |   1 +
 drivers/phy/qcom/Kconfig               |   8 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 365 +++++++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-usb-phy-d09a98f72d1b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

