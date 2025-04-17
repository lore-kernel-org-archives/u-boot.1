Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343A4C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 14:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F9E82D32;
	Thu, 17 Apr 2025 16:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hS5ymLTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6970383019; Thu, 17 Apr 2025 16:01:15 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8A882D18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 16:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso145486066b.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744898473; x=1745503273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xcwFbY3YmGLT3hsBTkDBmKXa70btKDW5wkkQD/nvAH4=;
 b=hS5ymLTOeG+13g3+aBsv/d6rWnzdfakalgFBOmjkuU8rYJhAXPegP4yz+kxbcZ0SKs
 VebpG5C+0lyN7g6r3Xz7zifSTOJ9AxpwqQOarMx+ZSj5HcMYapuXRQ3At0CxMtL245sA
 kqqygV8RDpzkC9reXZoj1KXY7jyMdlPlpmLvfeD9kOGH7j4Dmp+rzinWH5WV9+vIY/eb
 fJU4nD57dTz2Gtu/g49C/q7SODzfj3V6rkt++DUePISDIbS7PagacakCQM95UHDxJO/J
 WpJjr4ZjQnyDU7jC76Za6zXbvV6T2zM46KvLNn9tMPK2JQmfJfZntBbfho595uXQVhVR
 jXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744898473; x=1745503273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xcwFbY3YmGLT3hsBTkDBmKXa70btKDW5wkkQD/nvAH4=;
 b=IBarsUKfHDXOKI28+hprSw8wWF5aZ+2NeitjGATlZ+KIbX2HDbc3LlZEWZWn/B+s7o
 B5sU57SCAqZuryxseCfMY4f1RUQyMWGSTezOzBf4tcK0AbuDdW9tjmmNcYtB34Cb2rsX
 nZnXB4HKm0APEw8sKPDt+e49s/NRPx8KWlbTfFd88qnK+2iIkIo+NVygHF9mV2ZCMN2/
 P6XsW7eSbJAPj9wo/QRqLtuxApKbFsu3wJK0qxLt6TKTWNP758M9Ct59bw01SxG0MVnj
 5yOnGsoHmaElsxckUAXiwwTdEG+b4dHrWv6ghxAkXQeobdYnqdcoS8hjnrMyvaNnIrCr
 5tUQ==
X-Gm-Message-State: AOJu0Yw5+r4+JP0vs9ayDWZY/4zr5u3y/AnvOYXiTXpw0Q3hh23pE6M7
 f52MBNAfi67NK/fVDOuH+JnZaoPZTJTZnMjHBpuHqFvYwVPhK5Xyc3OAcT01Toc=
X-Gm-Gg: ASbGncsQ/VAh10mZJvP8VyPPjEKDDdYRJjXV8EiYcgiQTAoWCjpMUAKzIGSPGx8PBDK
 dyZJDeVdjxLZDJ2xSSpxFmBMDWNOHLmPcDGpntkAahe6o57sQ805oDBNwzxlIrIEDxXGA5l/cZK
 u977ztfLL/qoI5KfpFM1u+QttCiFT1Gcep/YG9Jz+4AZzZhUlSm3rVLeIGNDPMIf6AERFFYO1WD
 Z2qqpUxADQsw+xIjPs09U3tCzZb/jfmhZTCPv709Xcn6DullYeymO4qO61ZFINGV6UI6FMnoRxJ
 qNEFjUGPGFFEHTxGVuIA4y7A7CTWirotVbEz2KyExWfoul54
X-Google-Smtp-Source: AGHT+IF1M07muzg3YfhrJXLj9G/p3NeD9wXMz4pyVVH364fz/RygYoZZ6DWpLEqilHq7L2oCSzTWcA==
X-Received: by 2002:a17:907:7e9a:b0:ac3:ec70:18ae with SMTP id
 a640c23a62f3a-acb428776ccmr561155966b.3.1744898472262; 
 Thu, 17 Apr 2025 07:01:12 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb3d3498e3sm295060666b.175.2025.04.17.07.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 07:01:11 -0700 (PDT)
Message-ID: <e0a4f478-f1b3-46f2-82b8-15cd69f83b96@linaro.org>
Date: Thu, 17 Apr 2025 17:01:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250403151050.3649150-1-festevam@gmail.com>
 <CAOMZO5BT+yfWYab=Ltj5iJWWSGyAj_TVAuHd99RQP10rzauE4g@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAOMZO5BT+yfWYab=Ltj5iJWWSGyAj_TVAuHd99RQP10rzauE4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 4/17/25 16:54, Fabio Estevam wrote:
> Hi Eugen,
> 
> On Thu, Apr 3, 2025 at 12:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> From: Fabio Estevam <festevam@denx.de>
>>
>> The PIT timer needs to be available early in the SPL phase,
>> otherwise SPL fails to boot and only prints:
>>
>> Could not initialize timer (err -96)
>>
>> Fix this problem by passing 'bootph-all' to the sama5d2 PIT node.
> 
> Do you have any comments, please?
> 
> This allows SPL to work on sama5d27.
> 
> Thanks

No, this looks good. I will apply it for 2025.07 or next, let's see what
other patches I have and when the PR will be ready.
