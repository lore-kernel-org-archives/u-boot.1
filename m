Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F0C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:21:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1363C87776;
	Thu, 11 Jan 2024 11:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cFHw9OHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA4087613; Thu, 11 Jan 2024 11:21:03 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB0A87776
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbe344a6cf4so4272438276.0
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 02:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704968459; x=1705573259;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4RvWDvWT+B6QRxyuRtL3Vvsf5OIJSxxkFHVPFFPjYw=;
 b=cFHw9OHavF2wV/nWzjdZ5i+EtqgZpEAzdIaXJO+8ducaaMcu3L/T4pfRL6WDvy8sNW
 pSvP7LrntpWHUKmmZyi+piD2vxhEY4q0+unH6EFS/69QsRTXkFvMDkO/V/GiOqWh8bhx
 Wg4HqB6/9BPhFgzpEViRnPATtaJRyLqs2YHFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704968459; x=1705573259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4RvWDvWT+B6QRxyuRtL3Vvsf5OIJSxxkFHVPFFPjYw=;
 b=YD129Xcst78lCz4Mx6ItuX/hSw6497yzccZWVfZjOVqYFbX8u71sjJurXKywQCukjj
 Xb2fEJrzzLKqRWfZbNK5NxbFaUP4Yyo5q2e4Aaa1FuQUEfi1I0/4S1BvPrKg8mAwBWZO
 aJa1mXQf0hJ02nJ3+5eOhH4DPetSEK3eX1lmpj/jLfgWxQZ9RhDfC4g3R2Ddm730erbk
 o+e8VTvGyBa7UTrlHK0Aa7z2DBsiJ62p62L7FHjIPc8jTpG+LNMY/1VPW0BtSeqxG7Jy
 OyDenc+J+R+fMblIKUa4sIM1AhYtufno6/cwUbwK45OxW6bUOePH5pOTVu2vUKyFTHwr
 AB3g==
X-Gm-Message-State: AOJu0YyyT9+FV6hFoGSVqLvQ9Gs8ty8nxr3gHYg1xhVTcGAf5sSdI0fP
 ORQXx5PZvJRJVd4k94BpXCJAxMp+b6oroGGrB0iEKdXiQkAOdw==
X-Google-Smtp-Source: AGHT+IHYS75gA/GM7R0mynVo30+qobBtSON/Jm/PoD1fyRuTZKe6KFrhL1JdIRySMlbg1OPGsstjzYgXIBdMSbGx/9Y=
X-Received: by 2002:a05:6902:218a:b0:dbc:ceab:4c1c with SMTP id
 dl10-20020a056902218a00b00dbcceab4c1cmr993226ybb.7.1704968459518; Thu, 11 Jan
 2024 02:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20230718085736.17337-1-n-jain1@ti.com>
In-Reply-To: <20230718085736.17337-1-n-jain1@ti.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 11 Jan 2024 15:50:48 +0530
Message-ID: <CAMty3ZBPuYFwQTFT9JwwETGdLSvz1i6NvYFsTcv0SV1iVOjQYQ@mail.gmail.com>
Subject: Re: [PATCH V6 00/10] Update SPL splashscreen framework for AM62x
To: Nikhil M Jain <n-jain1@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, devarsht@ti.com, vigneshr@ti.com,
 nsekhar@ti.com, sjg@chromium.org, samuel@dionne-riel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Nikhil,

On Tue, Jul 18, 2023 at 2:27=E2=80=AFPM Nikhil M Jain <n-jain1@ti.com> wrot=
e:
>
> This patch series aims at updating SPL splashscreen framework for AM62x.
>
> This patch series depends on
> https://lore.kernel.org/u-boot/20230504225829.2537050-1-sjg@chromium.org/
>
> This series:
> - Fixes compilation issues in case splash related configs are not
>   defined in SPL.
> - Does page table setup, dram initialisation and dcache enabling in
>   one function call spl_enable_dcache.
> - Allows passing of framebuffer from spl to u-boot, eliminating flicker.
>
> V6:
> - Add patch [1] from Samuel Dionne-Riel fixing CMD_BMP/BMP dependecy.
>
> V5:
> - Change A53 SPL DDR layout from ASCII table to tabular format.
>
> V4:
> - Fix commit message.
> - Introduce patch defining DDR layout in A53 SPL.
> - Add Reviewed-by tags.
>
> V3:
> - Fix spacing issues.
> - Add Reviewed-by tag.
> - Replace #if with if in patch
>   common: spl: spl: Remove video driver
> - Add link to updated memory map.
>
> V2:
> - Update cover letter.
> - Fix commit message.
>
> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20230709231810.6330=
44-1-samuel@dionne-riel.com/
>
> Nikhil M Jain (9):
>   common: spl: spl: Update stack pointer address
>   arch: arm: mach-k3: common: Return a pointer after setting page table
>   board: ti: am62x: evm: Update function calls for splash screen
>   include: video: Reserve video using blob
>   common: board_f: Pass frame buffer info from SPL to u-boot
>   drivers: video: Kconfig: Add config remove video
>   common: spl: spl: Remove video driver
>   configs: am62x_evm_a53: Add bloblist address
>   doc: board: ti: am62x_sk: Add A53 SPL DDR layout
>
> Samuel Dionne-Riel (1):
>   common: Kconfig: Fix CMD_BMP/BMP dependency

I'm trying to use this to print splash in SPL. Look like the SPL video
is not initialized in a general way like U-Boot proper does via
board_f.c  in reserve_video() correct? do you have your board code to
initialize the video for SPL?

Jagan.
