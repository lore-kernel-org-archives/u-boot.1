Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922BC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263BA88C8A;
	Thu, 15 Aug 2024 22:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iEXcoUFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E260188C78; Thu, 15 Aug 2024 22:34:54 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF2888B63
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d3c05dc63eso975568a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754091; x=1724358891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=80oN8aC43iZpqu127zbWKhwroha62cl1Zfk1DUaCldQ=;
 b=iEXcoUFy3wOmmqtxfBPR/+Te5Nu2SgGSCYq9m2+1VHJCKk5jIyQpS61LYKx08zhknf
 pV0GYT5ijF6aVSKooDWY4/7yFRgYCc+utdJncXBKOy/hJU3xt+8RDbB+hQ71hg7e5Amc
 pnIAZkDhDipU7R7b99iFeTmngMAmGp8+L+PSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754091; x=1724358891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=80oN8aC43iZpqu127zbWKhwroha62cl1Zfk1DUaCldQ=;
 b=E0mgyz1Pepi+zf+nhjk6MxjHdCAd0aIjGxfFoccCXpALUWaZO0iXYtdG0Xnwb0PkHz
 gD1z49QpleyZmVterdHHZvw0GUk7/c3RA22xG7oBvq8wN5gZcYakODMPOHWbVhn3EOEV
 56trWd9C7sMpnU1vP03gpWottH5o6i/tAh2GrBhsQYZ4IncwYp58Tj0H8w079+u9hBQC
 9AViTuLO2gLaA70NE24X6GB3IW2jqSrN2HX/mVdwLvWae9uNmP6F5xdXTy5aqsgkhZjo
 KoZmuEyifV1q3UWnEI6fBv95B0k1lObsla5RiZP+co/VvF1obfJi1ZIOiNGdZQCE3J72
 LPpQ==
X-Gm-Message-State: AOJu0YzwwspnopZeuCq7WmvRb6fciMFVNNVnVv2Binhzk4kXcQqylo3y
 s7qLRVUsm/jcejBzIuhEKQZN1iD7vR+wRbeTvq9+XUVyTlEMbr5muno/RmQC9f2UcsKcIKo2rKQ
 9mg9UUUWwCfAxYHy197hzfD/Izv+zJ8ol3yYc
X-Google-Smtp-Source: AGHT+IExaKGn7J5vmG0wTfovPRlnNvBY9bUqVjkGi/oOU9w140ZxOTmWh1/cSnEHx45KhW7hqikZbIxLVgMFcsfyNKI=
X-Received: by 2002:a17:90b:802:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2d3dfc7d183mr938529a91.20.1723754090761; Thu, 15 Aug 2024
 13:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240810205205.3403177-1-sjg@chromium.org>
 <20240810205205.3403177-7-sjg@chromium.org>
 <20240815170108.GU1626301@bill-the-cat>
In-Reply-To: <20240815170108.GU1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:38 +0100
Message-ID: <CAFLszTgThyq1v+zP2z5znvzbZqTMQuNO1fkSP59KJ8BnZyiQEg@mail.gmail.com>
Subject: Re: [PATCH 06/21] mmc: Drop the blank line before accesses
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Tom,

