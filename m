Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E24CE7A9B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 16:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F4486BE7;
	Mon, 25 Sep 2023 18:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cFxoL+GJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A6B686BE7; Mon, 25 Sep 2023 18:10:19 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079F086B3A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 18:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f4db9e11eso50988077b3.0
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695658216; x=1696263016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/SCkfTV9otbtwMcKwb1FwUtTtWc2I114wnGM+o4z14I=;
 b=cFxoL+GJk2lRlfetjV32xtjHCL+AYDZuDikcKA9WQuIdijl4dYy6IkKWt88HfeyOs0
 9R9CTvilsu/nNLW9EQggkFY6kD4HJ+97ZNYdBWzc0s+gzkl9kzb2jnKPYt01EIBabQ/0
 daDNhKslpHN77X2j4hbwFZlRGM78JFp+zoELNu9lGbThC31ZDHV/c+O2OPVjYiTkDLjx
 p95LZYvyf1IYatrtfV595i5JV6kVPnv7KZSx6DBxr0tLasAnP/QgnH9doHV6XKqiCtNP
 YtvkUDyhXW7L+C1fXSLIRh+B+g3GKpL2aaUgS89bY6p/FoN7bD1lN/mi8UhpA+nKz538
 /AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695658216; x=1696263016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/SCkfTV9otbtwMcKwb1FwUtTtWc2I114wnGM+o4z14I=;
 b=PtuUERXiVg/uWkBCUDBa44jbEXpFHy3kQ52gt9fYHK8amUPrcOp3+rLEVrFrvc91YH
 SIKXcTFUBlxPwq7nvfMYiH5/ozmnq/0AcTX/PObh51dI4JsEOYrR4w9kz+B3AKcqzwZy
 tjuSVVlZjfqns4dZIH9JNkW/A4qnFEkqE995kjdwUDz8x/QNUTc8VJ5bUXf5xM1wmTeN
 DY6GApljsfIH9o6a6VKVi3vaHyipECYMqU4JximOoDiobqswI9HgysC6zyZvpFVOOXoa
 KB26zuLiDmZDrPTir1v7/tF4aAmY6PjpvhsQo3JpjBlBTDvBKrSnJhiZcBQbOvN4xQRi
 uB+Q==
X-Gm-Message-State: AOJu0Yz1Mqexzd+slvm6Un+L7y3sVtKULJZOQTkKVZxJXBL5oFkMedXt
 qeV0vXZUIX9kQTiwNqii4X8rX1tX+ZU70ZRlC0qi3A==
X-Google-Smtp-Source: AGHT+IGvNlqIxrsbBiYwvDWc9BVyRGYxiOZldV8OBGQmbMPF9nWX2zIZ/ZnL5giHrYMer09JAeK78XGsZcIycvAWXcs=
X-Received: by 2002:a81:8486:0:b0:586:9f6c:41a0 with SMTP id
 u128-20020a818486000000b005869f6c41a0mr5801618ywf.14.1695658215484; Mon, 25
 Sep 2023 09:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230924111832.3741245-1-u-kumar1@ti.com>
 <57F0DE54-C8BF-4B48-9075-2D267DBA4924@gmx.de>
 <7edb7998-66a4-293e-9cfb-ebc142387684@ti.com>
In-Reply-To: <7edb7998-66a4-293e-9cfb-ebc142387684@ti.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 25 Sep 2023 10:09:57 -0600
Message-ID: <CAPnjgZ1K8=UKaTf2WTeOY+58uoRrH=AiL6UNyM7v_Q1gpOvwuA@mail.gmail.com>
Subject: Re: [PATCH] lmb: remove overlapping region with next range
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, nm@ti.com, vigneshr@ti.com, 
 patrick.delaunay@foss.st.com, sjoerd@collabora.com, u-boot@lists.denx.de, 
 michal.simek@amd.com, Suman Anna <s-anna@ti.com>
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

Hi Udit,

