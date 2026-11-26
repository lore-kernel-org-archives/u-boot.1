Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC2606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rtaxxCKg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IGpPMiG5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E8640462;
	Thu, 26 Nov 2026 06:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sLDaDfqqTuCQ; Thu, 26 Nov 2026 06:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9340240471
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795673079;
	b=RBt6gRS2m5RxMNbeiSofcaQxa1Ie3TkdhQvhs24eCF4doqRVsSXp8WfX6Ae9cKiQWjAZ
	 2s0a2urGjA8KOvqOz8qFEG8mMhVHdM0DOR+ku18gs87daC2MHwW1hR8zcqe4esF43IK2r
	 haw/qtuh9pdW8/ERHOURlPvDOCzaV960SpOT4vN/UCzgOP7mxzQlsKyhB4M6OLCYjhjbg
	 5z6Dq2wpuXccgKp/Z7o3x5VqmzFYEXvLQ5oTC+hKWDheRcJgh14KKHZTZ66OpEMN7atSt
	 /t9Jyj6notj3EiO7UemI7PaM2wWSqrz6Sxg9ssVCZCbiWOuSvESlwPOGKPxb5EgxCig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795673079;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NLFd0Y1w/WXcRTo1g0VpGEO0QWRlra5QScpgRYNECK0=;
	b=Ct5rUGCIHMhvTjL2iMTpElOt1ZwWCxRHV4oX/Vbr6sXmgfFPnfHJGttcCCbDweXIm9hq
	 ZS1xd0MuBt6/RFLO2vBstpIUgHrvljPjZJE/YuAaIB35r7A+ta6i7KGLEd7K96U+MMsKK
	 hQ/VyhJ4Zn8OhwrgoM/1Mlf85R5QYIhWy+4vMHJVq+QC87a3NnjIcJI1xhWsNhMD6mrv7
	 cP+TDctFFLrC4pvYQsVvLWLkhxgvlrB4ro/UyTD3i86CVoq28hYNsdtfPY+ODWxdayhgy
	 oNK04/WgYec5FY88svGmDsW3cEbDey78OKxIHarLMkUIeoze6LG2A0PC//vOPi4HVLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795673079;
	bh=NLFd0Y1w/WXcRTo1g0VpGEO0QWRlra5QScpgRYNECK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rtaxxCKgXlvDtrqEFQ9FEYCuGyMOSVA8VisiUMo5gN5vUmu7dgXkpOG9yAbm0iYra
	 /9tgT8m8FEDJnL/TQhGzXaeM1MhlrMRWDbv0Ruj49lxqJzyzmgZqCFZvBHaiXxZ12r
	 jDz0iLzeNI2ijXfOPiiX4KpuYoOTouWt0irmttbJOMLIl0lMLKZG6h9FFUs+cYgS81
	 /tWiGZfSti4RAxs3UNtfttkU12mfLWZAzP05MzAOdhfN3rXHeHpMTple5GxTcz1V3H
	 ietE2c+5zQz8AJh1E0FYqHRmrf3SNsbDrxzMseLy+6nrJaQ6kg6gv2X+6aY5RU+OtI
	 biiMlvf9pbbEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9340240471;
	Thu, 26 Nov 2026 06:04:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4193260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5F4240474
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hu3aUPfcgpUs for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6410A4008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=IGpPMiG5
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6410A4008A
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:04:34 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b8a1f59d5eso8702923a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795673073; x=1796277873;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NLFd0Y1w/WXcRTo1g0VpGEO0QWRlra5QScpgRYNECK0=;
 b=IGpPMiG53/SGOb5/CzUusHwBYy9MsHm1K4DU0TOXgBu/AmUg7Fc0RVAFxXFm/Fukax
 2+j2gYWtEZIFX1+0bzpGYkLUitc9o3HJbFZP52N2hE4CPvm4jRkE5LIeBeEeDmSBtPir
 DfwgkFXo7rrzl7yhs9WLBD9onHH8RheSuVvljWBB4nchoyGScsp1P9vS08Wufd+YtHtV
 cJ9M24rxMypODsWL6NT+ePK+c8u+4nECanA7y7wZPEgjNr475hI9/46KSHgd+JQbU6xx
 DBDcWYu055hgPBQTc5n+Mh77HuM0qmBKlDY18t+zM5CrI0iz2MgmwC0ShDEOELrfFlXZ
 IzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795673073; x=1796277873;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NLFd0Y1w/WXcRTo1g0VpGEO0QWRlra5QScpgRYNECK0=;
 b=2OEzA6rg4tQQ4maqnyrYIyYBk/vMsOR69j3UqtHQ1Esc5rKb9FKpYIj1PdBGYBmDcG
 tVxv2Upa1s6q/quZzEu0H2dibNA7frVzvYlGsWQ3TnGlnomHQNqE9OjCdFXl7T6unlBV
 e820J0WHXU/Kw2mkp0bAxKciSIS4zsB4XQDcAEeogS8VBTLpYtuARX4izY6y29qvC/PF
 gIzyVHC/OuFJqFnWnq8QtKq4vtp7kZzgMkWgzNjvfnhhdO2bz1maEcyXR1cWiaPhtK3n
 9goPXzhaHAvW0VWZAdirvNqKWv/Msa+BMC/rS/nv4685E8XuLj0oyaNNbwZmpRR4y1kB
 zXuw==
