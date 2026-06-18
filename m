Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A67CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F03F784995;
	Thu, 18 Jun 2026 17:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKur8D3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB86A848EB; Thu, 18 Jun 2026 17:52:00 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DC48499C
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-696bf0e7c9cso174217a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781797918; cv=none;
 d=google.com; s=arc-20240605;
 b=lNJsAALtCsU+k+lEXBuKFwYJWnDhf5SZidJFaAAFJpV37zh+BsLJutylznh2/VSleh
 DpuBXCuXkGC4GCuERIdwXx0A2Mfh7wcr0vtj9ejHRgHmVXnTb/enPkXZWOcAr8xLif8p
 SM2zXqpT4qINswQFQBfX+EltpKRnrsiHzMa2JqU53aw6bR3qfLPAtvkVU9BLLZzw24Je
 jSh4MTe1zFPzhyWDR8O7gg3+sITxzUtuqYVp16DNh89NDrD604rJG6Dvta4h+nzYkEZ0
 ZrF5G3+l3s4oEirqsWU3XzXIe1yzx9fV9K+Z4CJWvJQ3XkP2/8vJYchQH12S/zodwm72
 sjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QoCJzoHorl6MTJEOsvfuJ2jLaMOkap2pPXr/FO7XB6c=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=ZoW0qYeG0cBc1wLrU8c9nCF1JdD5J39XbQBKN+hLzt1oBZ0SHRYmAEJ8VXi6oJaOFP
 CsWyVNKCMZ7oXWkm3hcuf+tDFiBw62Z0i0cEwEIxaIy+7bTMbaOyW1WS4hsQkbn26g1O
 wiUyCD9dh799gq63ndGNmIBCX7S4FxCinBd2MEfziXZ/5DzDc1pm4oDW1cF6aWFMxa9N
 JeChNtGccMh7vZQvC0QjMoEnMaI/xJOfsoEfKwVsOyKXGS2iAHXsnp/cOrOtnbjpcw4v
 sHB4ROp0Wc92mVjRfMtBItTUjYuhiqtGzRDKhfQaoSNYuo+4+F5HmLrIV5PJEqRuSAUs
 i5Hg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781797918; x=1782402718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QoCJzoHorl6MTJEOsvfuJ2jLaMOkap2pPXr/FO7XB6c=;
 b=DKur8D3h9n3p+ylPKVDxr30Rv1qKFQobIr5pJrTpQeLghvSurH2BdIJTxvsJn2E/xz
 tCKntUS7qsLgW9ijspkvnm/U1Gs0sYpyzgSLAa8uPAMtuOJoZQQ/xOv0RlCNYvc9l/tX
 4w8ljp/dgovsWX2K1knsVrTaN48XDIdoXED7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781797918; x=1782402718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoCJzoHorl6MTJEOsvfuJ2jLaMOkap2pPXr/FO7XB6c=;
 b=KxLTA73UzR6txNUEgyKlFjcKksH3dLS7Hr4wRUDC6LgpCe130Tp/8gaQhihjj/uTn4
 wgRuxcDaIaoJxryFCJII5fVuVDcoSX7kQ3iNEwxFx9VFlE+Z0yGfsSzmPPQX9gAsvFMC
 UJvaIk//+OM4+V/UtsnqITzr+X9YWFU+xDkI4SGtkE/8H91LzaoqiAo7rGy92NnF+113
 SFntnAupQprRM31e8hkkSzisBtvfkRXj2lbbKewsoDYFjO+PSAbulmHF4XsGHJ1aUTn+
 f9SIfUBBw0moQLZKRqsf4m10BLKkzvsatXf3PMXS7K7dDcganoJOpHRqqjsZlQ/Qqabm
 CT0g==
X-Gm-Message-State: AOJu0Yzr73+qfwcMcKuo3pOBHoR/7zTozajXmzuoAQLEyvM4BNRYGRtV
 LkReKvbHjsn5CjlDWJsB3A8xnANIO/TjYeDKZwNm1uc7A4Jx0VjFPrx0E3H29B5ubN7uwbYCT1M
 zLRZ8JOkyAzxPDwQpEly4FvoEm2uz0/KPSilPrif7
X-Gm-Gg: AfdE7cnyHH4FYPNr3ZFsT3VhKw/lFN3cIExxv7ovxBrO4qTxvwqn6EMt5T6svL8IcxD
 dOYapt0od9jcDs+VCbCMPaJdmga4v38pYzMHTYLkcgOjS4nIAlieEwhpZD4xfU4DuRrPuz7Uw1Z
 GZZM2eIWF3yKLEAs2YwH0HEMu9lknpeSqxls/Jnk6RQxmYQUsTF9u8LxHcJx0nxn5kgNGyvCK9j
 pLdG1+/TDqpsnBlrX2U5VP63HEolyY5G0xoRCEsQ81yBuViHV93jaLsByml1M/Na2cVH89PuQ==
X-Received: by 2002:a05:6402:886:b0:691:957a:bd61 with SMTP id
 4fb4d7f45d1cf-695ba7eef09mr1700867a12.7.1781797918185; Thu, 18 Jun 2026
 08:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-3-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:51:46 +0100
