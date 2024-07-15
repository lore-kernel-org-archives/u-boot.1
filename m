Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29676C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 08:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CF988747;
	Mon, 15 Jul 2024 10:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HI7FfkH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253D28657F; Mon, 15 Jul 2024 10:51:12 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD3E88765
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f40bso5010997a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721033469; x=1721638269; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09DxSv7bHnEMIq5CDxX9y0wreXM+3vvhznjIZuiZ7R0=;
 b=HI7FfkH79godWGejCORQ46sJcICr7TLRlERAD9mBWtYEohOgDiE7Oq8Yu9kt9m3di8
 v1+PPmPlK8w34ISUT8m7dNkUYUtJPlIY3tFgtTFxzu/2pMYwNcWcd+CryJJQhzWZhGuF
 pQ0FTHuyze8r3BAlPowKT/Vsf1i9Yh1ejDe7vhV2wLDsDcr7/PFX+n5hUC0F7GBXtjip
 mXDXw+eA++ERuSQz9GG+cBgzTVfXY1p39NE3GIfycy22G3cVh2fsAyYAbhGLULF02Y2+
 6N2HYl7+J9bEU5RM0ANo4mHcZfwMHcHUNN4rCKgejFFaVUOp4M2H2GgLh4yBJiuaSuHg
 FsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721033469; x=1721638269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09DxSv7bHnEMIq5CDxX9y0wreXM+3vvhznjIZuiZ7R0=;
 b=DVUGHvTXXsuJr6imIGmP9aCSiN68oDGrqmQL+c2qn9eyOLbNWt7pxFD03uMNbljrc1
 CTFET/0L6XfeBtaNwIE2xxiDjlfvJI3I8yhRHBOx4OeqEtyZM9AgvkAXRPz7SDAooW4U
 Y0LubmHH7Wd8nQjVLAK27Xa6Ey+/2bw5BJijFCnDFO78sQyHbe5h+f2O0RexT+BpJUOl
 RcESKJItB9jyBwRwjR3Yy0QIG45kJec4PosB2qA8KPAX6ew5g/uIf0EWS91AUuefqmS1
 L6gdDBxnxnztmXYrr7TQ7sNAm/AVaPe1bpwnjzskXa2bHyOMihg43uhpoJqQZ13tlaco
 FEJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUnkCAfbmbNyrXemM5sOjb7GcQmE/iRhPX0yujudtfVwBEItBqgMk2RbB5j2v/Vf4QCzmumpOGRSPHogDjtKAylUAiPw==
X-Gm-Message-State: AOJu0YzgsbKc68seA74yKSj6KAL4T4kPILZUDi5Kv3r4iAVD2vB+sOOy
 kYblVYcchnIbTRnbe5sMvWdiy6FjOfKq7TpEHW/LR97Ezay2OaF5pBrgeLnkzdw=
X-Google-Smtp-Source: AGHT+IGqVfDVz01T5UcHtLROhLqNAJbBX8Q8x7nzW9iOC2bs5iP1FAHfha/AbASskKhlDJ3VUFr3zw==
X-Received: by 2002:a17:906:dc92:b0:a77:cc46:80f7 with SMTP id
 a640c23a62f3a-a780b6b3a9cmr1428006366b.28.1721033469506; 
 Mon, 15 Jul 2024 01:51:09 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eeasm192917666b.71.2024.07.15.01.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 01:51:09 -0700 (PDT)
Message-ID: <78549161-6145-48ce-b088-10af906c0dc9@linaro.org>
Date: Mon, 15 Jul 2024 10:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dm: button: support remapping phone keys
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240714194948.1271135-1-caleb.connolly@linaro.org>
 <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <bea25c3e-3257-4316-b7c7-ec3fa8d5bfb0@cherry.de>
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

Hi Quentin,
>> +static int button_remap_phone_keys(int code)
>> +{
>> +    switch (code) {
>> +    case KEY_VOLUMEUP:
>> +        return KEY_UP;
>> +    case KEY_VOLUMEDOWN:
>> +        return KEY_DOWN;
>> +    case KEY_POWER:
>> +        return KEY_ENTER;
>> +    default:
>> +        return code;
>> +    }
>> +}
>> +
> 
> ....... I suggest to make this a weak function that can be overridden by 
> boards (should it maybe be only defined in boards C file?) so that it's 
> easy for people to come up with their own mapping without having to deal 
> with two people/the maintainer disagreeing with what should be the one 
> and true mapping for that key.

This is intentionally not a board specific feature. It is a generic 
option that does precisely one thing: remap the keys on a phone to be 
useful for navigating boot menus.

If some folks have a strong disagreement about e.g. what KEY_CAMERA 
should be (for the devices that have it) then I would rather propose 
making this all configurable via an environment variable, or better yet 
introducing a new bootloader,code property in devicetree to define what 
a key should do in a bootloader.
> 
> Cheers,
> Quentin

-- 
// Caleb (they/them)
