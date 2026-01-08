Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47786D1D480
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D514C84158;
	Thu,  8 Jan 2026 17:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i+gmhJ+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC668415D; Thu,  8 Jan 2026 17:41:47 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00DC84150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8018eba13cso562476466b.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767890504; x=1768495304; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j1W1eDrE830m/SiIN/XBKA/wspRJhMu7avOlNfzcQm0=;
 b=i+gmhJ+rJNaoPhSFR1dhSunXr3/g0wAAI3BcjtQXJHldyrrDimo+gXjiA95ptui/Gm
 gMj9Erbj2xrO4ynRof1mxK+XLDH3DYdeUKyVO9g9wSBqAiIK+5IrtnvACR2Z61T9RIUT
 IXPOWpKC1882epV8iMn0vHF75+i9T+G3BLwHhmEYl3fvYXfoF+x2qResQYVDhG9Ru4I9
 yEU1vLfkPP/zUq2HGojsofERgoaA+CFI2MkyBTCq55GviYkafXx1opnYPWubA+rKDomH
 dYvtIDgSS7s1GkT5Lh1a4sGVGs6JUrMw+2YiDfALMHUW0TLD/LHaGP0ssYhpL7OkgGCp
 UrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767890504; x=1768495304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1W1eDrE830m/SiIN/XBKA/wspRJhMu7avOlNfzcQm0=;
 b=jOD+ZpsaUQ+Ht9jBlB0m2dxR91nBAP5Wkl0b9/Qlk7YAt6z0TkSz+X3KJ5MmvOBQeA
 MZeAzequ1mR5THkc/kQj8pJiBS/2t+V8XcHefApwswlq852fW4DpWZSeRcQB5Ca1oiKG
 ZOc/qVck7njnTgpE91uFSQnSeW5iwWePL5HMTaVbGNdjT2oR+4N3ZiuHR4LmwufJCfOG
 eaJWG+03DFW2y2MOWKwddE3o0JHBi+zT1FqijPehSIghyHEuR8KH5efW9RgNchP67kQ1
 R9XuPf8KDAyDZap0oe+u2XuMJ74tn+IYJm2wJJ743ARQLBSDtCfhB0FirgI/XEC361rA
 0mEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrmIxWvVhN7IEbd7Q7c/+aBc0W/8jQ2eh4FtvznFkimPEidDsmuh6vmthMU83zK0Tz7IyzP7Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzJCKoG0LJBJ5jKv8oHMwldhab3GPyfJObz0nLwH2bDuvGBVaPs
 3lepTO/f/+tyPqrajaK/zLEq81Y+ZfVVpisW146fvsiNlWYHc3MHyk6BkuybI00unp4=
X-Gm-Gg: AY/fxX6qXZW1a4Vr70b5H0L36ZXXXRjBQdLT0UIpCPqnc7Y+O/X3y1wXcwA38IFA8Ya
 fZIlTf87L1Clp7Uwptm0Z0nDC81l/kylQEH6msFA2avPXR0HKNrq1Fmc4Xk8pjAgpVMhZ+rCqom
 vahWwBkXZcli3AzrlTqPykpY09Llc65+tDzt6BtD54vOYbRZwtHe/e6O16hZKpUhDpJDq92G4YJ
 SCJ1+pEOE8bQjDG2lfgwfOUiWQ/ZhvEX0FGfcHh+hlhR9mL/LCFNruw0UEXeYOjaeTjsRKWH9f0
 TwTYbU1QhtFP6F7ZIj84j06eoNFc1FzGM3QEIFP6Eu6Seoeu0tHBzfSbzxR2/SbvidDxn5taPjG
 xCnDU0/M/E+zktSRWRJCDxp9TrB78L00pHU92FL+TNALWphRH+3QtpnJkL6kzQBpMhgY2cdMnK7
 zG2UWrohHJNoDy/lRoTWLw6D+W6o37zW1BpyXdHdLXj0+MAHGQGus=
X-Google-Smtp-Source: AGHT+IGc+DhMcEQtwdGcaqlQZT2QEdRGxaXItEQKBnRVwN5ewB5GgMz0ltWENnOKc08PILI0KNZx+Q==
X-Received: by 2002:a17:907:3fa7:b0:b73:880a:fde8 with SMTP id
 a640c23a62f3a-b8444d4eb55mr738867866b.12.1767890504088; 
 Thu, 08 Jan 2026 08:41:44 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a234000sm863807366b.4.2026.01.08.08.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:41:43 -0800 (PST)
Message-ID: <c0bc6cab-6eee-40c2-b6f7-ff14d91906c5@linaro.org>
Date: Thu, 8 Jan 2026 17:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configs: Add generic qcom_tfa_optee_defconfig
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, neil.armstrong@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <20251229114312.668068-2-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251229114312.668068-2-sumit.garg@kernel.org>
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



On 29/12/2025 12:43, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> corresponding boot flow is packaged as a position independent executable.
> 
> So, lets add a generic U-Boot defconfig for Qcom platforms to support
> TF-A/OP-TEE based TrustZone stack. Build command:
> 
> $ make qcom_tfa_optee_defconfig
> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2

This would be better suited as a config fragment rather than a new
defconfig imo.

But more importantly, enabling OPTEE support in U-Boot doesn't imply
that it will be used, just that it's supported.

So I think the more appropriate patch here would be to just enable
OP-TEE in qcom_defconfig (assuming the binary size isn't significantly
affected).

Considering the other patch is based on this assumption that if OP-TEE
support is enabled then the board must be using it, a different approach
is definitely needed.

When I was looking into this last year I remember discussing this same
issue from the Linux side, there is a good argument to be made that
OP-TEE support in Linux shouldn't be based on the devicetree -
particularly in the Qualcomm case where whether or not OP-TEE is used is
a simple software change, nothing to do with hardware.

So in general I'm not particularly keen on this approach, I think it
/might/ be acceptable for U-Boot to have some fixup code to add the
OP-TEE node if OP-TEE is in use with the idea of phasing that out in
favour of runtime detection in the OS itself. I'd also expect that fixup
code to go in the generic U-Boot DT fixup code that runs before we jump
to the OS (like the EFI DT fixup function).

Kind regards,

> 
> For more information refer here:
> https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  configs/qcom_tfa_optee_defconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 configs/qcom_tfa_optee_defconfig
> 
> diff --git a/configs/qcom_tfa_optee_defconfig b/configs/qcom_tfa_optee_defconfig
> new file mode 100644
> index 00000000000..c398521770f
> --- /dev/null
> +++ b/configs/qcom_tfa_optee_defconfig
> @@ -0,0 +1,7 @@
> +# Configuration for building a generic U-Boot image
> +# with support for TF-A/OP-TEE based Arm TrustZone stack.
> +
> +#include "qcom_defconfig"
> +
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y

-- 
// Casey (she/her)

