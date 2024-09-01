Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C1BC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D3B88BF9;
	Sun,  1 Sep 2024 22:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XQZUGBVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5702F88A7F; Sun,  1 Sep 2024 22:10:31 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F169D88C3F
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d88690837eso1308346a91.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221427; x=1725826227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4yBZpr8mtfrvaoNWjr6BxYtF4eh9F3pBTiEYpMrLho=;
 b=XQZUGBViKoJMl38u++lgZXtTeF7VtDDeA2BsMmu1dSzx6w289TcvBGFTja7mDLHdqC
 bn/eMj2LZ+dRKB96lGZpM/5EZmA/Cc70ePB+KybwaNunsOdDc4573wgudacCIk+D/ZPB
 3gOOt0EaVLw9bTBrWmHpQ/gtB7RGdbkhh0Uvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221427; x=1725826227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4yBZpr8mtfrvaoNWjr6BxYtF4eh9F3pBTiEYpMrLho=;
 b=T99hsryMdM04YMvdYCCNTxieKl7Hd08SdAbU6N0tP+KhbsxvBAxqxQw8RQKsuPIqg/
 c7kLABKjCBg6AJJXiAcdRUOADSfjji9B0yY73CvAy9tjbvboBHnP8oL4Hb0By4kkgAfA
 28XItgv3lobhUoa4+comKFrHmfiAtT7bZymnk17nfRDw3m3JnrQgPzHuupgAKiHYsFSR
 pimpJGEUxgz5m09+1vl+iJYk6Fq7uO/QVzp9+SbfW6gojM3w6GGw8agFmFMIoVlzOOyT
 c9x+h+n2xVZ1DOrY6nvQOfM/cKO6YvsRJWSLCNE4dnp8pD0uWIxe9o5zLS9Z5W+6vqby
 sf8w==
X-Gm-Message-State: AOJu0YzzrTpAYuxr9r4Aa4/Ag6LrS//EXmIGMVLDWkOWDb3g/KKhbB8h
 ZXb5+OacrYxVtdYQxwIatvcvP7c4l3Sr5X9VBh5G/68CXe5gEfByi1jOkQrB9RQe1W/ToGbjlzf
 SOt0VexuNALeq1qK3V2+wSvcdkvWNyp+eE74vtZ6nOzVLT/8=
X-Google-Smtp-Source: AGHT+IEZUTKk6SkUhGqgvPGc0RMHb6aBZFMJmYfeas5oAZ6TxixGZVXJeNT+mWgL7+F3SshGIYJ4XKP51O5/8gfVVjc=
X-Received: by 2002:a17:903:2a85:b0:1fd:9a23:90cc with SMTP id
 d9443c01a7336-2050c34c67dmr130460625ad.26.1725221427471; Sun, 01 Sep 2024
 13:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <2p9.Zbg}.7NiPNKVgoiP.1cr7Cm@seznam.cz>
In-Reply-To: <2p9.Zbg}.7NiPNKVgoiP.1cr7Cm@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:07 -0600
Message-ID: <CAFLszTh=k5mA-uK_RooPdB8uEQpukUk+npaoLWaTskDbCoa-KQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: Allow using partition name in mmc erase command
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

Hi Tomas,

On Sun, 1 Sept 2024 at 07:59, Tomas Paukrt <tomaspaukrt@email.cz> wrote:
>
> The mmc erase command currently requires blk# and cnt parameters
> which can be obtained using the part command if the entire partition
> needs to be deleted.
>
> Simplify the use of the mmc erase command by allowing the partition
> name to be specified directly.
>
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  cmd/mmc.c             | 21 ++++++++++++++-------
>  doc/usage/cmd/mmc.rst |  4 +++-
>  2 files changed, 17 insertions(+), 8 deletions(-)
>

Does doc/usage/cmd/mmc.rst need an update too?

> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 7244a90..ba2f506 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -472,18 +472,25 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int flag,
>                         int argc, char *const argv[])
>  {
>         struct mmc *mmc;
> +       struct disk_partition info;
>         u32 blk, cnt, n;
>
> -       if (argc != 3)
> -               return CMD_RET_USAGE;
> -
> -       blk = hextoul(argv[1], NULL);
> -       cnt = hextoul(argv[2], NULL);
> -
>         mmc = init_mmc_device(curr_device, false);
>         if (!mmc)
>                 return CMD_RET_FAILURE;
>
> +       if (argc == 2) {
> +               if (part_get_info_by_name(mmc_get_blk_desc(mmc), argv[1], &info) < 0)
> +                       return CMD_RET_FAILURE;
> +               blk = info.start;
> +               cnt = info.size & ~(mmc->erase_grp_size - 1);
> +       } else if (argc == 3) {
> +               blk = hextoul(argv[1], NULL);
> +               cnt = hextoul(argv[2], NULL);
> +       } else {
> +               return CMD_RET_USAGE;
> +       }
> +
>         printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
>                curr_device, blk, cnt);
>
> @@ -1270,7 +1277,7 @@ U_BOOT_CMD(
>  #if CONFIG_IS_ENABLED(CMD_MMC_SWRITE)
>         "mmc swrite addr blk#\n"
>  #endif
> -       "mmc erase blk# cnt\n"
> +       "mmc erase blk# cnt | partname\n"
>         "mmc rescan [mode]\n"
>         "mmc part - lists available partition on current mmc device\n"
>         "mmc dev [dev] [part] [mode] - show or set current mmc device [partition] and set mode\n"
> diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
> index 5a64400..b919b75 100644
> --- a/doc/usage/cmd/mmc.rst
> +++ b/doc/usage/cmd/mmc.rst
> @@ -14,7 +14,7 @@ Synopsis
>      mmc info
>      mmc read addr blk# cnt
>      mmc write addr blk# cnt
> -    mmc erase blk# cnt
> +    mmc erase blk# cnt | partname
>      mmc rescan [mode]
>      mmc part
>      mmc dev [dev] [part] [mode]
> @@ -50,6 +50,8 @@ The 'mmc erase' command erases *cnt* blocks on the MMC device starting at block
>          start block offset
>      cnt
>          block count
> +    partname
> +        partition name
>
>  The 'mmc rescan' command scans the available MMC device.
>

Regards,
Simon
