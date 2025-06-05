Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490D7C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 04:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BE44801BE;
	Thu,  5 Jun 2025 06:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V0t/lyPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAE88070C; Thu,  5 Jun 2025 06:06:31 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076EE8004F
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 06:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55546RKd3992569;
 Wed, 4 Jun 2025 23:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749096387;
 bh=mb0mfbzjaTuS1faR83q966LBRz10RLuElCLXxQozzOI=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=V0t/lyPgl7zClC4UgPZ9i1qtlUtInm9mM93jEbI0U/tvPmB9j6pe+p3svPHaBDZwR
 eLplYEo73ndNwN80/z9TcQir28oFPSJgkTC7f7YrjYH5g3+Ry8ULimFSZ61ywGpw8x
 AwW8uGpn1RHXeEgJmh344fA+NaRmtuBEywnTFZjU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55546RZQ863508
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 4 Jun 2025 23:06:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Jun 2025 23:06:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Jun 2025 23:06:26 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55546QGk3098262;
 Wed, 4 Jun 2025 23:06:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 5 Jun 2025 09:35:53 +0530
Message-ID: <DAEAWS5319D9.FLN1SH37WR8D@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v1] ti: k3: abstract common fdt api for reserved mem fixups
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250522150941.563959-1-anshuld@ti.com>
 <20250604175741.GA1940110@bill-the-cat>
In-Reply-To: <20250604175741.GA1940110@bill-the-cat>
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

On Wed Jun 4, 2025 at 11:27 PM IST, Tom Rini wrote:
> On Thu, May 22, 2025 at 08:39:40PM +0530, Anshul Dalal wrote:
>
>> The usage of fdt_fixup_reserved is repeated for ATF and OP-TEE for
>> multiple platforms, this patch creates a single fdt API for fixing up
>> the reserved-memory node with added error handling.
>>=20
>> All k3 platforms already share a common tispl template which ensures
>> binaries are loaded as per the respective CONFIG_*_LOAD_ADDR. And the
>> provided new_size for the fixup is overridden by the size from fdt node
>> anyways. This allows for safe abstraction of the reserved memory fixups
>> for all current platforms.
>>=20
>> fdt_fixup_reserved now abstracts the ATF and OP-TEE fixups by calling
>> the renamed static fdt_fixup_reserved_memory function with the required
>> parameters.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> [snip]
>
> I think this shows the start of fixing up some problems, but that we
> need to do more.
>
>> diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am6=
2ax/am62a7_fdt.c
>> index 7f764ab36b5..9a4599432ff 100644
>> --- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> +++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
>> @@ -10,8 +10,5 @@
>> =20
>>  int ft_system_setup(void *blob, struct bd_info *bd)
>>  {
>> -	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
>> -	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000=
);
>> -
>> -	return 0;
>> +	return fdt_fixup_reserved(blob);
>>  }
>
> This is good.
>
>> diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am6=
2px/am62p5_fdt.c
>> index 2c40fa5a594..9f4b1663864 100644
>> --- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
>> +++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
>> @@ -92,8 +92,5 @@ int ft_system_setup(void *blob, struct bd_info *bd)
>>  	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
>>  	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
>>  	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
>
> Is it really OK for any of the above fixups to fail to happen and be
> silently ignored? fdt_fixup_thermal_zone_nodes_am62p() for example looks
> like it throws away error conditions from functions it calls. And other
> boards are doing similar things.
>

Yeah, all fdt_fixup_* currently don't propogate the errors to the caller
(ft_system_setup). I will refactor the fdt_fixup_* functions to return
errors instead, we can then decide in ft_system_setup whether to ignore
them with a warning log or fail booting by propogating the error
upwards.

[snip]
>> +	ret =3D fdt_fixup_reserved_memory(blob, "optee",
>> +					CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>
> But we can just return fdt_fixup_reserved_memory(...) here.

You're right, will be fixed in the next revision.

Thanks for the review Tom,
Anshul
