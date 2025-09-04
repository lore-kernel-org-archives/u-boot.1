Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B243CA1015
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 13:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E392C83B7F;
	Thu,  4 Sep 2025 15:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U2fwiXuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B5483B71; Thu,  4 Sep 2025 15:53:31 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E1C83B7E
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 15:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-afec5651966so206162466b.2
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756994009; x=1757598809; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rFck2DNPanOWdwpem4UoUxrxQprPSYxqwjaizu8pG9U=;
 b=U2fwiXuqWRzat4++NsAsFlhJXQp12G0zb0VcYPTRoeJnImCmol/8/+/lk152Iw7e6b
 RZbLsNuyo9IHhoYalwMtL8+rv+u93ITHv/X3D1/e9SMYi2H1XpNhTFok7CrmF8UmVeYk
 XbXegM/hcjn6eJ5ssR8ZsTPiiU4xX+ZD4rs+4HKPNE7PQn2HtoDDNL1dQ7AdxH18g4f6
 6VQ3O8/S1ygMrK58NQO/fwk9j6S2jbrdlrqz9XUgIr0p41SPnGZ6MdVzShO1fVXxIww7
 P4KQDXIUbOKewZVbU19kIA7DKA63oKiCIZ+Vq8pPreUSbHbVYO+vNEVvTYYOYUovefGs
 3Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756994009; x=1757598809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rFck2DNPanOWdwpem4UoUxrxQprPSYxqwjaizu8pG9U=;
 b=pLc/J+qaGwIjWVJetDu/a4w7vRvj3hdu1wLtzcMOBWhuCazSHiQtngr0M6fgklbFqE
 7IzTWtEIbnXDenyg6iWQefYes2C/uCrNeuuxfTvLsoYRBVc78yXyVxpBUJerLFSjXYP1
 AH5LxbvqBZ3LawyHNgSqhhfBbCi08VJVRqmoiKiU79ZiltpH7Y+d03iGomeypQgI0LET
 wefojiGoF9Uhi1KVBnOV3u+h8S70NyuzFzr/3VYhkam3smOzVtzqzyxJUfURGa5rbpVz
 4sEiibG/J7SDryEMeiopg4m5Ey6w4EOaES4mUNUZ83+3ZUkPSLVdgGjUstcbzjhHyYJ6
 DXUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2SovAmwTsZKcIWetmo29n4b68w7jIjGQS4AYqzhHjRu59+SSASIx6KzHiIAjZ0QXPKNrq5Es=@lists.denx.de
X-Gm-Message-State: AOJu0YyvUqWgmY2jszSqvm2hzI0IHeMaRj1Nwvzl6W0mnh1TAGc6eQdU
 N3F7vSLUM8MUOC93i+JgyyBCWAJjFOIHDQ66bvBh73RNIueeo8kK1SavG1+wGyb5GZg=
X-Gm-Gg: ASbGncv6zZ81oJzHzzzcDmUcSSDkBLncvVfbw8QpJppDDZ0zh2/MrDASyQxxDTin1lw
 FyJQ4WYjsZ0qk44esIlmpAPMMWwpKSOlg8QYOV5PpPFKg3AXAI4hPWOknc695CND1noC9aODGKI
 EnDAYbUtYVPKDoFNn8c6QmGSkM1HWpSHwzm1mqANm7vw5RJhCkET5Nz1Xe8q2tM0KOjsoIfPxqp
 CiBPJag5DrQYyPXpi9MDCsaKTDNBrHwxsnohYEbtQH2jvAaqHjo1xepo6GLdBPsqhe4DBQfRoWK
 0hozcU/iuXY59GB74mFHy4Kf5kQEBw5aJ3a35m6kmuy8Px1LNvT564rktR3g/K24bg2qQ1vPF/m
 7fGf33xKDCo6Cct1zYMHjzh4fY9vWV9UioswzGg5ulBjUIAkjWc1KkbMPYsNvrg/dNw==
X-Google-Smtp-Source: AGHT+IHuq2loNCof828QaU0r6KA7l4/Tdi5G82WuswxyMiYvfD92NpX4QJx2B1D2KPkFMedRaHmMeQ==
X-Received: by 2002:a17:907:d05:b0:afe:b872:b991 with SMTP id
 a640c23a62f3a-b01d8a8588cmr1754340266b.22.1756994009004; 
 Thu, 04 Sep 2025 06:53:29 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0416e878a2sm1145839666b.95.2025.09.04.06.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 06:53:28 -0700 (PDT)
Message-ID: <bd0eacba-7505-41e8-aace-9d9109ef2a35@linaro.org>
Date: Thu, 4 Sep 2025 15:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: qcom_defconfig: Enable SM7150 GCC and Pinctrl
Content-Language: en-US
To: Jens Reidel <adrian@mainlining.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, Luca Weiss <luca@lucaweiss.eu>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250831004602.699953-1-adrian@mainlining.org>
 <20250831004602.699953-5-adrian@mainlining.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250831004602.699953-5-adrian@mainlining.org>
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



On 31/08/2025 02:46, Jens Reidel wrote:
> From: Danila Tikhonov <danila@jiaxyga.com>
> 
> Enable the necessary drivers so that SM7150 devices can boot with
> qcom_defconfig.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Jens Reidel <adrian@mainlining.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>  configs/qcom_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 86d7de89e77..42a25b4a18a 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -60,6 +60,7 @@ CONFIG_CLK_QCOM_QCS8300=y
>  CONFIG_CLK_QCOM_SA8775P=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_CLK_QCOM_SM6115=y
> +CONFIG_CLK_QCOM_SM7150=y
>  CONFIG_CLK_QCOM_SM8150=y
>  CONFIG_CLK_QCOM_SM8250=y
>  CONFIG_CLK_QCOM_SM8550=y
> @@ -112,6 +113,7 @@ CONFIG_PINCTRL_QCOM_SA8775P=y
>  CONFIG_PINCTRL_QCOM_SC7280=y
>  CONFIG_PINCTRL_QCOM_SDM845=y
>  CONFIG_PINCTRL_QCOM_SM6115=y
> +CONFIG_PINCTRL_QCOM_SM7150=y
>  CONFIG_PINCTRL_QCOM_SM8150=y
>  CONFIG_PINCTRL_QCOM_SM8250=y
>  CONFIG_PINCTRL_QCOM_SM8550=y

-- 
// Casey (she/her)