X-Gm-Features: AVVi8CdMRWIe-7UR8qqzjskYQURxxh4pmbdNA7fmKBmtac7b_17LJ1gy18-DKck
Message-ID: <CAFLszThjYU6WC+NAPHwmK6SZSMQvEcGrCdD7gjSAa5xU3EXvpw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] disk: efi: introduce {read,write}_disk_flags
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
> disk: efi: introduce {read,write}_disk_flags
>
> Introduce helper functions for updating top 16 bits of GUID partition
> table entry attributes. The value can be used to store extra information
> about bootflow, such as counters and status.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> disk/part_efi.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/part.h  |  24 +++++++++++
>  2 files changed, 153 insertions(+)

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +int read_disk_flags(struct blk_desc *desc, int partnum, u16 *flags)
> +int write_disk_flags(struct blk_desc *desc, int partnum, u16 flags)

These names are too generic - they are not disk operations, they
read/write the top 16 bits of a GPT PTE in a ChromiumOS-specific
layout. Please rename to gpt_read_flags()/gpt_write_flags() and put
the prototypes alongside the other GPT helpers (next to
part_get_gpt_pte()). As-is, a casual reader would expect them to work
on any partition table.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +int read_disk_flags(struct blk_desc *desc, int partnum, u16 *flags)
> +{
> +     ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
> +     gpt_entry *gpt_pte = NULL;
> +     u64 attrs;
> +
> +     /* 'part' argument must be at least 1 */
> +     if (partnum < 1)
> +             return -EINVAL;
> +
> +     gpt_repair_headers(desc);

A read must not mutate the disk. gpt_repair_headers() performs writes
when one of the two headers is bad - please drop this call from
read_disk_flags(). The return value is also ignored in both functions:
if both GPTs are invalid the caller falls through into
find_valid_gpt()/is_gpt_valid() anyway, so the call adds nothing for
the read path and should be the caller's choice for the write path.

The doxygen says flags cannot be NULL but the function does not check
it - either drop the comment or add a check.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +     if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
> +             return -EINVAL;
> +
> +     if (partnum > le32_to_cpu(gpt_head->num_partition_entries) ||
> +         !is_pte_valid(&gpt_pte[partnum - 1])) {
> +             free(gpt_pte);
> +             return -EPERM;
> +     }

...
> +     rc = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h1, &gpt_e1);
> +     if (!rc) {
> +             rc = -EPERM;
> +             goto out;
> +     }
> +     if (partnum > le32_to_cpu(gpt_h1->num_partition_entries) ||
> +         !is_pte_valid(&gpt_e1[partnum - 1])) {
> +             rc = -EINVAL;
> +             goto out;
> +     }

The errno choices are odd and inconsistent. -EPERM (operation not
permitted) does not describe 'GPT could not be parsed' or 'partition
does not exist'. read returns -EINVAL for invalid GPT and -EPERM for
bad partnum; write swaps them. I suggest -EIO for the unreadable-GPT
case and -ENOENT for 'partition does not exist', consistently.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +     rc = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h1, &gpt_e1);

...
> +     attrs = le64_to_cpu(gpt_e1[partnum - 1].attributes.raw);
> +     attrs &= ~(0xFFFFULL << 48);

Please use lower-case hex.

> +     attrs |= ((u64)flags << 48);
> +     gpt_e1[partnum - 1].attributes.raw = cpu_to_le64(attrs);
> +
> +     rc = write_gpt_pte(desc, gpt_h1, gpt_e1);
...
> +     rc = is_gpt_valid(desc, desc->lba - 1, gpt_h2, &gpt_e2);
...
> +     attrs = le64_to_cpu(gpt_e2[partnum - 1].attributes.raw);
> +     attrs &= ~(0xFFFFULL << 48);
> +     attrs |= ((u64)flags << 48);
> +     gpt_e2[partnum - 1].attributes.raw = cpu_to_le64(attrs);
> +
> +     rc = write_gpt_pte(desc, gpt_h2, gpt_e2);

Two copies of the same logic varying only by LBA. Please factor into a
helper that takes the LBA (or a primary/backup flag) and call it
twice. Also please #define a constant for the bit-48 shift
(CROS_FLAGS_SHIFT, or similar in cros_flags.h) rather than open-coding
'<< 48' and '0xFFFFULL << 48' in three places.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +     rc = blk_dwrite(desc, le64_to_cpu(gpt_h->my_lba), 1, gpt_h);
> +     if (rc != 1) {
> +             pr_err("device %d: failed to update GPT header: %d\n",
> +                    desc->devnum, rc);
> +             return rc ?: -EIO;
> +     }
> +
> +     rc = blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba), cnt, gpt_e);

Please write the PTE array first, then the header - that is what
write_gpt_table() does, and it is the safer ordering: a torn write
leaves the on-disk header pointing at a CRC that does not match the
on-disk PTE if you do header-first.

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
> +static int write_gpt_pte(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
> +{
> +     const int cnt = BLOCK_CNT((le32_to_cpu(gpt_h->num_partition_entries)
> +                                        * sizeof(gpt_entry)), desc);

If primary write succeeds but the backup write fails (bad block at end
of disk, etc.) you leave the two GPTs out of sync and return an error
to the caller, who has no way to know what state the disk is in.
Please mention this in the function comment, and consider attempting
to roll back / retry rather than silently leaving an inconsistent
state. Yes I know this shouldn't happen, but power can fail, device
can reset, etc.

Regards,
Simon
