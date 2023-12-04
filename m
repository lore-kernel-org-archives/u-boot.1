Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA77C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 18:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD4187600;
	Mon,  4 Dec 2023 19:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u+GWIdHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5368760C; Mon,  4 Dec 2023 19:58:08 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD7A8719C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 19:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-286d701cabeso164874a91.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701716284; x=1702321084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhxeTRR4SEDWneJL2KZmZO4+bBJb4auvRstroSzZwTA=;
 b=u+GWIdHax/lj1J1Ni0kh0eq5wS85C3V0a8yNA8be1qPlX7d8pUKB9UUX/wgffWWaD6
 8CLvdvX6WMtD1wsYKlNuV7QCLiSyHECSzuxm+5eNM0upTkwlbD2IeNJR4JQws1l8Mg3R
 HQ/hjj6mUBIDb2Tdmlc/3ZB0RSFwaw5CevXTPqka2kbx52RJcMIBe3Th4Gb1qOZmYuzT
 MVNquTFKxaSa6568DrxzBU6MfTs/ao3ri6DGOKlxrEkwNvZM+0L48RLfjp+NFiV5OKff
 acERjM7OtafXDtaDqhBkpEKHehOZCHLHFocoAyjaxo1DDwwGdwiBEY7Evddg0zt/5yzh
 zsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701716284; x=1702321084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhxeTRR4SEDWneJL2KZmZO4+bBJb4auvRstroSzZwTA=;
 b=ZZdExZ8vvnk1JQ0irjv3fzLCFWcgqq/fPxwiRO6SLwBHPXJpEBmWZehuFVl43E3NKE
 r/d5nS2C2WrKaVzYAJVNqhNqk7jfyIpp5SnzAS1ijv2LCE2cbEjjSU0nzZkEnz3hpYc4
 N7eHSFzjtPenBupRcmhuZ0aRA9uCI8m1McLMOshEWfqvoxVnGn2vqg3iVUThGYj+yfuz
 w0J7JkfPaDvKMkiHvH/VQqsmOdRDgGnyR0wi3kDWPCDLKZnkkxGrvCVRcnclvUaJH6Od
 FYDGCl5E0IF7nSJcV0pt4DpPMLKD2Lo5b8kTPA05N5IbyeX7Oqytseuu1S/vgTY08T02
 ptKQ==
X-Gm-Message-State: AOJu0YwvEFteHEXIress2RkZKbdmJRXgpy3RAHIPvniNNgJqRJTKE6LV
 GADTWG9sxqByZYC78zb2to1kxaQuklEhYku3Z9DB0Th9ma6zmyyo
X-Google-Smtp-Source: AGHT+IGnG257ZV1bhvXcB0t07yrMIzQadn8X3wUkVV6Lj34rfAmp/nfaGx9HWvWW6Q9MHF4K7JQ1xI7024bJRyIQWZ0=
X-Received: by 2002:a17:90b:4f41:b0:286:9cc1:a10 with SMTP id
 pj1-20020a17090b4f4100b002869cc10a10mr38808pjb.8.1701716283664; Mon, 04 Dec
 2023 10:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-7-raymond.mao@linaro.org>
 <CAC_iWjLD3c+Z3cW9z-mKV1bXLEcu2L6Zmm9RMt1s6rV6i+AiJQ@mail.gmail.com>
 <CAC_iWjKP8q+5+3fLTmP+sh8fp7FF5jPGgCKR0N710jNGfhspDw@mail.gmail.com>
In-Reply-To: <CAC_iWjKP8q+5+3fLTmP+sh8fp7FF5jPGgCKR0N710jNGfhspDw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 13:57:53 -0500
Message-ID: <CAEfUkUJB=37uEarqk=cnG7ZS7u4Z3HOTeRcaTwG1ajFhM9SPjQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] bloblist: Drop the flags value
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, Bin Meng <bmeng.cn@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias and Simon,
I just realized that the latest FW Handoff spec introduced 'flags'.
I will remove this patch from the series of next rev.
Regards,
Raymond

