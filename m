Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB8E99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4662684242;
	Sat, 11 Apr 2026 09:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AmndMj/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A640840D8; Sat, 11 Apr 2026 03:03:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A39783DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 03:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775869381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5uxdLGqdyr26KBa8khYRsCN8MTqre22xxr02me1+o4=;
 b=AmndMj/RdL38oMHfysKN9aoeYjdMtdtr8jKhgcRWno+F3wTrO63amQ5xw34pd7tAyR7eJp
 gp9TJVAZGndgNpKKzLbShzwPKRpWjpNmi+1S/T9f3K26buA5gftcDT4X9z5Xjj/xPRs2/L
 AA6KVaqz/8yA7EfUwK/5ntbCxcQnC+8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-qSCo0m9vNfuHgAgMgp0nVw-1; Fri, 10 Apr 2026 21:03:00 -0400
X-MC-Unique: qSCo0m9vNfuHgAgMgp0nVw-1
X-Mimecast-MFC-AGG-ID: qSCo0m9vNfuHgAgMgp0nVw_1775869379
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d826ed6f9so61197351cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 18:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775869379; x=1776474179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5uxdLGqdyr26KBa8khYRsCN8MTqre22xxr02me1+o4=;
 b=mkWFT7K/wQIlnktfWfWGmB8KB+xwV0FE5b+FLMwr85uCBQ8yQ+KDuU+oTbRZnmRzXx
 D2f2qeoNNXc07Z3KV8Is6dRmy7Q3DVqk/+fW1zT0BrE5gNsAgWFd0NU4P/9haRhUkLnx
 5vdlFQIgjCiSB/C4s6Z8u4PxAZ+2sMTd4vkXA0uRLk2RfjQjrk98DjlMQjULwdRjeLD3
 k8ISjcGAkq/ut+IyceslFTILhrSUeufn4+b3bMniVHfQgHIf8CKagyJ2rxlkQ7d7CSej
 lj8DNrBBORuWyNSwxxiyhOHXppWRMbItKUgSIZ62HUpj4YDRKFTcfOj09GD3X6jpbk2S
 2Fqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQyMFl7wn1TvCxYDOyJnNWUKtUU8YlLZEDPCjR84nTT4OB154Pt8r/m/dNEzaPxx9cyderNVw=@lists.denx.de
X-Gm-Message-State: AOJu0YznpZMu4Xe2P+xuradlnCx1cdIm4oHjHNhx7hHIxmYvIC1Cmc7s
 C2XbVlkQFAmhU3StmO8/iahiQWms9p3e3TfmN9CprfvUOf7UGg185RPBJ7YHBaS/ojsaEHYn6Ov
 k7kK5NvXTekxrDnr1YEpKab/hXKzAJk6aHUvXzW2c1ukFE+xajiSziHg=
X-Gm-Gg: AeBDiet2ohXwm+SXrinVTfoS1tVGDOLBmVwfqcb5PVKBr77+vIUsovxEOJskjdbWOxt
 cpSUyFOt8Vdq9r4/idMFnkbCtq7BOrcmsVIDB+e45ZTSL+PAI3pddPUHjFDAtZxGykNNaXVBwfF
 6ro+f7zLogMQmQBh6H2qKxGm9waE5ekuS+62s8MkwE/w6Qdop1YZDCBUlQGYAabuePFGGvOe/h8
 sMW8/CQ8HLSWTfteDqpA2XhlW8aEqG7qECAGsjEngStOA4Dy6cfxeVgbTMtRDLA72am3fAXaFAx
 s12JJ3sz6gFf+tgB1r67zs6WBH0wGyIAJCd0TmjOlhIb/I4kcJUWWRjv2sDJY1dy3liDEDeP7aq
 Ds8yezkLpMPTT4FwV
X-Received: by 2002:a05:620a:31a5:b0:8da:4c20:50f0 with SMTP id
 af79cd13be357-8dc439f1c7dmr1271906985a.8.1775869379418; 
 Fri, 10 Apr 2026 18:02:59 -0700 (PDT)
