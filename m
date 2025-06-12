Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D68C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 04:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8622E82977;
	Thu, 12 Jun 2025 06:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dt6Q211c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8454C82A4B; Thu, 12 Jun 2025 06:36:19 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE4B828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 06:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C4aFu31558985;
 Wed, 11 Jun 2025 23:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749702975;
 bh=CtKoCho3K7upAoG3PldFWNhAh7qBKzcpHiQT+2Ci6gU=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=Dt6Q211c2b/EQ4w/W/mY45A/3v0f2np2znQ/cg2IVQMg6ZysnlI2negaCHSO8STLs
 /MQ4KfmA6oxAcXk+p1cI8+d57ogJi1NMa+j3wVQbMSq0qAJPkYJOuMn8LHCMzeeFfk
 9eK1+3l8HrZrbJb9nVUsnGmvaD8FBvwFvJ70Mu1c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C4aFm52277072
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 23:36:15 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Jun 2025 23:36:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Jun 2025 23:36:14 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C4aEc21403498;
 Wed, 11 Jun 2025 23:36:14 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jun 2025 10:05:38 +0530
Message-ID: <DAK9XDDNWUX4.1IRWBI9YA4MKG@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat> <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
 <20250609145919.GN1382132@bill-the-cat> <DAIPP8VS7YQO.3PK5EYRE3D11A@ti.com>
 <20250610144444.GY1382132@bill-the-cat>
In-Reply-To: <20250610144444.GY1382132@bill-the-cat>
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

On Tue Jun 10, 2025 at 8:14 PM IST, Tom Rini wrote:
> On Tue, Jun 10, 2025 at 02:01:59PM +0530, Anshul Dalal wrote:
>> On Mon Jun 9, 2025 at 8:29 PM IST, Tom Rini wrote:
>> > On Mon, Jun 09, 2025 at 05:38:37PM +0530, Anshul Dalal wrote:
>> >> On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
>> >> > On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
>> >> >
>> >> >> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437=
bc
>> >> >> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 3=
2-bit
>> >> >> HS devices and can be enabled on K3 devices.
>> >> >>=20
>> >> >> For secure boot, the kernel with x509 headers can be packaged in a=
 fit
>> >> >> container (fitImage) signed with TIFS keys for authentication.
>> >> >>=20
>> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> >> >> ---
>> >> >>  common/spl/Kconfig | 2 +-
>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>=20
>> >> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> >> >> index 77cf04d38ed..bc5a334a1c5 100644
>> >> >> --- a/common/spl/Kconfig
>> >> >> +++ b/common/spl/Kconfig
>> >> >> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
>> >> >> =20
>> >> >>  config SPL_OS_BOOT
>> >> >>  	bool "Activate Falcon Mode"
>> >> >> -	depends on !TI_SECURE_DEVICE
>> >> >> +	depends on !TI_SECURE_DEVICE || ARCH_K3
>> >> >>  	help
>> >> >>  	  Enable booting directly to an OS from SPL.
>> >> >>  	  for more info read doc/README.falcon
>> >> >
>> >> > I wonder if overloading ARCH_K3 like this isn't a great idea. Or pe=
rhaps
>> >> > TI_SECURE_DEVICE is too generic a name. I kind of want to introduce
>> >> > something that means TI Secure Boot is supported but also Falcon is
>> >> > supported, and then use that as how we disable in Kconfig various
>> >> > insecure options. And I assume that it's a matter of effort not
>> >> > technical restrictions for supporting falcon mode on older HS parts=
?
>> >>=20
>> >> I second your opinion here, the falcon boot flow we do have in K3
>> >> devices is quite different from existing platforms but still enabled =
by
>> >> the same SPL_OS_BOOT config. Perhaps adding a config like K3_FALCON
>> >> makes sense here.
>> >>=20
>> >> And yes, older HS *K3* parts should be able to support a similar falc=
on
>> >> style boot flow with not much changes to the k3_falcon_prep function.
>> >
>> > Maybe we need a common symbol for things that are common to all TI
>> > secure devices, and other symbols for K3 or AM33xx (or whatever is mos=
t
>> > appropriate for that overall era of parts).
>>=20
>> I was thinking of adding TI_SECURE_DEVICE_(LEGACY|K3) hidden config
>> symbols which TI_SECURE_DEVICE selects as below:
>>=20
>> config TI_SECURE_DEVICE
>> 	bool "HS Device Type Support"
>> 	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS || ARCH_K3
>> 	select TI_SECURE_DEVICE_LEGACY if ARCH_KEYSTONE || ARCH_OMAP2PLUS
>> 	select TI_SECURE_DEVICE_K3 if ARCH_K3
>>=20
>> We can then use TI_SECURE_DEVICE_LEGACY to disable OS_BOOT for older non
>> K3 platforms instead.
> =20
> The current tech today is the legacy tech tomorrow, so I think a better
> symbol name is needed for ARCH_KEYSTONE || ARCH_OMAP2PLUS, especially
> since the next question is how much do they in fact share in terms of

Agreed, I will update the names to be more descriptive of specific device.

> tooling and features. But I was also thinking that TI_SECURE_DEVICE
> should be a hidden symbol too, and used for the common-if-any parts, and
> so SPL_OS_BOOT would depend on !TI_SECURE_DEVICE_K2_OMAP2PLUS or
> whatever.

I don't think we should make TI_SECURE_DEVICE hidden since iot2050 is a
defconfig that disables TI_SECURE_DEVICE while being ARCH_K3, it's also
useful to expose it as a config to users in cases of GP devices for
example.

If we are in agreement here, I can post v8 with the suggested changes ;)
