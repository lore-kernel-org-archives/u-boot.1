Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F8FFA0C21
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FF2839D5;
	Wed, 15 Apr 2026 06:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rfQGH1rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BA283B99; Wed, 15 Apr 2026 06:24:04 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C09383936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 06:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbf23885dfso3835533a34.3
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 21:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776227041; cv=none;
 d=google.com; s=arc-20240605;
 b=gXhJo973+qTnR/oZCRwTvDTnhNKD3QhaWpYySoJIzfI1XY+Hvcum7ZDNY3XuQqcg/R
 dbld9jTYUYC342C99zAzTQtUupcd754BZb99Wc1kWQJRun/MUPjbBNY3Jk/t0zIrvHDL
 x3a8ZguhhlFwlVKdgk+gQDU37uowvMoQO6tt6xE7XddkFZdJ32cfB9Frjke+3UQLVY3S
 UNcXpu+q43IYdZiPAklb9LzMwCc3PoZOWBhKqTl65/6Pv86c+XGPKf2zI6jCrk/MgiMh
 SYxkIXiGrSvaggTBncKtfu6rc4a2yf/fwp333R64Tsm5lK/nWeXoqH7y0u/LcFO6PKPr
 lzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FFsB2RfVd1XiKoqYsAURSV4mRtAJIh88OQr17sp0v+0=;
 fh=1nEW93sjxCV0PkJKPPLUsKuD5Uu2CEoTpJYEjB7qx/Q=;
 b=c3wNU/svj662nnYwPuRniMjViecuolflUfK0QrpVIdj7FH/ZVMYZGlAA7KqSWLqJBq
 0/m5ySbF8PmMYEhIwLlNwERqmT6Ns0020p+k8SGW88LSe5VeNMLM2X405Ji9QaZUyr7A
 LWRDcBRxaqa8ArIdKlfIOAg0g3efd/rnKUGFPRtMF8MTy3NJs3FfpMvIT6+1fI3fwMyc
 A7dz4fAILt3tR4wxnUBTuY322s6yA/R8anFen7lbgiwUUQb4DQQF2ln7ePqpv6sg8zVK
 R77oD2CFyTmXXWJsmkvWzc5noYY2Mc5G6dgm8Vv5GZ7IKKw9lA/6e3Sy8y4lZwo7HsXm
 SIsg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776227041; x=1776831841; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFsB2RfVd1XiKoqYsAURSV4mRtAJIh88OQr17sp0v+0=;
 b=rfQGH1rgjLhFnxR9y0LQVE32AzM/TFRbsObCmx6cYXEKY26IH9wn7FBoxt+YFbU/wq
 Q/bj5kxEDiHXQeMMJWuvMkhzUfQ7PR/TnzQmScu5qC8z4wD6jv4OG05CJ+uEA7SonJd0
 1lXQ8pZOkdjvMosj5bYx+l7uBmqS3cyp2HmexrAYJgqAu0WeVOVOlRQ6zjR1Q3sycDqI
 2tMCGt/ppC8WtTG9BQIafK8wE0A9A5kH2kNByapAsB/FHgED4pbQEB4nPv7KpdV8P8Th
 lVM33g7KGeR9B648yT2G9kb9+JOezsKjRPQ5sCxl1mSJzqHQLLbpxmqSvw5psnwtNhT/
 HLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776227041; x=1776831841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FFsB2RfVd1XiKoqYsAURSV4mRtAJIh88OQr17sp0v+0=;
 b=eEEirjgE49JVXVoj+OBRpQNX/yHT2EiO3cZa/sDhe0wvaSz4mclciQNj3POYm7wO7r
 ozAvxUXHk96CVXV7q1dKkn18TJzBvYgJFY8tKIWbUDKEXqASopF0iSzvvsEEzzb7mJJb
 XV1IXtT+1RtYusBVu6bR3myZfbb3Amb2Ju7TJYOW1UZYvw1CJyRO05vWiYpkR0Q6JLq/
 40SSZZZqL3mv2+le+bIVazkygOTtbzg73hnb0YZwJaFVQU+SaJyxZNjChVwux/CMHA0y
 FSXqVkpABBvynDNX+sLQzrqC5oATeoLhuQzYCcN+MJTiiLQXEflCMfU/DqhUoOtHLqyx
 mamA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FFZdH+6T43ZoPW8jXcOJkO9O3VpTh7pgd7GDHn85JtfgyJ2zCXQblOYEUBxIvHG7TVpwU25Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxguvzyeRkznAnjQ6tTf/8r0EwNapO+y46lO680lYZHAGR5vXF8
 Lh/SG7lK7RTVFa0bEKa9FebYOcdxDmz07DzaDgL8+e6jkVQ7rO4ak3N4faGS8yEpvJuNcJuxmg0
 BkPkgylYSQ3hx9OB6Kn7VyuNBJ6o0ImU=
