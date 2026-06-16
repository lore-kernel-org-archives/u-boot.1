Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2346CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FBC84895;
	Tue, 16 Jun 2026 14:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBCPO/U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F76A84894; Tue, 16 Jun 2026 08:40:28 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CAB8484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37c5dabff14so8590a91.0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:40:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781592023; cv=none;
 d=google.com; s=arc-20240605;
 b=R/4S64vWf824xBtNzFXKIm4/LvPZvjxqhwNtaZ0hb1ultcDdh/c8F63WK4t6StJpMa
 i8TNSlsXyunIoqvgM/EbRpUqHBrVzZV9ymFabmr/AalmQxEv21nYKsi5Hee87R9r/gJH
 hjQPzJalvjQhHQjFe6EY9QNuMtwvr/HOeeRVDn9tg0O+qZZ4RCMTHakDbug9U/qdqQvE
 2ttVSg73lVEa0Sfy6B3mHd84fEAhm5cAxqci0ngziySjqdxqeCVURPCh6MqziswqQVoD
 uH8hDJ8RukNm1LdkBCjzBxf9J9tdSJtn4JKkyT7TlYDZDzAPWD4RxtkamK5QqROnFjbj
 UOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xa6rSMHu96HeitMNScoJHn1IZkWddHm7XuaCDKg+3cU=;
 fh=D6qvFFU0EZhjOgKMMVQIAYFSuWsMfrYZwCjbgl2RLPY=;
 b=TGvd68lYtjEoWKwY3fjeWVDXzIx+4qBsDvRWmotRemK1KpWw/jaDYrpcGLRhEjray+
 zxQYLYR9dFJLKUeBmcO4eybzRqE/Jplv1sMk93Gw7aYLfRuKDCun5kQ41RrYsXjb8S/o
 jU2KmHiNwGOKoEWZUq1uHd1/KFEqhUuz/oCzhf4zw4CnpDNmBVUMrcKihDM6b7MsMn/g
 fcjRKwSEgUPSNDlsFnKLFMXVm1huT527jor7kchlTsJ1dZos+7bqx0IHcDJHEXrSt63Q
 ZTUCbrkV0ivnfdDLYEDhFX6NxY7i83lHzCSZT8R/VVd/v6VTR0PNay8EGELnNdHprK53
 MapQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781592023; x=1782196823; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa6rSMHu96HeitMNScoJHn1IZkWddHm7XuaCDKg+3cU=;
 b=OBCPO/U1wNPkDeotD1Z+FoTeaCS3SUU+GPMy/WNmaSJ1tZjRtxk667ucZFXJExZu5d
 +Si2yMbdGGL4wIkWFP6hs13PurowTCS0hDN5lnVRHDvbunbfsX/MS1XZYU8pnYEtd3f+
 qKlvZC+Rjqm0MXvJMwInzyp7GFniWys4dHWZ9lk1vw4zL9wCpgIDmexQEZPAQYLCNxxc
 jOg02indy9Y6ZJCnw1ttTXsbW0e1efKt9xX0+7s0cKfaw9kwy6y5ZX6vPNexKkIDKcZk
 LJHC2/AfLcc13vDYUv5d7nAFXHZro8DItE/cL3r3SMF/1grNrqKd0nd/js8+kyVAeXwb
 Hg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781592023; x=1782196823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xa6rSMHu96HeitMNScoJHn1IZkWddHm7XuaCDKg+3cU=;
 b=iDHwh/OVwSF2Y9nebHxlioGrC2BtVuO5TMFIXbNz78piMcBR6E6RPrFtxDn10vpQyD
 eMQy7zCFxGmGdRklEtHGyKmU6U000EfL/3A9T9Zno8W9LOo6y5OJ5XUhmz/wCXG1i0rU
 A3TsI6us89hjS9o1YDHCk/gVqGPhP3e5Wp3+E1PqDcVyU8acU69rnVpRmQgr5i7tU7l/
 hh+ztGyb6OjjMIJeJ36k7MvHYOvqNzvOAMuBphFNs2Obs9c8zsCidXv1qYezLsz4mzLJ
 IwB4ojXBN6c9txDE9zSX0Si3JqpPWXDR/LrHC0FW+v/ySOgr79xtWi1dD8ooJRZjuoC1
 jhrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91DjaKgxaWatomd+5sh/fJzPBOdJ2lLObRz8SHApH642B3Kb4+unDimUCGVBZREPIL/o7A7zQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyWnPbactnWQnQHzuhzY2ADlrG/KEhd3qq+IwdJBRXvyPN0bIoL
 /zBI/VtylBdBACI+sYhK9w0A02pZZAWRKcoIpfz5PGmHpe7fcQ9QcS+Sa+u+PTWIYYNRwdLAzup
 /n5eVE7I2aZwjq9DVmXCybecrjYScBpk=
