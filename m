Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C647C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 14:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0FE87CD5;
	Mon, 18 Dec 2023 15:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5UiMpkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813F787E22; Mon, 18 Dec 2023 15:47:25 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8507287C82
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-336690479eeso879327f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702910843; x=1703515643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3M8r/pKC/5cF4KZMeEeOmmP29PiiDCpSdePMQasdQhg=;
 b=r5UiMpkd0yp+oV6hreOy0xioSgk2BUcVQB1DHrtQqw9sjXCid9oy/+8CCJlf4iJ4HN
 ojCmL0W5H+vVUM7953z5f3NWvhwwYRRV2csD6JXXbT8w/hZUZeCON3n9IArTbqdQb/8C
 /dTN0Xwzmofi5ArW/4b8xeoIdhy9M5SUE3V6M4R9IKYwDzD7gowGMZPtC4C/Ri4SHEYo
 s72hFKTLohpgMV983EjlHuZfizx/NVWmBOc87QtVJQYSfkjIEAF9eZWQRgULesn+GTkw
 K3TDAxsXWxM0h/ZsGwqKa0uBfbmjb8GQ5KBtMY+YpjhSPwpcdviwHkaOmlVmDdhy+RxC
 6oIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702910843; x=1703515643;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3M8r/pKC/5cF4KZMeEeOmmP29PiiDCpSdePMQasdQhg=;
 b=JJXUKpEjMmjD4MDQfsQb785q2eTNE9hmu+wxAI5oVqrU4aQS+GxnJQsFK9AwVjsQWU
 CwgpABVPzxm3XcSho03qr683jdTi+qKJPNbaMD33Rgj96JC1QJikGfAoKC+BN9cLWWQw
 dZx6Mo9uodPupG42kLlEC42P73RmgJ2Rxt7OWguUiv63N62xkpia7YKNd4CYRIPK+3Ht
 6ZlQde+iij4o4Yet2RlAtNsrj5K+LwtwFqycqWLaXFh/qO0Wq8kCTF66+bEUWJ3qaBlj
 QCf9Vk3o+ZINJxYIAT9f9p6jQ6opvvxBVAuQ394wRExVkEeR7kNIpj1epy5ClEtXZQNC
 Savw==
X-Gm-Message-State: AOJu0YwEcHt2rFULmIjoQO3FTOQuv5l5tJ6zCE9Ey4CiCkLIe2QdKQTk
 QArRp7iUYCZOwBfHbZIiNthXGQ==
X-Google-Smtp-Source: AGHT+IELQJSwEBYrsaI1DaxAJ5jY3U4Err84TcQ039c8O+YRI1IoWTHUP2RQ5T81xUuuThUa/ric7w==
X-Received: by 2002:adf:ee0c:0:b0:336:5fbf:c86f with SMTP id
 y12-20020adfee0c000000b003365fbfc86fmr1473995wrn.1.1702910842921; 
 Mon, 18 Dec 2023 06:47:22 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b003365b2047c5sm8228311wrt.114.2023.12.18.06.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 06:47:22 -0800 (PST)
Message-ID: <a543b77c-8829-4510-b1d4-f23478d58907@linaro.org>
Date: Mon, 18 Dec 2023 14:47:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] dts: qcom: adjust pmic gpio to use upstream
 bindings
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
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
 <bda2b648-a481-47a9-891b-9d1b81727706@linaro.org>
In-Reply-To: <bda2b648-a481-47a9-891b-9d1b81727706@linaro.org>
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



On 06/12/2023 11:39, Caleb Connolly wrote:
> Hi Simon,
> 
> On 06/12/2023 03:54, Simon Glass wrote:
>> Hi Caleb,
>>
>> On Tue, 5 Dec 2023 at 06:48, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>
>>> Use the upstream gpio-ranges property instead of gpio-count, and drop
>>> the bank-name property for Qualcomm boards.
>>>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>>> Tested-by: Sumit Garg <sumit.garg@linaro.org>
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>> ---
>>>  arch/arm/dts/dragonboard410c.dts | 3 +--
>>>  arch/arm/dts/dragonboard820c.dts | 3 +--
>>>  arch/arm/dts/qcs404-evb.dts      | 3 +--
>>>  arch/arm/dts/sdm845.dtsi         | 3 +--
>>>  4 files changed, 4 insertions(+), 8 deletions(-)
>>>
>>
>> What is the replacement for the GPIO bank name?
> 
> The bank name is hardcoded to "pmic". In previous revisions of this
> patch I tried to keep the specific PMIC model, but after some discussion
> we decided that there was no benefit to this over just "pmic".

Hi Simon,

Just wanted to check this is ok with you before merging this series.

Thanks,
>>
>> Regards,
>> Simon
> 

-- 
// Caleb (they/them)
