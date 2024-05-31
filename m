Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B04C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C21882F0;
	Fri, 31 May 2024 15:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="joS6Bsvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2643D8831F; Fri, 31 May 2024 15:34:18 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B0988246
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e95a1d5ee2so37073231fa.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717162455; x=1717767255; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVq+1W4xC7tipzTC7LwEth+9OEBNLh9rkgtP73Q4QK0=;
 b=joS6Bsvf251EiIDX7ZHEZWYBtOkGdT+Z26LPLSTkgB01YiQ7OJKmVAh1Y/lsINOIm/
 pw9iU2subERRX5Md9zUIFyMjAg7jLN4HNw0VSJ9pYTcBvi/SZM1KTi7So/OL0Jwofw6u
 UHo/Gw3uktmgIyroJvo+iVIafWElnMihUZvXQE+ngI/NHJp9JgW3vBQXrw9SdEfc7BN+
 qDJHo+8S+SyKIA2lsrJEkHLTmZxzwv4UxSimVxVcyX3ILWq+9pd33ZsUQs8Vsxs4H26s
 xNANp2669peImNuFIvI2MQ2WZwBCgxNd4m0qQl8fhYWY1+sjovrRCUAhNPWmH2SzdlHZ
 bZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717162455; x=1717767255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVq+1W4xC7tipzTC7LwEth+9OEBNLh9rkgtP73Q4QK0=;
 b=Ponk6sFQy62VJB+cn3i7cbXjzZyG9tTIwjM91r5VHgIHDIsA1DpSO5gfraCGQaMOX2
 4TnVLMxEMWqUGITiO9FHTnZZ1hkexDQ/kJ4SQ4HXKrwSbUWYZqn+hGsXq/WoZFder8fI
 2dFbTsOQ0bB/JC2yu9HIWHq0a6vF6V5w2tleGE06OhBv0rKVixxbBwBeMb8ywIfKsJcc
 IQ/BWAE5X60ja1Rl1tA4rMQMXfSjR5s6B3BROuqmPMrwCJiCu/BWkk8P/kFAYIVziqZK
 pbX0mwcMZP7BMuSUzRP7k3Fs3/QeYCfEACwSwCAbiSrQJim9KpMpIYh3beiOiIVFLyHb
 UaOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7BTnaQxKgGNcyIuSzhILCPeVB1D25IWJ8dQCy32snfhG7/t6Goh3HYP8Vzx3JIhf/4z/fkDtxn+DHCvFSQDvRCXQ0QA==
X-Gm-Message-State: AOJu0YzHMHL6UepeWL5c+6YBAeTzmzjNcg/14oq8uyq9300XD3dwDT30
 qetMhOObaXm+W2mseXbcwPO2KtyYrvNlHOP+L9QtZbj1annBD2qZ9g7fFzzG6ik=
X-Google-Smtp-Source: AGHT+IErtYFurUYLIphpNl+v/HnGyXJ1DQ1ORld7upZLAUreWORgpvrcO967b5EK1teedsJAdPd8+g==
X-Received: by 2002:a05:6512:3e24:b0:52b:798f:cd7e with SMTP id
 2adb3069b0e04-52b89521852mr2069874e87.12.1717162454972; 
 Fri, 31 May 2024 06:34:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::ebdd? ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea67b4f8sm87431866b.102.2024.05.31.06.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 06:34:14 -0700 (PDT)
Message-ID: <353ca842-e9d3-478b-a7da-33570dd3b7ec@linaro.org>
Date: Fri, 31 May 2024 15:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] tools: add genguid tool
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-6-c26f31057bbe@linaro.org>
 <CAFLszTgtJi+QE4Ry70jDJbqg3rgTMXEqbt-RROQ1kQwR1Qv-Ag@mail.gmail.com>
 <fd581f3d-00a9-4389-a9e5-e1fb8b5b213a@linaro.org>
 <CAFLszTgWPikh3VA6VvvQc6uuPvb3MZL=E37mUB4Ng7STJeUBTw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgWPikh3VA6VvvQc6uuPvb3MZL=E37mUB4Ng7STJeUBTw@mail.gmail.com>
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

Hi Simon,

On 29/05/2024 21:45, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 29 May 2024 at 13:02, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 29/05/2024 18:30, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Add a tool that can generate GUIDs that match those generated internally
>>>> by U-Boot for capsule update fw_images.
>>>>
>>>> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
>>>> with the board model, compatible, and fw_image name.
>>>>
>>>> This tool accepts the same inputs and will produce the same GUID as
>>>> U-Boot would at runtime.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>    tools/Makefile  |   3 ++
>>>>    tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 157 insertions(+)
>>>
>>> Where is this tool used? Can you add a man page and test?
>>
>> It currently doesn't have any users, it just allows for pre-generating
>> GUIDs ahead of time for a given board. It might be hooked up to vendor
>> tooling or some usecase like that.
>>
>> I've somehow escaped learning Groff before now heh, I can give it a go
>> and write a test.
> 
> OK (just copy bits of mkimage.1 :-)

Right :D
> 
> Re the test, would this be something that binman would use? If so you
> could put a test there.

This tool is just a wrapper for gen_uuid_v5() which we already test in 
the dynamic UUID unit tests also introduced in this series. I don't 
think it's necessary to additionally test this tool.

Kind regards,
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
