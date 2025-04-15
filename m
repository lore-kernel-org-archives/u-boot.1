Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B2C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 08:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F07D81E18;
	Tue, 15 Apr 2025 10:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JkhTVqRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90CA820E8; Tue, 15 Apr 2025 10:59:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E92281E14
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F8xS9W2993213
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 03:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744707568;
 bh=2HgiCT1eP1po1NeG2ieJMmDzq2K/s6bUr5A4rfUbVFo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=JkhTVqRlhCuN83CcNbOF0X+K9pECsxidedPqs9ugDnzui2ZqTvZOwaYCGIJVQVSS+
 C81fu/8xbpQysAVAmLm6vKsmaOmn9jkJuwRLzbnMjUI8y9DJUmLCWmUVuaL6noL9Z8
 BblUS3ssu4XbI1V/Ob4Om2nCKbmLaTZHyuf+oPBk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F8xScY027992
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Apr 2025 03:59:28 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 03:59:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 03:59:28 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F8xMFe023985;
 Tue, 15 Apr 2025 03:59:23 -0500
Message-ID: <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com>
Date: Tue, 15 Apr 2025 14:29:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>, Francesco Dolcini
 <francesco@dolcini.it>
CC: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin
 <agust@denx.de>, Fabio Estevm <festevam@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Udit Kumar <u-kumar1@ti.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable> <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb> <87wmblyh6j.fsf@bootlin.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <87wmblyh6j.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Miquel

On 15/04/25 13:45, Miquel Raynal wrote:
> Hello,
> 
> Thanks for the report.
> 
>>>>>> Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a commit
>>>>>> which is this patch.
>>>>>
>>>>> And assuming it's the same failure I got reported this morning by one of
>>>>> my coworkers, we just get:
>>>>> U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
>>>>> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
>>>
>>> This is not the failure I am seeing, we hang before console comes up so
>>> no prints. Looks like the different failure signature is due to TIFS
>>> (SYSFW) firmware being different (v9.2.7 vs. 11.0.4)
>>
>> To me it was failing freezing just after this
>>
>> U-Boot SPL 2025.04-01076-g739ad58dbee8 (Apr 14 2025 - 17:23:46 +0200)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
>>
>> and, with commit 197376fbf300 ("power-domain: Add refcounting") reverted
>> the issue is fixed and I get to the U-Boot command line.
> 
> Francesco, are you also testing on K3 platforms?
> 

Yes he would be, since the firmware print is K3 firmware.

> Can one of you boot with the patch below applied? It should partially
> revert the commit to the ancient behaviour, while adding more debug
> traces (please enable the debug logs as well). This should clarify
> which one of the 3 different path is likely failing. It should also help
> identify who's the user that fails to enable/disable its own power
> domain. I will need to know what board/SoC was used for the test, so I
> can look the relevant driver up.

Booted on j784s4_evm

https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3

Currently debugging on my build where I hang in console_init itself, I
think the path for failure is different here, will confirm.

> 
> Thanks for your help,
> Miquèl
> 
> ---
> 

-- 
Thanking You
Neha Malcom Francis
