Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425C4C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3AAF86548;
	Mon, 28 Aug 2023 19:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZYa9ODqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD5A86522; Mon, 28 Aug 2023 19:56:05 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA1386523
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7260fae148so3464135276.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ4WXlhgwRfTt+zrn4tAaN8rIjHqGVJgHb0Do6wB9Ws=;
 b=ZYa9ODqcdHl4rynpTTPjiup8On7q/0C9ve2n/SG6OROxzu0XD7uiT2VzEJyGEB8D/n
 qbNoH+/FjXEk3T2OPejzAN5XJm79MSAYcLLYyDsvZEtsv04YoEjAONpuqGnvFW0x9G2t
 AjhHwKWVOpsR5iuz9A81ri7Scb5xD/Wbuck2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJ4WXlhgwRfTt+zrn4tAaN8rIjHqGVJgHb0Do6wB9Ws=;
 b=f56KeDMa/sWqadeSeecTjPXLbQ3mvhB8vk6t0VGbrkz+72r/TOGnkbZYoHyq50laN9
 Mq9RV7sWH0TrhwQCMkOJBfagqnznW7o/X5s275cKJxUZ0ejVdENBStMIe+UwdPIVG1DC
 I6M66mpuDY/KtRcUkKha8+dITqc13OfeST8RxzDozKU1nj36CvKEYdymX05qks8UMOi9
 afCS5gDmuNLOiBubRk25bHx2/I5UqxmTBAShayJTkcXqkSyhfyyBPZTA2PTUe0GAZvYz
 MOtaoVJCRS/vE3zJRVraDI8oELku++oRfc0OMU993UBIJwZHLGX8P9tcNENtvAit2ilm
 y3lg==
X-Gm-Message-State: AOJu0Yxkpxx54wWoR/TUcMb99yREaYzCR/PYObXRNt0j4d41uVoClexT
 MUzPrOIBTrd/rRYuz1pao7mh2Yc/HWuBryLhfSQiHg==
X-Google-Smtp-Source: AGHT+IEcuMn3TvZDVRT0BCcU5+Ru+8SD9Hz373dqbjUnpn2Ra0HKociNlUDeIzJWWoyJNu1vw4NPo3sNMI2DNoWi6Lk=
X-Received: by 2002:a25:a28e:0:b0:d6c:cd45:73b4 with SMTP id
 c14-20020a25a28e000000b00d6ccd4573b4mr24785978ybi.54.1693245356096; Mon, 28
 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230827074324.34978-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230827074324.34978-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:50 -0600
Message-ID: <CAPnjgZ2xV0F6tqQDYFUC7jeC2T1_xap0rdEwnyMjYyTfNXaV1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: gpt: fix gpt read
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 27 Aug 2023 at 01:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> To partition a block device the partition type GUIDs are needed but 'gpt
> read' does not provide these. Add the missing parts.
>
> Part of gpt.c has been written to work with CONFIG_PARTITION_UUIDS=n. But
> when reading the disk information this is not considered. Currently we let
> CONFIG_CMD_GPT select CONFIG_PARTITION_UUIDS but we should enable dropping
> this requirement.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/gpt.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 964056bd28..d5d525397f 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -173,7 +173,10 @@ static int calc_parts_list_len(int numparts)
>         /* see part.h for definition of struct disk_partition */
>         partlistlen += numparts * (strlen("start=MiB,") + sizeof(lbaint_t) + 1);
>         partlistlen += numparts * (strlen("size=MiB,") + sizeof(lbaint_t) + 1);
> -       partlistlen += numparts * (strlen("uuid=;") + UUID_STR_LEN + 1);
> +       if (CONFIG_IS_ENABLED(PARTITION_UUIDS))
> +               partlistlen += numparts * (strlen("uuid=,") + UUID_STR_LEN + 1);
> +       if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID))
> +               partlistlen += numparts * (strlen("type=;") + UUID_STR_LEN + 1);
>         /* for the terminating null */
>         partlistlen++;
>         debug("Length of partitions_list is %d for %d partitions\n", partlistlen,
> @@ -217,6 +220,12 @@ static struct disk_part *allocate_disk_part(struct disk_partition *info,
>         /* UUID_STR_LEN is correct, as uuid[]'s length is UUID_STR_LEN+1 chars */
>         newpart->gpt_part_info.uuid[UUID_STR_LEN] = '\0';
>  #endif
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +       strncpy(newpart->gpt_part_info.type_guid, (const char *)info->type_guid,
> +               UUID_STR_LEN);
> +       newpart->gpt_part_info.type_guid[UUID_STR_LEN] = '\0';
> +#endif
> +
>         newpart->partnum = partnum;
>
>         return newpart;
> @@ -254,6 +263,9 @@ static void print_gpt_info(void)
>                        curr->gpt_part_info.bootable & PART_BOOTABLE);
>  #ifdef CONFIG_PARTITION_UUIDS
>                 printf("UUID %s\n", curr->gpt_part_info.uuid);
> +#endif
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +               printf("Type GUID %s\n", curr->gpt_part_info.type_guid);
>  #endif
>                 printf("\n");
>         }
> @@ -298,10 +310,16 @@ static int create_gpt_partitions_list(int numparts, const char *guid,
>                         (unsigned long long)curr->gpt_part_info.size *
>                                             curr->gpt_part_info.blksz);
>                 strncat(partitions_list, partstr, PART_NAME_LEN + 1);
> -
> +#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
>                 strcat(partitions_list, ",uuid=");
>                 strncat(partitions_list, curr->gpt_part_info.uuid,
>                         UUID_STR_LEN + 1);
> +#endif
> +#ifdef CONFIG_PARTITION_TYPE_GUID
> +               strcat(partitions_list, ",type=");
> +               strncat(partitions_list, curr->gpt_part_info.type_guid,
> +                       UUID_STR_LEN + 1);
> +#endif

Can you please remove the #ifdefs ? We have accessors for this now in
part.h in -next


>                 strcat(partitions_list, ";");
>         }
>         return 0;
> --
> 2.40.1
>

Regards,
Simon
