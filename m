Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E0C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 11:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DAA81113;
	Tue, 25 Feb 2025 12:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khgDfAq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A51810DC; Tue, 25 Feb 2025 12:49:34 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0FF3810ED
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 12:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso10899168a91.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740484169; x=1741088969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPSaheGmgXbfJeF5MVBQdvgzvQmRBS70OiNNlRDERE8=;
 b=khgDfAq9CwyEQbNhwuaI5iltQ83AiBJQT+yhCLIroP9xYQY15gqnabL8faAGS4Y53l
 2pQtIp7CqLodmtVS6ceG+y/7el+v0YRWcaeh4ICuduM2rjr+iBf3G1ijoDj9U+3jKCYi
 TJQtA3ckGcxUA28dMAWM6Yz01nTJQmfKYbM8ZZwqXKOsIYOlllNBhQB+AgWTGqZWu7D1
 wgLLiUGiklqpM/CMrYU+2+aH5fu+Ph6YyqXZuSelLVi7Ay9BLhcwubY6Tej2UifpZRJS
 boHsFSp1f8/QLyGAdbqr5TAX0Q7cWc/4WEpCd1B9/57Qk1uZOSt2VSfu2a8xDzf+jYFM
 m08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740484169; x=1741088969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPSaheGmgXbfJeF5MVBQdvgzvQmRBS70OiNNlRDERE8=;
 b=NOp0fPcSZn8/xOU+azDV7/E9QrnV4rHzoScFBldt0qT2SnrFx112d255sXNm0Mc66+
 wA2TDmw9umNK8391+mp8N6G9Imgb8TKiKQrq2Z/IF86Uc5uV+rIbhb2/vtwva0iNSBSw
 tHpPKQ3OI+G2R5QFGONKE0xPIkI/5FceF4DIre5kpUgHG8bg3WXksiBuh2IJigcOJcDN
 jLg2sVj8Quc1aJA2CvI3QWvZFbR4V35dkZsi2zLJAwBhJ+ps+FiVSQyPiQmFQKyWqBa3
 rmKOQJ/XQHyAkVmj22cDcyYLA2zTw8Mxl9gk8/5Y7GJEmJdG48HFdgI1+N7Cy9DnCyES
 qvYQ==
X-Gm-Message-State: AOJu0YwwsCN4uG0A8hIdfJ3NoQY9DEgBUw4TKneZhydYpIc0T4IsFTab
 juzDFs6DdEvZRsdwgrsGUDCVan+9ufsp0RThBzv1hB/u9d56q/y6fULasEcznMmDU9hdT6RI4s3
 nZZsJ4456KKUEnyF5cr0g+0G8xeg=
X-Gm-Gg: ASbGncuYiUTIVzux7E9ssrZVOyeMNXannoWhh79J1Dq0f/F3uSJw/2UuNCp55Cxsle+
 i1eD9dK5gDX5/F/L669X+xbs02wHAIplQtepho6yAjX0UAC2VcPLvJGg0yu+v9F0z9EXxhNoGUv
 xc3HNtgoLTy0ZBzJBwaNGs1qd3f6fT2pZ1tGkUAg==
X-Google-Smtp-Source: AGHT+IEq/2zr5pWYi0XVtSXL2U/YlRrr2ehcSSe4yEHVQkeeNZg/urkMNGvLwMFnb9LVudBxY45cILwWIUcRJSpQvWk=
X-Received: by 2002:a17:90b:4b86:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2fce86cef44mr31211840a91.16.1740484169043; Tue, 25 Feb 2025
 03:49:29 -0800 (PST)
MIME-Version: 1.0
References: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
 <19488fdc-2666-4407-b49b-d25085c98453@cherry.de>
 <CAJs94EbjwrFgh5Rb5addpdj19hfi2SPeDpDgGJYavNA_0GpCrg@mail.gmail.com>
 <7d430025-ba05-4ea4-becd-f746845e2429@cherry.de>
