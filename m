Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDA5C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B56D80657;
	Wed, 15 Jan 2025 21:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736971289;
	bh=gEuXCx5ML9WxtkIkKZU8U8rlmgV5Ltz2Ie0gwB/6yWQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jomt2sGuGjpCEjlTuyoZwRSUPXidKvfYwiF9lgUdm7a88z5LLbqdUYkc9YWH4OaIh
	 haEkfVLaLHumDCd00m2B2J4F+FLd7alugUtbXZG8cWIp4tDm4MZKG7foHeuevtgRKJ
	 4g2f6Ql8HLaKwRi/a9sbVublcHDagsCxiaVksPMZzjpbXKvjD1cHyjLYX6/ydKPhVT
	 WLX+kn6nJVbgrh1j5ON1LQuwZASeLksYrwab5ep864G4Ngc9cX48OsUm2yfyg16iBa
	 QoQL6aTC/U2erWAIt5gyTw0yq2Sx6TeNDNS+6BO4YPiPGWRH/meTzGYQkzu5/Q1Pvo
	 fPSy3eQOxMRFg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B3A80214; Wed, 15 Jan 2025 21:01:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9DD680214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NVc53Bbs"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7BBBA1092C1F3; Wed, 15 Jan 2025 21:01:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736971284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEuXCx5ML9WxtkIkKZU8U8rlmgV5Ltz2Ie0gwB/6yWQ=;
 b=NVc53BbslsE4LQWRhshDQY4h+F8NPGdV1Ki4i968ka5PR8/l9neoKw5xxxn/jiUzRmAt6z
 ryoHfR1+WGY2xvEidgt+A5DPoyI460IlXQc4RFICSLXmLBlQDEEKGQo49kyFFtObh3uVC8
 knm9gUz02EH8E9prIPONXlcR2s57fqJChan9Ph+wKtji8ulPrBrVhXU2MZEjlZ9wVD2cGI
 S840V/RESPu4pjByl8vMkDKC4bTIw/ci40WTNug0ivgrHiqmxemJSgPM+/OMzkFopu+/dE
 ZZZmDaUQtgmMSw418eqe6DM1IsTLOzYJzI8UARktCKTUI/v9Ufbk6EtBgYw7eg==
Message-ID: <962d01dd-aa01-43c6-aa0c-8281e04c5d53@denx.de>
Date: Wed, 15 Jan 2025 20:07:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/17] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Tim Harvey <tharvey@gateworks.com>
Cc: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-17-6744df5dc020@oss.nxp.com>
 <CAJ+vNU1xAhYdnoTRLuM6fWa1mQgkLrVj03BsSObtd7NDq9oogw@mail.gmail.com>
 <84b18e4b-cdd8-4767-98d2-ef31167ed6be@denx.de>
 <CAJ+vNU2yL1XBbtg=FhHohR72Wj58Y0wOEpckpzrNJCNUM=Px9A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2yL1XBbtg=FhHohR72Wj58Y0wOEpckpzrNJCNUM=Px9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 6:10 PM, Tim Harvey wrote:

Hi,

> You're right. I have a set of messy patches pulled from nxp's u-boot
> that is enabling PCI ECAM and enetc. With the latest patchset from
> Alice PCI isn't there yet.

I have ENETC pretty much cleaned up, the NETC block controller is what I 
still need to finish.

>>> - i2c
>>> - mmc
>>>
>>> the following are not yet supported by this series:
>>> - ethernet
>>> - usb
>> USB 2.0 should be usable with u-boot/master now, although you will need
>> to pull more recent DTs to obtain the controller node in imx95.dtsi .
>>
> 
> Yes, I did get USB 2.0 by adding the relevant usb2 nodes to dt
> (haven't seen this submitted upstream yet) and your "usb: ehci-mx6:
> Add i.MX95 support" patch.

Good.

>> USB 3.0 is possible without this TypeC switcher in PHY driver, I got it
>> working as gadget I think.
> 
> Ok, the usb3 dt nodes have been submitted upstream [1] but I haven't
> gotten usb3 to work as host yet but did not try peripheral mode. I did
> notice there is no ptn5110 driver keeping type-C role selection
> working.
Indeed . Do you want to start looking at the PTN and TCA block (that 
goes into USB PHY driver) support ?
