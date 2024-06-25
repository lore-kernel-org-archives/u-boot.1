Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E23C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 11:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECAC8824C;
	Tue, 25 Jun 2024 13:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="ZGSVPEuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465BC8841D; Tue, 25 Jun 2024 13:31:40 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF89288208
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 13:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719315097; bh=t/BvuxODH4dE9Y4+n5szsg4fhJfQYXhWG3kesk9Tf+0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZGSVPEuYyvwVZnuQsnHreiUliIwtj1EKzmmPfsdvNqfCV1nCMtL6HwkxNz2+MXcJe
 kBEpYxy+yND1o+FTBehZ96qyvpcY0abjUu+PqvPQ0yN9iP5prpxRGW55eC611KNwKE
 n+tCmlS5IAesSWuqKWWB7Y6JoGaQv56bRG1wZ4YSJGz3K83BLDF94ZtObFAaq3TEcC
 Tjos+kM/29cy27gUbTjhGKkuJm7447e8IboC6hyzZbsGMUkgloOdPSot2SxZPD6QJX
 /5vzzAsFCpmk86J+ENNfPlYkf2SQvsB222RBNvGJ1d9OBbY+uIDAezrD2S12lxEZli
 iOZWdWWJrWDyg==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 5B31F40228;
 Tue, 25 Jun 2024 13:31:37 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 57A87100068;
 Tue, 25 Jun 2024 13:31:37 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id E19F94007F;
 Tue, 25 Jun 2024 13:31:35 +0200 (CEST)
Message-ID: <9b6692fb-6856-4cd7-ab18-19a33eef1db4@imag.fr>
Date: Tue, 25 Jun 2024 13:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <6e542e4b-9785-4ce5-b10a-7ed1b54131a8@cherry.de>
 <2b902244-0688-432b-bd04-061a083a0fbd@imag.fr>
 <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se>
 <b238dae1-17f8-48c4-a75c-5d6002a9bea7@imag.fr>
 <12057632-0ea4-45c5-8c98-8f689c0338db@kwiboo.se>
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <12057632-0ea4-45c5-8c98-8f689c0338db@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (41)
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


Hello Jonas,

Le 25/06/2024 à 12:46, Jonas Karlman a écrit :
> Ahh, linux is still missing a patch to be able to use full address ranges
> as a root complex.
>
> Will re-run some tests on my R5C on both u-boot and linux to see if I can
> replicate your issue.

OK.
To use the second interface in u-boot, you first need to provide a 
".bind()" member function in the rtl8169 driver, otherwise both 
interfaces have the same name (this is my [PATCH 1/3]).
Then :

Hit any key to stop autoboot:  0
=> pci enum
=> net list
eth0 : RTL8169#0 52:e8:a1:60:81:e7 active
eth1 : RTL8169#1 52:e8:a1:60:81:e6
=> setenv ethact "RTL8169#1"
=> dhcp

The issue appears when sending the first packet. When activating 
DEBUG_RTL8169_TX in rtl8169.c it prints "tx timeout/error".

> The issue may be that U-Boot is not fully capable of having overlapping
> bus addresses for multiple pci controllers.
>
> To my knowledge these addresses should be internal to the pci controller
> and its devices.
>
> The addresses below tells us that system memory address 0x340000000+,
> and 0x380000000+ is mapped to bus address 0x40000000+ of each pci
> controller.

I see.

>> [...]
>> So I verified in the downstream repository of the board vendor
>> (https://github.com/friendlyarm/uboot-rockchip/blob/nanopi5-v2017.09/arch/arm/dts/rk3568.dtsi#L1754C21-L1754C31
>> and the second address there was replaced with "*0x0* *0x80000000*".
>> Then, updating this was enough to make the second interface work in u-boot.
> The bus addresses should be isolated to each pci controller if I am not
> mistaken, so changing the bus address was probably just done as a
> workaround because of some other unknown bug.

OK.

> Hum, could be an issue in pci core of U-Boot that expect unique bus
> addresses across all pci controllers.
>
> Will run some quick tests on my R5C later.

OK, thanks for looking at it. Regards, Etienne

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431

