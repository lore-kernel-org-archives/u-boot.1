Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78187EDF156
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 12:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA2E983015;
	Fri, 13 Feb 2026 13:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bNXN67nU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B9483AA9; Fri, 13 Feb 2026 13:02:36 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072A5802C1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 13:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-649b5f5570fso1096572d50.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 04:02:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770984151; cv=none;
 d=google.com; s=arc-20240605;
 b=BgfChRZv0B8eTCIv2bNcr0P4JCvBQsk8INZJl3yi3I4Ky3asrP6Dq4vRcYWXfnr6iP
 r/t6TDUBJ8yMAIsVgzW3AcxtluLgaGZngTYzvZyQgbrDKD5Ed7VC/zPM6wDEopqoSpor
 IUm9wqhcOrONUpHOqiKtXRaFp1yiH4GD0e5ROEyfosm0c65Qk0LIRHNXsYJXfImMa3jf
 iszdxNP1SIzaK4PsyAS5+oeN3s+U8Sqkk9qjOjrnoeQXwaWFdmEzt9/ANQVbu1G3iC/o
 U1oFVBqL9feWgbNygrERx8bvUDZQTTO3g/Kf7KR5FizUTPsQvXUzU8NleCz16kLk3QB5
 E58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zaUZut3BB9jqR+UdjG4ZL5fc981rcPID67cW27eIt1Q=;
 fh=KHYfCdCiT8YFLWWHIboEnmfISkJH4zI2cf6VmS1SUiE=;
 b=ZWkXH02GGTdakewYV2TyB/CCLmtKf4bMswrx1PpFim04Clk7G1jC7nPuPFnB/MrPsl
 ST/G2aICW9jXBfn7Gg6gqeMJC54gF9l5IJUqgKeg34TfeAn085GU0td7LkxhH1UkNQuG
 lgEzc9p+IS1k2uP9JYEN0Ii51cXT6HXsB9c+WB4ryFORCDgLJPrbfvHH1ALffgh7p0ij
 NfDd919hEtkl6WabtoEYQp4kZY7nzlej0jQVuyg1WMZAkdDTiECZ0LSsFg/rrZ8pnkGO
 PQEClaVD7fHurgypZeikbG3ZbfAe8ja9D2bjl6jR6YUv7khMfqVpcn82yZhhoZ7bzst0
 DV7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770984151; x=1771588951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zaUZut3BB9jqR+UdjG4ZL5fc981rcPID67cW27eIt1Q=;
 b=bNXN67nUO0xOY/4xwsGv+TEs76+z2Ze0Rt8ilcttaRS+FuilxS+9Du8okuHGNZbm3u
 3JqL8FArI35nWKxWZV7pF+QoK2fVs8vUE7LccBjuTmPiBqu1sKv2XI8SWRR4Mvllao7o
 nemmVxHQutf4O93xYqn3HVumQ1PtY60C616N8HgyQITyJh4xqzedqQSH7BvKQGN1pES+
 VM9QL8QqV1DYTUXtURg3mSIF3Nz+3DsG81HHcFZDfOZJoUt47waIIhAaH2Kk1+lGrXEs
 ESyup9F6TZbGUqA7QyvK2qviee8kGlP2GMIENITde8QDMjOjuOe7QjwMKC9SIi8FsOf+
 z0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770984151; x=1771588951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaUZut3BB9jqR+UdjG4ZL5fc981rcPID67cW27eIt1Q=;
 b=tYrwQSLvEKw4p2Cz1p4FHOfK4s9ngIozisg3ykp53Dm5xutdcPWKLhlOBezpOhA9sA
 BUEK8u0IvN/0WvQRuH/rhhE8LPfFz2B/WSRAYniXEwLp0uTaxhJLArWFSnqpNdMztnoU
 8kHuv/zs8ZpOIAIln83tNBf8qfnvQgzAxEqn7jF9t90viu2HL+7atmShqDIUpXRZ137w
 sIROSavecG+SvZ3c7O8L9cY4ZoAIEeBS5MT/wq9AkJyP9ViG2n8InwJOOZXQ096H51/G
 +JSw5GahhfR6tLKKoT5Nnf97NmlXRAbtVyXIEWOisNbqh361SEBTZfNwTKMDegMUkov4
 QgTQ==
X-Gm-Message-State: AOJu0YyQQTP9P2dPAHNvBANtkf9pSQlgUfYtx7tpqHV7OQ7kaFASOPq0
 VyUFRBUgqGRDDLSxd6uQw0i8qh1ItOeBaMDnT0oxsf3PARRlinoapLmX5XE1ZcYs3SOFwTdMJ6v
 NQxZAzCIg5QQvb2rEdkLTd6b8mXxXRTQceYKnX6wZOg==
