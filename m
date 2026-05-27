Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F716CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB48A846AA;
	Wed, 27 May 2026 06:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CqfqJyFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222BE846BD; Wed, 27 May 2026 06:45:31 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB485841D7
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so2059021266b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779857128; cv=none;
 d=google.com; s=arc-20240605;
 b=PwLM4KXrhUm1z66ldIEQybtQRvWVFs2UYQobgT1IVkyGbcdhlwFey3AZul3La90uAs
 cNYBtpoMRH3sRmHwvLzbt+Eu2oxN41DK60yj8jkLbVaRu0XcOwneS1vHnIzVn6K77SK4
 MEs4CnE+ywKr+ya/W4diL9+SQkSY+dTkDZ5pfsQDOI727QRdBpEJvSEnkLdbywhSoVpG
 dHyB/iL0Aftmfsm5BMgBMujftpbFk10qFfpjj9SZ8gC9ms8i+8wQFta4L7PQWGzdrJHX
 +uZkUY0DURi/p0EtaPyJCm2c9DEgxp+CoNIfLE6Uc66Z0U7sKY4ZS3mhyY9ktpkNyJZI
 NMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wh1xVVMr9KToYdzYVOt9tsTC3ga1+m17vJIgyhNrJYg=;
 fh=yZ0bW5EtO479EI+Sg6AbJukoJz1aL8XiEMBOeMLGSJ0=;
 b=NxP+mM8yNPR9JhdKaX1/CVd9OLsnEFdyUg3TY/v0FmLaNc+6PrYlFuQEockHvrcPXV
 HLo43qTHCLjRaWd82h8AThtgHYFf0umksylgELvks5dEgNKDD4af0HVOrAuZAW0UdIs/
 JE2axfbwEkyIYOokjhibgurVe822VX3y1CoApgzsCYhjE7PEXe/7Q2zWpXPlLcIhDn5V
 m4+biUc45TA3YyTYT65sLKZCjQ+HWWOeeiyxOT6t5NxHxYgwpymX4KCya7RKJcUjzh+6
 364i5DwFO9VpMvPPLfOCoF7fJKnqGR+EYbA2EgsNBkU9iTNLuTDNsSTSaaWxRytb8FV0
 cS9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779857128; x=1780461928; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wh1xVVMr9KToYdzYVOt9tsTC3ga1+m17vJIgyhNrJYg=;
 b=CqfqJyFKzbm+fRy3PpIh/1wMBXlW57qgvepbuqsNDkIT+wxtzJJ/BdchzgHyr24R0J
 d91C+7hZ/uAWz/a/TMKSFJwBAIUZqiio8caRGU2+1I0k9x6h2O59qOVtFZQgA3N10Rkr
 gd2FsWJT7P7Xbd/Tlb3y1QFNfOluh7U63qwjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779857128; x=1780461928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wh1xVVMr9KToYdzYVOt9tsTC3ga1+m17vJIgyhNrJYg=;
 b=LLv0kheRykTGVaZF2vPy4lEIVAP1nxDrroJ1a7JTNRIvyOS4tscNjKhGEtHdtHjEuG
 4hTcISecsmbOsqOktSH2Ioj/Nc1D2nKH1ZSt1ZdaMWVhIVW9nMGoBPthfriW88KCyKtg
 cexOhVGmZcQ5TNnl0MsdNFvNu1u2slN8XETOH23ghx//1ofrqE8WA4/etsJAGrQi2Tcf
 towbRPFHtwQH5BHxx4ZDZ/iQjl2TXy6DAiMa1BNM98QXx5iJ7dg/HstORMqMsADfCwcE
 nypZ/hMhQGx2rlFOLZ1fSk4/Qrgx+6J3/2KDyPl2Er/Icft/2OpD06aa0dBHxuVHPVMG
 qJPw==
X-Gm-Message-State: AOJu0YwBA2uHbc4ZpAyi33evJn3ggcKeL4f+qnGzJgQNASMGfEgzjCxj
 sLLDXvEZcKDJdVRapfQCzECK0wcUExdChC0jksSmazmzlVtCP7K091gDaJccytsCY+0S0mnnzY8
 CsnS4FFUEX9k1jrNxSAQSjrioG6r3IqWpOI2dD65l
X-Gm-Gg: Acq92OEulTHhsxqtwSQc6pgl2FtqRrUWtBnw2ugyarU1yDMW0bQZMEjci2d6iMZ4W+l
 Sf2NAbFKZZZC3e4ImRV0Uo20ltHeJpLuns7J1DUInLsUhRLFcpAYdsmm9DF3PyHRK/NSYDirNnM
 YAl6jiOYB8j9ym9Pe4d59ITXFAfV9lx0Rr2yMkvVaaoKK9ri2O5RiWT+to3kCgwlLz4hHjC4Loj
 1Pbq6x8x8KZL5kkd5q/60UOWfHvlAejlFKNtdKhljdr7nWFw5oQuhypaZIfcWnN3q2EvAhYHjrc
 SvDPA74BqJW6KMEq
X-Received: by 2002:a17:907:9690:b0:bbf:bab5:ecd9 with SMTP id
 a640c23a62f3a-bdd4a09a7cdmr1100409166b.15.1779857128165; Tue, 26 May 2026
 21:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-10-harsimransingh.tungal@arm.com>
 <CAFLszTh0GpA2WXAVL90QmM1Ta-uHPcaH6WOx+revrp3WQ03o6A@mail.gmail.com>
 <177980703908.3556959.6423699095258119667.b4-reply@b4>
