Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7226C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D000340B8A;
	Fri, 18 Sep 2026 12:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3-Zr4jqlZf6; Fri, 18 Sep 2026 12:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D648840B6F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789734962;
	b=LLRkJPyd/NKJurRn1/UVKj06U0S/GZalrsjhyPlTXO4MQM5aWecj0/b2/ixsRiYAj3oW
	 PDaaY6+U6FBIT+e2rM0ZXycSXjsvq7uWQ9/bDkpfx8dZ9tSKJ5FhQ0JD46N+lHXZn34CO
	 9pdBXb+UQRMlEsTFfbjyONvBX+nqOPmV8Fh/BDpbdTnPSqepInSxpzI5+pLIpf2toFoHf
	 /My/esCiJks0vtTx5w2NBwBs5Krb77SwooJcO6QkOiHJp7UHaFu5MHLJXLVMFpjakP3wp
	 klA923MFh25/KFcRhmmoM0Y5Aru29yGyzU1R983YybdR6vp+5ExC7zVyjhblnmcUJgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789734962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9ee3EAJgQYYL1u9+fEgkYOrT9hWLEAn2VDqCZWzNlow=;
	b=EUm8Yiob0Wi8eEHyrafrXvPXupxXBf28OfZ9xl4ZEmbMdpILkNf3Ec4RFgwC53UrRAPi
	 CvgubXuUvNNokoMbmDPXpR8hsh01yqucuLiSN1Irz78q4Y9ON9soOw1VCQwOtLxjuOPr2
	 I+sGvkwxwDSvOR1H4AecwZ/lo5jVF6vFjSg6ApOgULJ7aU51dzxo6sdrWXAGzuHtlTvZF
	 azr3W1pjRdxoOUslLakIG2eilzAUP8PMIZ6hhxeFKV8rn3IiG5GBYE1sqIxe3RRx873B5
	 yL6IWzrrFQGn0m8EKbJ6Tn7RPRWW5U7+EIeFjKWcGQZeXsJJ/hPg+Bx1nR/A28SpWXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MICLzCgK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789734962;
	bh=9ee3EAJgQYYL1u9+fEgkYOrT9hWLEAn2VDqCZWzNlow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aZnpdoNrzRqiRtfp66zbcgkokKbi106JpNnBLi6WIB+5Kh/eqb98AXroYGlrVzruz
	 AEzujZ91UvLa8x8Wu+Tm6B7kxCWg7iO0ZO3bFrGv9improR2UQewYAWw3SHtxsmAvk
	 kZC8gCWRuVSpfcepZ/1rcnxt0ug8WmSXX2tTyg8II9N10dGeXhzn4GpwGPkD0u+HiA
	 GrDWI39XeRZvcqJdpAobI3Mn7F6JIXJw96rqsIrAwYxX3qcYbYs4TZE/3rCNJTXy9h
	 3cfdRbBKZVQv3bW+K9H/CLJY9/klXo9f8LTKr3Ss/g+PSFerkGUAJh+8VCje+FM+Q1
	 LMpZYOFe/otEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D648840B6F;
	Fri, 18 Sep 2026 12:36:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 37B21279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2911440B6F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GEvDCakHlwZH for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB05A40B12
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789734959;
 b=foTlHn3k6RDYtH8iIpxIGmGUNyutICAWyrz8misxoEG1CNdzYdCWyrBJJTg5NPnfQpll
 J9n6YSIP9wxdbClSG5eO+8Caitd5MZnIivFnvSYitBSL9hLYcTTWe+65Lk8MMKcQu3iQw
 2k3dx75VX/wqPnQkCsaAF6NuzPjg/o/3F2J09NfRTbqhxxeo8nVoZQE9tTfIyx7ec6C6t
 1rhaRTY2VnHILxEKc6oR7AIKDs+Fwh2WV4G3ZXFdmTZ3f27zbIOSJUMnVn9rHuR4ePCoE
 uQfx4+Nh6YXQzOawS1QYNEGx4IazwLoQYs7r5lBIB4uGnZtGNfW9Vd4E6EMmq1XR9Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789734959;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=9ee3EAJgQYYL1u9+fEgkYOrT9hWLEAn2VDqCZWzNlow=;
 b=Hh4DWAWi8QdhAB7d2xX/pP+i9ReYszszzDJBlbd1l0otAVcL1s0bQCfrP9oNU1VceLFz
 +pfY6+qk/gDQDB4cUyZlb+j0kE7P/yyv3evKETqpsA9KmaRBwEf7SGB0pRZRDtSE5oQXZ
 lFeJyPfVeShjksdM2RI00S+bQCGDfnzLwYaZRQblsBaqt2gWRKQLN0tTe5rxAj3TLk7Oe
 9AA9HnLmmEQVi1vV9HcnRgFS8d/+HUeNMjC5JeblOs/I3416+sOCJOVx/hvM6o8ltSK7k
 FIV9v3FpEZLt+izyLv1NIDPm/OitTwQVZDOHsl54VZOek0ECXepVnuoQDq2e7bSoLPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=MICLzCgK; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=MICLzCgK
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB05A40B12
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:35:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8D11BF7;
 Fri, 18 Sep 2026 05:35:54 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.25])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 453003F86F;
 Fri, 18 Sep 2026 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789734957; bh=9wfmnZvbuDE/wu+djOaE+BClOHjLibLDVig0FUuQE0g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MICLzCgKiB0u/Q/CSJxaJVvG+crgwIwtN3qBsiJ4HrO613pft+5oa82a8uGgGse3U
 q9jSIqm6QPJxZtV3xEMA3lJil3Rw+InHpt3mx/kMOUUspBe1CKC2I8jjsxKXHbVzd4
 7th1h1DXuK7neS55IVo/mme3nomjwlL728UXESWo=
