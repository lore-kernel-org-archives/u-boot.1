Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8A0E9E2EC
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E260B831AC;
	Wed, 11 Feb 2026 12:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2991983015; Wed, 11 Feb 2026 12:48:01 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 17CAF83CE3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1382339;
 Wed, 11 Feb 2026 03:47:50 -0800 (PST)
Received: from debian (MacBookPro.nice.Arm.com [10.34.111.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E02E3F63F;
 Wed, 11 Feb 2026 03:47:56 -0800 (PST)
Date: Wed, 11 Feb 2026 12:47:53 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: fix ecpt size computation
Message-ID: <aYxsaXdISybHOQTq@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
 <a386de9e-1dc9-4b50-a86c-bb8dfd845eef@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a386de9e-1dc9-4b50-a86c-bb8dfd845eef@gmx.de>
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

On Wed, Feb 11, 2026 at 10:56:30AM +0100, Heinrich Schuchardt wrote:
> On 2/11/26 10:33, Vincent Stehlé wrote:
> > The size of the memory allocated for the EFI Conformance Profiles Table is
> > computed with `num_entries' always equal to zero, which is incorrect when
> > CONFIG_EFI_EBBR_2_1_CONFORMANCE is enabled.
> > 
> > This can be verified by allocating the ECPT memory with malloc() instead of
> > efi_allocate_pool(), building u-boot with sandbox_defconfig and
> > CONFIG_VALGRIND=y, and by finally running the following command:
> > 
> >    valgrind --suppressions=scripts/u-boot.supp \
> >      ./u-boot -T -c 'efidebug tables'
> > 
> > Fix this by using an array of the supported profiles GUIDs instead, which
> > should also be easier to extend in the future.
> 
> Thank you Vincent for this patch.

Hi Heinrich,

Thanks for reviewing.

> Maybe mention in the commit message that U-Boot should publish all supported
> EBBR revisions.

Ok, will do.

> 
> > 
> > Fixes: 6b92c1735205 ("efi: Create ECPT table")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Jose Marinho <jose.marinho@arm.com>
> > ---
> >   lib/efi_loader/efi_conformance.c | 18 +++++++++---------
> >   1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> > index 2bae93a94bd..9768b5ae824 100644
> > --- a/lib/efi_loader/efi_conformance.c
> > +++ b/lib/efi_loader/efi_conformance.c
> > @@ -13,8 +13,12 @@
> >   #include <malloc.h>
> >   static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> > -static const efi_guid_t efi_ebbr_2_1_guid =
> > -	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
> > +
> > +static const efi_guid_t profiles[] = {
> 
> As profiles[] is not used outside efi_ecpt_register(), there is no need to
> make it a static variable.

I am not sure why a "global" symbol would be better than a static one, but if
you like this solution we could make the profiles[] array extern.

Then I guess we should rename it with a much longer name to avoid namespace
"pollution":

	const efi_guid_t efi_conformance_profiles[] = {
		...

All the sizeof() and ARRAY_SIZE() would have to follow, too.

Alternatively, we could move the array declaration inside the
efi_ecpt_register() function completely:

	efi_status_t efi_ecpt_register(void)
	{
		struct efi_conformance_profiles_table *ecpt;
		efi_status_t ret;
		size_t ecpt_size;

		static const efi_guid_t profiles[] = {
		#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
			EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
		#endif
		};

		...

This is still static here, but for storage duration not linkage. One advantage
is that the name would not have to change. I am not a big fan of the #if in
function scope, but if you prefer this solution this is fine as well.

Best regards,
Vincent.

> 
> Otherwise looks good to me.
> 
> Best regards
> 
> Heinrich
> 
> 
> > +#if CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE)
> > +	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID,
> > +#endif
> > +};
> >   /**
> >    * efi_ecpt_register() - Install the ECPT system table.
> > @@ -23,12 +27,11 @@ static const efi_guid_t efi_ebbr_2_1_guid =
> >    */
> >   efi_status_t efi_ecpt_register(void)
> >   {
> > -	u16 num_entries = 0;
> >   	struct efi_conformance_profiles_table *ecpt;
> >   	efi_status_t ret;
> >   	size_t ecpt_size;
> > -	ecpt_size = num_entries * sizeof(efi_guid_t)
> > +	ecpt_size = sizeof(profiles)
> >   		+ sizeof(struct efi_conformance_profiles_table);
> >   	ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, ecpt_size,
> >   				(void **)&ecpt);
> > @@ -39,12 +42,9 @@ efi_status_t efi_ecpt_register(void)
> >   		return ret;
> >   	}
> > -	if (CONFIG_IS_ENABLED(EFI_EBBR_2_1_CONFORMANCE))
> > -		guidcpy(&ecpt->conformance_profiles[num_entries++],
> > -			&efi_ebbr_2_1_guid);
> > -
> > +	memcpy(ecpt->conformance_profiles, profiles, sizeof(profiles));
> >   	ecpt->version = EFI_CONFORMANCE_PROFILES_TABLE_VERSION;
> > -	ecpt->number_of_profiles = num_entries;
> > +	ecpt->number_of_profiles = ARRAY_SIZE(profiles);
> >   	/* Install the ECPT in the system configuration table. */
> >   	ret = efi_install_configuration_table(&efi_ecpt_guid, (void *)ecpt);
> 
