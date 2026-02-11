Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3154E9E2FA
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 12:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACEA783CF2;
	Wed, 11 Feb 2026 13:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDDB83D2E; Wed, 11 Feb 2026 13:25:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 519FE83CE3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 13:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A88339;
 Wed, 11 Feb 2026 04:25:04 -0800 (PST)
Received: from debian (MacBookPro.nice.Arm.com [10.34.111.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D10D3F632;
 Wed, 11 Feb 2026 04:25:09 -0800 (PST)
Date: Wed, 11 Feb 2026 13:25:07 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: fix ecpt size computation
Message-ID: <aYx1I0erSBYpNM2e@debian>
Mail-Followup-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jose Marinho <jose.marinho@arm.com>,
 u-boot@lists.denx.de
References: <20260211093308.3265022-1-vincent.stehle@arm.com>
 <a386de9e-1dc9-4b50-a86c-bb8dfd845eef@gmx.de>
 <aYxsaXdISybHOQTq@debian>
 <b236ac3f-493e-452e-93ce-03c0fc73baf3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b236ac3f-493e-452e-93ce-03c0fc73baf3@canonical.com>
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

On Wed, Feb 11, 2026 at 12:50:38PM +0100, Heinrich Schuchardt wrote:
> On 2/11/26 12:47, Vincent Stehlé wrote:
> > On Wed, Feb 11, 2026 at 10:56:30AM +0100, Heinrich Schuchardt wrote:
> > > On 2/11/26 10:33, Vincent Stehlé wrote:
(snip)
> > > > diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> > > > index 2bae93a94bd..9768b5ae824 100644
> > > > --- a/lib/efi_loader/efi_conformance.c
> > > > +++ b/lib/efi_loader/efi_conformance.c
> > > > @@ -13,8 +13,12 @@
> > > >    #include <malloc.h>
> > > >    static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> > > > -static const efi_guid_t efi_ebbr_2_1_guid =
> > > > -	EFI_CONFORMANCE_PROFILE_EBBR_2_1_GUID;
> > > > +
> > > > +static const efi_guid_t profiles[] = {
> > > 
> > > As profiles[] is not used outside efi_ecpt_register(), there is no need to
> > > make it a static variable.
> > 
> > I am not sure why a "global" symbol would be better than a static one, but if
> > you like this solution we could make the profiles[] array extern.
> 
> Sorry to not be clear. I wanted to suggest a local symbol.

Hi Heinrich,

The profiles[] array is "local" to the efi_conformance.c file already as it has
internal linkage, thanks to the static specifier. Is this the symbol name you
would like to prefix maybe?

	static const efi_guid_t efi_conformance_profiles[] = {
		...

Best regards,
Vincent.

> 
> Best regards
> 
> Heinrich
