Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7280AC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 18:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B470980EC0;
	Fri, 21 Feb 2025 19:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oFJCfRGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D642E80F5C; Fri, 21 Feb 2025 19:38:50 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5516807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 19:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51LIcTiu371423
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Feb 2025 12:38:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740163109;
 bh=QHsFTF0mOjcC8aMX4q3nAUMnseXzbaX98OFn8cnL3JU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oFJCfRGLSOS6HZt/Q0hEsx+IIQek51DjgGvNCE1EJnOK/8iFTagGWElWp7xPQTZYu
 aX8QNQW9KasZL/6xMt8BcCp8dKK2nfsNXkQ7Mrymy3mANdwOg3wsY9NcXgDs8kVeD0
 yeDNTH8C3VcnYsaXCG+7fywvhRzpjsogstDW57hs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51LIcTqF005126
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 21 Feb 2025 12:38:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Feb 2025 12:38:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Feb 2025 12:38:28 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51LIcO7L052674;
 Fri, 21 Feb 2025 12:38:25 -0600
Message-ID: <1133efa0-7f3d-40d2-8738-9e78868b305e@ti.com>
Date: Sat, 22 Feb 2025 00:08:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] power: regulator: Avoid probing of regulators at
 pre-ram stage
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <marex@denx.de>, <nm@ti.com>, <patrice.chotard@foss.st.com>,
 <n-francis@ti.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>
References: <20250221124505.1972915-1-u-kumar1@ti.com>
 <60f6f69d-7bdc-4ddd-b4f6-05b8d34ca382@cherry.de>
 <5c85ed27-384b-4e8e-ac19-b5641ad2b522@kwiboo.se>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <5c85ed27-384b-4e8e-ac19-b5641ad2b522@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Thanks Jonas

On 2/21/2025 7:49 PM, Jonas Karlman wrote:
> Hi Udit and Quentin,
>
> On 2025-02-21 14:54, Quentin Schulz wrote:
>> Hi Udit,
>>
>> On 2/21/25 1:45 PM, Udit Kumar wrote:
>>> commit 51c4679d2f84 ("power: regulator: Trigger probe of regulators which are always-on or boot-on")
>>> allow always on and boot on regulators to be early probed.
>>> Due to this probing boot time increases.
>>> Since in hardware regulators are always on, so probing of such
>> According to the DT binding:
>>
>> - regulator-always-on only means it should never be disabled, not that
>> it's automatically enabled.
>>
>> - regulator-boot-on means "It's expected that this regulator was left on
>> by the bootloader." We're the bootloader so it's our duty to turn the
>> regulator on.
>>
>> So I'm not sure the justification is valid here.
>>
>> I vaguely remember this patch was discussed a lot between Marek, Simon
>> and possibly Caleb so let's see if they have something to say.
> Correct, this cannot be reverted or it will break platforms that used to
> call regulators_enable_boot_on(), see commit 6f52feee2867 ("power:
> regulator: Drop regulators_enable_boot_on/off()").

ok. thanks


> If you want to skip probe, please ensure that appropriate bootph- props
> is used so that the regulator is excluded from your platform pre-ram
> phase.

Not entirely , I want to probe those but little later in time, around 
spl_board_init

by when boot is little progressed and clocking etc are in better shape.


>
> Regards,
> Jonas
>
>> Cheers,
>> Quentin
