Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8F6C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7021800C1;
	Thu, 12 Jun 2025 12:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="buASrV0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D5E82B70; Thu, 12 Jun 2025 12:39:30 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DEA88004F
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so5939145e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749724767; x=1750329567; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgAVfOjlVykqU1GeyYz34sdoGY89nm0c4zWwiE8dIhs=;
 b=buASrV0xSbTY8rp4OrGEg4zXJ91WLXovUq6zefnsyO4QUiZ41zx+t7wrItMrtZ+2Js
 H3W+EQz3hGXoWsDgUShRajgwwJc6xwDGtYB1eDr90ZUIb5PsB95eSJufdL4KBZpojLnY
 ISqTuiA6NwaZNv+rwnO01uYPqZywmR4DUOeEjXLv3OjzloxRL6BQdKZpWL6iIZPeRhy6
 C7pn+XnrEHCMmLktqo/zmk0FswSRRobDnCYUoEw48q5plWDxf/o73jLQ8Q8HQODrMV5Q
 ns8/Cz9MqFJe/UNeI3m9Jrjuiu24KA6XfUXHhzYH1THOwwCFZJUGyC0YTaYoqhYzkVM2
 qprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749724767; x=1750329567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgAVfOjlVykqU1GeyYz34sdoGY89nm0c4zWwiE8dIhs=;
 b=gwVEhfWDiMkDKvQJ8XR8GZLNP5UBxgsUINogvBy1HtJC3QJ98l+ou00vgcgTYMKU8w
 yNHOy0pemtTctyLVJK5ODibwslWsN4tyB3Cy08oCSVeS5larqriu2LoLE6trKMfGcT0O
 +l9uuDjnu2hQ4SqPQfRqE/uETL9syOFZ/DQWdhe3X3a3bx+NInV3Dqf8b8JjLvgDrQu7
 cSt1ayvVltiJvhXuRU4pf9NfHltkCkgstg3jqWzFf5aBdtvfb1WiqW8sfnePnKfpnPQx
 mh+BQ+XeVGzYJDOWeecVjbED1kG7551hgqStgCLVffUv/URtTYQznNTYATHKueMLWPPw
 VO+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6dqksw6qx6/oFnm52CIoDZ9ootCdwqo4gVda66BT3mBz5lsghq0/jZfkJcmQ48fk0lCDNAoE=@lists.denx.de
X-Gm-Message-State: AOJu0YwNWpX0Jckfu7GyQxIdZPLQmiMPwJdyfRfnjHfZ5SGrjciU8kKf
 jAx7PSoSUwAzgzrimByRbU/cavVMn3xBU+sRlvZZURzGtBD16VUiDBTWblHiochNoe0=
X-Gm-Gg: ASbGncvY3HyZbZ0FaK7rs/yLhC0/QLHlvGVuY6/PBuN+iCcHuXuZtkzvc7oli7CkoTl
 TBxCWBBVBIhDpal88S3y6+D05ooxcYQD46rbT7EOLaqFbF+FaxySUipRolfuhnhAKm4TbAo+6Q3
 VdRhCIHPBPoILSTZO5xekS/fv9bAYp1PEYwZc9zT4+xa7gMScSUVge/K/QKKE6Z8U9IO0IVkbvK
 n9oCYLUt4Pu+opfkeFtI4Rsw42tZd35j7tF8R2CpRungGuZ24ySjGktnPH6sv13K0cYTMfWEIR5
 A8FdxmWepvPQMD6jobF0gvK8RWTCBTjSeuh3OLz7S+oaseZxYI1UWaF3ZVVM6y16vLjvJf/FQfZ
 aW4UCW9eTZEytfGb2i4jKZCspohe01jBumGWnSw==
