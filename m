Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A50E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEB9A802EF;
	Wed, 18 Dec 2024 11:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sJPg+O1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFAA48031F; Wed, 18 Dec 2024 11:29:54 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706258027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so3533994f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 02:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734517792; x=1735122592; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c2ABOGNfUNPFTN3+UeY2qZ7pW9zV9XnSXYpEo8qhXnI=;
 b=sJPg+O1iqODlEYzqKAi4j8wcBwUNPfFqSi4U1cUfAti5KVmlzPvFwUsoiVK0CKu1RJ
 Cj4czCA9jrvJKTjamXLh/GGbB4zAKBMXvSnTOeGzQxUYooa2ZKSgwk1tCtA2SNAJjoz9
 p+4CsGAjDITe0/2W635IOvKJUhYSx2B2JZEzMbB9K1cyAHmqfsZ3J42G189DYYwZCdvq
 somjv048mtK+5pytmgefZF1M2+YncLSfxTJsegGT9JCyeJvnCwdPuHBSwXLsl6gRKvz6
 UNCQhLqWQAi3zoh+c+Y0V5G96ScRQo004y6wuFfw+s4m9gK9YR3tHVTMD3kJCcx98/TL
 gXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734517792; x=1735122592;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c2ABOGNfUNPFTN3+UeY2qZ7pW9zV9XnSXYpEo8qhXnI=;
 b=pq22InzT2i+6hM3ImhUK+M0vgnKiKVDrtp8mLakHTytciMJWuwzM4dM6as8NDu47V+
 uGMbj3jJ7ZGf3DrmOcK/yqIlKE3g/hksmdEuuHom7yKpo/+yiI/N/9QhEH5Sy+JroBSy
 q2vK7Ksve9cMbs/HRWS5ETmL4h1IQhR/f0Eq3f8EXREx9FaRu3q2eWym3mYX6fShnoDJ
 GYPP9liKTyAv5tsOk5UxBLACZGbKENZoD/p1YMYYwYXQkKfpPib6ijzvJYEQdDHnDKxm
 0L8OXnbnSB1v7IR1i1aIMpj6K13NkeLb0GUnywDIQIVx3OI6n/rxttjobQhu4nV7OUik
 /Q2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1TitCymx6WWitegxE53H7CL+vVBapPLbQbwtD8SDOzLvYOggzI9qWGnHbh+VYX7/ZWBf5nvs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj3wnNHHEs/pdVfzpNlNRlheGThtD4glIvveHO4ftaMR4XwAvl
 UQHg4Soezhoe1AxEIk9GPBKfTIR1uk2UmQJoKp0gjLFaXCc6269mWC6WXSW4ZWo=
X-Gm-Gg: ASbGncs7AlZDkqufUWdWH7RrlKySIi7qmNYvD4NvV86MKhc8upytKrUv1mXl7vStnW+
 4lY6KZ27PAB2Yp0xWJYN1FmhdJ6pwgWhS9iPF7Tns9D3re4bRwQyndBNNRAB30ikZYCT4qt5FVS
 Pe8Uh8HovjtAbqUZZpWLK2Y4MpG/9BNC/eQQX6HDwe8lTEABs5+avSsCCWM/vdvh50XHjdA6lUC
 n8lzA0o/66D5oxKBnCNd8Bdp9nOa2ow8LEqILZ71vb+UxITbItQmaCuTA/x3BEFRz6kX84PGhr9
 hhoLlusGIwOrSvGtZYDMm6FTWfkQ05mf2SXM
X-Google-Smtp-Source: AGHT+IHeDn0QjrpZmj4I83qBN2/T9k+1edT0lR1yUgP81NiueFD9SmX+skzxWJvT2zfGNyTge3THBg==
X-Received: by 2002:a05:6000:2c3:b0:385:e30a:394b with SMTP id
 ffacd0b85a97d-388e4d83283mr1840214f8f.16.1734517791897; 
 Wed, 18 Dec 2024 02:29:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9?
 ([2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806055bsm13465172f8f.92.2024.12.18.02.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:29:51 -0800 (PST)
Message-ID: <494b484c-8102-4594-98dd-68751c7d18f9@linaro.org>
Date: Wed, 18 Dec 2024 11:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] doc: man-page for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241218041914.1463666-1-venkatesh.abbarapu@amd.com>
 <20241218041914.1463666-3-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241218041914.1463666-3-venkatesh.abbarapu@amd.com>
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



On 12/18/24 05:19, Venkatesh Yadav Abbarapu wrote:
> Provide a man-page for the optee command.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  doc/usage/cmd/optee.rst | 70 +++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst     |  1 +
>  2 files changed, 71 insertions(+)
>  create mode 100644 doc/usage/cmd/optee.rst
> 
> diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
> new file mode 100644
> index 00000000000..532d488d5e3
> --- /dev/null
> +++ b/doc/usage/cmd/optee.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
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
> +This is an OP-TEE sanity test which invokes the "Hello World"
> +Trusted Application (TA). The TA does two things:
> +- It prints debug and information messages to the secure console (if logging is enabled)
> +- It increments the integer value passed as a parameter and returns it """

Drop the """

> +
> +
> +value
> +	Integer value that the TA is expected to increment and return.
> +	The default value is 0.
> +
> +To enable the OP-TEE Hello World example please refer
> +https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
> +
> +Examples
> +--------
> +
> +::
> +
> +	==> optee hello
> +	D/TA:  TA_CreateEntryPoint:39 has been called
> +	I/TA: Hello World!
> +	Value before: 0x0
> +	Calling TA
> +	D/TA:  inc_value:105 has been called
> +	I/TA: Got value: 0 from NW
> +	I/TA: Increase value to: 1
> +	Value after: 0x1
> +	I/TA: Goodbye!
> +	D/TA:  TA_DestroyEntryPoint:50 has been called
> +
> +	==> optee hello 74
> +	D/TA:  TA_CreateEntryPoint:39 has been called
> +	I/TA: Hello World!
> +	Value before: 0x74
> +	Calling TA
> +	D/TA:  inc_value:105 has been called
> +	I/TA: Got value: 116 from NW
> +	I/TA: Increase value to: 117
> +	Value after: 0x75
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

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
