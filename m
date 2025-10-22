Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5E1CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B088323A;
	Thu, 23 Oct 2025 09:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HBgmUhNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0960F8323A; Thu, 23 Oct 2025 00:44:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2D980422
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 00:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761173047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gs7sFmS7jrMh8zON+FwAqurWicQJ7/Kf3q6Y5Be7Q6w=;
 b=HBgmUhNCYfy4Qx/kvNrF4bgZCxeAPaL1dDIbr4KZze+/++lBfdgGhv+uBtntfesQ06Wtd6
 anVCpMTjfhqa/UoXMCBh9POlgwA/62bjEnNa5P1PAd21b8dMBi3BW6HZZbewE1GjP3XUal
 0iTIheulK7Ji5LYxn3DBHFGcCnj4GOI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-e-PETUv8OgGys0DLgxj8Vw-1; Wed, 22 Oct 2025 18:44:06 -0400
X-MC-Unique: e-PETUv8OgGys0DLgxj8Vw-1
X-Mimecast-MFC-AGG-ID: e-PETUv8OgGys0DLgxj8Vw_1761173046
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-88f8f54a828so39848685a.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761173045; x=1761777845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gs7sFmS7jrMh8zON+FwAqurWicQJ7/Kf3q6Y5Be7Q6w=;
 b=UK3dyMgRzguLnpsdtSlL8L9WAoz/SQDJdfE1vZpumVFthqnZh0XbUIEhDAkhil/rcY
 eDfl8W0rwCIqKIVUZJk8vDceklmOn0nTeSk6AWwBJMEVrUsIU2bRyCOx89+3tydRkzB5
 QS7nkmNyeLX1h49e41u0K+Fg4wFe8OWkkOIlQvxeiscs55XNyB/qE5U5nsBr+VbnJLXB
 l0nghuw4ElJDuuIN2JiYfP/iUqX9ZPs5JUaUwUGhrzuXoQ41mm7GEev0GhPFYYheDNWn
 Nd0dJqpj9r7ZqcWthVLo6JFjwRrq6BUOYd/2B74eSxsG3mloc78ndI616uPKJqH/VUpY
 8jsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpRV/PW8ryMKJdorVfmdpaHEMcgezrFHcrtChMxfmopTU21rf+/NQ4qxs5eFDxtdPGAoXVZXY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5zmw0u+Gt8Ndy117sh06E0BxbRhtkxW4vu9WzVddwcqWJkj9x
 0RwDtRoEflqPM6AAHGJVvBD+RWYwm5atEOwMmkN0kpioirQv/+7OPi8mjRqCcedVzlQE4Ig5hP/
 TgzoK0Tv3dOyWtxGa8s/YxRq5wRhBb9ahZsuFEzC638aGBURqfuL2Lcg=
X-Gm-Gg: ASbGncv3VbJ7stscKxd00OYs9TbjLtK4OYKYK7k+cew2Qn0XGpuOSr/WPc/iC+TueD7
 yJ1otYHasPAH3CNvSXJR+DlOZzVHbf7G6nd/+tysU45Yf6vS/vj5fVPCzcDSpXnwOUxuXfblAMW
 4IqPOPYoYmF7jrvNLTMo05fglGOyvJgnv3n3aWXcd/uWeFD5bu3SCxAqG/5GiVIqfk3JCBDxEvi
 jWEBF473bxyLT85i8g9nx6JKbheb2YDX87z15WUPXwjmv/ZXPjJHmtc6XQ/kPQYs9V/8sBuqDBF
 ML748fcePgyQlmLhl+4ornlkuWMrmerozc4Ml9Vt1J1zRZaQng4N1aXhHed7A58vdN2oCg==
X-Received: by 2002:a05:620a:7003:b0:883:9634:5176 with SMTP id
 af79cd13be357-8906e2ca648mr2656160285a.2.1761173045557; 
 Wed, 22 Oct 2025 15:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmLnquooICcl/xR8uGmzEAbe5COPwMXZ9xBXCvMHGKewaceUvaoGwPScE6ZqHimhWqx1gP6w==