X-Google-Smtp-Source: AGHT+IHn7IvupMBYc0KORMyG2D5Yckz8grlvekNDLofuWwmqH74HYurk/vZLxmLtiTiZdjVaP+sCPA==
X-Received: by 2002:a05:600c:83c6:b0:453:2433:1c5b with SMTP id
 5b1f17b1804b1-4532486c53emr63186145e9.5.1749724767448; 
 Thu, 12 Jun 2025 03:39:27 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1405:203b:89a3:c77a?
 ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e156e8dsm16736765e9.31.2025.06.12.03.39.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 03:39:26 -0700 (PDT)
Message-ID: <b79a5bb1-4f2e-4b08-a65c-8d909c7b0678@linaro.org>
Date: Thu, 12 Jun 2025 12:39:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] env: set fdtfile environment variable from
 /chosen/fdtfile
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
 <20250610-b4-fdtfile-from-dt-v1-2-aec4df0fa53e@linaro.org>
 <33d65ef7-34ca-455a-bf91-11716bae5236@cherry.de>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <33d65ef7-34ca-455a-bf91-11716bae5236@cherry.de>
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



On 6/11/25 15:55, Quentin Schulz wrote:
> Hi Casey,
> 
> On 6/10/25 6:23 PM, Casey Connolly wrote:
>> If /chosen/fdtfile exists in the devicetree and the fdtfile variable
>> isn't set in the default environment then populate it. This allows for
>> U-Boot to load the devicetree from the boot partition or ESP that should
>> more closely match the OS being booted.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   common/board_r.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/common/board_r.c b/common/board_r.c
>> index 
>> 41c8dec8d49ef21a12fd41272581dd94484dfa08..594c7827c39cfca5f4561b4699e5b66de54e11c2 100644
>> --- a/common/board_r.c
>> +++ b/common/board_r.c
>> @@ -448,8 +448,41 @@ static int should_load_env(void)
>>       return 1;
>>   }
>> +/**
>> + * fdtdec_setup_fdtfile - set fdtfile variable from /chosen/fdtfile
>> + *
>> + * This function will look for a string property named "fdtfile" under
>> + * the chosen node and if found set the "fdtfile" environment variable.
>> + *
>> + * This devicetree property is used to identify the path to the FDT in
>> + * use so that the same path can be checked in the dtbs directory on
>> + * the boot partition or ESP.
>> + */
>> +int setup_fdtfile(void)
>> +{
>> +    ofnode node;
>> +    const char *path;
>> +
>> +    if (env_get("fdtfile"))
> 
> How do we guarantee that fdtfile variable is read from the default 
> environment (I assume here you're talking about the environment stored 
> in the U-Boot binary?) with env_get?

I'm not sure tbh, I don't have much familiarity with the env_ api.

> 
>> +        return -EINVAL;
>> +
>> +    node = ofnode_path("/chosen");
>> +    if (!ofnode_valid(node))
>> +        return -ENOENT;
>> +
>> +    path = ofnode_read_string(node, "fdtfile");
>> +    if (!path)
>> +        return -ENOENT;
>> +
> 
> Please add this to the DT spec (and schema) before it lands in U-Boot so 
> we can have some sort of standard here (e.g. Barebox may want to use 
> that as well? The earlier stage setting this variable needs to know the 
> location, name and expected content of the property).
> 
> Additionally, you say this property is a string array, I assume of the 
> form:
> 
> fdtfile = "myboard.dts", "myboard-overlay.dtso";
> 
> ?
> 
> Which seems to be hinted at by the cover letter.
> 
> In that case, I don't think ofnode_read_string is the right way to go. 
> We should
> 
> 1) enforce the location of the dts in the array (I assume 0?)
> 2) look only at that location to get fdtfile, e.g. with 
> ofnode_read_string_index?
> 
> Otherwise we'll have incompatibility with old U-Boot being unable to 
> parse a string array and new Device Tree providing an actual string array.

I don't think this is an issue since a string array in DT is just null 
separated strings, but yeah it would probably make things clearer 
regardless.

thanks

> 
> Cheers,
> Quentin

-- 
Casey (she/they)

