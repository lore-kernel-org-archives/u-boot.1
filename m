Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B3C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 08:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB16881E18;
	Tue, 17 Jun 2025 10:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X2ExpB04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F69E82C4C; Tue, 17 Jun 2025 10:22:11 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C144480C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 10:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so46063245e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750148528; x=1750753328; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F59MYOBtMs6mx9RmpppJPX5dhgLZWLQPgvoOTzwgWCU=;
 b=X2ExpB04fKwqZxmAR0DGxY1W+zdLnaRvccjN3Dk6PwlIieYy1QY402s8UVNh+v7IIu
 r66r0gQ6+YZj/3jXvY8LE50uA1xV1Dv8M2slepYLaMsb1nqLoxjG4Xg8B6JbfzobgYIb
 +SXTzJJd7c6X6ZQXkv8HTNdwwpgpuA2wPyvQCBuJM2HMDWewNCZ5xE6nYRxd/gUAsAyG
 fAl4P2Cqoy1XCGGZusj+0oLpn7y9cuyKMvjN4PSTDiL8k9RM+4fq8eV8HTS4fI3Odxvw
 SkVFB1UCou5wHLlgsoYAckNpzrleqtPHSYagk/RP5HK2ecPrAImQM5TtX7teh1MQ3qXS
 5+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750148528; x=1750753328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F59MYOBtMs6mx9RmpppJPX5dhgLZWLQPgvoOTzwgWCU=;
 b=Uf+5Lr8sVHGi9D/ZUe/JLKR5VxfndeH+6902xNL+Fm4mN64YM/UIcaYQIuZiXi4gZ/
 JBM1SLOm+cbV/Wb0WmCpiCpsvfcrCDyBBnRJekv5KS9c66uBL2pOhcUcHX4FH1H8xPWC
 vDIBaK6iFauvyghYneIlQLlnVZXijab7u3LC25iDaXo2KjddOPcgS9YXIteutnOkcDCA
 f6jNXhMuTWwEUxIIKcwNI0/muW7kcf8ukjRx22ds7wB7ZYKhmQ3YRWbRO86ikv+Yic9y
 VtpnAA9LdbGBOr928+Hx6WGPysE9hZwANMJO6me1UbbzgADDKwbD3vENNWuLGrk9iSS0
 kuCA==
X-Gm-Message-State: AOJu0YzPyN4tgr87gxn15sYQFFVmjTqtNcoIDeRKJ71Okaep7pXvHtoH
 4D8mZoXyfmN7r7gLmOKky52P4peFxqpvNASZcjWNyIsKjLKe0Xdk0Cra/R3pdXfidHrH0mYNI8j
 /OpPD
X-Gm-Gg: ASbGnctYrn1NNBy3WTFgir9b/VfnOFZZm7DQxfzEsrqn6hZDckJauj2wglKpRzrRrdL
 f0qIfA+4CaJAKjYRImltydr9Vakgg89qChEcXqDnFy1twESEocmXOtLr17TBHeQg+BlOU+ZKc7O
 P+UIBlmU3guyZtLO79z0zMI762RJexX9Y3cH+5WJS26eoZ2wjFMRRXC5mVo+iPlTX8oeNGLFNR/
 wITKT7mv7EswnIyv3hCYVax5IADzQYJWP4s6FGOoNfmP2Htn95hrSbX4O5/NXeVNuSZrGuHF0rm
 JkImgVaBeyaoP2D4XQ5uaDK64ii32u+RoxTzqx4BwcS4yf/KEsBlYWk1IF2JyC/1654xPn8zjbk
 =
X-Google-Smtp-Source: AGHT+IFmO08HSK7bj5aADMli744/ZD8aJ6L17K1+k0tyvmwJxMngcOXj1se+k5WAO8rJsAPOE7hNmA==
X-Received: by 2002:a05:600c:4e0d:b0:453:c39:d0d0 with SMTP id
 5b1f17b1804b1-4533ca6905bmr124756515e9.13.1750148528064; 
 Tue, 17 Jun 2025 01:22:08 -0700 (PDT)
Received: from [192.168.7.94] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4533fc6578csm98915205e9.19.2025.06.17.01.22.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:22:07 -0700 (PDT)
Message-ID: <b3abfc20-17e3-4a64-ab5f-11941a825fff@linaro.org>
Date: Tue, 17 Jun 2025 10:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] Update doc/README.SNTP
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
 <20250606064211.3091237-13-jerome.forissier@linaro.org>
 <20250606142056.GP1382132@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250606142056.GP1382132@bill-the-cat>
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



On 6/6/25 16:20, Tom Rini wrote:
> On Fri, Jun 06, 2025 at 08:41:48AM +0200, Jerome Forissier wrote:
> 
>> Fix an error in doc/README.SNTP ("timeoffset") and clarify the
>> differences between CONFIG_NET=y and CONFIG_NET_LWIP=y.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>> Changes in v2:
>> - New patch
>>
>>  doc/README.SNTP | 23 ++++++++++++++++-------
>>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> Thanks for touching the docs. But, can you please convert this to rst
> and then update it?

OK. I will post a v3 with a new file: doc/usage/cmd/sntp.rst.

Thanks,
-- 
Jerome
