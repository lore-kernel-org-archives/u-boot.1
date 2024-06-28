Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E729C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 06:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD55885AE;
	Fri, 28 Jun 2024 08:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="ZRQ6KcOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0FC885A8; Fri, 28 Jun 2024 08:51:06 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7843885A0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 08:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719557463; bh=QeubiLrr5wfEQ8ZL0YG3h2+SHRg0KID6XVsV4drJ89M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZRQ6KcOFX/6qxt1GcUvcLjGKTXajnwfMDmsTcP4TlxoEE+vy7wVTIEoDPYWBmXAPW
 n1yXCSLcNHKBC4DzSTI4Ok/BvHNjzKPdLcz6muP5Umo8BB4BmCaooyqibd+WnollXk
 nV9ASPt47XeDuTUpKDaa+2VSAXSoNe8jL6RY1lOb3S9uZYYsqC6DEXT6BTm/ezEggE
 PpiQklzfVw1aK1QfsGW/WwCkw3TG23OTGgU4EyBDON79oq9VDA9ttfrWgyCmyFyJ77
 8BgESdoH8P5u0clSL6gOB3XSRhKmedI+25ffu43rOzq8pA+lg/KWJ/RqeFSEJxEByL
 sTdcy28juHjdQ==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 871E340289;
 Fri, 28 Jun 2024 08:51:03 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 82CE3100071;
 Fri, 28 Jun 2024 08:51:03 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 13951140092;
 Fri, 28 Jun 2024 08:51:01 +0200 (CEST)
Message-ID: <9d618818-f3f4-4e03-8696-dcbc5b944006@imag.fr>
Date: Fri, 28 Jun 2024 08:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
 <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
 <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
 <a7dbf00b11304f80cacd5821a5e19127@manjaro.org>
 <273b4022-4192-4df8-ab69-db8d05b091ea@imag.fr>
 <0487e16e-9a4f-4a1d-be80-312a2969d258@cherry.de>
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <0487e16e-9a4f-4a1d-be80-312a2969d258@cherry.de>
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (42)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


Hi Quentin,

Le 27/06/2024 à 14:27, Quentin Schulz a écrit :
> Hi Etienne,
>
> On 6/25/24 1:42 PM, Etienne Dublé wrote:
>>
>> Hello,
>>
>> Le 25/06/2024 à 12:25, Dragan Simic a écrit :
>>>>> Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
>>>>> reflecting the PCI region address (so it is unique and stable). 
>>>>> What do you think?
>>>>
>>>> I guess that's one way, I'm also wondering how systemd renames those
>>>> to be unique but stable on the same machine, maybe we could take some
>>>> inspiration from them for that?
>>>
>>> Systemd also allows renaming of network interfaces using some rules
>>> predefined by the user, so there's also the possibility to rename the
>>> interfaces in U-Boot to ethernet0 and ethernet1, using fixed rules
>>> that would be based on the PCI region address.
>>
>> OK but the renaming occurs in the rtl8169 driver, that is used by 
>> several boards, whereas the PCI region addresses come from the 
>> device-tree, so they differ from board to board.
>>
>
> I'm of the opinion that we only care about stability for the same 
> product, not for different products with the same Ethernet PHY on 
> different SoCs/products.

I agree, but my comment was more about how u-boot code is structured 
(network interface naming is done in the driver, and the driver code 
should probably not include board-specific code, so we are quite limited).
In theory we could just name the interfaces ethernet0, ethernet1, etc., 
by using the PCI region address as the sort key, and maybe this is what 
Dragan was suggesting. But in practice when driver->bind() is called we 
don't know if more interfaces will be discovered next; and renaming the 
1st interface when the 2nd one is discovered with a lower address is 
probably not the kind of code u-boot code experts would like...

Cheers,
Etienne Dublé

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431
