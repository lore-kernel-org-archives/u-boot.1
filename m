Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6258ACD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:29:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0046B847C5;
	Fri, 15 May 2026 20:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ByINB2N3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A4B8484D; Fri, 15 May 2026 20:29:13 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92733846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd36614d329so9377366b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869751; cv=none;
 d=google.com; s=arc-20240605;
 b=W8v/6f8Kq/8FMK+A7Sb9K4ek1Zbl1osbvzoQZQaz901wkzuNZNT+uxU0SaWnQkzKVb
 1swkszN86EjHtPOF635qJ35xnXAwZo7orTjoogTsF8nW/orGy3bCFzH19V7JEE9koRtk
 PBsgRKymIgflcwVE4NSSAZ3yyR10tkRAAIxOicVOtCSWvZXKLiNOBOhxi8z4X8Tv3AKk
 8pBZx5Vj88FZQpK4GXV2WGIzZ6VwipLq2wfUEGVjpr8499N5ZY4rimxWgg9GgK1Goet3
 93x6jGUF8ShiUE9IPG0K5IXsQ0wejKfv9al9UlziI5CCe5Hb7/79QOIU9XcVmiHtUdjQ
 UBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RPa5tYPQyXqYGOrh4CJ1CFA+YkLRkN4BugDTERQsWv4=;
 fh=3zI1MY2jLb+geQSEEyacKu9xbYcO7fBIfrZAWhTcvFI=;
 b=WcvkdwicvDrsEqegLYhmEktlwzewnjmh4AUCNMBzidLV9D/CNER6vMSz8jqLBwSJfz
 FXqxjsiYrsa6zgmuRHHXwEuolvfAdWasDPVZG/rxn2PNAnU15vf38QkyKTMRd+QEqyev
 ytFLBtC3DoGbhRDuLTFR/gWwsrhEa9na93EbbX0Xa/EDwsKCqYGuNHG8KO4I6+aRjZm/
 x0IEDFQAzysG1u7/8dG6qE+Ev24AVgnQm318uBuKj0ksNiq2g6fskgfYA1RWdZ2KEqva
 MI9wGre89AdIwo+Ale1c952/CNfzR9BO1M/MfnmjDBWG+hb/HxNlthW8IZzs1RHx8kp4
 fPwg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869751; x=1779474551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RPa5tYPQyXqYGOrh4CJ1CFA+YkLRkN4BugDTERQsWv4=;
 b=ByINB2N3Iv/nZcYdt2tiC1JlAvnXjTSOGo88yLw2GvP8VUjrn7c6DJIDJyyHnsCgse
 XC1PCE7BCLLJRtB6MPQllQb3lvFti+CfcDVkZgrvee+FxCDjOMRkAN9k83EluFAqXJ9z
 AOri9OTaYTMG1S+oDhecsFjKaJVFuE66KYZ8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869751; x=1779474551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPa5tYPQyXqYGOrh4CJ1CFA+YkLRkN4BugDTERQsWv4=;
 b=MMK+fbwF/8Vysayk1i+9cvro46bywQRGsnWDu216EIuo3QEiipogqCCV80VTrK+Flk
 GpYq5TD1dIIhVbLesoKN9BS7mBeXb9yJBiqvMoJtfx0VIlLn7dH4VtIjw/oNk0cHELCO
 4x4QpavzWV8ltq7N5jTvZJHWPzoZ4F/vH0/+f3ByO3TMXcasVqeMERBBNfRQyLekrndE
 +DsAUvo1AmjE3QV1xJsq/8XY1om+6iV1yhisDUhvbXXkGmftxDgdHNNNYcmUTTNpkfPl
 KDUIw6OEJkU0v5w+tA2CTrzB4XbDCMIoG3uq336wNsMr64S9KVniEHz+8dCJJ3e2nfPJ
 mb+w==
X-Gm-Message-State: AOJu0YxDbIvXLnULu1iGFGL3QoY8kpicvJUk6FhbdVQJeyLyRTUnXH/g
 FulPAZVQIvUbGIohpXIYYjI1hYBIW1IrKP9qOR9zPRWAM0fsR0gY5Y4xuzihXjdWDz2alLiKKlf
 0TUf0FiQlev+EC67vKHEg6MCWC1qwhEp0sCaYi9U7
X-Gm-Gg: Acq92OFGkkiS7FX0EoY/XWWZC3+tfw5dJCC006CVGQ8TmuiYHrAaJ74ssVwiqBDRJ/7
 NvnkWR1CG9N+IquMx2vTlWhGFZthfHFl/TiPNO6XkHO7BLBayVhp1SdUTshr55rmRYjZNLgdWe+
 XBUCMCcO8xmA6UcutIHgqywMmlcAGLM4yd45Qh9seyskjS83rtdCQXzS2VEAwm/DgcNLIPlyJpm
 sX2XYB9dnkAFGQFSppPMjeIEkReDPNl6JIoOZrAOTsay01eZ1qC+FSyysskyAT70W2JUkAoxO/k
 9E8lmG5YXVAFzXhR
