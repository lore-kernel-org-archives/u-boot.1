Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0BCCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 15:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C919848DC;
	Tue, 26 May 2026 17:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FRGA0UOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95288488F; Tue, 26 May 2026 16:50:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E13E9846A5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DEBB169C;
 Tue, 26 May 2026 07:50:41 -0700 (PDT)
Received: from e132995.arm.com (e132995.arm.com [10.1.31.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7F53F7B4;
 Tue, 26 May 2026 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1779807046; bh=KboHbX1lNKxWqKr1KSUZFYNOGkLFyrF0dtVsLvKit6o=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=FRGA0UOpUH+KzJY0kDRbaxCj6e5mk9QuNi+HaH2Z7GoQGaHgLl0Sr/ULySMDIlJLh
 R79DXzcm2wDJOvfpNTQKrEMk/g5VMrOlR0E2QIyFFsp7V0b4tBBCsaInSmutol8mAs
 zzR4wykmajiW+Fa9KNpfKWtawOGTHOns1i23OH3Q=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 09/11] test: dm: add sandbox FF-A runtime transport
 tests
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com
In-Reply-To: <CAFLszTh0GpA2WXAVL90QmM1Ta-uHPcaH6WOx+revrp3WQ03o6A@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-10-harsimransingh.tungal@arm.com>
 <CAFLszTh0GpA2WXAVL90QmM1Ta-uHPcaH6WOx+revrp3WQ03o6A@mail.gmail.com>
Date: Tue, 26 May 2026 15:50:39 +0100
Message-Id: <177980703908.3556959.6423699095258119667.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 26 May 2026 17:05:53 +0200
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

On 2026-05-15 12:27 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-05-14T12:49:13, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > test: dm: add sandbox FF-A runtime transport tests
> >
> > Exercise FF-A runtime helpers via sandbox DM tests
> >
> > Test the successful runtime direct-message round trip and the invalid
> > destination-partition case, using the shared FF-A prepare step so the
> > sandbox emulator has initialized partition state before exercising the
> > runtime-only messaging helpers.
> > Add a dedicated no-context test that calls
> > ffa_sync_send_receive_runtime() before enabling the runtime context and
> > checks that it returns -EPERM. Reset the resident FF-A runtime context
> > around the transport tests so the runtime flag and private data do not
> > leak across test cases.
> > Split the ffa_to_std_errno() checks into a separate DM test so
> > error-mapping regressions are reported independently from transport
> > failures. Cover both the valid mappings and the boundary inputs that
> > must return -EINVAL.
> >
> > Replace the hard-coded synthetic partition execution-context and
> > property values in ffa-emul-uclass.c with the shared
> > [...]
> >
> > arch/sandbox/include/asm/sandbox_arm_ffa.h |  16 +++-
> >  drivers/firmware/arm-ffa/ffa-emul-uclass.c |  36 +++++---
> >  test/dm/Makefile                           |   3 +-
> >  test/dm/ffa_runtime.c                      | 129 +++++++++++++++++++++++++++++
> >  4 files changed, 172 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,129 @@
> > +static int dm_test_ffa_to_std_errno(struct unit_test_state *uts)
> > +{
> > +     (void)uts;
> > +
> > +     ut_asserteq(-EINVAL, ffa_to_std_errno(0));
> 
> (void)uts is incorrect - uts is used by the ut_asserteq() macro
> expansions. Please drop it.
> 
> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,129 @@
> > +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> > +             .id = NS_PHYS_ENDPOINT_ID,
> > +     });
> > +     ffa_enable_runtime_context();
> 
> Twice you do reset + prepare + copy + enable + assert + reset. Please
> pull this into a small helper (e.g. ffa_runtime_setup()) with matching
> teardown, so the two tests can't drift and a failed assertion mid-test
> doesn't leak the runtime flag into later tests.
> 
> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,129 @@
> > +     /* Invalid partition IDs must be rejected and mapped to -EINVAL */
> > +     ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, true));
> 
> Just to clarify, this works because NS_PHYS_ENDPOINT_ID happens to be
> 0, so the emulator's self-ID check trips first rather than the SP
> validity check. Please pick a clearly-invalid partition ID (e.g.
> 0xffff) so the test exercises the intended rejection path.
> 
> > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> > @@ -19,41 +19,57 @@
> >  /* The partitions (SPs) table */
> >  static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT] = {
> >       {
> > -             .info = { .id = SANDBOX_SP1_ID, .exec_ctxt = 0x5687, .properties = 0x89325621 },
> > +             .info = {
> > +                     .id = SANDBOX_SP1_ID,
> > +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> > +                     .properties = SANDBOX_SP1_PROPERTIES,
> > +             },
> 
> This refactor (lifting exec_ctxt/properties into SANDBOX_SP*_EXEC_CTXT
> / SANDBOX_SP*_PROPERTIES) is unrelated to the runtime tests - none of
> the new tests reference these macros. Please split it into a
> preparatory patch.
>

Hi Simon,

In patchset v1 [1], it has been suggested by you to squash commit 9 into
commit 8.
Can you please confirm, if seperate patch is needed for these changes?
I will make relevant changes in v3, if required.

[1] : https://lore.kernel.org/u-boot/CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAgyXJ4nH3sUYLqk7A@mail.gmail.com/

Regards,
Harsimran Singh Tungal

> > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> > @@ -19,41 +19,57 @@
> > -             }
> > -     }
> > +             },
> > +     },
> >
> >  };
> 
> Stray blank line between the last entry and the closing }; — while you
> are reflowing this table, please drop it.
> 
> Regards,
> Simon
> 


