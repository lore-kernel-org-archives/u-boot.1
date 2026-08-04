Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8D7C55184
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 00:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F337E405DC;
	Wed,  5 Aug 2026 00:51:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9N--FEfuDvoq; Wed,  5 Aug 2026 00:51:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F0CA4059A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785891095;
	bh=Cqp3qTWp14x/1hfQ6F+v5r+wTF1lANrC1t8oEVk36Xo=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VaiTsx8+UZ/+x1i2LNawX4sj7xZn/egbvA2mK5P1n8hebnCFsQZRSib/as7z4rE78
	 q/OLiqX6vWJLLGT9ojlbwmiMPqHsPf0MX2uBow+tsGnNMwg7f+5pBHGRpqwgRjlUyJ
	 rCk+mWN1twP+jYA1s48/fjbghq2qgBcgv4z2TejHGt1gfc67b+fD9uqH4rPGPcv+hk
	 HjuZgWi8zg4kHz+rIn6pVCvjjEoFvSijoAXvswglcAeBaXx2k6n2TzMxyGaMVgrRkR
	 Tyzit5ZdpdkN1IvIv3ggBFeAGXsfi7VbqGUVXm0i9ZTrR7BtYWRajPAyJOAz1qmU3n
	 PwCdUe3ZXT9jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F0CA4059A;
	Wed,  5 Aug 2026 00:51:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D44528C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 23:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62CAA400BD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 23:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SQQQT2mhsqEM for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 23:21:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ekovsky@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 16E16400AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16E16400AF
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16E16400AF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 23:21:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC95E84867; Wed,  5 Aug 2026 01:21:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2947803F6
 for <u-boot@lists.denx.de>; Wed,  5 Aug 2026 01:21:16 +0200 (CEST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-iw52nOqdN-i_YUiDlvdjOg-1; Tue, 04 Aug 2026 19:21:12 -0400
X-MC-Unique: iw52nOqdN-i_YUiDlvdjOg-1
X-Mimecast-MFC-AGG-ID: iw52nOqdN-i_YUiDlvdjOg_1785885672
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso3477011cf.2
 for <u-boot@lists.denx.de>; Tue, 04 Aug 2026 16:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785885672; x=1786490472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cqp3qTWp14x/1hfQ6F+v5r+wTF1lANrC1t8oEVk36Xo=;
 b=F5LdSb8kNfXzqWwCdjh4OvlJ1bT/MTqs996XC5gxawhKtziZytn/ISfI0juUZi+ybf
 yi659c5sXOVsAthwNOAtXp5aXgNggEmJrLHb7Z3Sa0BPTtjgi+9RHwO+NvUhO6YPcsF5
 CHxWOR3PbJx+FBaBg98fUPKe4S4LRYYYZE+gVjUGS/se+WmqqOyd2XPSpg7KPjpNroEc
 xop0zuW9WzfAFdwewP4YSGZXh8845DgtgWyFQHNOwVP8knIwjbQQLZ/Gb7tZbnx/Xc/l
 2Ejg2PIeTMGM4rx5qEJFjAx7JdRtJsut0l4M2OZHtRm6Zy1vbRpi1gXJouYt6mZwoPnE
 +ykQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RomLuOiGwAB1tojQlxSEPrUOICcjvVYkPa6ZChzgGbuZLyhTAnNyXuAQI8KdBti1bFWqkivFWY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz27+wzz+FxJsPMEByZAJ9pyPhXrbpAqLHaVmVrXAru7+ro42Og
 nICgNBPAQMPVZYxrTqUYZuGap7Ee411ExctZL2CSUhDUn0D95IHKccRif/r1/UmJqlbkC+rS6/1
 xfNWf86vomuxvlGCoEVdievDeIAFtAyBhxpIhqTZ+b2Azo/wz1MuxMao=
X-Gm-Gg: AR+sD11wHfIQ1mIDC23+ts7Tfn+4pWSuwAvgtDBUUJ3sO6XMZpEAhh49JccohExcCAq
 FjuGlEKM6Je9ZtM79kZGIlpcqKhyxDKPfoBkqnemV5EUlZxsZyICPlhKovRIybFMWM8cg34uMvo
 5SVFddhj5U8SklX0CqRe412UemNnSwkLKvZHd7qKE70jcTZ0PazjuCU7c105qnfITLSIDlJvOT9
 7uOPT+4RpWJltaJ26mhVFyfYmfb6dNy/d9Ogql9krgXbv9YsIaBlIZcjGrkevXW0TvIZ4UQgWp+
 xuLsF6czZJH5SRXSikuuB6+kX8o45nZrzctFFmMtPNxCuLhugPqvEqJrjhaoaWFbQ+3IvJ8=
X-Received: by 2002:a05:622a:4c14:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-52ce61eabd5mr33273611cf.41.1785885671485; 
 Tue, 04 Aug 2026 16:21:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4c14:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-52ce61eabd5mr33272801cf.41.1785885670682; 
 Tue, 04 Aug 2026 16:21:10 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce894d825sm4426661cf.22.2026.08.04.16.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 16:21:10 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Tue, 4 Aug 2026 17:21:09 -0600
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
Message-ID: <anJz5aRlEH8kYyi3@daedalus>
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de>
 <ag-EpjuQlre9QmYN@daedalus>
 <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
 <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DOqSt8l7ObeRuQuiH7KS0QPcA6H6dMHLCOUelw4ZwMQ_1785885672
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 05 Aug 2026 00:51:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1785885675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cqp3qTWp14x/1hfQ6F+v5r+wTF1lANrC1t8oEVk36Xo=;
 b=AID6tkylPYCr/TcAQI3ouVI1zrJqXsoJtD0r1ITfQ8zsCibN+xaz9ZvhFzVjENfDbsw+kC
 EIrIr+v6L6XYGqFOgKjMq+C80akTcHoMpq1XWbKA55B5gTzfNeE3HLMEy2HS4jQor3AmN0
 6e2gGOdmTZ5n5YthwXYzByiYAFMJDAo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=redhat.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=AID6tkyl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ekovsky@redhat.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.b="AID6tkyl"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 06/04/26, Enric Balletbo i Serra wrote:
> Hi Quentin and Eddie,
> 
> On Fri, May 22, 2026 at 4:38 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >
> > Hi Eddie,
> >
> > On 5/22/26 12:29 AM, Eddie Kovsky wrote:
> > > On 05/12/26, Quentin Schulz wrote:
> > >> Hi Eddie,
> > >>
> > >> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
> > >>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> > >>> users have been advised to migrate to the new Provider interface.
> > >>> Several distributions have already removed support for engines, which is
> > >>> preventing U-Boot from being compiled in those environments.
> > >>>
> > >>> Add support for the Provider API while continuing to support the existing
> > >>> Engine API on distros shipping older releases of OpenSSL.
> > >>>
> > >>> This is based on similar work contributed by Jan Stancek updating Linux
> > >>> to use the Provider interface.
> > >>>
> > >>>       commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> > >>>       Author: Jan Stancek <jstancek@redhat.com>
> > >>>       Date:   Fri Sep 20 19:52:48 2024 +0300
> > >>>
> > >>>           sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > >>>
> > >>> The changes have been tested with the FIT signature verification vboot
> > >>> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> > >>> Engine library installed and with the Provider API.
> > >>>
> > >>
> > >> But does it actually use a provider or an engine to begin with? I don't see
> > >> test/py/tests/test_vboot.py calling mkimage with the -N argument. What are
> > >> the tests (or command) you ran to validate this? I briefly saw the CI failed
> > >> in v3 because a package was missing, but wasn't it simply because the
> > >> headers or provider libraries which are now necessary for building
> > >> lib/rsa/rsa-sign.c were not present? The logs aren't available anymore
> > >> unfortunately. If that's the case, then that's also an issue. We shouldn't
> > >> need to install providers if we aren't going to use any? Yes, I know that we
> > >> currently cannot compile if we don't have openssl-devel-engine (on Fedora),
> > >> but if we can improve the situation, we should.
> > >>
> > >> How did you test (locally is fine) with providers?
> > >>
> > >
> > > The FIT signature verification tests are documented here:
> > >
> > >      https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification
> > >
> > > The tests currently fail in build environments (like Fedora) that don't
> > > have engine support. This is how we originally became aware of the API
> > > issue last year.
> > >
> > >      ❯ ./test/py/test.py --bd sandbox --build -k vboot
> > >      +make O=u-boot/build-sandbox -s sandbox_defconfig
> > >      +make O=u-boot/build-sandbox -s -j8
> > >      In file included from tools/generated/lib/aes/aes-encrypt.c:1:
> > >      ../tools/../lib/aes/aes-encrypt.c:19:10: fatal error: openssl/engine.h: No such file or directory
> > >      19 | #include <openssl/engine.h>
> > >          |          ^~~~~~~~~~~~~~~~~~
> > >      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
> > >      ../tools/../lib/rsa/rsa-sign.c:22:10: fatal error: openssl/engine.h: No such file or directory
> > >      22 | #include <openssl/engine.h>
> > >          |          ^~~~~~~~~~~~~~~~~~
> > >      compilation terminated.
> > >
> > > Github provides the Azure CI pipeline as a free service. I wouldn't
> > > expect them to retain logs at that tier.
> > >
> >
> > As said, I don't think we are testing OpenSSL providers in test/py.
> > rsa-sign.c and aes-encrypt.c can work perfectly fine without using
> > engines, but currently it requires the engine.h header file to compile
> > (and if missing, then the functions, macros, constants defined in that
> > header file will need to be compiled out like done in this patch) even
> > if it doesn't use engines at runtime.
> >
> > The issue is not that OpenSSL is built without engine support, it's
> > rather that Fedora has decided to stop shipping openssl/engine.h by
> > default. For some reason, they still compile OpenSSL with engine support
> > (I don't understand why). You are fixing a build issue, sure, and we
> > must fix it, but I don't think this patch is doing it the proper way. So
> > I am asking again, did you test with an actual OpenSSL provider (and no,
> > the implicit file: scheme "provider" doesn't count)?
> >
> > See
> > https://lore.kernel.org/u-boot/d8b15735-0b3f-4a72-a2a2-9ac6e12f4dbf@cherry.de/T/#m7454283f474aaee33736e1ae7154569da846f14a
> >
> > >
> > >>> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
> 
> Chiming in here as one of the folks testing this series. I'll admit I
> got completely lost in the mailing list jungle trying to follow this
> massive wall of messages, but I finally dug into the logs and ran some
> more hands-on tests.
> 
> I think the scope of this patch was strictly a backend API migration
> to unblock U-Boot compilation on distros like Fedora, not supporting
> real providers out of the gate.
> 
> To verify that Eddie's patch successfully switches the underlying
> architecture to the OpenSSL 3.x Provider API, I ran a local system
> trace using a file-based path (-k .). The strace confirmed that the
> legacy engine hooks are bypassed and the provider module is used
> instead. The underlying provider plumbing itself is completely solid
> for standard file-based keys [1].
> 
> With that, plus the tests passing in CI, I assumed the new backend
> plumbing worked as intended. From a functional standpoint, the outcome
> is identical: your images get signed securely just like before. The
> only difference is the internal machinery OpenSSL uses under the hood.
> 
> But you are entirely right. I didn't test against a real hardware
> engine initially, and looking closer, I agree the current patch does
> break backward compatibility for anyone using a real Engine on OpenSSL
> 3.x.
> 
> I did a run using SoftHSM to see exactly why:
> 
> Before this patch: Passing -N pkcs11 successfully triggered the legacy
> engine. The signing succeeded.
> 
> With this patch: The OpenSSL 3.x version check unconditionally hijacks
> the flow, ignores the -N engine flag, and forces execution down the
> Provider path. The strict OSSL_STORE_open parser receives the mangled
> string and instantly fails with ENOENT because is unconditionally
> appending /[key-name-hint].key.
> 
> My understanding is that to fix the Fedora build issues without
> breaking existing workflows, Eddie just needs to adjust the control
> flow for v4 like you suggested:
> 
> If the user explicitly commands an engine via -N, prioritize the
> legacy engine path—guarding the engine headers and blocks with #ifndef
> OPENSSL_NO_ENGINE instead of a blanket OpenSSL version check.
> 
> If no engine flag is passed, route seamlessly into the new Provider API backend.
> 
> This fixes the compilation bottleneck on some distros, completely
> preserves legacy engine setups, and allows real providers URI
> string-mangling issue to be handled as clean, independent follow-up
> patches.
> 
> Does it makes sense?
> 
> Cheers,
> Enric Balletbo
> 
> 
> [1]
>  $ strace -f -e trace=openat ./tools/mkimage -F -k . -K mock.dtb -r
> fitImage 2>&1 | grep -iE "pkcs11|ossl-modules|\.key"
> openat(AT_FDCWD, "/etc/pki/tls/openssl.d/pkcs11-provider.conf", O_RDONLY) = 7
> openat(AT_FDCWD, "/usr/lib64/ossl-modules/pkcs11.so", O_RDONLY|O_CLOEXEC) = 5
> openat(AT_FDCWD, "./dev.key", O_RDONLY) = 5
> FIT description: Dummy FIT image for testing providers
> Created:         Wed Jun  3 19:26:03 2026
>  Image 0 (kernel-1)
>   Description:  Dummy Kernel
>   Created:      Wed Jun  3 19:26:03 2026
>   Type:         Kernel Image
>   Compression:  uncompressed
>   Data Size:    100 Bytes = 0.10 KiB = 0.00 MiB
>   Architecture: ARM
>   OS:           Linux
>   Load Address: 0x80008000
>   Entry Point:  0x80008000
>   Hash algo:    sha256
>   Hash value:   cd00e292c5970d3c5e2f0ffa5171e555bc46bfc4faddfb4a418b6840b86e79a3
>  Default Configuration: 'config-1'
>  Configuration 0 (config-1)
>   Description:  Boot configuration
>   Kernel:       kernel-1
>   Sign algo:    sha256,rsa2048:dev
>   Sign value:
> 4b88172afa850fb98d4c81662b043fedfebd7db55be8011aa464570e58289cf58939ea3adfafd9dd808362cfbd830fccaf806bbdc3d221922ec4e59a478a526904b1f39afa28d770b2808ed727825953eb8e4f1387faf3396e6f0e8d1a5be1c4b698e94e383d466371b8469638a3d3e1e1a3385eb4752c7554d09289face527d60262f274c8ab12ae28069a51dbce19505578e391e2fc25a9df915b6917cf057b5b2ecd9ede7db81a0be1cb106db801f75500562902f45fbed9df5b87c61cabc854cf429d25f5977813bdb239b38e27ba461b752c612068ae1dc2566d3456d2396828bfaea1a946b77d0479ee720574d6068409353e4554d0dd5c56f1a0a6228
>   Timestamp:    Wed Jun  3 19:26:16 2026
> Signature written to 'fitImage', node '/configurations/config-1/signature-1'
> Public key written to 'mock.dtb', node '/signature/key-dev'
> 
> ./tools/fit_check_sign -f fitImage -k mock.dtb
> Verifying Hash Integrity for node 'config-1'... sha256,rsa2048:dev+
> Verified OK, loading images
> ## Loading kernel (any) from FIT Image at 7f0d23b65000 ...
>    Using 'config-1' configuration
>    Verifying Hash Integrity ...
> sha256,rsa2048:dev+
> OK
> 
>    Trying 'kernel-1' kernel subimage
>      Description:  Dummy Kernel
>      Created:      Wed Jun  3 19:26:03 2026
>      Type:         Kernel Image
>      Compression:  uncompressed
>      Data Size:    100 Bytes = 0.10 KiB = 0.00 MiB
>      Architecture: ARM
>      OS:           Linux
>      Load Address: 0x80008000
>      Entry Point:  0x80008000
>      Hash algo:    sha256
>      Hash value:
> cd00e292c5970d3c5e2f0ffa5171e555bc46bfc4faddfb4a418b6840b86e79a3
>    Verifying Hash Integrity ...
> sha256+
> OK
> 
>    Decrypting Data ...
> OK
> 
>    Loading Kernel Image to 0
> ## Loading fdt (any) from FIT Image at 7f0d23b65000 ...
>    Using 'config-1' configuration
>    Verifying Hash Integrity ...
> sha256,rsa2048:dev+
> OK
> 
> Could not find subimage node type 'fdt'
> ## Loading ramdisk (any) from FIT Image at 7f0d23b65000 ...
>    Using 'config-1' configuration
>    Verifying Hash Integrity ...
> sha256,rsa2048:dev+
> OK
> 
> Could not find subimage node type 'ramdisk'
> Signature check OK
> 
> 


The root cause of the hardware key signing failures can be traced back
to the master branch. In lib/rsa/rsa-sign.c around line 306 we have this
function that decides which function to call to read a private key based
on testing if the engine pointer is valid.

    static int rsa_get_priv_key(const char *keydir, const char *name,
                    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
    {
        if (engine)
            return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
                            evpp);
        return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
    }

The problem is that only the first function rsa_engine_get_priv_key()
includes the code necessary to correctly parse a PKCS11 URI. So as it's
currently implemented if you are signing with a hardware key and are
unlucky enough to fail to initialize the engine pointer, then you will
take the fall through path to rsa_pem_get_priv_key(). This function appends
".key" to your URI string, making your private key unusable and
resulting in signing errors like this:

    $ ./tools/mkimage -F -N pkcs11 -k "pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;serial=e35503459cfe8566;token=uboot-token;id=%00;object=uboot-key;type=private;pin-value=1234" -K mock.dtb -r fitImage
    Couldn't open RSA private key: 'pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;serial=e35503459cfe8566;token=uboot-token;id=%00;object=uboot-key;type=private;pin-value=1234/dev.key': No such file or directory
                                                                      ^^^^^^^^

An unintended side effect of my initial patch is that it forces the
caller to take the second path IF the Provider API is available on the
system, even if the engine.h header is also present. This happened
because I was following the convention of equating OpenSSL version
numbers with APIs.

    +#if OPENSSL_VERSION_MAJOR >= 3
    +# define USE_PKCS11_PROVIDER
    +# include <err.h>
    +# include <openssl/provider.h>
    +# include <openssl/store.h>
    +#else
    +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
    +#  define USE_PKCS11_ENGINE
    +#  include <openssl/engine.h>
    +# endif
    +#endif

    --->8

    static int rsa_get_priv_key(const char *keydir, const char *name,
                    const char *keyfile, ENGINE *engine, EVP_PKEY **evpp)
    {
    +#ifdef USE_PKCS11_ENGINE
        if (engine)
            return rsa_engine_get_priv_key(keydir, name, keyfile, engine,
                            evpp);
    +#endif
        return rsa_pem_get_priv_key(keydir, name, keyfile, evpp);
    }

Hardware key signing isn't broken in environments that have an
Engine API provided by an older release of OpenSSL. RHEL 8 still ships
OpenSSL 1, and hardware key signing works as expected with my patch:

    # openssl version
    OpenSSL 1.1.1k  FIPS 25 Mar 2021

    # cat /etc/redhat-release
    Red Hat Enterprise Linux release 8.8 (Ootpa)

    # git apply 0001-Add-support-for-OpenSSL-Provider-API.patch

    --->8

    # ./tools/mkimage -F -N pkcs11 -k "pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;serial=779ba2fecf837067;token=uboot-token;object=uboot-key;pin-value=1234" -K mock.dtb -r fitImage

    FIT description: Dummy FIT image for testing providers
    Created:         Wed Jul 22 11:21:59 2026
    --->8
    Signature written to 'fitImage', node '/configurations/config-1/signature-1'
    Public key written to 'mock.dtb', node '/signature/key-dev'

Probably the easiest way to resolve this is, as Enric suggested, to
decouple the OpenSSL version from the Provider name. Although
technically correct, it doesn't cover the use case where the engine.h
header is available alongside the Provider API.

However, hardware key signing can still fail with the current
implementation. That needs to be cleaned up, probably in a separate
patch. After digging through the Git history I couldn't determine why
rsa_get_priv_key() is implemented this way. There's a lot of duplication
between the two functions it might call, but simply duplicating the
PKCS11 URI code would not be a good solution. So I'll need to think
about that some more.

Eddie

