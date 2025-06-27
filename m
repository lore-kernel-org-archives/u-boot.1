Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69612C7EE32
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 00:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA1A182E27;
	Fri, 27 Jun 2025 02:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVERdnKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63F982E34; Fri, 27 Jun 2025 02:01:52 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC7B82C65
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 02:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55R01j872264883;
 Thu, 26 Jun 2025 19:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750982505;
 bh=UQkeBxt8pS0Vh1aUGRo5BntFbz14XXmvdbS95aBUZOw=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=IVERdnKIO41VRAMWm+SV9mAnbeHQ3CLZ+uLb+BycBzpgWc5U6/oQIdUCSgdZWB8O1
 AevM5llhBO5bCiCBRx8RkYK7oNIAEZv7ZzMOfor/1lstukjQiUGzWRNPGlVQ/5dige
 OHNqZkxFpNYo9voUX4JUmu0p1lfYBRUtkyotrVy8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55R01jhm2438313
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 19:01:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 19:01:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 19:01:44 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55R01iwX1851333;
 Thu, 26 Jun 2025 19:01:44 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Jun 2025 05:31:03 +0530
Message-ID: <DAWVHAV5O7DD.319BE0HLA4EF4@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [RFC PATCH v1 2/4] spl: Kconfig: allow disabling fallback
 during os boot
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250626120443.1405409-1-anshuld@ti.com>
 <20250626120443.1405409-3-anshuld@ti.com>
 <20250626234723.GZ4003484@bill-the-cat>
In-Reply-To: <20250626234723.GZ4003484@bill-the-cat>
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

On Fri Jun 27, 2025 at 5:17 AM IST, Tom Rini wrote:
> On Thu, Jun 26, 2025 at 05:34:40PM +0530, Anshul Dalal wrote:
>
>> During falcon boot in FS mode, if the SPL fails to load the payload
>> (kernel image and args), the execution fallbacks to standard u-boot boot
>> mode.
>>=20
>> This might not be desired in cases when u-boot payload (tifalcon.bin in
>> our case) is dysfuncitonal by itself or user's access to standard u-boot
>> should be restricted (for security reasons for example).
>>=20
>> In our falcon use case, this fallback allows the user to bypass
>> authenticated boot by just deleting the fitImage which causes SPL to
>> reload tifalcon.bin. The boot proceeds as usual until ATF jumps to
>> PRELOADED_BL33_BASE where the kernel has not been loaded causing the
>> core to execute whatever else was written at that address.
>>=20
>> Therefore this patch adds a new config symbol SPL_FALCON_ALLOW_FALLBACK
>> that explicitly toggles the fallback for MMC FS boot. It is set to 'y'
>> by default so as to not break any existing falcon mode systems.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  common/spl/Kconfig   | 10 +++++
>>  common/spl/spl_mmc.c | 87 ++++++++++++++++++++++++++++----------------
>>  2 files changed, 65 insertions(+), 32 deletions(-)
>>=20
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index 8d153c2e9c9..d5d3a41ce61 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1203,6 +1203,16 @@ config SPL_SECURE_OS_BOOT
>>  	  Enables support for secure boot in falcon mode by restricting the SP=
L to
>>  	  only loading a fitImage instead of raw kernel images or DTBs.
>> =20
>> +config SPL_FALCON_ALLOW_FALLBACK
>
> SPL_OS_BOOT_ALLOW_FALLBACK please.
>
>> +	bool "Allow fallback to regular boot if falcon mode fails"
>> +	depends on SPL_OS_BOOT && SYS_MMCSD_FS_BOOT && !SPL_SECURE_OS_BOOT
>
> This should just be SPL_OS_BOOT && !SPL_OS_BOOT_SECURE.
>
> Then in a follow-up patch we need to go and modify spl_*_load_os to make
> use of the new flag and if fail to load the OS image we panic() if we
> can't fall back.

A quick general question here, in cases where we want a function to lead
to a boot failure. Is it better to return an error, hoping the caller to
handle it and stop the boot process or panic within the function body to
begin with?

int spl_do_*_os_boot() {
	int ret =3D spl_load_kernel_image(...);

	if (ret && !CONFIG_IS_ENABLED(OS_BOOT_ALLOW_FALLBACK))
		return ret; OR panic("Failed to os boot");

	/* fallback */
}

From a security PoV, I see the point in explicitly halting the boot
right within the function body but returning the error conforms to
standard error handling practices.

Regards,
Anshul

