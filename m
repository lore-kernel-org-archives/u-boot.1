Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6650DC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 05:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F974826AD;
	Tue, 15 Apr 2025 07:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YL8eF3ZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8249C828D0; Tue, 15 Apr 2025 07:21:14 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFABA8215D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 07:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F5KnTO2373040
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 00:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744694449;
 bh=zSYzZXraj+sHzuaN9sQ+TaR2GECN4Crp5bltCetmtvw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=YL8eF3ZOrZ8rR0x8QDhAdNMMBOuSmn6tAhp1p3sibo3OgEtpEotGKPS3c9YwJh/8e
 QfxB64o7vpe/Dqogn5J2eskMJgwoWrO5G99axwP7xMcDx1j4ziQADOAbEC4+Ej4NMw
 fRjViVdzbWp+jnYzsfJ7juU9mFXpDq1JLCDiss8g=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F5KnDq010198
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Apr 2025 00:20:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 00:20:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 00:20:48 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F5KhQo128528;
 Tue, 15 Apr 2025 00:20:43 -0500
Message-ID: <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
Date: Tue, 15 Apr 2025 10:50:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
CC: Nishanth Menon <nm@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
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
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250414210041.GA8754@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 15/04/25 02:30, Francesco Dolcini wrote:
> On Mon, Apr 14, 2025 at 02:06:35PM -0600, Tom Rini wrote:
>> On Mon, Apr 14, 2025 at 01:07:27PM -0500, Nishanth Menon wrote:
>>> On 23:06-20250414, Francis, Neha wrote:
>>>> On 4/3/2025 1:09 PM, Miquel Raynal wrote:
>>>>> It is very surprising that such an uclass, specifically designed to
>>>>> handle resources that may be shared by different devices, is not keeping
>>>>> the count of the number of times a power domain has been
>>>>> enabled/disabled to avoid shutting it down unexpectedly or disabling it
>>>>> several times.
>>>>>
>>>>> Doing this causes troubles on eg. i.MX8MP because disabling power
>>>>> domains can be done in recursive loops were the same power domain
>>>>> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>>>>> timings to respect and it is easy to produce a race condition that puts
>>>>> the power domains in an unstable state, leading to ADB400 errors and
>>>>> later crashes in Linux.
>>>>>
>>>>> CI tests using power domains are slightly updated to make sure the count
>>>>> of on/off calls is even and the results match what we *now* expect.
>>>>>
>>>>> As we do not want to break existing users while stile getting
>>>>> interesting error codes, the implementation is split between:
>>>>> - a low-level helper reporting error codes if the requested transition
>>>>>   could not be operated,
>>>>> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>>>>>   EBUSY.
>>>>>
>>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>>> ---
>>>>
>>>> This commit looks to be breaking K3 platforms boot, please see "Latest Boot
>>>> Summary" [0]. Reverting the commit fixes boot.
>>>>
>>>> [0] https://lcpd.itg.ti.com/upstream/k3-boot-build/main/build-trends.html

My bad on the internal link.

>>>
>>> Uggh. This link is a TI internal link. Nutshell, it is broken
>>> between:
>>> v2025.04-921-gcb7555e93075 : https://source.denx.de/u-boot/u-boot.git
>>> and
>>> v2025.04-1041-g407d68638fe3 : https://source.denx.de/u-boot/u-boot.git
>>>
>>> Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a commit
>>> which is this patch.
>>
>> And assuming it's the same failure I got reported this morning by one of
>> my coworkers, we just get:
>> U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
>> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')

This is not the failure I am seeing, we hang before console comes up so
no prints. Looks like the different failure signature is due to TIFS
(SYSFW) firmware being different (v9.2.7 vs. 11.0.4)
> I have not tried reverting that commit yet, but I do have the same
> failure.
> 
> Francesco
> 



-- 
Thanking You
Neha Malcom Francis
