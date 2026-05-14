Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515CFCD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 15:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C27384687;
	Thu, 14 May 2026 17:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="s5j4eDo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505BC8468B; Thu, 14 May 2026 16:58:32 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 994FB84686
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D38A1C00;
 Thu, 14 May 2026 07:58:22 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4553F7B4;
 Thu, 14 May 2026 07:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778770707; bh=eAcJMvxHn7o7fSHQz5XzHuLheP1U63u5nc/bL4B5uRA=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=s5j4eDo2ZOtzvPSmlSZhOVp9VKAoEXF8p5K0Ea8hlGrafs3UnTtsfPzgoHMjZVqXH
 A0j5PoL4tCslc1GZ3DKQ7mx6+zBuBO4hb2THsggAlEvXUnRex4C3IRR1O/uOK5ByCY
 na/AXMqLT1Ryfz/F9gBPePweudGmp6ju7XNAw3TY=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/12] test: dm: add sandbox FF-A runtime transport tests
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszTge4-kNpmh0q26KhRRrN_DK2134qbLi8KqRgwdB+mAaSw@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-9-harsimransingh.tungal@arm.com>
 <CAFLszTge4-kNpmh0q26KhRRrN_DK2134qbLi8KqRgwdB+mAaSw@mail.gmail.com>
Date: Thu, 14 May 2026 15:58:19 +0100
Message-Id: <177877069978.2318147.4826309565117196370.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 14 May 2026 17:20:09 +0200
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

On 2026-04-28 12:05 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > test: dm: add sandbox FF-A runtime transport tests
> >
> > Exercise FF-A runtime helpers via sandbox DM tests
> >
> > Add driver-model unit tests that exercise the FF-A runtime helpers on
> > sandbox. The new tests reuse the sandbox emulator to validate both the
> > positive direct-request flow and failure handling, priming the emulator
> > state so the runtime path can be executed.
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > arch/sandbox/include/asm/sandbox_arm_ffa.h | 16 +++++-
> >  test/dm/Makefile                           |  3 +-
> >  test/dm/ffa_runtime.c                      | 82 ++++++++++++++++++++++++++++++
> >  3 files changed, 99 insertions(+), 2 deletions(-)
> 
> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,82 @@
> > +static int dm_test_ffa_runtime_nack(struct unit_test_state *uts)
> > +{
> > +     struct ffa_send_direct_data msg = {0};
> > +     u16 sp_id;
> > +
> > +     ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
> > +
> > +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> > +             .id = NS_PHYS_ENDPOINT_ID,
> > +     });
> > +     ffa_enable_runtime_context();
> > +
> > +     /* Ensure runtime context is available before attempting runtime-only paths */
> > +     ut_assert(ffa_get_status_runtime_context());
> > +
> > +     /* Invalid partition IDs must be rejected and mapped to -EINVAL */
> > +     ut_asserteq(-EINVAL, ffa_sync_send_receive_runtime(0, &msg, true));
> 
> sp_id is fetched here but never used - the test sends to id 0
> directly. Please drop the call to ffa_runtime_get_sp_id() in this
> test, or use the discovered id for a positive comparison.
>

Thanks, you are right that sp_id was unused in dm_test_ffa_runtime_nack().
This has been fixed in v2.
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,82 @@
> > +static int dm_test_ffa_runtime_ack(struct unit_test_state *uts)
> > +{
> > +     struct ffa_send_direct_data msg = {0};
> > +     u16 sp_id;
> > +     u8 cnt;
> > +
> > +     ut_assertok(ffa_runtime_get_sp_id(uts, &sp_id));
> > +
> > +     ffa_copy_runtime_priv(&(struct ffa_priv_runtime){
> > +             .id = NS_PHYS_ENDPOINT_ID,
> > +     });
> > +     ffa_enable_runtime_context();
> 
> ffa_enable_runtime_context() flips a global static flag in
> arm-ffa-runtime.c that is never reset. Once either test has run,
> ffa_get_status_runtime_context() returns true for the rest of the
> process, which leaks state into other tests and means a
> missing-context path can never be reached. Please add a case that
> calls ffa_sync_send_receive_runtime() before enabling the context and
> verifies it returns -EPERM (that branch is currently untested) and
> provide a way to reset the runtime priv between tests.
> 

Thanks, good point.

In v2 I added ffa_reset_runtime_context() and use it around the sandbox runtime
tests so the resident FF-A runtime state does not leak across cases.

In v2, I have also added a separate dm_test_ffa_runtime_no_context() test that calls
ffa_sync_send_receive_runtime() before enabling the runtime context and checks for -EPERM.

> > diff --git a/test/dm/ffa_runtime.c b/test/dm/ffa_runtime.c
> > @@ -0,0 +1,82 @@
> > +     /* Validate FF-A error to errno translation helpers */
> > +     ut_asserteq(-EINVAL, ffa_to_std_errno(-INVALID_PARAMETERS));
> > +     ut_asserteq(-EOPNOTSUPP, ffa_to_std_errno(-NOT_SUPPORTED));
> 
> Just to clarify, ffa_to_std_errno() is a pure helper unrelated to the
> messaging round-trip - please split this into its own dm_test, so a
> regression in the table doesn't look like a transport failure, and add
> coverage for at least the boundary cases (e.g. 0, MAX_NUMBER_FFA_ERR,
> an out-of-range value) which all should map to -EINVAL.
> 
> Regards,
> Simon
>

Agreed.
In v2 I split the ffa_to_std_errno() checks into a separate dm_test_ffa_to_std_errno() case,
so errno-table regressions are reported independently from the FF-A messaging tests.

Regards
Harsimran Singh Tungal


