Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B427EEB28D6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 07:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8CE8382A;
	Fri,  6 Feb 2026 08:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikfcZNzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B59A83A64; Fri,  6 Feb 2026 08:50:16 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA92836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d18d9503eeso1250657a34.1
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 23:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770364212; cv=none;
 d=google.com; s=arc-20240605;
 b=H9ZZscvmt1aSax36vsN59FQQEX/Xoo+2n5deKByydPx4xtjTmPMg8SKa06Ntniq6pd
 Fx4qHCAf3i5y+xDrlIm6VV13Y9svPzNgBouO8Kdj2IRYZ7zwfa88HH5MWgcCcTLpqAod
 9IUypROjrYZYIRGz5cfMa3k+n+okyKgV/AvNm3xpQc1hexPhicEywB/zebzyMv7bbGfg
 mcqqMvsmL1RLBPjmUS41qIKLQpMkV34mYxMLlmLDOdqY8MMhuMbR9BVe32eaWfkQN0GJ
 3jol2bwmrcL80QZi1OjikPx87khBkB8PNZLoZfVi74nzqFNwPykbgYm2tGJyh1qJvHjv
 3Jfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=buyhXX9xjShwHLfduvUGLCqw/IaP+sFzVsiBcHMt90s=;
 fh=rt7zV6biCSr9AIwLQz41Q8wHPgg3GgCo+GOUXJ1pDoQ=;
 b=Q5Tp1jV8QveyVBKk5oYo7SGZqFUVn3QOfZSEz+GFOd2xaLXSIDANP76OcMZi5GjF0R
 nUD7OdooIOw3Pg8zy1mD1sowCACOkp+JkIQy4pqsYIfoM69dGS4kqvSJCQo8HPHMue3f
 NcN+CPzb93px+K3gVhAQKMRIQC8xo5MiAmWRM+h1oan6T0Wrs4AeuAFhE5/3ruBiZS04
 qFPF8611t8C4Qg+jc8IFQkij+0+AkabNJ9/fhB0DVdWPqSI4D/vFFmA15gjDs2/Onjat
 JjIZKVdZB9P93NuSo16Xv8CWAukfvOheTMhAIAKaq8jQjfHIYBvMkU1BephjhEyM8bIW
 N9Wg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770364212; x=1770969012; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=buyhXX9xjShwHLfduvUGLCqw/IaP+sFzVsiBcHMt90s=;
 b=ikfcZNzge1ky8zHS7WtMHyzky7CP81gZbzlzSYcjz7B79RzMKwS9f4JWD1BkpL7GwA
 Wou/ZHJiwr6u205OTDENdek5r3ATshhAmolKdIPB23Qv68yQyBfKwemVw2DJ0G4GU7HZ
 i89KXO1SUJNHlIgaiDU+xXPm4+4m/1zz1JLTzi+gb80ooRarEfb6ETB1WmkN63uDlZ0u
 FxUpArbplE8b8tqcGcekz7S5owHWL0Ilo2YaYhbhJo7UbBF421O4MdKbjcgoNGLYDP3F
 BHypEHHMJlcjJp8WS9UtI4waIryBmAgamw2E/2BqpwN4UtvI1FJlGawvkuY0zmvgMhh5
 N3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770364212; x=1770969012;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=buyhXX9xjShwHLfduvUGLCqw/IaP+sFzVsiBcHMt90s=;
 b=xH5T8kR6c8+q4sm33t1p9qddUHjTUvxhoqSOycppL4YVDR9hGdVF5cLRqpfCHJJOlj
 oyqc+1YlXuoa5Yw+iXTiO03xT9RgLmieonNuJZNc1b23KNU6eCnzZjMdgPQ4DBecV9Uy
 VfIRqIR4afmxPAw+A2J96ezB3LbThUsM40dNsNr7vYurRsE0rgSxQr/nGIjm3OMNeQV0
 TGL9V9lyFDKI+zMSbizOc3yTEM7Se5CwcTqDvMcerUZt477g22qZ98721TBDDpLZ+EkF
 GCAD/cVTj1MPrSkva5PTm4fmUJd2RESg1ats37rEB2Er4fAcrNw/aiZmlZhZ6VcQuXGh
 f2hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNUXFCcHQ5I2ytfzpjUYYTO24Zw/YNppcVHv8mRBfITT1D+soARHiKLx8fk78wJsKpHVZEJ+A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywbuy0+DjumbpuFS8DbY1yDbxH21LNQpwP861lWYyELkQJXBf77
 GKWhTcpzDWAJCrYj6PUZ+gErKzdE2/aJ2YEAIU9VV33YkGJ0sl+QzeL7JZkgmajhS/CNlQcW92b
 rDwzM7yjU86eA24jUhnkgexuuIFPlxic=
