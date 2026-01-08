Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4896BD1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA76B841CD;
	Thu,  8 Jan 2026 17:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="POUJDelo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6474841C2; Thu,  8 Jan 2026 17:17:19 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BE184150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so651798766b.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 08:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767889037; x=1768493837; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1opPybD0nA3kokw6Qt1l6G0oW9OOEYbr5qaCYAQ/KWE=;
 b=POUJDelotP/81xrn/i75KK/Jh82vuh1LeH9pFaS/pFafA1hwdkqVW8G7b7q7axyeKf
 1LUnv7OfVfWf2hhH6d8P8NgGHmR1hBipasOT6exSn5LSZbvTgjLqlKhMsd3y8Q6gmm/V
 KdbYdcSGgl2uWD9hbAa5XrxoPHJXjJnUxOD1SMAnWlJIH8ylVwSq5IfL1pEOBtu+TT35
 FdBsnsPAo6Eh4+WiYCbz/jAzgzBVSTgrp5EAKJL+kvjdGZGtkO6S8+spRu0aOOieOajK
 Q7i6w9h3z0CZxwwYf83WFDGMYDQNVqIeX95zOvnEg4uMVHDsVTpL2YDawk35Qp60AHOW
 LQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889037; x=1768493837;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1opPybD0nA3kokw6Qt1l6G0oW9OOEYbr5qaCYAQ/KWE=;
 b=XoKAx8tWFvkBJPdklBUixgksmgGSsXk2zt3yL+UmBjl3xdC6cqA9uRyX1FylindyB+
 qy+ZBweU+fHg/iqiqlv7iF15gvjEP15GQM2jthrm+Ww4gaUQOASqH4ver7Y3ZKqDaKJ6
 WWyyzZ99fdkh+fZQn6UPYLqUaiDhYrP9+lOWPwS3V2S/D84WTPuQl9Jkda6/J8Y0jN7a
 67M4bBw/Q4E9Vd6I4GhD2ttapIlsjTPPTpqAcYHBmOEyLY105Twup3eRWfJD5GxDd/8F
 Pcem0CWB1jdG8GcncmBcHJkhPyZA00P8/8WSNrAnd5X4DNG1I+h0bqUsYZxyiM721Yj+
 LsUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX+mP/gcCwQN5SvgcccFNs5g63D9tY5uumMV2CysTzc+OX0Gz85Qc6HIgazTSceWWtePx8Sjw=@lists.denx.de
X-Gm-Message-State: AOJu0YyjPpI+jJcznf+XIatnIsCtW5npJeTbyAg2RGn/XrEKqRIZzU1s
 4I9SXvH0/HHiDohGDt16og1+MMC06wrDrZYkHcCBnogxv351z1e9LCxD9ehXyAfK/zQ=
X-Gm-Gg: AY/fxX7lvAeCgm9dQo9QKiLa/k/UM7O/Oevdst9g6ZfWJooa6EW9CShDcfwLsyAnVhk
 nVGbdjNlV5JTFOnQ3zIvSmZVK0w3Q0AQQv56ccSOxTDkxbx9ojFp+E3t7Qlr+5/oFiiAXW+CFNx
 5hFso/ZfE0YmL3nX6cW5ix1Wc4HDI4RFmyTWCq4opfsh7ryjhLrTNLjkTLIvnGG4RQeaq98HI1e
 xV0UjScXuhn+SDEAfKaua+wDhe75UNtw6TVW4byxZ3pq1Si/WJI+zYfU9nj786VXxxaxN1ln1Ia
 WRqkUjJRM5+75BS1u78g8lIa1mrHffAPdqdOI6ap1IEEDYmQ+D1WmcI5qIYK5MhQHuGbUOCamLl
 igjFumYFij3HDphvs2obsqWasvMkvwvbIYvDRECtEhKzsgk3LuWW+39D6jAXrvZButEjrM89rgQ
 HjDaIuw8/l34P0/K5/71cdCL+St4S8LuVGD0mTbpDtwZagEu4zfzs=
X-Google-Smtp-Source: AGHT+IEdNPEfJ/XhtWpPeqbQYTaKW78YF8XqTRrqNDKu5C3lHpCMD25caCwR3sd3fyHFq9w2k9xjBA==
X-Received: by 2002:a17:907:94cd:b0:b80:3fb7:2165 with SMTP id
 a640c23a62f3a-b84453a1245mr657142366b.39.1767889036952; 
 Thu, 08 Jan 2026 08:17:16 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm851698466b.3.2026.01.08.08.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:17:16 -0800 (PST)
Message-ID: <67140dbd-1b93-43d1-b218-0b57a762ce1a@linaro.org>
Date: Thu, 8 Jan 2026 17:17:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] pinctrl: qcom: Make pinctrl drivers default y
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, marek.vasut+renesas@mailbox.org,
 alexeymin@minlexx.ru, danila@jiaxyga.com, david.wronek@mainlining.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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



On 07/01/2026 16:47, Aswin Murugan wrote:
> This is a follow-up patch series to address review feedback on the
> QCS615 pinctrl driver addition:
> https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com/
> 
> During review, it was suggested that all Qualcomm pinctrl
> drivers should be enabled by default based on a condition,
> rather than requiring manual enablement in defconfig files.
> 
> This series implements that suggestion by:
> 1. Adding 'default y if PINCTRL_QCOM_GENERIC' to all qualcomm pinctrl
>    drivers in the Kconfig
> 2. Removing the now-redundant explicit pinctrl driver selections
>    from qcom_defconfig & enabling PINCTRL_QCOM_GENERIC config
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks,

> ---
> Changes in v2:
> - As per review comments made default y for pinctrl drivers
>   based on PINCTRL_QCOM_GENERIC config 'default y if PINCTRL_QCOM_GENERIC'
> - Link to v1: https://lore.kernel.org/u-boot/20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com/
> ---
> 
> Aswin Murugan (2):
>   pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all drivers by
>     default
>   qcom_defconfig: Remove redundant pinctrl driver selections
> 
>  configs/qcom_defconfig       | 19 +------------------
>  drivers/pinctrl/qcom/Kconfig | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 18 deletions(-)
> 

-- 
// Casey (she/her)

