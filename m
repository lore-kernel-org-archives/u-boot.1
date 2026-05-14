Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6673ACD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 15:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C7A8469A;
	Thu, 14 May 2026 17:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bH8fUsTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777B78468B; Thu, 14 May 2026 17:01:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6D1F484686
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D82B1C00;
 Thu, 14 May 2026 08:00:50 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A24EA3F7B4;
 Thu, 14 May 2026 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778770855; bh=Q0J8NkMnyfgfoEQIeN43G4VCemiWO8ls2lcZWKC88Cw=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=bH8fUsTli9TngTeGuZc8c1griwvIgz9oTzFuXbpzS1rm2hOeLFMT4b6nlmChVBni3
 VmiGEQkPovH3Kicn7/1E1liwLBrYBFlgd4Et0SmGFtAMAB2GoUe0yt7oOOHdaJj7b6
 OLeD8QjnNc8Aamnn3EpbcCIaEINrZ7BiFRUtKxbM=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/12] sandbox: ffa: share synthetic partition metadata
 via macros
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
In-Reply-To: <CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAgyXJ4nH3sUYLqk7A@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-10-harsimransingh.tungal@arm.com>
 <CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAgyXJ4nH3sUYLqk7A@mail.gmail.com>
Date: Thu, 14 May 2026 16:00:47 +0100
Message-Id: <177877084717.2318147.855243701155756188.b4-reply@b4>
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

On 2026-04-28 12:07 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> > sandbox: ffa: share synthetic partition metadata via macros
> >
> > Reuse sandbox FF-A partition constants in emulator tests
> >
> > Allow the sandbox FF-A emulator test to use execution-context and property
> > constants defined in sandbox_arm_ffa.h
> >
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> >
> > drivers/firmware/arm-ffa/ffa-emul-uclass.c | 36 +++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
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
> >               .sp_uuid = {
> >                       .a1 = SANDBOX_SERVICE1_UUID_A1,
> > ...
> >       {
> > -             .info = { .id = SANDBOX_SP3_ID, .exec_ctxt = 0x7687, .properties = 0x23325621 },
> > +             .info = {
> > +                     .id = SANDBOX_SP2_ID,
> > +                     .exec_ctxt = SANDBOX_SP2_EXEC_CTXT,
> > +                     .properties = SANDBOX_SP2_PROPERTIES,
> > +             },
> >               .sp_uuid = {
> >                       .a1 = SANDBOX_SERVICE2_UUID_A1,
> > ...
> >       {
> > -             .info = { .id = SANDBOX_SP2_ID, .exec_ctxt = 0x9587, .properties = 0x45325621 },
> > +             .info = {
> > +                     .id = SANDBOX_SP3_ID,
> > +                     .exec_ctxt = SANDBOX_SP3_EXEC_CTXT,
> > +                     .properties = SANDBOX_SP3_PROPERTIES,
> > +             },
> >               .sp_uuid = {
> >                       .a1 = SANDBOX_SERVICE1_UUID_A1,
> 
> This is not a pure refactor. Index 1 and 2 swap, so SP2 moves from
> SERVICE1 to SERVICE2, and SP3 moves from SERVICE2 to SERVICE1. The
> existing test in test/dm/ffa.c queries by UUID and walks the matching
> SPs, so the set of IDs returned for each service changes.
> 
> If the reorder is deliberate (e.g. so the table reads SP1..SP4 in
> numeric order), please call it out in the commit message and confirm
> no downstream test relies on the previous SP-to-UUID mapping.
> Otherwise keep the .id fields where they were and only substitute in
> the macros.
> 
> > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> > @@ -19,41 +19,57 @@
> > +             .info = {
> > +                     .id = SANDBOX_SP1_ID,
> > +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> > +                     .properties = SANDBOX_SP1_PROPERTIES,
> > +             },
> 
> The macros being substituted in here are added in patch 8, and nothing
> else in this patch uses them - they exist solely to be consumed by
> this patch. Can you squash 9 into 8 so the macro definitions and their
> first user land together.
>

As suggested, 
This patch has been now squashed to previous patch and all the comments
for this commit have been addressed in v2.
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

Regards
Harsimran Singh Tungal

> > Author: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> 
> >
> >     sandbox: ffa: share synthetic partition metadata via macros
> >
> >     Reuse sandbox FF-A partition constants in emulator tests
> >
> >     Allow the sandbox FF-A emulator test to use execution-context and property
> >     constants defined in sandbox_arm_ffa.h
> 
> The body reads like two competing subject lines followed by a one-line
> restatement, and none of it explains the motivation. Also, the file
> changed is the emulator itself (ffa-emul-uclass.c), not a test, so 'in
> emulator tests' / 'emulator test' is misleading. Please rewrite to say
> what problem is being solved (e.g. the runtime tests added in 8 need
> to reference the same exec_ctxt/properties values, so the magic
> numbers are pulled out into shared macros) and drop the duplicate
> sentence.
> 
> Regards,
> Simon
> 


