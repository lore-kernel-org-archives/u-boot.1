Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC86C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3501588063;
	Wed, 20 Mar 2024 21:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AgijC7I0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A155880A6; Wed, 20 Mar 2024 21:21:39 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E161088010
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-512f892500cso358412e87.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710966096; x=1711570896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PW9iB6V8jVFEHUvp+OGuEpZob14Gus4npmv0ijcd8HU=;
 b=AgijC7I04yyJ8wuCy7ZKBFRzpMbWHz8w8JqxhSZDrBUm8VN36uZroEK65e18JGyeY8
 NwXjZYbIWU9YeAbvpZfezwEmcP46LBnVKezid+XYprt8NQt69csJYv963r58KxYHp+rm
 rJyxkGG2VOdgxUQze8EXoO8pNWiFea7OQ37C6UcjvRw6Zy8ycrXsZD/ESsIUeL5vFMT6
 ldaOT8ddzN6Nu6W3zyS7QJit1DlCC+ae4yeiXOz+eIneIdqqneVq0iwT0QrYSM5nv1Xj
 er/vt6XCmF+5iaYInn4VQUUqX1ZsKJqmy0ibLf2psN0yAIBf0m1wQbAIxUC9Hu7wvX7X
 xK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710966096; x=1711570896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PW9iB6V8jVFEHUvp+OGuEpZob14Gus4npmv0ijcd8HU=;
 b=QzfdmU0DmquF3nHJCzSnunLkvyUaizDgyyonhWmttpfG66e+x98bjw4ZldOrJF+3wW
 Bs4ntyPhPLZhEC/U4WsQYvWI7WHXQttKgbUpFd5Y/wxiGxIOYCCeI050CPuUO57fL6ea
 O9eEbPPHJE7GHwo6hm5iSLR/Offh+sVpkSulprlmzjIRwWk5EjocWUjNUL0YDavw3kpz
 ld9L+g4p4bBivgjtgQmy4/zZO/w88e7Lv0v2KMhQ7XOiRsTex5b0fSk9+rkITMQrdNIx
 52QtDNjzamAhFLoK5iuAc6rPMWReOtXhmjU02xWkL5PPFllXZUI1Ck0Q9GGC699pIX46
 OMNw==
X-Gm-Message-State: AOJu0YwqNwVUEwTxtSrs35tPV7MrGJ2VDsD5cInb8TDykTtlYbYR/yY6
 V9xhKrbmptVpItBKgXJRFPc7TLjU+B7Xq0ilZqZiXGXpFngbJjAqN5Glx74KPfQ=
X-Google-Smtp-Source: AGHT+IGrArLT5npXLfDcgKyM4td3r8ODUGFpEaJjERTnEHqe0uVBgG1TJiLHBgAEzKZT67ZY+TAeFQ==
X-Received: by 2002:a19:e05a:0:b0:513:572f:88f1 with SMTP id
 g26-20020a19e05a000000b00513572f88f1mr127211lfj.27.1710966096024; 
 Wed, 20 Mar 2024 13:21:36 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a056512070b00b00513c79048ecsm2339482lfs.273.2024.03.20.13.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 13:21:35 -0700 (PDT)
Message-ID: <6874ae11-0192-4e05-a79b-782d7c002dcf@linaro.org>
Date: Wed, 20 Mar 2024 20:21:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Qualcomm DWC3 USB support
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
 <eae25ae3-1b3c-486f-bf08-1f8aa1461360@denx.de>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <eae25ae3-1b3c-486f-bf08-1f8aa1461360@denx.de>
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



On 20/03/2024 20:01, Marek Vasut wrote:
> On 3/20/24 3:30 PM, Caleb Connolly wrote:
>> This series enables support for Qualcomm platforms in the DWC3 driver,
>> adds support for arbitrary sector sizes to the USB mass storage gadget,
>> and fixes an issue with the CDC ACM driver where it wouldn't initialise
>> the USB device.
>>
>> Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
>> makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
>> gadget mode.
>>
>> This is part of a larger series enabling DWC3 USB support on Qualcomm
>> platforms, a feature branch with all patches can be found at [1].
>>
>> [1]:
>> https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-livetree
> 
> Since this is mostly gadget and RB'd now, I think this should go through
> Mattijs / dfu tree.

Yes please!

> 
> Thanks

Thanks all for the reviews.

-- 
// Caleb (they/them)
