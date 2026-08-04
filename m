Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B132FC5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 08:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E05640550;
	Tue,  4 Aug 2026 08:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rilaoHakNNqN; Tue,  4 Aug 2026 08:26:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62F8E40580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785831971;
	bh=K3Y7Khls4DqMQodk+gtaPzINPBWBHNeZMUdjem9Qr5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CovwUxygB9GEMhhVfa7PnRK4XR7vUdjRQH6ahK6DP68qvFHlr0XVln6gqaG1/X0VA
	 O2/IX1N3wVjj7Q7gB2i5kl+vzi9mSY6VtPxEFm6Uh4HfphiR+HErFf5dhDbKPPRs0n
	 j0yPA/KpLZhHfpKl9rSGo+ImDfgUOtieTCR9M+3DFmlYG8p+WD5juhB0BKL1l8zKlO
	 1lBFB27v4wtHCmrcZ2AUHWllkL5VDM77QDLo3fS++y43qMFZM/U25AX0G+fHpkvo3O
	 d7fAUMtJYLX8N1jELITsWIxH6nShY3SFLKIQt+r0SmfVi5imlvgPgYz2F3BWdXCizw
	 0YGnCqt2/+E1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F8E40580;
	Tue,  4 Aug 2026 08:26:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5003326C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D6814004D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4tjNjBS9fv3 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 08:26:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2115A4002B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2115A4002B
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2115A4002B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:26:07 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66892c81725so5851351d50.2
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 01:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785831966; cv=none;
 d=google.com; s=arc-20260327;
 b=ODgCKUKax8/87qTxYGNQTKeFiemIJS3p71Fv32xLNXPrYQ8RJpFnzs2jg6ipA5tzgc
 BkeeYrEsdDCTh5uOHZ23UQfjOqF5baJ+nlECQCY+R3JW3rAMcR5UnwdwdTXgD/A8p1J+
 O9fmnUVSnRLBlsGZaF0pyMszprDhw2sL/lZAo5DhoT+LuU9njcmrGbDnaw8tHPddK4oQ
 VcaNvzZB15C4nyQzb9jrwDcEQTR7w2lM/tdzGdn43U6//Gq0IZDLn+pvlHyDktUA8/B7
 EBmDOPvWR24ZLQTtpLTeLCLjblZzTYX/pakZSPB809dtSHrOSncAo2VppLRsCNCSrD2s
 W7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3Y7Khls4DqMQodk+gtaPzINPBWBHNeZMUdjem9Qr5A=;
 fh=f/vaMyCG5Qv74UFk+AVmTQso3cXkIgLTJex8Yll2TDQ=;
 b=SGbeMQJbfIz1iYY7mnWNItqgkMljJAqIF1oK1f5mKzgktK2ZEaqzEHW0XupYlDQBw5
 HQKTR6xIZCkxdrS0SuuKDLXPMN5uNrLuo+4+GnTiqPqiITOD0H2d6OFoFOAdOKScG+qX
 6an4BIcjBRehpMld8DvSUI2zz8QUlO51ZElQr7ehrsD6GLCDpYWjte9bjXyzAXPFHOPC
 Gma2GnjaOK7em+gdLF0qqnTGLYitEEyORhJprLEKGVkQ8Q8z4JNQlZT7yJjC2xaHsSSF
 tNBvoSNX5gB8gB+vsE66oKbSdlkjZsdb+X7gSYDKibOSNYNGcb2YK177yMMTW+zIuXS4
 5tWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785831966; x=1786436766;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K3Y7Khls4DqMQodk+gtaPzINPBWBHNeZMUdjem9Qr5A=;
 b=UlDlQshMuFaysdJuocB83Y5ViDVhotONqlC+FBaJOvcw7yS37OQxjuTBZA8nTYkqs/
 5nkQuf5tD6tFW/o3asW9fsZnfrGyAFm9ldI/hB7lZRiQL5JSmq7kgqIVT3376LnXL5XN
 Y0aqbvzdakZRDtAvuGRzPIqR+nBxW3YsJmAk9cyzqLSHqFYw/TWQtYBiVykUq7airpvl
 0YZ+2oXGCEPRa+m4Qahw8KAf5veIDT14zYVnKJI3mSQnZiUyj+xNlTsPUOsTU+HjQfMd
 W+TfDwzAnjRypV44NQKWawAIqENjXN9YhEq2kQ96ezv57CvKborPehDdunnk/QdHLAxs
 9+GA==
X-Gm-Message-State: AOJu0YxutqWYxLfl0kPo/AuW+6JUVXujCIhnes/G6wGPhpMSEHksjH+t
 ocrlh2GDUnayG0tqEqXEXQBJh6SnBnffdeJlvcMw2iph9aEM9mjiEb89DO0cXRBH/pjaceAQcof
 5bFTRv2FzOwjJC2F1pCjiWo2n3Dnbdovv4tVbcbRIKA==