X-Received: by 2002:a05:620a:7003:b0:883:9634:5176 with SMTP id
 af79cd13be357-8906e2ca648mr2656158385a.2.1761173045118; 
 Wed, 22 Oct 2025 15:44:05 -0700 (PDT)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c12352ec2sm29098185a.52.2025.10.22.15.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 15:44:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 16:44:03 -0600
From: Eddie Kovsky <ekovsky@redhat.com>
To: Tom Rini <trini@konsulko.com>
Cc: Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] Add support for OpenSSL Provider API
Message-ID: <aPleM45ai8EJhmZO@daedalus>
References: <20251017171329.255689-1-ekovsky@redhat.com>
 <20251017215745.GJ6688@bill-the-cat>
MIME-Version: 1.0
In-Reply-To: <20251017215745.GJ6688@bill-the-cat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kf8QPQHXcKZ-63nsEgDIapUquS4zsj3Vg3A0hrRjOBM_1761173046
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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

On 10/17/25, Tom Rini wrote:
> On Fri, Oct 17, 2025 at 11:13:27AM -0600, Eddie Kovsky wrote:
> 
> > The Engine API has been deprecated since the release of OpenSSL 3.0. End users
> > have been advised to migrate to the new Provider interface. Several
> > distributions have already removed support for engines, which is preventing
> > U-Boot from being compiled in those environments.
> > 
> > The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the Provider API
> > while continuing to use the existing Engine API on distros shipping older
> > releases of OpenSSL.
> > 
> > This is based on similar work contributed by Jan Stancek
> > updating Linux to use the Provider interface.
> > 
> >     commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >     Author: Jan Stancek <jstancek@redhat.com>
> >     Date:   Fri Sep 20 19:52:48 2024 +0300
> > 
> >         sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> > 
> > The changes have been tested with the FIT signature verification vboot tests on
> > Fedora 42 and Debian 13. All 30 tests pass with both the legacy Engine library
> > installed and with the Provider API.
> > 
> > Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
> > ---
> >  lib/aes/aes-encrypt.c |  2 +
> >  lib/rsa/Kconfig       |  8 ++++
> >  lib/rsa/rsa-sign.c    | 93 ++++++++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 101 insertions(+), 2 deletions(-)
> 
> Thanks for doing this, I'm glad to see the work, and my comments are
> really style things to fix up and v2 once there's been time for real
> content comments if any.
> 
> [snip]
> > diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
> > index 9033384e60a3..622f06f8dba0 100644
> > --- a/lib/rsa/Kconfig
> > +++ b/lib/rsa/Kconfig
> > @@ -20,6 +20,14 @@ config SPL_RSA
> >  	bool "Use RSA Library within SPL"
> >  	depends on SPL
> >  
> > +config OPENSSL_NO_DEPRECATED
> > +	bool "Build U-Boot without support for OpenSSL Engine"
> > +	default n
> 
> This is the default, you can drop this.
> 
> [snip]
> > diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> > index 92b9d7876e52..9ebbcdfd52f3 100644
> > --- a/lib/rsa/rsa-sign.c
> > +++ b/lib/rsa/rsa-sign.c
> > @@ -19,15 +19,51 @@
> >  #include <openssl/err.h>
> >  #include <openssl/ssl.h>
> >  #include <openssl/evp.h>
> > +#if (IS_ENABLED(CONFIG_OPENSSL_NO_DEPRECATED))
> > +#include <err.h>
> > +#include <openssl/provider.h>
> > +#include <openssl/store.h>
> > +#else
> >  #include <openssl/engine.h>
> > +#endif // CONFIG_OPENSSL_NO_DEPRECATED
> 
> Two things (here and elsewhere). One, since we're generally using
> '#ifndef CONFIG_OPENSSL_NO_DEPRECATED' just using '#ifdef
> CONFIG_OPENSSL_NO_DEPRECATED' is fine, using a macro here is not aiding
> readability. Two, if the if/else/endif is within the patch context we
> really don't need a comment on the endif part.
> 
> -- 
> Tom

Hi Tom

I was trying to stick to the coding guidelines as closely as possible.
But I'm happy to replace the macro usage with standard #ifdef. I will
remove the extra comments and the default Kconfig as well when I send a
v2.

Thanks

Eddie

