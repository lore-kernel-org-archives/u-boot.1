Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE32E67803
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 18:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9C183B99;
	Mon, 22 Dec 2025 19:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="T11DH46n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B1CE83D1A; Mon, 22 Dec 2025 18:38:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5A683B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 18:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ekovsky@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766425091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DU2v0WTcK7U1tnvZDKmy+5p9IAELTqf9e9He/RjkDH0=;
 b=T11DH46n/sYkb/4ha8N065aU3XX2RIN2uwYoklLcolfzN9VZOMiCUcyJD6qcmeOwm2XDzl
 /dZPEggM4U206E/iIxF019U4E9lOwCam2k+GKQMNrHWx2k/srb0ZwrL3fxvg1OhY4sclRC
 aRHl54jeTR3H9FLhfXYybnkKYqkAbns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-HGmwXuoIPJCqrDDSj48tkA-1; Mon, 22 Dec 2025 12:38:08 -0500
X-MC-Unique: HGmwXuoIPJCqrDDSj48tkA-1
X-Mimecast-MFC-AGG-ID: HGmwXuoIPJCqrDDSj48tkA_1766425087
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a360b8096so99613086d6.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766425087; x=1767029887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DU2v0WTcK7U1tnvZDKmy+5p9IAELTqf9e9He/RjkDH0=;
 b=JBH5ruL8rniZ+na7vVGCuJg8OePJPErkWa7EIE/2Fn/40RG47jZ0Axwt8AA7iqRQcC
 GT7Jm0vCiyxSTiHztGI7S82FTOQA6idaVcbioxBhFgcKIehJ6SR+qvsOp0oZgMjQyV+n
 852xW+QcMgzT0HPnkKuYAiC+SyZXetnBVUar/RZ2hGtjFcFluhU7/qS9lEgMe1mKUOUK
 W60ISvJEE/MD38A8j2QQgZWhtPw2b3jnFnFVNkCm2iMmjm7DcwIt4C/5/cCSse1uuop4
 6+8PZ4Ih4SdbMG8lexykn0e50i2Sr0yEtwa1loluphpnJ+5YgzDn0I8g9v7C0Jj+sYDD
 gfcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7SvgpNrP88pKKmIL/jefKahGYoo6etMatiZHnhDbuQt/2I7FvS7LYItVArK2uM+cmYRefgjQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+211KpIZAYCtFH+yUhC5cvZ3rgSlo3Fb9qbOFgkc68h1qgSoa
 0LNdFkYIwMkl6hALEui2JE1v7PnqDYT1CR5ubCiT5NwRRSwpPB4N1HicP6S58YnJlXBu9tpYbIW
 5paR/WpXj6JX6TNGP7+BwM4Fu9tM7cVJehXsDRJAUoFR60G4a8fWzOs0=
X-Gm-Gg: AY/fxX7FxwNV6ppDCfAyTHw4losUejxSz0sZA5buZ6UPvjmarmoJ5wRDB5FcFvs1d0M
 XRXx1Qw0JrijmPOTR8c4ihpzqlqirw5m6tXBWyR/T6hDHIRUNP35Y5MT/b4zvxc5NbaUnnvQeh1
 jOD6hy0olp2GcUVMcBf5nFb3B31mkM1GDqRHlp6sI5psgxRAk9A3rktUL/Rwf0lOtYg3+3uZtmE
 pZyvTZDzQfzo2aCTke0fik7GtxqwVB3icRAxP7Ht2m+ATyXq4+hlO2wGFj7ftFkLc30aa0Z5Zeh
 6HD0r1oS0iTmUZugDjuQaBsFz5zCrdMeMLXfF6BuAepFkbKmRINp0c2sG9MWtSegXLJq/DbyNjx
 hvZLT
X-Received: by 2002:a0c:f789:0:b0:88a:2ebd:1e3a with SMTP id
 6a1803df08f44-88d854e1362mr126836196d6.62.1766425087344; 
 Mon, 22 Dec 2025 09:38:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGx1Od1+fAhytGumqHSI7ngZEdyVI3FVzUvmcf83lMQ6G15D3orLJiNLO86pfmKyKgpKBIDQ==
