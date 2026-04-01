Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0C51112241
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 23:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9249F8414B;
	Thu,  2 Apr 2026 01:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="A3Xd+G3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D6CA83CF5; Thu,  2 Apr 2026 00:05:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C92F80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775081133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scwJckGjp79iLHyu5IhwGXo1qRWW3aSEumcyb7rKhvg=;
 b=A3Xd+G3NR74FLVUEGBNjiaNQAZA/ak0Yof8uOZsYn72LqfylZ1ebnDsuLBOtNwZGZpss82
 t4oWSm6kXfgiplOtW1918calQi+IZnZ36nqo6pYBJmV8gcW8PckyLskMBpUfk/lsvbDbW5
 wcWm+pxrMfTMcLlQQQewcDHXkJ73eok=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-8lcqiqiqO5SV5BAxvma_0A-1; Wed, 01 Apr 2026 18:05:32 -0400
X-MC-Unique: 8lcqiqiqO5SV5BAxvma_0A-1
X-Mimecast-MFC-AGG-ID: 8lcqiqiqO5SV5BAxvma_0A_1775081131
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d74be44ccdso861356a34.1
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081131; x=1775685931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scwJckGjp79iLHyu5IhwGXo1qRWW3aSEumcyb7rKhvg=;
 b=AWU5NCS4Ud+JHoZrcsWPBCSyZQDJdhE3/ElESXRNjlzfz13gdwZEJDVY27yTEyyo5p
 upotlKUx+qS1pnBrCQvMQ4w6myOrqCXnDNxeZpnGx9jo5CNrWEjQenu7DjQe6hSjz0Hs
 Jg/8QzEoYE67ZCaPf3Rz8Qi4hdDiPKlszFyH4LgXNnLODvdQpniW+CUzOxtpWRRproa2
 Gys0BMkavIqpvPW6vHjM8N9LKGDmxR68+1Roa5F/5UxnRuF1NRz8x21Kv7//ZP2BqDXP
 Jzy1r7iJHRro2oZ6wlMhUElGYySvXZvQuqLtf1vHuan/RbboUvKgoaNfQtcSZL9jVPGn
 ZAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu+xr1KI5smndcjsAqWD+7H74NitxgihUXFIsbIcA8RWnZXoEFS0MY1dGByOUsmxCPHRoPxLc=@lists.denx.de
X-Gm-Message-State: AOJu0YyzWbz+LdpwmTYO3wSeG4kVYmXicxU1SetzbIyNeEVCV0j4H1pI
 WI/vqUmLaTmkcAwZSPGM5KtlKV74zt0VJzlprI+sT1P4DRxs2W3cc0vTv6FoAfY8yjq5FbCj8gE
 bnwrTtzN/Q5KJn9DYQEXbnMTtr72+TSlrn3LVD99x8RkDML9HObmK6dQ=
X-Gm-Gg: ATEYQzwVCd9uvWndqOXOSnwcZWOhXyyPprOZVut8TJ+sKYTYe+k1hH4nQzCsNFDZbbC
 zAr5yBCFGsXWDQrl6W7ncJI9z047M67Xhnch8N27GueHuRs4xviHltviL6kPIygqUO9aOjxzw8B
 eNsPHrc78VQ22IX95B+/yG3fvpjvLMItQtISWJHmjq37YjVkI/+1rt67Y4qJLfE+7KQEVIr5ZOX
 ligZnJGlbFkQRHT3VY2LTvxi6BsJEdDdd2sefNYXR1pIGMxrX7zEVEC3Tbvfl1L86XwQ2d3jtEl
 AoeRwfBUBpTbD9u5RL+KNBsZiPbTC0/2wltl9jYPsMMyNwmeK9NoNj26Bc+0ZHQbzyoCttIico6
 3JwvSJ18Uyl+x1ZGB
X-Received: by 2002:a05:6830:2585:b0:7d7:57ef:384d with SMTP id
 46e09a7af769-7db993923damr3739184a34.16.1775081131131; 
 Wed, 01 Apr 2026 15:05:31 -0700 (PDT)
X-Received: by 2002:a05:6830:2585:b0:7d7:57ef:384d with SMTP id
 46e09a7af769-7db993923damr3739167a34.16.1775081130653; 
 Wed, 01 Apr 2026 15:05:30 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba71279b9sm880868a34.5.2026.04.01.15.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 15:05:30 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Wed, 1 Apr 2026 16:05:29 -0600
To: Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <ac2WqaHYgLslig_a@daedalus>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
 <20260227174744.GW1593142@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20260227174744.GW1593142@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aLNkzDfL0iDR-hvexL8nyHietc5pxNn0OVz-tbLHowI_1775081131
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 02 Apr 2026 01:24:51 +0200
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