X-Gm-Gg: AZuq6aKI9R6YHqaU5JexiEL2fct91mu4fTAtefZ9IO3dtnAvvm7BOrMcV5Pd/WXCotH
 oIxh93OwI6G4AOdgZS8KKn9nW3q6gCHflQ3JO9lkYL7+ymFMo1x4L5nAWTexYsTtEJ0I4WQwhze
 rhrpb0RZ3IFGGR3msb5+x4VE45IhTd6lnSSF4LIqS0D6VZDu5sPwcHcGDT6u9JucJ+wtq7LFVgt
 q7mSi0TIQZP6BXtnZk8gBZAilZnJKtKFV6SR2w4MA9X3mTMj5yN0muX5L+tz22SLIpjeJwi
X-Received: by 2002:a05:6830:8283:b0:7c7:68d8:f702 with SMTP id
 46e09a7af769-7d464406b3emr914686a34.9.1770364212161; Thu, 05 Feb 2026
 23:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-4-alif.zakuan.yuslaimi@altera.com>
 <fb37af46-c84c-4438-a7a9-c9476f2511f8@altera.com>
 <CAN7C2SBDat32aNjROeet5BwZTpJxN-8DOKx4gU12QY_ibbDLtg@mail.gmail.com>
 <827bec45-c680-42f6-828f-0d7020503a10@altera.com>
In-Reply-To: <827bec45-c680-42f6-828f-0d7020503a10@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 6 Feb 2026 15:50:01 +0800
X-Gm-Features: AZwV_QhU8AP-2TOS7NXBDQWeY5OZQgDGR-NEHdrjb_s0_olNCZvYgo7vrJjBtco
Message-ID: <CAN7C2SAMk+y36zBAiY9UP=hVViWvPyDQgJzC0US3jFVC7N=trA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ddr: altera: gen5: Add DRAM size checking
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>, u-boot@lists.denx.de, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Boon Khai Ng <boon.khai.ng@altera.com>
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

