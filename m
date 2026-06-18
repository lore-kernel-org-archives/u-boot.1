Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE74CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820D2849AE;
	Thu, 18 Jun 2026 17:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jEblBYDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7313F849BA; Thu, 18 Jun 2026 17:52:14 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C5F848EB
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so2022536a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797932; cv=none;
 d=google.com; s=arc-20240605;
 b=U61sViPDd8dnVLBUPHaskm1jH/eX4Slz4pp7ZNG07H6XWT7ZaAzU4nLti8L3Ak6hR2
 T+MlaJXvB9CQ9XSeWuVFjqrv7JraT0OOHl75cJu0Mk2HBGlzqDQoiBWjPxxCoKOpz9k4
 FNQ0o908CIC3Q8DIHY5YzObMZ6zcE+jPngqYlcsCR+Glc2UDlGl9DZb8Wcs3AIFP6BXB
 t4PHBSm6rCoacVWv+lXHti0ExPEbGWjWXeTHerWpSV3Jyg7LrJ10wvyLPImHKTd+nQD8
 RssD9efOQFr6Ye56g5TEK72Ik4kPPSV/+fHeEQkXb+3l6B9Btk1ADs10hz90SnWEIhVn
 GBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9fTfnPuE08tbrdd6oWjqQ5L0UesEMXLJZFkIFgfkhGU=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=ep/mFyAC2ChFFe/RUYtNfJwleElGT6Lpt1ecZDBrha3eYlDxOmGhnmxTIivw4LQ69D
 G+erEhcluszybDXXqR+4Gp3ybTfWOgUq3J9LyuuUI39kctzFObFmokGYjxJSVOSVoozC
 CHzfAhKC1KzHpZBQy5zMGyb2GPgLEQ7GPkntYUmr/0UVbKAWko+3rgcsQqmwqyAA7TsJ
 gCs/T6SJgq15qr6thMld+XaaoiV/eJlkv+YcaEj6Pir4+xlNR9MmE49ZTSN5AoEbAdNB
 XpOHjFxgG8BOeEpzYWWFkEGArDe/K5plUgOKPL33F3ucLCnU9oUgb21qAsIK61xAY01X
 Yu0Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781797932; x=1782402732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9fTfnPuE08tbrdd6oWjqQ5L0UesEMXLJZFkIFgfkhGU=;
 b=jEblBYDYFpKBqiIbeo6LefEZYUou13hFzobYq5Lz2UJSs4TUT0H8aepMiefQwbnTqz
 onmQAYTGt06WAvcDrc9Pq/YfZymJkXFt4apMXp/aW18Zph/VhtTeH6XP5afnj4wmInoq
 KrvB8TPCTptztBtexq8sQZFy5USOu4amm/qW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797932; x=1782402732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fTfnPuE08tbrdd6oWjqQ5L0UesEMXLJZFkIFgfkhGU=;
 b=aNPXvBm4lxIfaqP5w2zNG54VWQNVd+p8SUlWJTYJrY0im9qsi30JETzGhBfIHGiEWG
 /3jeofJY0lFXjCmdpRH9m/moLv4SmAF3zb5AYmv77wKdneyeuUW39bzobybuF2HAqH8o
 u2HX4lUrla4kLnPj6xexbjFNTjWFbD4OF5DsoEWuCNfNhqweTgrL02Avm3GfRRgRqjS9
 J7mNncBwUFrc5z9xKEyzc7cQLGolk5Y1EsIhIM9mCCz2eG47JnvO/T2QzIwpmD+2wUzK
 GtzKzPNhOGVZ9lcTQzdi56ttYMdl1vYoBVtbD/J/1YQtGEtFloXfpy3zPZciLDUgR6PI
 2f0w==
X-Gm-Message-State: AOJu0YySW2Fl3+m8x6bAdmWzhrUCcTs8zlE9yKmvL0FUV3Ka836FMYoX
 gMnPobUTQ9FRtRRVAL4EgKUl4X96npzyu7VZS6tdDTAU7eg8DNaMYtNkInKqigkT1ade4HEzstM
 nv7LTEznHAoVTe4vlOqbiAVx4hmFMp+touHiTLKzI
X-Gm-Gg: AfdE7ckTNhK6FCMTVXBIN6M99d3QubeX1xTAasPo+ltH2ix2sGp6mHK32X7T7KF5qNI
 nk/ymelSUSRAaDZ3aSUx9fXZrDvR6W6ppgWfYSmdC0+ZyRqDTyRGEX1tMkbf29YJhyvNoGxKG9B
 1rmLWKvKuQh1KluWldsxX7FBvKg95djP1wJZhJaQIknIYvnrmxE0s+r8RZcAdvtt+leBamNFMEJ
 Sk7adnWRgpqsZn9onZ5wJp9nO3LutmBDfO7SfeEACU/8A6yaPix3JjasECpZGCToFLkDL3QKw==
X-Received: by 2002:a05:6402:1599:b0:68c:4424:a08d with SMTP id
 4fb4d7f45d1cf-696dde5e89dmr5009a12.2.1781797931818; Thu, 18 Jun 2026 08:52:11
 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-4-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:51:59 +0100
