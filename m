Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACEAEF584C
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 19:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1027E83C6C;
	Sat, 14 Feb 2026 20:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWx8iglD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D16683AA7; Sat, 14 Feb 2026 20:58:49 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D170983AAB
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 20:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d19d3c7208so1322215a34.0
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 11:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771099125; cv=none;
 d=google.com; s=arc-20240605;
 b=GhovG28cRAQGuWd6iAWO/+4bDH3fDnmG4WVMQypsZ0DOzAj/cLl1rcRfP+sQSIBAot
 nM86mf9iuXnF2AlJDldWOILxc4CHz+aL/cm4qsPWM2vVDElkzX0EI+qwwjEsu2jW4U4k
 ezOwjeS8ClU4uQvVsJSY9m4F22iSTurhv6BnzarglFpWgtENBqCkwsnwTB+fmyFr/DK/
 QBqCx7HLetKBS5xO9vs+0ovZVwRCONaSmz/dciqqUEHloOXHjJ+LFRBHbqnRKUaT9ROO
 eg9q3X5l47SBi8yrStcz9OH0hAV/5BNbvZNkN9+2uu7qmZUvbIUhIpUcaBhnh5Oxi24E
 m+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eRbLJLfOXopnWNLLHqNX3wmCdvMfKgeVKZiXSYJt3rc=;
 fh=no8W33Pn5R5GWWHU2aoiWzfLVa2piAT3KYru3U98z6w=;
 b=jzd4Kql2K/jQ3eWT1fHhBARdF3SxCGHTHJh1ChBOvh9H68V8Jhdi39+aafahYW1bf0
 WBw0J8rGQgiv5QzxahAeiryLreYp4rFp9dYDURZ2mmOp7hjKRRYd5hofUL+eSRVa2uyi
 VoBm5B4uaSv2HQEg0qMjYlNRY8+l6GdI0udYwjm2VqTrp6IO8e7ASw932m79JxeIwX2H
 7scqZ6nz7SD1k63N9lUdxiVCIxRYdHJVcZwMMEvTVY+Y7U6hn0V/7csPfkyYcfHnUt0/
 V6wwS4P1NxP0k8g8A+viBClBAaa0bp/FFt4EbJrr1wlXMNxI9JGp/A0HIYaedTgxMiw1
 RXww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771099125; x=1771703925; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRbLJLfOXopnWNLLHqNX3wmCdvMfKgeVKZiXSYJt3rc=;
 b=PWx8iglDC79BPRbEiqmMzYJOcPzgDKtBIXruIpU0OHMe95SO5ha7O4/O+ab3z4lU6M
 UJS/1DCAG8GwKb/Zau+jANFuPlz98tL0uwCjcwTPI2B3vzRPordKLinmu7tutP/TbfCS
 omBDZqmO/wXisvjgJziU1BkgprO23/bXI/FgRjjjRYHunaZlI6NxD3d+qCMPRiw/olnt
 F7BFHMGfI94t2eIvi3brfpUmAPltth3li3h9vwxjOkwrprKIAQNjlpJXkYjn1gqHf01Z
 x9zU2YAnhmcu6PKlUYR8F+V4Tn8rIYGboeqfi0Q3GH3V9RjinFpd8++fWj2JIllCO4Sp
 rVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771099125; x=1771703925;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eRbLJLfOXopnWNLLHqNX3wmCdvMfKgeVKZiXSYJt3rc=;
 b=FLDd3Po1TZgmkZalyJ3jO691+gj+iP3XGlf2xfqO+EoVSjdx84wugWNllWfrotsIOd
 U97fuT6XZ+M8rTRL4x0HUAHN67LKVlU1QnMPQJt86eic2xRuL6+MBQZZ8EiQVmIAkPYW
 8hJGIMVC8IxBiAAHpKbGO9H+HrhuK1I2EPg55tEUG9aZwozAVvfj0+S9VrTquF7qsfqi
 CQBB7vVnR2f4DowGVe3nxDXjyGDbA5cTdSXHZfU3j7bkRSPXwZpKZ/Sint+9KCHocENK
 A/kH2G1H/TOkst+YpwSj+ifZR9vI3ci+Ak+iG6vP772tdh+ack7c/f139whN+IHgpLP1
 4kbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaaXYjKPB8+GA/W5nkOqk7FzTOUENMNAAfUItTWh5mi9XRqnc+wPDBYPfbCiXE0sEJbUkj/MM=@lists.denx.de
X-Gm-Message-State: AOJu0YwjnOkUquXFXVIiYHiHI6rVtXu6z8DhzpqU9eX7Hydb8I1Zf+Oa
 lD/YbohlLS4F6J4OIPevd/dEm+UHRNLVeDvgVcJIitJ4dCc3AaqKeiIspcy0mp/1KgEYpWYj7kP
 WltkG/1PZ49FcmHjB1zE2HjyK+bAPuA8=
