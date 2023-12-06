Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16146C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 11:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A52876FA;
	Wed,  6 Dec 2023 12:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r/g8dJt8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04DE8770C; Wed,  6 Dec 2023 12:39:49 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF7AB87706
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 12:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c1e3ea2f2so4000945e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 03:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862786; x=1702467586; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0KUuRt+KdWKhemTUAv9wA+Xgs4RA8rDFLi5npaes9qA=;
 b=r/g8dJt8o/ja24B8M2iZeqrwcNuy9huJ0opCgcIVroqyhFf+UzHXtGGNeZV30fWo99
 v9ne0DHhOHva0wfXgNu+ZfHxLGlZYUJ9gGyPFnmsEgfHOgBYAqx7v+Gwg4LnP3VbCKTl
 ZSdwSBrpTSzTir4hFp0p1K3wXP2JKibs8GnsBq6NBbx1imjYFgKI+cJqo5t8LU1OgN9J
 N8qLRtsOD2qrLtCIGcE8lM9JRWUnRCO/Wb+m2GPMqpxvcvChWOldCsnbO7f+Hrswa/T+
 I054vNaRdhDo1lyIXo+EVz6P6SFUz3qcfBSkKWYOURWsRyZzuUX51oDt5IWwMw5w86qR
 uXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862786; x=1702467586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0KUuRt+KdWKhemTUAv9wA+Xgs4RA8rDFLi5npaes9qA=;
 b=ca1K1Y2ZXEqfNxl1KeTRRxrm2oLakMlrMiPVMuspElw0w6lNGcXClo+uyiwnGTFD8D
 Y52xDEjvNBoSSBXIAOrq33oYs91AO9YY8ik6pzKi0JtykUond25Yw3TuHglzdLYkMfDU
 WEme7ShG3QS1SK35gKhyEnURMtCSdDa5vowouz6hYkQc0QhnYLeKXBVAJ2haM5f5W4Kl
 pdUkuG2Qjmq3hobgZgfcYEmMynh4bxpB4b3A8t2cuALb2jGYRLrQR/LIwK2G9Jnm1x7n
 TBxfGKgsRUt+JW0B4E8hT2ASvyf2RsXMuHZYm+D0ZRdrPKbE22dgn9uMAXCbhi1G9RbW
 UqBw==
X-Gm-Message-State: AOJu0Yzt4eQ4jaHkz7A+zWlH9zh6LRQObYMo0moq+d5r8DX8pQ7/XmbZ
 CRyqNtArA9PQoEJBRL9a95Njjw==
X-Google-Smtp-Source: AGHT+IHnohjosdHFyzAyDRI1LMg98z3m/motiw+26VI+4IYqkwAyXQ6DFm4fIWz2NNne+yPyVJpQaQ==
X-Received: by 2002:a05:600c:470c:b0:40c:b0d:398b with SMTP id
 v12-20020a05600c470c00b0040c0b0d398bmr557933wmo.16.1701862786543; 
 Wed, 06 Dec 2023 03:39:46 -0800 (PST)
Received: from [192.168.1.15] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c4fd200b0040b45282f88sm25113009wmq.36.2023.12.06.03.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:39:46 -0800 (PST)
Message-ID: <bda2b648-a481-47a9-891b-9d1b81727706@linaro.org>
Date: Wed, 6 Dec 2023 11:39:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
 <20231205-b4-qcom-dt-compat-v6-6-61d104a8f920@linaro.org>
 <CAPnjgZ0gC2nhpX=fA=s3b+LiABN4E-cHqY-qH5+4LuVfBwp1Gg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ0gC2nhpX=fA=s3b+LiABN4E-cHqY-qH5+4LuVfBwp1Gg@mail.gmail.com>
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

Hi Simon,

On 06/12/2023 03:54, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 5 Dec 2023 at 06:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Use the upstream gpio-ranges property instead of gpio-count, and drop
>> the bank-name property for Qualcomm boards.
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> Tested-by: Sumit Garg <sumit.garg@linaro.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  arch/arm/dts/dragonboard410c.dts | 3 +--
>>  arch/arm/dts/dragonboard820c.dts | 3 +--
>>  arch/arm/dts/qcs404-evb.dts      | 3 +--
>>  arch/arm/dts/sdm845.dtsi         | 3 +--
>>  4 files changed, 4 insertions(+), 8 deletions(-)
>>
> 
> What is the replacement for the GPIO bank name?

The bank name is hardcoded to "pmic". In previous revisions of this
patch I tried to keep the specific PMIC model, but after some discussion
we decided that there was no benefit to this over just "pmic".
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