In-Reply-To: <177980703908.3556959.6423699095258119667.b4-reply@b4>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:45:16 -0500
X-Gm-Features: AVHnY4J1Ic3L2zooale0azgvCQPbqSZ_9WF9tTaPmp73M_oyuv7TMk30lJ10DT0
Message-ID: <CAFLszTjo2a50iF5oQDzsz1K4ViGEAAGVsgn_xXxP2478YxwgVw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] test: dm: add sandbox FF-A runtime transport
 tests
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com
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

Hi Harsimran,

On Tue, 26 May 2026 at 16:50, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-05-15 12:27 -0600, Simon Glass wrote:
> > Hi Harsimran,
> >
> > On 2026-05-14T12:49:13, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > > test: dm: add sandbox FF-A runtime transport tests
> > >
> > > Exercise FF-A runtime helpers via sandbox DM tests
> > >
> > > Test the successful runtime direct-message round trip and the invalid
> > > destination-partition case, using the shared FF-A prepare step so the
> > > sandbox emulator has initialized partition state before exercising th=
e
> > > runtime-only messaging helpers.
> > > Add a dedicated no-context test that calls
> > > ffa_sync_send_receive_runtime() before enabling the runtime context a=
nd
> > > checks that it returns -EPERM. Reset the resident FF-A runtime contex=
t
> > > around the transport tests so the runtime flag and private data do no=
t
> > > leak across test cases.
> > > Split the ffa_to_std_errno() checks into a separate DM test so
> > > error-mapping regressions are reported independently from transport
> > > failures. Cover both the valid mappings and the boundary inputs that
> > > must return -EINVAL.
> > >
> > > Replace the hard-coded synthetic partition execution-context and
> > > property values in ffa-emul-uclass.c with the shared
> > > [...]
> > >
> > > arch/sandbox/include/asm/sandbox_arm_ffa.h |  16 +++-
> > >  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  36 +++++---
> > >  test/dm/Makefile                           |   3 +-
> > >  test/dm/ffa_runtime.c                      | 129 +++++++++++++++++++=
++++++++++
> > >  4 files changed, 172 insertions(+), 12 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > > @@ -0,0 +1,129 @@
> > > +static int dm_test_ffa_to_std_errno(struct unit_test_state *uts)
> > > +{
> > > +     (void)uts;
> > > +
> > > +     ut_asserteq(-EINVAL, ffa_to_std_errno(0));
> >
> > (void)uts is incorrect - uts is used by the ut_asserteq() macro
> > expansions. Please drop it.
> >
> > > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > > @@ -0,0 +1,129 @@
> > > +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> > > +             .id =3D NS_PHYS_ENDPOINT_ID,
> > > +     });
> > > +     ffa_enable_runtime_context();
> >
> > Twice you do reset + prepare + copy + enable + assert + reset. Please
> > pull this into a small helper (e.g. ffa_runtime_setup()) with matching
> > teardown, so the two tests can't drift and a failed assertion mid-test
> > doesn't leak the runtime flag into later tests.
> >
> > > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > > @@ -0,0 +1,129 @@
> > > +     /* Invalid partition IDs must be rejected and mapped to -EINVAL=
 */
> > > +     ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, tru=
e));
> >
> > Just to clarify, this works because NS_PHYS_ENDPOINT_ID happens to be
> > 0, so the emulator's self-ID check trips first rather than the SP
> > validity check. Please pick a clearly-invalid partition ID (e.g.
> > 0xffff) so the test exercises the intended rejection path.
> >
> > > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/fir=
mware/arm-ffa/ffa-emul-uclass.c
> > > @@ -19,41 +19,57 @@
> > >  /* The partitions (SPs) table */
> > >  static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIO=
NS_CNT] =3D {
> > >       {
> > > -             .info =3D { .id =3D SANDBOX_SP1_ID, .exec_ctxt =3D 0x56=
87, .properties =3D 0x89325621 },
> > > +             .info =3D {
> > > +                     .id =3D SANDBOX_SP1_ID,
> > > +                     .exec_ctxt =3D SANDBOX_SP1_EXEC_CTXT,
> > > +                     .properties =3D SANDBOX_SP1_PROPERTIES,
> > > +             },
> >
> > This refactor (lifting exec_ctxt/properties into SANDBOX_SP*_EXEC_CTXT
> > / SANDBOX_SP*_PROPERTIES) is unrelated to the runtime tests - none of
> > the new tests reference these macros. Please split it into a
> > preparatory patch.
> >
>
> Hi Simon,
>
> In patchset v1 [1], it has been suggested by you to squash commit 9 into
> commit 8.
> Can you please confirm, if seperate patch is needed for these changes?
> I will make relevant changes in v3, if required.

It's not critical, just a suggestion as it seemed to me that the
patches were interwined.

>
> [1] : https://lore.kernel.org/u-boot/CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAg=
yXJ4nH3sUYLqk7A@mail.gmail.com/
>
> Regards,
> Harsimran Singh Tungal
>
> > > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/fir=
mware/arm-ffa/ffa-emul-uclass.c
> > > @@ -19,41 +19,57 @@
> > > -             }
> > > -     }
> > > +             },
> > > +     },
> > >
> > >  };
> >
> > Stray blank line between the last entry and the closing }; =E2=80=94 wh=
ile you
> > are reflowing this table, please drop it.
[..]

Regards,
Simon
