Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C087D44161
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD414895B1;
	Tue, 19 Nov 2024 15:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jxqMCwYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8500895AE; Tue, 19 Nov 2024 15:10:17 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97445895A4
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso28417705e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732025415; x=1732630215; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxEhnDXuAC+viemPHYojiSRcjlMQbhzzMXkfpYDOw1s=;
 b=jxqMCwYiVQqLAkPmO8hgokckt8hxBxueg33cD2fC9GPX5q9lRd/gaJseZinEQvehzJ
 ZHydezSC8WhpaLkiK3gN1qE++ULNriX3ep0Ecz4z7MDEJwr1yWS9+vUebiAF0EMKEHZ7
 bhIYyxRtoShR9hZC7cKSXwb0tu05jFnDpcbbBG9Wc+PcusRAWl6CjPG+n3WtXxVKys4e
 vvz4Q6PRlIoi1LJhhohS8rQAr2tGEnXeI1UdxO2DDkWXi61IfT+naZ9EtYL18yVb14LY
 PuR3msLo552c4xuysMsvRhbTV+Ly/64ppaYXdjptyzqE159F3+2eE2qonPYJOCzQimbC
 nVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732025415; x=1732630215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxEhnDXuAC+viemPHYojiSRcjlMQbhzzMXkfpYDOw1s=;
 b=MMP7LNzwRWd2gkE3WzVCU0ifSDwk5QYfrkmQo0a5+DZiMnv8k8nzymXGXncBk4tPQK
 zXGF0DO1FCCa4+i9p1XEjI59GL8fu8+L5Y3eY1MWC0BMpytdW/iPjAkg+EDCp8JfAIq0
 AIWVRduFEgpvPFvizZ74YqoBR8AQoLjlKKsP0N3CsAD9PKdbu5oJm29T3RvJEPzByA62
 xqXGGjaUB0JdrLlULGfiZ0BEyjVA/b3oL/4OYroA6Unvyaic/vljnztms7YGAsjn93Zr
 irUbCmQyoTUYyTZETAYc87b4ufb+J9Ry73ajaRlSEVZqQ7ewHhlAGQdMMspNw7Nujkfz
 FbIw==
X-Gm-Message-State: AOJu0YxD7o81xFYzx38U7wDY4DUymdv0cGNI3v9gkxaej0AcYIRkm56Z
 wSsLf5illazt/0m8lLejTxaWQjoxKgCBr78Eoq2oGpTe/W4FMWy3uB5Qkx4cwqJV6r/vXe801JV
 F6bg=
X-Google-Smtp-Source: AGHT+IEZnk7C2ktqPb4PkpPwla7jdU+gkYSm8PRDVQLrnwMEu0BrQz0AgaQ/vJ8vPZkJZOerVUcTYQ==
X-Received: by 2002:a05:600c:4712:b0:431:3a6d:b84a with SMTP id
 5b1f17b1804b1-432df71b232mr143836445e9.4.1732025414992; 
 Tue, 19 Nov 2024 06:10:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309?
 ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da265f28sm199834865e9.17.2024.11.19.06.10.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 06:10:14 -0800 (PST)
Message-ID: <bbb605fd-1ab8-4f47-a679-c39ddaeceb33@linaro.org>
Date: Tue, 19 Nov 2024 14:10:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Azure: Do not run "udelay" test on sandbox
To: u-boot@lists.denx.de
References: <20241117162606.3212279-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20241117162606.3212279-1-trini@konsulko.com>
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



On 17/11/2024 16:26, Tom Rini wrote:
> With the changes in commit 88db4fc5fec2 ("test: Update time tests to use
> unit-test asserts") we now frequently exceed the limit on the udelay
> test, leading to false failures in CI. Skip this test.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   .azure-pipelines.yml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 4ecf76eaa0b5..a51db936d83a 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -320,12 +320,14 @@ stages:
>         matrix:
>           sandbox:
>             TEST_PY_BD: "sandbox"
> +          TEST_PY_TEST_SPEC: "not udelay"
>           sandbox_asan:
>             TEST_PY_BD: "sandbox"
>             OVERRIDE: "-a ASAN"
>             TEST_PY_TEST_SPEC: "version"
>           sandbox_clang:
>             TEST_PY_BD: "sandbox"
> +          TEST_PY_TEST_SPEC: "not udelay"
>             OVERRIDE: "-O clang-17"
>           sandbox_clang_asan:
>             TEST_PY_BD: "sandbox"
> @@ -333,8 +335,10 @@ stages:
>             TEST_PY_TEST_SPEC: "version"
>           sandbox64:
>             TEST_PY_BD: "sandbox64"
> +          TEST_PY_TEST_SPEC: "not udelay"
>           sandbox64_clang:
>             TEST_PY_BD: "sandbox64"
> +          TEST_PY_TEST_SPEC: "not udelay"
>             OVERRIDE: "-O clang-17"
>           sandbox_spl:
>             TEST_PY_BD: "sandbox_spl"
> @@ -351,6 +355,7 @@ stages:
>             OVERRIDE: "-a CONFIG_SPL_LOAD_FIT_FULL=y"
>           sandbox_flattree:
>             TEST_PY_BD: "sandbox_flattree"
> +          TEST_PY_TEST_SPEC: "not udelay"
>           sandbox_trace:
>             TEST_PY_BD: "sandbox"
>             BUILD_ENV: "FTRACE=1 NO_LTO=1"

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>
