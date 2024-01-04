Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA6C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 22:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04864877D5;
	Thu,  4 Jan 2024 23:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x36uBsqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA0687866; Thu,  4 Jan 2024 23:23:33 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE42F877D5
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 23:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404MNK2x069621;
 Thu, 4 Jan 2024 16:23:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704407000;
 bh=NbBINHG/PG7ZNDH6iV2RvY1Y66hb89NZYqSlwsSwQ1k=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=x36uBsqzH6QkWeVUirzU59BmU7Ba5sGQmO7V97oDlEO9oUBekbm+CAGVDuQCBhnbP
 SGEdXTmOtlBrSuuF2WryXGhk8op+a+vThTgYkKj1tj5d1fT56PCjSsO62Wzy93vyBm
 gAIp7+it+4lPyFuVkWp8xgPcJwmHiUGeAreP1G1E=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404MNK0G001601
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 16:23:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 16:23:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 16:23:20 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404MNK3b116978;
 Thu, 4 Jan 2024 16:23:20 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Nishanth
 Menon" <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 <vigneshr@ti.com>, <jonas@kwiboo.se>, <srk@ti.com>, <bb@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>,
 Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
In-Reply-To: <7e7dde90-0711-4cce-b2ca-ab7369f36ae4@ti.com>
References: <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
 <20231106055351.f2fny5ys6avi5qnk@ula0497581>
 <20231106153159.GH496310@bill-the-cat>
 <736c04ab-9c48-4957-b242-fcbde0ace68b@ti.com>
 <CAPnjgZ1JTcybX9sRFQtddcwefLum6_+ynQSWbQ=4NVdO6eAxhg@mail.gmail.com>
 <7df59596-ac84-4e26-844f-3f3ad4bb0b7f@ti.com>
 <CAPnjgZ06tDBGko7RxO_ec1hKYqOhfhY9D7FdPiaVcDxaomeUDA@mail.gmail.com>
 <CAFLszTiNruYVsRjAaKdtpvjuK3YfQN92DDArRofUOnWo-1jXUw@mail.gmail.com>
 <e6e305c1-a233-4b0c-9f2f-ae3339b9688f@ti.com>
 <20240104075245.wkirozn7ifoxinbn@uda0497581>
 <7e7dde90-0711-4cce-b2ca-ab7369f36ae4@ti.com>
Date: Thu, 4 Jan 2024 16:23:20 -0600
Message-ID: <86il48wxev.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 04 Jan 2024 23:23:55 +0100
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

Andrew Davis <afd@ti.com> writes:

>>>>>>>>      * uEnv.txt processing
>>>>>>>
>>>>>>> What command can do this?
>>>>>>>
>>>>>>
>>>>>> run envboot;
>>>>>>
>>>>>> https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/mmc.env?ref_type=heads#L20
>>>>>
>>>>> This could be a new bootmeth which looks for uenv.txt on available
>>>>> devices. It might be better to put the env in a FIT or something with
>>>>> a checksum.
>> 
>> We use non-FIT boot as well for our non HS platforms, I think the new
>> bootmeth might be helpful as you mentioned, would have to look at this
>> more as I thought bootmeth is supposed to boot a platform at the end
>> only but it seems like here we'll be combining this bootmeth ( that'll
>> just import the env ) and then other bootmeth will actually boot Linux.
>> 
>
> As long as bootmeths can perform an action then continue with other
> bootmeths that could work. This might require complex logic though.
> For instance the uenv.txt bootmeth would only need run on some subset
> of available bootdevs, and it should scan all those devs for uenv.txt
> first, before the Linux finding bootmeths start.
>

It doesn't make sense to treat envboot as a bootmeth because it's really
not about a way of booting but more often just used to modify
environment variables before going through another boot flow (although
you could define/run env variables that performs it's own boot).  It may be
better to think of it as a preprocessing step before a bootflow scan.

Some other thoughts - envboot is more of a hacky way to solve things:
1) As we move more towards secure boot as the standard, we should
   understand what use cases the hacks are working around and properly
   support those use cases.
2) But I don't think we should just remove it altogether because it is a
   very powerful 'feature' during the development phases to try out
   changes without modifying/rebuilding/reflashing u-boot.
3) This is a TI feature.  Are others solving this need in a better way?

Jon
