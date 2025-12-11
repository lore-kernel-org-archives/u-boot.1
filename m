Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4110D41C02
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E396A83C94;
	Thu, 11 Dec 2025 09:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jIHYvPpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F4A83C9F; Thu, 11 Dec 2025 09:23:19 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ADFC83BFE
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D2F843DC5;
 Thu, 11 Dec 2025 08:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF094C4CEFB;
 Thu, 11 Dec 2025 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765441394;
 bh=jMIUmWpON58mVNJDoT/8YAr1kPKvmvO6aEUK9z5V4o8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jIHYvPpWMBRu7CWsUdzb54I7EzCaXhEpH9A4XP7D7zaJRBSstLWgLFpfnPWtmVvrr
 azhFul/xUrt81QpYXlqV5TQq4SDCqJ7IifUPjmuB2heyzxGYpU77hFSfGO7a9ZrzIf
 E9Isp7fQK5R67csggKPvb73Rz8irkBp6LstOYnhy51VM5aRJo6XlWhGmdRdaHtMCjc
 s+r/rJvwMkjaFDR63T7wS8OeVlvODIgaW46aALBQ1pRnoYpXN5vLRoPD31cHD97vRl
 WtTPw9VTOeExEUXrhLTYD2Wzx91QMjtnkw/8+erPXVPOG3p1dnECiuyhzDqhDdkSvg
 ASMRzY50idvVQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eddie Kovsky <ekovsky@redhat.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] Add support for OpenSSL Provider API
In-Reply-To: <aSCsgniomRMN0u1m@daedalus>
References: <20251027195834.71109-1-ekovsky@redhat.com>
 <c2b48b27-9d4e-4be8-b94a-4aac7ef922a8@cherry.de>
 <aSCsgniomRMN0u1m@daedalus>
Date: Thu, 11 Dec 2025 09:23:11 +0100
Message-ID: <87fr9h5swg.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Eddie,

Thank you for working on this. It would be really nice if we could build
U-Boot on more recent Linux distros without bridge packages such as
openssl-devel-engine.

On Fri, Nov 21, 2025 at 11:16, Eddie Kovsky <ekovsky@redhat.com> wrote:

