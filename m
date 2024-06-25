Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF6EC2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 10:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED147883CD;
	Tue, 25 Jun 2024 12:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="Eow/gDKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA2F8844C; Tue, 25 Jun 2024 12:12:40 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B188824C
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 12:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719310358; bh=yjqqBe1TGG5bfEonAQYbnPi3uDmJ3l4Awce3nQKgOQ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Eow/gDKoGqhK9wzeE/5URok/QbVhpCtBB8dvZXtZ52tpNqGN3A2XtKK1QEf6va+k+
 PhyAlw2pC467sLh5ItQcTGrGud4bsK9vdERrcBP/kfdjeMLMnn0G3gl592wPMij1Ly
 lkUEBrw8lBsjxnZj5s/ez/4x7Q3WmHtGjU1MOEdEETLBFCThewF0Bb4asYKNZc9MGU
 3X7Vi5Ecnbxr4h8f2ZMW6vxYEPorK4icbZRHDDHu2qklGZckFlV7EuF4RK62L7qvrh
 SBmnywdet/4XGd1Zc4kuXyp7M/VVsasITIVolJf41zCeM+wgePKPM+ElOP1m4Xg5R1
 OPQTXNDQNb8pw==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 28C094022A;
 Tue, 25 Jun 2024 12:12:38 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 24C82100068;
 Tue, 25 Jun 2024 12:12:38 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id B70114007F;
 Tue, 25 Jun 2024 12:12:36 +0200 (CEST)
Message-ID: <b238dae1-17f8-48c4-a75c-5d6002a9bea7@imag.fr>
Date: Tue, 25 Jun 2024 12:12:36 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <8224b226-49ba-4a6a-a736-3c0dfee0aa57@kwiboo.se>
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

Le 25/06/2024 à 10:29, Jonas Karlman a écrit :
> I do not understand the need for such/this patch. The changed address is
> the internal io address that is shared with the pci controller and
> devices.
>
> Do you have any issue in linux or is it only in U-Boot?, I suspect this
> change is only a workaround to an issue only found in U-Boot.

On my board (Nanopi R5C with two RTL-8125B interfaces) both RTL-8125B 
interfaces work in Linux, and only the first one works in u-boot.
But Linux is apparently using the second PCI region and u-boot is using 
the third (with the suspected address). These PCI regions are of the 
same type.

> The rtl8169 driver or pci system of U-Boot may be of fault and should
> probably be fixed instead of changing io addresses to work around issues
> in software. E.g rtl8169 has a static ioaddr that is shared between all
> drivers, something that may cause issues.

I am not an expert, but I really believe the issue comes from this 
address in the device tree.
We have these pcie entries in rk3568.dtsi:

----
         pcie3x1: pcie@fe270000 {
[...]
                 ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 
0x00100000>,
                          <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 
0x01e00000>,
                          <0x03000000 *0x0* *0x40000000* 0x3 0x40000000 
0x0 0x40000000>;
[...]
         }
[...]
         pcie3x2: pcie@fe280000 {
[...]
                 ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 
0x00100000>,
                          <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 
0x01e00000>,
                          <0x03000000 *0x0* *0x40000000* 0x3 0x80000000 
0x0 0x40000000>;
[...]
         }
----

Again, I am not an expert, but it seemed suspicious to me that those two 
entries were sharing the same PCI address.
So I verified in the downstream repository of the board vendor 
(https://github.com/friendlyarm/uboot-rockchip/blob/nanopi5-v2017.09/arch/arm/dts/rk3568.dtsi#L1754C21-L1754C31), 
and the second address there was replaced with "*0x0* *0x80000000*".
Then, updating this was enough to make the second interface work in u-boot.

Like you, I initially suspected the code of rtl8169.c, which has many 
global & static variables, so I actually spent quite a lot of time on 
refactoring it, moving things to the private struct, but could never 
make it work until I found this suspecting PCI address.

Cheers,
Etienne

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431

