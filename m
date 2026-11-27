Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC8606A326
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kGSvIuKn;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z8LbKbbX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C763660B3F;
	Fri, 27 Nov 2026 14:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3M2UD_FPrHn; Fri, 27 Nov 2026 14:39:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 177BC60B04
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795790340;
	b=XOp4Rl6h4rtx9JKBJ6kE7BeuVQsB6gS13jW+jeqNBYyG2ZRMzsH2bKF1eqqFZ1m+QWMT
	 ISB1unEVvGJ3mF8y8gXRayME5LWtF2rXOW5YBvWomxiwk/gv8tzGC6evbPw0rTfr8BZK/
	 Y/lJ7Xto/2nulcDlfjmja4tC94mH63XTyLvRAV62nRIdG4UVasCbkZe8mgODv5L+Us5y5
	 Deqv8k5/jedwZjca9DA67oOq1s7pUO2plRghY8iJJOIdSdYnlsFW/ho1csPjbhTEW0X5e
	 kZ1PsAV02UNFfTQ0QtujI2TIDeWMl/BpmVRNfo4T3Kgq6tp+oXV32BV795ztCy1aiVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795790340;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8udT8kYvSBGvGVN4nZ4m+aKjT5Cz7iGWaqjxPlcn+x4=;
	b=LAYZEaNaxKmKukDL2jkssaBIKvaOowsNCGj+kJsgv1hEgNRWvAl4TQljMmiCFDSwv8hI
	 Zeho/TqcbwrBEoi15lrEgzh5HMJjA/Sr1CIBqBNGe3e3DAPQ6JPgRje9QWTaiAEJCvIAJ
	 UnR9psBhrYfkOPsQt3rSy0Hl/Q3XS+OM1kRP7jjdiPNJEQy1SdMp8WR26hG3f82rDhWxU
	 1OPNUZ9jcHzkY0QcMLJXW4mo5e+HBLjygKg7BQjh9teJfdv7pX2fD4VlYdV29b5I1tb/O
	 S6kYBGWg0V9Tsx7Nd1ESoCFF9wsqDeT097aCifHorQjaiD+Uo9ws6LycK1nHcn78l6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795790340;
	bh=8udT8kYvSBGvGVN4nZ4m+aKjT5Cz7iGWaqjxPlcn+x4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kGSvIuKnL1RKkEAqMy59Vq7ZdWeYO/Vktoxvox9cn62NQrD47UQ3ZXQS5tHakAVFj
	 Tyv0mhCLA9hBlgWejdSdxpZHR0ss3WvOFe2K5OiUtaY+Vf68aebPEayqVwUOs7nKpY
	 48M4q2Xk8/VDt8txLep9Avr4EJKIzGisuoItos/neWrUilEamNzKZx9wUT0w821GRJ
	 g8+v3CZvfvj67KVoGzLDNxougEdgYo2oScKSEkl9Od7ICZqe54nrXSnY6XRGlv4Nw3
	 lrsUtVFlxM6cSTjIlTMlO9iIuAsfYdyIOaQA35DQ8xk8fKdgeCMMNQrfMXeSlTJ0e5
	 xl3tXodbiSRuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 177BC60B04;
	Fri, 27 Nov 2026 14:39:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F0710373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE19140573
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yqm21FFlw8a4 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 14:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A4E6C404F1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Z8LbKbbX
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4E6C404F1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:38:57 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so86967385e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790335; x=1796395135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8udT8kYvSBGvGVN4nZ4m+aKjT5Cz7iGWaqjxPlcn+x4=;
 b=Z8LbKbbXo9+6B8ECDCXmbI+4Cr+306GU8pvtn0M+4nmgw5IDe8d7YlIPOQ6g8H893L
 BVOoZbu5SfSQBrLneYOOIRPJyHXVFeV4fmq1sTIBrGA/mcGTiPVlAibfyKEA70Zxn8gb
 1Owrc2lxAlucqxcz3agrN1055S0pnqWVvK/4+1RBghlI4B86QIOGfYV2GABWIzH8L70v
 77oRV/AqVeOpZft4rI7oNELiISvT1DoT7wnuAty0Zikz0g5o8CJSJaelyxFHMnwUFQrC
 jEBR4Uju/PBM+dD1OPIUy3Lz3HUWZ59zCKR0ZMRVVTRS5j2ihpj3guz63E1/LrWgIoL5
 mcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790335; x=1796395135;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8udT8kYvSBGvGVN4nZ4m+aKjT5Cz7iGWaqjxPlcn+x4=;
 b=jZGkkDioTN2IOzSrH+BWGZqR59AjQ6uOi/MilWjEMZHxcPMFs3FtQpShqu3n8utbi3
 hNrHSuNf1AlAch5Oe8WDD/RfcMTPO2ScfwqE3mM9M5TQthXxelSBSpPUaCtCBGV+UTj7
 UTL112j7FdoXq+QAH/UBoIkiqp/gJrfMxvs9uCQpk+nj4byDgOcg4g6fz8Yo01lzLDmL
 wxzTiTexmhjQ3W4SUMQQRVsDN+L5UVB2N7iMWbgaRBiX4CjE07+COE30e33l0tXSqWPA
 /Y3Doy3KGYvI7U1nLcTI9nFsaPw8ghK5aaYn84l5f/2TGkDwluj0hKf3qYlHJunXXM9Z
 wIvg==
X-Forwarded-Encrypted: i=1;
 AL+hErGCOLpUGUV/Ml9UGLDnahHGuii6SBRh2I2NwXr5Osu15QMP/ehUXFV+oNsgWhGv2eoIDHUZ8Zk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lYNQwqIw4G9ystHaJkerfEz4QULMI3usZ8dPaYckpi87BxY3S
 lCmOkd9ucNhOVlawqajvSOrWSe/qhUuY956/EZUhjEvya/oE7SnR1aHrYfPr1hD8Bkw=
