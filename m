Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4614FC83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 09:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD7282103;
	Wed,  2 Jul 2025 11:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kj4kl7nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E9F82B18; Wed,  2 Jul 2025 11:18:23 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C3380E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 11:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso34106295e9.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751447901; x=1752052701; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gP1aB/ueEivbumnnkhb0d7NKetZjFuDtzPF6MMJPljg=;
 b=kj4kl7nWs0gPg1iGBh56Hk0Y6hum8ofPm9K6kY0KkCsF03EicY/Q3fpHY6A0slJS7c
 QU14qb804VdrKDO7Z3dGY4fVWBXd+F794M+IziawA18QYL2dAnoMg2ayONhUTFV2ZrqM
 2KTpuEgc2usmN3DKrY2N9nD6pHofM7c/BNoRChm57amyCjNqhHQeDvQymvJIoIq1qCly
 0+I6yxkeGExfa/rcXw8Ec6SFYU2BQVY+54JGAW5O95apHaxWqbyoKEc2PnrC/IFZadyC
 iWwBpoEp82Dc2mxzu0hIscIAUlUaXF2xsOoXR8ue7247gGlkFp/Pa+2z0zvwp/j7vowe
 fg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751447901; x=1752052701;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gP1aB/ueEivbumnnkhb0d7NKetZjFuDtzPF6MMJPljg=;
 b=aaono7NWN+GyK5XTIq6Kxf79sOlcnfZmOApX8BaC1UJO+0/+RYh27zxumQ9boE8liO
 zvi5x5yPnuQjs8kg0h1lt+vxavUWkWX8P4fiY1T0wCwu7fsxh9nfXq78ISUymODWe02V
 eXetbAsYcugW1CzqwH3PPM/QNbgumAMuAkw7RO3xtx4im2zJfpr0rMXgEi+ruaWoXvWZ
 aYwBBjgYZzMXBk08YZHC/0Mp2WOlhYPtfy/UyoOq5BeHsNQJLxg9oBsXvgCp12YujMej
 kSVXFY5xhvEsQEAu6Zef+Kgnst2BL/FGP22bZlKQfk96xdcmN61B58Zj0ZQWomu4JbHP
 2fFA==
X-Gm-Message-State: AOJu0YyxOrTZMSaHNT1/jUq9FMMjY8ITqNtpu25MPNnV02CzVykgisg/
 wyD9h/1X02U4KtgHvW9yoUB4xqo+HkZZSiT1rZDBcY6TY4Nqx6kTP+zM/o780Mjcvy4=
X-Gm-Gg: ASbGnctJmxHKc2vWYdD1vjMsKUWIbd93z5rp+V/P/drsOhipz0z8ZIunqcMf+MDcOr3
 IGtOhVQbcYi/ZXw0w/0S3z6oLYqSITMibrZc0XcPuBtaxzmK+W5zPdRGGiSzNqJHWfFHr7LoFw4
 a9Lb62l7r4IsOqwu9kSkSJV9R4UCYXP3eLcTjdYKwMDqAms1En5WHNXLZhzXYSfEtPw8TnAZIPj
 TPXUXD5W/ZXYDJw7l7E3AMjLRdRhzDPTU4RXLZCmC+kA43297e04tigY2AFtI0t2zNBSFOqw1Lc
 1t5wHGYg0XZ08xblpuB5Gm5e150+jJN17nShO3DtGvtBo8r06lZDwdVIacIWHNeXUJYvvUFPl+y
 CV6uSAlljWVDEj5eyo3PhbOVbjPUic7o5i+loISg=
X-Google-Smtp-Source: AGHT+IFE2AsEFblpqqUI3GRYDLJplJvH1dqDUKWwJhFEt20IjSC14VVmztf/qd4+0hIjqxiFkKVgpw==
X-Received: by 2002:a05:600c:8212:b0:43d:45a:8fc1 with SMTP id
 5b1f17b1804b1-454a36dd789mr24908845e9.4.1751447900816; 
 Wed, 02 Jul 2025 02:18:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30?
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a5599sm196190115e9.13.2025.07.02.02.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:18:20 -0700 (PDT)
Message-ID: <bc0d6906-c1a0-457d-900a-769f5186723c@linaro.org>
Date: Wed, 2 Jul 2025 10:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: menu: Do not dereference pointer if pointer is NULL
To: Tom Rini <trini@konsulko.com>
References: <20250630-scene_menu_fix-v1-1-9ccb9a49c4d8@linaro.org>
 <20250701204042.GD523899@bill-the-cat>
Content-Language: en-GB
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250701204042.GD523899@bill-the-cat>
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

On 01/07/2025 21:40, Tom Rini wrote:
> On Mon, Jun 30, 2025 at 05:06:07PM +0100, Andrew Goodbody wrote:
> 
>> scene_obj_find can return NULL but this is not checked for before
>> the return is dereferenced. Add a NULL check.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   boot/scene_menu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/scene_menu.c b/boot/scene_menu.c
>> index 17150af145d..9a6e37d1c64 100644
>> --- a/boot/scene_menu.c
>> +++ b/boot/scene_menu.c
>> @@ -508,7 +508,8 @@ int scene_menu_display(struct scene_obj_menu *menu)
>>   		return 0;
>>   
>>   	pointer = scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
>> -	pstr = expo_get_str(scn->expo, pointer->str_id);
>> +	if (pointer)
>> +		pstr = expo_get_str(scn->expo, pointer->str_id);
>>   
>>   	list_for_each_entry(item, &menu->item_head, sibling) {
>>   		struct scene_obj_txt *key = NULL, *label = NULL;
> 
> This is in a slightly different place in -next, and I think the whole
> function needs to be read and corrected for error handling. I think we
> then will need to initialize pstr to NULL as well. Thanks.

Hi Tom,

I will rebase to -next and resend. I also added a NULL check for str but 
I am not sure what else might need doing though unless you have some 
suggestions?
It looks to me as though pstr is not used if pointer is NULL so there 
should be no need to initialise it?

Andrew
