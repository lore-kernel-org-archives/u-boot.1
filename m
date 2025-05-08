Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17FFC3ABC3
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 03:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4E1820EB;
	Thu,  8 May 2025 05:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KPCD92jn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460978210D; Thu,  8 May 2025 05:12:37 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8510781FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 05:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5483CWiM1717187
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 May 2025 22:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746673952;
 bh=h8hSZfgURx05LVrSgqI2UKL2uU9PGDzpcWEhSp28jv8=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=KPCD92jnElBKkYiJJQJFH1QC/T6JJYvYKnk56bTU+XEX2m2MfGSF+MFWC08OS7rwr
 4FPcLHS9NldRUoYJ1VnPOMOca63cpzzNlOY/PDio4t4B93+IMUxa1G+hWrf/BXHofJ
 3oTJq/3leQJ2Cnpg0wuh2r2M59UF9+5AF0wrmnrQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5483CW1p010975
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 May 2025 22:12:32 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 May 2025 22:12:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 May 2025 22:12:32 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5483CVOx023685;
 Wed, 7 May 2025 22:12:31 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 8 May 2025 08:42:09 +0530
Message-ID: <D9QG8DY630MX.1OV8MBZIM4R8S@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
Subject: Re: [PATCH v6 1/9] spl: Kconfig: allow K3 devices to use falcon mode
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250428141235.1734014-1-anshuld@ti.com>
 <20250428141235.1734014-2-anshuld@ti.com>
 <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
 <D9PM26J8COAY.1ACTT0I6VHQJH@ti.com>
 <3741d859-2048-4b32-9c1e-f551ec62d377@ti.com>
In-Reply-To: <3741d859-2048-4b32-9c1e-f551ec62d377@ti.com>
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

On Wed May 7, 2025 at 11:36 PM IST, Andrew Davis wrote:
> On 5/6/25 10:33 PM, Anshul Dalal wrote:
>> On Tue May 6, 2025 at 8:03 PM IST, Andrew Davis wrote:
>>> On 4/28/25 9:12 AM, Anshul Dalal wrote:
>>>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
>>>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bi=
t
>>>> HS devices and can be enabled on K3 devices.
>>>>
>>>> For secure boot, the kernel with x509 headers can be packaged in a fit
>>>
>>> "can be", this is the issue. Security is not just allowing methods that
>>> are security checked, but forcing the use of such methods. Setting
>>> OS_BOOT opens up several paths that look for non-FIT images. These
>>> images do not enforce authentication like FIT does. This means one can
>>> bypass secure boot when OS_BOOT is enabled by simply placing a non-FIT
>>> boot image on the boot media.
>>>
>>=20
>> As per spl_load_image_ext_os, the SPL first tries to load the file set
>> in falcon_args_file env variable but since it's not set in our case. And
>> the only way to set them is by rebuilding u-boot as uEnv.txt is not
>> supported at SPL stage.
>>=20
>> This means the SPL only loads CONFIG_SPL_FS_LOAD_ARGS_NAME and
>> CONFIG_SPL_FS_LOAD_KERNEL_NAME which are set as the DTB and fitImage
>
> What is stopping me from replacing the content of the file "fitImage"
> with a normal kernel image? When loading that image the file type
> will be detected as a normal kernel image and all FIT logic bypassed,
> including authentication, breaking our secure chain of trust.
>
> Andrew

That would require booti_setup to be executed in spl_parse_image_header,
which is not possible on the R5 SPL since the required config symbol
CMD_BOOTI is only available for ARM64 platforms.

In the worst case we end up loading a 32-bit zImage which wouldn't
boot on the Cortex-A cores anyway and would additionally require
enabling CMD_BOOTZ (currently disabled) at build time.

Regards,
Anshul

>
>> respectively. Following that, authentication is enforced during FIT
>> loading by the call to board_fit_image_post_process in load_simple_fit.
>>=20
>> So even if the fitImage was modified, boot would fail without valid
>> signatures on HS-SE devices.
>>=20
>> - Anshul
>>=20
>>>> container (fitImage) signed with TIFS keys for authentication.
>>>>
>>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>>> ---
>>>>    common/spl/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>>>> index c08045f9c8d..68e900e9b91 100644
>>>> --- a/common/spl/Kconfig
>>>> +++ b/common/spl/Kconfig
>>>> @@ -1165,7 +1165,7 @@ config SPL_ONENAND_SUPPORT
>>>>   =20
>>>>    config SPL_OS_BOOT
>>>>    	bool "Activate Falcon Mode"
>>>> -	depends on !TI_SECURE_DEVICE
>>>> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>>>>    	help
>>>>    	  Enable booting directly to an OS from SPL.
>>>>    	  for more info read doc/README.falcon
>>=20

