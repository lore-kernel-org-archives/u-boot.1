Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F583D32D8E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 10:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD5E890FD;
	Tue, 12 Nov 2024 11:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="czEW/vz2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B9489426; Tue, 12 Nov 2024 11:53:05 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F47989032
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 11:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so52370005e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731408783; x=1732013583; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0n2wHYi/+MD0OHVGv4fX5wxXORxuNJyKSykhXw/Recs=;
 b=czEW/vz2d3I+7YDkKkeO5CbQjX0qo3lgBcd2nO6Q7l+9KwGM15oIdB8OF9hRmLeYhC
 5ICseL1KeuO6MpxAl8Dfsm/nNrd1eIU/uPpEc+ou3JOmbMtpQPIHwJrb7c2R3ztgGwJJ
 kYtxYC7OAi39wAMBuw7Mkbv+D9GUP6U8dgbTctcIAViCgdgHiv5KrsiKhr2oN0nZqGue
 cRk5mAsxYGzx1Zzl6lUPfSHxR8DUuK1iSgDpCF/vzn90RSHIWi+1IexBIItqLM8wyiMZ
 cyqoT6PYT45Fwvvzzv6mSZNXxL9q+Z6M35ThC5k1cWCe7eZ/Lpv9x1OUQcuXxN7PYBP0
 MYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731408783; x=1732013583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0n2wHYi/+MD0OHVGv4fX5wxXORxuNJyKSykhXw/Recs=;
 b=MmNP76UT/7GLQ6sKGq8Vxu+pqrJps4Zxmf8UT5NkcTZJQaTYNPFex8IJWv+uOfMbTl
 vJhB/oV7dgT4AFQvmyCrRk40xWZDSDQTirKDnpcEJKzbf0We2m6rB45TJjfXwb7mSqTg
 xUB+A5NRIgDqM1wB06dh3eEjQNpj0ZfdymwOkgcBCNPk0PGXo2exH5RA6D+BDiLn5EWP
 GtZvCRTB4ercSp6ehNijAiX64LKzOly6Iqee3u+llHuCBeNMfZAovAlOqOO8yMswBRSB
 Wr5y2/O+XRQtVBsnudGXDPcowxKizfBvzDxP3fOZF6wTzHKLScxepuENwNlqSXQq5LZd
 OH8g==
X-Gm-Message-State: AOJu0Yz0T7/OpWgzwMpdPkuBaTcLMI1no55IKF86uv5tFUUa0S0FQfym
 c/iUWODaY/YcgBeXG1JQfzTtoRRvnAJhUUrsrCGbEMv+ai/CgG19cnPlrf5MMfc=
X-Google-Smtp-Source: AGHT+IH15ORTVXq51W2Y1YIiqIKuzgBxZFeCfcIZ29O8ZmKjrtDDHtvGKwtYWVy33WNqLWbReuWwLQ==
X-Received: by 2002:a05:600c:46c4:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-432b7501c6bmr147003965e9.12.1731408783049; 
 Tue, 12 Nov 2024 02:53:03 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b3de8710sm187877345e9.17.2024.11.12.02.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 02:53:02 -0800 (PST)
Message-ID: <d410ced4-058f-45d6-a0e5-ec608529325d@linaro.org>
Date: Tue, 12 Nov 2024 10:53:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: net: lwip: use EOPNOTSUPP not ENOTSUPP
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20241105102455.10141-1-jerome.forissier@linaro.org>
 <CAC_iWj+f+kOSZjbJZ25qCHq3+y99a7TwyvoRjf736VUZOFFsbw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+f+kOSZjbJZ25qCHq3+y99a7TwyvoRjf736VUZOFFsbw@mail.gmail.com>
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



On 11/11/24 12:49, Ilias Apalodimas wrote:
> On Tue, 5 Nov 2024 at 12:25, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> EOPNOTSUPP is the recommended SUSV4 error code that should be used
>> instead of ENOTSUPP.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  drivers/net/sandbox-lwip.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
>> index 3721033c310..5c9a0cb1b9f 100644
>> --- a/drivers/net/sandbox-lwip.c
>> +++ b/drivers/net/sandbox-lwip.c
>> @@ -27,7 +27,7 @@ static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
>>  {
>>         debug("eth_sandbox_lwip: Send packet %d\n", length);
>>
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
> 
> I think we are fine without this. Isn't EOPNOTSUPP for socket use only?

Indeed. I think the most appropriate and standard code here would be
ENOTSUP but we don't have such a define and it doesn't matter much
anyways. The checkpatch advice is bad IMO. I am fine with dropping this
patch.


Thanks,
-- 
Jerome

> 
> Thanks
> /Ilias
>>  }
>>
>>  static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
>> --
>> 2.40.1
>>