X-Gm-Gg: AZuq6aLW4DWKs83ZOiuXxay91+22JWeuWn0nxziJFNkPQOKyIEx+tehBM1RHhKH/MwF
 KeMzJPhTLB8YwJL1HtSpSlI1iLGgOvtdbz9/f+MiHQXp2ITGmMnVoPVMTsZ5xFRJ3vU1aGQu9MB
 6EAB/L7JkD2inHNBikaqQCDyufZa1WZ03sDlE22c5IqRXiMu7RU7EoAXy4xT0ErT1qnCBTjag0p
 6fjkRDZxZn6SbT1DNFTZFwC3VwGm2TRUrWl19UR5yy6RjE6tdmXp/Qwn8/k73DzROuxLyBj9R2k
 Xdv4+7zH
X-Received: by 2002:a05:6830:3882:b0:7cf:e4a1:8a9d with SMTP id
 46e09a7af769-7d4c4a63bb2mr3906745a34.14.1771099125540; Sat, 14 Feb 2026
 11:58:45 -0800 (PST)
MIME-Version: 1.0
References: <LV8PR03MB81379CE3BDF36A06DC1D517BA761A@LV8PR03MB8137.namprd03.prod.outlook.com>
 <20260214185409.GS2747538@bill-the-cat>
In-Reply-To: <20260214185409.GS2747538@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sun, 15 Feb 2026 03:58:35 +0800
X-Gm-Features: AZwV_Qh18lTBjpPqAin5wy9bw76zSDiHFXEr4sKANs_oT5htB5y46NtAbmrJN5A
Message-ID: <CAN7C2SAbayHsJWyKQE=trBhV-qFTdVTdV-pFCM-ji4tRzZoUTg@mail.gmail.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20260213
To: Tom Rini <trini@konsulko.com>
Cc: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, 
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, "Maniyam,
 Dinesh" <dinesh.maniyam@altera.com>, 
 "Lok, Chen Huei" <chen.huei.lok@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
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

On Sun, Feb 15, 2026 at 2:54=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Feb 14, 2026 at 04:45:41AM +0000, Chee, Tien Fong wrote:
>
> > Dear Tom,
> >
> > This pull request updates SoCFPGA platforms with DDR improvements, new =
board support, Agilex5 enhancements and general cleanup across the codebase=
.
> > DDR and memory handling
> >
> >   *
> > Add DRAM size checking support for Arria10.
> >   *
> > Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
> >   *
> > Assign unit address to memory node for improved memory representation a=
nd consistency.
> >
> > Agilex / Agilex5 updates
> >
> >   *
> > Restore multi-DTB support for NAND boot and fix NAND clock handling.
> >   *
> > Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agilex5.
> >   *
> > Fix DT property naming conventions for Agilex5.
> >   *
> > Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operations to =
avoid unintended clock control.
> >
> > New board support
> >
> >   *
> > Add support for CoreCourse Cyclone V boards:
> >      *
> > AC501
> >      *
> > AC550
> > Including device trees, QTS configuration, defconfigs and maintainers e=
ntries.
> >
> > Fixes and cleanup
> >
> >   *
> > Fix GEN5 handoff script path.
> >   *
> > Remove incorrect CONFIG_SPL_LDSCRIPT settings.
> >   *
> > Replace legacy TARGET namespace and perform related cleanup across SoCF=
PGA code.
> >   *
> > General Kconfig, build and SoCFPGA maintenance updates.
> >
> > Overall this pull request improves platform robustness, adds new board =
coverage and cleans up legacy configuration usage across the SoCFPGA U-Boot=
 codebase.
> > Thanks.
> >
> > Best regards,
> > Tien Fong
> >
> > The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde78=
fee8:
> >
> >   board: toradex: Make A53 get RAM size from DT in K3 boards (2026-02-1=
2 08:12:09 -0600)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-bo=
ot-socfpga-next-20260213
> >
> > for you to fetch changes up to 4b567f8e252e27f6dafdfe22de1bad147595e33b=
:
> >
> >   Replace TARGET namespace and cleanup properly (2026-02-13 20:35:09 +0=
800)
> >
>

Hi Tom,

Actually I am also troubled by this manners:

If there are patches that are not committed yet while new patches do
rely on the other holding patches.

Under that background should the new patch that relies on another
follow the new one or ignore the dependent patch.
Keep using the master to develop.

Thanks,
Brian

> Please note that I had to fix the Kconfig entries for the two new
> platforms as they were referring to the old symbols and so didn't build
> (and failed in CI, in that harder to spot manner). I am also concerned
> it looks like there's a few places in the code rerferring to the old
> symbol names and not the new ones. That said, applied to u-boot/next,
> thanks!
>
> --
> Tom
