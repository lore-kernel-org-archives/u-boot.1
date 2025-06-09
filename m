Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C166DC61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 12:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD7E826AA;
	Mon,  9 Jun 2025 14:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YU1Qsc6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5415E82AA7; Mon,  9 Jun 2025 14:09:16 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239A2811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 14:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559C9CWd763003;
 Mon, 9 Jun 2025 07:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749470952;
 bh=Tv34fIUt87t89i/5147ojRxL5CRMF8HB5H+lFNl0rWM=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=YU1Qsc6e4xLalASP1srpYFVxbEv7g3bLvNnliRknnnBpFB5K2x83KNM2vm2bvugAN
 dvT/q2aTdjUdfGFfjvohudZsfOGA2kzGhcWso7NsEd+NUKV+AxMTB6ytEouxnZl0HQ
 xpZdwH1rSpZKM9vehLNaeEZjXCD7Idx0Ww3HDMm0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559C9C9G066672
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 07:09:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 07:09:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 07:09:12 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559C9BVM1234611;
 Mon, 9 Jun 2025 07:09:11 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 17:38:37 +0530
Message-ID: <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat>
In-Reply-To: <20250606190625.GZ1382132@bill-the-cat>
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

On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
>
>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
>> HS devices and can be enabled on K3 devices.
>>=20
>> For secure boot, the kernel with x509 headers can be packaged in a fit
>> container (fitImage) signed with TIFS keys for authentication.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  common/spl/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 77cf04d38ed..bc5a334a1c5 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
>> =20
>>  config SPL_OS_BOOT
>>  	bool "Activate Falcon Mode"
>> -	depends on !TI_SECURE_DEVICE
>> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>>  	help
>>  	  Enable booting directly to an OS from SPL.
>>  	  for more info read doc/README.falcon
>
> I wonder if overloading ARCH_K3 like this isn't a great idea. Or perhaps
> TI_SECURE_DEVICE is too generic a name. I kind of want to introduce
> something that means TI Secure Boot is supported but also Falcon is
> supported, and then use that as how we disable in Kconfig various
> insecure options. And I assume that it's a matter of effort not
> technical restrictions for supporting falcon mode on older HS parts?

I second your opinion here, the falcon boot flow we do have in K3
devices is quite different from existing platforms but still enabled by
the same SPL_OS_BOOT config. Perhaps adding a config like K3_FALCON
makes sense here.

And yes, older HS *K3* parts should be able to support a similar falcon
style boot flow with not much changes to the k3_falcon_prep function.

