Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA42C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC32E82A33;
	Tue, 15 Apr 2025 11:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bwDbkt2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1924682A39; Tue, 15 Apr 2025 11:59:37 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADA280C93
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F9xGvD2447410
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 04:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744711156;
 bh=a9Kp1J8LuHyEJd+oYPF57KmZE2wIDrzr/1a7HZwrEyA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=bwDbkt2ENXNAbARpMDEj2IsWGawCQrgyU6d6Dvm5nZIOSfBqeXvzhQ718ORNZxDEL
 7rrABgC2c58D1Ff1dg11Skqg3Vu9MREmxgNCJZnGR3v0dPuJ77VEdK3/14YaqVnOOs
 H45ZjaGqkZ+WEgocetv9GDzleXn8LMsnr10GVw8o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F9xF8m013419
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Apr 2025 04:59:16 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 04:59:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 04:59:15 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F9x9Ml089035;
 Tue, 15 Apr 2025 04:59:10 -0500
Message-ID: <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com>
Date: Tue, 15 Apr 2025 15:29:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, Fabio Estevm
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Mario Six
 <mario.six@gdsys.cc>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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
 <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com> <87sem9wy6e.fsf@bootlin.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <87sem9wy6e.fsf@bootlin.com>
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

On 15/04/25 15:20, Miquel Raynal wrote:
>>> Francesco, are you also testing on K3 platforms?
>>>
>>
>> Yes he would be, since the firmware print is K3 firmware.
>>
>>> Can one of you boot with the patch below applied? It should partially
>>> revert the commit to the ancient behaviour, while adding more debug
>>> traces (please enable the debug logs as well). This should clarify
>>> which one of the 3 different path is likely failing. It should also help
>>> identify who's the user that fails to enable/disable its own power
>>> domain. I will need to know what board/SoC was used for the test, so I
>>> can look the relevant driver up.
>>
>> Booted on j784s4_evm
>>
>> https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3

^
>>
>> Currently debugging on my build where I hang in console_init itself, I
>> think the path for failure is different here, will confirm.
> 
> Thanks a lot for your feedback. Normally by applying the diff shared in
> my previous e-mail, you should have the console back. If not, maybe
> there is something else involved and the blamed commit is just the first
> showing an underlying problem.

I do have console back with that patch, see the gist link above. What I
meant was the path of failure seems to be different, it's looking like
with my version of firmware the serial driver probe
(ns16550_serial_probe) tries to do a readb() and fails, this could
possibly be because the device was not powered on to begin with. Whereas
in another case (what Francesco is seeing), this issue is not run into.


> 
> Thanks,
> Miquèl

-- 
Thanking You
Neha Malcom Francis