Date: Fri, 18 Sep 2026 14:35:53 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/5] efi_loader: adjust EBBR 2.1 ECPT entry
Message-ID: <aq0wKfYmEAOcUZks@debian>
References: <20260904-conform-v1-0-475b2947631a@arm.com>
 <20260904-conform-v1-1-475b2947631a@arm.com>
 <CAC_iWj+y1YnNfhijUdtzJhXJ9ig23dLnV9yBgZcT9sB5Kipk2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWj+y1YnNfhijUdtzJhXJ9ig23dLnV9yBgZcT9sB5Kipk2Q@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Sep 17, 2026 at 06:04:07PM +0200, Ilias Apalodimas wrote:
> Hi Vincent,

Hi Ilias,

Thank you for reviewing; my comments below.

Best regards,
Vincent.

> 
> On Fri, 4 Sept 2026 at 17:01, Vincent Stehlé <vincent.stehle@arm.com> wrote:
> >
> > Adjust the EBBR 2.1 conformance profile ECPT entry configuration, and
> > prepare to add more:
> > - Introduce the HAVE_EFI_EBBR_2_1 non-visible configuration symbol to
> >   compute the actual system conformance status with the dependencies.
> >   This will make it easier to add more versions with a chain of
> >   dependencies, while avoiding a chain of nested submenus.
> > - Adjust version 2.1 dependencies to better match the specification.
> >   Relax the dependency on the boot manager, which was introduced in
> >   version 2.3, and make the list of required UEFI protocols and services
> >   more complete.
> > - Reword the EFI_EBBR_2_1_CONFORMANCE configuration entry title and help
> >   text, mostly to separate "EBBR" from "v2.1" and to attenuate the
> >   redundant "table" mention.
> >
> > We do the following additional configurations dependencies
> > approximations:
> >
> >       Configuration symbol  Used to approximate
> >   ------------------------  ------------------------------------
> >   EFI_HAVE_CAPSULE_SUPPORT  Firmware update is performed in-band
> >                     DM_RTC  An RTC is present
> >
> > While at it, refine the ECPT help text to attenuate the redundant
> > "table" mention there as well.
> >
> > Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >  lib/efi_loader/Kconfig | 36 +++++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index 4cb13ae7c8a..40380876959 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -557,23 +557,41 @@ config EFI_ESRT
> >         help
> >           Enabling this option creates the ESRT UEFI system table.
> >
> > +config HAVE_EFI_EBBR_2_1
> > +       bool
> > +       depends on EFI_LOADER_HII
> > +       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> > +       depends on EFI_RNG_PROTOCOL || !DM_RNG
> > +       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> > +       depends on BOOTMETH_EFILOADER
> 
> Similar comments here. The BOOTMETH_* shouldn't be a requirement

