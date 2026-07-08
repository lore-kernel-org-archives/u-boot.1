Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDD2C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869EF8497A;
	Wed,  8 Jul 2026 14:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ckqiqC9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AA084979; Wed,  8 Jul 2026 14:11:17 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA0584118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 14:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-848479c9bd5so337584b3a.3
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783512674; x=1784117474; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JqRtJ+khLTfAaENOUW5lQ58JjLcnpVprujtYaQTyQDM=;
 b=ckqiqC9p2Zrnj3BqU89apEtm+UnmBNu3Xg1E2Xlmt/Ad6364M+4DV+s9nc4JIgWIAS
 5JlzsTVIME055lvon3q6DE/8s6Nb5Y/Ypi72vGrLfYfwkfWIE8WXhwCBD97+BTNRrzfI
 cleqdnl9BoWEM3tcgXkana/iGKX/+qEdMEC4lyrrfPsCNZJJjB9SobeEBXjJcIDGLlM9
 0QjBOs/dZzzw0SUpEDBrW0tTJU14hq351DdLIanK16Ru/t1/n72++7X8zx7Zm8cXg8d2
 o8aSwEm0JiWaX65NTFxS6uwJb7FDus86c6yrL2AvimtpmyuoFdebJJ1gCsC4QSyY2Kpw
 UEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512674; x=1784117474;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JqRtJ+khLTfAaENOUW5lQ58JjLcnpVprujtYaQTyQDM=;
 b=IAgxVSN3wl743vXBhQ8MNQKg8WKumOBOVsNw95qxjDsNwwNwJu8x2EPYPaol8OH8md
 0wzIbTvz/nNu5/fPj7fJ8QOQvR9bUW0BvZkmyh15iVGb01YSULIRgEW9jc/usKiipYcH
 01Q39aY2qiNojjsSVJkKq/nn9dX0+umTHhbNwOZxT32Jfuwxkm3VwVuSakDtmeU0U2EH
 VEXcrEn+nSl/uKrz8P7mAOENchC50/37chgH7HWwfg+Gj3yvYi/V99/sLZfCfVa1LuHr
 UuhUcICK/t2l696oN4JU7MN9HN1jhm/r3UVtUDzEkH2/wJPklVuiDoeIknAO0Qbu/vyp
 FHVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCpp2hKAxfInU2n3m+GE1Ap7RCYqIQbcK2h+AG7fTAo4P8i5wfLBKCBVUh8HmYEysJwW/r+RU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9zEcVAt1JIuG3WeC5kzVUb12cj3l5QjgF7C2Hm20fgzpGnpYm
 tY/i3esfpxdSKYwjpaRKmQy1E3q44Itqyn01kCtBjEtux3F+txgjnv5uuOrkxmqPH8iZ86Dbv8g
 /xBj4O5b2Sg==
X-Gm-Gg: AfdE7cmn+RSB42//0BMhZUSnattS7U7Clhd1ZSKqpce8Dg/PvtP47x/dRDRzL+VboDn
 qXa9lK3C7E96zcdGLuiF8bHBGZMYsapliA+YFOoNLhujHCAKNiz8yN5wAMUS9aGywrCQQX1qc6v
 JhuC9zqOOKL1fQfEB95fEf0tXkOTAXdz41kVaabfzg4X8xUGnItw3rtM8/0dfPw+TlA+4Vs5GDd
 diRz+cFQN5fMoDhZH0QbrsIDpXvCfcTwicQsVn8+E43PeJ+BczPUaxmvJro2G3fbOtB9y9Yj8aR
 J1LyUqZeU6VPC9jMJccGdt1puGmka4C0zfnOVUaNGyurDY9Mlv7letiRGRFx4GyF8RafC/SqkHR
 tUsT9dTwKrnLev3Z8UWQzBXBI7YQHBmAWm4Uhn9FhwprLtr1VxnNr4YgOND5TdwltnqtxitPmoI
 kRt1uMPOpEE2NnKX1avaolvRgZWXA=
X-Received: by 2002:a05:6a00:4292:b0:847:9c06:2bef with SMTP id
 d2e1a72fcca58-84842ee3fcbmr2579890b3a.29.1783512673470; 
 Wed, 08 Jul 2026 05:11:13 -0700 (PDT)
Received: from [192.168.45.141] ([112.212.195.74])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5afbc1363sm2272566a12.8.2026.07.08.05.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 05:11:12 -0700 (PDT)
Message-ID: <005d2642-e23d-467c-9c02-ace78c108daf@linaro.org>
Date: Wed, 8 Jul 2026 14:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: qcom: Update ipq5424-rdp466-u-boot.dtsi for v7.1-dts
 changes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot-qcom@groups.io,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260707220257.252911-1-trini@konsulko.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260707220257.252911-1-trini@konsulko.com>
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

Can someone confirm this?

On 7/8/26 00:02, Tom Rini wrote:
> Once we move to the v7.0-dts tag, we get a failure to build of:
> dts/upstream/src/arm64/qcom/ipq5424.dtsi:556.21-573.5: ERROR (phandle_references): /soc@0/mmc@7804000: Reference to non-existent node or label "sdc_default_state"
> 
>    also defined at arch/arm/dts/ipq5424-rdp466-u-boot.dtsi:20.8-39.4
> ERROR: Input tree has errors, aborting (use -f to force output)
> 
> Looking over the changes, this appears to be what's required to keep the
> platform functioning as expected.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> This file isn't covered by MAINTAINERS directly, so can someone please
> follow-up and correct that? And, based on looking at the changes between
> v7.0-dts and v7.1-dts, this would appear to be the right change, but I
> don't know the platform.
> 
> Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> CC: Casey Connolly <casey.connolly@linaro.org>
> ---
>   arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> index 36640f31d616..56677cd6f6da 100644
> --- a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> +++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
> @@ -24,7 +24,7 @@
>   		mmc-hs200-1_8v;
>   		max-frequency = <192000000>;
>   		bus-width = <4>;
> -		pinctrl-0 = <&sdc_default_state>;
> +		pinctrl-0 = <&qpic_snand_default_state>;
>   		pinctrl-names = "default";
>   		non-removable;
>   

