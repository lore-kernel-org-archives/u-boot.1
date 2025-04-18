Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBCC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 10:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A7F82BA1;
	Fri, 18 Apr 2025 12:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ul5e0c8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2351382C15; Fri, 18 Apr 2025 12:46:58 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2045A82B9C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 12:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2aeada833so347446866b.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744973215; x=1745578015; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u3RwhrHG6TPZ1Z+3FT3iKKg5HtHGjAB6Z9KFP5JSiBY=;
 b=ul5e0c8vgr1IkNJI0kRYWvmpMcFuhhypnsHJf0cO+2T1+9iSWfbj2aNDdzRkLgnmxF
 2yalqIueeVgh0a87FTp8LsP/puV4l5PLxqJT56BVEePdIESXdPNlF6SVbFgDH/0bXtGE
 tgyQzvUlvoc+LzbmzW4mUNqh+bMX9dC8PW8gd9kXwSJeTLJDCCE9e3GTtSsK5OSenSfV
 vi/u36FDYwwQIUMbco8w4paFF3UBBTNtEPSIjOPnDs5emg6CDHxUUudylJ4qFTg2Z7qh
 aKNgWuLJVZtnLT75u1tfDhKZ03yJzBmJtwWo0H+4g5CMc507C06b5mWuJFWewzn0lWQe
 UeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973215; x=1745578015;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u3RwhrHG6TPZ1Z+3FT3iKKg5HtHGjAB6Z9KFP5JSiBY=;
 b=HuQEC8HfgqNMBHn8BfEW2i7ulgMaUSlXvh1I66DSIVz7Iqpit2zP5Vp0ijinoETtxy
 5gs6wWFBmzw+DhG7dbgId5Btic3fAq5ye87Cxpe8ZezUsNzUeNemiODN9YR0cqEbg2TR
 h66IvShNoEZqZoQivadM7dpm1uyvgAwfhhoS8VxrAttgOg5oGjZee/rfJWa+IdLQ+wqo
 KbBHPTzCZGTOo1xoPNX01f3YzzPueFtA6HGh9B4zUWqaC90cTXZp++zjvSORdCtcuYjX
 T09UiU0gnURhun3WbfEMr3I6/dGIxKgYrDeNHlDXmqI25fAfa3AbCFw+eeEv/LzTImXs
 qPBA==
X-Gm-Message-State: AOJu0Yy2WKOA4bN31xs/lThPOMtJTOpLEfN681oEKUkrE8bFhF5IrA1/
 RS3XEwQrgSJ8D+7vFtbSqY3mXJjOk/vcFHuD9m7tQQOD8bZEqU5/sr4FOn6CIaA=
X-Gm-Gg: ASbGncuSLCNCbc9BRxeelscTbObtSmEfcuh7FvuV7bxQDh2XNN8DJmKvgvdxE+1RrJR
 GTToWBa8DEQ9VlMzkicbO4unb5ikY6ZHwcAwJoAf9irJorWD9r4mEQsxok6LhZGdiAw8csgH/Wf
 n5mrPz3/lkDvF3kVMD9Gu4Vv0NULvcZZdd+8XtYEe3vkVErBwNBMvNhY0WEciFSQwJ8NOrSWG26
 icvO9i0anZc6f5LmExHkF38+gN3oBv7JL9NsIRZ+e8cU49Af8J4toVIWI/rZhvhaJuqkofo/N9p
 8rxcxhvGTNe803VL7OCFXXd/XY7mu/v0ojxpuFkhZwP3gKee
X-Google-Smtp-Source: AGHT+IGlKwaUGPxeO+1PdCvoQFw26r0EulynoYLW/rygSm+EfAv7aZovH9So2W21R8L9bW6kR0lHQw==
X-Received: by 2002:a17:907:2da3:b0:ac7:81b0:62c9 with SMTP id
 a640c23a62f3a-acb7534a1e7mr169231966b.20.1744973215458; 
 Fri, 18 Apr 2025 03:46:55 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ef48e5csm105797266b.148.2025.04.18.03.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 03:46:55 -0700 (PDT)
Message-ID: <8daeefec-2e04-43a9-a14d-52ef30063c88@linaro.org>
Date: Fri, 18 Apr 2025 13:46:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: Pass bootph-all to the PIT timer
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
References: <20250403151050.3649150-1-festevam@gmail.com>
 <CAOMZO5BT+yfWYab=Ltj5iJWWSGyAj_TVAuHd99RQP10rzauE4g@mail.gmail.com>
 <e0a4f478-f1b3-46f2-82b8-15cd69f83b96@linaro.org>
Content-Language: en-US
In-Reply-To: <e0a4f478-f1b3-46f2-82b8-15cd69f83b96@linaro.org>
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



On 4/17/25 17:01, Eugen Hristev wrote:
> 
> 
> On 4/17/25 16:54, Fabio Estevam wrote:
>> Hi Eugen,
>>
>> On Thu, Apr 3, 2025 at 12:10 PM Fabio Estevam <festevam@gmail.com> wrote:
>>>
>>> From: Fabio Estevam <festevam@denx.de>
>>>
>>> The PIT timer needs to be available early in the SPL phase,
>>> otherwise SPL fails to boot and only prints:
>>>
>>> Could not initialize timer (err -96)
>>>
>>> Fix this problem by passing 'bootph-all' to the sama5d2 PIT node.
>>
>> Do you have any comments, please?
>>
>> This allows SPL to work on sama5d27.
>>
>> Thanks
> 
> No, this looks good. I will apply it for 2025.07 or next, let's see what
> other patches I have and when the PR will be ready.

Applied to u-boot-at91/master, thanks !
