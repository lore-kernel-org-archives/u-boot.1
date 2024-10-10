Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F11CEDDBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 03:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6940F88FEE;
	Thu, 10 Oct 2024 05:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728530970;
	bh=H5o4nWa7/MNMUuCq2MO4UoniTyHAbsRHOasO0/Pn2tQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HrXEsSDMc2S2CN8H04iawqEoGVX9VC4GMwOE7hBDyvz8aiG9AJpcJhXrD/+lSvk3K
	 zQuCAf1/dewUhNBr0xMGj4adexqUNYNrJNUbwbe+JOPKkzVdb9wiK/2m6sfD78HKpG
	 e6niIrmFJrinfNzVt7ENSJDg8raf+F++gkjhehsHxTXxqTAT/dohqfZv+qwDnJJQma
	 TpoQeAd3LWV98rhXctb3mIPLorYSBxMmZ96Y8sCtXTOfVeF+S3jptt0/DYb51zwKKm
	 EDZbyshKZr5pbC2K2CMsz7HOvLGwEUjam2j9NwRomlBOFDeypVbf0EbualNyosgFrg
	 ZrRimUSzDr4Ww==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 96BA088FE1;
 Thu, 10 Oct 2024 05:29:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728530968;
 bh=H5o4nWa7/MNMUuCq2MO4UoniTyHAbsRHOasO0/Pn2tQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Ud+wnmTtJX3jC0UHUB97oVMtHCGbTdogK1WuY3ryru3rQaYSmDtxWus7P92jIOBcX
 ZL+a0jyI+us0iuK1SBF9C1izTQ9hAnaoSIkWLSJ4f80mpMZgHPJezKJqqkJnwPc85q
 t4VUvu1AJfbn78qaSDaItMdCN+gndynYEeyCxSRXlA91aHHsmemOyUrjhsko/w7WdO
 l227Ex5X6QApe6p4WerMQIbDWYWoN2U5MHIpnaGXwv74m98OBKevPgp1tv853qhIwp
 vvkX5dV0ruYvg1zwl6uru8XFONLvXRJvfob+yYsy2QuOmVpH6nUgLSpgkaRTFyG+YJ
 E8CEMLj5vs18g==
Message-ID: <089523ad-83e3-4717-a96a-a7bdf396e956@denx.de>
Date: Thu, 10 Oct 2024 04:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
From: Marek Vasut <marex@denx.de>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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
 <65ceb565-e84e-4ba1-a11d-7bd0ac98f7ee@denx.de>
 <9dd94d8a-0b83-480f-831b-e4bfd4a67333@denx.de>
Content-Language: en-US
In-Reply-To: <9dd94d8a-0b83-480f-831b-e4bfd4a67333@denx.de>
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

On 9/25/24 7:05 PM, Marek Vasut wrote:
> On 9/11/24 1:05 PM, Marek Vasut wrote:
>> On 8/30/24 3:36 PM, Jagan Teki wrote:
>>> On Sun, Aug 25, 2024 at 5:58 AM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 5/24/24 6:05 PM, Jagan Teki wrote:
>>>>> On Mon, Mar 4, 2024 at 9:46 PM Marek Vasut <marex@denx.de> wrote:
>>>>>>
>>>>>> Some Winbond SPI NORs have special SR3 register which is
>>>>>> used among other things to control whether non-standard
>>>>>> "Individual Block/Sector Write Protection" (WPS bit)
>>>>>> locking scheme is activated. This non-standard locking
>>>>>> scheme is not supported by either U-Boot or Linux SPI
>>>>>> NOR stack so make sure it is disabled, otherwise the
>>>>>> SPI NOR may appear locked for no obvious reason.
>>>>>>
>>>>>> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
>>>>>> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>> ---
>>>>>
>>>>> Applied to u-boot-spi/master
>>>>
>>>> I do not see this patch in u-boot/master , was it missed ?
>>>
>>> I missed it, I will send it as part of PR soon.
>> Is there a PR now ?
> 
> Is there any progress on this ?

What is the current state of this patch ?