X-Gm-Gg: AZFdTZdBZGWSLBpSMvgG36eyT6qswxteNz7oovEt2LgLT9shVl8x7AYCA5oedNjwjpQ
 zl55VWO7sQ1Z8NtWz2yJlxGnehYl3Qfnvc2duDXbu9GdClkyp1m/BEH+Cs6+WiM8HjbMHXSNdIO
 6ARZ3pET6MD874Xi9+JuTgjPB6b/BOXnjucPWzNNjTuf8saoUqCtqtfpn0QrLHIUQdqwhj/yzZK
 6hu6v36RVamh8SunEVwGiLWPrB7DxOdzJ7luKoST4ELqagJ/2n8/cXxsHGvpa+bRTBYz5ktYM/u
 XYYIapGKgY3YU2H2kux7OgBQtV4QQ26gYfbGR/neJYV+sBPMIgWrVh81SnNTtEZOmB2zO34GtAH
 pGN3W2PRPr0+toPzBS8zefr1PU5GwdjkVkv2X8QmFd7AUMbZ//levLkOkPIyKYggpTk2C+T+Uzl
 cn2YhOnOYYY1M/ialDvwQR4OvK6WXa7AZsZxMwPgpd1mCRA6OVbrM0WJVxMzuEGWv3/JC6cWyTK
 +bUm4NHpIKeewqAi2T3aqL77FI7nckjaYLg0sIE2TgYepoFM2V+RUwh9gurmo/t/D4EDKPy+c3F
 9TkErCjCMessDhxOgqeI4u6oRHfaWEQDlw7BsxGB9vwzTbUS21qAEVFwuKjPtxysmC/4R+8bdE6
 FrefG73EauInqh9q6KZSWOVPaG9yS
X-Received: by 2002:a05:600c:a088:b0:4bb:6473:cde9 with SMTP id
 5b1f17b1804b1-4bb8880f2d8mr435308115e9.6.1795790335308; 
 Fri, 27 Nov 2026 06:38:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:ee3:3401:5259:fcca:6bd9:26b1?
 ([2a0a:ef40:ee3:3401:5259:fcca:6bd9:26b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a1e8bsm575362065e9.9.2026.11.27.06.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 06:38:54 -0800 (PST)
Message-ID: <c1e5a206-bcfe-4751-9f46-0c15b4afab06@linaro.org>
Date: Fri, 27 Nov 2026 14:38:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Azure: Move Qualcomm boards out of aarch64 catch all
 builds
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261125204733.2995467-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261125204733.2995467-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/2026 20:47, Tom Rini wrote:
> The aarch64 catch all build is currently failing, due to running out of
> disk space. Also currently we build kirkwood platforms in two jobs. Take
> kirkwood out of one of them and replace it with qcom, and exclude qcom
> from the aarch64 catch all build.
> 
> Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   .azure-pipelines.yml | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index fcf7aafade6e..ff6392439da2 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -10,7 +10,7 @@ variables:
>     container_option: -u 0
>     work_dir: /u
>     # We define all of these as variables so we can easily reference them twice
> -  am33xx_kirkwood: "am33xx kirkwood"
> +  am33xx_qcom: "am33xx qcom"
>     amd: "amd xilinx zynq"
>     amlogic_bcm: "amlogic bcm -x mips"
>     atmel: "atmel"
> @@ -38,7 +38,7 @@ variables:
>     sun8i: "sun8i"
>     sunxi_rest: "sunxi -x sun4i,sun5i,sun6i,sun7i,sun8i"
>     arm_catch_all: "arm -x aarch64,am33xx,atmel,bcm,ls,lx,imx,k3,kirkwood,mvebu,mx,omap,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,vf610,xilinx,zynq"
> -  aarch64_catch_all: "aarch64 -x amd,amlogic,bcm,engicam,imx,k3,ls,lx,mediatek,mvebu,renesas,rk,samsung,socfpga,stm32,sunxi,tegra,xilinx,zynq"
> +  aarch64_catch_all: "aarch64 -x amd,amlogic,bcm,engicam,imx,k3,ls,lx,mediatek,mvebu,renesas,qcom,rk,samsung,socfpga,stm32,sunxi,tegra,xilinx,zynq"
>   
>   stages:
>   - stage: testsuites
> @@ -204,7 +204,7 @@ stages:
>             # First get the total number of boards
>             total=$(tools/buildman/buildman ${BMANARGS} | grep "Total boards to build for each commit" | cut -d ' ' -f 8)
>             # Now build up the list of what each job built.
> -          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_kirkwood) | grep '^   ')"
> +          built="$(tools/buildman/buildman ${BMANARGS} $(am33xx_qcom) | grep '^   ')"
>             built="$built $(tools/buildman/buildman ${BMANARGS} $(amd) | grep '^   ')"
>             built="$built $(tools/buildman/buildman ${BMANARGS} $(amlogic_bcm) | grep '^   ')"
>             built="$built $(tools/buildman/buildman ${BMANARGS} $(atmel) | grep '^   ')"
> @@ -640,8 +640,8 @@ stages:
>         # We split the world up in to 10 jobs as we can have at most 10
>         # parallel jobs going on the free tier of Azure.
>         matrix:
> -        am33xx_kirkwood:
> -          BUILDMAN: $(am33xx_kirkwood)
> +        am33xx_qcom:
> +          BUILDMAN: $(am33xx_qcom)
>           amd:
>             BUILDMAN: $(amd)
>           amlogic_bcm:

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
