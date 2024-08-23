Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C5FC5472D
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD6288AA9;
	Fri, 23 Aug 2024 23:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQf34IQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8637388B70; Fri, 23 Aug 2024 23:44:59 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E4C88440
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5dca00a72easo1886682eaf.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724449496; x=1725054296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0rVdzaONylOrolTPb8GefURZ7sJlLJr7MJ3M3Cjjn98=;
 b=CQf34IQ6BEh4PaK4y/k58cI2uk4LdyQiocicDX3fXlLiJbrHNw1Ta3DDPzXAMG2PdJ
 7GL/Xp16jeGIEMRnh8XdGwVdQ6Y2OAgYsP/GHteShf8Rkv0FQvnIzDHUXBgsA2OQuWmq
 lNqAbWyJIs2brW8CRm3lpOuN3BM081tNaBWu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724449496; x=1725054296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0rVdzaONylOrolTPb8GefURZ7sJlLJr7MJ3M3Cjjn98=;
 b=USnORZq3xHXqYXu+yu2m2zBustJ1hJjZAHVAyyXnvoxgDWr+SsniIATpls/a6/kOBH
 JZE6Cf/QIU9FHfyjKvdTrLESpp5G1J1vY5uoxCZ7A4qxYJVhd/JKyWof5PkheGyViJPG
 S05us7Cuid5EMmq5loCFkAdqNfTMDwuI85lBlOFlPuPs08lQVH0DOdf9mRdd2gTX9N9I
 eucPkGMKyQ9MZEZsoI+yq3LR1QJwDGZKAMMiOF/b2zPqPlkeIOS/bR9awRe5twlckD1M
 t5D/oGeezgFJIMB06WwQ6VMMy3pHFm+1F0GbAbpjTOnfZMP1li5JAkSjM6o2KKjxfdIJ
 PQpA==
X-Gm-Message-State: AOJu0YyHXQR4h4ZIcb87YTWr5+krVcfI3MTkkVtqUHG5Mhr4yp8Eo54H
 OxKNvx5bO4vQvcgw7l0cxIUdhSS1+XUogkblgEU6BGgn+G8ntqK8mL4uhxXbtKgrNk32azA19q8
 pey0HgC3eoocEO7Xbj4Jsm3OlpgTa49w+Cnx7E78C+fps6/t9+A==
X-Google-Smtp-Source: AGHT+IF/oS6LwZoL+cZkjxzUfny5dBbFiGRUqb5oaG0TE7/fVY8na0J0j7XrVb1VdWuhE7vUkcuus0WmFqsC3CkNvZA=
X-Received: by 2002:a05:6358:419d:b0:1a5:a3b3:ada7 with SMTP id
 e5c5f4694b2df-1b5c22e4fa6mr452255955d.25.1724449495777; Fri, 23 Aug 2024
 14:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
 <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
 <20240823210723.GY1626301@bill-the-cat>
In-Reply-To: <20240823210723.GY1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Aug 2024 15:44:45 -0600
Message-ID: <CAFLszTirvuCkhb7BTj84Y3oNey34fmi=+V=fFTwb73rV428i=Q@mail.gmail.com>
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, 23 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Aug 23, 2024 at 02:30:04PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
> > >
> > > > The early malloc region is normally quite small and is certainly less
> > > > than 4GB, so use a 32-bit value for the limit and pointer. Update the
> > > > comment for clarity while we are here.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/arm/lib/bdinfo.c             | 2 +-
> > > >  common/board_r.c                  | 2 +-
> > > >  common/malloc_simple.c            | 7 ++++---
> > > >  common/spl/spl.c                  | 4 ++--
> > > >  include/asm-generic/global_data.h | 6 +++---
> > > >  5 files changed, 11 insertions(+), 10 deletions(-)
> > >
> > > This breaks booting on am64x_evm_a53 which is an odd platform that does
> > > SPL->SPL->U-Boot.
> >
> > OK, I can repeat that on the Beagleplay in my lab. I sent a v3 patch.
> > Thanks for bisecting.
>
> Oh good, beagleplay is run after the EVM in my loop and so I didn't see
> it was broken there too.
>
> > I'd love to be able to push trees to gitlab and have them run on my
> > lab. I think you said that the patches[1] break your lab, so let me
> > know if there is anything I can fix.
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=420392
>
> Well the good news is that I've got the tests running again here, and I
> think I mostly understand where the challenges will be in updating this
> lab to a newer labgrid version and so being able to migrate it to on top
> of your patches. The challenge next will be time. Likely the next steps
> will be splitting out your serieses in to test fixes and labgrid
> implementation details.

I just sent v3 of the u-boot-test-hooks series. That needs to be in
for Labgrid to work.

The only other series is [1] which makes the integration nicer, but is
not necessary. That makes sense since we still want the lab to be able
to test older commits.

From that series patch [2] fixes a problem which breaks pytest runs,
since without it, pytest gets a double echo of a few of the characters
of the first command it sends. It is a pretty annoying problem which
took a while to figure out. I tried very hard to fix it without
patching U-Boot's pytest code, but I gave up. One thought I just had
is that it is possible that setting up the terminal in the
u-boot-test-console script might work most of the time, i.e. before
calling Labgrid.

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=420392
[2] test: Avoid double echo when starting up
