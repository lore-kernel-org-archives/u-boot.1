Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FFACAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 12:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E0E83447;
	Wed, 24 Sep 2025 14:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PhI9Rgjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A26983448; Wed, 24 Sep 2025 14:55:37 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32AC800D7
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 14:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OCtSkN1700408;
 Wed, 24 Sep 2025 07:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758718528;
 bh=ppol2CkhfcaECH+xd085CQYh4WQBPVhkJiHj5ZEg4f0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PhI9Rgjxgx+xlhOaInUuULwFxH7LkzdAE5Sn5GACIGbtOhUgd+y2UfvTiUD4ZysHl
 wP3X78JcBTWthRqNUM7UhqRuLiulPY/g+SIYFFysjAsdKBbOVM70uwIAgNfzl5fZId
 R/CSf2gW6D92cWJJEaDJukhGfg8+j/Oei8l3/Rwo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OCtSqG2762764
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 24 Sep 2025 07:55:28 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 07:55:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 07:55:27 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OCtQHo2028232;
 Wed, 24 Sep 2025 07:55:27 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Sep 2025 18:25:25 +0530
Message-ID: <DD11OP1DYB5Y.4ABDK7GP4SSO@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>,
 <kever.yang@rock-chips.com>, <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 2/8] spl: Kconfig: allow K3 devices to use falcon mode
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250923130901.705124-1-anshuld@ti.com>
 <20250923130901.705124-3-anshuld@ti.com>
 <134414a0-8fcc-4fb0-9f53-3dc803d41b70@ti.com>
In-Reply-To: <134414a0-8fcc-4fb0-9f53-3dc803d41b70@ti.com>
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

On Tue Sep 23, 2025 at 9:48 PM IST, Andrew Davis wrote:
> On 9/23/25 8:08 AM, Anshul Dalal wrote:
>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
>> HS devices and but can now be enabled with the addition of
>> OS_BOOT_SECURE.
>>=20
>> For secure boot, the kernel with x509 headers can be packaged in a fit
>> container (fitImage) signed with TIFS keys for authentication.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   common/spl/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 7e87e50f693..ab780da9e1c 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1201,7 +1201,7 @@ config SPL_ONENAND_SUPPORT
>>  =20
>>   config SPL_OS_BOOT
>>   	bool "Activate Falcon Mode"
>> -	depends on !TI_SECURE_DEVICE
>> +	select SPL_OS_BOOT_SECURE if TI_SECURE_DEVICE
>>   	help
>>   	  Enable booting directly to an OS from SPL.
>>   	  for more info read doc/README.falcon
>
> The subject doesn't need to include "K3", this is for all
> TI secure devices.
>

Oh yeah, will fix in the next revision.

> This patch should also go last in the series. Not that it
> causes any break, but feels like a "security bisectability"
> problem to allow something and then after make it secure.
>

I was more looking at it from the ability to test the subsequent patches
in the series on any TI platform which would depend on this [2/8] patch.

Though your concern is valid too but there are still a few things
remaining from this series that would need to be implemented to make
falcon mode truly secure on TI_SECURE_DEVICE. Perhaps we should drop
this patch until everything's in place?

Regards,
Anshul