X-Gm-Gg: AeBDieuNFqRhfnSH5x9p3I9ZdpXjqoX/9QCoGiL2O1ppFSHGOFxUdJ8CWeY2I+E8h1R
 uiC9lBsEmH4XUXU3Ka0w2l8sQ0RIK5mlc1/xZc5m7o0z7iqh/fbvOej38T4C9h+J6RB1mdoHnyW
 WroYtpQImhpMeH/SdJMTYQUizB66DAU4KdtI9LJwaxyGW8VXRO1te69mTeUKrZ965C4toPc+XD8
 jOvQ2vi543QyZ6ETqVYxT3ruzjd+HUB0nsPHqEM4mZtFIKimbZcSx5fHDWEcdb35PuMV453VHUj
 BFx28QEuvkLJCfs4QZTOm/bmdGsFxA==
X-Received: by 2002:a05:6830:67d7:b0:7d7:ef0a:1ce9 with SMTP id
 46e09a7af769-7dc27f0b2d3mr12879204a34.14.1776227040670; Tue, 14 Apr 2026
 21:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <c5129f8f-5970-44eb-8bda-a6577bde41bd@altera.com>
 <CAN7C2SAP8b38_2=6oanx7s8zYPpudUBFF+J1te6bPqALcbRPVQ@mail.gmail.com>
 <a8baeaf7-dc67-4ad1-905e-e8abeab6fd43@altera.com>
In-Reply-To: <a8baeaf7-dc67-4ad1-905e-e8abeab6fd43@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 15 Apr 2026 12:23:48 +0800
X-Gm-Features: AQROBzBTejOxkE2K-rriP5iFA9Kyf4Phj07FJKQ60Wyds3EfTcxKCWvWyE4-ZGw
Message-ID: <CAN7C2SC2C0kfyfmytoWrmTkyxY8k6=KkFPU49ROT643fxjDz6Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>, u-boot@lists.denx.de, 
 Tien Fong Chee <tien.fong.chee@altera.com>
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

On Wed, Apr 15, 2026 at 11:33=E2=80=AFAM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hello Brian,
>
> On 12/4/2026 8:11 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Hi T.F. and Alif,
> >
> > What are the issues here? Try to help push ECC back to main
> > stream u-boot.
> >
> > Latest U-Boot revision even removed cache codes.
> >
> > So what are the solutions here?
> >
> > Thanks,
> > Brian
> >

Hi Alif,

+spl/u-boot-spl.bin exceeds file size limit:
+ limit: 0xf520 bytes
+ actual: 0xf621 bytes
+ excess: 0x101 bytes
+make[1]: *** [Makefile:2416: spl/u-boot-spl.bin] Error 1
+make[1]: *** Deleting file 'spl/u-boot-spl.bin'
+make: *** [Makefile:189: __sub-make] Error 2
+ actual: 0xfa0d bytes
+ excess: 0x4ed bytes
+1024+0 records in
+1024+0 records out
+65536 bytes (66 kB, 64 KiB) copied, 0.0017824 s, 36.8 MB/s
+ actual: 0xfc96 bytes
+ excess: 0x776 bytes
+ actual: 0xfa85 bytes
+ excess: 0x565 bytes

I think this is board dependent.
I used the patches in this patch series and had no issue on size.
No too familiar with those boards but highly suspected the original
rooms for those are closed to zero.

Maybe reduce the check cases in sdram_gen5.c:
Just check size match.
Then completely remove the extra file and turn into inline action for
sdram_soc32.c.