X-Gm-Message-State: APuU4Z+FfUvtyoozzLSxwEcvBR6XKOnoV0Yg5c0lWphCnhnTc827PcfC
 r+AycGUqC5b8B8NwPHtD9ZRnIbU4LB/6htx4gOCROXLNP9TnhVysh6Sn8g6pJjVrIN7Xbr4hQrR
 HScnGBf+t77NuROiBxTrT/mH+6m540f8=
X-Gm-Gg: AZFdTZc/fab1IQPc/iUYMcQ5mhGWrC8OZAasaub7dGJZ4Yp2XekbKWo7bq6+j05Trt0
 SIJ2TxDXky/H+x8WGCQC9qgBAA8zlGuBxLEd9rUHK1qfh28SLLrCDLmKDzMCl0OaS8jwhmt1pQD
 VQgCQmIUpp5DyM39sIuLGOq5yWrOuMJWvtVjb6ZysrUD5taR1ZiLp2r8IVLYHWfcoZtaFdPCbZS
 Iq2OPLZxscJmMiblo04nSbXHBQcJ5Uf6GkKwHrOxqOB99qMQ/Ly0V+0aE10qaVEdvFMJVskEivf
 jEWuHPNrmXu1X8+OzHw6wN/uWOofCwMlYoWVOWVm5Lt/PnLtD88sbo+FY8QRylgMyc33PPtuzlO
 8hBP5kYMnliOivGntFjwp3ucWKUdDQrnXZJE=
X-Received: by 2002:a05:6402:210e:b0:6aa:f0e:a15f with SMTP id
 4fb4d7f45d1cf-6ba37ec43c0mr15993217a12.38.1795673072928; Wed, 25 Nov 2026
 22:04:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123193714.5096-1-linux.amoon@gmail.com>
 <CANAwSgQ-vKfciZ+F+vAqmk-kJS1cqMxKWaUrRBbyYnwgWcygXQ@mail.gmail.com>
 <20f0a389-8672-45df-b5fe-6593cab0e4e2@freeshell.de>
In-Reply-To: <20f0a389-8672-45df-b5fe-6593cab0e4e2@freeshell.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 26 Nov 2026 11:34:21 +0530
X-Gm-Features: Aa3M54rxy7yz2fFWv-a-JCm2Zv8s5pPsqTpDCRXi0ixgOO1OMSQmYpho6-puNfo
Message-ID: <CANAwSgSvcUhdUsaObd1yr-5KDA1Z6dEhnY_hEnjS0kc_bjv4ig@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] riscv: spacemit: Add GPIO and pinctrl support in
 SPL
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>, 
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,

