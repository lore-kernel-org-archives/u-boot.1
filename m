Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F77EC9EC90
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE10B838A5;
	Mon, 12 Jan 2026 14:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I43YX2l6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4FE83AAE; Mon, 12 Jan 2026 14:29:18 +0100 (CET)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE908388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so930516666b.1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224556; x=1768829356; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P7OrG6zaSrxjlbMURCnG13UAzHznxRBjgPuq1OW+lD0=;
 b=I43YX2l6VL7HWKDJI1Z2XnDLCDCMiy3w58HVwyozF4FBZ/GgNAFQkD4R9G46NWr4p+
 GToxr5WhvNfhEW+3/rdGWfMdl9EZj32I06xong/7Kq6sE+Du1saDQ1n+/Ekoo2UaWq7S
 BZFBn5ZzzbqLr4w0MOAjcW42Ysu6nkpdGH631ClE3piMBorI0bJ9uEXsNWIbVaCty2nQ
 6GnLp+5eLUJ/3MCtnwiwVGtCvmlCrCZAmTsgUqP9PWRsiYM3EPKYMiazmSSsyrsk+jxR
 PnL+SHt/BMuEIMIapXgh/0KM7/YslfPbsSlMvF+olmXlkJeZKHDdPYopuxQJp7881s/I
 1fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224556; x=1768829356;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P7OrG6zaSrxjlbMURCnG13UAzHznxRBjgPuq1OW+lD0=;
 b=Ie7uPOw9fUGbA1xCvJN4H3OpT6w9PCzWoJYzSXwu3BX4Mv/bU9Cv5PK3O8fhShKUOO
 YpJmormYvF7wsiIVTzJo/1QV/ZFTOM5j8wfH5/xHo4ziC3Sh5tQa3081IrrymyuNd4bx
 DaLJOkcQTIVhbWT2oeJCUjWHJUnHe1lSzaTtCdSc9W4NKrZ2/Bre7EZbGC4k3hhAvjt8
 n7cEOsC+hLeAKAKIWR58nyPJ2QrpC+hP8XJz7XUFiEakAfNbLSh6xbPCkJ9pmMVwi17W
 ssAluXsd4J90VmbU1E+a/swj/B2iKTmMeY2fjIovez6g6OslQUvcxnGManjUVR7PGK/B
 w3jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVxxkdacq+CfqeAMO+3mY8717A+U6sM6R6JFrxsFY4F1YEtktrnDMGKDfZtbnvcqQi0o1mEGA=@lists.denx.de
X-Gm-Message-State: AOJu0YxxOCGXVr1B5FvvUUBsrYhLgN1kni7RY9tAgHHhYlbVzA/NJqIX
 DTNYreZ1AsE6uJnnn4QwSypl2Az/USICtZiMN/PPeoMgD+C4LroNh/QKhTQCfPLYxxw=
X-Gm-Gg: AY/fxX5lu6ycMhnEKhuJCDtborFZGkJ7aRAtStkR/yT8tpSsDSTDlaTptFVEf4Q5zWr
 q+nq96enqooJTIawD8V1ic49GWL6mMapkY+CIYxkyhlgIQ8r6woLINkFuiKjJWyLjiwaomOnosM
 n6B3kF6pCxtRL9dH53kubopEf2AucIrVniINBO1Jq70/JG6LOvDpFQvU08p6PT2M2XD9bcLyL3N
 /aa9UuMOVBz3sPpFqQ2uCNbYqGl2FMmF97P/XIbIWiJnAdE4u6B5udoIM+957Roq4yNLHIaK0Vp
 l1J0PnuMjGh9EcK8l18pqBdf1ohR/QrTkRfv/p2uE3Fq+SiL35bJhQRf4iFnD4etyoSdrmau2Du
 bCNKEAQ7XTXpeCuBnGFXf4pHXVSXd+/DX3ciQkdE7J4TlTAOIVR/vp9tQwDKuR4naPtbCXJ4sxN
 SleTqZmecQALz+BRCpwQhovKIyVsTs8LOmF0NdJLzbPgzjzgRL0ww4zdAhB5LfvA==
X-Google-Smtp-Source: AGHT+IHVK8bQmj3PB0Q14Ewr7Rd3/ZKRvUGdoXUDmB7ZNYdmf6ioL1QjQgCwMqEoNIIw3TCToTCMLg==
X-Received: by 2002:a17:907:807:b0:b80:3fc4:37bd with SMTP id
 a640c23a62f3a-b844503088bmr1648294566b.7.1768224556039; 
 Mon, 12 Jan 2026 05:29:16 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b872b027020sm125275266b.10.2026.01.12.05.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:29:15 -0800 (PST)
Message-ID: <abe66212-c251-4e11-9c12-3b2fc412c29f@linaro.org>
Date: Mon, 12 Jan 2026 14:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] cmd: boot: Add '-edl' option to reset command
 documentation
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-5-quic_varada@quicinc.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613051957.3159564-5-quic_varada@quicinc.com>
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



On 13/06/2025 07:19, Varadarajan Narayanan wrote:
> Add help text about '-edl' option to reset command definition and
> related documentation.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  cmd/boot.c              | 3 +++
>  doc/usage/cmd/reset.rst | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/cmd/boot.c b/cmd/boot.c
> index 23496cafdf5..d80f9d8c05d 100644
> --- a/cmd/boot.c
> +++ b/cmd/boot.c
> @@ -60,6 +60,9 @@ U_BOOT_CMD(
>  	reset, 2, 0,	do_reset,
>  	"Perform RESET of the CPU",
>  	"- cold boot without level specifier\n"
> +#ifdef CONFIG_SYSRESET_QCOM_PSCI
> +	"reset -edl - Boot to Emergency DownLoad mode\n"
> +#endif
>  	"reset -w - warm reset if implemented"
>  );
>  
> diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
> index 126db21cdb8..4237f764175 100644
> --- a/doc/usage/cmd/reset.rst
> +++ b/doc/usage/cmd/reset.rst
> @@ -22,6 +22,8 @@ DDR and peripherals, on some boards also resets external PMIC.
>  -w
>      Do warm WARM, reset CPU but keep peripheral/DDR/PMIC active.
>  
> +-edl
> +    Boot to Emergency DownLoad mode on supported Qualcomm platforms.
>  
>  Return value
>  ------------

-- 
// Casey (she/her)

