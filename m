Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DE0CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7140E846A5;
	Tue, 26 May 2026 16:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CsJ4QhVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474C6847B0; Tue, 26 May 2026 16:56:47 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F297B84671
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a8e33556c0so13069553e87.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779807404; x=1780412204; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZ9F9rgqs+8vqg1G9W42DUjH7OMudlsgdog/ngW6MeQ=;
 b=CsJ4QhVw3A6Blcs9bvTW+ki0VSIGw8R6qgoDr0OfTA6/FvQQ7zqHe02bi5pV755vaN
 GaGz6BBQIMKOGrhopGqc5Nax6YbrTo/jM51PC15UffUbfeHz/gNtQyZYlKtGhvHnBZhh
 3ijC8t80Sa6K9A61Pv1sOytFe5vNjF8MQP8/W1vLCT0TZT9wG6qV5nfL303tT0J2xfTr
 jyZfIsxfvA3Fl3IZG1WK+lzto+TnEgRuLZBPLbBV0s5TOzdyalhoFhxaxpsXZNCyc3iE
 cpwFHLldvLLdFedBXdA6c/UEpsVrv878oY9z9SXZFb4+Zr0C7gLyC8D5F/o4XQtT3fsB
 kdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807404; x=1780412204;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZ9F9rgqs+8vqg1G9W42DUjH7OMudlsgdog/ngW6MeQ=;
 b=sIAEjxXNzPWkojoRBWJqyeqZCtFs9LZnckbpGbnDMDSGcB68rcdK4wdPp+28+2GNn7
 LNeS4v9pFgdyl0it1Ca2xJTnBDvbMKSFkoViWP5vk1LxvBXzGcs/IU7OWjJvSRjnICNB
 N4KDDThYAMoi2XPnJZ262UggJqyPvqdI4fQcNiRIwiu1yC9GaKGILN6OMbXw1q4jHTuf
 WLpY8JZvp8I89D7T/sORbMBj5fvo6v6xBLyd+GFdvOEKLW8/SzQf4f1dUu9Xrqo4uY+b
 p8z+CyvgfIH0+Iyc5APdtPnoUX8Itltl9OWJYIkmeU56h+vX2Yvb9lIuCdGUpz0m6wLc
 GrDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+wZu/5PwJDW2dZq/1N3X69qVgfwl3NCe+dtCp3EHYJrjPBhpxrAmun8kuj0XME1MDAsbIpe4c=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4GGhxWUngzZmvDOeButSDLGRKEs5J6dyDugEaFjz3i22naWlZ
 hWaLXltPD2F0jRbKZCmigvuRz6+/JZEeIshuMgGf2edcA/ztr9rLwasmRDmum44Ngr/dPv2n72U
 ol8My
X-Gm-Gg: Acq92OE3k2K6C8st+zlhEx9W7lh+KDMkZSqLuHxh3SuhodyVC2yKZ6ewJy9xQo7jWS4
 3DbRe6HRoSSVLeqE6Py4c5DoItg3lHccujfaQpUP4iXWZCRdHjOFCihKhiqWh2/NY6st1htJyN/
 YSQi/IyV5ySZriV2lqtUqdYtwdr512Zx548lV4QHcOVYiW5h9iTluTDXrdIop3xnw6cKEZKeJUL
 igdkNNwgTLdonKuKDnMJyeyESPTh4gtx2c5LG01D/JYFF6sU1BCK0kVwrH9r1XEU5RIiBZvZ4R2
 nQCGFU1keq/ZJ0XoC7xYbXHAjDzLf7kff7jX+xALf3J6Gha8byUjIOPb6L5u8GW2aSwGY4PslY1
 9M1zcpq5ZJmfzfAP1H0h63kZLsp3nRhsY1uOMD1yy0oQ9gPxdgKrRcF3G0xpiKOiC5x0q63EjFX
 hBgHhboGcknA7OX+ZKTWturKmRbeG1fCIda45POrAbKDW3PAarY65LKma66RXDGdc=
X-Received: by 2002:a05:6512:1086:b0:5a2:b514:4fbb with SMTP id
 2adb3069b0e04-5aa322fb141mr4920524e87.11.1779807403935; 
 Tue, 26 May 2026 07:56:43 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa462cf284sm482867e87.7.2026.05.26.07.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:56:43 -0700 (PDT)
Message-ID: <778d8313-7140-4086-997f-8c94a5e0e1ae@linaro.org>
Date: Tue, 26 May 2026 16:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: qcom-geni: add DM_FLAG_PRE_RELOC to geni-se-qup
 driver
Content-Language: en-US
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 gurumoorthy.snthakumar@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260524050328.414639-1-gurumoorthy.snthakumar@oss.qualcomm.com>
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



On 24/05/2026 07:03, Gurumoorthy Santhakumar wrote:
> The GENI SE QUP wrapper driver (geni-se-qup) needs to be bound during
> pre-relocation to allow its child devices (such as the debug UART) to
> be discovered and probed before relocation.
> 
> Without DM_FLAG_PRE_RELOC, the qupv3 device is skipped during the
> pre-relocation DM scan, which prevents early serial devices from
> being bound. This causes serial_find_console_or_panic() to fail with
> "No serial driver found" during serial_init().
> 
> Add DM_FLAG_PRE_RELOC to the geni_se_qup driver so that the GENI SE
> QUP wrapper and its children are bound during pre-relocation, enabling
> the serial console to be initialized correctly.

This is a non-issue if you correctly set /chosen/stdout-path in your
DTB. I'd rather minimise the devices we probe pre-reloc and skip this
whole dance which we will do once we get
https://lore.kernel.org/u-boot/20260401-casey-ccf-compat-v2-2-414d5b7f040b@linaro.org/

Kind regards,

> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.snthakumar@oss.qualcomm.com>
> ---
>  drivers/misc/qcom_geni.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> index a62ae6a2478..cbad7bd3bd2 100644
> --- a/drivers/misc/qcom_geni.c
> +++ b/drivers/misc/qcom_geni.c
> @@ -576,5 +576,5 @@ U_BOOT_DRIVER(geni_se_qup) = {
>  	.of_match = geni_ids,
>  	.of_to_plat = geni_se_of_to_plat,
>  	.plat_auto = sizeof(struct geni_se_plat),
> -	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };

-- 
// Casey (she/her)

