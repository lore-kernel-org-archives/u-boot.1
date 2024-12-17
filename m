Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03261E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4101801CE;
	Tue, 17 Dec 2024 09:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DhYb/ynM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E25801CF; Tue, 17 Dec 2024 09:23:25 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41ACD801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3dce16a3dso9340436a12.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 00:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734423803; x=1735028603; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tbGKyjbRwmQjS1xWlwON/C3q9dn3ni6RqEqS/PvIQI=;
 b=DhYb/ynMxLsnw2gxxhL95AF+iMXQFNle7amppU6tDQPsKeXFkpidYfvd1h96UPtG6l
 HAj2AcKT6drfvo5bJzrIMBAFlZh1BLO41FWwRj98yl+Ax6r8n34Wk9jMMv8sRJJiU3l9
 hauwB3EZ3mNiI28XxEZ3bb1s+C+xdKKuqBErse/j+ImJOdzqeWYNjV5Qf9fXK8/PuPxE
 h95bS5KxnlxokN4WmqeOSKpBIq883YPU/i8LDKNrwkGJpyWrd8OvyzoxVhnuv0wPDrw+
 AUTAuEMuIkievZsOeJciW47sky4ae3hHjsuZzd4aOj6rxKSm/mjlx+hcDleVfG9uAQwM
 +JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734423803; x=1735028603;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tbGKyjbRwmQjS1xWlwON/C3q9dn3ni6RqEqS/PvIQI=;
 b=Bg/+58cAXh1yP3oOscjaoU6dOnE+jJShuV5DPBxI/VuYDyBnOAV/UBAa8KwRZqdMuN
 J9T3VPmzoXJ5sldC1LfjKLwOlGVyEaKyz79nDGGOCkS2H6CETT7tsUpolLd5ybAxkfqy
 Q+KLUOdWYNBd/K80Jlc8NddNKxrYZDs2BH56B7kAnE8+v5zWJlha7jxOoejtmVZpUEUy
 hQq6Pf7leKQrEiT6/JBNrU9kUZFx3cuhMJ2nKMYXsIXIq1f+MZwKA1Ywzokg7lKCLqaZ
 k1UsplC55YJzdZ6gDQKy24nTDnJWjxbQyezcl4eAf9HKsoCpZYecgVHtNjEPsuSEEMJW
 EoTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVRGWyftIZ5CyWih5pmrvKyE1hEHv/YxWDrXoMl+a4twwJ8pH4zAkXf78J4S8p+tO49A0ub2w=@lists.denx.de
X-Gm-Message-State: AOJu0YxBAGjKdOuhaTXms37BJkk6WHlXEeFLSujNCdP/btPSkc5Yux3s
 OGG9sHbWIzs5NSiK//aLNAFxpCpeGlRFg6goy7xnFbXPi//h6lORGXDzWUpG/Is=
X-Gm-Gg: ASbGncsGlLrPUnD2gbVi8hYu82+8ioM/ZG7EQ5ZxOmFkFCZA4JpTjtu3BAwMYto9Dix
 3aD08zmEmHoDVUmDNbDX+fF4raT0e7VhMBNVx3NrTH/Bx7gm1JBOSzK2/wYBu2xHAww9ciI8nxD
 sk6xKgFRpmeFcSN5RX+nH/0Ea2JKMD6KJmLr//Sf0GQaYC6QbZqw3j3YCDYD6UKzlu2uJmoNrFL
 jLI1D1690cM/AG36E42Zv6YijDYR6mr5PJD7+/pQZKtmLhws4HtdFPYwMGQLme6Uh/3
X-Google-Smtp-Source: AGHT+IEAPDjYeZV14u9HWnt2RTu+burQ8c3PxOJTlgtI1j3kwaA9eOATU24dFlJVX8rF8kmIlUkWXA==
X-Received: by 2002:a05:6402:518e:b0:5cf:ba23:3e44 with SMTP id
 4fb4d7f45d1cf-5d7d55719f9mr1984469a12.7.1734423802433; 
 Tue, 17 Dec 2024 00:23:22 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.158])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d6529e6a06sm4026346a12.0.2024.12.17.00.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 00:23:21 -0800 (PST)
Message-ID: <3c667acf-17fb-40ed-b954-9cce1e6bc5a4@linaro.org>
Date: Tue, 17 Dec 2024 09:23:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] doc: man-page for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241217035914.1297469-1-venkatesh.abbarapu@amd.com>
 <20241217035914.1297469-3-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241217035914.1297469-3-venkatesh.abbarapu@amd.com>
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

Hi Venkatesh,

Some suggestions below.

On 12/17/24 04:59, Venkatesh Yadav Abbarapu wrote:
> Provide a man-page for the optee command.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  doc/usage/cmd/optee.rst | 66 +++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst     |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 doc/usage/cmd/optee.rst
> 
> diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
> new file mode 100644
> index 00000000000..53e36853742
> --- /dev/null
> +++ b/doc/usage/cmd/optee.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +.. index::
> +   single: optee (command)
> +
> +optee command
> +=============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    optee hello
> +    optee hello <value>
> +
> +Description
> +-----------
> +
> +This is a very simple optee hello command which is going to
> +increment an integer value.

While this description may be good enough, I believe it would be
better to say more about the real purpose. This is a test command.

"""
This is an OP-TEE sanity test which invokes the "Hello World"
Trusted Application (TA). The TA does two things:
- It prints debug and information messages to the secure
console (if logging is enabled)
- It increments the integer value passed as a parameter and
returns it
"""

> +
> +value
> +	value to be passed which is going to increment

Integer value that the TA is expected to increment and return.
The default value is 0.

> +
> +To enable the OP-TEE OS side HELLO WORLD example please refer

To enable the OP-TEE Hello World example please refer to

> +https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
> +
> +Examples
> +--------
> +
> +::
> +
> +	==> optee hello
> +	The Hello World TA is going to be called
> +	D/TA:  TA_CreateEntryPoint:39 has been called
> +	I/TA: Hello World!
> +	TA value: 0x0
> +	D/TA:  inc_value:105 has been called
> +	I/TA: Got value: 0 from NW
> +	I/TA: Increase value to: 1
> +	TA value: 0x1
> +	I/TA: Goodbye!
> +	D/TA:  TA_DestroyEntryPoint:50 has been called

This output doesn't match with the code in 1/2

 +       printf("value: 0x%x TA value: 0x%x\n", value, (int)param[0].u.value.a);

> +
> +	===> optee hello 74
> +	The Hello World TA is going to be called
> +	D/TA:  TA_CreateEntryPoint:39 has been called
> +	I/TA: Hello World!
> +	TA value: 0x74
> +	D/TA:  inc_value:105 has been called
> +	I/TA: Got value: 116 from NW
> +	I/TA: Increase value to: 117
> +	TA value: 0x75
> +	I/TA: Goodbye!
> +	D/TA:  TA_DestroyEntryPoint:50 has been called
> +
> +Configuration
> +-------------
> +
> +The optee command is enabled by CONFIG_OPTEE=y and CONFIG_CMD_OPTEE=y.
> +
> +Return value
> +------------
> +
> +The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index cb7a23f1170..4dd00f002cd 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -92,6 +92,7 @@ Shell commands
>     cmd/msr
>     cmd/mtest
>     cmd/mtrr
> +   cmd/optee
>     cmd/panic
>     cmd/part
>     cmd/pause


Thanks,
-- 
Jerome
