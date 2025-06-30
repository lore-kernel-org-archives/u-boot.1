Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B464AC83029
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 15:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2149B809A5;
	Mon, 30 Jun 2025 17:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RDGNmMGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C8E80B9B; Mon, 30 Jun 2025 17:50:08 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17E9800C1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 17:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso4940326f8f.3
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751298603; x=1751903403; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1pfjFA500DDtbyXPaUYd0ErlDCZ0Wc4pLlCaAu/RWlk=;
 b=RDGNmMGPEE53/Y4Hng4BeNSqGw58BfmSzSjVpnT7aFpqacHrhaMzVjuyMWSLqMQ+/a
 bdtHweVRbE5GvZ3ZcKBh7dMZBdD6TAGP3wyM0yMNIl9+A1IaReJGplYUPTLfJiTJFsb3
 ZKMxnAC5acgmU4oxXI9MJ4tTcIlSF7OBCaeT50/0JCt3oJ/2GT/8XLSsPvx3C1LPGjY3
 ua4cct8jQDJ2uiNZSDyoh6PVlOZlgAvSs3X+mZ6vqon0mRPYr1dp3rXlxGsWD86eJZ9r
 xLP/VqAgtsAKZnNYFO2MzGf2k+/EyaoXGv1K9yxasgUWNVhVg0ehZb4H8jCblu4QebLJ
 6anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751298603; x=1751903403;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pfjFA500DDtbyXPaUYd0ErlDCZ0Wc4pLlCaAu/RWlk=;
 b=F7HAAKHJJYFINL68xfHR8LBYpQZFpANWdb8vsOGa1qnfPl7fAZsHfWA1WHjPaZlGxo
 J9aJW/bdIGnsTxGlBUplJ1EI1+2+I4JsB1n7cR51NDCGIfts72s/RSrnn9oFXt91Okj6
 bYew75Adg3woOZMLeBJCNdJbldpj74cE9mbVN2dNNxm3LnProC03hnB5i1kIVVY0n4vd
 JylWduTqVyauT9u2+ewTERs23GV7wVrOklQlX3Q0rDmbswDhLYqXdaw0DniRFLStzuDv
 ehjKom4H0ZouOU8A8GKS7Etyf1r/FkOHxyhfeDQPvXeC4s4QSlO/pobhABJ1urgQD1C8
 C6UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrvh5sXQWTOpUBXZzWGsp7ANndklLqJNeRBI/hbolBOz/ru1v6kiG9pTUlIxOJzG+kt4WCLSY=@lists.denx.de
X-Gm-Message-State: AOJu0YxLZr0DLAB/O4Sg44Qe9fi8brL27Rt4NtZrpk4rco4L+KL04Fls
 4qaIWE9qz+pCUBE9Hg9t1PkI4lWDpzlAiLsyAY3WGuMCz3GK4th+c+pDWRLkU+odz14=
X-Gm-Gg: ASbGnculwFkyiF6PnbZoPVfsxDmiRgHAKXXp9OxVc/s42eDCvc+9z1JQp26VWc7tb42
 bjO9eOiFKt7dBFAW7s8t1S+VcnKDy+9eedezgR74zRQd1wVsAlHsW6NzG4m6TsnWL3fhzHaZ3A9
 Zi8frsbxMTPLt4iIgBmAve8ntukDHgFrc5S+r+Bj9yBAMufq0855dV330W1KkIrGhqFec3Rpt6l
 EA6KJWMQ3usyj2XqvGbX+PQrx/f36vm8JCFKAChGhiI/8TPSQsZ5Y7by9bkmzAll7+6M3dFAq0G
 EpgqukhyXFhdSbQQwzweE1yX8dtSOIs4McYjKMM/mmx7tNmuzu3FAhFT4AbuKE9vmAfE2JFkxrl
 ZtSzBDwkefbvHABtsI6dbS59hMNvb7EBDjWgGMA==
X-Google-Smtp-Source: AGHT+IGS9PWGGDRh9eMiR40jRGhxPZF4XS7R/n219MbN0IVzYKzlVM6blzBgCfXWH9mWf2wo3rawdg==
X-Received: by 2002:a05:6000:400b:b0:3a5:5270:c38f with SMTP id
 ffacd0b85a97d-3a8ff8f52c3mr11449608f8f.0.1751298603281; 
 Mon, 30 Jun 2025 08:50:03 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d10e.dip0.t-ipconnect.de. [79.195.209.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52addsm10639901f8f.47.2025.06.30.08.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:50:02 -0700 (PDT)
Message-ID: <401766e2-baf1-41fd-b0bf-672937776b35@linaro.org>
Date: Mon, 30 Jun 2025 17:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] configs: Rename qcs9100_defconfig to
 qcom_qcs9100_defconfig
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 quic_varada@quicinc.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250630070040.734486-1-balaji.selvanathan@oss.qualcomm.com>
 <20250630070040.734486-2-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250630070040.734486-2-balaji.selvanathan@oss.qualcomm.com>
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



On 30/06/2025 09:00, Balaji Selvanathan wrote:
> To align with the naming convention used for Qualcomm platforms in
> U-Boot, renamed the defconfig file from qcs9100_defconfig to
> qcom_qcs9100_defconfig.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks!> ---
>  configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename configs/{qcs9100_defconfig => qcom_qcs9100_defconfig} (100%)
> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> similarity index 100%
> rename from configs/qcs9100_defconfig
> rename to configs/qcom_qcs9100_defconfig

-- 
// Casey (she/her)

