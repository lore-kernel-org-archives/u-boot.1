Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9608AE9A769
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D328D8352B;
	Tue, 24 Mar 2026 11:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsUHqlHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B112A839A8; Tue, 24 Mar 2026 11:59:40 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8752A80050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso2629838f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774349975; x=1774954775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byOY/c3pda3nCAw4UcZvi/XHby6O6dU1IfIH5pqk6/A=;
 b=MsUHqlHQxGpHC9qE/y1lybp6Cxc+cxRirj8QVmk77UHcIZEMgKttiPETx6N+dQ9+bp
 dWsAE8gLKOdrmBSHWYOHfqkDnJZ1L6+ihFR6GHwRACEywFyz3KzZ/2ZOiwFbh29Bul5V
 f5203CYK8HggClLPIP95wHwF2+GdQk0xcMkBbJ1sjrVWN1pWVcaTqD/RNiDhFTTFmL1k
 NMGt6aoNuXq7OEQZ6I+Udvw8NHQPSB+/OZcFl1QEa2MQqfVOB4Thx5fpRSYh84R8olYX
 gRvV0T7/xzz/o5PyCyHk+00DF9dX/pj7dfHfFKe7RSaVggyDUENTD8L3iP1T8g+ZvzxJ
 ZKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349975; x=1774954775;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=byOY/c3pda3nCAw4UcZvi/XHby6O6dU1IfIH5pqk6/A=;
 b=l3OX7qACoVI77y3DiZ0wMNOD6ontxbFEzGbhVIUVH2MNf5fIvgw+SzDLMhIIK0/1td
 thkxtCvYdT2TiLHPMZERe63BKZ+DDRMri4Z1YBjWBwnz+AN7EcrQ9Zb9tKaRNfmOxDeP
 91q9LOM/q6ZOPXisnP3hKA7tfzeYXxWs6e10a45L+Whe9wuyHkKfIvC8jtbxmHUnhYGU
 keM9TeKthIrjMFWArZy1jfoxocauy7XX2qzRBbWSRWrwoHeRv/2QH+EePdA0cb0FzPEZ
 MQ3A7bjTmv7TxLdUcCCmlaUcsiWqmy4P6IwCyyEOaRoziPrmpZXX6v7XQsupPbMHboeP
 K3Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmifQJZSNHqI18CEaa9fvLmqa6wBmewNftbffSiCoLeuhC7oLRvFjBIYsA5Dv44BU3zk5H5Qw=@lists.denx.de
X-Gm-Message-State: AOJu0YyAuUOA76lHMH5j2y3F1Y/2m9UDRff5fYGGBn0QkzK/oEAfpmID
 G4nvOfjAMoMtu5nICg7LEYmi/XVxTvpb/Sw5zKJEqm6kd5al0akIevcLivPGT99hIdDZLKzUQrM
 iiMrB
X-Gm-Gg: ATEYQzx4S+wNYOtM04TAc5PYaUPNUIZEAzSuYZv2rxMAM9cuVIev8DTwFpw9oaz8DZ2
 i0KpuGAZemYYwWL5se1iOEQndGtoJPFPQz29VPuXezkYgMfi5Ha4JoMUvSkDbV+rDMFb2TDy3SD
 XKdC0AdE1b6RdfsGNykzkCtLDDsSuOiEkkQJ/MkdPP7lhIYSuMPCir+Ag2+RW8CsS5VEV9xHfXP
 G6K8jLtpGnTwotVJXymWq85pzCFCT6fMWiH10Cfx6VPgnOqci2noIJZA1HGLy+sZteCSaMTGorT
 sot9FUTa5jjyScMntES/jzbGPY8oMr+xxlHmdn1muovu8ZiRP9vjRONGGyXRwPl5Uh/fo965gCS
 cKl51oP3SWHGFlOXBnGdzMJflM7yH0u/Z3VXy18DU7y8MrzaVq2VURnWxGpk5HM+UmlUrkjvWjF
 Wp8iwDYvOeBMalaBA6rakv6+7Twozzav+wS8udLLtD6qwRtmCy+64gIQvA/kK6OuXPtPFvHJvKG
 VEH
X-Received: by 2002:a05:6000:310b:b0:439:f605:afde with SMTP id
 ffacd0b85a97d-43b6428ae11mr24586575f8f.51.1774349974673; 
 Tue, 24 Mar 2026 03:59:34 -0700 (PDT)
Received: from lion.localdomain (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm37810416f8f.26.2026.03.24.03.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:59:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] Enable USB High-Speed support for QCS615
Message-Id: <177434997369.3720457.15261784252984910297.b4-ty@linaro.org>
Date: Tue, 24 Mar 2026 11:59:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Fri, 13 Feb 2026 14:31:17 +0530, Balaji Selvanathan wrote:
> This series enables USB High-Speed functionality on QCS615 by
> adding missing clock support and QUSB2 PHY support.
> 

Applied, thanks!

[1/3] clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4f40d092590
[2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c4169dfa1dcc
[3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0f265c20a56f

Best regards,
-- 
// Casey (she/they)


