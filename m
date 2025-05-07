Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A4C3ABBC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 03:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25D881F66;
	Wed,  7 May 2025 05:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BuKjHdiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 750EC81FAB; Wed,  7 May 2025 05:33:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A78F8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 05:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5473XqM8687594
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 22:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746588832;
 bh=V0x76Ks/vV/eNQg/WfLtxExIAlQ02LhDQQv6mRgQvCk=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=BuKjHdiYkJuERsKs43DYAGziaIwl3AYNE8WauBkGHuyszhF3Ws9M+7oy97yTPA9fH
 trTcAD0DqbHgl/z4skQklZq5acUNLbNGNAws1dTlxxVtoV+FnRzccnjaWhPRLj+HXi
 QlsDxF0z8mmnoSeWKqm6ytikDX1+yhj1HG4IYpcI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5473XqKF007673
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 22:33:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 22:33:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 22:33:52 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5473Xpto008027;
 Tue, 6 May 2025 22:33:52 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 7 May 2025 09:03:30 +0530
Message-ID: <D9PM26J8COAY.1ACTT0I6VHQJH@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
Subject: Re: [PATCH v6 1/9] spl: Kconfig: allow K3 devices to use falcon mode
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250428141235.1734014-1-anshuld@ti.com>
 <20250428141235.1734014-2-anshuld@ti.com>
 <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
In-Reply-To: <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
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

On Tue May 6, 2025 at 8:03 PM IST, Andrew Davis wrote:
> On 4/28/25 9:12 AM, Anshul Dalal wrote:
>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
>> HS devices and can be enabled on K3 devices.
>>=20
>> For secure boot, the kernel with x509 headers can be packaged in a fit
>
> "can be", this is the issue. Security is not just allowing methods that
> are security checked, but forcing the use of such methods. Setting
> OS_BOOT opens up several paths that look for non-FIT images. These
> images do not enforce authentication like FIT does. This means one can
> bypass secure boot when OS_BOOT is enabled by simply placing a non-FIT
> boot image on the boot media.
>

As per spl_load_image_ext_os, the SPL first tries to load the file set
in falcon_args_file env variable but since it's not set in our case. And
the only way to set them is by rebuilding u-boot as uEnv.txt is not
supported at SPL stage.

This means the SPL only loads CONFIG_SPL_FS_LOAD_ARGS_NAME and
CONFIG_SPL_FS_LOAD_KERNEL_NAME which are set as the DTB and fitImage
respectively. Following that, authentication is enforced during FIT
loading by the call to board_fit_image_post_process in load_simple_fit.

So even if the fitImage was modified, boot would fail without valid
signatures on HS-SE devices.

- Anshul

>> container (fitImage) signed with TIFS keys for authentication.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   common/spl/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index c08045f9c8d..68e900e9b91 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1165,7 +1165,7 @@ config SPL_ONENAND_SUPPORT
>>  =20
>>   config SPL_OS_BOOT
>>   	bool "Activate Falcon Mode"
>> -	depends on !TI_SECURE_DEVICE
>> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>>   	help
>>   	  Enable booting directly to an OS from SPL.
>>   	  for more info read doc/README.falcon