In-Reply-To: <7d430025-ba05-4ea4-becd-f746845e2429@cherry.de>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Tue, 25 Feb 2025 14:49:17 +0300
X-Gm-Features: AWEUYZmJ4shG_gnZxLPgvrSbLa-RQo86nO8y8J27lZlfo0rwOs4Dr2oOTekJceg
Message-ID: <CAJs94EZr9EFP5U1XZUbboNoXpehYwUqst46EbxBnSVL1aVYekw@mail.gmail.com>
Subject: Re: Need help with booting from SPI Flash
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

=D0=BF=D0=BD, 24 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 18:0=
9, Quentin Schulz <quentin.schulz@cherry.de>:
>
> Hi Matwey,
>
> On 2/24/25 3:37 PM, Matwey V. Kornilov wrote:
> > =D0=BF=D0=BD, 24 =D1=84=D0=B5=D0=B2=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 =
13:54, Quentin Schulz <quentin.schulz@cherry.de>:
> >>
> >> Hi Matwey,
> >>
> >> On 2/24/25 10:57 AM, Matwey V. Kornilov wrote:
> >>> Hi,
> >>>
> >>> I have an Allwinner based board with manually soldered 16MB SPI Flash=
.
> >>> I am trying to place u-boot into the flash and need some help so far.
> >>> I have already updated the board DTS file and checked that the Linux
> >>> kernel provides me with a /dev/mtd0 device which is writable and
> >>> readable.
> >>>
> >>> I enable the following config options additionally to the board confi=
guration:
> >>> CONFIG_SPL_SPI_FLASH_SUPPORT,
> >>> CONFIG_SPL_SPI,
> >>> CONFIG_SPL_MTD_SUPPORT,
> >>> CONFIG_SPL_SPI_FLASH_MTD,
> >>> CONFIG_SPL_SPI_LOAD.
> >>
> >> Make sure the driver for the SPI controller on your SoC also is enable=
d
> >> in SPL.
> >>
> >>> I am not sure that I chose every relevant option.
> >>>
> >>> However, I see the following message from the bootloader:
> >>>
> >>> U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 12:43:=
35 +0300)
> >>> mxstatus=3D0xc0408000 mhcr=3D0x0000010b mcor=3D0x00000003 mhint=3D0x0=
0004000
> >>> Trying to boot from SPI
> >>> Invalid bus 0 (err=3D-19)
> >>> SPI probe failed.
> >>> SPL: failed to boot from all boot devices
> >>> ### ERROR ### Please RESET the board ###
> >>>
> >>> Are there any obvious things I missed? How could I debug this?
> >>>
> >>
> >> Can you check your SPL DTB has the SPI bus and flash node?
> >>
> >> dtc -I dtb -O dts spl/u-boot-spl.dtb
> >>
> >> If not, you're missing a <your-board>-u-boot.dtsi in arch/arm/dts/ whe=
re
> >> the SPI bus (and most of what it is needed to enable the controller,
> >> power, clock, pinmux, ...) and the flash node has the appropriate
> >> bootph- property. I believe it should be bootph-pre-ram for SPL,
> >> according to scripts/Makefile.lib (fdtgrep_props).
> >
> > Thanks. This indeed helped me, while no success yet:
> >
> > U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 17:31:47=
 +0300)
> > mxstatus=3D0xc0408000 mhcr=3D0x0000010b mcor=3D0x00000003 mhint=3D0x000=
04000
> > Trying to boot from SPI
> > fdt_fixup_memory_banks: FDT_ERR_BADMAGIC
>
> The code seems to be wanting to load the DTB to fix it up. I do not know
> if it's U-Boot proper's or U-Boot SPL's it's after. A memory address
> might be misconfigured in the config or include file somewhere (not in
> the environment likely as I would assume no environemtn in SPL just
> yet), maybe the "wrong" U-Boot proper was flashed (e.g. one missing the
> device tree) or at an unexpected offset.

Thanks for the help. I succeeded.

>
> Cheers,
> Quentin



--=20
With best regards,
Matwey V. Kornilov
