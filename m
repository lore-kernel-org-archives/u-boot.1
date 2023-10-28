Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6755DC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 05:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB617877AE;
	Sat, 28 Oct 2023 07:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kxMS50BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9342877AF; Sat, 28 Oct 2023 07:36:05 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 808A687761
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 07:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-da2b8131c1aso268011276.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698471362; x=1699076162; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=obOmE4USD18iUvxfI4mpw0pm2esSbiAkzgbja2gfO3k=;
 b=kxMS50BYFbAwsWuNwRS5TB3QsGwbRXXHK/thhDOMD4hxD6DoTvW+XlI/vhD5Sl0d6o
 DQ+REoyCQPbXgxbeYgEolFHmpNk1EYsglS6hyF5IDde6qxnjL9OhZsORqWWgvhiPwV57
 MoyVNveWP7/SrfVaVaFLsOJfOj7alICSsdwOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698471362; x=1699076162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=obOmE4USD18iUvxfI4mpw0pm2esSbiAkzgbja2gfO3k=;
 b=VxFPiXVEW55FQNnG/gprUgpMGVtKRv/n7P29H7SaqeWm+SLAMBXuM5/TXXKlAAkfb3
 oFpcdVx4YQDVQbvnGyPP+uayzLIiRNm56d52MGvU7ntbwbb+4bfEvLzzm5rqmZ3fF6wy
 q70i0Z1txPOTnVZpNiSQBFp7g9SnYF5NDHJ/N9blQc0K+c/ekhDAZBF/oubqpLWf/1Nt
 ddDn13187FJ8dUwAtsokBsWlaBonZaQfRJvocKMFSncOLrtXPrqraLYBWmq7j9YNzjma
 A7dXdvPx8Xbv5NBWdlQVAjKK+D0dXlq1HWXKevCGycKzJh4L+GwYPNE3DXvdUNoq+8QS
 HDHQ==
X-Gm-Message-State: AOJu0Yym3yvDG+6/57JntTKbTyJVBrA9U/erqgvc37Qww/tw23UKC/jA
 4Z9Q6/ThdDOcUyd/B1HvZv9i7MJgMY1OUlX6j3/IeA==
X-Google-Smtp-Source: AGHT+IGskdMMkmzP9omlaA+mujr7F1enkgr6en3AN4cKxJyDI/4CThVEfbaQU/YwwEELXyoGrCIfvNiWtLmuIy0/jZQ=
X-Received: by 2002:a25:aa10:0:b0:d9a:d7a5:e445 with SMTP id
 s16-20020a25aa10000000b00d9ad7a5e445mr4425709ybi.49.1698471361987; Fri, 27
 Oct 2023 22:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230725213634.255345-1-sjg@chromium.org>
 <CAHTX3dJ+es41yLzPA32kLWt70d0rGATCROJBW8aXMZjZA5w=Hg@mail.gmail.com>
In-Reply-To: <CAHTX3dJ+es41yLzPA32kLWt70d0rGATCROJBW8aXMZjZA5w=Hg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 28 Oct 2023 05:35:43 +0000
Message-ID: <CAPnjgZ0hYHxc6HKd2wMu4jdTtDyNDxRmcSDMCs6azNwr=tstjA@mail.gmail.com>
Subject: Re: [PATCH 00/14] bloblist: Align to firmware handoff
To: Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Julius Werner <jwerner@chromium.org>, 
 Dan Handley <dan.handley@arm.com>, Jose Marinho <jose.marinho@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Michal Simek <michal.simek@amd.com>
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

Hi Michal,

On Wed, 6 Sept 2023 at 12:22, Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Simon,
>
> =C3=BAt 25. 7. 2023 v 23:36 odes=C3=ADlatel Simon Glass <sjg@chromium.org=
> napsal:
> >
> > In moving from v0.8 to v0.9 the Firmware Handoff specification made som=
e
> > changes, including:
> >
> >    - Use a packed format for headers to reduce space
> >    - Add an explicit alignment field in the header
> >    - Renumber all the tags and reduce their size to 24 bits
> >    - Drop use of the blob header to specify alignment, in favour of a
> >      'void' blob type
> >
> > This series attempts to align to that specification, including updating
> > the API and tests. It is likely that refinements will be made as other
> > projects implement the spec too.
> >
> > As before the code is dual-licensed, to permit use in projects with a
> > permissive license.
> >
> >
> > Simon Glass (14):
> >   bloblist: Update the tag numbering
> >   bloblist: Adjust API to align in powers of 2
> >   bloblist: Change the magic value
> >   bloblist: Set version to 1
> >   bloblist: Access record hdr_size and tag via a function
> >   bloblist: Drop the flags value
> >   bloblist: Drop the spare values
> >   bloblist: Change the checksum algorithm
> >   bloblist: Checksum the entire bloblist
> >   bloblist: Handle alignment with a void entry
> >   bloblist: Reduce blob-header size
> >   bloblist: Reduce bloblist header size
> >   bloblist: Add alignment to bloblist_new()
> >   bloblist: Update documentation and header comment
> >
> >  arch/x86/lib/tables.c    |   3 +-
> >  common/bloblist.c        | 102 ++++++++++++++++++++-------------
> >  doc/develop/bloblist.rst |   4 +-
> >  include/bloblist.h       | 121 +++++++++++++++++++--------------------
> >  test/bloblist.c          |  53 +++++++++--------
> >  5 files changed, 152 insertions(+), 131 deletions(-)
> >
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
>
> Would it be also possible to align names in the bloblist_hdr structure?
> magic->signature
> align_log2->alignment
> alloced->size
> size->max_size
>
> The same is for bloblist_rec.

OK. I am not sure I like the size/max_size thing so I filed an issue for th=
at.

>
> I don't know the history but spec is about transfer list and transfer ent=
ry.
> Do you plan to rename it to avoid confusion?

I don't really like transfer_list_xxx as an API. It is too
long-winded. We used that name since it is unique and descriptive as
to its purpose. But I think that 'bloblist' is a better name in the
code base. Perhaps we could use xferlist instead of bloblist?

Regards,
SImon


>
> Thanks,
> Michal
>
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


REgards,
Simon
