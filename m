Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2ACC369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7AC82D09;
	Wed, 16 Apr 2025 09:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Loozghne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B626482E0A; Wed, 16 Apr 2025 09:47:17 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA7F82D1B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kpUJ247402
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789611;
 bh=dydCL5qtC+5KzHMzzJQePlmzIJvdqtgyXxbbjAVhZs8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LoozghneclyCqw0VPquaeq2q7Om3QVnxCv+6yoeQ3JXD5F79tAxvHYIDR/UxsgrIk
 wMj6uHXWEwiIvDrpIjnKRR/4rclvIVVXVe3AGh/Dyt4rlLLMwKrBMyqVl6K+Ml6SVx
 qMLgwRQ3tNo1cUZSfW412qLp+iqaemLxCgiY9vDI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kpHR023836
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:51 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:51 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kjJW076052;
 Wed, 16 Apr 2025 02:46:45 -0500
Message-ID: <aa1c7e4d-f1ae-493e-aef7-adb356088af9@ti.com>
Date: Wed, 16 Apr 2025 13:16:44 +0530
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
 Udit Kumar <u-kumar1@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable> <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb> <87wmblyh6j.fsf@bootlin.com>
 <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com> <87sem9wy6e.fsf@bootlin.com>
 <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com> <87jz7lwq5u.fsf@bootlin.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <87jz7lwq5u.fsf@bootlin.com>
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

On 15/04/25 18:13, Miquel Raynal wrote:
> On 15/04/2025 at 15:29:09 +0530, Neha Malcom Francis <n-francis@ti.com> wrote:
> 
>> Hi Miquel
>>
>> On 15/04/25 15:20, Miquel Raynal wrote:
>>>>> Francesco, are you also testing on K3 platforms?
>>>>>
>>>>
>>>> Yes he would be, since the firmware print is K3 firmware.
>>>>
>>>>> Can one of you boot with the patch below applied? It should partially
>>>>> revert the commit to the ancient behaviour, while adding more debug
>>>>> traces (please enable the debug logs as well). This should clarify
>>>>> which one of the 3 different path is likely failing. It should also help
>>>>> identify who's the user that fails to enable/disable its own power
>>>>> domain. I will need to know what board/SoC was used for the test, so I
>>>>> can look the relevant driver up.
>>>>
>>>> Booted on j784s4_evm
>>>>
>>>> https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3
>>
>> ^
> 
> Ah, sorry! This is very interesting.
> 
> There are two things which I do not understand:
> - if we look at the very first power domains, their id is 15 and 14
>   respectively. I do not see these numbers in any device tree, am I
>   looking incorrectly? Could you help me identify what are the devices
>   requesting these IDs?

Yeah this might have been confusing. We have device IDs which are what
is mentioned in the device tree mapped to the power domain (LPSC) IDs
via arch/arm/mach-k3/r5/j784s4/dev-data.c which is consumed by a
rudimentary power domain driver ti-power-domain.c

I have enabled a debug log in ti-power-domain.c so you can see what is
the device ID that is eventually mapped to it's corresponding power
domain ID. So from:

ti_power_domain_of_xlate(power_domain=41c65ecc, id=191)
power_domain_on_lowlevel(power_domain=41c65ecc, id 15)

You can see that LPSC 15 was mapped from dev ID 191 which is from
memorycontroller@2990000. Hope this helps.

> - all power domains appear to be already enabled the very first time we
>   enable them. I believe this is the root cause of the problem, as they
>   should have count_on to 0 when booting. I checked again,

We're seeing only the logs after console is up. We are definitely
enabling up some power domains for the first time prior to the very
first print.

>   'per_device_auto' is a field that is zeroed when allocated (using
>   calloc() in this case) so I am really puzzled about this. It looks
>   like "something else" is using this data field, which would be
>   wrong.
> 
>>>>
>>>> Currently debugging on my build where I hang in console_init itself, I
>>>> think the path for failure is different here, will confirm.
>>>
>>> Thanks a lot for your feedback. Normally by applying the diff shared in
>>> my previous e-mail, you should have the console back. If not, maybe
>>> there is something else involved and the blamed commit is just the first
>>> showing an underlying problem.
>>
>> I do have console back with that patch, see the gist link above. What I
>> meant was the path of failure seems to be different, it's looking like
>> with my version of firmware the serial driver probe
>> (ns16550_serial_probe) tries to do a readb() and fails, this could
>> possibly be because the device was not powered on to begin with. Whereas
>> in another case (what Francesco is seeing), this issue is not run
>> into.
> 
> Clear.
> 
> Could you make another round with this extra change?

https://gist.github.com/nehamalcom/6772169d2b26d89ddcdeaf6049a8ff8f

This includes the debug logs you've provided as well as the debug log I
added as mentioned above.

Maybe I need to go over the power framework in detail, but it seems like
we (K3 devices) have a singular power-controller node that internally
goes ahead and turns on the respective power domain via our
ti,sci-pm-domain drivers. So the power-domain uclass sees only one power
domain i.e. power-controller and keeps incrementing it's on_count (see
the logs, I debugged even before the prints come we start from 0 and
keep incrementing the same power-controller's on_count). But maybe what
you expect when you wrote this patch is something similar to the
fsl,imx8mq-gpc drivers where each power-domain is a device node with
it's own on_count (see arm64/freescale/imx8mq.dtsi)?


> 
> Thanks!
> Miquèl
> 
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -119,14 +119,18 @@ int power_domain_on_lowlevel(struct power_domain *power_domain)
>  
>         debug("%s(power_domain=%p, id %d)\n", __func__, power_domain, power_domain->id);
>  
> -       if (priv->on_count++ > 0) {
> -               debug("Power domain %s already on.\n", power_domain->dev->name);
> +       if (priv->on_count > 0) {
> +               debug("Power domain %s already on (usage count: %d).\n", power_domain->dev->name, priv->on_count);
> +               priv->on_count++;
>                 //return -EALREADY;
> +       } else {
> +               priv->on_count++;
>         }
>  
>         ret = ops->on ? ops->on(power_domain) : 0;
>         if (ret) {
>                 priv->on_count--;
> +               debug("Power domain %s on failed (usage count: %d).\n", power_domain->dev->name, priv->on_count);
>                 return ret;
>         }
>  

-- 
Thanking You
Neha Malcom Francis