X-Gm-Gg: AZuq6aIhMDYxjS+Ta2PIMvXtgaEmfe6a3S/1B+iHtViyBEulQcPenCk15oNPXNFAh5+
 /cCyEBwRUR+/vehv2/UJC7ZWC7u2247Aa2kb1g3jg2IFO1Po/FXGqIOYHWJtuR5+vq65DGfYz0C
 v48QU6BIVh0A4ITYFJFCpEfRRLUxhpUFs03+EuJ6GPc7m+uwSWtyFyZUTPWsCvCCqrrGSgBLd8v
 v3Ib+7hCb5kn2xya0Oby6h6rSV8s6RJqXHokKnoAmyB4HI5MCAUOjPZ4yxHMSg7wXcAqtANTVWn
 KXrcIcJ4xMyZaB7QKL8wqT6L9deyslm4KNfFLurNh/KKWpsnCz+NM5rSBcRE7BybHasC/+XzAVB
 yMwdb2AiU+9BrzY47fCePnc8YNrfsYFDrvGDTnLfntGOsWy2PCgUHiLLTWec8G0Tv4usKZx/eZq
 6iU2dL4r2KI6OmlFmXkLyrBulYP2eslIBwiYDIS+hLnyGablZjnMyApu7ZE30PpT/FypQ9fhIOn
 k51Fre8FzizahnSbab8yptrXTuuUyoPkHgjotJSJ4/htFBnLLj/5xotSsvlsl9RbOwBBhXp7g9e
 5IfkDgZ/mw+q71JNMQaHl9PowiQpI0MsBUK02fQ6Ni8Q
X-Received: by 2002:a05:690e:1247:b0:649:d084:9ee2 with SMTP id
 956f58d0204a3-64c195d851dmr1002210d50.1.1770984151228; Fri, 13 Feb 2026
 04:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-6-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-6-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 14:01:55 +0200
X-Gm-Features: AZwV_QjPFtG0k7NXPnh_8iHhJRnfZAunvfoIWEgNjTDeJKUsNlgGoxE0qWbca8E
Message-ID: <CAC_iWjL3Z47=psqHNpP_zDbArsQahHu9Kad1KRHkUKrUF0FfHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] disk: part_dos: Refactor to allow retrieving raw
 MBR partition data
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Javier Tia <javier.tia@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
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

