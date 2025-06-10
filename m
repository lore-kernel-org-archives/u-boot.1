Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD576C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5F88070C;
	Tue, 10 Jun 2025 14:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RaD//4F7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D4882AC4; Tue, 10 Jun 2025 14:48:56 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E7308007D
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 14:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55ACmqQI2290343;
 Tue, 10 Jun 2025 07:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749559732;
 bh=xsU+Ludi3xhwPU02I/gHoP9Wamd+8jWWHK9kZYWsca0=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=RaD//4F7oNyvgbPZQ/Mvr6hSiFMDgAGXfKY7uDVCIeuUOfETQcYCMceUTBZxkJgeK
 5I7hLwJWS62lufaK+kCw6fcrtPflFAD21GhBPRSI1YuFVfC0kzq1lWQu8++z5An1q2
 jEACGGNBEPpIZXm42bZJOGbx0KmgTNwEn2i/OEJU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55ACmqau2121651
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 10 Jun 2025 07:48:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 07:48:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 07:48:51 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55ACmoAp3069281;
 Tue, 10 Jun 2025 07:48:51 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Jun 2025 18:18:16 +0530
Message-ID: <DAIV5H1N5ERM.EC24TFII1C1Z@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v7 04/10] arch: arm: k3-binman: add fit for falcon boot
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-5-anshuld@ti.com>
 <20250606115719.eyu2vk3zdwygzmc2@bryanbrattlof.com>
 <DAHTPYAY74YM.1NOHZR0BX3KPD@ti.com>
 <38ae6f7c-0e66-4f27-a5bf-55eef8ba54f1@ti.com>
In-Reply-To: <38ae6f7c-0e66-4f27-a5bf-55eef8ba54f1@ti.com>
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

On Mon Jun 9, 2025 at 8:53 PM IST, Andrew Davis wrote:
> On 6/9/25 2:28 AM, Anshul Dalal wrote:
>> On Fri Jun 6, 2025 at 5:27 PM IST, Bryan Brattlof wrote:
>>> On June  3, 2025 thus sayeth Anshul Dalal:
>>>> This adds creation of tispl_falcon.bin for the am62a, 62p and 62x.
>>>>
>>>> The contents are the same as the existing tispl.bin but A53's spl and
>>>> the fdt have been removed as they are not needed in falcon boot.
>>>>
>>>> This reduces boot time since the payload size is smaller and we also
>>>> aren't authenticating the spl and fdt in secure boot.
>>>>
>>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>>> ---
>>>>   arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++=
++
>>>>   arch/arm/dts/k3-am62a-sk-binman.dtsi | 64 ++++++++++++++++++++++++++=
++
>>>>   arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
>>>>   arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
>>>>   4 files changed, 233 insertions(+)
>>>>
>>>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am=
625-sk-binman.dtsi
>>>> index cc619f5920e..9544b9d1134 100644
>>>> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
>>>> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
>>>
>>> ...
>>>
>>>> +				dm {
>>>> +					ti-secure {
>>>> +						content =3D <&dm_falcon>;
>>>> +						keyfile =3D "custMpk.pem";
>>>> +					};
>>>> +					dm_falcon: ti-dm {
>>>> +						filename =3D "ti-dm.bin";
>>>> +					};
>>>
>>> When you build this are you using the TI_DM argument? Or are you using
>>> BINMAN_INDIRS to point to all the firmware? I think this will only look
>>> for "${BINMAN_INDIRS}/ti-dm.bin" and error out now that DM is mandatory
>>> unless you use TI_DM which will break a few distro builders' recipes
>>>
>>=20
>> It relies on BINMAN_INDIRS still and I hadn't updated the dm node since
>> c492a55fe4 ("arm: dts: k3: binman: Fix DM firmware selection"). I will
>> fix this in the next revision. Thanks for bringing it to my attention.
>>=20
>>>
>>>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>>>> index 5163161b94d..a678379dae9 100644
>>>> --- a/arch/arm/dts/k3-binman.dtsi
>>>> +++ b/arch/arm/dts/k3-binman.dtsi
>>>> @@ -489,6 +489,60 @@
>>>>   		end_address =3D <0x0 0x9fffffff>;
>>>>   	};
>>>>  =20
>>>> +	ti_falcon_template: template-9 {
>>>> +		filename =3D "tispl_falcon.bin";
>>>
>>> Small nitpick: We could probably just call this tifalcon.bin or
>>> something shorter. It's not really an SPL now.
>>>
>>> The bigger issue here (in my mind) is this requires our falcon.config
>>> fragment to work properly. I don't think it is wise of use to produce
>>> this image if that fragment isn't applied. It would be a debugging
>>> nightmare for others outside of the U-Boot space.
>>>
>>=20
>> The fragment applies to r5's defconfig which prevents us from doing a
>> conditional build of tispl or tifalcon at the a53 stage.
>>=20
>
> You might also be able to add a config fragment that would be applied
> to the A53 stage. It would only be used for this one binman task,
> but isn't that all the A53 build does in the falcon boot case anyway?
>

I don't see much value to such a config fragment, we already create
unsigned binaries without having a conditional build for it. Existing
customers can continue using tispl as usual and ignore the tifalcon.bin
file just like any other binaries binman produces.

>> Either we move the tifalcon.bin generation to r5 stage which would
>> require not only changes to the build arguments as we would now have to
>> pass OPTEE/ATF and DM's path at r5 stage but considerable changes to the
>> SDK recipes as we would now have to deploy a binary from r5's build
>> output to rootfs.
>>=20
>
> I wouldn't worry too much about the SDK, that is something we control
> and is not the only user of U-Boot.
>
> Why do we do the A53 build at all in the falcon case? If we move the
> tifalcon.bin generation to R5 stage we can skip the second build,
> which might be something worth doing just for that reason. Side benefit
> is it would fix the above issue with non-functional `tispl_falcon.bin`.
>

I agree that A53 build is just an overly complicated way to package
binaries for falcon boot if you only consider OS_BOOT use case but I
expect most users would have built A53 at least once from where they can
directly use the tifalcon binary.

Having tifalcon be part of A53 build also keep the clean separation
between R5 binaries (tiboot3) and **mostly** A53 ones (optee and atf).