X-Gm-Gg: AR+sD11dIkkg1hgTv8PYbAFgbIy38ShP0YV3Qi3AIrL2eCsVkuAyEEej9WDp/2ng3WX
 oTiWBrgMbuKAtXT46G9DqX7vzf55vzTy0FEbak6og5AdwII5sZ0aWPln9Z72YxFLb2XHE1ufmum
 ehchgleiVEToy9c0i2aSuDOdGUuyBk/SOo4sgk2wciwQpbCu7mWTdvGPR1K23bNbINd+yjBJFD9
 UWjrHWpwPZT6YUuHFgmdBfrEyYpAK+CyYqYqdVMTNwvxdVtqOcYvdvGNBV4iVNAQUiKFEzveXA3
 GbXW0ThXWMhGqB40rveVVbHRgtVhb+mMT18ZQVwWEQ0LRNVKOFHyu/4oK8Dl7BYv0Q0Bv8ruJyc
 4I/AzVUvvRW0C091pA+KvE20tKiUFKs+i/QgLQJGw0ihqmPISxqaSJ8GkbMd70UTgpfnDuXvdTP
 uj0TqMSwBs12KAgFlWPnBq0uggc0rUQrNmtAGbIkuylWOsBjDLZ8XrTtvwwBKhpEUgxGy5u2FYi
 Jm8wysyvTqw/xPYGxYB6tRZmW4VV8NHb9mqcDGKn+KMefEJIVBpodl8COWpMoISIdSHf8nKUdv5
 Ek3xNHhpB0H1nANFEBLMlxAuY7LeJ4Cf5/FJp9Nd9xfj0JXhlslt7shRNhEhVinSX5LyGmqaWG8
 7CKUNi01uji97gGtDapT5Q4npnehkb6TP4SY3MTP83hc=
X-Received: by 2002:a53:c48e:0:b0:668:43ff:265d with SMTP id
 956f58d0204a3-6694f17589cmr12526223d50.33.1785831966427; Tue, 04 Aug 2026
 01:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-1-a3f1f16b53ae@flipper.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Aug 2026 11:25:28 +0300
X-Gm-Features: AUfX_mwZRRzTiBssYbGChW2LXq8GLayJ728JrMfGy0yuTDp5fNj1uh9Lyqb-RZA
Message-ID: <CAC_iWj+amWJLeGCXFTTtfpfGfzhbY5bHxBPWXmZW-E=LBMB1hQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] disk: part_efi: Size the partition entry array from
 the block size
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
 d=linaro.org; s=google; t=1785831966; x=1786436766;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K3Y7Khls4DqMQodk+gtaPzINPBWBHNeZMUdjem9Qr5A=;
 b=lnL/FKM5X3w3lj7bPeJrwri8T/8mbo5GdatD4SBAeQ8CjDc0E9CZ6GYdvuw5+dV1dq
 7DdKkl1VwO1nVxalXfkfjGovs2mQ9m/Fsv/CKVBwSCdKgMimh61tMmomX8XIl5Mz5YWR
 byis6KwQoHEbiG/Zqbc4aMkFnNK6JKScyCi4LI8JsISu+Q719KOjrudJHtd+3hQGNLqv
 YM0pAmZAGwbB07vN7w7On/7Yve9EjhA7VKq80e1Ny7EXTVtwRaIdTbX9pTCEBCqaGZFN
 oH4dRTdTPDrWdqvZi3wIymz9H8rOKK8ETK5XOGNRuFuA8Tzk0KguysbqiKGr2E8kHygV
 gg/g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lnL/FKM5
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
> gpt_fill_header() computes last_usable_lba and first_usable_lba from
> hardcoded block counts that silently assumes 512-byte sectors and the
> default number of partition entries.
>
> The partition entry array holds GPT_ENTRY_NUMBERS entries of 128 bytes
> each, so the number of blocks it needs depends on both the entry count
> and the block size. write_gpt_table() derives that count correctly and
> writes the backup array at last_usable_lba + 1, so whenever the two
> disagree the backup array no longer immediately precedes the backup GPT
> header. Furthermore, on a device with 4096-byte native sectors, such as
> UFS flash, and the default 128 entries, the array is 4 blocks rather than
> 32. Current code reserves 34 blocks at each end of the disk for any block
> size and wastes about 114 KiB at each end.
>
> Add a new helper gpt_pte_blocks() and use it in all four places which
> currently calculate the number of blocks each in its own way, so the
> layout written by gpt_fill_header() and the extent written by
> write_gpt_table() cannot drift apart again. With this, first_usable_lba
> on 4096-byte sectors is 6, last_usable_lba is lba - 6, and the backup
> array occupies lba - 5 .. lba - 2, immediately preceding the backup
> header, as the UEFI specification describes.
>
> Note that this changes the 512-byte layout too for boards that do not use
> the default entry count. CONFIG_EFI_PARTITION_ENTRIES_NUMBERS is
> "default 56 if ARCH_SUNXI" and is set to 64 by a number of Rockchip
> defconfigs:
>
>   entries  array blocks  first_usable_lba  last_usable_lba
>        56            14        34 -> 16    lba - 34 -> lba - 16
>        64            16        34 -> 18    lba - 34 -> lba - 18
>       128            32        34 -> 34    lba - 34 -> lba - 34
>
> Existing partition tables stay readable either way, since is_gpt_valid()
> locates the entry array from the on-disk partition_entry_lba. Only newly
> written tables change. Partitions given without an explicit start= will
> now be placed lower on those boards; on sunxi first_usable_lba lands on
> the 8 KiB SPL offset, so such boards should keep specifying start=
> explicitly.
>
> While here, report both LBAs when the requested layout does not fit, since
> the existing "Partitions layout exceeds disk size" debug message gives no
> clue as to by how much, making it less helpful in debugging.
>
> Co-developed-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Anton Burticica <mouse@ya.ru>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  disk/part_efi.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>