X-Received: by 2002:a05:620a:31a5:b0:8da:4c20:50f0 with SMTP id
 af79cd13be357-8dc439f1c7dmr1271903385a.8.1775869378909; 
 Fri, 10 Apr 2026 18:02:58 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84c45944sm37039096d6.24.2026.04.10.18.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 18:02:58 -0700 (PDT)
From: Eddie Kovsky <ekovsky@redhat.com>
X-Google-Original-From: Eddie Kovsky <ewk@edkovsky.org>
Date: Fri, 10 Apr 2026 19:02:57 -0600
To: Tom Rini <trini@konsulko.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v3] Add support for OpenSSL Provider API
Message-ID: <admdwS1tuX_ZdPFF@daedalus>
References: <20260120164524.253188-1-ekovsky@redhat.com>
 <87ikckmbbi.fsf@kernel.org> <aZc_efHFk1Q-iWvP@daedalus>
 <20260219172836.GN3233182@bill-the-cat> <aaHWNU0LQqJ0zNDD@daedalus>
 <20260227174744.GW1593142@bill-the-cat> <ac2WqaHYgLslig_a@daedalus>
 <20260402162704.GG41863@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20260402162704.GG41863@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jWolvXrgPoSz0hBtsXwCcsdcJdEdTt-aTrjOBiax1aM_1775869379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

--->8
> > I finally got to the bottom of this. Debian/Ubuntu ship OpenSSL backends
> > separately. The CI environment is missing the 'pkcs11-provider'
> > package, which is causing the binman tests to fail.
> > 
> >     $ apt show pkcs11-provider
> >     Package: pkcs11-provider
> >     Version: 1.0-3
> >     Priority: optional
> >     Section: libs
> >     Maintainer: Luca Boccassi <bluca@debian.org>
> >     Installed-Size: 410 kB
> >     Depends: libc6 (>= 2.34), libssl3t64 (>= 3.0.7~)
> >     Homepage: https://github.com/latchset/pkcs11-provider
> >     Download-Size: 125 kB
> >     APT-Manual-Installed: yes
> >     APT-Sources: http://ftp.debian.org/debian stable/main amd64 Packages
> >     Description: OpenSSL 3 provider for PKCS11
> >     With this provider for OpenSSL you can use the OpenSSL library
> >     (version 3) and command line tools with any PKCS11 implementation as
> >     backend for the crypto operations.
> > 
> > With this package installed the SSL errors logged on Azure are no longer reproducible.
> > 
> > The results from the first pipeline expired while I was investigating
> > this. I reran the CI job so you can see the error messages.
> > 
> >     https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13035&view=logs&j=c59aff74-743b-5f08-f408-4a608a489153&t=f2ea3536-b291-5a39-ad92-0220c9b8101a
> > 
> > I have looked into the .azure-pipelines.yml file, but it's not clear to
> > me how to configure the CI to install extra packages.
> 
> Ah, OK. So the package needs to be added to tools/docker/Dockerfile (and
> doc/build/gcc.rst). For testing changes out, you can then modify
> .azure-pipelines.yml to point at your image, rather than the default
> image. Or hack in a "sudo apt-get update && sudo apt-get install ..." to
> the job.
> 
> -- 
> Tom

Hi Tom

Updating the dockerfile and documentation was easy enough, but I was
still seeing the Azure pipeline fail with the same errors. It seems to
be ignoring the updated dockerfile.

After digging through the pipeline logs I noticed that Azure is using
the Windows Subsystem for Linux with Arch Linux to set up the test
environment. The package name 'pkcs11-provider' is even the same on
Arch, so I added that to .azure-pipelines.yml.

    https://archlinux.org/packages/extra/x86_64/pkcs11-provider/

And the Azure pipeline now fails because it reports the package doesn't
exist.

    https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13066&view=logs&j=8222cf02-b5ce-5040-5def-6173bf341f71&t=5f6e674b-07e4-5ce5-77ac-ecaae7331dd8

I am not an expert in these CI systems, so I'm not sure what else can be
done to change the test environment.

Eddie