X-Received: by 2002:a17:907:d30e:b0:bd5:5834:1d36 with SMTP id
 a640c23a62f3a-bd558341eb3mr66359466b.21.1778869750941; Fri, 15 May 2026
 11:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260424173151.371134-10-harsimransingh.tungal@arm.com>
 <CAFLszTiDRK-OZV-rqXs+NpJZd+ZSoxjKuAgyXJ4nH3sUYLqk7A@mail.gmail.com>
 <177877084717.2318147.855243701155756188.b4-reply@b4>
In-Reply-To: <177877084717.2318147.855243701155756188.b4-reply@b4>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:28:58 -0600
X-Gm-Features: AVHnY4Ju1C2rvqBPmoXMCE5hc8kR90QAfWgVk_dgfJpsO_Ij4W22qB-uzAQvVS0
Message-ID: <CAFLszTj+j_sQwOupFaRanhu8Vzsd1Ebszrq8CMPLAQ1AD+b2Cg@mail.gmail.com>
Subject: Re: [PATCH 09/12] sandbox: ffa: share synthetic partition metadata
 via macros
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 14 May 2026 at 09:00, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> On 2026-04-28 12:07 -0600, Simon Glass wrote:
> > Hi Harsimran,
> >
> > On 2026-04-24T17:31:50, Harsimran Singh Tungal
> > <harsimransingh.tungal@arm.com> wrote:
> > > sandbox: ffa: share synthetic partition metadata via macros
> > >
> > > Reuse sandbox FF-A partition constants in emulator tests
> > >
> > > Allow the sandbox FF-A emulator test to use execution-context and property
> > > constants defined in sandbox_arm_ffa.h
> > >
> > > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > >
> > > drivers/firmware/arm-ffa/ffa-emul-uclass.c | 36 +++++++++++++++++++++---------
> > >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> > > @@ -19,41 +19,57 @@
> > >  /* The partitions (SPs) table */
> > >  static struct ffa_partition_desc sandbox_partitions[SANDBOX_PARTITIONS_CNT] = {
> > >       {
> > > -             .info = { .id = SANDBOX_SP1_ID, .exec_ctxt = 0x5687, .properties = 0x89325621 },
> > > +             .info = {
> > > +                     .id = SANDBOX_SP1_ID,
> > > +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> > > +                     .properties = SANDBOX_SP1_PROPERTIES,
> > > +             },
> > >               .sp_uuid = {
> > >                       .a1 = SANDBOX_SERVICE1_UUID_A1,
> > > ...
> > >       {
> > > -             .info = { .id = SANDBOX_SP3_ID, .exec_ctxt = 0x7687, .properties = 0x23325621 },
> > > +             .info = {
> > > +                     .id = SANDBOX_SP2_ID,
> > > +                     .exec_ctxt = SANDBOX_SP2_EXEC_CTXT,
> > > +                     .properties = SANDBOX_SP2_PROPERTIES,
> > > +             },
> > >               .sp_uuid = {
> > >                       .a1 = SANDBOX_SERVICE2_UUID_A1,
> > > ...
> > >       {
> > > -             .info = { .id = SANDBOX_SP2_ID, .exec_ctxt = 0x9587, .properties = 0x45325621 },
> > > +             .info = {
> > > +                     .id = SANDBOX_SP3_ID,
> > > +                     .exec_ctxt = SANDBOX_SP3_EXEC_CTXT,
> > > +                     .properties = SANDBOX_SP3_PROPERTIES,
> > > +             },
> > >               .sp_uuid = {
> > >                       .a1 = SANDBOX_SERVICE1_UUID_A1,
> >
> > This is not a pure refactor. Index 1 and 2 swap, so SP2 moves from
> > SERVICE1 to SERVICE2, and SP3 moves from SERVICE2 to SERVICE1. The
> > existing test in test/dm/ffa.c queries by UUID and walks the matching
> > SPs, so the set of IDs returned for each service changes.
> >
> > If the reorder is deliberate (e.g. so the table reads SP1..SP4 in
> > numeric order), please call it out in the commit message and confirm
> > no downstream test relies on the previous SP-to-UUID mapping.
> > Otherwise keep the .id fields where they were and only substitute in
> > the macros.
> >
> > > diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
> > > @@ -19,41 +19,57 @@
> > > +             .info = {
> > > +                     .id = SANDBOX_SP1_ID,
> > > +                     .exec_ctxt = SANDBOX_SP1_EXEC_CTXT,
> > > +                     .properties = SANDBOX_SP1_PROPERTIES,
> > > +             },
> >
> > The macros being substituted in here are added in patch 8, and nothing
> > else in this patch uses them - they exist solely to be consumed by
> > this patch. Can you squash 9 into 8 so the macro definitions and their
> > first user land together.
> >
>
> As suggested,
> This patch has been now squashed to previous patch and all the comments
> for this commit have been addressed in v2.
> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

Thank you for the note. From my POV it is fine to just send the next
version, with the per-patch change log indicating what happened. If
you remove a patch you can use a 'Cover-changes' tag to indicate that
(if you are using Patman). To be honest I might not even notice a
removed patch :-)

Regards,
Simon
