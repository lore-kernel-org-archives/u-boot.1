Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010D2C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA5381F32;
	Wed,  7 May 2025 14:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LQaCfQj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658778211F; Wed,  7 May 2025 13:38:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A6181F32
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so30661425e9.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 04:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746617889; x=1747222689; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wi+/jGcU3qzCGk6UGvVtcl9lndEk2NzqCedbCpF5O8Q=;
 b=LQaCfQj0fo8HjLnmHKCjHJYacjws8z/XwKlCFfHmi1Y2tJ7p9+t0NQ8taweRooksTF
 Hq5KxtvNmv29w+NNv5GtHMxYFHkc0PXJWqvx7MhwknZa4qkK9UvkP5fPK5FkFppeeNzB
 cWYK4xGg3RL06UIRwtbd3pOjHxp5W1k63uWLFhDxHNjgQsuU9uAV6svPFPHyQKqouzTV
 8ZBHcB4zZn11Oyg3nF9MiQiarRYY02CBbyGhLTidD7+6E+zRFkPvnQmQjfzRqEv/q4Nq
 pMBAMvqUOTgKMZIE05EjOAmuCMRHIBulNurFISIj7Ui8djqjAdbsFHkVb/9OD8K/CjOb
 EXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746617889; x=1747222689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wi+/jGcU3qzCGk6UGvVtcl9lndEk2NzqCedbCpF5O8Q=;
 b=spHGoS0wjul14kGO+sD3IMMP0nWsN+Dn9f2gUJMS4DXNhjnWWAh30J4WKI98Aa/udl
 0C3Oa4a7eYDbXCEVW1JmQtF0dtJsWz66iqZzcN+fmt4a7pATzcYxeWAq+zzxW7vBVhx0
 Cd16ZP+AcWt9wyhtz2LqQGu76u0XAUr6dfyUjIWYR/zanzYd9/TKDF1mntersBJdUpMV
 fQGrAVi2wNoAG41DsZd4Y5M6a284ceGupgjBM7zR34xMM4D96DLmQvTuWEvfuAyMK1Iu
 kXMb6BRO1d6VjHefSTPmuVAJrq0IZpgkDYziVUilGBOn3U5/J8hWoLX6r70Fh80khp8a
 yttg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGee9LAhtLlLikpFONtxg5H045qWgWplQrkN/y7BZrVI/Z3X4yuxnLHlBASEdfFIti66Uggu8=@lists.denx.de
X-Gm-Message-State: AOJu0YwrxRYFCNswRt17W2WhYa2uoDHpXS6Y+8REhvAkaLNldKk4LOsK
 0NkA/mBZ+VYb6UmqyrYQCE9HVxtavErBGrn5rm/y8YYVcVnUZzmKWc59T6Xr2S0=
X-Gm-Gg: ASbGnctGLo6PLaxCaRxJf3xqQpHfHNNymfRAclVmaqkXYZTqqrDQwV5ieMCwuBgQc12
 GrmsJGfVeRG0s+AOEJ0WicoZNJ65ribRbMo51AjJ1ZnePtPVT/X4V5XdEaOb2YRfLHmhYHTaXeo
 ZHIDUp35urGn2MPoh/zRq+I4RqktUBtlSZS3bBbmDnitreONteN1o1ycl5L/29pvLYHvSG+AgX/
 jwrSRzyli2f5XtN2J9OgjzSpou+6j39a2DdgYNTs7j0jkwV93y7tcgb7as/MYPg4wEGrkF2Tbxc
 qK5ixZDEzyid0TN1tDngj6ywIr1OyHAKs8ArZk6AjWE3+7+zZMPmGVBkRhqOfHEMzCemauWnzuZ
 lpX4Hpeg=
X-Google-Smtp-Source: AGHT+IEoTpQnOj1dFMsuRtxrqg1TK6BDSdEdUZ2Zu2ulGdFqCKAs+KABZxjR8wyjKzrJ3bp3LQKQdw==
X-Received: by 2002:a05:600c:820a:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-441d44bb7f4mr26059795e9.7.1746617888600; 
 Wed, 07 May 2025 04:38:08 -0700 (PDT)
Received: from [192.168.1.47] (234-60-142-46.pool.kielnet.net. [46.142.60.234])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d43d1f58sm28500825e9.15.2025.05.07.04.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:38:07 -0700 (PDT)
Message-ID: <2de62c4f-6dc5-4d3c-96f3-33014289b3c1@linaro.org>
Date: Wed, 7 May 2025 13:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] configs: qcs9100: Enable env in SCSI
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 joe.hershberger@ni.com, avromanov@salutedevices.com,
 michael@amarulasolutions.com, hs@denx.de, sjg@chromium.org,
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, xypron.glpk@gmx.de,
 cniedermaier@dh-electronics.com, ansuelsmth@gmail.com,
 venkatesh.abbarapu@amd.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-5-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250507112812.3066301-5-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 May 2025 14:39:00 +0200
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

On 5/7/25 13:28, Varadarajan Narayanan wrote:
> Enable CONFIG_ENV_IS_IN_SCSI to store environment variables in SCSI.
> Set env variables partition UUID as seen in qcs9100 based boards.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: s/CONFIG_SCSI_ENV_PART/CONFIG_SCSI_ENV_PART_UUID
> ---
>   configs/qcs9100_defconfig | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d25398..cd48973599b 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -14,5 +14,8 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>   # Address where U-Boot will be loaded
>   CONFIG_TEXT_BASE=0xaf000000
>   CONFIG_REMAKE_ELF=y
> -
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_ENV_IS_IN_SCSI=y
> +CONFIG_SCSI_ENV_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"

Could you also update the RDP documentation to describe firstly that env 
is loaded from a partition, and then reference this GUID and which 
partition it is.

As Tom mentioned before, doing it on FAT would make it much easier to 
tinker with, but I guess it's better to match what you're doing in 
production, just as long as it's documented...

Kind regards,> +# CONFIG_ENV_IS_DEFAULT is not set
> +# CONFIG_ENV_IS_NOWHERE is not set
-- 
Casey (she/they)

