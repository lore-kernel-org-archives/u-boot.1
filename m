Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE3C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC9774065C;
	Mon,  3 Aug 2026 12:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJ6ZxaAuzEWK; Mon,  3 Aug 2026 12:37:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F7324064B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785760647;
	bh=3F8shym1b/Uo4+NbGXa9AQuRR1E+v/K3ewsO2UgUsGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVWPNrzylj5MqMxTLFnvEjNtHv7SUeos/ZNyzp3vPePKHC/PvdUWePfzAmmqDbAYL
	 NbuZQa7yMV2HkPeDuS4z+oaUhK8/cyDjCC9XLgsbmaWiteMlwLDcII5la1HYQ42ChO
	 7VJG+OqDW+4SdPJS62bIu+lv4S9BiUB31dMQzGT0FbNE5zrfU5mxZw69YCuJ46JK5G
	 9GjgIgsNNwtVFt9E5BHnLU7/RCrcgbMkKoto0Rcp7iLB9WOasi0CdbtvGNGtOy1SA3
	 XjVGOxpfNS+exjrApypKNs3DJY32NUGWvVjDpDmYFL3EsbIZPnpDnpzoCPnMnI+jH5
	 5WULOr9XfM7NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F7324064B;
	Mon,  3 Aug 2026 12:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50DF836E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3762E60703
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6N-xcfBwMAV for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:37:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D0ED605D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D0ED605D5
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D0ED605D5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:37:23 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664a09bc459so4051996d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785760643; cv=none;
 d=google.com; s=arc-20260327;
 b=dWUD1BWMgfbOX2Xki3UbvGktF4MO8bJBc/hsjg02BhHWum4iuKhNuCykDCyflQ+t5L
 9/B2Ws1Rla5sDSsWCmKj2aR58S26pVDBULeNZNqXRIZrbYH2pz/LqoRAMLA/SdVuFYa7
 JigcLOcMnTF/+Prm67lbAD+YARGBOJF7X/6tvNGuCyELdeXy3OvpY9NVU10/Xx+R+ue6
 mTRVBJmbAs/bK34m36+NX23dgZHf6uf2OMRl+BRgJBhKW7ueJix5ELQ5BU1qlq5VYwpL
 0BLMcJmgD4uz/JmbxiRaaXwdJEI2t2uHeX3S2juOJOKNh6EwwWi6NFVZcSwFLeCaYOrj
 uJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3F8shym1b/Uo4+NbGXa9AQuRR1E+v/K3ewsO2UgUsGM=;
 fh=f/vaMyCG5Qv74UFk+AVmTQso3cXkIgLTJex8Yll2TDQ=;
 b=MsRUozregquz2Vq0bUu9VjCRjrjah6ZHcoZLx4ZDFKom9gGcUsPM6gyuXviMrnOEFG
 2XqcRRI4bYWdunYWenuyFAQXDYHCV9OWKd0h+MfZcoCRibj2VRZgA/42xIDcSe4lDQs0
 QDiOTpV5ZnwoxvkxyQHhxrcAiszOk/fFE4Cf127YOtKAGJwul9lOGyfleM4jedoazkzh
 wSgYqvnPKXjK77FigBoCuv4ir9UGaenqBMPN1v0/eAcLDmQc9lwBciKPoRo7QHjEJBpc
 ayA8RenSV4X9nv+gXK4vElOJT7kp84G4cmNWZsj1NhylIXjyrcm45VQU59mUaKIp+KxF
 LYsw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760643; x=1786365443;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3F8shym1b/Uo4+NbGXa9AQuRR1E+v/K3ewsO2UgUsGM=;
 b=S4V5YKOkox3q6uqQ3Xf3+fVfEaBnIPBi8HK8fvdPxDRlWw7R4WjVRVnX7PItSrMULp
 JKYfSZYi+gzE0/DUTzU2JOYGXrVwIjS2M5peHsENPk1r8yjyJCv6TLf4/Tz/xox974g6
 BJF7kn93fxECj1Oz1UUDIPM8mBQoMdoEzN/lEqy/9m/1oo5NacKvXbXMMlcJGyPFya92
 Dq/+a4ucocZEDozcDjhiAisplsHxDRZ4kS1s2FZlYm79Pdh/WL3DnhNoxjjOk8yBQQdf
 laWSYqMTWKnoo1BvwVOsgwjCVy3O3KydjguBFgu6z0fjief62mfvxJoYRdYrYKkSmNNg
 9o9w==
X-Gm-Message-State: AOJu0YwU2vQe12b+CHvDEKZqP049TGt9vkdXTqaI+wQrZCSfjAh3bXIY
 ah7gcZAyH+nDSm1z9KGiGr5y6UEVGvOmwU9E1E5jIv5db13rnn8PH4PtPN3FEpw1DQt8Y04KbzG
 6dK89I/OqaOs42VtGX49LCZE394hLJ8tvKUYbxlSHaA==
