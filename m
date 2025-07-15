Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF3EC83F34
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 12:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D632282BF6;
	Tue, 15 Jul 2025 14:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzIX/6uZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7EA782E37; Tue, 15 Jul 2025 14:30:14 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A2708277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 14:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d54214adso36207795e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752582612; x=1753187412; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cl9GMHGOhZxNW4cbE0rDcKPvALgvT7QSaa1aEh//97k=;
 b=ZzIX/6uZcBoMku69QMWxOBQrn8+GRinJ4OIG4R8CILSnKcvRIymcbV0uydDRtFd2Pe
 RD/6NdIwgCiVrMSWRTfpudMxLRcZvMj6eoUOAnnFXC0CU/geA+Dv+8s8V/TF2ZI1PZx6
 b+SoD7v4+XaeH+BEwtvPbntghIx+FD8sToDmYTXokn/x81dSeMQSjHIyjSAzSw0vmSUS
 ZBjoroBfNH1PFeUqD/txt1j++6n4pkihLOcimR8F95e2yN6pcymLhY3cBFOJdpm7tSDg
 3KzFJHTU4BinIe3cX36J0L/MteUp2CtBqinI/74nn2AkFWL9ZPUpCgg+79WeE1CO/gh5
 76NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752582612; x=1753187412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cl9GMHGOhZxNW4cbE0rDcKPvALgvT7QSaa1aEh//97k=;
 b=N9wa2Qc7d1ZOVZWFEJ82Ly572N9C7BwtsI1rvxgVRj2AgvLxCeaZCdNpNAvsnBxw7u
 5BPDR32IaXZlJAGVUelokHNt3soSSzRGWRxze2y65hr7jNsd1kYgyw15PUbWRCZZKyT6
 mqv1IAv3V1oRlpbqotDbVjF1hgyspPkRN/e1im/bwnUydQraS0/+9V2lRU2xwDyDvEwy
 lCvjUsCCfEDpZEqh+N1QRBGpiF/BfWBt3x1VvHzSyj53Qn0RB3A1AUMiPRha95Kn/wJp
 LozqRkw8g673N4lP7Xw4ilOJaItPuIwj5EUcrtsIXpn31ya4e6J3UFGhrqmlSqtokPZL
 WMdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVect1QGgVWizfpfCybf4F5lGLzBA/0PylQXPGoClXvUbytv+y1iTwTF06nuWV8uCf3fr3uspQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu2DetFU5GqOcy6JEkZDcY8gXd19nvpxklg599OP3YXYPQGs01
 u/PptwK2wK/sLNOWPtHKtQ2vGaz1KKsNRDf0+a777SscoJSLUmBE+5ZLCiuihiXMwnA=
X-Gm-Gg: ASbGncvc1Lm8zLei2WnMAP2Bc6+RgYmqEU4L2yx/Jb7VkfIDprOcd9rhnSTs//MFGIi
 kF9OIfcnTKI2g3vBA7bu7A1cJk4tXcpkEO1Al3nyyh6XIEHEX/xVwS1X8MkwI9W8CziP9TY3F5X
 5peLeab+Ri7ehkGcboBxF62Mgq6D8OSPVhTz683EHoMFfuyZllNhlGOKyw6IKkJb5S8aUHRAGX8
 dfoRIj4kNiHqhoJ2ALlUH3JCdTDTYxSUEGn/suj3iTFWjewpa1IPPBD3xRQ0iqGyLbPR9Ykrslc
 PpGpDvuXu7a0POcGYeZImPygoGnXiJghC/XeL/Nkjnm71TcmfhwzZ6eS/ows6jOUOG6TlSoxYB0
 /8aOmUAEyucfYRaKal0nuC81q1A63gSFNpPM2RKDsvNzF2ZuwLCRxWaUueibt/Kl3
X-Google-Smtp-Source: AGHT+IFPs3GYV6EIbygH4rcwK0fpJCXjUe3D2H71Rp/pu9wnh7EzN01tu6sukfuSmy34AsFjTY1Jrg==
X-Received: by 2002:a05:600c:a216:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-45555e4c191mr108771775e9.9.1752582611587; 
 Tue, 15 Jul 2025 05:30:11 -0700 (PDT)
Received: from [192.168.1.159] (p549d485b.dip0.t-ipconnect.de. [84.157.72.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c7b1a9sm11897085e9.0.2025.07.15.05.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 05:30:10 -0700 (PDT)
Message-ID: <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
Date: Tue, 15 Jul 2025 14:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, marek.vasut+renesas@mailbox.org, bhupesh.linux@gmail.com,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250715101538.4072985-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Varadarajan,

On 7/15/25 12:15, Varadarajan Narayanan wrote:
> This series enables MMC based fastboot flashing for IPQ9574 boards.
> For this the following are added/enabled
> 	* USB2 & USB3 phys support
> 	* USB Gadget support, Fastboot-MMC related configs
> 	* Flashing related documentation

This is awesome! Glad to see you have the superspeed phy working. I'm a 
bit confused though since the of_fixup code in mach-snapdragon 
configures all the usb controllers for high speed only and removes the 
reference to the superspeed phy, is there some missing commit to adjust 
this?

Kind regards,
// Casey (she/they)


> 
> Varadarajan Narayanan (6):
>    clk/qcom: Add USB related clocks for IPQ9574
>    phy: Add IPQ9574 support to Qualcomm QUSB2 phy
>    phy: qcom: Add QMP USB PHY driver
>    configs: ipq9574: Enable fastboot support
>    dts: ipq9574-rdp433-u-boot: Enable USB device mode and MMC
>    doc: board/qualcomm: Update RDP flashing instructions
> 
>   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi       |    6 +
>   configs/qcom_ipq9574_mmc_defconfig            |   22 +-
>   doc/board/qualcomm/rdp.rst                    |   14 +
>   drivers/clk/qcom/clock-ipq9574.c              |   28 +
>   drivers/phy/qcom/Kconfig                      |    8 +
>   drivers/phy/qcom/Makefile                     |    1 +
>   drivers/phy/qcom/phy-qcom-qmp-common.h        |   62 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h   |   17 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |   34 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h    |   36 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h    |   17 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h    |   17 +
>   drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h        |   32 +
>   .../phy/qcom/phy-qcom-qmp-qserdes-com-v7.h    |   87 +
>   .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h   |   78 +
>   drivers/phy/qcom/phy-qcom-qmp-usb.c           | 2114 +++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp.h               |   15 +
>   drivers/phy/qcom/phy-qcom-qusb2.c             |   42 +
>   18 files changed, 2629 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
>   create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb.c
> 
> 
> base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482

