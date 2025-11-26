Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ABDD10F57
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA68C84239;
	Wed, 26 Nov 2025 15:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="elJWKCv0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507D68423F; Wed, 26 Nov 2025 15:30:51 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4466C84214
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so608562f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764167448; x=1764772248; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vibX9gdqLJS8CiMjl3+VzDoeCZtluiKkFJtTviEUgq4=;
 b=elJWKCv0VI6pZn80BpdxH8ZIpeiQ0x5dqogElDHE1mvKtyD8LXTy+b077S2uEwB279
 ZT183uf2Tcji+0WTRKhmPf2iGE+2WOL4xRWIvIxCmaPwfiocFXUn+IcEuU+btNP/vhVP
 9bangmtAwk07BVqaoQtL5vWOHCFuCvDaXblcAHfxil0Rfg4e44a8Vhfs0/7t47wRUSVx
 9/4STPQ6NP4IIsP1QINrIZk44WU5zn4751K4QbN5GEnQpi0caXyZG1E7Fhy/BK0ef9QN
 r/OgdbaYubBcqQJ1MXn6N82c7tv50jjt74z6Zu+lkn/T2XlAgrPkqYtsQpbIIGNQHoBf
 4R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764167448; x=1764772248;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vibX9gdqLJS8CiMjl3+VzDoeCZtluiKkFJtTviEUgq4=;
 b=VqXEAKJNXWJNzW0vHlx8HGX0rYDwrOxdgJ55Xc/pKG/00KitqO3ctwUoOaRDq3MruS
 aUgsACynt5MT1myQgprxlO+Kbx/lc/4jc+AAxufRxiVTzadep0ZEj2373yEr310jibim
 VHJLXKSFLamjTLBD19iWwZ5i6myo5R4sfRcESoB5GiXX5QR1pB8sehkT1qulGnLKAneX
 FBmxci8N+wb5RLE4ULQAK7WXltkWTGZQkXnX12JgJnmbl01Gor0QXxBozcbkUg1GA1n3
 2cu0uGpeZ73m4aH65zSe/0w29ddLN1Pp6HLrTyT8KvDMv9BbcC+EjWwstgkTyG1aoTKq
 9hTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOVSyYtCb578bz8/7+mlJ+nIzA8RbYZ0Sx+VPIgqq236+dAnbRJPsUzXvhBKKlOwTMec4svR0=@lists.denx.de
X-Gm-Message-State: AOJu0YypWjjWzgnuxBVYJzUuTwVIHfDtgi6JpQdLSDNM+KtVmtdPSCHX
 oqc/tIONNCV3BG0pES8RReSNgrQiv2eBO9Wa3HaS4vkVH49T1n9P2nZOJTYKTONjQeE=
X-Gm-Gg: ASbGncvHnajnqfoPuDHBd6L3Y26gMcdKEi3KEEhGwbQB4bWIbBNld+Q6zr/jSshp9tV
 QZX9oRRJPYkYKdhzOcP2hzxJqGPlqvA72reeo4dmBAwnu8eoE6eNwlEuCI9z5llHtAPGFCeSGmH
 X57DOa/GUvQ/IbsYJ4bj/bm6XBOy0yfJst/4Y4hnq76hGs5iBb5UKEckMDlNoRle4zDAAB96w8o
 eXoEXpSB6QbtVUpITr9dhMm5ggPzp6sWQH9vMRIEbsf5LHw/Vtu5JWezSkmaUdRYy/YsOFo4EsU
 +wc19h9hlHexTNIJps1BtlbN4+bIAJFVi8uSwCWURrv3+B8jXNsxeCi5DRJBv3Dt0w/GPW6TSul
 sxY9N/TQmlLhNjqZQM1DrtOCJOqQSmz7hV/T+DXfdDRuxC+uIc2+K4wvvk5SRQ1mICs2xlbqszK
 kywne1TfW10McXF20AlR1CLv2gKLwWIXPoS8UYeeuINDNGmIJtHziS
X-Google-Smtp-Source: AGHT+IHOKbkFaZsZIWCVLBolEE63ERYEVMsqHxAVVJ/A6FXs6SqEnaZkLUUt5rf5KP9MyT0cMQ2f8w==
X-Received: by 2002:a5d:584f:0:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-42cba652ec0mr27418000f8f.9.1764167447826; 
 Wed, 26 Nov 2025 06:30:47 -0800 (PST)
Received: from [192.168.1.36] (p549d4195.dip0.t-ipconnect.de. [84.157.65.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8e54sm42137622f8f.40.2025.11.26.06.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 06:30:47 -0800 (PST)
Message-ID: <174f3c4b-40fd-43cd-813a-b0d815c32db0@linaro.org>
Date: Wed, 26 Nov 2025 15:30:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drivers: clk: qcom: sc7280: Add USB3 PHY pipe clock
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-2-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251124155503.2839766-2-balaji.selvanathan@oss.qualcomm.com>
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



On 24/11/2025 16:54, Balaji Selvanathan wrote:
> Add support for GCC_USB3_PRIM_PHY_PIPE_CLK which is required by
> the USB3 PHY on SC7280/QCM6490 platforms.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>  drivers/clk/qcom/clock-sc7280.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 55a233df394..a2af73cd976 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -111,6 +111,7 @@ static const struct gate_clk sc7280_clks[] = {
>  	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
>  	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf05c, 1),
>  	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
>  	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
>  	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),

-- 
// Casey (she/her)

