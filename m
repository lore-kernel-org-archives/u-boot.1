Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38726C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 07:29:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F28282A36;
	Mon,  9 Jun 2025 09:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RAI6NWmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33BA82A65; Mon,  9 Jun 2025 09:28:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C90882958
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 09:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5597Ss05730116;
 Mon, 9 Jun 2025 02:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749454134;
 bh=riAXIvsfXNBmib6aPuUT6MR7zjJy+gBebzzoMPhvqSM=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=RAI6NWmUwb0Wy/bPQ/G3+NZ3No5NjYF60bTYqLnjsUACNcqd1VWNsfSzcIMhlkOcH
 kj328MWNU1BWuf0t5lvD89lEjIo2aIJ4cOZweytfAHK3YgsDjrLKJ++8GLAYyXKny+
 AalfGYChsy/Il4SBpTQ8YX/VMIBEADlwkoNggXCw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5597SsHN4096076
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 02:28:54 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 02:28:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 02:28:54 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5597Sreg897828;
 Mon, 9 Jun 2025 02:28:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 12:58:19 +0530
Message-ID: <DAHTPYAY74YM.1NOHZR0BX3KPD@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>
Subject: Re: [PATCH v7 04/10] arch: arm: k3-binman: add fit for falcon boot
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-5-anshuld@ti.com>
 <20250606115719.eyu2vk3zdwygzmc2@bryanbrattlof.com>
In-Reply-To: <20250606115719.eyu2vk3zdwygzmc2@bryanbrattlof.com>
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

On Fri Jun 6, 2025 at 5:27 PM IST, Bryan Brattlof wrote:
> On June  3, 2025 thus sayeth Anshul Dalal:
>> This adds creation of tispl_falcon.bin for the am62a, 62p and 62x.
>>=20
>> The contents are the same as the existing tispl.bin but A53's spl and
>> the fdt have been removed as they are not needed in falcon boot.
>>=20
>> This reduces boot time since the payload size is smaller and we also
>> aren't authenticating the spl and fdt in secure boot.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/dts/k3-am625-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>>  arch/arm/dts/k3-am62a-sk-binman.dtsi | 64 ++++++++++++++++++++++++++++
>>  arch/arm/dts/k3-am62p-sk-binman.dtsi | 51 ++++++++++++++++++++++
>>  arch/arm/dts/k3-binman.dtsi          | 54 +++++++++++++++++++++++
>>  4 files changed, 233 insertions(+)
>>=20
>> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am62=
5-sk-binman.dtsi
>> index cc619f5920e..9544b9d1134 100644
>> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
>> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
>
> ...
>
>> +				dm {
>> +					ti-secure {
>> +						content =3D <&dm_falcon>;
>> +						keyfile =3D "custMpk.pem";
>> +					};
>> +					dm_falcon: ti-dm {
>> +						filename =3D "ti-dm.bin";
>> +					};
>
> When you build this are you using the TI_DM argument? Or are you using=20
> BINMAN_INDIRS to point to all the firmware? I think this will only look=
=20
> for "${BINMAN_INDIRS}/ti-dm.bin" and error out now that DM is mandatory=
=20
> unless you use TI_DM which will break a few distro builders' recipes
>

It relies on BINMAN_INDIRS still and I hadn't updated the dm node since
c492a55fe4 ("arm: dts: k3: binman: Fix DM firmware selection"). I will
fix this in the next revision. Thanks for bringing it to my attention.

>
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index 5163161b94d..a678379dae9 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -489,6 +489,60 @@
>>  		end_address =3D <0x0 0x9fffffff>;
>>  	};
>> =20
>> +	ti_falcon_template: template-9 {
>> +		filename =3D "tispl_falcon.bin";
>
> Small nitpick: We could probably just call this tifalcon.bin or=20
> something shorter. It's not really an SPL now.
>
> The bigger issue here (in my mind) is this requires our falcon.config=20
> fragment to work properly. I don't think it is wise of use to produce=20
> this image if that fragment isn't applied. It would be a debugging=20
> nightmare for others outside of the U-Boot space.
>

The fragment applies to r5's defconfig which prevents us from doing a
conditional build of tispl or tifalcon at the a53 stage.

Either we move the tifalcon.bin generation to r5 stage which would
require not only changes to the build arguments as we would now have to
pass OPTEE/ATF and DM's path at r5 stage but considerable changes to the
SDK recipes as we would now have to deploy a binary from r5's build
output to rootfs.

Binman already produces a lot of binaries during the A-core build most
of which the end users doesn't care about. I don't see how adding
tifalcon could become a "debugging nightmare".

Regards,
Anshul
