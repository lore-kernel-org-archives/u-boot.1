Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02D9C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051F582A2F;
	Fri,  9 May 2025 14:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TDhIZtzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244868210D; Fri,  9 May 2025 13:07:25 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326EF8059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 13:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso10873525e9.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746788842; x=1747393642; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a4E7z7RqEjApXkEVi7L6N1dbylK9nRPdmX8P5C/08BI=;
 b=TDhIZtzVS1dfoVAOQz+lZW+6mLiMzpJKU91GzDUR6eBjL2b/FbweycVljbpXlz5gOp
 fYea905BZZzStSUolcmRy0A3TV5PRA032RYd/q1GQTwrBR1K4BHkP8au32jxb+gbO0Jd
 FAeT3C+L7R/4otswtTpAGYHHV296WjP4P32xoMaT0qA0ozleCTrMVfOvNZupdM/NA+o/
 2J+sYWil/SdCNK5zWxqYe955USa0ie/t2jsusvzKaO80rd6aqBBjZdB8N8XofNl1/XW3
 aZET71yv5WDAWwLNI/dRxgZrLFvee1seFbrr+vG3gyoN0n4nIVh046DOWTQnIakQ+Wmz
 zO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746788842; x=1747393642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4E7z7RqEjApXkEVi7L6N1dbylK9nRPdmX8P5C/08BI=;
 b=k2HaW0n955K6qRAWzes2k+v0KnicgWH1iAnHrqyHtY1eo/ydzlqJY8t/RY4E/qS3mc
 SQhZIHKWTsnVbXWoNpg8aN8YLGjswfgqDGcAElfr8vvoG9LFC40CUStbr5nKWNiywnjp
 5NwYRo4Wf34+W7zujIAoGaD0pDS4oJLdF88k8xZjiNHk0olV+yikjjegwok+9+FPn5dM
 gvHoZ4xkpu3I4YtvUCp0HJrtKAb1zEvphpNXB6DCgB9Lh4XXRYbQjdhyMiECDl6YDSc3
 FQj5/qptKLHw8YunNWV4vyYo0Wn5DyFV8g81Y/Ev3TOKDPc7Sqpeu32Ztsk7cuNtpDSR
 w4RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5zb/jprGsAIPWpf982+k4PjnNTrbLHqFlcNJdY1FrkChN+2e4xO/2nlM+pMVb8r1BzlH9TO4=@lists.denx.de
X-Gm-Message-State: AOJu0YxX2iclNyemhMvOUsX07TD1e0Pwliy0QjaPbmGOq45p09qx1B3m
 l21RBk18QvXSxyvQpMRBPacQHCshl189FjzDPwchStjbp9ExfupZ/P6SvSN28Kg=
X-Gm-Gg: ASbGnct0mdlGaZNLOh77Uy1uI32aTsYaXhVBWIdsYf4skHme6MK2kcLKMWDUmP4bGAt
 CqHYU+xqUhp5ugk+fUD9HDvhE+odSHXOHhw7f0WDRIkjup49Cf7V9gSNUdbDtn2bOTHGe8ChZbP
 WGG6GFFtuEKmPhMduHX5I1rDNBYPtli5Q2NyAit+LkaFapq2XcLhNtOOWPO+mjRmDM4K7TCpQsd
 uSswzYmVIyM+Zhkam+W1BSOBvxq71jTE5DGh7l/eMdbTQCbR/WSCINmLUfNAJcteK74loKc515t
 40fy/94aMC1oQo5IbDAtEh+pw2+Qr07zNAbRSp1+AWwzGT+fQM0jQK5SR93CRur+TJ3reyhZ9Q6
 p1JOve0qzcDpq7w==
X-Google-Smtp-Source: AGHT+IEqHXklJ2BDGFm2YuKpManic6uoIS1PBG+6Y+859PVFRYTU6dpxC8fLde3qt55P9rGEonsE2g==
X-Received: by 2002:a05:600c:3d14:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-442d6dd21demr21335825e9.23.1746788842609; 
 Fri, 09 May 2025 04:07:22 -0700 (PDT)
Received: from [172.18.195.54] (ip-185-104-138-77.ptr.icomera.net.
 [185.104.138.77]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67efd26sm25935475e9.23.2025.05.09.04.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 04:07:20 -0700 (PDT)
Message-ID: <2dd78ea0-3b3b-4dbf-a89d-ec8d2267a959@linaro.org>
Date: Fri, 9 May 2025 13:07:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250508111952.2304578-1-balaji.selvanathan@oss.qualcomm.com>
 <20250508111952.2304578-5-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250508111952.2304578-5-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 09 May 2025 14:39:39 +0200
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



On 5/8/25 13:19, Balaji Selvanathan wrote:
> Enable QMP phy for QCS8300, referenced from Linux.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 449b9767778..18cc665647f 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1469,6 +1469,7 @@ static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
> +	{ .compatible = "qcom,qcs8300-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
>   	{ .compatible = "qcom,sc7280-qmp-ufs-phy", .data = (ulong)&sc7280_ufsphy_cfg, },

-- 
Casey (she/they)

