Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56317C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36DC88619;
	Tue, 11 Jun 2024 11:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HV9igveP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A212B88660; Tue, 11 Jun 2024 11:56:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B167A883D3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718099783; x=1718704583; i=xypron.glpk@gmx.de;
 bh=T6U8AO2jf+SRIpj/+vsSvyp7l5P9WibL2qt3L2M38gk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HV9igvePINzCEThLGZndwusaczw9j7FU4rHRXQylyezjjjCZgzs9b48l3VkbpC+Q
 5bVnUy2hBuXYYFeYVcOaT1TinuTaRNljwqdHCmaTxmeXwndBuvZlxDMXlQHwydfja
 HIW9qtfPwWVWGYleCqI9k4Q00/zyLpZp2p8EdUADow66qp/BsvIemzHMMN2ASzs5a
 bZsrjki1NUTeoHMoEpSg6NFE3qENiwIJtoaLj/PmoZ1LSCkHRfHJ5kqB5EzhEviV3
 BdBLMUzNbckfFIkUAjDVUVAq99xrbogDZQ4/7pKPD/KvfsA+Fb3udlLI9rw2ZUbB9
 QroegBsi7R1vr7vbHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72sP-1sL3ub2xDT-00799S; Tue, 11
 Jun 2024 11:56:22 +0200
Message-ID: <f490a30f-046d-4bb1-bbc2-5820f4623ca1@gmx.de>
Date: Tue, 11 Jun 2024 11:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
 <20240610174450.GX68077@bill-the-cat>
 <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TYk/4/1iwuSKJcON7Yc+YGJQlEaAqGSgPllQlrrewZq3XFM3tPS
 xoRlk8Z8O2fZ9GUdvCv1gIAdUNLZ8SSmfDNvMw2plRhHWZ3XhqR+YaA+xNe4S9Y0hmqDxwB
 bBrV2ij/PjE4bzwj9bgdGv1rmfoI6xR3e2NFUOyQdrnw3w/fO7MKvKVdG7erscdrwAfURSs
 MgSTQ0a5A/9PMkEhd656g==
UI-OutboundReport: notjunk:1;M01:P0:J02A0WzgP3M=;OV+fiDA4Y87/uPBXu6Ecos+DTTv
 wxuZj8tQZSQXOK3CUfkP0oqtyeKQ2mQWmWvqXf58z9aLr42yst7yxwnggeXb4cX1ZCKlAjHqN
 DRDtOFBFOJ3mPvFj+/haE+rnPUIh2FDuemqTk2/Fn2vFD2e9GxkOhaNMsGXFUr4v1mqldqg5V
 eGbWcVy8tq7FD423OwFRyK3lG7mP8k5dRGjYBW7VjrfzjkpmHlU9fmhnB3Qu5gIpuFqtD6O7b
 eA0pPvYfwsQaFCaZPKIxJ7q42yTQWKhpOQTJ6f7wiMKQk1RkCY2QLQQbgumrrhrWPMb9izTuA
 3FadxXGIbJm9mucFYIYC5CEGBgWeokPf/wuirxLLLQCvbyCEFCg8IeaMOaVdE0ttNH1F70x0t
 Yv4zpQcqFBJvtJRiH/UBc20222he1v0UHjaVqC4pXFIaiMlXs0iK4JitP/yTnqIPbQPG5w8j+
 qh1DYQPR7oWttRfv+tgfvCzNxXXx5nUycqLQB284mofiMEvEBD9ONoTfrhSDuOECAlqvtGVE+
 PD0wFzqtCXcBvVlQr6Uan/gBeG8tvbcMkG05Pk9tKRTHAD3NXcQwRVhbxnl4jzv/C/Rww2Svs
 qvXWVF+NebL6pufYXURqByc9Zr2EC4+siy+HANcDiSnSoPxBLFLt3JxuI2HzNXNewFdfMICtM
 4jq7FQdsdu/KP33mu4nAHrHJ6lCddStChRhoKe4qDGrzebMn/jBoxqvKHZQJHKsaPbzAWPv/O
 1JW2zrEzqItnZle7MO5yztvr2ka9y4endjkyjsc4GLJRsu2kq2rfZLygkHRiX6osftrXTPPtG
 INKAgJ8QI26TwfQ8rYX0eF+MyFDpvJsc4pcoac3X/z6PM=
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

On 11.06.24 10:55, Sughosh Ganu wrote:
> On Mon, 10 Jun 2024 at 23:14, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:
>>
>>> The LMB memory map is now persistent and global. Running the tests for
>>> the LMB module will result in the memory map getting reset, and this
>>> will have side-effects on the rest of the working of the platform. Run
>>> the LMB tests only on the sandbox platform, which is meant for running
>>> such kinds of tests.
>>>
>>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>>
>> I'm not sure about this. We can reset real hardware as often as we need=
,
>> too. Did you run in to problems with this test on non-sandbox?
>
> But do we want to reset the state of the LMB memory map on real
> hardware? This was working up until now because of the local nature of
> the LMB variables. But if the LMB memory map is to be persistent,
> should we allow it to be changed for running some test? That would
> have side effects? I think running these tests on sandbox should
> suffice. I mean there isn't any aspect of the LMB module that is not
> getting tested on sandbox, right?
>
> -sughosh

We should run tests on systems with different bitness and endianness.

As the LMB test does not rely on any sandbox driver we should be able to
run it on any system.

If the memory map is not usable anymore after the test, the system
should be rebooted.

Best regards

Heinrich