On Fri, Feb 6, 2026 at 11:33=E2=80=AFAM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
>
>
> On 6/2/2026 3:17 am, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Tue, Jan 27, 2026 at 4:03=E2=80=AFPM Chee, Tien Fong
> > <tienfong.chee@altera.com> wrote:
> >>
> >>
> >> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> >>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>>
> >>> Add DRAM size checking compare between size from device tree and actu=
al
> >>> hardware.
> >>>
> >>> Trigger hang if DRAM size from device tree is greater than actual har=
dware.
> >>> Display warning message if DRAM size mismatch between device tree and
> >>> actual hardware.
> >>>
> >>> get_ram_size() uses size from device tree. So, it has consistency wit=
h
> >>> other device families.
> >>>
> >>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>> ---
> >>>    drivers/ddr/altera/sdram_gen5.c | 20 +++++++++++++++++++-
> >>>    1 file changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdr=
am_gen5.c
> >>> index 7a0a043557b..d5892850da7 100644
> >>> --- a/drivers/ddr/altera/sdram_gen5.c
> >>> +++ b/drivers/ddr/altera/sdram_gen5.c
> >>> @@ -6,6 +6,7 @@
> >>>    #include <dm.h>
> >>>    #include <errno.h>
> >>>    #include <div64.h>
> >>> +#include <hang.h>
> >>>    #include <init.h>
> >>>    #include <log.h>
> >>>    #include <ram.h>
> >>> @@ -615,6 +616,22 @@ static int altera_gen5_sdram_probe(struct udevic=
e *dev)
> >>>        sdram_size =3D sdram_calculate_size(sdr_ctrl);
> >>>        debug("SDRAM: %ld MiB\n", sdram_size >> 20);
> >>>
> >>> +     /* setup the dram info within bd */
> >>> +     dram_init_banksize();
> >>> +
> >>> +     if (sdram_size !=3D gd->bd->bi_dram[0].size) {
> >>> +             printf("DDR: Warning: DRAM size from device tree (%d Mi=
B)\n",
> >>> +                    (u32)(gd->bd->bi_dram[0].size >> 20));
> >>> +             printf(" mismatch with hardware (%d MiB).\n",
> >>> +                    (u32)(sdram_size >> 20));
> >>> +     }
> >>> +
> >>> +     if (gd->bd->bi_dram[0].size > sdram_size) {
> >>> +             printf("DDR: Error: DRAM size from device tree is great=
er\n");
> >>> +             printf(" than hardware size.\n");
> >>> +             hang();
> >>> +     }
> >>> +
> >>>        if (sdram_is_ecc_enabled(sdr_ctrl)) {
> >>>                /* Must set USEECCASDATA to 0 if ECC is enabled */
> >>>                clrbits_le32(&sdr_ctrl->static_cfg,
> >>> @@ -623,7 +640,8 @@ static int altera_gen5_sdram_probe(struct udevice=
 *dev)
> >>>        }
> >>>
> >>>        /* Sanity check ensure correct SDRAM size specified */
> >>> -     if (get_ram_size(0, sdram_size) !=3D sdram_size) {
> >>> +     if (get_ram_size(0, gd->bd->bi_dram[0].size) !=3D
> >>> +                      gd->bd->bi_dram[0].size) {
> >>>                puts("SDRAM size check failed!\n");
> >>>                goto failed;
> >>>        }
> >>
> >>
> >> Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
> >
> > Hi T.F. and Alif,
> >
> > I know you reviewed the code.
> > But I am not sure on 2GB w/o ECC run it will pass SPL stage.
> > However when applied to the patch 2GB w/ ECC it does not pass SPL.
> > I would like to confirm that ARM GDB cannot be used to test ECC or not?
> > As I do see it involved D-Cache on
> >
> > "drivers/ddr/altera/sdram_soc32.c"
> >
> > Thanks,
> > Brian
> >
>
> Hi Brian,
>
> The code has been tested with RAM boot via ARM debugger on our Cyclone V
> SOC Development Board with ECC enabled, we are able to boot up to Linux
> successfully.
>
> Our board specs can be found here -
> https://www.rocketboards.org/foswiki/Documentation/AlteraSoCDevelopmentBo=
ard
>
> You can also refer our documentation here on running U-Boot with ARM
> debugger -
> https://altera-fpga.github.io/rel-25.1/embedded-designs/cyclone-v/sx/soc/=
boot-examples/ug-linux-boot-cve-soc/#appendix-2-run-u-boot-with-the-debugge=
r-from-command-line
>


Hi Alif,

Yes, if you use DS5 to run this patch series it will properly boot on
a 2GB case.
Our side changed to use openocd with GDB.
In that case it will simply be stuck on the "DDRCAL: Scrubbing ECC RAM".

Thanks,
Brian

Under DS5 boot message shows ECC init passed.

U-Boot SPL 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 15:43:21 +0=
800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1051 ms


U-Boot 2026.04-rc1-00154-gb5213bbfdcb1-dirty (Feb 06 2026 - 15:43:21 +0800)

CPU:   Altera SoCFPGA Platform
FPGA:  Altera Cyclone V, SE/A6 or SX/C6 or ST/D6, version 0x0
BOOT:  QSPI Flash (3.0V)
DRAM:  2 GiB
Core:  32 devices, 17 uclasses, devicetree: separate
MMC:   dwmmc0@ff704000: 0
Loading Environment from MMC... Card did not respond to voltage select! : -=
110
*** Warning - No block device, using default environment

In:    serial
Out:   serial
Err:   serial
Model: Cyclone V-5CSXF6C6U23
Net:   Could not get PHY for ethernet@ff702000: addr -1
No ethernet found.

Hit any key to stop autoboot: 0


> Thanks,
> Alif
>
> >>
> >> Best regards,
> >> Tien Fong
> >>
>
