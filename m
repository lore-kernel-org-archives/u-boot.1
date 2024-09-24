Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6E1CF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 11:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9422D8843A;
	Tue, 24 Sep 2024 13:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IBJOaIfQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B6E8855C; Tue, 24 Sep 2024 13:30:17 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9814E881C1
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 13:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so35427235e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727177415; x=1727782215; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8rJ7RoQxGSR6CKX20stpjt38ozXj8p0AF3HaGil1VAc=;
 b=IBJOaIfQk70K26Oit999ND4DK+ZmGBM55Gb1i2wbKud9/SZw0VKQBYGrt3cEzWOGZb
 fp+iSRL498VPD3PZqyDhJxbwxkPxiPdLvBtefASXmIS67IQdIBPRNSjTopncZ3LLRcda
 SAPbKJsHflMFXE06zFVN30j6BOB8nj4x6Z3UwotWc71kwqzMDTvSBz1SYoeCKhAsab74
 6WZFXgmu6DWDk/wvULBXvf0E2VuLc/mw8oVZQg3QvMVQvYeFUtfFYCCOGGrcFE89iaW2
 9AuZuDWNn50hKP55xmTPXaRdrWP07B3X7wl7ObmHToSoErZWyLL/I4IwiK3xcK8KIRBw
 1R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727177415; x=1727782215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8rJ7RoQxGSR6CKX20stpjt38ozXj8p0AF3HaGil1VAc=;
 b=EbPMPVqD1BwJSkAOTCpzGlQH9ZcIdjDJIdRlAp5+pyNnliOb9JQRxKACDA7OH+IS8L
 QyTk96WhyCLCmP7dG5qomIbIaq5tfhOGelSNFEUv2wLy/y/ADmQl5rQFvCsJeY4Lq0gN
 KQA9/dFVuDQ4wZ/bgnphmozd279aoHTJcapnZrkKxmX9EsokqRU0KRh+Tmc2iOBvz/vb
 AtncuduFl3eVtjYMUrxcFyWDU5XVN9mM+P0C9KoNGhpRK2qe/NAAQOwcZnkXnp7VJ1HV
 iYKrGQW3swlVmAiGUgkVMTxivqxhKaPX3/xcGo0tke+k5Uw6N+be/jv/aNUe2nN8MnTo
 JzEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtd8wbhADh82zKCzzO/nO+2SKwrcfzhzW/M9boNaowrJEqJDDw1/BqEdJDuaguBxTILt1ZDqM=@lists.denx.de
X-Gm-Message-State: AOJu0YzPzhyxIpwcOesW5Qn49PPQj01WLAToOHVsJvlImde7DsSorjUo
 bqd19GqrFrihgpUexWai6lG5lj9NV5qhbttqQGqeQQf20VbLOn8eB0nVLo4hMgM=
X-Google-Smtp-Source: AGHT+IEHh3hMInWpMXiZq0wbwmSIxf8ZvL2t1lYV2VghyNoL5eU+Nq1/Vd4f8DvmU3KtZihip6tSvg==
X-Received: by 2002:a05:600c:8718:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-42e7c1a2685mr102018815e9.29.1727177414760; 
 Tue, 24 Sep 2024 04:30:14 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e9029ef29sm19082705e9.28.2024.09.24.04.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 04:30:14 -0700 (PDT)
Message-ID: <d9be0378-2882-44a0-ad46-7b2c73bc8e40@linaro.org>
Date: Tue, 24 Sep 2024 13:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
 <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
 <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
 <CAFLszTh-5o8hEv47+jb2od=xQxMhjOGpG0qC_PjL5XkLx5nM2w@mail.gmail.com>
 <20240904223230.GC2479150@bill-the-cat>
 <CAFLszTj0joALRDNjoEGkt99QCACZgLiOZbMTJoJK3_JzGmtLSg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTj0joALRDNjoEGkt99QCACZgLiOZbMTJoJK3_JzGmtLSg@mail.gmail.com>
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



On 9/19/24 16:14, Simon Glass wrote:
> Hi Tom,
> 
> On Thu, 5 Sept 2024 at 00:32, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sun, Sep 01, 2024 at 02:09:43PM -0600, Simon Glass wrote:
>>> Hi Ilias,
>>>
>>> On Fri, 30 Aug 2024 at 03:27, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On Fri, 30 Aug 2024 at 03:59, Simon Glass <sjg@chromium.org> wrote:
>>>>>
>>>>> Hi Jerome,
>>>>>
>>>>> On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/29/24 16:05, Simon Glass wrote:
>>>>>>> Hi Jerome,
>>>>>>>
>>>>>>> On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
>>>>>>> <jerome.forissier@linaro.org> wrote:
>>>>>>>>
>>>>>>>> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
>>>>>>>> NET_LWIP so default to NET in this case.
>>>>>>>
>>>>>>> Sandbox needs to support NET_LWIP.
>>>>>>
>>>>>> I agree in principle, but AFAICT it is not a trivial task. Does it have to
>>>>>> be done in this series or can it be dealt with later?
>>>>>
>>>>> Does it build OK with sandbox? We use it for almost all of our feature
>>>>> development and testing, so I cannot imagine bringing this in if it
>>>>> doesn't work. How did you develop this feature?
>>>>
>>>> sandbox is deeply rooted into the old network stack. It fakes ACK
>>>> responses, handles the ping request/replies with the sandbox ethernet
>>>> driver etc. I was looking on adding LWIP support for it, but it's not
>>>> trivial and I don't want us to add another hacky 'glue layer'. Since
>>>> LWIP is a big feature on its own -- and is working on real hardware
>>>> and QEMU, we discussed adding it, so people can test and contribute
>>>> fixes while we fix sandbox.
>>>
>>> At the very least it needs to build on sandbox.
>>
>> It builds with sandbox, one of my tests is to switch the global default
>> to lwIP and make sure nothing blows up.
>>
>>> I am not sure what tests LWIP has. The U-Boot networking tests are
>>> very simple on sandbox. The test provides a handler to generate a
>>> packet that it wants, then does a networking operation. It should not
>>> be hard to plumb that through.
>>>
>>> I am nervous about this going in with an intention to fix it up later...
>>
>> We have two flavours of tests. One is the sandbox-specific state
>> machines, and the other is functional testing. This series passes
>> functional testing while adding another functional test (for wget). I'm
>> quite fine with having sandbox figure out lwIP be a later TODO.
> 
> OK, well let's not leave it too long. It makes tests nice and simple
> to write - just a function that can parse and generate any required
> packets.
> 
> Also if someone can answer my first question (what tests LWIP has)
> that would help.

There are unit and functional tests in lib/lwip/lwip/test but I have no
idea how to run them and even if they are run in some upstream CI.

That said, NET_LWIP is functionally tested via test/py, more specifically:

 test_net_dhcp()
 test_net_ping()
 test_net_tftpboot()
 test_efi_setup_dhcp()
 test_efi_helloworld_net_tftp()
 test_efi_helloworld_net_http()

Regards,
-- 
Jerome