X-Gm-Gg: AR+sD11Ew/l44eX0AmKf9lR77/SP82U3zcVIhcCDIDQSJZatdD3OXSqqkiyipklLgbC
 9W4m9VtNstFjxXMTOynOiABzGN8UeLmY2EHwvT6Ux3HBWNdnhWHBTNoC8G1elE97YLmyd2KkROh
 ZHRNEvFyRYyfZn1rwYO0ib3AfWvAMB5xjkF7l+p9fBvAnem75DjA8Cd67P7sSsdKJ0bj5IU2uRE
 k5ICOrIIlpZy3EQ/GdP0dJmKdbS46rQqGQIcZ/mEnlu5a/1Y8Y2tnUvpSVyGjlXTZvcV1x7meqc
 nG7SHFj2MoHixW4jAmO14rhuIj7czfFOrmCCLEZt7yUiWr+e7LNNfyo+9C4jfgldA5hB6gcqhW3
 Z/skEX5mSH0OtTmwl6xFzRjRCCjVja1NYBTXaAhDXOxWApCsJOOW5eVhyq5HXJ04VsctK+Gb0O1
 QCKTtR7xYMA0dQPAA9H3kJCie/A4XmZcE+OpPO/X0Fay/jUxuQwHyq6lr8OJTRl8I7DCJeWISLd
 cRF9dru1NDbj6VtdTfUcuABhMV3hnL/ul1Y6I3z1n/XpOpwhHgQ3nnILdm/UePt/pvT8Sm9AdWd
 wawORT3LeGAzJPYIRq31PcocDRjdYhTy+iWaOMPmZdjBT6LWN9SfSh8jllHqvSbwBX60vllxZtl
 oycw77bidAWh757/dij/NzPrnTDmZ1B+E+AAjuPPpucw=
X-Received: by 2002:a05:690e:1a90:b0:662:c4c4:dabf with SMTP id
 956f58d0204a3-6694f06362dmr7183238d50.16.1785760621083; Mon, 03 Aug 2026
 05:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 15:36:24 +0300
X-Gm-Features: AUfX_my63W22VMK1xdG1v4NoLsPm5JzT4pA55q-J5hFMamYDHkw_5Amv0_g7zb8
Message-ID: <CAC_iWjKeVJgzP6TGFBanokX4PF9dZcMZNQ4_KjtfCNvKchDQeg@mail.gmail.com>
Subject: Re: [PATCH 4/6] test: dm: part: Check the GPT layout for large sector
 sizes
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785760643; x=1786365443;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3F8shym1b/Uo4+NbGXa9AQuRR1E+v/K3ewsO2UgUsGM=;
 b=tthELXFM0XI01lPJ+CfFQqQN2/ugJhS+9CSjCEzLBrxZMLtdsd7xNrONjgOAcp/AP1
 wB0PxHn6U8t1ZRdXVMK4hJSaB4dYWv4l6Us66g5TWVYs2Laj1qPMYKlaBSwCHq4MyPfd
 mt2tAK0uVLhcFiOVXIiI98i3UXtsicReqTrhvJrwN2aFQR0SJJqQwwasHJudQKT1Pauh
 b2xLaIv/ztERnrg+7xl/9uLQ7xq8CTeKpnpfXd3jebhTiUbBa4QhnwivTXY1kVcQK6+h
 pRdUaOjyILN8znHXiHOrMFKNzGHCuVy56YE2XKWgQXsZ8Mm8q9wfc6mf1LoN4m5n9u9W
 rr5A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tthELXFM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
