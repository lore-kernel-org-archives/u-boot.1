Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95881C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5572986532;
	Thu, 24 Aug 2023 01:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="k0BtXLll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B7E864FF; Thu, 24 Aug 2023 01:59:23 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC76864FA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d74a012e613so526880276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHhkGHpCp0ncZVBSmNaUInccx3us2PZpvKhomyrKIAk=;
 b=k0BtXLllsBMwd1X1W8cWkVzPBcrbRHbPS7aGAiyV+zMJ/SEGZy87t2Qx8m1xEXZA6I
 yjefHRRBswx2hLk9tJgEriPSX9CZzO+cN62j8eZcCznq33uWgBWF/FCObFcK0bM7Tl0Y
 OOieDlNbJc1LzD9NKaqgWhqxvjwoS+n8ie0p3LA+Q1AfqDK5ALB+0BbEWtxA+9snRGmY
 c+W2iEbxL5J+lYH+v8Qzcrb9/8de2aApLzDf2OT9VDLeaWUsRdvI+YL05pWW2rRAG8cf
 4miAYAsL+TQHNkgSmXqgXBuD7TggpNjfEsFNIC1A6vD6jHNh7+H9dnLbg6PWmYQb9Lai
 56oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHhkGHpCp0ncZVBSmNaUInccx3us2PZpvKhomyrKIAk=;
 b=SdVp0dVV5nYuJXPYV4Z2Bq8OEq19YnIGdjp/2ha6S3TNcuoeim+HcMRuMSatE2tx6F
 M8pAArr0d9wrEoFLzOjPg3QOF4i/amNX08sbYNHvtNAn75r26wgo7gM8RMBPfK5Cn7yz
 1mpO6jzyotT871+3air5ZFwvT2QUgjlN9zHSf20Z8RrVY6asJSDSV18be5bE/kRlg6LD
 TIEHjhgzac35tps4ZMtK/1alITKNyErU1ycxajtqVmDW+KFzuakOOoNuKh67/Zlk4WE3
 2UtCGrgP5UDZ/bUh/blCwa6I3gKivfqQb+NlfAzHJ/TuIaTx37W/l9ear2VfAQ07x/ce
 zjQw==
X-Gm-Message-State: AOJu0YxTjJ7up2FIj4lFlBD6v14BAZTGv9dpP/4a3a+ztHLm+kJ78o3r
 i5v0/OniVWTiq0cKxk9pJShqptnuIFaAItGZQpysuUxEYD3k17TMpIw=
X-Google-Smtp-Source: AGHT+IF0W3xRVyjM3yF3CdjK8tJ1qhtk9f3mK8ASWE7y3jtYbG7jG9PmCXWVFUkif2jyPxcVR7lR4rIhWtBjofnhtAs=
X-Received: by 2002:a25:dc06:0:b0:d71:8786:625d with SMTP id
 y6-20020a25dc06000000b00d718786625dmr15318578ybe.1.1692835156433; Wed, 23 Aug
 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230815162726.1524958-7-JPEWhacker@gmail.com>
In-Reply-To: <20230815162726.1524958-7-JPEWhacker@gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 23 Aug 2023 17:57:51 -0600
Message-ID: <CAPnjgZ0qR-7j2U7kEfHdsdOFjc291BxTn--t_sNuaPsk0do4BQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] cmd: gpt: Add command to swap partition order
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Joshua,

On Tue, 15 Aug 2023 at 10:28, Joshua Watt <jpewhacker@gmail.com> wrote:
>
> Adds a command called "gpt swap-postition" which will swap the order two
> partitions are listed in the GPT partition table (but leaves them
> pointing to the same locations on disk).
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  cmd/gpt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 58564436d3..c8a2b5ae7b 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -859,7 +859,7 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
>         int partlistlen, ret, numparts = 0, partnum, i = 1, ctr1 = 0, ctr2 = 0;
>
>         if ((subcomm == NULL) || (name1 == NULL) || (name2 == NULL) ||
> -           (strcmp(subcomm, "swap") && (strcmp(subcomm, "rename"))))
> +           (strcmp(subcomm, "swap") && strcmp(subcomm, "rename") && strcmp(subcomm, "swap-position")))

While you are here you could tidy this code:

if (!subcomm || !name1 || !name2 ||
...

>                 return -EINVAL;
>
>         ret = get_disk_guid(dev_desc, disk_guid);
> @@ -920,6 +920,48 @@ static int do_rename_gpt_parts(struct blk_desc *dev_desc, char *subcomm,
>                         ret = -EINVAL;
>                         goto out;
>                 }
> +       } else if(!strcmp(subcomm, "swap-position")) {
> +               int idx1, idx2;
> +               struct disk_partition first, second;

blank line

> +               idx1 = simple_strtoul(name1, NULL, 10);
> +               if (idx1 <= 0 || idx1 > numparts) {
> +                       printf("Illegal partition number %s\n", name1);
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +               idx2 = simple_strtoul(name2, NULL, 10);
> +               if (idx2 <= 0 || idx2 > numparts) {
> +                       printf("Illegal partition number %s\n", name2);
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +               if (idx1 == idx2) {
> +                       printf("Cannot swap partition with itself\n");
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               i = 1;
> +               list_for_each(pos, &disk_partitions) {
> +                       curr = list_entry(pos, struct disk_part, list);
> +                       if (i == idx1) {
> +                               first = curr->gpt_part_info;
> +                       } else if (i == idx2) {
> +                               second = curr->gpt_part_info;
> +                       }

Can you please either use patman or manually checkpatch on your
patches? This should not have {}

> +                       i++;
> +               }
> +
> +               i = 1;
> +               list_for_each(pos, &disk_partitions) {
> +                       curr = list_entry(pos, struct disk_part, list);
> +                       if (i == idx1) {
> +                               curr->gpt_part_info = second;
> +                       } else if (i == idx2) {
> +                               curr->gpt_part_info = first;
> +                       }
> +                       i++;
> +               }
>         } else { /* rename */
>                 if (strlen(name2) > PART_NAME_LEN) {
>                         printf("Names longer than %d characters are truncated.\n", PART_NAME_LEN);
> @@ -1122,7 +1164,8 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         } else if (strcmp(argv[1], "read") == 0) {
>                 ret = do_get_gpt_info(blk_dev_desc, (argc == 5) ? argv[4] : NULL);
>         } else if ((strcmp(argv[1], "swap") == 0) ||
> -                  (strcmp(argv[1], "rename") == 0)) {
> +                  (strcmp(argv[1], "rename") == 0) ||
> +                  (strcmp(argv[1], "swap-position") == 0)) {
>                 ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
>  #endif
>         } else if ((strcmp(argv[1], "set-bootable") == 0)) {
> @@ -1175,11 +1218,14 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>         " gpt swap <interface> <dev> <name1> <name2>\n"
>         "    - change all partitions named name1 to name2\n"
>         "      and vice-versa\n"
> +       " gpt swap-position <interface> <dev> <part1> <part2>\n"
> +       "    - Swap the order of name1 with name2 in the partition table\n"
>         " gpt rename <interface> <dev> <part> <name>\n"
>         "    - rename the specified partition\n"
>         " Example usage:\n"
>         " gpt swap mmc 0 foo bar\n"
>         " gpt rename mmc 0 3 foo\n"
> +       " gpt swap-partitions mmc 0 1 2\n"
>  #endif
>         " gpt set-bootable <interface> <dev> <list>\n"
>         "    - make partition names in list bootable\n"
> --
> 2.33.0
>

Regards,
Simon
