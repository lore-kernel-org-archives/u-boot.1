Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1494C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21F9484BC9;
	Wed, 15 Jul 2026 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="aTALuubA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C51584AFF; Wed, 15 Jul 2026 15:37:12 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCB884A12
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15ba5b151dso276499266b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784122630; x=1784727430; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8L+dzadRwZNQPMWDqaK7mtWxuTt5MTtyO+OKzMH8028=;
 b=aTALuubAJanfhxTKBcjYebB2WjM0zx4di+FIqVmWY/YXC5pFfe36aRm6MoCmewsggi
 itZ9gvz1XI1OzSUa3GAkdhozPAdsM6DzJj2UDQdEwNI/pLsZef+JTZbxLCI92mxxXE2h
 Kb23ZYRckazZoEhVqzo7n6ZIfedbVsxtjTmdFG6iiT0BUm99/LO5uG6bDKtaAlrWjz12
 tLAIQ6iMT3WK1HgqQC8YZpVBdMG65k1dPS18XI0NkB5a0LBu6z5LXBCLBmmmLk4gJ1Ac
 1jPHM54iIgp+wEDhqkkTkzLsR0I1PEEYOnL1OuTJYcTDvBemE9gLJMeQYrNT16sFn+4V
 idkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122630; x=1784727430;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8L+dzadRwZNQPMWDqaK7mtWxuTt5MTtyO+OKzMH8028=;
 b=dL8LyYwNeijZBMHVQF1dXR/0Z5vVsfcQKbwlfqIg7w5uSdJqykC0PrPATabbptVcVr
 qKZUgHuS1eY1dw13OOSqOAZz83HEHOGl2mPFzj85j/LGRa1mWxe6KSfLBxgGSoAkbx+A
 kwpRfJnOY/CpfSaqJK0C1CSwHw7ZwhHm68SMWC2NM31wASvNuwfZ5k7dRq4pX6fyYAuY
 1sBuWYXqXuCjH9W9OjzuMzGX89utzn/jOV2nQvkRRtjciKejN1EMF5CyvtKXq5NBWg52
 87OBqqAIcIYPWH0ux+/YLTdFxZOwSbF7Oa6u9jAW/aoFAKcCIl7YegVIowTov5i4wnG0
 F1Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqB6tRU93194yRMC05ZusNpgYyl3XHgu3PZtt3nD5c+OU7IYRCvUWllV2rrW/izPcdQvTkMX7o=@lists.denx.de
X-Gm-Message-State: AOJu0YzUNYWDFh6e9KyPvr4tr3ilXCCkctjA6XwhIF+X4EweS4vqkFh3
 uapuKeU/CaZ463t2cx0DHmVewLVWIqrMebdDZMWYrAcoG8iBAazNHowdjTGvJgF2mCY=
X-Gm-Gg: AfdE7clAV0SiljEC5BaVr8dHCExputW8fa2fOvXiRWsNYLOJMa+KSdWHyJFuh9VKZIb
 qulVRb79ONzRxj5L2Z+d15AG3OxGY0NJBQhwQi5tzNIlXC8G5PDkWowmLRTXEvhjUJ19SMoHZS4
 2VeA1oOfqDURi8/Lh2+KYnzfBjYQp1NN8dLc10xNcN4lPOfmSBek72a/O2BBMntxeXjHmOgmmwK
 1LHmfiur8/CxLADmnwigN0bhvmdbiw6Dx1041j+Kf3lqcNOtmwFpzyg0GkB704GVuYHQ8Uls9N6
 VRJujHpP2TbzeGdHtGPKgnXmF7du1ovM4mFRCG4vaQW8OIEihHrnKpsapWvJpJPu87Z99kJ1YKh
 YqZZl9J1bMhZ8OPY+pa3kH6FldvFg0PGjX570m1vTT3qRRronwjSoFzApsXJad6KUQ3t+XQ5f+X
 q3a0Ku+Vk49sG0e3Vf756Bw1ZAqxWklSbptNp9j03RxV48BhglnfgrdjVFOlDfocwAKXc=
X-Received: by 2002:a17:907:97cd:b0:c15:c1fb:e8ca with SMTP id
 a640c23a62f3a-c161e95848bmr908019166b.12.1784122629922; 
 Wed, 15 Jul 2026 06:37:09 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871962cesm29896166b.25.2026.07.15.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:37:09 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/4] Support reading has_se_clk_scheme from TCSR in
 phy-qcom-qusb2
Date: Wed, 15 Jul 2026 15:37:06 +0200
Message-Id: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQqEMBBA0atIrQ1oOcariAsTSy3BKaVNg3j3T
 uvyLf6/QMgxCVTBBY4+LLwuHnEYgB3bZSDFnTdghHlUxJnaTzGoZplLnSUKLaZp15LWuQHfbI5
 6/j6/unktp5nIHv8J3PcP/A7I6HEAAAA=
X-Change-ID: 20260715-qusb2-msm8953-2c244dae996b
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784122629; l=1022;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=20rVnuEuNuK/GWF/UWiqCNtvVpRozipvAYWhnZ8HZtQ=;
 b=WBeP/J6855Ve2fpHcm52SRTN+NICFgegm37kR6nD38++fVZJIdIBRPHzWGLb2S56j2dspafKD
 76zTkmHNnbYCpYg3b/PhV6jeKqVbZ3TSHyvwl8RHlXgRz3nP5SMnBNB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

On SoCs like MSM8953 the fixed "se_clk_scheme_default" variable does not
reflect the correct value for that SoC, so support reading the correct
value from TCSR.

And add support for the MSM8953 QUSB2 PHY compatible in u-boot.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (4):
      phy: phy-qcom-qusb2: Sort headers alphabetically
      phy: phy-qcom-qusb2: Support reading has_se_clk_scheme from TCSR
      configs: Enable SYSCON dependency for PHY_QCOM_QUSB2
      phy: phy-qcom-qusb2: Add MSM8953 SoC

 configs/qcom_defconfig             |  1 +
 configs/qcom_ipq5424_mmc_defconfig |  1 +
 configs/qcom_ipq9574_mmc_defconfig |  1 +
 drivers/phy/qcom/Kconfig           |  1 +
 drivers/phy/qcom/phy-qcom-qusb2.c  | 45 +++++++++++++++++++++++++++++++++++---
 5 files changed, 46 insertions(+), 3 deletions(-)
---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-qusb2-msm8953-2c244dae996b

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

