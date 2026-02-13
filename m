Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113C1EF48ED
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733F083015;
	Fri, 13 Feb 2026 09:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzoMnOWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6F183B30; Fri, 13 Feb 2026 09:43:10 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE49B80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64aea64bf15so693709d50.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972186; cv=none;
 d=google.com; s=arc-20240605;
 b=Zc2hRXWTOtfWGXpQq2SxZYv/CUCz2rD1XqezG08EqIP7aFU4FPZ8MPCGwidLtWB6Qs
 bBXpss2hyo90Ag47TN/d3KOiK5aSHgl8qJAjfGrKEmZM5RPhQvNNUP4AccdJ+Tg/kQe3
 F5ggD+SH7hjs84jBbQHMqTRCHc2hsNBsmWs1c0UIEErgoR1qd5mu9Snd3XJXEVPH/tOr
 QoXp+S5L6bDf6PdE199pOkbeGgEE3izT3zeO86d4nzwG/Y4Fcj/SwoX9ZIjjl93f1PLf
 UdDSdJnx6NjCHoygU8giMmHIKJ3XrUZssDTcDmbi/BopLRR0FQ+7EfqSD7M1lTm2IHNo
 lTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oyY5Brbhs0vppJCvvigT0scLQqs5R9UXcijozdTx6zQ=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=CjF1ifTv0opHhVcoS8c2Rd2843WHm7F5GGqXzIU7OwKXIeNP5ws5jGEwAWp9T2iv4+
 z54IFWQ9gwYSs3Pat7zJMMiChkYwtvrutuJKsedNsaDdJYOtCYxi3binaKkTJGQSLj/n
 a7/bAI/0szdrl99yz1KcAlN3xZQYj4/p2rMukTVVR44d0ndY9JoNMm+tly+nAzV4B3Ar
 1qpdeDonhLRrhOm5z6jv3mFWghINf1YsVt2fD3PLY4TYlb74AZU41khiDXCTAtAfKFdu
 k9VgkZPzssAMCA+Fbuvv9bGHAdrWnMY+E7ZIpnyzb9H6l+szNsoG5gPud+Ntr6KB5051
 Zodg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770972186; x=1771576986; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oyY5Brbhs0vppJCvvigT0scLQqs5R9UXcijozdTx6zQ=;
 b=nzoMnOWkLJ+0nY0o3AbnLGl7/DXZvpabe5daJdN8+RHxrM6OIjUyzZlOIQULPxsE6W
 5582aReZoudqYGIN+7T6R5zHOEkoNyrVQ9Abd3uaVQYKcqVkdk/zxJSDgOOXrxUwoeak
 kZV5+jqRnbo9+Z9N2IczjVH0chqyz8ITvHXYd4OJk/Sb92RZmPPSlRJI2jmAuxlc1Iz3
 fsmx0w1aHUA1PbSj2Z5THFNSAQqdh+wsXgNdvWruiMkOrK8Hl9nUyJm/W/GaVHk26Jmt
 fYymR0XZ53Oy4LsEwyp3QaFMC4fmAC4W8SZpvavCEs6B6xD7wlzkCmuAmDQtrt+fHgoW
 l7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972186; x=1771576986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyY5Brbhs0vppJCvvigT0scLQqs5R9UXcijozdTx6zQ=;
 b=jIoeW2bHhpUBN6byJkwvjEH7XSyUnUi2QS729mcJUN517QR808uP+hJQCW3xJ/96wj
 cjK7JBXRWvS1Hu8x2e6WDaClYfEe5htJdOajCit6nTw7z8O+XyN0u0ZXBigxNz0KlWLK
 iY1cY+/dG1ZpggpDPNHu6ukJ48CgnWkkqOFNfgbGAfdC8Ijw/X+Uovlxn55M9H10qHoT
 OtzZJLyX2/kKbaY46RxOVcmlouqwDSJ6ba8JMI98++OJ7O6ZO/InwG8E8Ss5giEvX/2J
 MAWR/s8HPIB+T94Rznj+oAf4xWIZBZAGRddDtqdNuP59yb3TpnAnxeEgTpWGtVh+4uZN
 qEqQ==
X-Gm-Message-State: AOJu0YyPxLNv06PyXif8R5QNOOkClGpY9vs22evMyH6M0J4yWFb1PzGM
 7/07k0LqleaxXu8/wxZXePlAGOaM7h128K8rwBKs81ZmP2E7QylYuDIs7B9CE4mmWKJrBchtDl3
 CcM0k550qmIDaO0gJ9QKusAsxN0emeTZs05eBZd7lcg==