X-Gm-Features: AVVi8Cd5mtgEoOtpLoRARdpeIzPd2eTBY8zzJnp03r6R1uS-LX6sEi9oN9zWfVo
Message-ID: <CAFLszThnYiMhYMkDwRj4-NeKvsyaRpq3Ba3_ZMq10C3k5WUVQA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] test: disk: coverage for {read,write}_disk_flags
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> test: disk: coverage for {read,write}_disk_flags
>
> Add unit test coverage for GPT flags functions.
>
> To run the test:
>   truncate -s 16M mmc1.img
>   ./test/py/test.py --bd sandbox --build -k test_gpt_flags -v
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> disk/part_efi.c     |  12 +++--
>  test/dm/Makefile    |   2 +-
>  test/dm/gpt-flags.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 156 insertions(+), 6 deletions(-)

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -47,17 +47,19 @@ static inline u32 efi_crc32(const void *buf, u32 len)
>       return crc32(0, buf, len);
>  }
>
> +/* Public for unit tests. */
> +int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
> +                     gpt_entry **pgpt_pte);
> +int is_pte_valid(gpt_entry * pte);
> +

Please don't expose these by re-declaring the prototypes in two places
(here and in test/dm/gpt-flags.c). Either put the prototypes in a
private header that only the test pulls in, or rework the test so it
goes through the public API. The "Public for unit tests" comment plus
a duplicated extern declaration in the test file is fragile - if the
signature ever changes, the test silently drifts.

> diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
> @@ -0,0 +1,148 @@
> +static int mock_blk_desc(struct unit_test_state *uts, struct blk_desc **desc)
> +{
> +     struct udevice *dev;
> +     char str_disk_guid[UUID_STR_LEN + 1];
> +     struct disk_partition parts[2] = {
> +             {
> +                     .start = TEST_LBA_COUNT,
> +                     .size = 1,
> +                     .name = 'test1',
> +             },
> +             {
> +                     .start = 49,
> +                     .size = 1,
> +                     .name = 'test2',
> +             },
> +     };
> +
> +     ut_assertok(uclass_get_device_by_name(UCLASS_BLK, 'mmc1.blk', &dev));
> +     *desc = (struct blk_desc *)dev_get_uclass_plat(dev);
> +
> +     if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
> +             gen_rand_uuid_str(parts[0].uuid, UUID_STR_FORMAT_STD);
> +             gen_rand_uuid_str(parts[1].uuid, UUID_STR_FORMAT_STD);
> +             gen_rand_uuid_str(str_disk_guid, UUID_STR_FORMAT_STD);
> +     }
> +     ut_assertok(gpt_restore(*desc, str_disk_guid, parts,
> +                             ARRAY_SIZE(parts)));

When CONFIG_RANDOM_UUID is not enabled, str_disk_guid is an
uninitialised stack buffer and parts[].uuid is empty, so gpt_restore()
calls uuid_str_to_bin() on garbage and fails. Please use a fixed GUID
string (or assert the dependency on RANDOM_UUID) - silently relying on
the sandbox defconfig is brittle.

> diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
> @@ -0,0 +1,148 @@
> +DM_TEST(test_gpt_flags_default, UTF_SCAN_FDT);

DM_TEST registers these under the dm suite (I am assuming DM is
necessary?), and the convention is to prefix function names with
dm_test_. Please rename to dm_test_gpt_flags_default etc - that is
also what 'ut dm gpt_flags_default' will look for. Please give
test_disk_flags_invalid_partnum the same prefix for consistency.

> diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
> @@ -0,0 +1,148 @@
> +static int test_gpt_flags_headers(struct unit_test_state *uts)
> +{
> +     struct blk_desc *desc;
> +     u16 flags_in = 0x0111;
> +
> +     ut_assertok(mock_blk_desc(uts, &desc));
> +     ut_assertok(write_disk_flags(desc, TEST_PARTNUM, flags_in));
> +
> +     {
> +             ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h1, 1, desc->blksz);
> +             ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h2, 1, desc->blksz);

The nested { ... } block is awkward - please put the buffers and
locals to the top of the function.

> diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
> @@ -0,0 +1,148 @@
> + * To run the test:
> + *   truncate -s 16M mmc1.img
> + *   ./test/py/test.py --bd sandbox --build -k test_gpt_flags -v

This belongs as automatic setup in test/py/tests/test_ut.py (see
setup_fedora_image, setup_rauc_image, etc), not as manual instructions
in the commit message. Otherwise CI won't run it and people reading
the test years from now won't know where the image came from. Please
wire it into test_ut_dm_init_bootstd() so 'ut dm gpt_flags_*' just
works.

> diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
> @@ -0,0 +1,148 @@
> +static int test_disk_flags_invalid_partnum(struct unit_test_state *uts)
> +{
> +     struct blk_desc *desc;
> +     u16 flags;
> +
> +     ut_assertok(mock_blk_desc(uts, &desc));
> +     ut_asserteq(-EINVAL, read_disk_flags(desc, 0, &flags));
> +     ut_asserteq(-EINVAL, write_disk_flags(desc, 0, 0));
> +     ut_asserteq(-EINVAL, write_disk_flags(desc, 255, 0));

Missing a few cases: negative partnum, a partnum just past
num_partition_entries (which returns -EPERM from read_disk_flags() and
-EINVAL from write_disk_flags() = different return codes, worth a
separate comment on patch 2), and read_disk_flags() with the high
partnum. Also please test with a NULL flags pointer if
read_disk_flags() is meant to reject it.

Regards,
Simon
