Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AB6C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 20:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F5DC80A55;
	Tue, 11 Feb 2025 21:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iH08XeMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8DE80AE5; Tue, 11 Feb 2025 21:58:55 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D3B6809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 21:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso17148235e9.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739307533; x=1739912333; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYsDG9wZ9CHSmDA1Ao/oWMsjCMzofal9DGy3qw4Vwtk=;
 b=iH08XeMxPWxO9dRoURBDgcZ34wsHzHzM3ZLLRDpIIIUdwgW/q1DDYquhqRTxnzcXCR
 2MFe+VYtVF67WSy/77OWpWWorzpIFYvXJBlbbBXlQ+in4cp14qqX5PuZo4RTOrAERwK3
 P/wpaquo6/Zod0g7v2NIactjnU+RibQ8lmbl9SDnZG+ogymriAioZIKFYRo9NT0+rif0
 e4dBY3JLs90VKO9kEe008MRFCzxLgTClVMjBMAaQSJ8KmpsD7HSsI9M1XJmLYMJ94KN/
 yx6G5hj7Ip4x/mC6/wTLVNFd0sb7SiCz0reiobLAGhWsiCYGhQO9cHtGDVurSAcdXwLQ
 kLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739307533; x=1739912333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYsDG9wZ9CHSmDA1Ao/oWMsjCMzofal9DGy3qw4Vwtk=;
 b=L3kJIRjdtaGWCO5i5WegRo9JHCyWu4u0HMa6+uZn+8T+DcDd0pzO0nfFJl7OiQc4xA
 Yqo/9k1I4XUP6T6n3fIc9qonSzoThZ2S0l56VnCelr0nIr1+EIv6JdxM/f0qOkV1666X
 x4B35T06CmmbwoDhj4ZJ5InTZpQuFfn//gv8Gftrt1oGfajIdqWntaUOuzkEU2HsO63y
 gv3zp/jgXPcVrdheU4TcIA+65wPlL3V+N2xMBFTakMBMc4iY0z76CH9o7hzrMrVPE7PF
 UWPKCuLYjlUk7afNqVJOPm603wx9bXuAzaRbdQBIAnEhzJa/ycCTBVEPlYBwaiw5MziJ
 7V6w==
X-Gm-Message-State: AOJu0YxGF9NwwyqpAqhGBc3tisjvNg3RzYQBBF045UNn6e/sIrp64gso
 E9k/whlrUngeBzJfJsTjahPoNULkf+JAokm9G4NI+dz+o4SX+L9W2xwUh0Hfj5E=
X-Gm-Gg: ASbGncsoUOO4R/ckaPgEHApVz1ZqUYvN+xdIKlsYZaagtnTJFi17zsQOzVP8ATfSYMo
 19spzTFs1VmxEhI0vxvkC7HItS+pzbeRQfbDjCfTWzMdJLdAjMRU5pq0YYaDiP1CDSaTIl2ISau
 TgUCaxUdAIVBJ/h6fB1wJignoc/b/Ih5FCLYaI1v5l23EcRNuo1l41+agknJBnJLNKlaFhwSoZM
 y6j7CQ6kPlrs4MPNJMYBpt7JBmcd/2y5TbdslEQ384G5QBBLtkgnsK25zVDWJMTSlqLjwMgG1kp
 gaaE8R36Zg0zgibJSDF6438m80sDskOh2Yd7zMUvTD/D4TivY01CymL6/+CNA/lhlcGRpw==
X-Google-Smtp-Source: AGHT+IEsSVmM3Z0tQU39/RHC1u2JzFDGxWUsrp+wstl/vrLOrBC+VYI/6RFAm9W9Exo+v++gXvr3CQ==
X-Received: by 2002:a05:600c:3b11:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-43958176305mr7595435e9.12.1739307532642; 
 Tue, 11 Feb 2025 12:58:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d?
 ([2a0a:ef40:1d11:ab01:c8c:8100:5ea8:e20d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf44f3sm226186055e9.29.2025.02.11.12.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 12:58:52 -0800 (PST)
Message-ID: <ca422594-9870-4b39-b6c5-0b3c701df1d3@linaro.org>
Date: Tue, 11 Feb 2025 20:58:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: efi_var_file: specify absolute path
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250210131045.13905-1-caleb.connolly@linaro.org>
 <39d08725-833c-4ac1-805c-2402a20039aa@gmx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <39d08725-833c-4ac1-805c-2402a20039aa@gmx.de>
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



On 2/10/25 14:04, Heinrich Schuchardt wrote:
> On 10.02.25 14:10, Caleb Connolly wrote:
>> The EXT4 FS driver gets unhappy if you attempt to write a file without a
>> '/' prefix. Adjust the EFI_VAR_FILE_NAME string to be the full path to
>> the file.
> 
> Thank you for reporting the issue.
> 
> Our FS systems should all behave the same. U-Boot file paths are always
> absolute. We should identify the problem in the ext4 driver.
> 
> I thought I fixed this in
> 4ed2b1af4599 ("fs: ext4: all file paths are absolute")

hmm, ahh yeah that looks right. For some reason I thought this patch was 
still relevant but it seems not.
> 
> Best regards
> 
> Heinrich
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   include/efi_variable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/efi_variable.h b/include/efi_variable.h
>> index 4065cf45ecaf..83fbca93b6bd 100644
>> --- a/include/efi_variable.h
>> +++ b/include/efi_variable.h
>> @@ -91,9 +91,9 @@ efi_status_t efi_query_variable_info_int(u32 
>> attributes,
>>                        u64 *maximum_variable_storage_size,
>>                        u64 *remaining_variable_storage_size,
>>                        u64 *maximum_variable_size);
>>
>> -#define EFI_VAR_FILE_NAME "ubootefi.var"
>> +#define EFI_VAR_FILE_NAME "/ubootefi.var"
>>
>>   #define EFI_VAR_BUF_SIZE CONFIG_EFI_VAR_BUF_SIZE
>>
>>   /*
> 

-- 
Caleb (they/them)

