Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF01C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8070987D2F;
	Mon,  8 Jul 2024 08:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="xoGnG2cs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C024A882AA; Mon,  8 Jul 2024 08:49:30 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE96187D2F
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1720421368; bh=HMY5D0HaOhqjB8z7PofcTX1KKZaKm1eabMZ3lLWgzRA=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=xoGnG2cskAEfvtUC2IzExXa/7eAGDQQTbKCR2W0KbNVDgyjv5P0aiObY3YkCcqjJQ
 8PasAKWxq3GL1AbF3fS8AU21UUtglWrEvfPB+X/sIEO5m1IB/EtQtqrkyds/lV25cQ
 EzWa2xC6ZUfd+s2T92eLK96svElcKECJlZzceVR26+7os98kRcj2WvFKAgQeSrPU4Q
 3U50CeuY3N9yUazP3IVAvgDTDUweuFTRR3pjN1gtFnmOmYciP+AGQbyzDcIHsYyJBK
 LnmQzyxpcC7bDSMjSPkYfx6+VWiiAUQoxKKWzwzAx6/NDWGEsXeJYX+aJxn09nI7+M
 2T86lQSXsAeUQ==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 6015A4022A;
 Mon,  8 Jul 2024 08:49:28 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 5B899100068;
 Mon,  8 Jul 2024 08:49:28 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id DA51C140093;
 Mon,  8 Jul 2024 08:49:26 +0200 (CEST)
Message-ID: <a5070d95-e444-4ed3-bba8-24377c5d75d7@imag.fr>
Date: Mon, 8 Jul 2024 08:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
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
 <9b6692fb-6856-4cd7-ab18-19a33eef1db4@imag.fr>
Content-Language: en-US
In-Reply-To: <9b6692fb-6856-4cd7-ab18-19a33eef1db4@imag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (42)
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



Le 25/06/2024 à 13:31, Etienne Dublé a écrit :
>> The bus addresses should be isolated to each pci controller if I am not
>> mistaken, so changing the bus address was probably just done as a
>> workaround because of some other unknown bug.
>
> OK.
>
>> Hum, could be an issue in pci core of U-Boot that expect unique bus
>> addresses across all pci controllers.
>>
>> Will run some quick tests on my R5C later.
>
> OK, thanks for looking at it.
>

Hello Jonas,

Could you have a look at this issue with the 2nd interface on the nanopi 
r5c, and your idea about a possible issue in U-Boot core about 
non-unique PCI bus addresses?

Thanks,
Etienne


-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431

