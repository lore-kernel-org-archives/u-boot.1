Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9597FFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 04:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3C684314;
	Tue, 28 Apr 2026 06:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="I8KHogbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82EC84106; Tue, 28 Apr 2026 06:07:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F1084099
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777349235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rdryLV0YICc5YlOEF8rPDK88n8gF0YpIBPdngbQcTrI=;
 b=I8KHogbAt0yhsD2amZgyq+GtQ5W7GEE3VFh+TjYsbMBdD025eXTL0Dy7UT3WcPUhQo4x+N
 tN4AMXSG/jlLWOgCLqaFTd2gaq66qwAkjLrOkrBonjn+JH/+evfLudjo+g/6hKaTq7L5BJ
 GU7tCqKbL4ZuvUVwINiUIhU61jAED2Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-HNi5QMUGP-iknkec-5UHWQ-1; Mon, 27 Apr 2026 16:43:43 -0400
X-MC-Unique: HNi5QMUGP-iknkec-5UHWQ-1
X-Mimecast-MFC-AGG-ID: HNi5QMUGP-iknkec-5UHWQ_1777322623
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eaf1ce4a9bso1504818085a.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322623; x=1777927423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdryLV0YICc5YlOEF8rPDK88n8gF0YpIBPdngbQcTrI=;
 b=ZY3ZApmDAG+SruZN7RmhL+8ygezMQhfU7pD2e7NQHvZ8pc014Yqcb5wI+K9f1OiNc1
 nHPbgXzd+lz5r8t43GRcguHd8nwKxHU/Sj3YZjm/LbtdHpvspUKcCGfqJ/0+eYhMg8JU
 Lhiusk4XDwbcHCgY0dutc9D7XeAPyVJyJ214iyG+iXn2mjjJbgnzy4bs32KKQ4nkRfai
 aNVaQmn8j4LYh6SCCyCGbEgtfXBDbluYlF3V8Rd8qVOwbHcLMuYL62X9HN4vKh8dpceB
 D726mONi4YmfIW2SuuZFbek2HGFgubkmqZ2uznyiRHJzqcB613sF8NzU02JAmmN3GPwz
 h6oQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+i4eGS9Drb5OVhhm3TSZZEsZpIjyz0dfJWzLhn0Ue+NJpmlz2xKS5PdwGt9/5vkoCE/pY9zQo=@lists.denx.de
X-Gm-Message-State: AOJu0YyRDz/CtMhY63mqIKT/M2cswrlg2hESwQyuNebpf99kJjafP4gF
 M8W8wuyD69pxZu0+XdJfYZNguVJye1k6dVc+2cYBO6qArZtxCL6igN9T8/HGGYcKl0cTGTQiWjV
 2vHF3dKUXnTqa2eo0A8I5gpkJEKxSLYokz3jSnfuNoNbtqYJVg7j9z+c=
X-Gm-Gg: AeBDietnBhX2T3F3wJUDenryLG4BsTnnczLtvu9PEFLrBuUbBQeuTSaE9fVMJRpBFJy
 8l23vnbTjqOIl95FMg74vcQ4xrKRzjC7NWEaZLCMunMqAdFkG4+1z1z0K5O4OvUpZ6PZUE9RpJH
 dpwo3s2zQLrTGaaTNM+QTVcMppvcZcOD1vpy/tBqvLrvwm6OcCc+WPPfi/kVxW538LKdY6WsZC0
 Uc2mPAQcOuHOIwhIbPUyNJ+mieuCcp9/ceKGjtW9TrQXYf+fWKsOIsvrsCq+d4cqqODl4b4T6T9
 HBh8qUzmH68avZgEO/PN2CpdEmDigjirtdR+utQNmRPPI64fYD48znnoI76U/MykAFZxPEVQ3nf
 OVUzCtiOEEj2iHjq2VtZ6yka9oZY=
X-Received: by 2002:a05:620a:170c:b0:8f1:7ce7:5aff with SMTP id
 af79cd13be357-8f7ccfa6b37mr47643885a.1.1777322622946; 
 Mon, 27 Apr 2026 13:43:42 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:8f1:7ce7:5aff with SMTP id
 af79cd13be357-8f7ccfa6b37mr47639185a.1.1777322622340; 
 Mon, 27 Apr 2026 13:43:42 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f7c8a97f3esm22383585a.47.2026.04.27.13.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:43:41 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Mon, 27 Apr 2026 14:43:40 -0600
