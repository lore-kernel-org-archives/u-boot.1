Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67D5FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8C08470F;
	Wed, 29 Apr 2026 10:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZeVTZADp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8124584711; Wed, 29 Apr 2026 10:49:32 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4C38470E
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso94191855e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452569; x=1778057369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1J+hvmcCCYi5C4QG76jOsPiikEpZh6p0Y+Ly9DTZxtM=;
 b=ZeVTZADpq5Y6dW1YIpJWG+1UGyam0CeI6NbAANO4V8xynTv3zrM5DA5of5U1u+K46N
 CxopzlW/2cbiuBXXyPjl4s53Ynj4f26E94/UlOczXcS2jB+ZlAdJR8FQqJLY6kRtrtuR
 MPbAT3EiE29LWp+QJ/9qCjQ9Q/nVBqyo6BEbSI3kRnKN+b77OGM+1grJUu+mcrgIyP+V
 FbvfX9Z1ojo62a7GJZY4ouzW/Q7nyoD9Tw1oLuLTgZ+wrv1cJmSja8zcioWjAe3QcSdK
 yDEVTvffBPwgUjLAODLn6OVyKoBE6FxgdCMM/qxX+/cyQmsFj5mHSWl0HDVcdKdu4hWv
 phRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452569; x=1778057369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1J+hvmcCCYi5C4QG76jOsPiikEpZh6p0Y+Ly9DTZxtM=;
 b=CdxAj6QIxD/X2/Q2+Oz/tO94EykWb48M0I6guDSYvoDN7ky0/IkdXatcX3rjbYtCw0
 tkD/wyZ47yfQ74iBKrJHslyV9XeHPnyObjt/gZiBQDCiA1fZPxZpEGvOR+0jYUQGAi1L
 HoNa5NIrsCKzhTyDTjWi0IOdOj64vqgxarzSsNeRmOVteJRQaH/agYEeU48QwNCu3jwp
 GejRPBeCJcSITe3gJbYC8vyVvBUGMoGvYVy2pRDmFOBLClzS9fQsiUAK2eCwZIARecUq
 nWvTHtnws+rHAQZ8rHw3uhhDUcHKkuB4huw4+GKlj+wPvX541eBURCrkyjVvlCPnOsXP
 s7YA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89x6OGTf8B0jzaRB3sfd0p3urHSVCkPDf5aI+9qcRTytrnY8oBzwRAHWyHcCQWBvhFOdDAP5A=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2vA3Davq5xs6KfnaVQq51TDifj+Idtm4IHqBGX0DYVDltR4nU
 0syYswlQO94zLjHfFCiPxQ29GwAOvvmEnqjyriwltk0TZwIwWbe5Lv3QgiWmMfoHYDc=
X-Gm-Gg: AeBDievtmqWMyoiSzZv/N9OuiIP8ecY7nWeXlc5styNMGhu8ghE9ZVh6R8VKdOZYgG6
 0wkIxW3BAxdjR/wkQdolfPCw/jCn4QswXaKA2tkNpxkevBEZ1CgvBRKhRFkVJ+zIoAZg2hEKdfD
 9kRvDOD1N/CU2w4xllKPIUz3rDBAfEsVfrUhTIDIIps804Ux/KXLDL9Y81oaew3uPlY28sd7w6V
 Qqcu1TeOLkH95Az37CuoUhPB2WRkJnm4Uc5/bU9nSuNWKS7/j6alultGE+DP+LZ6Hhabj1xiH/o
 75wfbplyifiy1NqwJy0sz/MY0V+6deG4TJGBgocCw719BpscsdGbWmLPCTX8PRI1m5jJaRkJ1fl
 K5js9Dw2THqz74qNcxNJ2Su+qDGN+XG6SRVStx9wjc/l9WPAYqz9j8UQikWOs5fc1UO1yBlIf5/
 DWX9lT6LAEuaSPJSJN18ZMvR8Li/JYKpbmrFHCgC32TB2+vb3W2NycrcP+J7cNpF1Rit88r8+ZC
 AF2bIU=
X-Received: by 2002:a05:600c:3e83:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48a77aed616mr104358335e9.9.1777452569435; 
 Wed, 29 Apr 2026 01:49:29 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d47ff1sm4374696f8f.6.2026.04.29.01.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:49:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com, 
 vasileios.bimpikas@analog.com, utsav.agarwal@analog.com, 
 arturs.artamonovs@analog.com, nathan.morrison@timesys.com, peng.fan@nxp.com, 
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com, sjg@chromium.org, 
 stefan.roese@mailbox.org, mkorpershoek@kernel.org, 
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org, 
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com, 
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jerome Forissier <jerome.forissier@arm.com>, Yao Zi <me@ziyao.cc>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/6] Enable USB3 Super-Speed support for QCM6490/SC7280
Message-Id: <177745255938.126665.16625119085748603933.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:49:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=VhIQeHBaM7qppghA6I8vVKWlWK6qelk1PlBUlVznPY8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPx8T+rfX5HXqrf5/Mi8/xrZxe5Q2HOxzi+2SdOz11D
 V6X7+HvKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABM5u4Hhn8WtlV0JjuIyr8W5
 mhSXfFwyJfLSMq2NpTJOflo1/q/apzAyTG08bnhNVujgJr/LVoJt65WM3VnFhK/fvZRb4lByTdf
 9FAA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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


On Wed, 03 Dec 2025 16:37:29 +0530, Balaji Selvanathan wrote:
> Enable USB3 Super-Speed support for QCM6490/SC7280
> 
> This series enables USB3 Super-Speed functionality on QCM6490 and SC7280
> platforms by adding support for the QMP USB3-DP Combo PHY. The combo PHY
> is a dual-mode PHY that can operate in either USB3 or DisplayPort mode,
> and this implementation focuses on USB3 mode to enable Super-Speed USB
> support.
> 
> [...]

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/6] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c91a35ea6ec2
[2/6] drivers: usb: dwc3: Add delay after core soft reset
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f69a20002995
[3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1811eae79f52
[4/6] arch: arm: mach-snapdragon: Auto-detect USB SSPHY driver support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d7a4a156fce6
[5/6] configs: qcm6490: Enable super-speed USB support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/450d50e25a02
[6/6] MAINTAINERS: Add entry for Qualcomm PHY drivers
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/78e0bcbb6cd9

Best regards,
-- 
// Casey (she/they)