On Mon, 4 Dec 2023 at 03:40, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> I just noticed that's fixed in path #12
>
>
> On Mon, 4 Dec 2023 at 10:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 27 Nov 2023 at 21:52, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > >
> > > From: Simon Glass <sjg@chromium.org>
> > >
> > > There is no flags value in spec v0.9 so drop it.
> > >
> > > For now it is still present in the header, with an underscore, so that
> > > tests continue to pass.
> >
> > Why? Can't we drop it overall?
> >
> > Thanks
> > /Ilias
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  common/bloblist.c  |  5 ++---
> > >  include/bloblist.h |  6 ++----
> > >  test/bloblist.c    | 45 +++++++++++++++++++--------------------------
> > >  3 files changed, 23 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/common/bloblist.c b/common/bloblist.c
> > > index f084a32cfc..4d01772c3b 100644
> > > --- a/common/bloblist.c
> > > +++ b/common/bloblist.c
> > > @@ -331,7 +331,7 @@ static u32 bloblist_calc_chksum(struct
> bloblist_hdr *hdr)
> > >         return chksum;
> > >  }
> > >
> > > -int bloblist_new(ulong addr, uint size, uint flags)
> > > +int bloblist_new(ulong addr, uint size)
> > >  {
> > >         struct bloblist_hdr *hdr;
> > >
> > > @@ -343,7 +343,6 @@ int bloblist_new(ulong addr, uint size, uint flags)
> > >         memset(hdr, '\0', sizeof(*hdr));
> > >         hdr->version = BLOBLIST_VERSION;
> > >         hdr->hdr_size = sizeof(*hdr);
> > > -       hdr->flags = flags;
> > >         hdr->magic = BLOBLIST_MAGIC;
> > >         hdr->size = size;
> > >         hdr->alloced = hdr->hdr_size;
> > > @@ -490,7 +489,7 @@ int bloblist_init(void)
> > >                 }
> > >                 log_debug("Creating new bloblist size %lx at %lx\n",
> size,
> > >                           addr);
> > > -               ret = bloblist_new(addr, size, 0);
> > > +               ret = bloblist_new(addr, size);
> > >         } else {
> > >                 log_debug("Found existing bloblist size %lx at %lx\n",
> size,
> > >                           addr);
> > > diff --git a/include/bloblist.h b/include/bloblist.h
> > > index d70a7bad2e..2b898d0c55 100644
> > > --- a/include/bloblist.h
> > > +++ b/include/bloblist.h
> > > @@ -164,7 +164,6 @@ enum bloblist_tag_t {
> > >   * @version: BLOBLIST_VERSION
> > >   * @hdr_size: Size of this header, normally sizeof(struct
> bloblist_hdr). The
> > >   *     first bloblist_rec starts at this offset from the start of the
> header
> > > - * @flags: Space for BLOBLISTF... flags (none yet)
> > >   * @size: Total size of the bloblist (non-zero if valid) including
> this header.
> > >   *     The bloblist extends for this many bytes from the start of
> this header.
> > >   *     When adding new records, the bloblist can grow up to this size.
> > > @@ -182,7 +181,7 @@ struct bloblist_hdr {
> > >         u32 magic;
> > >         u32 version;
> > >         u32 hdr_size;
> > > -       u32 flags;
> > > +       u32 _flags;
> > >
> > >         u32 size;
> > >         u32 alloced;
> > > @@ -317,11 +316,10 @@ int bloblist_resize(uint tag, int new_size);
> > >   *
> > >   * @addr: Address of bloblist
> > >   * @size: Initial size for bloblist
> > > - * @flags: Flags to use for bloblist
> > >   * Return: 0 if OK, -EFAULT if addr is not aligned correctly, -ENOSPC
> is the
> > >   * area is not large enough
> > >   */
> > > -int bloblist_new(ulong addr, uint size, uint flags);
> > > +int bloblist_new(ulong addr, uint size);
> > >
> > >  /**
> > >   * bloblist_check() - Check if a bloblist exists
> > > diff --git a/test/bloblist.c b/test/bloblist.c
> > > index 8b435e27ca..36994c3dd4 100644
> > > --- a/test/bloblist.c
> > > +++ b/test/bloblist.c
> > > @@ -72,15 +72,15 @@ static int bloblist_test_init(struct
> unit_test_state *uts)
> > >         hdr = clear_bloblist();
> > >         ut_asserteq(-ENOENT, bloblist_check(TEST_ADDR,
> TEST_BLOBLIST_SIZE));
> > >         ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         ut_asserteq_ptr(hdr, bloblist_check_magic(TEST_ADDR));
> > >         hdr->version++;
> > >         ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
> > >
> TEST_BLOBLIST_SIZE));
> > >
> > > -       ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10, 0));
> > > -       ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10));
> > > +       ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >
> > >         ut_asserteq(-EIO, bloblist_check(TEST_ADDR,
> TEST_BLOBLIST_SIZE));
> > >         ut_assertok(bloblist_finish());
> > > @@ -90,9 +90,6 @@ static int bloblist_test_init(struct unit_test_state
> *uts)
> > >         ut_asserteq_ptr(NULL, bloblist_check_magic(TEST_ADDR));
> > >         hdr->magic--;
> > >
> > > -       hdr->flags++;
> > > -       ut_asserteq(-EIO, bloblist_check(TEST_ADDR,
> TEST_BLOBLIST_SIZE));
> > > -
> > >         return 1;
> > >  }
> > >  BLOBLIST_TEST(bloblist_test_init, 0);
> > > @@ -106,7 +103,7 @@ static int bloblist_test_blob(struct
> unit_test_state *uts)
> > >         /* At the start there should be no records */
> > >         hdr = clear_bloblist();
> > >         ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_size());
> > >         ut_asserteq(TEST_ADDR, bloblist_get_base());
> > >         ut_asserteq(map_to_sysmem(hdr), TEST_ADDR);
> > > @@ -144,7 +141,7 @@ static int bloblist_test_blob_ensure(struct
> unit_test_state *uts)
> > >
> > >         /* At the start there should be no records */
> > >         clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >
> > >         /* Test with an empty bloblist */
> > >         size = TEST_SIZE;
> > > @@ -176,7 +173,7 @@ static int bloblist_test_bad_blob(struct
> unit_test_state *uts)
> > >         void *data;
> > >
> > >         hdr = clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         data = hdr + 1;
> > >         data += sizeof(struct bloblist_rec);
> > >         ut_asserteq_addr(data, bloblist_ensure(TEST_TAG, TEST_SIZE));
> > > @@ -192,7 +189,7 @@ static int bloblist_test_checksum(struct
> unit_test_state *uts)
> > >         char *data, *data2;
> > >
> > >         hdr = clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         ut_assertok(bloblist_finish());
> > >         ut_assertok(bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >
> > > @@ -201,10 +198,6 @@ static int bloblist_test_checksum(struct
> unit_test_state *uts)
> > >          * change the size or alloced fields, since that will crash
> the code.
> > >          * It has to rely on these being correct.
> > >          */
> > > -       hdr->flags--;
> > > -       ut_asserteq(-EIO, bloblist_check(TEST_ADDR,
> TEST_BLOBLIST_SIZE));
> > > -       hdr->flags++;
> > > -
> > >         hdr->size--;
> > >         ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR,
> TEST_BLOBLIST_SIZE));
> > >         hdr->size++;
> > > @@ -256,7 +249,7 @@ static int bloblist_test_cmd_info(struct
> unit_test_state *uts)
> > >         char *data, *data2;
> > >
> > >         hdr = clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         data = bloblist_ensure(TEST_TAG, TEST_SIZE);
> > >         data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
> > >
> > > @@ -282,7 +275,7 @@ static int bloblist_test_cmd_list(struct
> unit_test_state *uts)
> > >         char *data, *data2;
> > >
> > >         hdr = clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         data = bloblist_ensure(TEST_TAG, TEST_SIZE);
> > >         data2 = bloblist_ensure(TEST_TAG2, TEST_SIZE2);
> > >
> > > @@ -312,7 +305,7 @@ static int bloblist_test_align(struct
> unit_test_state *uts)
> > >
> > >         /* At the start there should be no records */
> > >         hdr = clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
> > >
> > >         /* Check the default alignment */
> > > @@ -348,8 +341,8 @@ static int bloblist_test_align(struct
> unit_test_state *uts)
> > >         hdr = map_sysmem(TEST_ADDR + BLOBLIST_ALIGN,
> TEST_BLOBLIST_SIZE);
> > >         memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
> > >         memset(hdr, '\0', sizeof(*hdr));
> > > -       ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN,
> TEST_BLOBLIST_SIZE,
> > > -                                0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR + BLOBLIST_ALIGN,
> > > +                                TEST_BLOBLIST_SIZE));
> > >
> > >         data = bloblist_add(1, 5, BLOBLIST_ALIGN_LOG2 + 1);
> > >         ut_assertnonnull(data);
> > > @@ -370,7 +363,7 @@ static int bloblist_test_reloc(struct
> unit_test_state *uts)
> > >         ulong new_addr;
> > >         ulong new_size;
> > >
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         old_ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
> > >
> > >         /* Add one blob and then one that won't fit */
> > > @@ -409,7 +402,7 @@ static int bloblist_test_grow(struct
> unit_test_state *uts)
> > >         memset(hdr, ERASE_BYTE, TEST_BLOBLIST_SIZE);
> > >
> > >         /* Create two blobs */
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         blob1 = bloblist_add(TEST_TAG, small_size, 0);
> > >         ut_assertnonnull(blob1);
> > >         ut_assertok(check_zero(blob1, small_size));
> > > @@ -461,7 +454,7 @@ static int bloblist_test_shrink(struct
> unit_test_state *uts)
> > >         ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
> > >
> > >         /* Create two blobs */
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         blob1 = bloblist_add(TEST_TAG, small_size, 0);
> > >         ut_assertnonnull(blob1);
> > >         strcpy(blob1, test1_str);
> > > @@ -511,7 +504,7 @@ static int bloblist_test_resize_fail(struct
> unit_test_state *uts)
> > >         ptr = map_sysmem(TEST_ADDR, TEST_BLOBLIST_SIZE);
> > >
> > >         /* Create two blobs */
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         blob1 = bloblist_add(TEST_TAG, small_size, 0);
> > >         ut_assertnonnull(blob1);
> > >
> > > @@ -548,7 +541,7 @@ static int bloblist_test_resize_last(struct
> unit_test_state *uts)
> > >         hdr = ptr;
> > >
> > >         /* Create two blobs */
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >         blob1 = bloblist_add(TEST_TAG, small_size, 0);
> > >         ut_assertnonnull(blob1);
> > >
> > > @@ -593,7 +586,7 @@ static int bloblist_test_blob_maxsize(struct
> unit_test_state *uts)
> > >
> > >         /* At the start there should be no records */
> > >         clear_bloblist();
> > > -       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
> > > +       ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE));
> > >
> > >         /* Add a blob that takes up all space */
> > >         size = TEST_BLOBLIST_SIZE - sizeof(struct bloblist_hdr) -
> > > --
> > > 2.25.1
> > >
>