To: Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <ae_KfGqNrsWZ1rfQ@daedalus>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
 <20260227174744.GW1593142@bill-the-cat> <ac2WqaHYgLslig_a@daedalus>
 <20260402162704.GG41863@bill-the-cat> <admdwS1tuX_ZdPFF@daedalus>
 <20260413181258.GD41863@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20260413181258.GD41863@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UlaqZbUgNwC4mq-Y1VDTn3SQTtKUeXavh-gIuLcFyuU_1777322623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 28 Apr 2026 06:27:12 +0200
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

On 04/13/26, Tom Rini wrote:
> On Fri, Apr 10, 2026 at 07:02:57PM -0600, Eddie Kovsky wrote:
> > --->8
> > > > I finally got to the bottom of this. Debian/Ubuntu ship OpenSSL backends
> > > > separately. The CI environment is missing the 'pkcs11-provider'
> > > > package, which is causing the binman tests to fail.
> > > > 
> > > >     $ apt show pkcs11-provider
> > > >     Package: pkcs11-provider
> > > >     Version: 1.0-3
> > > >     Priority: optional
> > > >     Section: libs
> > > >     Maintainer: Luca Boccassi <bluca@debian.org>
> > > >     Installed-Size: 410 kB
> > > >     Depends: libc6 (>= 2.34), libssl3t64 (>= 3.0.7~)
> > > >     Homepage: https://github.com/latchset/pkcs11-provider
> > > >     Download-Size: 125 kB
> > > >     APT-Manual-Installed: yes
> > > >     APT-Sources: http://ftp.debian.org/debian stable/main amd64 Packages
> > > >     Description: OpenSSL 3 provider for PKCS11
> > > >     With this provider for OpenSSL you can use the OpenSSL library
> > > >     (version 3) and command line tools with any PKCS11 implementation as
> > > >     backend for the crypto operations.
> > > > 
> > > > With this package installed the SSL errors logged on Azure are no longer reproducible.
> > > > 
> > > > The results from the first pipeline expired while I was investigating
> > > > this. I reran the CI job so you can see the error messages.
> > > > 
> > > >     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13035&view=logs&j=c59aff74-743b-5f08-f408-4a608a489153&t=f2ea3536-b291-5a39-ad92-0220c9b8101a
> > > > 
> > > > I have looked into the .azure-pipelines.yml file, but it's not clear to
> > > > me how to configure the CI to install extra packages.
> > > 
> > > Ah, OK. So the package needs to be added to tools/docker/Dockerfile (and
> > > doc/build/gcc.rst). For testing changes out, you can then modify
> > > .azure-pipelines.yml to point at your image, rather than the default
> > > image. Or hack in a "sudo apt-get update && sudo apt-get install ..." to
> > > the job.
> > > 
> > > -- 
> > > Tom
> > 
> > Hi Tom
> > 
> > Updating the dockerfile and documentation was easy enough, but I was
> > still seeing the Azure pipeline fail with the same errors. It seems to
> > be ignoring the updated dockerfile.
> > 
> > After digging through the pipeline logs I noticed that Azure is using
> > the Windows Subsystem for Linux with Arch Linux to set up the test
> > environment. The package name 'pkcs11-provider' is even the same on
> > Arch, so I added that to .azure-pipelines.yml.
> > 
> >     https://archlinux.org/packages/extra/x86_64/pkcs11-provider/
> > 
> > And the Azure pipeline now fails because it reports the package doesn't
> > exist.
> > 
> >     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13066&view=logs&j=8222cf02-b5ce-5040-5def-6173bf341f71&t=5f6e674b-07e4-5ce5-77ac-ecaae7331dd8
> > 
> > I am not an expert in these CI systems, so I'm not sure what else can be
> > done to change the test environment.
> 
> So, I see two problems. One is the failure on Windows hosts. Perhaps
> https://www.msys2.org/docs/package-management/ has some hints on how to
> find out where it's looking for packages and if that's packaged in turn?
> The other is that the binman test suites are still failing, on Linux.
> 
> -- 
> Tom

Okay, I see now that MSYS2 is really a package management tool for
Windows that happens to reuse some of the tools from Arch Linux. But it
doesn't package pkcs11-provider. The only pkcs11 package available is
pkcs11-helper, which is a different upstream and does not resolve the
binman failures on Azure.

    https://packages.msys2.org/base/mingw-w64-pkcs11-helper

I will include the Dockerfile update adding pkcs11-provider when I send
v4, which should resolve the errors on Linux. But at this point I've
done all I can to resolve the issues with CI.

Eddie