I think you are right: depending on the boot method is a bit too
specific.

The original intention was to advertise a system as compliant only if we
could guarantee that it would boot automatically with UEFI (in this
patch with the default filename, and in previous patch with the boot
manager).
There did not seem to be an easy way to guarantee that with the
configurations dependencies.

What you see here is a second attempt, trying to -at least- avoid
advertising as compliant a system, which we know cannot boot
automatically with UEFI.
Even for that depending on the BOOTMETH_* configurations is probably not
good enough after all.

I think you mentioned that you or Heinrich could amend the patches
before merging; do not hesitate to let me know if you prefer that I send
a v2 series with the dependency here and in the previous patch removed.

> 
> Cheers
> /Ilias
> > +       depends on !EFI_VARIABLE_NO_STORE
> > +       depends on BOOTM_EFI
> > +       depends on EFI_BINARY_EXEC
> > +       depends on EFI_DEVICE_PATH_TO_TEXT
> > +       depends on EFI_DEVICE_PATH_UTIL
> > +       depends on EFI_GET_TIME || !DM_RTC
> > +       depends on EFI_PARTITION
> > +       depends on EFI_SET_TIME || !DM_RTC
> > +       depends on EFI_UNICODE_CAPITALIZATION
> > +       depends on EFI_ESRT || !EFI_HAVE_CAPSULE_SUPPORT
> > +       depends on EFI_RUNTIME_UPDATE_CAPSULE || !EFI_HAVE_CAPSULE_SUPPORT
> > +       depends on EFI_CAPSULE_FIRMWARE || !EFI_HAVE_CAPSULE_SUPPORT
> > +       default y
> > +
> >  config EFI_ECPT
> >         bool "Enable the UEFI ECPT generation"
> >         default y
> >         help
> > -         Enabling this option created the ECPT UEFI table.
> > +         Enabling this option creates the EFI Conformance Profiles Table
> > +         (ECPT).
> >
> >  config EFI_EBBR_2_1_CONFORMANCE
> > -       bool "Add the EBBRv2.1 conformance entry to the ECPT table"
> > -       depends on BOOTMETH_EFI_BOOTMGR
> > -       depends on EFI_ECPT
> > -       depends on EFI_LOADER_HII
> > -       depends on EFI_RISCV_BOOT_PROTOCOL || !RISCV
> > -       depends on EFI_RNG_PROTOCOL || !DM_RNG
> > -       depends on EFI_UNICODE_COLLATION_PROTOCOL2
> > +       bool "Add the EBBR v2.1 conformance entry to the ECPT"
> > +       depends on EFI_ECPT && HAVE_EFI_EBBR_2_1
> >         default y
> >         help
> > -         Enabling this option adds the EBBRv2.1 conformance entry to the ECPT UEFI table.
> > +         Enabling this option adds the Embedded Base Boot Requirements (EBBR)
> > +         v2.1 conformance entry to the ECPT.
> >
> >  config EFI_CONSOLE_DISABLE_ANSI
> >         bool "Disable ANSI escape sequence queries for console size"
> >
> > --
> > 2.53.0
> >
