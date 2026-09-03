Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF7AC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 11:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41660810B3;
	Thu,  3 Sep 2026 11:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2ZmP_v1tuHp; Thu,  3 Sep 2026 11:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21D82810B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788435598;
	b=D6fmy+K7BWm6Cb8X2IZxUSJTX4EhnHLM4OQbFdvgWmHL5DjFW8rpPRC393ObTuRSmBx9
	 gkAjipr9Jr2mwhYbiH9/BKdl1pE3rezG2Q/daaBdB+3njLYUKNSVR5Xlm0ZlDAKv2cu8b
	 zqaPd8gXL22xy8tNGT7UfXNSFT69g1Aqt9nubeJDPFYHCh4wINm14hv1bPVKLdT1sJuxv
	 GWMgDfD+U5cVsuKAUjq5RPLKlsroakT8zdh622ymKD1lRVL8s07T/9UCra+hxZ7iC9bDJ
	 pQsGsOTBC48mVQPbnjJhTEzBlvUHrJqItVlnyOb9AzLUotpHUnTHl2NmcKoie7OAdUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788435598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AUaDcAjEPCRz3xBikpKVZV9VQdjzCKgWxjx7P8+FLio=;
	b=GoLNzRSsEh+pu0Q9sX+KOgn+06JbjhR+M6FLqOErKGpxFG8mQz7S27b2EnZbmJfUFsoZ
	 SXINipMbEkjNfikrsYadhxnVZQ/O6t43fen4asaUAgIPf3c1uWUDGJjonjXSoGE23CX8y
	 X849uy6T1OdyTe1+PqxwYiD1V9A8ag3gE7ysNCRGDCS9NRTIWTvy68xaavRQLpuL1ha91
	 SMHe2Leidp86NY1g2V0cO8Ivysa1MvimFRQEa5vXarSNLUrU/CvU1oRD+kVFp2IPRSOFp
	 C401d4TzQQSkO2fb+nfhvXWciaiqPfhHOadSD48Jj2U89ah/+zUhppL64eg7Z9cijYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788435598;
	bh=AUaDcAjEPCRz3xBikpKVZV9VQdjzCKgWxjx7P8+FLio=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXYpeA/FV9UVtNwIH9x5qqDfnXmIqcSumBRyIte68q0IveOe1ea4kgiFE0NvkL8nM
	 mxaRVz6GBWFR+ejIoBhAq3lW6TZuy6Q7+L/X56wvbI7JuWJ1KU3TJ6a9o4iHusC6Z3
	 iy9CNWPJFddHgaLbBJe9ePFz4PNoMWWjHG96ri6FIRyCoXmPxwk9AkOGPERU5IMwMl
	 BC8mm0+Z/eDivi6MvfiFVJCSdGHZexgDGKwW+nAZzHW5OvTyWs+EbGcz3clX1sVvdg
	 FkQa1anG0bq857WPc/fU1EmouQh7uGKl5EeoDS0LFPctA0vRrRN4k3ggF5O0liLGsr
	 Zsxx6MSiblSRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21D82810B7;
	Thu,  3 Sep 2026 11:39:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59F93363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F6A640A66
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:39:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnzm2f-VxJ3r for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 11:39:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 399FA40707
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788435596;
 b=jHvEwL7Grv4n+3uX7m4M5usZo1e0TFrJDqcNvmEt8gM5qAjhh3AHc3W2x/ifQk/pe5vO
 lalJDoy8BC04pRYUOeYou+BjkFQDTVy506nmtpF9iw1e/Q8OwIWEHcCPLW5K06kmtHzB0
 pbpsgOr0aJPM0fqTfYL1UGRvxwy4/XPu+eGlPGEJu2/i5JfV4XMiDHrW4Li4QBTOQ81x2
 wA5SVnHzxB1iDWJ2+t7tEZ7bAexvXjsG99Bdgr0MSk9X3WVSQG4WhtxACOh0cMd9PMLgb
 4MsEy6KwxbkDUgWFcPNMkgmFwqo20AFesjNGTup29l4l4OparAGPkUFtJZ4ptI4k8aQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788435596;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=AUaDcAjEPCRz3xBikpKVZV9VQdjzCKgWxjx7P8+FLio=;
 b=Kltsx+IVTUjrunAvm2HULv9edDv5x1FQju+QUtlV6u5dBf3aF4nCHIbMdTGSt3djHls2
 9EQ1oR+0hxBT3HI8gV5RVKKi5srBAsUN0SPAwIuTraXg0rGXUcqf7VjLPsbNMUgYhxSTd
 kzOcHSwt5A157AtC0Et/kLNHl60N69NfHO8jPh4SDiboUnFchgu6v/yS5e/V9fUR5VdJC
 0Yw0Yl+wJuV63mndpq8QKVZ7S60UGCvuiV0GwosDOoogMRjTeO+l0sYcHfAFrefWIZ5Qf
 GTqE9dKSc3rNgulfkTKBLjqf/26+D20jjxpFmSoyAy0n829wsow58TOf1qBI6QlRgSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EptibYoj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EptibYoj
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 399FA40707
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:39:53 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so25785195e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788435591; x=1789040391;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AUaDcAjEPCRz3xBikpKVZV9VQdjzCKgWxjx7P8+FLio=;
 b=EptibYojreTDy/0FQ55Zp6OmvZxdq5I+jH+B9MokQ7yvhlrCaemI9L3LMX3aGc7byE
 Y9HcoGYo6AEQB+Ijcr0X9IuNY3aiebVWWOpnKwFMTCv6VwzhFioxRZPz4jgjnbZ+RAMn
 A7EzHARu3+Dyaq8WndeRqimh8SHa3iDVv4XD7bKPv433gs9VohJ9sp8hjzZTbcvmdUgD
 yo6+H+v9R73Ns7IWEZ7cYv4SR+jAJNKjTwfheKVzJ2bRTZsyhdHe689SkSmkfDhi3BOu
 6NkJE5YVb86ocYkD9K5tx+nYhYFCUkmIp492WqfuVIx3yUYZnOgNxA5uRIVkku/1Hemm
 V1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435591; x=1789040391;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AUaDcAjEPCRz3xBikpKVZV9VQdjzCKgWxjx7P8+FLio=;
 b=T5TC46YkU4mAJTLcOGGUwSE9bgd2oEX51J6d1StUhJAKugdUtK1rvpmHJlYdDxsmV9
 EDziytcZfljF8cj+I+bUOCRWDx0d1gZzymFPOEckyC1SxBVfx9yqbhYl/cU4F9P46fr6
 qny20XUNVP9TyRG6qEuyoT51LiDey3FYVCB7CXX5vjVWe0D0r1cIARQCGU/KcaP2LZ8n
 8rH+Z0VmWgJgyKCU5avkV5q6Cd+GXdQKSHmdDD7/4V1kBF2kiUaPQsGRn6X5H51xxbJO
 OF+PfkKE+uZTV045kYNB4ZCS/TytWJ2i/tRE8SDl34rb5LKvm7+HgGr6PnI9nAdDCShr
 yEGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrsswwZAu0OXsE3lQLY6TkY1+yDV3pbo+gFziiFxA8f8+7PP7A6S3HkxG75xBp4NwO30jjbnY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkoWvzZvuX/8euSPc1BfZyAKGIBwQ7Z8tFrg1N4IMJHxW7X4h1
 9sjeA/bvJKb/TP7N3gB92YRlHisrvzNuHiRpWMYqez6Tr1ssU1VgWovvQFbZ9Swsv3k=
