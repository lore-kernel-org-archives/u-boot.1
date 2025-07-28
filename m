Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961EC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 09:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3D2083045;
	Mon, 28 Jul 2025 11:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SBX/3qOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8CB830B4; Mon, 28 Jul 2025 11:02:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4287C82F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so556124f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753693331; x=1754298131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XPIZ31WvWQq9fDqBLSUu3bCftZLEtTQhIV4EIa031jU=;
 b=SBX/3qOv8v31EAV/Zg5xcgUQSqz3K06ecY/vFTAbpQXSJCkrx1Ysm0dO2L06w4aPzu
 MvBCIiZM7HBftqPgJ5Xq3stOJCZLY1xq8WhxpUBth2NiRrzq0MVKyFl96BLVEf1nLKOh
 6n3NiEDQchKmePBLYVF7xT6B9ewR5wQ/dh6540dJVglrp1iVIVPUVeo6JULFQ5GUNnGN
 XA8aI7rL2PWYC/KNcyMFZswc0vMmjO11dfNpKFu44SKfQG88+3pX+GSZu5IRVk0zb8IM
 7/l1pCHOwqumGjlybh5SD2XL+ptsvUjS57gMbXRXK8KmnG9rOekAnvKZRQsPsKAyf7c+
 Jt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753693331; x=1754298131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XPIZ31WvWQq9fDqBLSUu3bCftZLEtTQhIV4EIa031jU=;
 b=GPchTB47sR04M/Kv8L63wFsKACCXPY06QfJaZPO0wFzhEWLTyk3LhI6s/drzJ8NDWK
 2kigMChFjxofSMMeKj2XaBFi4Au8/7hlgSQJX+V/cHIy2cU/9q3bXsU9m9fG/I/oaPix
 elEm586t1agBoyl4aek5XMWz3+En2GtMvbY8VGrG93qBBSOc8GJ0srjwHcwR9OHhmzY0
 h7YqTVj5K0g5K92cGn8lxI9EfUvN5gXENscSp5KjxRwu4oskaP4TxONa/doKCAXjgCny
 Tuq3qzerV+EHpLSMU9kdHtQLFh2Y7TCsPdYlZ1Ju1ljDECL5EGjf8mMGRdoBNgfSCMyb
 6tAQ==
X-Gm-Message-State: AOJu0Yw9zVvWnY+Be9UolkbaG8Q2qwxEQ8Kc8Lzwm6ndLggq0FNek7Ky
 dS6Yy4C5SLOkZS8ejU1TbG7mztupDkKDmz4s2P+Jfiv/k6bxPdHsk6wySQEX4gcV3k8=
X-Gm-Gg: ASbGnctxHe/3kcta0zrW0tilxYpIQbS+DMFto6VoJjQy0W3RjISiM+E9CvKyTFtm6AI
 dK1G6LDnVOA0649OMoZJuL0VVlMNqZuqzhXPSxatvzRNbIAM7TqyHndkCVVBEwkr6lxpm4Fhxly
 xwiXKlf0SNpqNPzjAHeuNqMdMkYUAfvsv3UyCm+rjS50LfxpnLPXcJUakH2j0cggfuKCv7Spk12
 3iRymMRFlgUz7PciD4L5dUAVs7mvAKG9NYyvaDoDbfUT19WXvEstvussdku1CLwQ3ZhshuCMEzh
 59fbXX1HrUOEj8r2A9HToAzBfJt7vrV02x7AWl1QT/0P/YzQZOZJ3PXbHf60aq/gh3q+DAoVSlV
 VHh1EFXlsam6MNK4jsevhXPSnVoO8m4RqvyYuyNPZhS2m1xSAtteQF7JtvtLuACwzu2n88lMXop
 Y=
X-Google-Smtp-Source: AGHT+IFpEYQp4N7UevKVObhacgwRc6hVzGJx/Y5+WrUycORKIRz8AxSVZXtHiA4KesEP05NF0VbpQw==
X-Received: by 2002:a05:6000:2883:b0:3a5:2e9c:edb with SMTP id
 ffacd0b85a97d-3b77668d454mr8673518f8f.47.1753693331260; 
 Mon, 28 Jul 2025 02:02:11 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3?
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587ac7625esm91270195e9.31.2025.07.28.02.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:02:10 -0700 (PDT)
Message-ID: <2a7826fd-1573-4f4a-8540-afbefe3b0d0b@linaro.org>
Date: Mon, 28 Jul 2025 10:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: ufetch: Initialise size before first use
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20250626-ufetch_fix-v1-1-025afdb85dc2@linaro.org>
 <84393d64-b2c6-4287-8fe3-10c6b23dd8d4@linaro.org>
 <013b1877-e199-4f98-bcb6-54a06d86ae7d@linaro.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <013b1877-e199-4f98-bcb6-54a06d86ae7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Thanks Casey. It is just that this patch still shows as 'New' in 
patchwork rather than 'Accepted'.

Andrew

On 25/07/2025 14:19, Casey Connolly wrote:
> Hi Andrew,
> 
> Sorry I missed the thank you letter for this one. This patch was picked
> as 8830e72092e0
> 
> Kind regards,
> 
> On 24/07/2025 10:59, Andrew Goodbody wrote:
>> ping?
>>
>> On 26/06/2025 15:12, Andrew Goodbody wrote:
>>> The local variable size is not assigned to before it is used
>>> for the first time. Correct this.
>>>
>>> This issue was found by Smatch.
>>>
>>> Fixes: 86d462c05d57 (cmd: add a fetch utility)
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>    cmd/ufetch.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
>>> index 46bd16824e6..bc5db08eee1 100644
>>> --- a/cmd/ufetch.c
>>> +++ b/cmd/ufetch.c
>>> @@ -93,7 +93,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int
>>> flag, int argc,
>>>        const char *model, *compatible;
>>>        char *ipaddr;
>>>        int n_cmds, n_cpus = 0, compatlen;
>>> -    size_t size;
>>> +    size_t size = 0;
>>>        ofnode np;
>>>        bool skip_ascii = false;
>>>   
>>> ---
>>> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
>>> change-id: 20250626-ufetch_fix-54b741710142
>>>
>>> Best regards,
>>
> 

