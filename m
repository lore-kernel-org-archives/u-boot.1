Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA11106ACC9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB01842E6;
	Thu, 12 Mar 2026 17:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XjI3Z2td";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025E984166; Thu, 12 Mar 2026 14:20:53 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC9B8407F
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 14:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4800101EE9; Thu, 12 Mar 2026 14:20:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773321649;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gkSa0dEdyJ4tn+coTbckAOPzar4FId9C2hmdMibWCk0=;
 b=XjI3Z2tdco+n6mdLAVaQfFOfBJ3uuK10co5JKLgWN8nHVUAt9Vk7HiFch/V/belWZK3yFr
 jHruzaXMTkuX5E8Yb1+XO0I0Ixm4tG5g7nnK0aEB/HxpmYC7lvo69z2Gbb0LkhwvdLSwmq
 7F8GfWDcLqOLJP109/S8p/w4Sh9KoCa3KcRiNTVzTQGZo/RSiLn/yGby5Eu04Uz01U8HvK
 oJSb6ypviPzyxT4PHA3Z4s+Xv2JKL3nvFej64pUHRZDke68gN6FdB3C4A9PBSxO6N2o4un
 ZmIbF267+uGvv8qCEMxUMHNqp2Vc2DaPbUzkfcbrhP2JP6GOZV0N9EZpkIdnhw==
Message-ID: <07607b88-bd5d-4d24-802b-0975cf4d596d@nabladev.com>
Date: Thu, 12 Mar 2026 14:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] imx9{4,5}: Add Quickboot support
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, ravi@prevas.dk, fedor.ross@ifm.com,
 sebastien.szymanski@armadeus.com, joao.goncalves@toradex.com,
 ji.luo@nxp.com, semen.protsenko@linaro.org, sjg@chromium.org,
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <d1f9c66c-fedb-4802-94b0-3b043e0b8bbd@nabladev.com>
 <7y5vmmpzrerguaswwwusw4bl2rfzadlxgwnwovmk3hqfuszzcp@yebfnc4sipsj>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <7y5vmmpzrerguaswwwusw4bl2rfzadlxgwnwovmk3hqfuszzcp@yebfnc4sipsj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 12 Mar 2026 17:24:18 +0100
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

On 3/12/26 12:47 PM, Simona Toaca wrote:

Hello Simona,

> On Wed, Mar 11, 2026 at 04:42:54PM +0100, Marek Vasut wrote:
>> On 3/10/26 12:54 PM, Simona Toaca (OSS) wrote:
>>> From: Simona Toaca <simona.toaca@nxp.com>
>>>
>>> This patch series adds support for saving DDR training
>>> data to non-volatile memory on iMX94 and iMX95 platforms.
>>> The purpose is running DDR Quickboot flow on next reboot.
>>>
>>> The process is as follows:
>>> - OEI runs Training flow for the DDRPHY
>>> - OEI saves the data from training to volatile memory
>>> - U-Boot can then save it to non-volatile memory (e.g. SD)
>>> - OEI loads the data from NVM at cold reboot and runs Quickboot flow
>>>
>>> By skipping training, a much lower boot time is achieved.
>> How does this interact with authenticated boot ? I wonder if, in case the
>> entire bootloader stack is authenticated, the attacker can tamper with the
>> saved QB data (which do not seem to be authenticated) and cause bitflips to
>> occur in DRAM, which could then allow them to bypass authentication in
>> follow up stages which execute from DRAM ?
>>
>> Are the QB data protected/authenticated in any way against tampering ?
> 
> In U-Boot there is no authentication for qb, it's just the CRC that is used
> to ensure the qb data was not overwritten by another (non-malicious) entity.

Ouch

> OEI is the first boot component that runs during the bootflow and is
> in charge of verifying if the data stored in NVM is valid or not. With
> the exception of iMX95 A0/A1, which use a CRC as well for this purpose,
> the other boards (iMX95 B0, iMX943, etc.) use ELE to verify a MAC stored
> in the qb_state structure. This provides the authentication part.

I see, understood and thank you for clarifying this. This part kept 
coming up in various discussions, so it would be nice to have this at 
least in the commit message, for future reference.

Thank you !