X-Gm-Gg: AYBFou2lMLkbA0XW3zzyutPL15Xks+IJsCuPrGugoufP0gIaiQq5/Py8CnmxJmh5F5O
 JR3Rk+BAnuZfFTYXJkAREX/Lvw/IMj9mxs2hFNTysBvcVPBXs8fh/k4ynVHoCCDRMkr9th+DcFx
 subP+zeSj1TsN1N4LS3dnvhCW1Fwx2uej20flzI48NOu+fMGXEnq4MSzHH9b0dS9pRgThC5CrVU
 pbo8l4IhyZyjOmT7myFIRkVZ2ogpN95NJ8+y+zafZb1fE1IofHp2uDbAq7gUXvAGJJXzGG+IwFi
 +U7nchWlAOWf7ZGIcpeX62g0iNUTSdOVMALRCto+2T3wK+ABZfUNF+3JwGD7Lx3XY6KzfBfwQ20
 GPlFW4QhF6dehmk37rG//AsoeiQeTw4I+wJha7a0zCSv9jGeGPVMLZ1dPuSJpv7t6I6FPw+xUcJ
 T2SwuPlvwLmjbQO7UEuLvbyjCLk00xUuczS9eYZOvJvU9WumVcnWlgQ14o9RESTRHXoHai4uhKX
 rHxleK1REpa4Qib7onSN/4X4w==
X-Received: by 2002:a05:600c:4743:b0:49c:e3b1:d826 with SMTP id
 5b1f17b1804b1-49ce58195b0mr175934615e9.13.1788435591526; 
 Thu, 03 Sep 2026 04:39:51 -0700 (PDT)
Received: from [192.168.1.37] (p549d4d01.dip0.t-ipconnect.de. [84.157.77.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e6f604sm13123020f8f.2.2026.09.03.04.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:39:50 -0700 (PDT)
Message-ID: <16d8ac69-b8e6-4d4c-b2fa-6538246d63fc@linaro.org>
Date: Thu, 3 Sep 2026 13:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm: dts: qcom: Configure Lemans PS_HOLD reset
Content-Language: en-US
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
 <20260901195748.1192630-3-sumit.dhami@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260901195748.1192630-3-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 01/09/2026 21:57, Sumit Singh Dhami wrote:
> Add the Qualcomm PS_HOLD sysreset node for the Lemans EVK.
> 
> Link the reset driver to the PMIC PON peripheral and provide the PBS
> PS_HOLD control register offsets required to configure warm and hard
> resets before deasserting MPM_PS_HOLD.

please link to the upstream patch adding this node and the new DT
bindings, I'd like to see them at least approved by the DT maintainer
before we start adding these bindings to U-Boot.

> 
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  arch/arm/dts/lemans-evk-u-boot.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/lemans-evk-u-boot.dtsi b/arch/arm/dts/lemans-evk-u-boot.dtsi
> index fd4eaa2fec8..0e676bf4b55 100644
> --- a/arch/arm/dts/lemans-evk-u-boot.dtsi
> +++ b/arch/arm/dts/lemans-evk-u-boot.dtsi
> @@ -64,3 +64,15 @@
>  		mode-edl = <0x80000000 0x00000001>;
>  	};
>  };
> +
> +&soc {
> +	restart@c264000 {
> +		compatible = "qcom,pshold";
> +		reg = <0x0 0x0c264000 0x0 0x4>;
> +		qcom,pon = <&pmm8654au_0_pon>;
> +		qcom,pbs-pshold-sw-ctl = <0x52>;
> +		qcom,pbs-pshold-reset-ctl2 = <0x53>;
> +
> +		bootph-all;
> +	};
> +};

-- 
// Casey (she/her)

