Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF545C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 15:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A73D839EC;
	Fri, 25 Jul 2025 17:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8022839F3; Fri, 25 Jul 2025 17:56:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 773D1839E4
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 17:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5F7B176C;
 Fri, 25 Jul 2025 08:56:17 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.31.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E43353F6A8;
 Fri, 25 Jul 2025 08:56:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:56:14 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v3 17/24] fwu_arm_psa: Add ESRT support
Message-ID: <20250725155614.GA286785@e130802.arm.com>
References: <20250721111816.62340-1-abdellatif.elkhlifi@arm.com>
 <20250721111816.62340-18-abdellatif.elkhlifi@arm.com>
 <58d20e4a-6b5e-4217-a95a-0643a37d1a09@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d20e4a-6b5e-4217-a95a-0643a37d1a09@amd.com>
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

Hi Michal,

> 
> 
> On 7/21/25 13:18, abdellatif.elkhlifi@arm.com wrote:
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > 
> > Read ESRT data from Secure world in GetImageInfo()
> > 
> > Use FWU_READ_STREAM ABI to read ESRT data from Secure world.
> > 
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Michal Simek <michal.simek@amd.com>
> > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > Cc: Casey Connolly <casey.connolly@linaro.org>
> > 
> > ---
> > 
> > Changelog of changes:
> > ===========================
> > 
> > v2:
> > 
> > * As suggested by Michal: Add /** for marking kernel-doc format
> > 
> > v1:
> > 
> > * Read ESRT data from Secure world in GetImageInfo()
> > 
> >   include/fwu_arm_psa.h         |  13 ++++
> >   lib/fwu_updates/fwu_arm_psa.c | 116 +++++++++++++++++++++++++++++++---
> >   2 files changed, 119 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
> > index 6400cf44d1b..38fb9bde165 100644
> > --- a/include/fwu_arm_psa.h
> > +++ b/include/fwu_arm_psa.h
> > @@ -16,6 +16,9 @@
> >   #define DEFAULT_HW_INSTANCE		(1)
> > +/* The minimum supported ESRT version */
> > +#define EFI_SYSTEM_RESOURCE_TABLE_FIRMWARE_RESOURCE_VERSION		(1)
> > +
> >   /* Default values of the ESRT fields which are not supported at this stage */
> >   #define PACKAGE_VERSION_NOT_SUP		(0xffffffff)
> >   #define LAST_ATTEMPT_NOT_SUP		(0)
> > @@ -355,6 +358,16 @@ struct __packed fwu_image_directory {
> >   	struct fwu_image_info_entry entries[FWU_DIRECTORY_IMAGE_ENTRIES_COUNT];
> >   };
> > +/**
> > + * struct fwu_esrt_data_wrapper - Wrapper for the ESRT data
> > + * @data: The ESRT data read from secure world
> > + * @entries: The ESRT entries
> > + */
> > +struct __packed fwu_esrt_data_wrapper {
> > +	struct efi_system_resource_table  data;
> 
> double space
> 
> > +	struct efi_system_resource_entry entries[CONFIG_FWU_NUM_IMAGES_PER_BANK];
> > +};
> > +
> >   /**
> >    * fwu_agent_init() - Setup the FWU agent
> >    *
> > diff --git a/lib/fwu_updates/fwu_arm_psa.c b/lib/fwu_updates/fwu_arm_psa.c
> > index 40746eee6ce..7297e724569 100644
> > --- a/lib/fwu_updates/fwu_arm_psa.c
> > +++ b/lib/fwu_updates/fwu_arm_psa.c
> > @@ -27,6 +27,7 @@ static u8 g_fwu_version_minor;
> >   static bool g_fwu_initialized;
> >   struct fwu_image_directory g_fwu_cached_directory;
> >   efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
> > +struct fwu_esrt_data_wrapper g_esrt_data;
> >   /* Error mapping declarations */
> > @@ -898,6 +899,100 @@ close_handle:
> >   	return ret;
> >   }
> > +/**
> > + * fwu_esrt_sanity_check() - Verify ESRT data
> > + *
> > + * Make sure the ESRT data matches the directory data.
> > + *
> > + * Return:
> > + *
> > + * 0 on success
> > + */
> 
> Please run
> ./scripts/kernel-doc -man -v 1>/dev/null lib/fwu_updates/fwu_arm_psa.c
> 
> and fix issues created by new added code.
> 
> And obviously here you are returning more then just 0.

Thanks for the review. All comments have been addressed in patchset v4.

Cheers
Abdellatif