X-Received: by 2002:a0c:f789:0:b0:88a:2ebd:1e3a with SMTP id
 6a1803df08f44-88d854e1362mr126835836d6.62.1766425086828; 
 Mon, 22 Dec 2025 09:38:06 -0800 (PST)
Received: from localhost ([38.246.12.206]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997ada77sm86152506d6.37.2025.12.22.09.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 09:38:06 -0800 (PST)
Date: Mon, 22 Dec 2025 10:38:05 -0700
From: Eddie Kovsky <ekovsky@redhat.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
Message-ID: <aUmB_fvpK1macga7@daedalus>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus> <87fr9h5swg.fsf@kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fr9h5swg.fsf@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kWpqp3NhBawmMZWgdXEUemjZjnt6BDwyGgsiGjXZH4Y_1766425087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 22 Dec 2025 19:04:16 +0100
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

On 12/11/25, Mattijs Korpershoek wrote:
> Hi Eddie,
> 
> Thank you for working on this. It would be really nice if we could build
> U-Boot on more recent Linux distros without bridge packages such as
> openssl-devel-engine.
> 
> 
> I also don't linke this double negative.
> As you already shared, Linux solved this via:
> 
> #if OPENSSL_VERSION_MAJOR >= 3
> 
> Why can't we have something similar?
> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558bdc45dfb2669e1741384a0c80be9c82fa052c
> 

Hi Mattijs

Yes, we could also implement it this way with the extra USE_PKCS11_XXX
symbol. Jan's original patch I based my work on does something similar,
and I perhaps oversimplified it.

> >
> > [4] https://docs.openssl.org/3.0/man7/openssl_user_macros/
> >
> >> > Provider API while continuing to use the existing Engine API on distros
> >> > shipping older releases of OpenSSL.
> >> > 
> >> 
> >> One can use org.openssl.engine: as prefix for provider arguments when one
> >> wants to use an engine still.
> >> 
> >
> > Sorry, but it's not clear what you are referring to here.
> >
> >> > This is based on similar work contributed by Jan Stancek updating Linux
> >> > to use the Provider interface.
> >> > 
> >> >      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
> >> >      Author: Jan Stancek <jstancek@redhat.com>
> >> >      Date:   Fri Sep 20 19:52:48 2024 +0300
> >> > 
> >> >          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
> >> > 
> >> > The changes have been tested with the FIT signature verification vboot
> >> > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
> >> > Engine library installed and with the Provider API.
> >> > 
> >> 
> >> Are there actually tests using an OpenSSL engine? Because otherwise it's
> >> simply checking that local keys are still working... which isn't that much
> >> different from what we currently have with engines when not using engines.
> >> 
> >> I'm implementing FIT images signing with OpenSSL engines, and it'd be nice
> >> if we could have something that doesn't require changes to support providers
> >> (or if it does, not in a confusing manner for example).
> >> 
> >> https://lore.kernel.org/u-boot/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de/T/#t
> >> for the v1, I'll soon (next hours or tomorrow) post a v2 and Cc you if you
> >> don't mind.
> >> 
> >> [...]
> >> 
> >
> > As mentioned above, the motivation for this patch is that the Engine
> > API has already been deprecated. Projects that depend on OpenSSL will
> > need to move to the new Provider API in order to continue to function.
> >
> > The FIT Signature Verification tests I used to exercise both APIs are
> > documented here.[5]
> >
> > [5] https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification
> >
> >
> >> > diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
> >> > index 9033384e60a3..1bf0ac96d598 100644
> >> > --- a/lib/rsa/Kconfig
> >> > +++ b/lib/rsa/Kconfig
> >> > @@ -20,6 +20,13 @@ config SPL_RSA
> >> >          bool "Use RSA Library within SPL"
> >> >          depends on SPL
> >> > 
> >> > +config OPENSSL_NO_DEPRECATED
> >> > +       bool "Build U-Boot without support for OpenSSL Engine"
> >> > +       help
> >> > +         Add support for the OpenSSL Provider API, which is the officially
> >> > +         supported mechanism in OpenSSL 3.x and later releases for accessing
> >> > +         hardware and software cryptography.
> >> > +
> >> 
> >> mmmm Cannot we use providers for something else than RSA? In which case it's
> >> a bit odd to have it in lib/rsa/Kconfig (but I have no better suggestion).
> >> 
> >
> > To the best of my knowledge, the only areas in the U-Boot source that
> > are using the Engine API are the RSA and AES libraries. All other uses
> > in U-Boot are clients of these two libraries.
> >
> >> >   config SPL_RSA_VERIFY
> >> >          bool
> >> >          depends on SPL_RSA
> >> 
> >> [...]
> >> 
> >> > @@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> >> >                  return -ENOENT;
> >> >          }
> >> > 
> >> > +#ifdef CONFIG_OPENSSL_NO_DEPRECATED
> >> > +       EVP_PKEY *private_key = NULL;
> >> > +       OSSL_STORE_CTX *store;
> >> > +
> >> > +       if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> >> > +               ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> >> > +       if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> >> > +               ERR(1, "OSSL_PROVIDER_try_load(default)");
> >> > +
> >> > +       store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
> >> > +       ERR(!store, "OSSL_STORE_open");
> >> > +
> >> > +       while (!OSSL_STORE_eof(store)) {
> >> > +               OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> >> > +
> >> > +               if (!info) {
> >> > +                       drain_openssl_errors(__LINE__, 0);
> >> > +                       continue;
> >> > +               }
> >> > +               if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> >> > +                       private_key = OSSL_STORE_INFO_get1_PKEY(info);
> >> > +                       ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> >> > +               }
> >> > +               OSSL_STORE_INFO_free(info);
> >> > +               if (private_key)
> >> > +                       break;
> >> > +       }
> >> > +       OSSL_STORE_close(store);
> >> > +
> >> > +       *evpp = private_key;
> >> > +#else
> >> 
> >> Wondering if it really makes sense to have the provider API implemented as
> >> an #ifdef to save like 10 common lines between key-based and provider-based
> >> implems.
> >> 
> >> On another topic, my first reading of the code makes me a bit worried by the
> >> fact that there's seemingly no way to select whether we want to use a local
> >> key or a provider key. Also, I see "pkcs11" and "default" here, but how do I
> >> select which provider I want to use (e.g. my custom one). If I somehow
> >> manage to have a key named the same locally and in one or more providers,
> >> how do I make sure the proper one is selected? I'm wondering whether we
> >> should be reusing the engine parameter to select a provider?
> >> 
> >> I have 0 security or crypto background, don't hesitate to be verbose in your
> >> answer.
> >> 
> >> Cheers,
> >> Quentin
> >> 
> >
> > It's not the prettiest code. But I'm trying to be very conservative
> > in making these changes so that no one's workflow is disrupted.
> > Developers should be able to build U-Boot with the latest OpenSSL
> > without impacting developers who are in environments utilizing the
> > Engine API. The goal here is to preserve feature parity between the two
> > APIs. Adding support for custom Providers is outside the scope of this
> > change, but could certainly be added later.
> 
> I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together and
> just use "#if OPENSSL_VERSION_MAJOR >= 3".
> 
> Tom, or anyone else, is there a particular` reason for gating this in a
> Kconfig ?
> 
> The oldest Ubuntu version that seems supported (22.04) already has
> OpenSSL version 3:
> 
> $ podman run -it /bin/bash ubuntu:22.04
> root@6dc347676b8a:~# apt update && apt install -y openssl
> root@6dc347676b8a:~# openssl version
> OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)
> 

I assumed that we would want this to be an explicit config option, but
logically there is no reason that it has to be. I'd be happy to spin up
a v3 if there's agreement that the Kconfig isn't needed.

Eddie

