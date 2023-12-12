Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF18C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 17:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9E9870A4;
	Tue, 12 Dec 2023 18:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UE1WKrHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6402B86D37; Tue, 12 Dec 2023 18:19:58 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24717877CD
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 18:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e1a3199f6bso14918777b3.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 09:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702401595; x=1703006395;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfBaDk6fy0fwgxA7513+0QUa/H+qgg/S1p6nSWJBscs=;
 b=UE1WKrHN1PeXyW+tYXc5Z5gusjy1uKbdFKdtCGwgtCWLTb1PxuICpaLW+2eLIL2RBv
 I9ffgSnZW2sLHgn7wx8umbzFvsZigvODnD/FrrqufB/cxfhaXlx3pEL0jeRe+lI94UCd
 kHZgUQ+JYb86OfMNmd6lxKHdiP82QYoafQMuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702401595; x=1703006395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfBaDk6fy0fwgxA7513+0QUa/H+qgg/S1p6nSWJBscs=;
 b=LMvJKX/IQ5ThBS5q6qpsFcN9Fc+KpZp+VSoY+WENrjUN5iOsN3kmUsgfYE03c2u354
 UAfUNFxgXEu3TgXy0F4f2QxDtetxEynVTVHjx0O1cf4hUfPlHzZNh1BUHPrDcgCHgaVS
 OAKKttmoGBiBsakg7aRK5LLqFPAfYi0DsiueDJkC4kkSEXD722OpzR+KARA9QHVwZ8uS
 UBDXJ/KIoSXxLLCQGyyJWPHlDXJCftgTxhvRUqVm6IL/gGOj+8Y1uHdL0OyZv61TdVH8
 ytJTlYSkl1yrQetNT/jz9k7SPpfuuqCN2ALY4ZOK/0hArl4sq/k8pULqIDt3nBJ/nIQ6
 3asQ==
X-Gm-Message-State: AOJu0YyyjvAmRm4JllHsSETI05kIxMYJ7PFJUdUrca4VBzvc8NzFsTrl
 pIb5SLiDbHKAdYidVzHTtIeZ+7+2STe8wTsJbNwiyQ==
X-Google-Smtp-Source: AGHT+IGLIUR/5nnmnbmz8JU5ZTOxEA3Ms8c7zBAT0uivNPFk9DThRftbubJtmWeE/Qef9f4VCIA843izmfbAb6WApms=
X-Received: by 2002:a81:4a41:0:b0:5d7:1941:2c27 with SMTP id
 x62-20020a814a41000000b005d719412c27mr4574487ywa.84.1702401594776; Tue, 12
 Dec 2023 09:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20220603070132.29734-1-vaishnav.a@ti.com>
 <CAMty3ZCTiW88SAuaZ6vCfuDAsHKPv0nA8ku_Tvs_11mEuidfMw@mail.gmail.com>
 <20231212140438.GA1721487@bill-the-cat>
In-Reply-To: <20231212140438.GA1721487@bill-the-cat>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Tue, 12 Dec 2023 22:49:43 +0530
Message-ID: <CAMty3ZCypqjN=RG7-wVUObbKTQ7Q7XOiwpJ0H3oCAojjTDpNrQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor-core: Implement
 spi_nor_read_sfdp_dma_unsafe() for sfdp parse
To: Tom Rini <trini@konsulko.com>
Cc: Vaishnav Achath <vaishnav.a@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 p.yadav@ti.com
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

On Tue, Dec 12, 2023 at 7:34=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jul 10, 2022 at 11:07:41AM +0530, Jagan Teki wrote:
> > On Fri, Jun 3, 2022 at 12:31 PM Vaishnav Achath <vaishnav.a@ti.com> wro=
te:
> > >
> > > During SFDP header parse and BFPT parse, structures in stack are used
> > > to perform spi_nor_read_sfdp() which expects a dma-safe buffer.
> > >
> > > This commit introduces spi_nor_read_sfdp_dma_unsafe() to wrap
> > > spi_nor_read_sfdp() using a kmalloc'ed bounce buffer which is
> > > the same implementation in Linux (drivers/mtd/spi-nor/sfdp.c).
> > >
> > > Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> > > ---
> >
> > Applied to u-boot-spi/master
>
> Where did this end up? Thanks.

I have CI, will send PR. soon.

Jagan.