X-Gm-Gg: AZuq6aLUbPDgFG/mEXEPoIDrt7PlcoLjpphp84QBbP/Tp50PsVIz7cTWL1izW6vuM+f
 pLBvQ7w/ZhytpnSVBP77CQDVP3aq3yw8CIuxqkasqixzqR0wNvE6vNAaA73elvZb/XzeAHZf5vE
 /Iw9SR5hQiz/zpS/eUJAqk0WskYZxTbMSCrC8zv679yA7w4pkqUowUz+tmXeEG6r9nVx8LUpLyC
 Lrsw86oDensWCZ2GewBaqUAi4AGH/M61I49jcIN4yJ8yzC2oghy2aAFpgbjigctmKreq4cqTte4
 sKrAZwOlbKfkTVOm51lOgjfb6mz/2ww/NyLkrFXUTyS+SHES9e04DdT9ixfygchAfu9AEDBc3FA
 6ojKHy1IAFpW3H8gH9LuCdMqpGGVX7k6oof7XUwhmaiqsGx9LncHLFxM6jKg/Vb31fKHT0OHVzf
 kz5FCl7FdDfJA7ZWVAJhFgi/3cA7FPEjVVdulTCmziIY29+KQ74+4dKXFEJRZBzaos37yxMrYa9
 k+L/t3W3alTzuGEHbkvaunlRSDEVGgZSXtrcG+8HGsmo2twLjU1rpW8hf9cXDtxk7a9CKoxoCcV
 gmZxKFy7rNl+DXOICgaF+5Ggzdluxv5TrFVimMx1cDv/4eCFkjk0C5s=
X-Received: by 2002:a05:690c:9990:b0:796:26af:612a with SMTP id
 00721157ae682-797a0bc2596mr17780907b3.10.1770972185575; Fri, 13 Feb 2026
 00:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-4-javierm@redhat.com>
In-Reply-To: <20260212204511.619392-4-javierm@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 10:42:29 +0200
X-Gm-Features: AZwV_QhBe2Wp-zdaq-9kmREGuUF6MA9lWqrp1kcf-mssAEnndwmiVNna452KgHk
Message-ID: <CAC_iWjJrpsiBiUmKLQhzWKmq7x8GJo4a2NxWUf8aafNeJWKZYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] disk: part_efi: Remove redundant struct partition
 definition
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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
> Now that dos_partition_t and struct partition are identical, the duplicated
> data structure definition in the part_efi.h header can just be removed.
>
> This results in a single, shared definition for MBR partition table
> entries, instead of having the same definition in two different places.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> (no changes since v1)
>
>  disk/part_efi.c    |  4 ++--
>  include/part_efi.h | 19 +++----------------
>  2 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index fb1ed534f861..d8b17ec2e91a 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -51,7 +51,7 @@ static inline u32 efi_crc32(const void *buf, u32 len)
>   * Private function prototypes
>   */
>
> -static int pmbr_part_valid(struct partition *part);
> +static int pmbr_part_valid(dos_partition_t *part);
>  static int is_pmbr_valid(legacy_mbr * mbr);
>  static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
>                         gpt_entry **pgpt_pte);
> @@ -990,7 +990,7 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
>   *
>   * Returns: 1 if EFI GPT partition type is found.
>   */
> -static int pmbr_part_valid(struct partition *part)
> +static int pmbr_part_valid(dos_partition_t *part)
>  {
>         if (part->sys_ind == EFI_PMBR_OSTYPE_EFI_GPT &&
>                 get_unaligned_le32(&part->start_sect) == 1UL) {
> diff --git a/include/part_efi.h b/include/part_efi.h
> index fb402df6f13e..2cea50880465 100644
> --- a/include/part_efi.h
> +++ b/include/part_efi.h
> @@ -18,6 +18,7 @@
>  #define _DISK_PART_EFI_H
>
>  #include <efi.h>
> +#include <part_dos.h>
>
>  #define MSDOS_MBR_SIGNATURE 0xAA55
>  #define MSDOS_MBR_BOOT_CODE_SIZE 440
> @@ -77,20 +78,6 @@
>  /* linux/include/efi.h */
>  typedef u16 efi_char16_t;
>
> -/* based on linux/include/genhd.h */
> -struct partition {
> -       u8 boot_ind;            /* 0x80 - active */
> -       u8 head;                /* starting head */
> -       u8 sector;              /* starting sector */
> -       u8 cyl;                 /* starting cylinder */
> -       u8 sys_ind;             /* What partition type */
> -       u8 end_head;            /* end head */
> -       u8 end_sector;          /* end sector */
> -       u8 end_cyl;             /* end cylinder */
> -       __le32 start_sect;      /* starting sector counting from 0 */
> -       __le32 nr_sects;        /* nr of sectors in partition */
> -} __packed;
> -
>  /* based on linux/fs/partitions/efi.h */
>  typedef struct _gpt_header {
>         __le64 signature;
> @@ -134,7 +121,7 @@ typedef struct _legacy_mbr {
>         u8 boot_code[MSDOS_MBR_BOOT_CODE_SIZE];
>         __le32 unique_mbr_signature;
>         __le16 unknown;
> -       struct partition partition_record[4];
> +       dos_partition_t partition_record[4];
>         __le16 signature;
>  } __packed legacy_mbr;
>
> @@ -153,7 +140,7 @@ struct efi_partition_info {
>         u8 system;
>         u8 reserved[7];
>         union {
> -               struct partition mbr;
> +               dos_partition_t mbr;
>                 gpt_entry gpt;
>         } info;
>  } __packed;
> --
> 2.53.0
>