On 02/27/26, Tom Rini wrote:
> On Fri, Feb 27, 2026 at 10:36:53AM -0700, Eddie Kovsky wrote:
> > On 02/19/26, Tom Rini wrote:
> > > On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> > > 
> > > > On 01/29/26, Mattijs Korpershoek wrote:
> > > > > Hi Eddie,
> > > > > 
> > > > > Thank you for the patch.
> > > > > 
> > > > 
> > > > Hi Mattijs
> > > > 
> > > > Thanks for the review.
> > > > 
> > > > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:
> > > > > 
> > > > > > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > > > > > users have been advised to migrate to the new Provider interface.
> > > > > > Several distributions have already removed support for engines, which is
> > > > > > preventing U-Boot from being compiled in those environments.
> > > > > >
> > > > > > Add support for the Provider API while continuing to support the existing
> > > > > > Engine API on distros shipping older releases of OpenSSL.
> > > > > >
> > > > > > This is based on similar work contributed by Jan Stancek updating Linux
> > > > > > to use the Provider interface.
> > > > > >
> > > > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > > > >
> > > > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > > > > >
> > > > > > The changes have been tested with the FIT signature verification vboot
> > > > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > > > > > Engine library installed and with the Provider API.
> > > > > >
> > > > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > > [snip]
> > > > Sure, I can update the comment for v4.
> > 
> > Hi Tom
> > 
> > > 
> > > Since we're talking about v4, can you please make sure that for v4 it:
> > > - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
> > >   that will cover some non-Linux host builds.
> > 
> > I don't have resources available to set up a Gitlab runner. Based on the
> > documentation you provided it seems like this wouldn't be effective for
> > me as a non-custodian.
> 
> Yes, correct, today using Azure is the easy option.
> 
> > I did use GitHub to trigger an Azure pipeline. There was one failure and
> > several errors in the binman Command Line test.
> > 
> >     https://github.com/u-boot/u-boot/pull/875/checks?check_run_id=65015204887
> 
> And the full log is:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12893&view=logs&j=c59aff74-743b-5f08-f408-4a608a489153&t=f2ea3536-b291-5a39-ad92-0220c9b8101a
> 
> and so yes, it's from your changes.
> 
> > These are PKCS11 errors, so of course I thought my patch was to blame.
> > But I'm seeing the same errors on Debian 13 running 'binman test'
> > manually on the master branch.
> 
> Some of the tests are indeed more frustrating than others to run either
> outside of CI, or outside of the containers, or both. I would recommend
> looking at the portion of .azure-pipelines.yml for that job for the
> steps to replicate, and if it doesn't work inside of your host (and
> https://docs.u-boot.org/en/latest/build/gcc.html is still missing
> things) it's easiest to just pull and run the CI container.
> 
> > > - See if you can get access to a FreeBSD or OpenBSD host and make sure
> > >   the tools build still works there too? I was hoping Mark would have
> > >   commented / tested-by v3 because I do want to make sure the libressl
> > >   case still builds. At worst case, I have a freebie Oracle VM that's
> > >   FreeBSD based, so you can maybe spin one of those up as well?
> > > 
> > 
> > I spent some time again setting up OpenBSD and FreeBSD virtual machines, but I was
> > unable to reproduce the build environment for U-Boot. But thanks to
> > Enric and Mark's work it looks like we have the LibreSSL use case
> > covered now.
> 
> Yes, thanks.
> 
> -- 
> Tom

I finally got to the bottom of this. Debian/Ubuntu ship OpenSSL backends
separately. The CI environment is missing the 'pkcs11-provider'
package, which is causing the binman tests to fail.

    $ apt show pkcs11-provider
    Package: pkcs11-provider
    Version: 1.0-3
    Priority: optional
    Section: libs
    Maintainer: Luca Boccassi <bluca@debian.org>
    Installed-Size: 410 kB
    Depends: libc6 (>= 2.34), libssl3t64 (>= 3.0.7~)
    Homepage: https://github.com/latchset/pkcs11-provider
    Download-Size: 125 kB
    APT-Manual-Installed: yes
    APT-Sources: http://ftp.debian.org/debian stable/main amd64 Packages
    Description: OpenSSL 3 provider for PKCS11
    With this provider for OpenSSL you can use the OpenSSL library
    (version 3) and command line tools with any PKCS11 implementation as
    backend for the crypto operations.

With this package installed the SSL errors logged on Azure are no longer reproducible.

The results from the first pipeline expired while I was investigating
this. I reran the CI job so you can see the error messages.

    https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13035&view=logs&j=c59aff74-743b-5f08-f408-4a608a489153&t=f2ea3536-b291-5a39-ad92-0220c9b8101a

I have looked into the .azure-pipelines.yml file, but it's not clear to
me how to configure the CI to install extra packages.


Eddie

