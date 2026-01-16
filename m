Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C950C982FB
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 19:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41D983966;
	Fri, 16 Jan 2026 20:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Fq9HLGIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD9B836AC; Fri, 16 Jan 2026 20:00:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94F683015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 20:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768590053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzDR67jGeAAbM0UgldBcW/ZNVYzaBGShfWonUXp3LKY=;
 b=Fq9HLGIPridC9OmJth2N0xFBR/w0Or1KZc9HXsQeqTdmphn+l5EYRA6GSBX2saGk+buUsO
 /PWVMDFi2l4wenu4XKJrIigmbZGxr1zCH3tRpxWyYMhDI3wcz8hfCnNJQk82oEBfSlotD8
 ClGn6Qe4oaMgCLfM/eqaP2Ma2WxyWiU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-9SVTAGmxNHqCw1cvaFU2Bw-1; Fri, 16 Jan 2026 14:00:52 -0500
X-MC-Unique: 9SVTAGmxNHqCw1cvaFU2Bw-1
X-Mimecast-MFC-AGG-ID: 9SVTAGmxNHqCw1cvaFU2Bw_1768590052
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50148a1cc44so95230411cf.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768590052; x=1769194852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzDR67jGeAAbM0UgldBcW/ZNVYzaBGShfWonUXp3LKY=;
 b=dgzTS4wcz7dNk/U9lUnU/wiDAPqLNsWf6eN0w+CO8bSw845Ew41nvECryqzU++q2P6
 mdW1Fe+zkbqBdRn3wcy6ilpD8VYMn9reTZ7ia9GQGs6wrqGNV7PSYSfr7eb/me3PDbLw
 mSw7yRSQdjF+pp7xsvT+cdpa3WRaOMdxPk8PQl22p44GMd76/8KW8MR4VsWFxF4KBAjm
 bNRtH8kJIvIB0iTVxW4j+y+9x4uy67IOXilx/osHmmRN7murSWb3RQqpXP7ozKRMlv90
 qX/YeDnbyBJnP6FsWfdWLZcG7svh+Ewmo2XD1nc4sbzzWwYCxheKzbywvMx76NTImeai
 pPzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRYcWCgMmb54+XmhqOe3AMsllX1pJOuRRGhIxzkw1akhWaUf7PXMjaH5zCjFg2n4nqtO9sips=@lists.denx.de
X-Gm-Message-State: AOJu0YyRQhOwMVStWQk1K3JbAWftdDU7cwRP8S3oWEz198ZcO4yqAbHl
 NcI5o4uUNNrYiUBIUPF3jpqLkO9mhm4o9dSM6nN51s4TRAtPvvmcaGBdcfyxAUW4XOkKUcQR7cD
 4l7KYEx5EzwuY0uUGdTBsYDRwHC8vHxBChE0ihUfCdmGbQrS5ryUgygE=
X-Gm-Gg: AY/fxX5tt95F+qH2EX81PCAQc1JtaLbb7zCIzypFeiWe0ebyEf+YFKtrShwjT+s8T0s
 /ApTtnuuzaKfn1nqNyJu6ZkKvJ/Z5Ayzsz/5VC9d3W9YpGpzTXGarmpMRni1HffbRTc1ZHJVLEY
 Ep8EzYCC0aAAGG0guf1dI1DLECIencWRm0l5HOm9ffLlFUbHPMDk7gAkNDXC91MGwTr+6z9rYjK
 /BJzxLL7Nxq+xIsLHc4o5DiE044OqLVqkOTYC70SynwoGfrmvV+oVP3VLAh+NRPYLDrtLL48VwS
 GdZQJHqviGEIHEw+W3YxA85pIbeP+bhSI7DloC7+E+2ggYKpD1dKRPSpqFEtDMxDgThgHw+Mbtd
 rlXWB
X-Received: by 2002:ac8:5a95:0:b0:4ff:b231:3e1a with SMTP id
 d75a77b69052e-502a1fb913emr55806431cf.78.1768590051517; 
 Fri, 16 Jan 2026 11:00:51 -0800 (PST)
X-Received: by 2002:ac8:5a95:0:b0:4ff:b231:3e1a with SMTP id
 d75a77b69052e-502a1fb913emr55805341cf.78.1768590050727; 
 Fri, 16 Jan 2026 11:00:50 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1f1b872sm26169411cf.31.2026.01.16.11.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 11:00:50 -0800 (PST)
