Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE73D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 13:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BB883B27;
	Mon,  1 Dec 2025 14:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gmSB8kNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B1183B48; Mon,  1 Dec 2025 14:24:40 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE0A83B23
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 14:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c704bdd57aso2037531a34.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764595477; x=1765200277; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad4d1qoDIoSmE3rhjTgnv5W2kA3ZeQvfsJBEJ0NRR60=;
 b=gmSB8kNFRkUDiEF7/V3OzGeMCsNtbSaCXwk9Gpw7WlIxQCeh7KH6IVoAosxF8se2ZV
 pkiw2KbqxJyjvOZ9ulD51y0stomzHIA1XrnDjKH93auU4/iK9impK3vt77KIrXJ9mlI3
 OrHbYfsWwpMt/0VPlugxY5LDeMdpQ92PnyGuUbTY3tYRHCq4sennWNSaqARzeaOVIlNi
 G4HkzpCOy7r5QEItFydzYnTAtHWgwhbOgJBLAFkHoWetvTEJ3rvo+66+cBvEOZmyhfNE
 s55gvhVF8fm8GKnpN+CTK4mxBUMXiCEyJO8Rh0/4Z89gAAGiQ82XPjeyn+0xtgmxFqfn
 qBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764595477; x=1765200277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ad4d1qoDIoSmE3rhjTgnv5W2kA3ZeQvfsJBEJ0NRR60=;
 b=tOubw3OlSoYtHz2cJoJnfMJbc+vh2asJxUwITeIA7ilk7VIDGtvh4XXZS/Vuc77OkJ
 tu7A39JK9HGtsg+gGUPq0Jha4uv5Z0DOyDOp6u4MwLF7X9LpA9rA/JMqi3ruSmAN0HjT
 r+vOgzr53NjI0x62tlBfr0VVI72snnewJWjD0yeZT8NtzbkNIqDow3i4FCY5sdO12kbO
 k5LWmtkERES6vPVLZ0TbIsajnYSwYCmZ8aJEUkLeSqV5dfrjhbqo4n+2E2gezB/9MLZa
 hUF5nXk1U3I+YSK/SL3fySU8LVy8Wo9/2UiAvRgSKA/pCIp7kwEk9J7bXnOfymgK3GvB
 S84Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNLF9HZN7ErgVdO4d6UPPYEYSAFOqVjL3Y6x4s2OWG6f9bEg2V0yw7db6vFIixvDRNGMuj4NU=@lists.denx.de
X-Gm-Message-State: AOJu0YxmhVAyLKaBu1bD0F6f0d+RZALdUvp8Y8mK5kEyJZf53/bEAI/m
 HBms8hKAooAhAsVudEbUOYElcJSO4Z6gPCUeGhtT90+lqiLcvhCL20RDhKIbCT/CgQLLpT02yUu
 +P0fq4fPqorn/ZopMHaV5faZcJNTIv8g6xAXhUZw=
X-Gm-Gg: ASbGncv/wuWWVLAEQBAbvwmaMqXdT1lrk5ScsBQkZfpyOn1iVUTh1KE/mi230d2QkFi
 qmlOMvR1xDsTE/4L6rfFKaEl+inH8m3mujfWA7H8qzbiaeVBhd8FLlv1PSnNcgt6U5xtYwB+HX7
 IzR3kGei4hqQ/Ow5VsGmZ5ZACURxvlcNsARQ5g73I5opLcY1MBkVgqoZBIufBuZctW5MxxFiAiX
 vdz5LZGedSqZ5AyyahHPNZ8002TEH2vKBNtRWQasVJG7lIDHEO3G+VInKCVh6d4/8MfD97i
X-Google-Smtp-Source: AGHT+IGfWIxjaiq3OvVG8zEy7bcEFhKy36BT14xf02FtN1KMgOSMZAo859fYR9FGmQFJ77tyTn6QIC35KugNuRiXMpM=
X-Received: by 2002:a05:6830:44a0:b0:7c7:6043:dd93 with SMTP id
 46e09a7af769-7c7c4332327mr11018471a34.13.1764595476760; Mon, 01 Dec 2025
 05:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
In-Reply-To: <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 1 Dec 2025 21:24:26 +0800
X-Gm-Features: AWmQ_blJsgt3zydKVeufrFMW0AypNzqemCCvQUYaf6qj7fevU7Fz8yVHl9qCa4k
Message-ID: <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Chee, Tien Fong <tienfong.chee@altera.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=8828=E6=97=A5=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Brian,
>
> On 28/11/2025 6:04 am, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Hi all
> >
> >>> CMD_CYCLIC is enabled by default ("default y") if its dependencies ar=
e
> >>> met (that is "CYCLIC" as specified by "depends on CYCLIC" in
> >>> cmd/Kconfig). So when you enable CONFIG_CYCLIC via menuconfig, it
> >>> enables (by default) CMD_CYCLIC as well. But you can disable it if yo=
u
> >>> don't need it for example. If you add a "select OPTION" in an option =
in
> >>> Kconfig, you cannot disable OPTION anymore.
> >>>
> >>> CMD_CYCLIC is not required, so you shouldn't "depends on" or "select"=
 it.
