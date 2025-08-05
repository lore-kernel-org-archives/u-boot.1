Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F587C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 10:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E3D835B0;
	Tue,  5 Aug 2025 12:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O8f1NiOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EAC835B2; Tue,  5 Aug 2025 12:51:45 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E80835AA
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 12:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7e806613af8so165827085a.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754391102; x=1754995902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMiF/iWsFZ90JX8NsaZgVOBCvWpmag7dWYlk/uSEXuo=;
 b=O8f1NiOsZIadwJjZvRrlQrQjKwPmuPWAveJTS5+7E4j7WCD03JBTY5QXCTFe0DaJHm
 LidhjEtGxcg4PifEUJEidAE1lw5JVq8qJ70fVH/AfedrSzvZLDwk8WcG8Jablva7gRFn
 WG5m7+vSlOnqEny9oLTkcQdlfIcGTDNzrgq/IqbG2rQN0w462kY7RoNM5YtkOaaR5ryJ
 Kju+qnRkgKWo6Uleb5C7IO4ZabCY6Mj33ORaiYcinFxs8ngE8qoUtyaLn5oaG48UTLJq
 QSIDuPJRsDPfX/z5iwvYr5lgQ8UWXLFW9wa6BQUdcEblSIxcsZVJpN0USpm04sJem82j
 T8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754391102; x=1754995902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMiF/iWsFZ90JX8NsaZgVOBCvWpmag7dWYlk/uSEXuo=;
 b=UfPZofL7eI/6BZlj873W9WCmE6VJo5GKJwsz3J1YgyV2nrlwuihxwOQrSHRfkyosLT
 nGXktEXK0PXrD79lucBidvlIifTEUbgf7o1EulE8cSxuoXmFQSDd50dotktrMA5WE2so
 +zbdF/y+D/WSABpFDwxjd9anDN60vP2CWmbwCizf1ndC33LWRCqxn08OOEYKKvGKN/xs
 b6zCHSZLUJm45nsiKdVeEf5oBWb2vcNKzV0bXD/8rcYVDvs1eMJJZjTu4vnpW9D/AAZp
 rA7fiDGCFitCP4/uvd2TrJpjpKiDk6vcuVnk7nfbibFiSzhU2V9GLuBizst9l7rNacwu
 QGrA==
X-Gm-Message-State: AOJu0YyJt8X2kk1KU66X0Ua4OjxUntwJATGhYtBcBW2dNze8h8mlRbSd
 mLWFq7NJQGsAc7b2YKoI7nHRINABwrBXbd9cVVlcJZtk1xuQeWUOq6nPbswJC5hZO+9LYS7A3FU
 w/K2WtryHNhy853+7HSOJNnfPT9HFS8PO7ug48RSSAw==
X-Gm-Gg: ASbGncumPRAhljmzNrzkRQhwyE/TiF1KB8tVXCtrGQATcfW1v5aZ4Q3gjkFQBYKy16E
 srKsJG43NppQhbhBDnVaat64LeuPVINKVyEFxneFI3LZn7Po5Dq1R/nnjQL0EyOiLUG0QhpeJgY
 rVZe32UEIQh0ngcOvVe/TOm15WFl3ZX4HUfC24SzSq9fMkQoyK2H7qwVTgUWx42TvCoAAx4hGcy
 k9hfgrI6Enaml7vafI=
X-Google-Smtp-Source: AGHT+IGgxmreapNHE/qLn40Ohfi+Eojo0iWX8FL2bos8w/L/HyYyZPrMGBPQWO+kUX0WRudI8N0eoqT+cTXUc1tACJ0=
X-Received: by 2002:a05:620a:1990:b0:7e8:74d:fdf5 with SMTP id
 af79cd13be357-7e8074e02cemr684434885a.4.1754391101600; Tue, 05 Aug 2025
 03:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 5 Aug 2025 16:21:30 +0530
X-Gm-Features: Ac12FXwKZI8rpvZY_JcjbVibYJLfryURdkrFGEsOuNY3yUCEtUn7NnCdgkP1HqA
Message-ID: <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
Subject: Re: [RFC 0/1] use lmb to calculate ram left for the kernel
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
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

On Tue, 5 Aug 2025 at 15:11, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>
> Hi all,
>
> We recently updated from 2024.01 to 2025.07 and the changes in the lmb lib
> required us to add some custom code to it.
>
> I would like to ask for your opinion on if we are overcomplicating this or if
> it would make sense to add this functionality to it.
>
> We have a booting mode in which we load a root filesystem in the memory and use
> it to emulate an mtd device.
>
> For this, we were using the lmb library to calculate how much ram was left for
> the kernel, based on the size of the rootfs and other reserved regions.
>
> In the 2024 version the lmb library was working with user lmb tables, so we
> were able to create it, initialize it and then do the calculations there
> without any of the tftp allocs bothering us.
>
> We were just allocating a part of the memory for the rootfs and then using
> `lmb_get_free_size` at the start of the memory to get the kernel memory.
>
> After the update, the table is globally shared, so now there's regions of
> memory allocated by tftpboot (but with no flags).
>
> To work around this, we copied the `lmb_get_free_size` and created
> `lmb_get_reservable_size`, which is the same except it counts as free any
> contiguous memory regions with no flags (see patch).
>
> The functionality could also be extracted to be in a generic function that
> takes 'allowed' flags as an argument.

Do you know what would be the size of memory that the kernel would be
occupying? If you do, the memory allocation API, lmb_alloc_mem() can
be used instead. This function will ensure that the memory returned
will not be overlapping with any other memory in use.

-sughosh

>
> Our platform is armv8, our lmb table looks like this at boot time:
>
> ```
> reserved[0]       [0x83000000-0x83a9afff], 0xa9b000 bytes, flags: none
> reserved[1]       [0x90000000-0x9077e417], 0x77e418 bytes, flags: none
> reserved[2]       [0x93000000-0x930089d3], 0x89d4 bytes, flags: none
> reserved[3]       [0xf3113180-0xf51fffff], 0x20ece80 bytes, flags: no-overwrite
> reserved[4]       [0xf54fc000-0xf7dfbfff], 0x2900000 bytes, flags: none
> reserved[5]       [0xf7dfe000-0xfbdfffff], 0x4002000 bytes, flags: no-notify, no-overwrite
> ```
> Where  0 to 2 are allocated by tftp, 4 is where the root file system is loaded,
> and 3 and 5 are added during the init of the lmb.
>
> Is there a better way to calculate the available memory for the kernel that we
> might be missing?
>
> Would it otherwise make sense to update the lmb library to cover this usecase?
>
> Tomas Alvarez Vanoli (1):
>   lib: lmb: add lmb_get_reservable_size, fix ramfs
>
>  board/keymile/common/common.c | 10 ++++++++--
>  include/lmb.h                 |  1 +
>  lib/lmb.c                     | 31 +++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 2 deletions(-)
>
> --
> 2.43.0
>
