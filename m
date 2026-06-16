Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D00CCD98D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 20:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B02848BF;
	Tue, 16 Jun 2026 22:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SHK4eqKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A67848C5; Tue, 16 Jun 2026 22:21:03 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB071848BA
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 22:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5aa68d9d56fso6971821e87.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 13:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781641260; cv=none;
 d=google.com; s=arc-20240605;
 b=UIQQntH8LEjWimpsnhkRyFANPXlPie7liy2BcMkEeLtzT41wz92+AXK1Np5ZKYT74F
 l4dh9QnhPCYHTmpRWNgkWMQeMGnkMNp0QPZIwKPE7yMKtbbHxzIVtC8kWcRsfFbUTWWL
 GW9ReOsTV2tCzK4/ziCHgHYYsM1r4nGL73Vo2iA4HJb2VcU5KY1W7OikIwp2w5kHS7uA
 jEPcFNuyengAeDVfs0Gfy1/y9XGAnryNbL+Dh6Db7tPPno77I/zCQWU2qs7S9Pu13/yq
 YGgnK7HjH3ay7eosxdzDLFLMI7AeEHFA9xBDLjklz79q2+tYNpLnIUXFkbmhSLEG//5X
 fwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k/4qTAe5Zn5NunAHHjKwKFozHVtff/sEiKKU+iRLThw=;
 fh=Onk8CV/oMe/7ruVfDBgE4uDC4qaGrgigx0Kwh6MN8n8=;
 b=Jx4/B5Hn2wloF5Ht9OtBgm2J3GcPmlAbjOxqdqVh1iMfepJPeJJxLvZqbsSDjA4bmW
 YmHWU8ZNLyCEMYRRiAgR7uHcyyjp7xgA6BiOyAoFVDkRFha6i50od4Jfx8G0OQBzRZiD
 V0vf4dKfJPDowhlCS9S+RmBHk7Y2IAMb72ULLrDkVWt2Kes+OSdIXe+hW3mnYukUneiQ
 fHpAdEZZ1lBRJxC49QDe3DIBCEozGhKN1wVELRuNdcbt5aFZ02Rh1woNCALo0Z7pNWF1
 P3KhEjjBHxR77WqcMz4uju173C9JX+ZD62FoS5jvIIXY/FjHxQzdnlYaz65PGL//dU2I
 kjvA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781641260; x=1782246060; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/4qTAe5Zn5NunAHHjKwKFozHVtff/sEiKKU+iRLThw=;
 b=SHK4eqKpD+MrgP/Gvyj/s4cy1u021cq6OUhdP6BO+TV3/mPP/u6cEODy/iM9nrxOPz
 xA1u8MjkC3bNMDB1N3Rppq5cA3QJAUOOknzTyPRgFRoyFJfdNqkQk9BlKzrUFoUy50/W
 vr34+7JFL88h7T5vI5GjYSVqr4Qsvd9+7vIpOQuL1NTPqVI8NB8iD3LIpvtswrIw+EWw
 dX2eZZbMuHr/Fe5lenvnZOMTFoawPQwCpARZwBX71DrH8KYzTG4mHZSmqs9wrWnt+dRn
 BKDFCdM6P36BYZdfGhharFhmlhg4bOb6vlXZ+ckrcnwtFW4vARagltSLU3toVue45EB0
 kb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781641260; x=1782246060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/4qTAe5Zn5NunAHHjKwKFozHVtff/sEiKKU+iRLThw=;
 b=HJ3tu4O1FroTkO41I4raKthWqtJ1fSULTXp3HZtijyxtvrxateLhzWJakSc1pz0KM+
 Vr1OkiBAopO/wuBAP8xAEagldPKr3PglexYEiEBo23UxSzIGvf/NUZ4cq8msTaDrBrsJ
 SPT1ixTockzgCp+ZYrZKFmu7vBpU/JOTFRx5/wS7UCbu9Kp8xqKUL7iU/QAd2rmPpkW9
 W27F+BYQPpmCbUkX5q1rsPjC0vmvahidUjriUrKvU1dAFdnP40TbPC0DVZguJX4eDsGe
 OGb2wymVYOWJbUwyQ2iHeLSc859K5M1utZsT6s1+H8oiy8IIImNfdIbUwX/z2T5Q/wdd
 GghA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eCIotJr5T17eX4d+mK47hPb8tj4dw8LTtLvRp+ybdZZ2AuVXoQwOYFAX0zzC9ibKeUhWFBYo=@lists.denx.de
X-Gm-Message-State: AOJu0YzPxzMkXUMUIRXrZNdoMySkmF9BqXFmoaMIeiH07+aHERUtMsB2
 kzzqsRppmsMusQRrzLPYFebcTbkeQGh0a/P0VUxXOKEPdvIB59fm4802uw2oDk9tR5bEu3SfMyD
 0aPNfWNUKFLbJwy0nLYK3/00Jm7uswn0=
X-Gm-Gg: Acq92OEtqXWvA8IPqpIafzurCDnT/7Jwx7MCNGq/6paqrpQX584k9k7KCbM8NUv37qi
 XCFVt+JdRg+WW8wR/Flnm7SsXVT9TxtvfkBAZV/MXZ4A8GzlQWv45XAeJrs5fe5XGzbTAKmMyyk
 ugd423LiJOZnq6TO9gjDH5lfvmn1Qa9aUYR8ME0I4JrF+OvjULrJkPxqRwMK1kTZgMW6/ZmWXgg
 5uyp6pqS+9gKSkNPyGx31zhrX1Rojl+P2NUOAr6hoPlx7mg7dgxdo8QRSf6lQKCe5XebIhnJT/y
 79BqqgyA9bs8FySzdNTX+GxILZTBA9fWJKK/d+P37kAh0Ylkhk+hZ2MKFQCECNwP7DlsvSsELOB
 RndeVw1I3bD720xakwuv4GvKBs7vYJ0POPO2QYVtmeCqejG+c33sghjy3tJzOXEiygtZM/tgofl
 mQ3CR75zAsPp4e
X-Received: by 2002:a05:6512:251e:b0:5aa:6fff:c3e3 with SMTP id
 2adb3069b0e04-5ad47ed9351mr69504e87.33.1781641259682; Tue, 16 Jun 2026
 13:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
 <978a771c-678e-4956-9aa0-ba4fa8469350@cherry.de>
In-Reply-To: <978a771c-678e-4956-9aa0-ba4fa8469350@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 16 Jun 2026 21:20:43 +0100
X-Gm-Features: AVVi8CfZ7LoeaS_CbhqpaYoHO_c1Ax6Prnye2QZgBRCLFUa00rGM-EqRY5ZRVUk
Message-ID: <CALeDE9O+T5KFH1=iFXdis95ZGtumhL99YbB1P2YJzwrB-Wwfbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Tobias Olausson <tobias@eub.se>, u-boot@lists.denx.de, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

To be very clear Red Hat !=3D Fedora. I am the U-Boot maintianer in
Fedora, I do not work for Red Hat. That doesn't mean that Red Hat has
related interests.

That aside Fedora's openssl maintainers are employed by Red Hat and
Fedora has been leading on this and engine's are completely disabled
and unavailable in RHEL 10 even thought it shipped with openssl3.

Fedora 45 will ship with openssl 4, it landed in rawhide this week so
I know I already have build issues for the next build I do for U-Boot
2026.07 and that's the entry point for the latest versions of U-Boot
into that Red Hat derived ecosystem.

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
