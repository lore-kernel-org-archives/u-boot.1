Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE9D4114C
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB8980325;
	Thu, 15 Jan 2026 10:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PBv784OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12340835B3; Thu, 15 Jan 2026 10:37:10 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78FAF80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6455a60c11fso474272d50.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 01:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768469825; x=1769074625; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+Gk0opgaQ3LeB35iu90SGUwCx78G4TquVpu6st0kGo=;
 b=PBv784OOJSvg68tzZEVeHcraITaCD90dZ0FqaPGrxq9Q4kaBNPr1ug0a4DnrCHXyhy
 kgFptLQGSU482euDkPnwzG7es/emt3MAM66yfz216Z0TtCkLIMSQLc5bQRVCIx1pOmh2
 /UVP9S6e+nLaZNBPvcpzxspeUropRhstc3l7fV1QolUxc4VN0T9NSPykF/NZO67EA2b7
 o25X2ZtX9H3YlnEZBV3g8WrYSM0CQPkBM7jqsKwcjAJDuSWCAwRDjmcwLQmxU3WadEBE
 4lBmn1DkDy9ChwOzEtWQqmRLkliCJ71mH/KKndmg+rOAwanf1+7bWHgntwQXt58GEm76
 +21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768469825; x=1769074625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+Gk0opgaQ3LeB35iu90SGUwCx78G4TquVpu6st0kGo=;
 b=TcQ0I4/YhCIT7ILrUpNhh+ObH0X6Cu9TYvZefUpE+z8FLXJvdfeV3bEL49Oue02rlS
 wU7p4Vr61Ap0rzZwXnjvXZc+5AOZaENJ4r8I3DNA6OUuP2Pq8+J9Ufa7kvKEn7sq7ZN4
 0iLhuGvtUbj/+GndzrQx+QbEvqCXwDPAKLZeUIYMgLvTLwkvEGTMRvZ4CX/XMvoodYdt
 wbrDNf+nqBGKIfLxXnOm5mbf/y9x7r92JI4qe++VRRe8u/ZwqgW8JNuhtg7CWvntFFkg
 zuEd7os4ACZm53jr5RXQm3ClhpIPqwrsd7zol9Dc8wnXUuUN208dfKMtTefIvcwAg1HL
 VZ1Q==
X-Gm-Message-State: AOJu0YyQ4qBIby/OlqxuMGJdQbTePT60cX6t3xL5/Ghx3ipPOnBnjQjx
 wd+6vIG+Igd9pOA3ryA2J6GH0g2ALKnvbeSaU5BMEoGvcYUcGmUdnU/1hppu10oY3fsjmrveOMz
 b59ODTGTHMPGm74yEguL3q04T0O79bGTHHFKDVYsCpA==
X-Gm-Gg: AY/fxX4fhMDSXHNcpqh9ObterpYh1gMcVepKU6XqStq6KsaDiLvx6s2YQBcjFEVyhhc
 QrW7XiclCFHIACqSZJEgB45NK3YNDril1TnpU9OZwVQVRNLBLQ+pSSq3TGXV/TlXj5Pkny9CIjJ
 iPhKhQbZBJF0PXm2aSj4OsxYSAy3FrQIxes7/Iy+MQJ7eUBcU7sgFhVEW1/fSNuQV0tOg6XyJKj
 XCqbvKNxByJc7cmgKSTXAovQrc9vDiY8lEjNbEp954vAvFXh5VSJr8Y1KJ/MfVurJnsV5DG9Zbf
 NRLVZT7Owc0qWL9JZhRA4QetXqwh+e0LIIo3QtUjxFQKQKxJjBwvf7g5Mb5/zYAlO5t+NvIFxlS
 NSH/Z9+iwrsmqbf3BExSxlfFh9srTmRb0mQm0ooIolrt908ylb248DlF9prhwoDioNu2B3+Kh/K
 eFcqGsJNKduXcam8NWxYqLJgTgpwtCmCtN5zzBZab5e7j3S/L8nsa9OsLs5eIy6n1iErA6J8DAi
 LrReaONhTREydS2TdTj88D9xp18jbBPggSgslG1qRAH8neHASBrDdWY89pPRQd/GPamYlxN+Ipt
 oP/e6IYWp3I0DmPmsDPQXNahEEc2V/9r
X-Received: by 2002:a05:690e:d8c:b0:644:7398:6682 with SMTP id
 956f58d0204a3-64901aba169mr4589528d50.30.1768469825180; Thu, 15 Jan 2026
 01:37:05 -0800 (PST)
MIME-Version: 1.0
References: <20260114095917.737634-1-kory.maincent@bootlin.com>
 <CAC_iWjKRVFF8aDLyyJi5Mbnbku=NJMX7SG4ZRfoJ2YzrAwyGQw@mail.gmail.com>
 <20260114161649.76cd4f23@kmaincent-XPS-13-7390>
In-Reply-To: <20260114161649.76cd4f23@kmaincent-XPS-13-7390>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 11:36:29 +0200
X-Gm-Features: AZwV_QiL--nrA0g_Mu1uVr2G5abNbrgDbUzd02iSOH4ktBrlDXDkK4qik45dJlI
Message-ID: <CAC_iWjLFJKTV_VY_GvMYzTiAARsNWFei_R4hfno6FpM+On4H=g@mail.gmail.com>
Subject: Re: [PATCH] fwu: Mark failed bank as invalid during rollback
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
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

Hi Kory,

On Wed, 14 Jan 2026 at 17:16, Kory Maincent <kory.maincent@bootlin.com> wro=
te:
>
> On Wed, 14 Jan 2026 15:54:07 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> > Hi Kory,
> >
> > On Wed, 14 Jan 2026 at 11:59, Kory Maincent <kory.maincent@bootlin.com>=
 wrote:
> > >
> > > When boot_idx differs from active_idx at boot time, it indicates a
> > > rollback scenario where the firmware update failed and the system
> > > reverted to the previous working bank. In this case, mark the failed
> > > bank (active_idx) as invalid to prevent future boot attempts from tha=
t
> > > bank.
> > >
> > > This change adds a new fwu_invalid_bank() function that sets the bank
> > > state to FWU_BANK_INVALID and syncs the metadata. This is only
> > > supported in FWU metadata version 2; version 1 provides a no-op stub.
> > >
> > > Without this change, a failed bank would remain in a valid state and
> > > could potentially be selected for boot again, leading to repeated
> > > boot failures.
> >
> > How? Doesn't the code already switch the metadata to point to the
> > 'boot_idx' bank as active?
> > What could happen here I guess, is the selected active bank to go bad
> > somehow and the firmware would try the secondary bank, which contains
> > an invalid firmware. But in that case the board will fail to boot
> > regardless. Is there a corner case I am missing?
>
> I think I have faced a corner case, but I can't recall what it was. :/

I think this patch has value if you have 3 banks. In that case, you
won't have to try and boot the invalid one, before booting a correct
one.

> Anyway we should change the bank state to invalid if we don't manage to b=
oot
> one bank right. We should provide to the user the information that one ba=
nk is
> in an invalid state if that is the case. What do you think?

Yes. The invalid state is already described in the spec so I think this is =
fine.
However, instead of adding a new function to invalidate the state,
can't we tweak fwu_bank_state_update() instead?
Instead of a boolean for trial state, pass an the actual state and
update it while keeping the same checks.

Regards
/Ilias


>
> Regards,
> --
> K=C3=B6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