On Thu, 12 Feb 2026 at 22:45, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Refactor the part_get_info_extended() helper function (which already
> recursively traverses DOS partitions) to optionally return the raw MBR
> partition structure (dos_partition_t).
>
> This allows other subsystems, such as EFI, to retrieve the partition
> details in the legacy MBR format.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  disk/part_dos.c | 66 ++++++++++++++++++++++++++++++-------------------
>  include/part.h  | 14 +++++++++++
>  2 files changed, 55 insertions(+), 25 deletions(-)
>
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index a69ad8962106..4e1d01b2f21e 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -204,7 +204,8 @@ static void print_partition_extended(struct blk_desc *desc,
>   * @relative:          Relative offset for the partition
>   * @part_num:          Current partition number
>   * @which_part:                Target partition number
> - * @info:              Returns a pointer to the partition info
> + * @info:              Returns partition information (optional)
> + * @mbr:               Returns MBR partition entry (optional)
>   * @disksig:           Disk signature
>   *
>   * Return:             0 on success, negative on error
> @@ -212,7 +213,9 @@ static void print_partition_extended(struct blk_desc *desc,
>  static int part_get_info_extended(struct blk_desc *desc,
>                                   lbaint_t ext_part_sector, lbaint_t relative,
>                                   int part_num, int which_part,
> -                                 struct disk_partition *info, uint disksig)
> +                                 struct disk_partition *info,
> +                                 dos_partition_t *mbr,
> +                                 uint disksig)
>  {
>         ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, desc->blksz);
>         struct disk_partition wdinfo = { 0 };
> @@ -243,9 +246,11 @@ static int part_get_info_extended(struct blk_desc *desc,
>         if (CONFIG_IS_ENABLED(PARTITION_UUIDS) && !ext_part_sector)
>                 disksig = get_unaligned_le32(&buffer[DOS_PART_DISKSIG_OFFSET]);
>
> -       ret = part_get_info_whole_disk(desc, &wdinfo);
> -       if (ret)
> -               return ret;
> +       if (info) {
> +               ret = part_get_info_whole_disk(desc, &wdinfo);
> +               if (ret)
> +                       return ret;
> +       }
>
>         /* Print all primary/logical partitions */
>         pt = (dos_partition_t *) (buffer + DOS_PART_TBL_OFFSET);
> @@ -258,25 +263,29 @@ static int part_get_info_extended(struct blk_desc *desc,
>                     (pt->sys_ind != 0) &&
>                     (part_num == which_part) &&
>                     (ext_part_sector == 0 || is_extended(pt->sys_ind) == 0)) {
> -                       if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
> -                               info->blksz = wdinfo.blksz;
> -                       else
> -                               info->blksz = DOS_PART_DEFAULT_SECTOR;
> -                       info->start = (lbaint_t)(ext_part_sector +
> -                                       get_unaligned_le32(&pt->start_sect));
> -                       info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
> -                       part_set_generic_name(desc, part_num,
> -                                             (char *)info->name);
> -                       /* sprintf(info->type, "%d, pt->sys_ind); */
> -                       strcpy((char *)info->type, "U-Boot");
> -                       info->bootable = get_bootable(pt);
> -                       if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> -                               char str[12];
> -
> -                               sprintf(str, "%08x-%02x", disksig, part_num);
> -                               disk_partition_set_uuid(info, str);
> +                       if (info) {
> +                               if (wdinfo.blksz > DOS_PART_DEFAULT_SECTOR)
> +                                       info->blksz = wdinfo.blksz;
> +                               else
> +                                       info->blksz = DOS_PART_DEFAULT_SECTOR;
> +                               info->start = (lbaint_t)(ext_part_sector +
> +                                                        get_unaligned_le32(&pt->start_sect));
> +                               info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
> +                               part_set_generic_name(desc, part_num,
> +                                                     (char *)info->name);
> +                               /* sprintf(info->type, "%d, pt->sys_ind); */
> +                               strcpy((char *)info->type, "U-Boot");
> +                               info->bootable = get_bootable(pt);
> +                               if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
> +                                       char str[12];
> +
> +                                       sprintf(str, "%08x-%02x", disksig, part_num);
> +                                       disk_partition_set_uuid(info, str);
> +                               }
> +                               info->sys_ind = pt->sys_ind;
>                         }
> -                       info->sys_ind = pt->sys_ind;
> +                       if (mbr)
> +                               memcpy(mbr, pt, sizeof(*mbr));
>                         return 0;
>                 }
>
> @@ -296,7 +305,8 @@ static int part_get_info_extended(struct blk_desc *desc,
>
>                         return part_get_info_extended(desc, lba_start,
>                                  ext_part_sector == 0 ? lba_start : relative,
> -                                part_num, which_part, info, disksig);
> +                                                     part_num, which_part, info,
> +                                                     mbr, disksig);
>                 }
>         }
>
> @@ -328,7 +338,13 @@ static void __maybe_unused part_print_dos(struct blk_desc *desc)
>  static int __maybe_unused part_get_info_dos(struct blk_desc *desc, int part,
>                                             struct disk_partition *info)
>  {
> -       return part_get_info_extended(desc, 0, 0, 1, part, info, 0);
> +       return part_get_info_extended(desc, 0, 0, 1, part, info, NULL, 0);
> +}
> +
> +int __maybe_unused part_get_mbr(struct blk_desc *desc, int part,
> +                               dos_partition_t *mbr)
> +{
> +       return part_get_info_extended(desc, 0, 0, 1, part, NULL, mbr, 0);
>  }
>
>  int is_valid_dos_buf(void *buf)
> diff --git a/include/part.h b/include/part.h
> index daebbbc2e68f..aed089d00f64 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -704,6 +704,20 @@ int write_mbr_partitions(struct blk_desc *dev,
>  int layout_mbr_partitions(struct disk_partition *p, int count,
>                           lbaint_t total_sectors);
>
> +/**
> + * part_get_mbr() - get the MBR partition record of a partition
> + *
> + * This function reads the MBR partition record for a given block
> + * device and partition number.
> + *
> + * @desc:      block device descriptor
> + * @part:      partition number for which to return the partition record
> + * @mbr:       MBR partition record
> + *
> + * Return:     0 on success, otherwise error
> + */
> +int part_get_mbr(struct blk_desc *desc, int part, dos_partition_t *mbr);
> +
>  #endif
>
>  #if CONFIG_IS_ENABLED(PARTITIONS)
> --
> 2.53.0
>