>
> Add a test that runs gpt_fill_header() and gpt_fill_pte() over a range of
> block sizes and checks that the partition entry array is sized and placed
> consistently, in particular that the backup array ends exactly where the
> backup GPT header begins.
>
> Neither function performs any block I/O, so the test builds a synthetic
> struct blk_desc rather than needing a block device with a configurable
> block size. The expected array size is taken from the GPT header fields
> rather than from GPT_ENTRY_NUMBERS, so the test still holds for builds
> with a non-default CONFIG_EFI_PARTITION_ENTRIES_NUMBERS, such as
> ARCH_SUNXI with 56 entries.
>
> Without the preceding fixes this fails on the first block size other than
> 512:
>
>   test/dm/part.c:313, dm_test_part_gpt_blksz():
>       entry_lba + pte_blks == first_lba: Expected 0x12 (18), got 0x22 (34)
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  test/dm/part.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/test/dm/part.c b/test/dm/part.c
> index ad37d7f406f4..4b48322fb807 100644
> --- a/test/dm/part.c
> +++ b/test/dm/part.c
> @@ -5,6 +5,8 @@
>
>  #include <dm.h>
>  #include <env.h>
> +#include <malloc.h>
> +#include <memalign.h>
>  #include <mmc.h>
>  #include <part.h>
>  #include <part_efi.h>
> @@ -248,3 +250,101 @@ static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
>         return 0;
>  }
>  DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> +
> +/*
> + * Check that the GPT layout adapts to the block size of the device. Neither
> + * gpt_fill_header() nor gpt_fill_pte() does any block I/O, so a synthetic
> + * descriptor is enough here; partition_entries_offset() reads the device tree
> + * '/config' node, which is available without scanning for devices.
> + */
> +static int dm_test_part_gpt_blksz(struct unit_test_state *uts)
> +{
> +       static const struct {
> +               unsigned long blksz;
> +               lbaint_t lba;
> +       } cases[] = {
> +               {   512, 0x2000 },      /* 4MB, the traditional 34-block layout */
> +               {  1024, 0x1000 },
> +               {  2048,  0x800 },
> +               {  4096,  0x400 },      /* 4K native media, e.g. UFS */
> +               {  8192,  0x200 },
> +               { 16384,  0x100 },      /* the array fits in a single block... */
> +               { 32768,   0x40 },      /* ...on a device smaller than 34 blocks */
> +       };
> +
> +       char str_disk_guid[UUID_STR_LEN + 1] =
> +               "8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
> +       struct disk_partition part;
> +       struct blk_desc desc;
> +       gpt_header gpt_h;
> +       gpt_entry *gpt_e;
> +       int i;
> +
> +       gpt_e = calloc(GPT_ENTRY_NUMBERS, sizeof(gpt_entry));
> +       ut_assertnonnull(gpt_e);
> +
> +       for (i = 0; i < ARRAY_SIZE(cases); i++) {
> +               u64 entry_lba, first_lba, last_lba;
> +               u32 pte_blks;
> +
> +               memset(&desc, '\0', sizeof(desc));
> +               memset(&gpt_h, '\0', sizeof(gpt_h));
> +               desc.blksz = cases[i].blksz;
> +               desc.log2blksz = LOG2(desc.blksz);
> +               desc.lba = cases[i].lba;
> +
> +               ut_assertok(gpt_fill_header(&desc, &gpt_h, str_disk_guid, 1));
> +
> +               /*
> +                * Size the array with BLOCK_CNT() rather than the
> +                * DIV_ROUND_UP() that gpt_pte_blocks() uses, so that this
> +                * checks the layout instead of restating the implementation.
> +                */
> +               pte_blks = BLOCK_CNT(le32_to_cpu(gpt_h.num_partition_entries) *
> +                                    le32_to_cpu(gpt_h.sizeof_partition_entry),
> +                                    (&desc));
> +               entry_lba = le64_to_cpu(gpt_h.partition_entry_lba);
> +               first_lba = le64_to_cpu(gpt_h.first_usable_lba);
> +               last_lba = le64_to_cpu(gpt_h.last_usable_lba);
> +
> +               ut_asserteq_64(1, le64_to_cpu(gpt_h.my_lba));
> +               ut_asserteq_64(desc.lba - 1, le64_to_cpu(gpt_h.alternate_lba));
> +
> +               /* the primary array ends where the usable area begins */
> +               ut_assert(entry_lba >= 2);
> +               ut_asserteq_64(entry_lba + pte_blks, first_lba);
> +               ut_assert(first_lba < last_lba);
> +
> +               /*
> +                * write_gpt_table() puts the backup array at
> +                * last_usable_lba + 1, so it has to end exactly where the
> +                * backup header begins
> +                */
> +               ut_asserteq_64(le64_to_cpu(gpt_h.alternate_lba),
> +                              last_lba + 1 + pte_blks);
> +
> +               /* a partition with no start and no size fills the disk */
> +               memset(&part, '\0', sizeof(part));
> +               disk_partition_set_uuid(&part, str_disk_guid);
> +               ut_assertok(gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +               ut_asserteq_64(first_lba, le64_to_cpu(gpt_e[0].starting_lba));
> +               ut_asserteq_64(last_lba, le64_to_cpu(gpt_e[0].ending_lba));
> +
> +               /* a partition overlapping the entry array is rejected */
> +               part.start = entry_lba;
> +               part.size = 1;
> +               ut_asserteq(-ENOSPC,
> +                           gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +
> +               /* so is one running past the end of the usable area */
> +               part.start = first_lba;
> +               part.size = last_lba - first_lba + 2;
> +               ut_asserteq(-E2BIG,
> +                           gpt_fill_pte(&desc, &gpt_h, gpt_e, &part, 1));
> +       }
> +
> +       free(gpt_e);
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_part_gpt_blksz, 0);
>
> --
> 2.54.0
>
