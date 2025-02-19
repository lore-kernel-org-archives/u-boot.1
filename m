Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8DAC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57981807C4;
	Wed, 19 Feb 2025 16:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="BGdcnk2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E01A80F18; Wed, 19 Feb 2025 16:30:27 +0100 (CET)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D39801BE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1739979024; bh=CGYI0v0GCCGtovCRn5/D/w08ae1+SxOl0xrx0XYUXdY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BGdcnk2fghqKeCwGPZJqGUtr06qGspCBXKdXKU4bNBXtVtSbZvMGFk/H4kLGoVxQB
 T2FDyZQkV91e0vrMG88IE7Z7to+7QChfRU5m83BKWq5txCBg3ZOFQmzI6rlfvM4O6N
 KnLB1ReApoiO3ePqpGcX/eN9+VVnTPmqe0TiZxWSm6tXvvB7NR5jEB7nsckryyBayQ
 ZAbzMub3ASQPogepoql8YQRJdp91N5SZN0Ch26wOBWAtjxknHyZVx3HqretEf2UMCP
 IRXVDYTpWSfNGu2bQDa544ixdCX34tdLAgE1GCu87o7XIX6mOaOkvWoZ38bZNsmdau
 /i2L/aSsheLkA==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id BC06040290;
 Wed, 19 Feb 2025 16:30:24 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id B6052FF853;
 Wed, 19 Feb 2025 16:30:24 +0100 (CET)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 95EAE140084;
 Wed, 19 Feb 2025 16:30:23 +0100 (CET)
Message-ID: <8c47e42c-6922-45a1-97ad-de634d8075d3@imag.fr>
Date: Wed, 19 Feb 2025 16:30:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>,
 Matthias Brugger <mbrugger@suse.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
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

Le 05/02/2025 à 11:15, Oleksii Moisieiev a écrit :
> This patch series provides generic support for Raspberry PI 5 in
> U-Boot with additional hardware drivers.
> The following features were implemented:
> 1) add generic board config for Raspberry PI5 including device-tree
> files;
> 2) add support for RP1 chip with additional hardware;
> 3) add support for rp1-clock driver with dt-bindings update;
> 4) PCIE BRCMSTB driver support for Raspberry PI 5;
> 5) add clock/reset/gpio drivers;
> 6) add ethernet support in u-boot.
>
> [...]

Tested-by: Etienne Dublé <etienne.duble@imag.fr>

I applied the patch on commit 6e316e3f397b5e01e98c5dd56cdbaab961daeedf (April 15, 2024) and used it for network booting a Raspberry Pi 5 in a WALT platform [1].
Our boot procedure is quite convoluted and in this specific case it 
involves two network transfers (a small u-boot script first, which is 
then executed and triggers the download of a FIT image) but I have not 
noticed any problems. I hope the remaining questions will be quickly 
sorted out by linux kernel maintainers. Great work Oleksii!

Thanks
Etienne

[1]: https://walt-project.liglab.fr/

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
150 place du Torrent
38400 St Martin d'Hères
Bureau 426 - Tel 0457421431

