Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74F6FEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 18:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8B283D1A;
	Fri, 27 Feb 2026 19:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EfQhqMu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E87D83E76; Fri, 27 Feb 2026 18:37:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 292CE83EC9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 18:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772213816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWPnCZGSgBVAzY14z8a+S8nnQ7o9/+4giaAxyDtkW6U=;
 b=EfQhqMu6rCAKw71iCXGDBieycmW3hmvQR1kIe5we2PxImBiPSMMPGCvyrDLgL2A513D41/
 AfWGXL2EarHK/8t9RS3r3g6Jdc/f6qhrYPyBO+t9tEnBjp78rYi1/c1FoMJuQJpd2UAxPn
 9wihPKwOfw43a6+ZScDRwiNP2hqo/g8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-dlzWLOwqNn2Sd_ZsjstklA-1; Fri, 27 Feb 2026 12:36:55 -0500
X-MC-Unique: dlzWLOwqNn2Sd_ZsjstklA-1
X-Mimecast-MFC-AGG-ID: dlzWLOwqNn2Sd_ZsjstklA_1772213815
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb3fae6f60so2338085985a.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 09:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772213815; x=1772818615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWPnCZGSgBVAzY14z8a+S8nnQ7o9/+4giaAxyDtkW6U=;
 b=LV45C41LgMrUf/D7YH1K/Ftv8aHTOYnYFiZ+9I/NozCKE3FEA1nUyE7L8/FwVkq3WP
 FFT1AbP9co8PFabPFdRFfJsCs2kgFkuqLg+jBYqx5HT78EcU9L7+eXjexjZ+zkGNYCtp
 YlOR0ygyWUJyFayLl0V/3ophC8hAaS5xpeXCp5gxuV9VVU2dUj2Qs3FABRaI8lk092mK
 tY7zsibs+AgUNU9pmjRiLLDOwt5AJhjAVE8p1T/PNvc3z+a3jyu2I1uOVyF5slrNXA7X
 ZBnPEv8ATPQm6DKMSaIUQ1IQPvv4CiluMwFuxZUv2bQYA1C22tzdWLRnUulBEBlHO3yQ
 eCAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmk1kxtg/TZnncea6n1nGFts9iFGXi5r+OCrH33qZB2Nb05iKBA1vERwUe0wp5C9CUtxWXIK0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6+wxEJHNg7i2gk36/6maldJprraTSiHU5RThflDSTeY8sNGsX
 QKerT7TGDmGcwubP+L6MirtJp6DaCjES1euWI9TPi5VtWs7FlAWWVhKJMv0Mffgz6zmbGORSfb/
 2Tn3aJl3lsUX0ItafuPmjcCC84D3s+Qc6adBSOkx12T00IUGlsvyrRtQ=
X-Gm-Gg: ATEYQzw/+MKaIatPvQIsaNmRAm8F3EWtNfrT3idGFA5mMnzxyR6bdt/K3bDQL/Kauyu
 Od0g3tgAIYM0dPGAoHqBtXMACfhGMWpiOEMgliiX3A6xwgPRMlwZQfYvIxuvQ9dNkYE8DlNUhTH
 etZEV9oZLr3VJRBmDWbq8GrVbcfPzuDfgHmger1/nLL91zV3AcXioCiWuJUwOswdt9Ki3btpvKk
 SegHRVwsASReathPD/dK6fpzrm2RZMMJpHS6J/Wvka32YBK9Md6rb+8C8Z31udYKzxzLQFj5Gsd
 +IbSVI+Yas2J3sTRQ4PLvIPkxKIvuNpiGnGNH2Ub+a8POKDLGj7JyXg5U84d149tQCqK9mocWqB
 +fJ/hbT4zfxARp8j6
X-Received: by 2002:a05:620a:25cc:b0:8c7:1271:f336 with SMTP id
 af79cd13be357-8cbbf35265emr812790385a.2.1772213815114; 
 Fri, 27 Feb 2026 09:36:55 -0800 (PST)
X-Received: by 2002:a05:620a:25cc:b0:8c7:1271:f336 with SMTP id
 af79cd13be357-8cbbf35265emr812787585a.2.1772213814587; 
 Fri, 27 Feb 2026 09:36:54 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66f31asm502453085a.15.2026.02.27.09.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 09:36:54 -0800 (PST)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Fri, 27 Feb 2026 10:36:53 -0700
To: Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <aaHWNU0LQqJ0zNDD@daedalus>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20260219172836.GN3233182@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TpgbW_IQKyDJx9rLWRU7P1YxTU0VMDS8yqO61GbM9nU_1772213815
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 27 Feb 2026 19:13:42 +0100
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

On 02/19/26, Tom Rini wrote:
> On Thu, Feb 19, 2026 at 09:51:05AM -0700, Eddie Kovsky wrote:
> 
> > On 01/29/26, Mattijs Korpershoek wrote:
> > > Hi Eddie,
> > > 
> > > Thank you for the patch.
> > > 
> > 
> > Hi Mattijs
> > 
> > Thanks for the review.
> > 
> > > On Tue, Jan 20, 2026 at 09:45, Eddie Kovsky <ekovsky@redhat.com> wrote:
> > > 
> > > > The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > > > users have been advised to migrate to the new Provider interface.
> > > > Several distributions have already removed support for engines, which is
> > > > preventing U-Boot from being compiled in those environments.
> > > >
> > > > Add support for the Provider API while continuing to support the existing
> > > > Engine API on distros shipping older releases of OpenSSL.
> > > >
> > > > This is based on similar work contributed by Jan Stancek updating Linux
> > > > to use the Provider interface.
> > > >
> > > >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > > >     Author: Jan Stancek <jstancek@redhat.com>
> > > >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > > >
> > > >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > > >
> > > > The changes have been tested with the FIT signature verification vboot
> > > > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > > > Engine library installed and with the Provider API.
> > > >
> > > > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> [snip]
> > Sure, I can update the comment for v4.

Hi Tom

> 
> Since we're talking about v4, can you please make sure that for v4 it:
> - Passes CI https://docs.u-boot.org/en/latest/develop/ci_testing.html as
>   that will cover some non-Linux host builds.

I don't have resources available to set up a Gitlab runner. Based on the
documentation you provided it seems like this wouldn't be effective for
me as a non-custodian.

I did use GitHub to trigger an Azure pipeline. There was one failure and
several errors in the binman Command Line test.

    https://github.com/u-boot/u-boot/pull/875/checks?check_run_id=65015204887

These are PKCS11 errors, so of course I thought my patch was to blame.
But I'm seeing the same errors on Debian 13 running 'binman test'
manually on the master branch.

> - See if you can get access to a FreeBSD or OpenBSD host and make sure
>   the tools build still works there too? I was hoping Mark would have
>   commented / tested-by v3 because I do want to make sure the libressl
>   case still builds. At worst case, I have a freebie Oracle VM that's
>   FreeBSD based, so you can maybe spin one of those up as well?
> 

I spent some time again setting up OpenBSD and FreeBSD virtual machines, but I was
unable to reproduce the build environment for U-Boot. But thanks to
Enric and Mark's work it looks like we have the LibreSSL use case
covered now.


Eddie

