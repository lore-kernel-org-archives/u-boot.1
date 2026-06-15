Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFFDCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 09:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2473A846B0;
	Mon, 15 Jun 2026 11:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="diD76C5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8EC84704; Mon, 15 Jun 2026 11:57:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BF21A846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 11:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 371A01BF3;
 Mon, 15 Jun 2026 02:57:34 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130B53F915;
 Mon, 15 Jun 2026 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781517458; bh=LIESP9kias47XPVgh711DlveggNe7JGDPwlKnaFz9K0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=diD76C5MyfLzOqwUpC5hpwCw4/iwpFDSX+P643PrxanbZctEgkA1wefj97r20C5PO
 RxYt9yG+UhmVjfd+zdHgXyPP654Rz7ZrGXBg0WQFVsmlWN09/6POiy1lKc/pVy3mSk
 V3FGix7opwJ+y/Hp/eTiSCI4hRyWcrHoUSIoZVo4=
Date: Mon, 15 Jun 2026 11:57:35 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] efi_selftest: fix guid comparison
Message-ID: <ai_Mj-fFCbIWwmip@debian>
Mail-Followup-To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@suse.de>,
 u-boot@lists.denx.de
References: <20260611092926.578977-1-vincent.stehle@arm.com>
 <377d6138-c90f-4da2-98a7-7507003ba91f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377d6138-c90f-4da2-98a7-7507003ba91f@gmx.de>
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

On Sat, Jun 13, 2026 at 10:22:39AM +0200, Heinrich Schuchardt wrote:
> On 6/11/26 11:29, Vincent Stehlé wrote:
> > The `loaded image' efi selftest is comparing protocol GUIDs with the wrong
> > polarity.
> > This can be verified on the sandbox, where two protocols GUIDs are
> > retrieved by the test from the image handle in the following order:
> > 
> > 1. Loaded Image Device Path Protocol GUID
> > 2. Loaded Image Protocol GUID
> > 
> > The test matches on the first GUID, while it is in fact looking for the
> > second one; fix the comparison polarity.
> > 
> > While at it, use guidcmp() instead of memcmp() to spare the size parameter,
> > and use the Loaded Image Protocol GUID definition from efi_api.h instead or
> > redefining it locally.
> 
> Hello Vincent,
> 
> Thank you for catching the issue with the incorrect checkout for the Loaded
> Image Protocol.

Hi Heinrich,

Thanks for your review.

> We never use U-Boot library functions in efi_selftest to allow converting it
> into a standalone EFI application.

Ok, this makes sense.
I will send a v2 keeping memcmp().

Note that I see 4 calls to guidcmp() in the selftests already. I think this does
not harm in practice because guidcmp() this is marked inline.
I also see more than a dozen places where memcmp() is used to compare GUIDs in
the selftests.

Would you like me to send another series to add a local definition of guidcmp()
for the selftests and convert all memcmp() when appropriate?
Or should I rather send a series converting all uses of guidcmp() in the
selftests to memcmp(), maybe?

> 
> > 
> > Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Alexander Graf <agraf@suse.de>
> > ---
> >   lib/efi_selftest/efi_selftest_loaded_image.c | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_selftest/efi_selftest_loaded_image.c
> > index 5889ab12617..48890a66db7 100644
> > --- a/lib/efi_selftest/efi_selftest_loaded_image.c
> > +++ b/lib/efi_selftest/efi_selftest_loaded_image.c
> > @@ -9,9 +9,7 @@
> >   #include <efi_selftest.h>
> > -static efi_guid_t loaded_image_protocol_guid =
> > -	EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,
> > -		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b);
> > +static efi_guid_t loaded_image_protocol_guid = EFI_LOADED_IMAGE_PROTOCOL_GUID;
> 
> This change is not described in the commit message.

It was a bit hidden, but it was mentioned:

  (..) and use the Loaded Image Protocol GUID definition from efi_api.h instead
  or redefining it locally.

> With the change we no
> longer test if efi_api.h has the correct value of the GUID. Why would you
> prefer this?

Sure, it could make sense to duplicate the GUIDs definitions for test purposes.
I will keep the definition as it is in the v2.

Note that we have a dozen places in the selftests using the common GUID
definitions from efi_api.h; shall I send a patch series to replace those?

Best regards,
Vincent.

> 
> >   static struct efi_boot_services *boottime;
> >   efi_handle_t image_handle;
> > @@ -60,8 +58,7 @@ static int execute(void)
> >   	efi_st_printf("%u protocols installed on image handle\n",
> >   		      (unsigned int)protocol_buffer_count);
> >   	for (i = 0; i < protocol_buffer_count; ++i) {
> > -		if (memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
> > -			   sizeof(efi_guid_t)))
> > +		if (!guidcmp(protocol_buffer[i], &loaded_image_protocol_guid))
> >   			found = true;
> 
> Changing the polarity is correct.
> 
> Best regards
> 
> Heinrich
> 
> >   	}
> >   	if (!found) {

-- 
Vincent.
