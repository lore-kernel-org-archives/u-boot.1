Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4112C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 09:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388B888210;
	Mon,  8 Jul 2024 11:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CK+FHE0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A228839A; Mon,  8 Jul 2024 11:42:39 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E70F87DEA
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 11:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so4702317a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720431757; x=1721036557; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pPFgBOg0BwvjqhaIzOQzuUDIJVPwIY9J0BPpaCd2cV8=;
 b=CK+FHE0uQvmgqYbOYxEJEEz5C2btUVTBGGAGzymfL5+Tfc2sHwVW9MH10w5xU1gF5P
 qkMZnJt2en/DB1hxtsxtGA3qXRgbh8CFgnKvtx3urCf08rPWJirmeeRdqt4uuhv8HlP9
 WX0deYQxQqRkqPmMVGYymqgqJUCPB7qDGqXZnFgry3QkEXQwLHvbWT3+rO9VD3lyOGOU
 V+wLSIiA/oq87MJH3L1PLbdcMokXcONiU+Ava0v0+Vfa/kGFmEWNImXfhwlr5UonRQA3
 ap+silu28hbS3ElzhhcjPpfzGwIl2V2r7VDvV1MRiOVgUqwHlwwCnPG4+JsBqWJD4vSs
 rRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720431757; x=1721036557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pPFgBOg0BwvjqhaIzOQzuUDIJVPwIY9J0BPpaCd2cV8=;
 b=IBfT0TJFjw5Er1wRRAz+MPnXo4bxq/6NMvSh5PGuERZ1cVBO0QbJNPPUYmNwsbG0ho
 cyTppUjsI8VGODtuYhDV5ck5Mz6rXH9krbOzqv8wHTXN/6FxAxPLkjo96RQ80b8v78ix
 lbnFyaNQAsDCPZ5O4oFGXYMOMTVy4RYzcWcn0TlGVpv1U/2x20E/1kaACyZ47uVhO+oe
 6NMkIaHQyzf22+IALDvzizPfZgXB0ZDxGzZEXfay5b27lGpqJb1YaMbGdIGw4WfMb8zc
 hvu/wno5unR18Z8MUgp88dsrHjvQXcY0xjXM/vDu7UAOQGCklI+Xexl1Ly6Iv15GtOMc
 thMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6rDM4vGFK0h7muuO9lGFCt1VbGjxWgz8V42CowMg/DrO6pAjhIen19VYltc32aqV6SXZetuNwiKMiuNe3z85HuIWGdw==
X-Gm-Message-State: AOJu0YxqKxS9U00wunGhLTcGU1Y75QrR1rI6HfLQP+nx0ELOEtaLriEN
 0Tc/+jk0oexiuq7z38X7mOiW0DNJYlbxfkt3hK08qtqC+p58quoJ
X-Google-Smtp-Source: AGHT+IGJTVwfxRPLlqsy1KIoSb8jqnFfw/igQQIrxqMOb9EfhE4RP8yDb4xRHk0zohcC0359UuhRFw==
X-Received: by 2002:a05:6402:2349:b0:57c:aac9:cd8 with SMTP id
 4fb4d7f45d1cf-58e5a7e8b66mr7953030a12.8.1720431756473; 
 Mon, 08 Jul 2024 02:42:36 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5925eb01124sm1539068a12.32.2024.07.08.02.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 02:42:35 -0700 (PDT)
Message-ID: <329fefa1-5274-4f74-8d7a-aaf8d2a65189@gmail.com>
Date: Mon, 8 Jul 2024 11:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240705225821.13196-1-zajec5@gmail.com>
 <20240708083208.322f4418@xps-13>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20240708083208.322f4418@xps-13>
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

On 8.07.2024 08:32, Miquel Raynal wrote:
> zajec5@gmail.com wrote on Sat,  6 Jul 2024 00:58:21 +0200:
> 
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> U-Boot environment variables can be stored in various data sources. MTD
>> is just one of available options. Refactor DT binding into a layout so
>> it can be used with UBI volumes and other NVMEM devices.
>>
>> Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
>> I'm sending this PATCH without Linux changes to see if this is the
>> right approach - for developers and (DT) maintainers to review it first.
>>
>> My previous attempt (see above Link) turned out in refusal so I'm just
>> trying to save some time in case this one goes wrong as well.
>>
>> Hopefully the included example (which I really think we should add)
>> explains well how I think this binding should be used with layouts.
>>
>> If I get some positive feedback I'll work on V2 with actual Linux
>> changes.
>>
> 
> I am still in favor of this change. I know from a binding perspective
> it might be questionable; but from an OS perspective it makes total
> sense to deprecated the old U-Boot env "device" driver in favor of this.

Please note that at this point I didn't decide to deprecate the old
binding (using "u-boot,env" for flash device partition). That would
require mixing "nvmem-layout" with "partitions" which I believe Rob
objected to.

My PATCH in its current form just allows reusing this binding with
"nvmem-layout"s which is needed for cases where we agreed to allow
"nvmem-layout" (UBI volumes and pure - non-MTD - NVMEM devices).

If we want to refactor this binding in MTD partitions context I hope we
can handle that at different time if we agree on some solution. I hope
and I don't think this should be a blocked for this PATCH.
