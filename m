Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2473BC35FFF
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 17:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CF3D806FC;
	Thu, 20 Mar 2025 18:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pZJiAjOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93ADE8070C; Thu, 20 Mar 2025 18:33:48 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4090C803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:33:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so941538f8f.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742492026; x=1743096826; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iHz4LRj/8Z56cTootLYodMmMITamo1nYiwPQKrwARwc=;
 b=pZJiAjOjNS04MKBpMTX7X3DaZ3X/jeP5AP/5Xf5SQpQYU99T8DoDXa5uEMC08rbulV
 G8Mah7XDalPVRWeaPxJr++YKaEZhJJqzxn2gom2dgX3rBb46ERstC8Krcu42D+QoAZk2
 oXKd3XkwIKLs2wAzIISZCNX1cCRF5c4Yi9LAYfxx28gt/cDXENva78gCdKyayhAyNMr+
 jOyg3aM/7KcpU3gNoBkSzI+KJXkaVoPl0IS4ENWMbG9mDLs96VWl9vQzULAPY1duqOp5
 uFKySSoQ+5kLxrx4IHodtx3TY0yM8BUetnoqMXpiQkumnzd1v89e4Mb5/MpIRTszWd+W
 uOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742492026; x=1743096826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iHz4LRj/8Z56cTootLYodMmMITamo1nYiwPQKrwARwc=;
 b=Ml8Mn4Oro6GY6Y+Op5nLWQZWDjklNG4IIF7HK0F0OQN64H6WydoPD5q5Bv5LzqOnRG
 ocTGLqm6KmFyt4Zgin/FYYojRFYbbpIFVtXK6X5VNehj7yq3+HV550qQgX7uLga6Y6DG
 qFK8cmoiVcoI0hzclwAlaTL8/AnOcBnKorLl56mKk8MpEtAdqH9SYiAKHZkenSBtZUHo
 fvpqVj2hfZgWS+NOSEds2eO4ZnEmVGgzcG4zlY5fGpHxf7NSxJqvBJwj2VtmXq1iDCTH
 ejvOWbufyUjoLBwyLr5cqbONpuhQclxiJNyP4WgnvEYPyuQ1534Q2eJUAWeXFQOaxvAG
 XVOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77nEkEABlDlDBFuJjSe6TJh+fpgXtodqERQ45l3CFVCXq8PBhzihrA3JOAh6ni+P9TO2j3K8=@lists.denx.de
X-Gm-Message-State: AOJu0YytezLKVXYtqs1BR1tvspO40FzpGSg6ndvQSAGepvDQaPHF2il/
 n0XBonBY7r5IMgTQnXYr6L5iK3dCz2kbTB0UuftoptZ/5PeYrS9p3FNNWd8aC6s=
X-Gm-Gg: ASbGncss5gZpuIOYKFOTZEYXoKlZWVYSJTKEWjEFYtqHOD6zWxFVceMahSMQMBFNsb9
 imtOZtAcCczMiDus2GkVdIDQDmfXBnvCMtYhPEaFNEFDzIesM+ZOqK2NkOooK9BWjq/0AuEQOcg
 sYiJI/2Yqk5Np6b1FebniBXhrnUPXuCzkL1GLB6a/qQVRFK+ds2ijxM5mBpBSFDiYRjouM7C+p3
 1xTyhevhYQO3OmrQj0FkdBCh1qq37WaFrkBM3XFJ0nA+aOf7FAZ8BtsDuzzmgFP6Yh80Fzn0UdW
 i9uCEdTjU/omkHNjnWvG+Pys8Xt1pjVNsuCG2EBoE3juDxPnt0ln8UlX1BcVlWC8hy6xj24FYa1
 LyHtQTNs5TwPSL/rbRk6buoemFA==
X-Google-Smtp-Source: AGHT+IFuX5iO08xbEaYstlMKWfpXGmud+b3ZCn1wUPGNZuRy8vE4TsAmo1p5APCefeg8Dr/QGFL7bA==
X-Received: by 2002:a05:6000:418a:b0:38d:eb33:79c2 with SMTP id
 ffacd0b85a97d-3997f9154e2mr333433f8f.32.1742492025555; 
 Thu, 20 Mar 2025 10:33:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:1c93:5a83:c943:b712?
 ([2a0a:ef40:1d11:ab01:1c93:5a83:c943:b712])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995423sm180727f8f.20.2025.03.20.10.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 10:33:44 -0700 (PDT)
Message-ID: <a5f82eba-4451-4028-835e-747da14f7f90@linaro.org>
Date: Thu, 20 Mar 2025 17:33:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] power: regulator: add qcom usb vbus
To: Jaehoon Chung <jh80.chung@samsung.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250227094911.497219-1-rui.silva@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250227094911.497219-1-rui.silva@linaro.org>
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


On 2/27/25 09:45, Rui Miguel Silva wrote:
> Add PMIC USB vbus regulator driver (bindings already present);
> and fix related with property overwriting found out during
> testing of host setup.
> 
> Cheers;
>      Rui

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> 
> Rui Miguel Silva (2):
>    mach-snapdragon: of_fixup: fix property length at writing
>    power: regulator: add qcom-usb-vbus
> 
>   arch/arm/mach-snapdragon/of_fixup.c           |   4 +-
>   drivers/power/regulator/Kconfig               |   7 ++
>   drivers/power/regulator/Makefile              |   1 +
>   .../power/regulator/qcom_usb_vbus_regulator.c | 111 ++++++++++++++++++
>   4 files changed, 121 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c
> 

-- 
Caleb (they/them)

