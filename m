Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DFC02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77855800B6;
	Mon, 20 Jan 2025 10:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNqMdzWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7F1801CF; Mon, 20 Jan 2025 10:10:52 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2FA80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4aff620b232so1159518137.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 01:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737364249; x=1737969049; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMcE+9H1+rIxQoz3IT3Lr59bUKFVWxWtXb3nB0/XuRg=;
 b=NNqMdzWdYwwFJwxnMhMi3v9WSTEhwc4hUJFbY1m+WPaFai3Ux3yMN2sExePs4990dz
 u9drbBxPehSC9yn1pyrcnJvcepLj4noJy3zQ9tRnlZ3ZvJfs2VwViFWAV09wWITuoHyi
 ZVZTvb2i6p0xv/1jo8xEhdMokmo0DsZYvlr7tgNeBmngpm9UCpylKMTMzuYKNXKo0DFw
 tqdApIjsCmRECAivkHWjtOvy8Cs7pjprcKeHJRGp0xYexoiSwjgrZ3Igz8mRfjXOQ3F1
 YcI+0oCNzGWJbsQVXGmE+SCnLuP0ennDbVME4zOzCoQXQUMdURA28ETT7Od+Ge3Kqgln
 /oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737364249; x=1737969049;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMcE+9H1+rIxQoz3IT3Lr59bUKFVWxWtXb3nB0/XuRg=;
 b=QEm0cAHOuG89D3vY7SQCE1MfnkkVCX9unD3FJAmlo2K/wnS7Y8ZKdmPgeOcyCUmyRz
 NFfTHtnh50pJge1MWi4Z53RICr6pQayYJ1D1BmMqkUfkwW//QIiaCxe5vn3MbTveU3mw
 LTzKTmLVUErKnvCwtyh65EpE2ezNEhjGyymIpl8wIJb5hM2a5mMO9V/AvcJAC8siMRi7
 V4QaVs/TB9ozeeCiwmj8E4OVCV8Dus6VcSarMXJR/pUHE3tJy/0JTDTzIBybnNDPAVeG
 53h/fv9DZamV8yMKYF/mHP6vbx0lcGXWE9DlHV2Z4MVIvxO8D7TmkmIe6Chr4sYn1Exq
 ObLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr8Zv8gqD21LtWb0EO6yc1v+vr0hMH3ypwzBBR/goAZodWinAffqCA8jT6do6OiKpr/ezSPII=@lists.denx.de
X-Gm-Message-State: AOJu0YwIlp+FkQcMWsJASj0Gq0gbsZpxA3rTKftrEzLm0oCsbPGqoUOT
 +2Fnb27XDcNYoZ4ZC3jlKVFKOtst2yApcoUKvAJ76etodogK5OhOXJKiSwP/9s6zkEoJuRPOpYZ
 6CKXEfHsvquE67tqodFA25FrABXBuHFbZZh8ouA==
X-Gm-Gg: ASbGncs2oiTXq+TnqrUrxaZcYrOIdSSFKKcmeIguvOsMoBC47Iym189QDM9WeeFQB8K
 vqadQAvziA2fZq8oebPm8l+WK09n6NCTL1uVM85W0vLNKxBXnJsma
X-Google-Smtp-Source: AGHT+IEpOSNuWO2I0nzIopcJarbQdgAfSgENYMgR3dn6juXJFUvypZE9c8GwxRnOZxueezc0vqX57OSTODncH6WfIzY=
X-Received: by 2002:a05:6102:3f8d:b0:4b6:3d72:5c28 with SMTP id
 ada2fe7eead31-4b690c822c5mr11034918137.18.1737364249078; Mon, 20 Jan 2025
 01:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
In-Reply-To: <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 20 Jan 2025 14:40:38 +0530
X-Gm-Features: AbW1kvYSmZgrGxdWl9hJWQAMF3mKCfe3wgONGDnzTmxee3elnYUsY1NudKmwbTg
Message-ID: <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> wrote:
>
> Hei hei,
>
> Am Tue, Oct 15, 2024 at 09:07:07PM +0530 schrieb Sughosh Ganu:
> > In U-Boot, LMB and EFI are two primary modules who provide memory
> > allocation and reservation API's. Both these modules operate with the
> > same regions of memory for allocations. Use the LMB memory map update
> > event to notify other interested listeners about a change in it's
> > memory map. This can then be used by the other module to keep track of
> > available and used memory.
> >
> > There is no need to send these notifications when the LMB module is
> > being unit-tested. Add a flag to the lmb structure to indicate if the
> > memory map is being used for tests, and suppress sending any
> > notifications when running these unit tests.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V3:
> > * Drop use of is_addr_in_ram() function
> > * Drop use of CONFIG_MEM_MAP_UPDATE_NOTIFY symbol to check if the
> >   notification needs to be sent.
> > * s/lmb_notify/lmb_should_notify
> > * Put a check for EFI_LOADER in the lmb_should_notify() function
>
> This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy for
> me.  In a usual non-debug build, everything is fine.  However in a
> debug build now I get this error:
>
>       UPD     include/generated/timestamp_autogenerated.h
>       GEN     Makefile
>       Using /mnt/data/adahl/src/u-boot as source for U-Boot
>       CC      common/version.o
>       AR      common/built-in.o
>       LD      u-boot
>     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
>     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined reference to `efi=
_add_memory_map_pg'

Can you share the details of the toolchain that you are using, where
can I download it from. And the target that you build which shows this
up. Thanks.

-sughosh

>
> My tree is based on v2025.01 release.  lib/lmb.c is built because =E2=80=
=A6
>
>   =E2=94=82   Selected by [y]:
>   =E2=94=82   - SYS_BOOT_RAMDISK_HIGH [=3Dy] && (CMD_BOOTM [=3Dy] || CMD_=
BOOTI [=3Dn] || CMD_BOOTZ [=3Dy]) && !NIOS2 [=3Dn] && !SANDBOX [=3Dn] && !S=
H [=3Dn] && !XTENSA [=3Dn]
>   =E2=94=82   Selected by [n]:
>   =E2=94=82   - EFI_LOADER [=3Dn] && OF_LIBFDT [=3Dy] && (ARM [=3Dy] && (=
SYS_CPU [=3Darm926ejs]=3Darm1136 || SYS_CPU [=3Darm926ejs]=3Darm1176 || =E2=
=80=A6
>
> So as you can see EFI_LOADER is disabled, because I don't need to run
> UEFI applications on my armv5te SoC (Microchip sam9x60).
> CMD_BOOTZ is enabled, because I boot a Linux kernel.
>
> I can not enable EFI_LOADER however, because there's nothing in the
> long list of "depends on" which is or can be satified on my target.
>
> I would really appreciate to be able to use a debug build again,
> please advice!
>
> Greets
> Alex
>