Thanks,
Brian

> The pipeline test was failing for SoCKit SoCrates and VINING boards due
> to exceeding their SPL size limit, further improvements will have to be
> made to exclude these Gen5 variants from enabling these features to
> conserve SPL size.
>
> I will submit v2 once I have finalized and tested the workaround
> accordingly.
>
> Thanks,
> Alif
> > On Sat, Feb 14, 2026 at 12:52=E2=80=AFPM Chee, Tien Fong
> > <tienfong.chee@altera.com> wrote:
> >>
> >> Hi Alif,
> >>
> >> On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> >>
> >> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >>
> >> This patch set updates the boot support for the Altera SoCFPGA Gen5/Ar=
ria10 platform in U-Boot. The changes include:
> >> 1. Update MMU/dcache setup across Gen5/Arria10 using common driver
> >> 2. Add ECC scrubbing support for Gen5/Arria10
> >> 3. Add DRAM size checking for Gen5/Arria10
> >> 4. Assign unit address to memory node in common SoCFPGA device tree fi=
le
> >>
> >> This patch set has been tested on CycloneV devkit with SDMMC boot and =
RAM boot (TFTP & ARM DS debugger).
> >> Tested on Arria10 devkit with RAM boot as well
> >>
> >> Alif Zakuan Yuslaimi (5):
> >>    arm: socfpga: Consolidate dram_bank_mmu_setup()
> >>    ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
> >>    ddr: altera: gen5: Add DRAM size checking
> >>    ddr: altera: arria10: Add DRAM size checking
> >>    arch: arm: socfpga: Assign unit address to memory node
> >>
> >>   arch/arm/dts/socfpga-common-u-boot.dtsi       |  2 +-
> >>   arch/arm/dts/socfpga_arria5_secu1.dts         |  2 +-
> >>   arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts    |  2 +-
> >>   arch/arm/dts/socfpga_cyclone5_de10_nano.dts   |  2 +-
> >>   .../dts/socfpga_cyclone5_de10_standard.dts    |  2 +-
> >>   arch/arm/dts/socfpga_cyclone5_de1_soc.dts     |  2 +-
> >>   arch/arm/dts/socfpga_cyclone5_is1.dts         |  2 +-
> >>   arch/arm/mach-socfpga/Kconfig                 |  1 +
> >>   arch/arm/mach-socfpga/misc.c                  | 31 ++++++++
> >>   arch/arm/mach-socfpga/misc_arria10.c          | 26 -------
> >>   arch/arm/mach-socfpga/spl_gen5.c              |  4 +
> >>   drivers/ddr/altera/Makefile                   |  4 +-
> >>   drivers/ddr/altera/sdram_arria10.c            | 57 +++++++++-----
> >>   drivers/ddr/altera/sdram_gen5.c               | 38 +++++++++-
> >>   drivers/ddr/altera/sdram_soc32.c              | 74 +++++++++++++++++=
++
> >>   drivers/ddr/altera/sdram_soc32.h              | 11 +++
> >>   16 files changed, 205 insertions(+), 55 deletions(-)
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
> >>   create mode 100644 drivers/ddr/altera/sdram_soc32.h
> >>
> >> I will need to drop these patches (1/5, 2/5, 3/5) for now as it causes=
 the U-Boot SPL file size to exceed the limit on several Cyclone V variant =
defconfigs (see CI failure: https://source.denx.de/u-boot/custodians/u-boot=
-socfpga/-/jobs/1379031).
> >>
> >> Please consider restructuring the changes so that Arria 10 and Cyclone=
 V are handled separately. Arria 10 has a larger OCRAM footprint, while Cyc=
lone V is much more constrained.
> >>
> >> The SPL size overflow on certain Cyclone V boards must be properly res=
olved before we can take this upstream.
> >>
> >> Also, please make sure to run the pipeline tests and confirm they pass=
 before resubmitting the patches upstream.
> >>
> >> Thanks for your understanding, and please resend once the Cyclone V si=
ze issue has been properly addressed and the pipeline is clean.
> >>
> >> Best regards,
> >>
> >> Tien Fong
>
