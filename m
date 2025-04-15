Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFBDC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAB58209C;
	Tue, 15 Apr 2025 15:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mVEp8PuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E71829CF; Tue, 15 Apr 2025 15:51:28 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E0D88003E
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso38572645e9.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744725086; x=1745329886; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqEkqtymY6RxSEHOL39NNLurwmr7kkrUnIao00WHhHs=;
 b=mVEp8PuAfknKt3tqVOTjihKICzpfBYhTKtmFg3aN9co25BVUkeHv1bjsBs8+dLfFLG
 csZg0QvPbdfxlwlS3WWAriAYDRdaiuBSor8PeJfiIZKy7te5xQVMfRsSe1khAefqTXeb
 nUx1+NjQGRaLgid4Wofy4vhFXirW0Ab5CIJD7Dz/xaaPDgfhhKmBsuuqymV7Wd/rHWL5
 0IDzpfR700KDlb6i1EAKDQ6JpczmJ8yxnieSmGltzCqaxRAIkJ/S59vV+z9SaqkL17nf
 9uxI76k+LFjOYFUy5zatHAxjl7t4Vp5+Ad1Z0E4OS1qC+buiDQBwtQiPgFNNNnwV21XV
 GzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744725086; x=1745329886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqEkqtymY6RxSEHOL39NNLurwmr7kkrUnIao00WHhHs=;
 b=YSebeXRcM48yQ+xVwweSct3UD2ssKLK+1J3Ec5v2tBZ2Vrr8NyV7vrk1CZCh1J09L2
 hshMxJ5sQduakj3qorGk3Zh7yLZzydH5SR8Gmg6mtfgwcYVWbp6uMilikz3Fcks3HGv7
 /XzSDr7t6ojAAWt0/2Da7ZOkRx3p7yELbUOubI792ymRMBjXcJS2fsh+9vLoBRRqW9Pr
 u84yklLqmvVyMyOZcCzaIkSJqFi1ZJvh2b13kZGspvlS9z8cuQoX1Tp+eyyK9Btt9141
 ZxMcQbfRBIk+8YAzlnpxAr57/0PWuW8Omdakw/SvmvR2n/0Ch9q+DTZA1EI+FtHSLzFd
 PjIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ugwMloH8U8SuGgzBQ9NUQmyjoPct8PCmcKBHHsWqRAI1/VrD1/Q1Q4XWj7dNFk0o/Ttn9ik=@lists.denx.de
X-Gm-Message-State: AOJu0YwefD2oA2iOVWotZD+KZox5UtwE9PwgT69nqat2kMzOTrc8DSnN
 c/jv+FUFd4mYZGqy27uoR301vJq1+XrImfg6EEVmjbmTJMdhplNtckslPQBhimY=
X-Gm-Gg: ASbGncuqvZZR8wDRswQTGnL2/imXicqZ37vj0VNBP+U0xXr+B+temQSHt0ZoaOKxsCd
 FqYECgmVp6Pn5lGIODdIvQUJQRwX4A0xgX3OwXiX5ai11A79BOAidTnixJfTa/rJlKZo6dg2272
 WHoGy/b37RcMqvT3xPKMLF50I5UguRwoTAZ3sSdbD7pBrIk1jW+sKY6bUYyilLNTz5eV8AFcjyj
 d8d8SagtynUWiKlxqBJHVhIYJyf5soAUB/yv/BDvn8WIJ9ojpYqVQRjq1VtAHNhkpWvmMSmay3S
 oMJgWZVuRljmD7b0a/DKsceOyE4h0nR42yEhQjqyziz4gHX58re6xUDS5jNPFg==
X-Google-Smtp-Source: AGHT+IHuYljHEt9BZe7W4py1IoD6M8xNmalSP1DGpkFK3obM6Qu5VUxbA8esZI2weSOv0SnYtfJwPg==
X-Received: by 2002:a05:600c:3554:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-43f3a93f2d8mr159644605e9.10.1744725085677; 
 Tue, 15 Apr 2025 06:51:25 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cd69sm14130974f8f.80.2025.04.15.06.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 06:51:25 -0700 (PDT)
Message-ID: <e84b805c-49b9-41dd-84d8-1b40dad0b2f5@linaro.org>
Date: Tue, 15 Apr 2025 15:51:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] test: fix print_guid()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot mailing list <u-boot@lists.denx.de>
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
 <20250415125345.427420-2-jerome.forissier@linaro.org>
 <b4d515cd-57de-4094-96b2-54749129a284@gmx.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <b4d515cd-57de-4094-96b2-54749129a284@gmx.de>
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

Hi Heinrich,

On 4/15/25 15:25, Heinrich Schuchardt wrote:
> On 15.04.25 14:53, Jerome Forissier wrote:
>> The %pUs format specifier prints the system partition GUID as "System
>> Partition" if PARTITION_TYPE_GUID is disabled but either CMD_EFIDEBUG
>> or EFI are enabled. See list_guid[] in lib/uuid.c. Fix the print_guid()
>> unit test accordingly.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>
>>   test/common/print.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/test/common/print.c b/test/common/print.c
>> index e3711b10809..574c84b2eee 100644
>> --- a/test/common/print.c
>> +++ b/test/common/print.c
>> @@ -47,6 +47,8 @@ static int print_guid(struct unit_test_state *uts)
>>       sprintf(str, "%pUs", guid_esp);
>>       if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
> 
> I would not know why a brace should be needed for a define using
> {( some expressions }).
> 
> The problem should be resolved since fa847bb409d6 ("test: Wrap assert macros in ({ ... }) and fix missing semicolons").

Most probably, yes. I'll reformat in v2.

>>           ut_asserteq_str("system", str);
>> +    } else if (IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI)) {
>> +        ut_asserteq_str("System Partition", str);
> 
> Printing two different strings depending on configuration settings is not very helpful for users.

Agreed.

> Can we print "ESP" in all cases, please?

Fine with me in principle but...
- Don't we risk breaking things which would depend on the partition name?
- I find "ESP" a bit cryptic. I would suggest "EFI System Partition" but it
is quite long and I see that CONFIG_PARTITION_TYPE_GUID defines only short
names ("system", "mbr", "msft"...) so there must be a reason.

Regards,
-- 
Jerome


> Best regards
> 
> Heinrich
> 
>>       } else {
>>           ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
>>       }
> 
