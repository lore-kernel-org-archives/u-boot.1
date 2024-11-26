Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF90D5A6ED
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ABB8961F;
	Tue, 26 Nov 2024 09:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ghigydKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C9889643; Tue, 26 Nov 2024 09:03:08 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F238961E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a736518eso2975215e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608186; x=1733212986;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMOQpomcuAjM7OMIKK4o9zAv9bVdyoTZnabgN7EeIxI=;
 b=ghigydKZjCIljS91maHppo4G7ayyiof34NLKeVgyXEbfB98uC5rOtZIMuYCwppRl6b
 4XspaDwzBSf4Z3RJvc61n4Srwcr/uyMcT4nbWr8RwRczugUZQQOWXto1Dk9rjZP+YIQt
 8wKYQvmnihjMUTEUIlMUtZ/zTAPGHPa063RuNsMtdSbFTpBfLdNuGDiDq0qTcvJ2Y+IU
 WOVu9+IU98F2SaTdZHisUM/POGjQJhSLmu5ETe8e294RPTZ/FLGUefOjHe21glnqU7Yv
 WUjDEc1XjSqgopr9oA2nVPSDWsOFv4TxE7DNDPuM2/TyTJikAKGQ8llFcuFfN3633ESn
 lNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608186; x=1733212986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMOQpomcuAjM7OMIKK4o9zAv9bVdyoTZnabgN7EeIxI=;
 b=Gm/qHj/1grUm6YADgwusIGuk3u5eaAiIdVxo7iqwRUR7V1B+KL0cCYRPSLi1lqOmXO
 yg0KnhyFvw8B/gWW1t0oBAGYENh3IEon5+3TEG1KC+yyalBY4PjKdAGAlReW6SbByzTx
 GtWTdLSf1hT+g8njIhqB77O9DUyrXZrTVTVN0yHzap/t94/WvfbaONYmN5cMO/dhUiL7
 V2KX2+MoGAxmQgYQ1REZwYgcCHFFXMWlvhYDLGeFpVjeCXFbxzSVc6XzHA9vXhbSfzU9
 jpJtbdRDAFxERz0hftIpHXw3Qy6BVMfFqQ2tJiBICT/N7OVmLdkJXqP0AODc6eYe3AuY
 T6Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjyc4Fenbsn9yW+eRvY4K17w0UdZmvZ6kXUGRaSWaGtyG4XVyya5P4mWVGAUtU8jiK33WLmjg=@lists.denx.de
X-Gm-Message-State: AOJu0YxTO8qp4/x37a6zgfAFDLKHnHFOy44EDATxlWYYqkSF/k3iOB2l
 6JjzJrLCCXbfe/xh+xOGKuemW/0sat5LDTzd/cmFghi+pb8f5ivgSg3vDrDchW8=
X-Gm-Gg: ASbGncu7LzyuGjlTPXnhkXnYa+KeakSYqmCSptRhEl9wbNJJ0S4PYFJve8YNKT/IN7j
 6NkERlvoywkh2Nny1Yw/xuhsZ7YWqZJjzRby8qB10cjehckzaFsoMNrCWg6BRteVt6l9LUr18GS
 AHMF+6v503Q1L7fxExWyQswXEG/85h3eL+CUPDuSqcUKJwx5bGQHpS4u4ZGI7dc3HvRk84iRX3n
 C2kSYG+Yt/rMdCjP8Yo+wq9Dx5njUUMCmhDh/QserP1flYgr+O7wXpBIMHb7aeyH1IemUU43HD6
 aJAq+Q2foS/dF28Th6Wbww==
X-Google-Smtp-Source: AGHT+IFAfyvf7aVhTKT5OyuDHDDmDnfWhuuhylU/ootwcvZcJ/YJSXbgyYhhWOBQOI5QgJjr8xG8tA==
X-Received: by 2002:a05:600c:3ac3:b0:431:4b88:d407 with SMTP id
 5b1f17b1804b1-433ce410255mr155896445e9.5.1732608185602; 
 Tue, 26 Nov 2024 00:03:05 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:3c0b:832b:cf30:eeea?
 ([2001:861:d40:ed60:3c0b:832b:cf30:eeea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43499bdfc0fsm96647115e9.19.2024.11.26.00.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 00:03:05 -0800 (PST)
Message-ID: <6b46f8e0-acfd-48a8-a54f-e1e35e572138@baylibre.com>
Date: Tue, 26 Nov 2024 09:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <1809644DD9DF8FC7.18574@groups.io> <87serfbjq6.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87serfbjq6.fsf@baylibre.com>
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

Hi,

Le 25/11/2024 à 13:06, Mattijs Korpershoek a écrit :
> Hello,
>
> On mar., nov. 19, 2024 at 15:16, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:
>
>> Hi,
>>
>> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>>> Actually bootmethod android only support android boot image version 4
>>> and with AB image, some old platform wtill use android boot image
>>> version 2 with AB or without AB slot.
>>>
>>> This patchset add support of both version 2 and non-AB slot images.
>>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>>>
>>> [...]
>> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>>
>> [1/5] bootstd: android: add support of bootimage v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
>> [2/5] bootstd: android: add non-A/B image support
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
>> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
>> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
>> [5/5] bootstd: Add test for Android boot image v2
>>        https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a
> Due to the test regressions discussed in this thread, I'm dropping this
> series from the u-boot-dfu tree.
>
> Please submit a v4 targetting next once [1] lands in next.
next was update so i will send v4 today, thanks for fix on test.

Guillaume
>
> Thanks,
> Mattijs
>
> [1] https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/
>
>> --
>> Mattijs
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#2573): https://groups.io/g/u-boot-amlogic/message/2573
>> Mute This Topic: https://groups.io/mt/109662676/1991006
>> Group Owner: u-boot-amlogic+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
>> -=-=-=-=-=-=-=-=-=-=-=-