On Sun, 24 Sept 2023 at 22:10, Kumar, Udit <u-kumar1@ti.com> wrote:
>
> On 9/24/2023 7:21 PM, Heinrich Schuchardt wrote:
> >
> > Am 24. September 2023 13:18:32 MESZ schrieb Udit Kumar <u-kumar1@ti.com>:
> >> In case of new memory range to be added is coalesced
> >> with any already added non last lmb region.
> >>
> >> And there is possibility that, then region in which new memory
> >> range added is not adjacent to next region. But have some
> >> sections are overlapping.
> >>
> >> So along with adjacency check with next lmb region,
> >> check for overlap should be done.
> >>
> >> In case overlap  is found, adjust and merge these two lmb
> >> region into one.
> >>
> >> Reported-by: Suman Anna <s-anna@ti.com>
> >> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> >> ---
> >> logs
> >> https://gist.github.com/uditkumarti/5d08c34442235ad270cfa863792ebcdc
> >> seqeunce : line 1 to 13
> >> without fix : line 96-100
> >> with fix : line 199-202
> >>
> >> lib/lmb.c | 37 +++++++++++++++++++++++++++++++++----
> >> 1 file changed, 33 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/lib/lmb.c b/lib/lmb.c
> >> index b2c233edb6..2580d01d90 100644
> >> --- a/lib/lmb.c
> >> +++ b/lib/lmb.c
> >> @@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
> >>      return 0;
> >> }
> >>
> >> +static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
> >> +                            unsigned long r2)
> >> +{
> >> +    phys_addr_t base1 = rgn->region[r1].base;
> >> +    phys_size_t size1 = rgn->region[r1].size;
> >> +    phys_addr_t base2 = rgn->region[r2].base;
> >> +    phys_size_t size2 = rgn->region[r2].size;
> >> +
> >> +    return lmb_addrs_overlap(base1, size1, base2, size2);
> >> +}
> >> static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
> >>                               unsigned long r2)
> >> {
> >> @@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
> >>      phys_size_t size1 = rgn->region[r1].size;
> >>      phys_addr_t base2 = rgn->region[r2].base;
> >>      phys_size_t size2 = rgn->region[r2].size;
> >> -
> >>      return lmb_addrs_adjacent(base1, size1, base2, size2);
> >> }
> >>
> >> @@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
> >>      lmb_remove_region(rgn, r2);
> >> }
> >>
> >> +/*Assmptuon : base addr of region 1 < base addr of region 2*/
> > Assumption
>
>
> Thanks Heinrich  will fix this typo in v2.
>
> Let me wait for other review feedback as well before proceeding for v2.
>
>
> > Regards Heinrich
> >
> >> +static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
> >> +                                 unsigned long r2)
> >> +{
> >> +    phys_addr_t base1 = rgn->region[r1].base;
> >> +    phys_size_t size1 = rgn->region[r1].size;
> >> +    phys_addr_t base2 = rgn->region[r2].base;
> >> +    phys_size_t size2 = rgn->region[r2].size;
> >> +
> >> +    if (base1 + size1 > base2 + size2) {
> >> +            printf("This will not be a case any time\n");
> >> +            return;
> >> +    }
> >> +    rgn->region[r1].size = base2 + size2 - base1;
> >> +    lmb_remove_region(rgn, r2);
> >> +}
> >> +
> >> void lmb_init(struct lmb *lmb)
> >> {
> >> #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> >> @@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >>              phys_size_t rgnflags = rgn->region[i].flags;
> >>              phys_addr_t end = base + size - 1;
> >>              phys_addr_t rgnend = rgnbase + rgnsize - 1;
> >> -
> >>              if (rgnbase <= base && end <= rgnend) {
> >>                      if (flags == rgnflags)
> >>                              /* Already have this region, so we're done */
> >> @@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >>              }
> >>      }
> >>
> >> -    if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
> >> -            if (rgn->region[i].flags == rgn->region[i + 1].flags) {
> >> +    if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
> >> +            if (lmb_regions_adjacent(rgn, i, i + 1)) {
> >>                      lmb_coalesce_regions(rgn, i, i + 1);
> >>                      coalesced++;
> >> +            } else if (lmb_regions_overlap(rgn, i, i + 1)) {
> >> +                    /* fix overlapping area */
> >> +                    lmb_fix_over_lap_regions(rgn, i, i + 1);
> >> +                    coalesced++;
> >>              }
> >>      }
> >>

Can you please add a test to test/lib which fails before your change
and passes after?

Regards,
Simon