X-Gm-Gg: Acq92OEi02BsIms1qwLYYYMIcX4JV90u8IUCRzZWxGokropiG4yYN62U2eaDnhVl9dq
 ZBd9ybJIudQzElVZSj7EgKx0BYnUFi2PcYBRyRjgYzPx6KYSCbSAdv5vUC5TSkZ5tiWBizqQJs5
 L0D7xKYs2NJddudSkwChpLkF7gIy88WGHdv57++/7svTEaFDgNpHzv2/oyqBCeqU+Bi7/fyRWG4
 AMRIG1ZUQmiODKE5EPdQXDj/WG9H4wsCBMU43vdQSWLEGhIXvEabqN+KwR8ldj0raEpbeOllq1I
 Ej1L6w8o67X2SURdLwXohPPssIEiXo8gv9zj
X-Received: by 2002:a05:6a21:710c:b0:39b:8b59:4ec9 with SMTP id
 adf61e73a8af0-3b7837fa39bmr8786518637.0.1781592023491; Mon, 15 Jun 2026
 23:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
 <978a771c-678e-4956-9aa0-ba4fa8469350@cherry.de>
In-Reply-To: <978a771c-678e-4956-9aa0-ba4fa8469350@cherry.de>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Tue, 16 Jun 2026 08:40:12 +0200
X-Gm-Features: AVVi8CdmpP_tlqQPtxg1SwRiW59fFnj3FgHRHhEWwwzh69Bd3NzSU2FTgwVcRpI
Message-ID: <CAFqH_50b5CbjFFAfSdyjFo53HOOQYZZMq+v97bg+GAcSQ3C6tA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Tobias Olausson <tobias@eub.se>, u-boot@lists.denx.de, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 16 Jun 2026 14:26:56 +0200
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

Hi Quentin,

Missatge de Quentin Schulz <quentin.schulz@cherry.de> del dia dl., 15
de juny 2026 a les 18:51:
>
> Hi Heinrich,
>
> On 6/15/26 6:07 PM, Heinrich Schuchardt wrote:
> > Building with OpenSSL 4.0 fails:
> >
> >      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
> >      ./tools/../lib/rsa/rsa-sign.c: In function =E2=80=98rsa_engine_get=
_pub_key=E2=80=99:
> >      ./tools/../lib/rsa/rsa-sign.c:115:9: warning:
> >      =E2=80=98ENGINE_get_id=E2=80=99 is deprecated: ENGINE_get_id API s=
ymbol is removed.
> >      Define OPENSSL_ENGINE_STUBS to mask linker errors.
> >      [-Wdeprecated-declarations]
> >        115 |         engine_id =3D ENGINE_get_id(engine);
> >            |         ^~~~~~~~~
> >
> >      rsa-sign.c: undefined reference to `ENGINE_load_builtin_engines'
> >      rsa-sign.c: undefined reference to `ENGINE_by_id'
> >      rsa-sign.c: undefined reference to `ENGINE_init'
> >      rsa-sign.c: undefined reference to `ENGINE_set_default_RSA'
> >      rsa-sign.c: undefined reference to `ENGINE_ctrl_cmd_string'
> >      rsa-sign.c: undefined reference to `ENGINE_free'
> >      rsa-sign.c: undefined reference to `ENGINE_finish
> >
> > Add -DOPENSSL_ENGINE_STUBS -Wno-deprecated-declarations to the
> > rsa-sign.c build flags.
> >
>
> Please no.
>
> We should not build OpenSSL engines when they aren't supported at all
> anymore.
>
> Fedora is already complaining it doesn't build on OpenSSL 3.x anymore
> for them. See
> https://lore.kernel.org/u-boot/20260429180247.83091-1-ekovsky@redhat.com/
>
> The linked patch is not satisfactory though, and I've provided lengthy
> feedback a few times (although often with a big delay).
>
> I'm waiting on Eddie to answer as it's "gentleman agreement" in FOSS
> that the first who posts a patch gets to keep working on the patch until
> it gets satisfactory enough to be merged. I do admit I took a very long
> time a few times to answer so it didn't help with getting this forward.
> I am unsure how much longer we should wait for Eddie if more people are
> getting hit by this issue.
>

It looks like Eddie is away on holiday for at least two weeks more, so
we shouldn't expect a v5 series or a reply from him.

I must admit, it took me a bit of time to piece together all the
review notes scattered across the different email threads! :-)

I tried to consolidate the goal of the patch and your reviews into a
summary in my previous reply in v4. Since Eddie is out for a bit,
could you take a quick look at that breakdown when you have a moment?
I want to make sure the proposed path forward makes sense to you, or
if I=E2=80=99ve completely misread the situation.

Cheers,
  Enric

> As told on the linked patch, I have local patches (that I need to write
> nice commit logs for) to support OpenSSL providers and remove OpenSSL
> engine support for releases and variants of OpenSSL not supporting
> engines. With (binman) unit tests passing.
>
> Note that this patch here is also not sufficient as, sure, it makes it
> possible to build U-Boot again, but you won't be able to run the test
> suite as we build dummy-rsa-engine.c unconditionally and you'll have the
> same build issue then.
>
> As said in the linked patch, I would welcome an immediate patch that is
> disabling OpenSSL engine support with a big ifdef (still won't fix the
> "dummy-rsa-engine"-based tests but I haven't come up with a way to fix
> this "nicely").
>
> Cheers,
> Quentin
