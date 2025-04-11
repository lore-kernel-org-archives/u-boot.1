Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049E1C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 05:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBED83E88;
	Fri, 11 Apr 2025 07:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ezW4JYgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2368D83E8A; Fri, 11 Apr 2025 07:34:10 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6E783E72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53B5Y6un1488697
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 00:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744349646;
 bh=5C5d53D2H86HU6p2Y2a9wv6yjpKYQFpSsFk6G4XmZpw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ezW4JYgoupD5Y8XWVyMHx4dyY0fAL3+8aMXfJrnGkd88yYYcoKkHV8lumSA9yQqKc
 ygsPzRWFcMwsgU8p+FxBH3CN6vC3bku1oxb0hkeblsGEMde2oq1mRY+d6EPsyj78Li
 5UY2tCoJTiGJ0LijpFzaQxY7E5iN9HLWGgFtjj7I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53B5Y6Gv122077
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 00:34:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 00:34:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 00:34:05 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53B5Y1DC039410;
 Fri, 11 Apr 2025 00:34:02 -0500
Message-ID: <c7aeedc9-3786-4d1f-b68d-22252d9c3197@ti.com>
Date: Fri, 11 Apr 2025 11:04:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>, Neha Malcom
 Francis <n-francis@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: Andrew Davis <afd@ti.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>, Dhruva Gole
 <d-gole@ti.com>, <u-kumar1@ti.com>
References: <20250407121554.1010490-1-nm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250407121554.1010490-1-nm@ti.com>
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

Hi Nishanth,

Sorry for basic question

On 4/7/2025 5:45 PM, Nishanth Menon wrote:
> [..] This creates a problem when Device Manager(DM) firmware starts up later
> on in the boot process and identifies that this instance of i2c is

Do we need to do clean up, where DM is loaded as different binary .

As I understand this cleanup is needed, where DM is running along with 
SPL/R5

or I am missing something


> already marked active, so it assumes this can no longer be controlled
> by software and is marked internally as reserved and HLOS can no
> longer control these instances. This defeated the purpose of
> ti_sci_cmd_release_exclusive_devices.
>
> NOTE: This scheme works just fine if the FIT has just a single dtb as
> the info->dev_list is upto date.
>
> To fix this, let us make ti_sci_cmd_release_exclusive_devices scan the
> all registrations of tisci instances and cleanup all exclusive devices
> that have ever been registered.
>
> As part of this, change the prototype of release_exclusive_devices to
> drop the handle since that has no further meaning now.
>
> Though this issue was identified on AM64-sk, this can be present in
> other builds which use multi-fit-dtb for R5 SPL startup.
>
> [..]
