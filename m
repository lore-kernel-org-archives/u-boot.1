Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16194C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 16:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5361D80283;
	Tue, 21 Jan 2025 17:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WtRa7rbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC6E80326; Tue, 21 Jan 2025 17:02:57 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED01801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 17:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7be6fdeee35so237298285a.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475373; x=1738080173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hKBSsfCnsX646sz7IkFGnPquY2RLGGPSCCxz1ZcAgEg=;
 b=WtRa7rbWuFIyaLEppujVIj/CmGGH0JfScwKnr26/0T748nK36TbOkZCfwaXNFkdaFL
 jZq559qtOrgx3KJn+jhRToWO1eH9ONUcvdTPYaySly3dpb8RXeMyjZZ0CS2/ppzEZfmg
 szxAzzgTq9Hua/t2NCx6q44zvQ8KtvaR/UpXW3Pom0pml5/PNcGbUD1FN0ae327fThc6
 y/Y/gAfGHrojdNKYKwAnusCbqo15484hxNxgXquMoWITrDmwmGo3G8kaeMTe98Vkp3K+
 IDW63Xy0oj1fJPL0tscapMCptlW0pZzLMXAECP31ilrF7EQAfHKUox4tZweAuaIZZI4b
 csgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475373; x=1738080173;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKBSsfCnsX646sz7IkFGnPquY2RLGGPSCCxz1ZcAgEg=;
 b=EQYbvWAGxFHLN2dsv+7YHqfFNGEW8ls0ZdMxIhWbNZkThuatyIkvqoMYno1QajvIjd
 nojPq3OHOipopx3uDXDtJAfLvAXv+haECSnRXnUYH+2aJIikAVSNZM0Lia+c5/GMCUUj
 JS6ogw5VxPlnSsiM32aV9/AG3owhBxA4SPca/eyLAy1/4zDwu6k9WSfDpZm8A5CzoX59
 xrzz3FjfrrHO49ttFwncGtahqVwWt2dz+pXQ/3bSsLgNyx6UplUittrrMSyRGY0M+mc2
 A/oc2dR8dOzZXz628QxzOCY0zlQD22i6wSbGoujMsc+HJj/ny23jxq4PW32xEery22RG
 DVRg==
X-Gm-Message-State: AOJu0YzL7OybnFH76kRQHj2pW5LP+WD/Bb5mnkzPIKJlI+wLlPtRFUVY
 meM5+WGxZwXR2L6ffpWrYQKbUYX62Ppl2ZAF+czIowgnoIaoRne5a55FbfZOrsDlwrUOx5gwA3R
 cA4GeyDDGoKcJdXWH9vpYD8DM2RjeaOJsXiF+1RU5fIJ+r45DQfc=
X-Gm-Gg: ASbGncsCLcSr4c7wa1k1rdm4cLG+NH8KbdTOSsxfo1/YHE4qpzg0LxMLbnSp6tTAJlj
 tKjMJo62VI2jKGEEOck+OFZBhiFZFuHdd36K38jSo0gToHO30I6E7
X-Google-Smtp-Source: AGHT+IEMM0xIsiSjBUKpTn80sbib1XJnGnMx8+sUlQVknOoa9RzJvTjWDkDXa/WAEZGwVkyDhgHvoZyH7XCQ6i7e25I=
X-Received: by 2002:a05:620a:2405:b0:7b6:c90e:e227 with SMTP id
 af79cd13be357-7be63202177mr2624981985a.20.1737475373219; Tue, 21 Jan 2025
 08:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <20250120105045.1281262-5-sughosh.ganu@linaro.org>
 <CAC_iWjJT3MW0UXGS-84C_ZDuj-mQau3nrO9tAPsbGehpXLm6bQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJT3MW0UXGS-84C_ZDuj-mQau3nrO9tAPsbGehpXLm6bQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 21 Jan 2025 21:32:42 +0530
X-Gm-Features: AbW1kvYVdJXPoEIofXczhKrGl-xldST3_poqiS4H2SGHQWCtKse2KK7aoEO9Xe0
Message-ID: <CADg8p947wYiKfpcjOkufCvhH2Cz2+U3iPECG777v+kptum9b9A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] blkmap: store type of blkmap device in
 corresponding structure
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

On Tue, 21 Jan 2025 at 21:25, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh
>
> On Mon, 20 Jan 2025 at 12:51, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add information about the type of blkmap device in the blkmap
> > structure. Currently, the blkmap device is used for mapping to either
> > a memory based block device, or another block device (linear
> > mapping). Put information in the blkmap structure to identify if it is
> > associated with a memory or linear mapped device. Which can then be
> > used to take specific action based on the type of blkmap device.
>
> I haven't followed up all the discussions yet, but I do have a question.
> Are blkmap devices now unconditionally added in a pmem node? (if they
> are backed by memory)

Yes, all memory backed blkmap devices are being added as pmem nodes.

-sughosh