Date: Fri, 16 Jan 2026 12:00:49 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, mark.kettenis@xs4all.nl,
 Quentin Schulz <quentin.schulz@cherry.de>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
Message-ID: <aWqK4eo83-ybjlCQ@daedalus>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus> <87fr9h5swg.fsf@kernel.org>
 <aUmB_fvpK1macga7@daedalus> <87zf6sflkr.fsf@kernel.org>
 <20260106003347.GC3416603@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20260106003347.GC3416603@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k7HrBHV9UOhLU7m11S6ofUw5sv3F6ByKrxIk8OWXCz0_1768590052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 16 Jan 2026 20:29:22 +0100
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

On 01/05/26, Tom Rini wrote:
> On Mon, Jan 05, 2026 at 10:36:04AM +0100, Mattijs Korpershoek wrote:
> > On Mon, Dec 22, 2025 at 10:38, Eddie Kovsky <ekovsky@redhat.com> wrote:
> > 
> > > On 12/11/25, Mattijs Korpershoek wrote:
> > >> Hi Eddie,
> > >> 
> > >> Thank you for working on this. It would be really nice if we could build
> > >> U-Boot on more recent Linux distros without bridge packages such as
> > >> openssl-devel-engine.
> > >> 
> > >> 
> > >> I also don't linke this double negative.
> > >> As you already shared, Linux solved this via:
> > >> 
> > >> #if OPENSSL_VERSION_MAJOR >= 3
> > >> 
> > >> Why can't we have something similar?
> > >> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558bdc45dfb2669e1741384a0c80be9c82fa052c
> > >> 
> > >
> > > Hi Mattijs
> > >
> > > Yes, we could also implement it this way with the extra USE_PKCS11_XXX
> > > symbol. Jan's original patch I based my work on does something similar,
> > > and I perhaps oversimplified it.
> > 
> > In my experience, when porting things from the Linux kernel into U-Boot,
> > we try to keep the code as similar as possible. This helps reducing
> > maintainance burden.
> > 
> > Sometimes, we can't do that. In that case, we should explain why.
> > 
> > Do we have a strong reason for *not* reusing OPENSSL_VERSION_MAJOR with
> > USE_PKCS11_XXX ?
> > 
> > [...]
> > 
> > >> >> 
> > >> >
> > >> > It's not the prettiest code. But I'm trying to be very conservative
> > >> > in making these changes so that no one's workflow is disrupted.
> > >> > Developers should be able to build U-Boot with the latest OpenSSL
> > >> > without impacting developers who are in environments utilizing the
> > >> > Engine API. The goal here is to preserve feature parity between the two
> > >> > APIs. Adding support for custom Providers is outside the scope of this
> > >> > change, but could certainly be added later.
> > >> 
> > >> I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together and
> > >> just use "#if OPENSSL_VERSION_MAJOR >= 3".
> > >> 
> > >> Tom, or anyone else, is there a particular` reason for gating this in a
> > >> Kconfig ?
> > >> 
> > >> The oldest Ubuntu version that seems supported (22.04) already has
> > >> OpenSSL version 3:
> > >> 
> > >> $ podman run -it /bin/bash ubuntu:22.04
> > >> root@6dc347676b8a:~# apt update && apt install -y openssl
> > >> root@6dc347676b8a:~# openssl version
> > >> OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
> > >> 
> > >
> > > I assumed that we would want this to be an explicit config option, but
> > > logically there is no reason that it has to be. I'd be happy to spin up
> > > a v3 if there's agreement that the Kconfig isn't needed.
> > 
> > Tom, do you have an opinion on this? It seems you are listed as
> > maintainer for this (THE REST).
> 
> Yes, sorry, I think part of the question here is how it plays out with
> LibreSSL and other alternatives to openssl, which ends up being a Mark
> question.
> 
> -- 
> Tom

I am being careful not to break backwards compatibility here. I've
written the patch so that anyone who needs to continue using the Engine
API can do so.

The LibreSSL project implements the OpenSSL 1.1 API, but does not
support the OpenSSL 3 API, and to be the best of my knowledge does not
intend to support the Provider interface. During the V1 discussion I did
ask Mark to verify that my patch preserves backwards compatibility with
LibreSSL as intended.

Tom, regarding the other question, would you prefer that I implement
this using just #ifdefs without the Kconfig option?

Eddie