Thanks for your feedback,

On Wed, 25 Nov 2026 at 21:53, E Shattow <e@freeshell.de> wrote:
>
> Hi Anand,
>
> On 11/25/26 07:35, Anand Moon wrote:
> > Hi All,
> >
> > +Zixian Zeng
> >
> > On Tue, 24 Nov 2026 at 01:07, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> This series consolidates common U-Boot device tree properties for
> >> SpacemiT K1 boards and enables GPIO and pinctrl support in SPL.
> >>
> >> The device tree changes move common early boot properties into shared
> >> DTSI files, reducing duplication between the Banana Pi BPI-F3 and
> >> MusePi Pro boards.
> >>
> >> The remaining patches add SPL build support for the SpacemiT K1/K3
> >> GPIO and pinctrl drivers and enable these drivers in the K1 SPL
> >> configuration.
> >>
> >> The series consists of six patches:
> >>
> >> 1. Move common K1 U-Boot nodes into a shared DTSI.
> >> 2. Remove redundant MusePi Pro device tree overrides.
> >> 3. Move common K1 U-Boot properties into the shared DTSI.
> >> 4. Add SPL support for the K1/K3 pinctrl driver.
> >> 5. Add SPL support for the K1/K3 GPIO driver.
> >> 6. Enable GPIO and pinctrl support in K1 SPL.
> >>
> > Following the description on the Linux mainline list:
> >
> > [1] https://lore.kernel.org/all/20261123-fix-bpf3-eeprom-v1-1-df8cce6ef2b5@gmail.com/
> >
> > I am currently working on enabling multi-DTB support in U-Boot SPL
> > for SpacemiT K1 boards.
> >
> > While investigating the board detection issue, I noticed that the EEPROM
> > on my Banana Pi BPI-F3 does not contain a Product Name TLV entry.
> >
> > alarm@k1:~$ sudo hexdump -C /sys/bus/i2c/devices/2-0050/eeprom
> > 00000000  54 6c 76 49 6e 66 6f 00  01 00 20 24 06 fe fe fe  |TlvInfo... $....|
> > 00000010  d5 52 bd 2a 02 00 02 23  0c 39 38 61 39 63 33 61  |.R.*...#.98a9c3a|
> > 00000020  32 62 64 34 37 fe 04 3b  e3 ff bd ff ff ff ff ff  |2bd47..;........|
> > 00000030  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> > *
> > 00000100
> >
> > Although the EEPROM is readable, the missing Product Name TLV entry
> > explains why read_product_name() returns `-ENOENT` (-2), assuming the
> > EEPROM read and validation succeed.
> >
> > Consequently, automatic board detection fails, and U-Boot falls back to
> > CONFIG_DEFAULT_DEVICE_TREE, which may select an incorrect device
> > tree for the target board.
> >
> > Since the SD card-detect GPIO polarity differs between the Banana Pi BPI-F3
> > and MusePi Pro, selecting the incorrect device tree can result in SD
> > card detection
> > and boot failures.
> >
> > The following SPL boot log shows the board detection failure, although
> > DDR initialization completes successfully:
> >
> > ```
> > U-Boot SPL 2026.10-01060-gf3080abcfe92-dirty (Oct 24 2026 - 17:30:03 +0530)
> > Fail to detect board:-2
> > vdd_core, value:900000
> > vdd_1v8, value:1800000
> > vdd_1v8_mmc, value:1800000
> > DDR firmware: [0xc0820900]:0xf0227179, size:0x8d98
> > DDR is ready
> > ```
> > Could you please confirm whether the Product Name TLV entry is
> > expected to be programmed into the EEPROM during manufacturing?
> >
> > Also, is there a recommended approach for handling boards with missing
> > product information in the EEPROM to ensure reliable automatic device
> > tree selection?
> >
>
> Is specialized equipment needed to pulldown the WP pin on these boards,
> or would a common office paperclip (and a steady hand) do it?
>
> In other examples we've just invented some reasonable-sounding product
> ID and stuck that into the logic. Particularly several Milk-V
> product-lines had wrong EEPROM values and majority of their sales
> through a vendor that would swap product models without informing the
> customer, and Pine64 shipped non-programmed EEPROM on early
> manufacturing run of Star64 boards. There's several of the StarFive
> JH-7110 SoC -having boards by third party (not StarFive) where the
> manufacturer uses the same EEPROM product ID as the StarFive VisionFive
> 2 1.3b reference board even though the hardware is widely different.
> With a steady hand and a paperclip...:
>
> https://freeshell.de/e/riscv64/vf2eeprom/
>
> ...it's not too much trouble to pulldown the WP leg of that IC part on
> the board and write a new product ID to EEPROM. For the integrated
> products like Pine64 PineTab-V however it may require specialized
> equipment and/or significant risk of physical damage to the product to
> get access to the WP pin of EEPROM IC part.
>
> Something I intend to do and haven't yet is a bare-minimum dts for
> JH-7110 SoC -having boards which has just enough functionality to write
> new EEPROM values and SPL fastboot by default through the on-SoC USB
> interface. Currently in respect for an abundance of caution to prevent
> data corruption and hardware breakage if the EEPROM ID does not match it
> does not continue to boot. However, not being able to continue to boot
> with a non-valid EEPROM also makes this software then useless for
> updating EEPROM... so the way it is postured currently is that vendor
> BSP is recommended for EEPROM setting actions. This is not a solved
> problem in my opinion and it would be welcome to have a general document
> that describes this.
Ok I see the issue, with a few boards like: StarFive VisionFive2 (V1)
and Milk-V Mars CM
which fail to boot once I updated the u-boot and image to SPI flash
a long time ago.
>
> >> Changes in v2:
> >> - Consolidate additional common U-Boot properties into
> >>   spacemit-k1-u-boot.dtsi.
> >> - Reduce duplication in the board-specific DTSI files.
> >> - Retain board-specific configuration where required.
> >>
> >
> > This current series is incomplete, I missed few code cnages
> > But I am working on a few changes to fix
> >
> > Please review the DTS changes and share your feedback.
> >
> > Thanks
> > -Anand
>
> A note about spacemit-k1-u-boot.dtsi it does generally look good however
> the per-board property overrides (as determined by Linux upstream
> organization) should go in per-board -u-boot.dtsi files. When device
> tree changes get merged in Linux upstream for e.g. bootph-pre-ram hints
> or prior to being a proper cherry-pick in U-Boot then it's so much less
> confusing if there is a 1:to:1 relationship between upstream where/when
> something is merged and then looking at U-Boot to figure out if/when it
> can be safely deleted as being redundant. I haven't looked at the K1
> dtsi with much attention but I trust you're aware of this.
>
Thanks for the feedback. I understand the importance of maintaining
a one-to-one relationship between the upstream Linux device trees and
the corresponding U-Boot device tree overrides.
I have identified a few additional changes required in spacemit-k1-u-boot.dtsi,
along with changes to the clock driver and Binman configuration to
support SPL booting.

My intention is to upstream the required `bootph-pre-ram` properties
and missing regulator names to the Linux device trees.

Once these changes are merged and synchronized with U-Boot, the redundant
board-specific overrides can be removed, potentially eliminating the need for
per-board `-u-boot.dtsi` files.

For now, I will keep the board-specific property overrides in their respective
-u-boot.dtsi files and retain only the common properties in
spacemit-k1-u-boot.dtsi.

I will address these changes in the next revision of the series.

> Best regards,
>
> -E
Thanks
-Anand