>
> Thanks
> /Ilias
>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: New patch
> >
> >  cmd/blkmap.c                  | 16 ++++++++++++----
> >  drivers/block/blkmap.c        | 10 +++++++++-
> >  drivers/block/blkmap_helper.c |  2 +-
> >  include/blkmap.h              | 12 +++++++++++-
> >  test/dm/blkmap.c              | 16 ++++++++--------
> >  5 files changed, 41 insertions(+), 15 deletions(-)
> >
> > diff --git a/cmd/blkmap.c b/cmd/blkmap.c
> > index 164f80f1387..1bf0747ab16 100644
> > --- a/cmd/blkmap.c
> > +++ b/cmd/blkmap.c
> > @@ -119,15 +119,23 @@ static int do_blkmap_map(struct cmd_tbl *cmdtp, int flag,
> >  static int do_blkmap_create(struct cmd_tbl *cmdtp, int flag,
> >                             int argc, char *const argv[])
> >  {
> > +       enum blkmap_type type;
> >         const char *label;
> >         int err;
> >
> > -       if (argc != 2)
> > +       if (argc != 3)
> >                 return CMD_RET_USAGE;
> >
> >         label = argv[1];
> >
> > -       err = blkmap_create(label, NULL);
> > +       if (!strcmp(argv[2], "linear"))
> > +               type = BLKMAP_LINEAR;
> > +       else if (!strcmp(argv[2], "mem"))
> > +               type = BLKMAP_MEM;
> > +       else
> > +               return CMD_RET_USAGE;
> > +
> > +       err = blkmap_create(label, NULL, type);
> >         if (err) {
> >                 printf("Unable to create \"%s\": %d\n", label, err);
> >                 return CMD_RET_FAILURE;
> > @@ -218,7 +226,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
> >         "blkmap read <addr> <blk#> <cnt>\n"
> >         "blkmap write <addr> <blk#> <cnt>\n"
> >         "blkmap get <label> dev [<var>] - store device number in variable\n"
> > -       "blkmap create <label> - create device\n"
> > +       "blkmap create <label> <type> - create device(linear/mem)\n"
> >         "blkmap destroy <label> - destroy device\n"
> >         "blkmap map <label> <blk#> <cnt> linear <interface> <dev> <blk#> - device mapping\n"
> >         "blkmap map <label> <blk#> <cnt> mem <addr> - memory mapping\n",
> > @@ -228,6 +236,6 @@ U_BOOT_CMD_WITH_SUBCMDS(
> >         U_BOOT_SUBCMD_MKENT(read, 5, 1, do_blkmap_common),
> >         U_BOOT_SUBCMD_MKENT(write, 5, 1, do_blkmap_common),
> >         U_BOOT_SUBCMD_MKENT(get, 5, 1, do_blkmap_get),
> > -       U_BOOT_SUBCMD_MKENT(create, 2, 1, do_blkmap_create),
> > +       U_BOOT_SUBCMD_MKENT(create, 3, 1, do_blkmap_create),
> >         U_BOOT_SUBCMD_MKENT(destroy, 2, 1, do_blkmap_destroy),
> >         U_BOOT_SUBCMD_MKENT(map, 32, 1, do_blkmap_map));
> > diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> > index 34eed1380dc..a817345b6bc 100644
> > --- a/drivers/block/blkmap.c
> > +++ b/drivers/block/blkmap.c
> > @@ -153,6 +153,9 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >         struct blk_desc *bd, *lbd;
> >         int err;
> >
> > +       if (bm->type != BLKMAP_LINEAR)
> > +               return log_msg_ret("Invalid blkmap type", -EINVAL);
> > +
> >         bd = dev_get_uclass_plat(bm->blk);
> >         lbd = dev_get_uclass_plat(lblk);
> >         if (lbd->blksz != bd->blksz) {
> > @@ -240,6 +243,9 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
> >         struct blkmap_mem *bmm;
> >         int err;
> >
> > +       if (bm->type != BLKMAP_MEM)
> > +               return log_msg_ret("Invalid blkmap type", -EINVAL);
> > +
> >         bmm = malloc(sizeof(*bmm));
> >         if (!bmm)
> >                 return -ENOMEM;
> > @@ -435,7 +441,8 @@ struct udevice *blkmap_from_label(const char *label)
> >         return NULL;
> >  }
> >
> > -int blkmap_create(const char *label, struct udevice **devp)
> > +int blkmap_create(const char *label, struct udevice **devp,
> > +                 enum blkmap_type type)
> >  {
> >         char *hname, *hlabel;
> >         struct udevice *dev;
> > @@ -472,6 +479,7 @@ int blkmap_create(const char *label, struct udevice **devp)
> >         device_set_name_alloced(dev);
> >         bm = dev_get_plat(dev);
> >         bm->label = hlabel;
> > +       bm->type = type;
> >
> >         if (devp)
> >                 *devp = dev;
> > diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
> > index bfba14110d2..56cbe57d4aa 100644
> > --- a/drivers/block/blkmap_helper.c
> > +++ b/drivers/block/blkmap_helper.c
> > @@ -19,7 +19,7 @@ int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
> >         struct blk_desc *desc;
> >         struct udevice *bm_dev;
> >
> > -       ret = blkmap_create(label, &bm_dev);
> > +       ret = blkmap_create(label, &bm_dev, BLKMAP_MEM);
> >         if (ret) {
> >                 log_err("failed to create blkmap\n");
> >                 return ret;
> > diff --git a/include/blkmap.h b/include/blkmap.h
> > index d53095437fa..21169c30af1 100644
> > --- a/include/blkmap.h
> > +++ b/include/blkmap.h
> > @@ -9,6 +9,12 @@
> >
> >  #include <dm/lists.h>
> >
> > +/* Type of blkmap device, Linear or Memory */
> > +enum blkmap_type {
> > +       BLKMAP_LINEAR = 1,
> > +       BLKMAP_MEM,
> > +};
> > +
> >  /**
> >   * struct blkmap - Block map
> >   *
> > @@ -16,11 +22,13 @@
> >   *
> >   * @label: Human readable name of this blkmap
> >   * @blk: Underlying block device
> > + * @type: Type of blkmap device
> >   * @slices: List of slices associated with this blkmap
> >   */
> >  struct blkmap {
> >         char *label;
> >         struct udevice *blk;
> > +       enum blkmap_type type;
> >         struct list_head slices;
> >  };
> >
> > @@ -78,9 +86,11 @@ struct udevice *blkmap_from_label(const char *label);
> >   *
> >   * @label: Label of the new blkmap
> >   * @devp: If not NULL, updated with the address of the resulting device
> > + * @type: Type of blkmap device to create
> >   * Returns: 0 on success, negative error code on failure
> >   */
> > -int blkmap_create(const char *label, struct udevice **devp);
> > +int blkmap_create(const char *label, struct udevice **devp,
> > +                 enum blkmap_type type);
> >
> >  /**
> >   * blkmap_destroy() - Destroy blkmap
> > diff --git a/test/dm/blkmap.c b/test/dm/blkmap.c
> > index a6a0b4d4e20..06816cb4b54 100644
> > --- a/test/dm/blkmap.c
> > +++ b/test/dm/blkmap.c
> > @@ -56,7 +56,7 @@ static int dm_test_blkmap_read(struct unit_test_state *uts)
> >         struct udevice *dev, *blk;
> >         const struct mapping *m;
> >
> > -       ut_assertok(blkmap_create("rdtest", &dev));
> > +       ut_assertok(blkmap_create("rdtest", &dev, BLKMAP_MEM));
> >         ut_assertok(blk_get_from_parent(dev, &blk));
> >
> >         /* Generate an ordered and an unordered pattern in memory */
> > @@ -85,7 +85,7 @@ static int dm_test_blkmap_write(struct unit_test_state *uts)
> >         struct udevice *dev, *blk;
> >         const struct mapping *m;
> >
> > -       ut_assertok(blkmap_create("wrtest", &dev));
> > +       ut_assertok(blkmap_create("wrtest", &dev, BLKMAP_MEM));
> >         ut_assertok(blk_get_from_parent(dev, &blk));
> >
> >         /* Generate an ordered and an unordered pattern in memory */
> > @@ -114,7 +114,7 @@ static int dm_test_blkmap_slicing(struct unit_test_state *uts)
> >  {
> >         struct udevice *dev;
> >
> > -       ut_assertok(blkmap_create("slicetest", &dev));
> > +       ut_assertok(blkmap_create("slicetest", &dev, BLKMAP_MEM));
> >
> >         ut_assertok(blkmap_map_mem(dev, 8, 8, NULL));
> >
> > @@ -140,19 +140,19 @@ static int dm_test_blkmap_creation(struct unit_test_state *uts)
> >  {
> >         struct udevice *first, *second;
> >
> > -       ut_assertok(blkmap_create("first", &first));
> > +       ut_assertok(blkmap_create("first", &first, BLKMAP_LINEAR));
> >
> >         /* Can't have two "first"s */
> > -       ut_asserteq(-EBUSY, blkmap_create("first", &second));
> > +       ut_asserteq(-EBUSY, blkmap_create("first", &second, BLKMAP_LINEAR));
> >
> >         /* But "second" should be fine */
> > -       ut_assertok(blkmap_create("second", &second));
> > +       ut_assertok(blkmap_create("second", &second, BLKMAP_LINEAR));
> >
> >         /* Once "first" is destroyed, we should be able to create it
> >          * again
> >          */
> >         ut_assertok(blkmap_destroy(first));
> > -       ut_assertok(blkmap_create("first", &first));
> > +       ut_assertok(blkmap_create("first", &first, BLKMAP_LINEAR));
> >
> >         ut_assertok(blkmap_destroy(first));
> >         ut_assertok(blkmap_destroy(second));
> > @@ -168,7 +168,7 @@ static int dm_test_cmd_blkmap(struct unit_test_state *uts)
> >         ut_assertok(run_command("blkmap info", 0));
> >         ut_assert_console_end();
> >
> > -       ut_assertok(run_command("blkmap create ramdisk", 0));
> > +       ut_assertok(run_command("blkmap create ramdisk mem", 0));
> >         ut_assert_nextline("Created \"ramdisk\"");
> >         ut_assert_console_end();
> >
> > --
> > 2.34.1
> >
