Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1649EE4991
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922988927F;
	Wed, 11 Sep 2024 13:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726052765;
	bh=dIafNyfdH+D3rE5yuoGgBMTIC6afSNg9ySffpxDqDeM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QXrkMFD/4Yw6me+1ExJetSsSbzjLjGYTNXqauegcCNFmJkeAS+oKRsewqtqyfw+o5
	 FNEBHvDrjy3zrlYhfEKUCa86lquKwk74/togjvS9kX96DgWi4ut8H9rhWQbExppnMt
	 s+p3RFf9JkkUSuPOHZ7ZOZ6qLYDdcv85JPuc6930WvkAgk6X6u5d1lND+BNzYFiJ9/
	 wrdNTugnALJlqx4EPeSWth2ZzX6o6ZiV8yCBy2tqJ5gZlk6MxH36qDGusBDTQxcTK/
	 L84VivXCRrwtSbalG4CLv+ikeLFiHLDqv0x93FQKKqY19X5cuhfAGT7qsxYK2jtKsh
	 862C9FJ2JOmNQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1F8018925F;
 Wed, 11 Sep 2024 13:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726052764;
 bh=dIafNyfdH+D3rE5yuoGgBMTIC6afSNg9ySffpxDqDeM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e0aG59i0yMqKoTwKy6NNaWiI3qExVxnEx0kaj6GDFHBHB3Wo6FnxNA17xIFtPle3r
 1HBfwkZsukgvg7vfyvc/R+dP9lgLyuOGzUO5DYXyOkt1ASQ7rpWace19km0ckpp+q1
 Dtr7ZRj8ba7LARIAMdOpFrhTj1zq9AjiK5ZzjVM1UFk2FeAnOUbKG8dNZtvTEQa6tG
 pdS4XbvKhTcWdTMPeQvKnYKCawMdE1p9iRieGbIiMOTVIw6W0q9Zrf3bPyd5S+0/AB
 W6w78QUYWaxgzrijPY1AAIPJf1Cl3m7FG2KydShPy2evtBukLaHHxPttxpfzokhybT
 A/H/AegVdPdrg==
Message-ID: <65ceb565-e84e-4ba1-a11d-7bd0ac98f7ee@denx.de>
Date: Wed, 11 Sep 2024 13:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Hai Pham <hai.pham.ud@renesas.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240304161607.82759-1-marex@denx.de>
 <CAMty3ZB=s5ZNhgHZ2Q8vbzcvFCdO=62xHSY+dAeyr=y3ujkgWA@mail.gmail.com>
 <19a4f9fd-81c7-4ff7-a202-8f0f0c5857a9@denx.de>
 <CAMty3ZD0e1N_AQVOn_eCNkQQusib64QannFfx8Edku57WZWrfA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAMty3ZD0e1N_AQVOn_eCNkQQusib64QannFfx8Edku57WZWrfA@mail.gmail.com>
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

On 8/30/24 3:36 PM, Jagan Teki wrote:
> On Sun, Aug 25, 2024 at 5:58 AM Marek Vasut <marex@denx.de> wrote:
>>
>> On 5/24/24 6:05 PM, Jagan Teki wrote:
>>> On Mon, Mar 4, 2024 at 9:46 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Some Winbond SPI NORs have special SR3 register which is
>>>> used among other things to control whether non-standard
>>>> "Individual Block/Sector Write Protection" (WPS bit)
>>>> locking scheme is activated. This non-standard locking
>>>> scheme is not supported by either U-Boot or Linux SPI
>>>> NOR stack so make sure it is disabled, otherwise the
>>>> SPI NOR may appear locked for no obvious reason.
>>>>
>>>> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
>>>> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>
>>> Applied to u-boot-spi/master
>>
>> I do not see this patch in u-boot/master , was it missed ?
> 
> I missed it, I will send it as part of PR soon.
Is there a PR now ?