On Thu, 15 Aug 2024 at 18:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Aug 10, 2024 at 02:51:50PM -0600, Simon Glass wrote:
>
> > Several mmc subcommand print a blank line before starting and after
> > finishing. It isn't necessary to do both, so drop the first one.
> >
> > It is questionable whether these command should produce any output at
> > all, but leave it for now.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  cmd/mmc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/cmd/mmc.c b/cmd/mmc.c
> > index 7244a90f4dc..ff7b8e555ba 100644
> > --- a/cmd/mmc.c
> > +++ b/cmd/mmc.c
> > @@ -238,7 +238,7 @@ static int do_mmcrpmb_read(struct cmd_tbl *cmdtp, int flag,
> >       if (argc == 5)
> >               key_addr = (void *)hextoul(argv[4], NULL);
> >
> > -     printf("\nMMC RPMB read: dev # %d, block # %d, count %d ... ",
> > +     printf("MMC RPMB read: dev # %d, block # %d, count %d ... ",
> >              curr_device, blk, cnt);
> >       n =  mmc_rpmb_read(mmc, addr, blk, cnt, key_addr);
> >
> > @@ -265,7 +265,7 @@ static int do_mmcrpmb_write(struct cmd_tbl *cmdtp, int flag,
> >       cnt = hextoul(argv[3], NULL);
> >       key_addr = (void *)hextoul(argv[4], NULL);
> >
> > -     printf("\nMMC RPMB write: dev # %d, block # %d, count %d ... ",
> > +     printf("MMC RPMB write: dev # %d, block # %d, count %d ... ",
> >              curr_device, blk, cnt);
> >       n =  mmc_rpmb_write(mmc, addr, blk, cnt, key_addr);
> >
> > @@ -362,7 +362,7 @@ static int do_mmc_read(struct cmd_tbl *cmdtp, int flag,
> >       if (!mmc)
> >               return CMD_RET_FAILURE;
> >
> > -     printf("\nMMC read: dev # %d, block # %d, count %d ... ",
> > +     printf("MMC read: dev # %d, block # %d, count %d ... ",
> >              curr_device, blk, cnt);
> >
> >       n = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, addr);
> > @@ -411,7 +411,7 @@ static int do_mmc_sparse_write(struct cmd_tbl *cmdtp, int flag,
> >       if (!mmc)
> >               return CMD_RET_FAILURE;
> >
> > -     printf("\nMMC Sparse write: dev # %d, block # %d ... ",
> > +     printf("MMC Sparse write: dev # %d, block # %d ... ",
> >              curr_device, blk);
> >
> >       if (mmc_getwp(mmc) == 1) {
> > @@ -455,7 +455,7 @@ static int do_mmc_write(struct cmd_tbl *cmdtp, int flag,
> >       if (!mmc)
> >               return CMD_RET_FAILURE;
> >
> > -     printf("\nMMC write: dev # %d, block # %d, count %d ... ",
> > +     printf("MMC write: dev # %d, block # %d, count %d ... ",
> >              curr_device, blk, cnt);
> >
> >       if (mmc_getwp(mmc) == 1) {
> > @@ -484,7 +484,7 @@ static int do_mmc_erase(struct cmd_tbl *cmdtp, int flag,
> >       if (!mmc)
> >               return CMD_RET_FAILURE;
> >
> > -     printf("\nMMC erase: dev # %d, block # %d, count %d ... ",
> > +     printf("MMC erase: dev # %d, block # %d, count %d ... ",
> >              curr_device, blk, cnt);
> >
> >       if (mmc_getwp(mmc) == 1) {
>
> Did you confirm things look right still, on hardware?

Yes that's why I decided to drop it. See here for example:

$ ub-int ff3399
Building U-Boot in sourcedir for firefly-rk3399
Bootstrapping U-Boot from dir /tmp/b/firefly-rk3399
Writing U-Boot using method rockchip

U-Boot TPL 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51)
Channel 0: DDR3, 800MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
Channel 1: DDR3, 800MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
256B stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51 -0600)
Trying to boot from MMC2
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
## Checking hash(es) for Image atf-4 ... sha256+ OK
load_simple_fit: Skip load 'atf-5': image size is 0!


U-Boot 2024.10-rc2-00093-gcbaae70baf39 (Aug 15 2024 - 13:27:51 -0600)

SoC: Rockchip rk3399
Reset cause: POR
Model: Firefly-RK3399 Board
DRAM:  4 GiB (effective 3.9 GiB)
PMIC:  RK808
Core:  308 devices, 29 uclasses, devicetree: separate
MMC:   mmc@fe310000: 3, mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... Reading from MMC(1)... *** Warning -
bad CRC, using default environment

In:    serial@ff1a0000
Out:   serial@ff1a0000
Err:   serial@ff1a0000
Model: Firefly-RK3399 Board
Net:   eth0: ethernet@fe300000
Hit any key to stop autoboot:  0
=> mmc read 1000 0 100

MMC read: dev # 0, block # 0, count 256 ... 256 blocks read: OK
=>

With this patch, the blank line above is gone.

BTW, this whole series is marked as needing changes. I've dropped the
wget patches. Should I send it again, or just wait?

Regards,
Simon