LGTM, but I'd like people that have been involved to take a closer look
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91a..af311867a285 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -388,10 +388,23 @@ static int set_protective_mbr(struct blk_desc *desc)
>         return 0;
>  }
>
> +/**
> + * gpt_pte_blocks() - number of blocks taken up by a partition entry array
> + *
> + * @desc:      block device descriptor
> + * @gpt_h:     GPT header describing the array
> + * Return: number of blocks the array occupies on @desc
> + */
> +static u32 gpt_pte_blocks(struct blk_desc *desc, const gpt_header *gpt_h)
> +{
> +       return DIV_ROUND_UP(le32_to_cpu(gpt_h->num_partition_entries) *
> +                           le32_to_cpu(gpt_h->sizeof_partition_entry),
> +                           desc->blksz);
> +}
> +
>  int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
>  {
> -       const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
> -                                          * sizeof(gpt_entry)), desc);
> +       const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
>         u32 calc_crc32;
>
>         debug("max lba: %x\n", (u32)desc->lba);
> @@ -453,9 +466,7 @@ int gpt_fill_pte(struct blk_desc *desc,
>         size_t hdr_end = hdr_start + 1;
>
>         size_t pte_start = gpt_h->partition_entry_lba;
> -       size_t pte_end = pte_start +
> -               gpt_h->num_partition_entries * gpt_h->sizeof_partition_entry /
> -               desc->blksz;
> +       size_t pte_end = pte_start + gpt_pte_blocks(desc, gpt_h);
>
>         for (i = 0; i < parts; i++) {
>                 /* partition starting lba */
> @@ -482,7 +493,9 @@ int gpt_fill_pte(struct blk_desc *desc,
>                 gpt_e[i].starting_lba = cpu_to_le64(start);
>
>                 if (offset > (last_usable_lba + 1)) {
> -                       log_debug("Partitions layout exceeds disk size\n");
> +                       log_debug("Partitions layout exceeds disk size: "
> +                                 LBAFU " > " LBAFU "\n",
> +                                 offset, last_usable_lba + 1);
>                         return -E2BIG;
>                 }
>                 /* partition ending lba */
> @@ -604,18 +617,29 @@ static uint32_t partition_entries_offset(struct blk_desc *desc)
>  int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
>                     int parts_count)
>  {
> +       u32 pte_sectors;
> +
>         gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
>         gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
>         gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
> +       gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
> +       gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
> +
> +       /*
> +        * Number of blocks occupied by the partition entry array. For the
> +        * default of 128 entries that is 32 blocks on 512-byte sectors, but
> +        * only 4 blocks on 4096-byte sectors.
> +        */
> +       pte_sectors = gpt_pte_blocks(desc, gpt_h);
> +
>         gpt_h->my_lba = cpu_to_le64(1);
>         gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
> -       gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
> +       /* Reserve space for backup GPT header (1) + backup partition entries */
> +       gpt_h->last_usable_lba = cpu_to_le64(desc->lba - pte_sectors - 2);
>         gpt_h->partition_entry_lba =
>                 cpu_to_le64(partition_entries_offset(desc));
>         gpt_h->first_usable_lba =
> -               cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + 32);
> -       gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
> -       gpt_h->sizeof_partition_entry = cpu_to_le32(sizeof(gpt_entry));
> +               cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + pte_sectors);
>         gpt_h->header_crc32 = 0;
>         gpt_h->partition_entry_array_crc32 = 0;
>
> @@ -747,8 +771,7 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *desc)
>  static int write_one_gpt_table(struct blk_desc *desc, gpt_header *gpt_h,
>                                gpt_entry *gpt_e)
>  {
> -       const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
> -                                          * sizeof(gpt_entry)), desc);
> +       const int pte_blk_cnt = gpt_pte_blocks(desc, gpt_h);
>         lbaint_t start;
>         int ret = 0;
>
>
> --
> 2.54.0
>
