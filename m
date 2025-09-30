Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08439CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 10:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3919583045;
	Tue, 30 Sep 2025 12:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PEatf+n+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE8E832AD; Tue, 30 Sep 2025 12:14:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EB9828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 12:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso38756125e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759227240; x=1759832040; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z4NcRRSASc9w9smggCpaAwMGPyDApvnuTX0i77ptFLw=;
 b=PEatf+n+7MYWN+o84F0qqWU3uW2prY/OPubjHchyfeRbjIliYqvuLapdfYJhtwaEBf
 k+O824unv3F58eMxRWw7D76nhLfv1SwyC0ot2P0eccw3a8U/b55mPokf1jklcjEUlx8W
 5+u34d1n/+fp4toY1KLDquRvCqTkfzcyKPBUPQSKLlIhvuIAlioPELxy5aqnHpj1gKmf
 A+/OUCNbe9btSJrzhHSIoOwwrkhphqdFOe9x88TyCG+cbXuir7efRu+HQ4FI0q0FPWgp
 QGJgLL5CaeOG2WHU8NN/6gJX3YR14zT2a6mNuV6a2RXhVSMTEHDahmOcuYRft2ExqlOJ
 DFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759227240; x=1759832040;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4NcRRSASc9w9smggCpaAwMGPyDApvnuTX0i77ptFLw=;
 b=s7IjKWeXQ297pACBF1tBE3+R+oDn3gZP/bSLLPYRD9OTH1MY3PeSpy5mnSYEoyp0c8
 GPwJmCa+sNngBQR3VRDj+GN22HEuZItJkw3AKqmHOhq+lGzjrY9L6yn2yyzj3jb3rjY+
 kSV9fGXpH9HDON6ze6Qtt1nGTFC4af3xgB0qtelFyV+JrPHdcPJfRsF7DBELP1us8Xrg
 IeAfmlTJD6rxgvopd31Mcys4A3lQ/+My1K7SRTd+Yot9iU8MSKwXEPG56xPjf6Wt1nCc
 W4We0PaQ7wpjKDTqhaw5q3qdtOojuowN26Oxwy6QgZ/NNv5AhmllLJf/LATSLDon/67k
 CfNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqYB1IQ9XJTsJBgvke026tbaXd1TGHOS5C3Yeu2K3gejZqhtNXkkKlRjv5MBavMZacuJlZm00=@lists.denx.de
X-Gm-Message-State: AOJu0Yweo7Dpla042KAWjOzULOAsoVdLLfcbUS3H2LKFVtUVddZeZyDl
 I2lea/M1Ujk1aGRnOsuzLncC2rdeVOJYMu5dSXlpC8iwE8TA9aVn+/6e33L5+ZDyJTruPmLR6ng
 4+8nb
X-Gm-Gg: ASbGnctgMEUtQSQDUGZ/53t72O1+FPulTazPhfci1bfAovAslwKLD24dctHSD5DL4ua
 dRc1FUQE9kGEj8gov/1E5KuHlC4iKld/8zDUtncEO2z5J9tAH93vOnB1qehCx1vK343GvzKSTND
 sIhYjtN8u+Z2DXGudVbJ+x5dOk98L+bhh8wtje8EKDsCTPN0zNXitiKmomdenJewBdcdFw6E9sj
 NX9Kyi3+/Rh8UzPZRgN6+AXm2DjZr0RLR8rrsZpYWPrg6JdXoR3WSFM7kU9p7EuTNyZN1MCPLX3
 /cjVGjF2ygEbNUEwm7HGM0zeqFCriAXfhI15QNMGLkXlHIOcTLIHF6KlFmMEVVsEOKvAuX7oKwc
 G4ZkOfUTghJg9C5KcW0L1lJaMC+NJXpp7MsV3TEppZjvrI8Uf7mCZZQw0c1RcWPHolTbDFrSPC6
 l1TQJZFkOPbMj6AKXawY9V9Mo=
X-Google-Smtp-Source: AGHT+IFnIVG7vD5dAxuhBXpbhamjT83hw2SFBfIikroWfdNSjc6WKUbLnhTC8kR+W0mUAWz4ov+yXw==
X-Received: by 2002:a05:600c:15d1:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-46e32a0bd39mr129783435e9.28.1759227239626; 
 Tue, 30 Sep 2025 03:13:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:aed:2018:ed42:d786?
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b576badsm12090735e9.0.2025.09.30.03.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 03:13:59 -0700 (PDT)
Message-ID: <e361f9bb-9838-46b7-8293-99e48bfdc71a@linaro.org>
Date: Tue, 30 Sep 2025 11:13:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: ohci-hcd: Null check lurb_priv before dereference
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20250930-usb_ohci-v1-1-9efa75e71885@linaro.org>
 <46e03e10-3a48-4886-ae40-b1014e647861@mailbox.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <46e03e10-3a48-4886-ae40-b1014e647861@mailbox.org>
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

On 30/09/2025 11:05, Marek Vasut wrote:
> On 9/30/25 11:56 AM, Andrew Goodbody wrote:
>> When a variable needs a null check before it is dreferenced ensure that
> dreferenced typo

Will fix

> Can lurb_priv actually be NULL ? What are the preconditions for that ?

I do not know but it is null checked before it is used a little later in 
the function so I opted for the safer option.

Andrew