> >> Yes this patch had removed it by cross-check via real board on the fai=
l
> >> calibration issue. But CYCLIC and CYCLIC_SPL still a must to fix the i=
ssue.
> >>
> >> Brian
> > Would Altera also confirm this issue a bit?
> > I can repeat this issue by a fresh pull build.
>
> Thanks for sharing your findings. However, based on the behavior you
> described, I=E2=80=99m not fully convinced that enabling cyclic/watchdog =
is
> actually fixing the SDRAM calibration issue itself. From the SPL side,
> there is no clear timeout or calibration control path that would
> logically be corrected by turning on the cyclic framework, so the
> improvement may simply be due to timing shifts rather than a real fix.
>
> Before we go deeper into upstream work, could you try testing against
> the official Altera downstream tree?
>
> Altera official U-Boot (SoCFPGA):
> https://github.com/altera-fpga/u-boot-socfpga - branch socfpga_v2025.07
>
> This branch includes several Gen5 DDR related fixes that are not
> upstreamed yet. If calibration becomes stable with the downstream tree,
> then it is very likely that the real fix already exists there, and we
> can identify which patch addresses the root cause instead of spending
> time reverse engineering a solution that may already be solved.
>
> If the calibration still fails even on the official release, then at
> least we can rule out downstream fixes and focus efforts on the correct
> upstream location.
>
> Let me know the results, it will help us pinpoint whether the issue is
> timing-related or missing a specific patch.
>
> Thanks.
>
> Tien Fong
>

Hi T.F.

I am enclosing a bit log here.
I had diff both sequencer on mainstream and altera trunk.
No diff.

As for the sdram_gen5.c there are diff but no major point
before calibration fail is trigger. ECC is not use or setup.

Setup:
No CYCLIC no WDT all off on dts and .config.
No modification on code.
The below logs are trigger via reset key.

Pass case:
U-Boot SPL 2026.01-rc3-00043-gd5276409c0a1-dirty (Dec 01 2025 - 21:10:15 +0=
800)
sequencer: Preparing to start memory calibration
sdram_calibration_full:3939
run_mem_calibrate:3671
phy_mgr_initialize:115
rw_mgr_mem_initialize:1048
delay_for_n_mem_clocks:809: clocks=3D250 ... start
delay_for_n_mem_clocks:872 clocks=3D250 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D512 ... start
delay_for_n_mem_clocks:872 clocks=3D512 ... end
mem_calibrate:3492
mem_init_latency:3358
rw_mgr_mem_calibrate_vfifo:2853: 0 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
rw_mgr_mem_calibrate_vfifo_center:2565: 0 0rw_mgr_mem_calibrate_writes:3295=
 0 0
rw_mgr_mem_calibrate_writes_center:3146 0
0rw_mgr_mem_calibrate_vfifo_end:2950 0
0rw_mgr_mem_calibrate_vfifo_center:2565: 0
0rw_mgr_mem_calibrate_vfifo:2853: 1 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (1,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 1
rw_mgr_mem_calibrate_vfifo_center:2565: 1 0rw_mgr_mem_calibrate_writes:3295=
 1 8
rw_mgr_mem_calibrate_writes_center:3146 1
8rw_mgr_mem_calibrate_vfifo_end:2950 1
0rw_mgr_mem_calibrate_vfifo_center:2565: 1
0rw_mgr_mem_calibrate_vfifo:2853: 2 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (2,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 2
rw_mgr_mem_calibrate_vfifo_center:2565: 2 0rw_mgr_mem_calibrate_writes:3295=
 2 16
rw_mgr_mem_calibrate_writes_center:3146 2
16rw_mgr_mem_calibrate_vfifo_end:2950 2
0rw_mgr_mem_calibrate_vfifo_center:2565: 2
0rw_mgr_mem_calibrate_vfifo:2853: 3 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (3,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 3
rw_mgr_mem_calibrate_vfifo_center:2565: 3 0rw_mgr_mem_calibrate_writes:3295=
 3 24
rw_mgr_mem_calibrate_writes_center:3146 3
24rw_mgr_mem_calibrate_vfifo_end:2950 3
0rw_mgr_mem_calibrate_vfifo_center:2565: 3
0rw_mgr_mem_calibrate_lfifo:2979
rw_mgr_mem_calibrate_read_load_patterns:1446
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
sequencer: CALIBRATION PASSED
sequencer: Calibration complete
Trying to boot from MMC1

Fail case:
U-Boot SPL 2026.01-rc3-00043-gd5276409c0a1-dirty (Dec 01 2025 - 21:10:15 +0=
800)
sequencer: Preparing to start memory calibration
sdram_calibration_full:3939
run_mem_calibrate:3671
phy_mgr_initialize:115
rw_mgr_mem_initialize:1048
delay_for_n_mem_clocks:809: clocks=3D250 ... start
delay_for_n_mem_clocks:872 clocks=3D250 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D512 ... start
delay_for_n_mem_clocks:872 clocks=3D512 ... end
mem_calibrate:3492
mem_init_latency:3358
rw_mgr_mem_calibrate_vfifo:2853: 0 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
rw_mgr_mem_calibrate_read_load_patterns:1446
rw_mgr_mem_calibrate_dqs_enable_calibration:2747 (0,0)
rw_mgr_mem_calibrate_vfifo_find_dqs_en_phase:1959 0
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
delay_for_n_mem_clocks:809: clocks=3D4 ... start
delay_for_n_mem_clocks:872 clocks=3D4 ... end
sequencer: CALIBRATION FAILED
sequencer: Calibration complete
SDRAM calibration failed.
### ERROR ### Please RESET the board ###

Thanks,
Brian
