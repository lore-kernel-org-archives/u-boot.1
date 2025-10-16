Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03095CCD195
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 14:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8EE836D1;
	Thu, 16 Oct 2025 16:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="b78V/nFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0C2836EE; Thu, 16 Oct 2025 16:39:25 +0200 (CEST)
Received: from mout.mail.com (mout.mail.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC24C83655
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1760625559; x=1761230359; i=sinan@writeme.com;
 bh=h0T/6pzJNaXogBJooW6Np9xZyo+pxreiWTNSHq2D47I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=b78V/nFl4GKSCXCQufPyWRoLO32alUxlQXUly8DwNLb2cUgxfM7wD44aTb6gQfQ2
 HEjQ6T303Uk1H+XL++aCiI+6mBc2/Iwy8OkHGUhnFf/A4o8gNYSrQZqZ4UWcJYiaU
 gxs9MU5MiqV9I+c5MQTqiwja64Ef5eUfhwPDzSjuAAqU4iDjw3tuGieWG5YmMxLTS
 lDSioLhiuBsDiiJPQYLh7b/N4i9EIYBAtcA3POjK6GIy5d05p5PLJY81y5DSg43yu
 JCzajxg4UinODQjAEYE14X+9A4vrpsKqRdbhYm+lOleuNBFssDExdPnMA45w0X0DC
 IV1Lqqlr3akdpmhl/Q==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LqB0g-1uVxe3102S-00eIX0;
 Thu, 16 Oct 2025 16:39:19 +0200
Message-ID: <11ae527d-5d5d-4ae7-a3de-024c2edaeaba@writeme.com>
Date: Thu, 16 Oct 2025 10:39:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External]Re: Uboot upgrade from 2016 to 2020
To: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <20251015221933.GW6113@bill-the-cat>
 <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
 <SJ0PR15MB47583424C26BA0F2290F1532DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <SJ0PR15MB47583424C26BA0F2290F1532DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7K8//M6UjufR0cUidfEHSncjrrsNsSUn8iErWGIdqqsiB1TcWQY
 HaXBRDWnAJFYATyxjXnLb2W4kHrBBUur7a2sOr1KFh93h4DvEOjiBPEc/eftB2Ueh45YEQ8
 q+Ya9XXzsvINJb0HTk1698ZJOlJ9pelcP85ULs4YrhY3njFjAGDjpXPmdE1QtQ8Kih55/HD
 6vI3uHAvCVFBBXSldOHug==
UI-OutboundReport: notjunk:1;M01:P0:E3AxC2JOfvA=;Gu0oDd18qPY9dmfgeJ8nnpsdJV4
 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
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

Hi Alex

On 2025-10-16 01:26, Manea, Alexandru (Alexandru) wrote:
> Hi Sinan,
>=20
> First thanks for replying. I do hope you will be able to help me a bit.
> The board is PPCE5500 used for Avaya IP500L platform.
>=20
> What I noticed for hanging is that it hangs when setting mtspr    IVPR, =
r0 in start.s although this seems correct: CONFIG_SYS_MONITOR_BASE@h
>=20
> Regards,
> Alex
>=20
> From: Sinan Akman <sinan@writeme.com>
> Sent: Thursday, October 16, 2025 3:00 AM
> To: Tom Rini <trini@konsulko.com>; Manea, Alexandru (Alexandru) **CTR** =
<amanea@avaya.com>
> Cc: u-boot@lists.denx.de
> Subject: [External]Re: Uboot upgrade from 2016 to 2020
>=20
> [External Sender]
> Hi Alexandru On 2025-10-15 18:=E2=80=8A19, Tom Rini wrote: > On Tue, Oct=
 14, 2025 at 10:=E2=80=8A21:=E2=80=8A37AM +0000, Manea, Alexandru (Alexand=
ru) wrote: > >> Hi, >> >> I have an issue with upgrading our sources to us=
e the 2020.=E2=80=8A04 uboot rather
>=20
>=20
> Hi Alexandru
>=20
>=20
>=20
> On 2025-10-15 18:19, Tom Rini wrote:
>=20
>> On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru) =
wrote:
>=20
>>
>=20
>>> Hi,
>=20
>>>
>=20
>>> I have an issue with upgrading our sources to use the 2020.04 uboot ra=
ther than the one working now on our system which is 2016.
>=20
>>> After adding all our board changes, I can see the SPL loading and sett=
ing DDR and TLB entries but once it tries to jump to uboot from mmc_boot()=
 it hangs and I can't get to see anything...has anyone encountered this? I=
s there something I can do to make sure uboot is actually being jumped to =
or why the hang? I've set the offsets to go to the _start_e500: instructio=
ns like the old uboot. I can share the traces I have if needed. Looking fo=
rward to an answer.
>=20
>>
>=20
>> There might have been some issue with certain PowerPC platforms
>=20
>> introduced after the v2016.xx releases and fixed later than v2020.04,
>=20
>> and git log might help. Of course, it would be better still if you coul=
d
>=20
>> move to current mainline and then help with PowerPC maintenance, as we
>=20
>> do need more people helping there. Thanks.
>=20
>>
>=20
>=20
>=20
>=20
>=20
> Which board is this for ?
>=20


I don't have access to P50x0 or T10x0 boards to test and debug this
but I might try to see if I can get my hands on a T1040RDB or one of
your boards (e.g. IP500L). As Tom mentioned any help you can provide
is definitely very welcome here in this area.

=2D- sinan
