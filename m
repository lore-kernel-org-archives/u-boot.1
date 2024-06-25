Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39557C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 11:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BEE8824C;
	Tue, 25 Jun 2024 13:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="I23oI5DQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE178841D; Tue, 25 Jun 2024 13:42:30 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2700288208
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 13:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719315747; bh=ocmnycEdHilSr9n9yA3/uUqlC8ynzghmroJn6ppjyFo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I23oI5DQXMcYocQdSoAptqoQerJbO5fML8LHKfnyMvfK6ViFShyQNOigX/i28xirr
 mCl7smJrZRanMpLnQe/fLCGjkvYo4tPzDPIqIW+d49N+IYbCKjDTnHkKNYj4DwT3qq
 pYcYiuaM3YO9QJ1B1sWql/lgL8xoGltQC69XuJyr4r7a0Ar3Eja1mzoRPMIv7vyU6Z
 QDODNb6oQSenlCnGSuWnAwiOraIWsEzcVE1yAbNQzc7BaepXQQvCqTQL2ABpO4vjMe
 t123Nxs+jFjO9KvJ6HHcQ8ZF2RMkdXNbyBBdsS97vGvvvuW5za1eDGJiX3d8Sjzmfg
 VdTSrfgaZPp7A==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id C3FC140235;
 Tue, 25 Jun 2024 13:42:27 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id C01AD100068;
 Tue, 25 Jun 2024 13:42:27 +0200 (CEST)
Received: from [129.88.53.250] (pimlig-dock-duble.imag.fr [129.88.53.250])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 (Authenticated sender: dublee@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 1532F4007F;
 Tue, 25 Jun 2024 13:42:22 +0200 (CEST)
Message-ID: <273b4022-4192-4df8-ab69-db8d05b091ea@imag.fr>
Date: Tue, 25 Jun 2024 13:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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
Content-Language: en-US
From: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>
In-Reply-To: <a7dbf00b11304f80cacd5821a5e19127@manjaro.org>
X-Greylist: Whitelist-UGA SMTP Authentifie (dublee@univ-grenoble-alpes.fr) via
 smtps-465 ACL (41)
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


Hello,

Le 25/06/2024 à 12:25, Dragan Simic a écrit :
>>> Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
>>> reflecting the PCI region address (so it is unique and stable). What 
>>> do you think?
>>
>> I guess that's one way, I'm also wondering how systemd renames those
>> to be unique but stable on the same machine, maybe we could take some
>> inspiration from them for that?
>
> Systemd also allows renaming of network interfaces using some rules
> predefined by the user, so there's also the possibility to rename the
> interfaces in U-Boot to ethernet0 and ethernet1, using fixed rules
> that would be based on the PCI region address.

OK but the renaming occurs in the rtl8169 driver, that is used by 
several boards, whereas the PCI region addresses come from the 
device-tree, so they differ from board to board.

Regards,
Etienne

-- 
Etienne Dublé
CNRS / LIG - Bâtiment IMAG
700 avenue Centrale - 38401 St Martin d'Hères
Bureau 426 - Tel 0457421431
