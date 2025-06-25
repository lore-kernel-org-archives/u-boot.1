Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F077C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 15:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834D782D34;
	Wed, 25 Jun 2025 17:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WXObalO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49EC982D21; Wed, 25 Jun 2025 17:39:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E1B82D34
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 17:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so3563273f8f.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750865953; x=1751470753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LPo3LwibQNA4bqfnD9JnU/Mbz8cRLmcm1B4DsfE4S0w=;
 b=WXObalO+UglMz2npX+7/TfyhDMd6eMJ/FwhwM+TDwfE31hMCu9wMC+aulaT9eqL++X
 NL4XzSK7LgeVlfHeMBeMGXQTTJZxH2ZgAymlnj+MGDoaDoiPx34Te+2ZLVIIVfQ/RABm
 yW9lrdY05qr9fdA27hUNm3tuWKKFbPh13eN1AQoLhSboIx4CZxBUFmxvwRqEPcIh/aah
 9472u/nFaolV78KtCf4+hQ2UgdLM0jnTBQd7fzwnvtFId7OkKdExgDHqSWpkVxmtpOct
 O6CnJMGowQydkdtFbWSM9l7l7Cd0yrcP6ttTn0a46xzP0MI6doSnMfoR/W8GMoXpQ8/H
 akkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750865953; x=1751470753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LPo3LwibQNA4bqfnD9JnU/Mbz8cRLmcm1B4DsfE4S0w=;
 b=PZZkbpxgm7bVZVDMDeCSRCk/ABp3PavpM7rayFDqvkpA3OMQ993yW0EB+r+hUdFt6G
 4d1ZzPhL8OiiIUNnEj6dhzcMvOjRgX3HTvjUu0DdWcRhI85fyenHBqOaDVQMG+9IPaAZ
 fOLBmHzyCKN93hic/dSnZM38zkS33ekXNzbwBSPVPq9RZHF1HDbnw/jJ/1Lg7+x0YCQ9
 r3LeBhrTQadCYokYwrMDebXgoumlLsCdC5H9VfSuoCbITNxRTnyGtwLTufce8nWAsUvJ
 x5zlAPqJ44pmVJ30KSP5pSmI709dBiMdU4Aif8bdyyupy2+aa+4OMAVEdb8FMk6s+PyL
 ih6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuzMi35gePH5tchxIWQXxR0oNl1phbIL8p4WbacM0GXoAmyEh45dY6IXNbuGmRmd0cJG8zBSg=@lists.denx.de
X-Gm-Message-State: AOJu0YzvIQsEqZ5RQE8aLJUu5GcJhjWJ0rnGPi77+BCsZn2G619s5GAz
 6qXGI6qZxB4eNPVEnzgzexJeDy9f1z7D/HVvLSpfGiQE0jhrb4yr17pyIn2R3MGOv1c=
X-Gm-Gg: ASbGncvtDrwPQIN/yzFt4mJmVShu6mjf1ZaYBQe+ywjRvB2SSYYyK+HTViTaJPHZwyN
 jeDinTjgYqKJV+t/k5Nv8leWh+2sww3rMk7wU5RbRz7mMl0UD2lrpMP4ftL7DDw+ctoncie55mb
 F9e0RyjaG9mEUGbt9ShxsueqIBGQfwPwWjpXL9c2K3dsmUVOXVh7pCnkv5dSwb/xD9feencGmsf
 JBV6LiJo5025qxnPC+ImcFpovkOTfmIQKjTZTC9rYSPXCO1oJ/WNzMLbOKegx2HQ5xuRX5lSZXM
 PIQCqjndgbtgr8ynb7TlF87apn8iM8Q/FDAmsbfPg7Gc468dGpYFSGB8THCinkRAPR1lBGZiONN
 ueAl77dvvAt0iOpG4Ee2zC1ZwZTzTiru5HI/49nE=
X-Google-Smtp-Source: AGHT+IGNaW/YOJ3LFZiRjwye7beBUG/Re0ywhFju6f9C6zIet2Al/+VUBuf+GXHDpIoQdGjfchAa7g==
X-Received: by 2002:a05:6000:230d:b0:3a5:14e1:d9ec with SMTP id
 ffacd0b85a97d-3a6ed65d1fbmr3110567f8f.51.1750865952631; 
 Wed, 25 Jun 2025 08:39:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5?
 ([2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f2670sm4864397f8f.49.2025.06.25.08.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 08:39:12 -0700 (PDT)
Message-ID: <fd870e10-079c-4782-a6a6-684fa4d3a752@linaro.org>
Date: Wed, 25 Jun 2025 16:39:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: abootimg: Prevent use of unintialised variable
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org>
 <20250625144340.GP4003484@bill-the-cat>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250625144340.GP4003484@bill-the-cat>
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

On 25/06/2025 15:43, Tom Rini wrote:
> On Wed, Jun 25, 2025 at 12:15:53PM +0100, Andrew Goodbody wrote:
>> vhdr can be used when not initialised so detect this condition
>> and exit early to prevent the problem.
>>
>> This issue was found with Smatch.
>>
>> Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   cmd/abootimg.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
>> index ae7a1a7c83b..6065be9de6a 100644
>> --- a/cmd/abootimg.c
>> +++ b/cmd/abootimg.c
>> @@ -100,16 +100,16 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
>>   	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
>>   	if (get_avendor_bootimg_addr() != -1)
>>   		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
>> +	else
>> +		return CMD_RET_FAILURE;
> 
> Do we need an unmap_system(hdr) here as well?

Ack.

Andrew

>>   
>>   	if (!android_image_get_data(hdr, vhdr, &img_data)) {
>> -		if (get_avendor_bootimg_addr() != -1)
>> -			unmap_sysmem(vhdr);
>> +		unmap_sysmem(vhdr);
>>   		unmap_sysmem(hdr);
>>   		return CMD_RET_FAILURE;
>>   	}
>>   
>> -	if (get_avendor_bootimg_addr() != -1)
>> -		unmap_sysmem(vhdr);
>> +	unmap_sysmem(vhdr);
>>   	unmap_sysmem(hdr);
>>   
>>   	if (img_data.header_version < 2) {
>>
>> ---
>> base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
>> change-id: 20250625-abootimg_fix-51600dc8356a
>>
>> Best regards,
>> -- 
>> Andrew Goodbody <andrew.goodbody@linaro.org>
>>
> 