> Hi Quentin
>
> On 11/17/25, Quentin Schulz wrote:
>> Hi Eddie,
>> 
>> On 10/27/25 8:58 PM, Eddie Kovsky wrote:
>> > [You don't often get email from ekovsky@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>> > 
>> > The Engine API has been deprecated since the release of OpenSSL 3.0. End
>> > users have been advised to migrate to the new Provider interface.
>> > Several distributions have already removed support for engines, which is
>> > preventing U-Boot from being compiled in those environments.
>> > 
>> 
>> Which ones? How do I reproduce?
>> 
>
> As you are probably aware, OpenSSL deprecated the Engine API with the
> 3.0 release, and engines are likely to be removed entirely when
> OpenSSL 4.0 is released in 2026. [1][2]
>
> [1] https://docs.openssl.org/3.0/man7/migration_guide/#engines-and-method-apis
> [2] https://github.com/openssl/openssl/discussions/21832
>
> I don't have a comprehensive list of all distros. Fedora, RHEL 10,
> Arch, and Debian 13 are all shipping OpenSSL 3.5. If you try to build
> U-Boot in those environments the compiler will not be able to resolve the
> engine API symbols and the build will fail.
>
> Fedora is currently providing a bridge package openssl-devel-engine [3] to
> help make the API transition easier, but that is only a temporary
> solution. (I think Debian is currently doing something similar.)
>
> [3] https://packages.fedoraproject.org/pkgs/openssl/openssl-devel-engine/
>
>> > The Kconfig option OPENSSL_NO_DEPRECATED introduces support for the
>> 
>> Please consider renaming this, OpenSSL itself uses OPENSSL_NO_DEPRECATED
>> constants for many things. I would recommend simply renaming to
>> OPENSSL_NO_ENGINE which is also the symbol OpenSSL is using. If there comes
>> a time we have more OPENSSL_NO_ options, we can always have a "virtual"
>> symbol called OPENSSL_NO_DEPRECATED which would select them all if one
>> wanted for example.
>> 
>
> I did give some thought to using a different name because I don't
> like the double negative that comes from this construct:
>
>     #ifndef CONFIG_OPENSSL_NO_DEPRECATED
>
> But I kept it because the name is advantageous precisely because it's
> already recognized by the OpenSSL API. OPENSSL_NO_DEPRECATED is a
> user-defined macro.[4] When combined with the OPENSSL_API_COMPAT macro,
> which is already defined in lib/rsa/rsa-sign.c, we can ensure that
> deprecated symbols won't be available in sections where
> OPENSSL_NO_DEPRECATED is defined.

I also don't linke this double negative.
As you already shared, Linux solved this via:

#if OPENSSL_VERSION_MAJOR >= 3

Why can't we have something similar?
See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=558bdc45dfb2669e1741384a0c80be9c82fa052c

>
> [4] https://docs.openssl.org/3.0/man7/openssl_user_macros/
>
>> > Provider API while continuing to use the existing Engine API on distros
>> > shipping older releases of OpenSSL.
>> > 
>> 
>> One can use org.openssl.engine: as prefix for provider arguments when one
>> wants to use an engine still.
>> 
>
> Sorry, but it's not clear what you are referring to here.
>
>> > This is based on similar work contributed by Jan Stancek updating Linux
>> > to use the Provider interface.
>> > 
>> >      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>> >      Author: Jan Stancek <jstancek@redhat.com>
>> >      Date:   Fri Sep 20 19:52:48 2024 +0300
>> > 
>> >          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>> > 
>> > The changes have been tested with the FIT signature verification vboot
>> > tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
>> > Engine library installed and with the Provider API.
>> > 
>> 
>> Are there actually tests using an OpenSSL engine? Because otherwise it's
>> simply checking that local keys are still working... which isn't that much
>> different from what we currently have with engines when not using engines.
>> 
>> I'm implementing FIT images signing with OpenSSL engines, and it'd be nice
>> if we could have something that doesn't require changes to support providers
>> (or if it does, not in a confusing manner for example).
>> 
>> https://lore.kernel.org/u-boot/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de/T/#t
>> for the v1, I'll soon (next hours or tomorrow) post a v2 and Cc you if you
>> don't mind.
>> 
>> [...]
>> 
>
> As mentioned above, the motivation for this patch is that the Engine
> API has already been deprecated. Projects that depend on OpenSSL will
> need to move to the new Provider API in order to continue to function.
>
> The FIT Signature Verification tests I used to exercise both APIs are
> documented here.[5]
>
> [5] https://docs.u-boot.org/en/latest/usage/fit/signature.html#u-boot-fit-signature-verification
>
>
>> > diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
>> > index 9033384e60a3..1bf0ac96d598 100644
>> > --- a/lib/rsa/Kconfig
>> > +++ b/lib/rsa/Kconfig
>> > @@ -20,6 +20,13 @@ config SPL_RSA
>> >          bool "Use RSA Library within SPL"
>> >          depends on SPL
>> > 
>> > +config OPENSSL_NO_DEPRECATED
>> > +       bool "Build U-Boot without support for OpenSSL Engine"
>> > +       help
>> > +         Add support for the OpenSSL Provider API, which is the officially
>> > +         supported mechanism in OpenSSL 3.x and later releases for accessing
>> > +         hardware and software cryptography.
>> > +
>> 
>> mmmm Cannot we use providers for something else than RSA? In which case it's
>> a bit odd to have it in lib/rsa/Kconfig (but I have no better suggestion).
>> 
>
> To the best of my knowledge, the only areas in the U-Boot source that
> are using the Engine API are the RSA and AES libraries. All other uses
> in U-Boot are clients of these two libraries.
>
>> >   config SPL_RSA_VERIFY
>> >          bool
>> >          depends on SPL_RSA
>> 
>> [...]
>> 
>> > @@ -207,6 +247,37 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>> >                  return -ENOENT;
>> >          }
>> > 
>> > +#ifdef CONFIG_OPENSSL_NO_DEPRECATED
>> > +       EVP_PKEY *private_key = NULL;
>> > +       OSSL_STORE_CTX *store;
>> > +
>> > +       if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
>> > +               ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
>> > +       if (!OSSL_PROVIDER_try_load(NULL, "default", true))
>> > +               ERR(1, "OSSL_PROVIDER_try_load(default)");
>> > +
>> > +       store = OSSL_STORE_open(path, NULL, NULL, NULL, NULL);
>> > +       ERR(!store, "OSSL_STORE_open");
>> > +
>> > +       while (!OSSL_STORE_eof(store)) {
>> > +               OSSL_STORE_INFO *info = OSSL_STORE_load(store);
>> > +
>> > +               if (!info) {
>> > +                       drain_openssl_errors(__LINE__, 0);
>> > +                       continue;
>> > +               }
>> > +               if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
>> > +                       private_key = OSSL_STORE_INFO_get1_PKEY(info);
>> > +                       ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
>> > +               }
>> > +               OSSL_STORE_INFO_free(info);
>> > +               if (private_key)
>> > +                       break;
>> > +       }
>> > +       OSSL_STORE_close(store);
>> > +
>> > +       *evpp = private_key;
>> > +#else
>> 
>> Wondering if it really makes sense to have the provider API implemented as
>> an #ifdef to save like 10 common lines between key-based and provider-based
>> implems.
>> 
>> On another topic, my first reading of the code makes me a bit worried by the
>> fact that there's seemingly no way to select whether we want to use a local
>> key or a provider key. Also, I see "pkcs11" and "default" here, but how do I
>> select which provider I want to use (e.g. my custom one). If I somehow
>> manage to have a key named the same locally and in one or more providers,
>> how do I make sure the proper one is selected? I'm wondering whether we
>> should be reusing the engine parameter to select a provider?
>> 
>> I have 0 security or crypto background, don't hesitate to be verbose in your
>> answer.
>> 
>> Cheers,
>> Quentin
>> 
>
> It's not the prettiest code. But I'm trying to be very conservative
> in making these changes so that no one's workflow is disrupted.
> Developers should be able to build U-Boot with the latest OpenSSL
> without impacting developers who are in environments utilizing the
> Engine API. The goal here is to preserve feature parity between the two
> APIs. Adding support for custom Providers is outside the scope of this
> change, but could certainly be added later.

I'd be in favor to drop CONFIG_OPENSSL_NO_DEPRECATED all together and
just use "#if OPENSSL_VERSION_MAJOR >= 3".

Tom, or anyone else, is there a particular` reason for gating this in a
Kconfig ?

The oldest Ubuntu version that seems supported (22.04) already has
OpenSSL version 3:

$ podman run -it /bin/bash ubuntu:22.04
root@6dc347676b8a:~# apt update && apt install -y openssl
root@6dc347676b8a:~# openssl version
OpenSSL 3.0.2 15 Mar 2022 (Library: OpenSSL 3.0.2 15 Mar 2022)

>
> Eddie
