Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D919C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 10:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D295A87032;
	Wed,  6 Dec 2023 11:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkGEr1yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8794870DE; Wed,  6 Dec 2023 11:45:13 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9388A86EA6
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 11:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54c4f95e27fso5282908a12.1
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 02:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701859511; x=1702464311; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Cgq4FGI/1LZhwaomQeeoZFHOj8vJT5niw9+B2ZGo4Y=;
 b=WkGEr1ytxDc9m1YIt7FLdMYryvwjAjLZpLi1X30WyQwGkingAoQ2KBMYnnw9f7VWDe
 RnBDooe/hfyOTm6fbbNO0PD3KOjzMIhRCGTPVz0rFNCNIeBXQ8gbMfkS1tfp398J7DZA
 zF+qQQ3h/mY2n4qoanGZtAc5j0YYIrCQJsUPQwfwu+RoI/uTo16HPO0VvhpbLV+Sm7d5
 Q1M6LytcdL0RpAHHSACd8ubzcycAWczT7opf49aTqDBeDyCstOijRWaWeDNKu89FQWz6
 WJE1lWhkzxdLWtSkY/Gq38WQQ+hWhP5BqlmTVurnSNg6FtTr4pILVZntItmxvagsgiPe
 zpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701859511; x=1702464311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Cgq4FGI/1LZhwaomQeeoZFHOj8vJT5niw9+B2ZGo4Y=;
 b=f/WpPRo8N+SC2/gY5rqOU5WviKXo9Wg3cVRA3iGQEUTxD65BVrU+tsuuBOWnvVJvc0
 iwFguw2ViDUc300ClYssozgI7mHAUOjSW9iAHZKiwkWECrXoI0XikYujsOjz0b4TL3jd
 wICeQ20mr+NF9zWF9RqMuCFldzggfPfjn4JyC86SVXONQckxyIgtQ63Gf1uZEDYbggfa
 g4Eju0thACtTt87RPo3vmSQHiojlSIi+EIW4+VPHzrZM7TYPTEV5avpB8INJu+4AxBdY
 CwrfUOxojc7F1RH2Aneu1S3X7eQyJeZ5XcImRLrMJZV1XOdTvNq49A501NnJq7uvKeHs
 PtRw==
X-Gm-Message-State: AOJu0Yz6DUiePZpfgJBnUNvTWoBSg0E1Rzqm+y5HLHHXRNSL1bawcnLD
 YVmQgvR2iLVK7OLsiK8w05cHwXP2RdA0qAS7F9Y=
X-Google-Smtp-Source: AGHT+IGWWEtB7zZogucKCo5Bkvx3HOLyYS2vdNxti3njeH0wnTxG/tGEgyTbwBe+2IGGMQCxbNbvI9Lj1ETzMDbeBug=
X-Received: by 2002:a50:d498:0:b0:54c:a846:99f9 with SMTP id
 s24-20020a50d498000000b0054ca84699f9mr520405edi.81.1701859510747; Wed, 06 Dec
 2023 02:45:10 -0800 (PST)
MIME-Version: 1.0
References: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
 <CADQ0-X9Euv7UwVS49N=DvQxN+O_+6fq_jJw=Jiqauau6TyLpUg@mail.gmail.com>
 <35373146-3e24-461f-88b7-58eb01be1c45@canonical.com>
In-Reply-To: <35373146-3e24-461f-88b7-58eb01be1c45@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 Dec 2023 10:44:59 +0000
Message-ID: <CALeDE9O_7ndGQeEoErVQQcpvSWVVpw5dg+tygvyYi_s4Ta5Wtg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: boot options should relate to the ESP
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, Dec 6, 2023 at 9:31=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 05.12.23 07:23, Masahisa Kojima wrote:
> > Hi Heinrich,
> >
> > On Tue, 5 Dec 2023 at 11:38, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> * Only generate removable media entries for EFI system partitions.
> >> * Only offer EFI system partitions for boot options in the eficonfig
> >>    command.
> >>
> >> Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
> >> Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot opt=
ion")
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   cmd/eficonfig.c              | 6 ++++--
> >>   lib/efi_loader/efi_bootmgr.c | 3 ++-
> >>   2 files changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> >> index 34a59cb15d..c066b28b6b 100644
> >> --- a/cmd/eficonfig.c
> >> +++ b/cmd/eficonfig.c
> >> @@ -626,8 +626,10 @@ static efi_status_t eficonfig_select_volume(struc=
t eficonfig_select_file_info *f
> >>          efi_handle_t *volume_handles =3D NULL;
> >>          struct efi_simple_file_system_protocol *v;
> >>
> >> -       ret =3D efi_locate_handle_buffer_int(BY_PROTOCOL, &efi_simple_=
file_system_protocol_guid,
> >> -                                          NULL, &count, (efi_handle_t=
 **)&volume_handles);
> >> +       /* Find all EFI system partitions */
> >> +       ret =3D efi_locate_handle_buffer_int(BY_PROTOCOL,
> >> +                                          &efi_system_partition_guid,
> >> +                                          NULL, &count, &volume_handl=
es);
> >
> > UEFI specification v2.10 section '3.5 Boot Mechanisms' says
> > "EFI can boot from a device using the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL o=
r the
> > EFI_LOAD_FILE_PROTOCOL."
> >
> > So in my understanding of the UEFI spec, I think
> > efi_simple_file_system_protocol_guid
> > is correct here.
> >
> >>          if (ret !=3D EFI_SUCCESS) {
> >>                  eficonfig_print_msg("No block device found!");
> >>                  return ret;
> >> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
> >> index 48153bd5ff..9e84391186 100644
> >> --- a/lib/efi_loader/efi_bootmgr.c
> >> +++ b/lib/efi_loader/efi_bootmgr.c
> >> @@ -1047,8 +1047,9 @@ efi_status_t efi_bootmgr_update_media_device_boo=
t_option(void)
> >>          efi_handle_t *volume_handles =3D NULL;
> >>          struct eficonfig_media_boot_option *opt =3D NULL;
> >>
> >> +       /* Find all EFI system partitions */
> >>          ret =3D efi_locate_handle_buffer_int(BY_PROTOCOL,
> >> -                                          &efi_simple_file_system_pro=
tocol_guid,
> >> +                                          &efi_system_partition_guid,
> >
> > In EDK II reference implementation[0], it enumerates all
> > block_io_protocol devices
> > and eliminates logical partitions.
> > Should we do the same? If yes, I can prepare the patch on this.
>
> This is what the boot options look like on an EDK II system:
>
> $ efibootmgr -v
> BootCurrent: 000D
> Timeout: 3 seconds
> BootOrder:
> 000D,000B,000C,0003,0004,0005,0006,0007,0008,0009,000A,0000,0001,0002
> Boot0000* UiApp
> FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(462caa21-7614-4503-836=
e-8ab6f4662331)
> Boot0001* helloworld
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,655=
35,0)/HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c9f,0x2000,0x200000)/File(\=
helloworld.efi)h.e.l.l.o.
> .w.o.r.l.d...
> Boot0002* UEFI Crucial_CT128M550SSD1 14270C7CFEFE
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,655=
35,0)N.....YM....R,Y.
> Boot0003* UEFI eMMC Device
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ct=
rl(0x0)N.....YM....R,Y.
> Boot0004* UEFI eMMC Device 2
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ct=
rl(0x1)N.....YM....R,Y.
> Boot0005* UEFI eMMC Device 3
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ct=
rl(0x2)N.....YM....R,Y.
> Boot0006* UEFI PXEv4 (MAC:000000000001)
> MAC(000000000001,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> Boot0007* UEFI PXEv4 (MAC:000000000002)
> MAC(000000000002,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> Boot0008* UEFI PXEv4 (MAC:000000000003)
> MAC(000000000003,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> Boot0009* UEFI PXEv4 (MAC:000000000004)
> MAC(000000000004,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> Boot000A* UEFI Shell
> FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(7c04a583-9e3e-4f1c-ad6=
5-e05268d0b4d1)
> Boot000B* UEFI HL-DT-ST DVDRAM GTC0N
> VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f40000000000)/Sata(1,655=
35,0)N.....YM....R,Y.
> Boot000C* ubuntu
> HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\u=
buntu\grubaa64.efi)
> Boot000D* grub
> HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\g=
rub\shimaa64.efi)
> Boot1001* helloworld
> HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c8f,0x2000,0x200000)/File(hello=
world.efi)
>
> As you described autogenerated boot options are on block device level
> irrespective of the existence of an ESP.
>
> EDK II does not to care if /EFI/BOOT/BOOT<ARCH>.EFI is on a partition
> with the ESP partition type.
>
> We should try to mimic the EDK II behavior.

I believe the UEFI spec allows VFAT partition type as well ESP
partition type. For example a lot of Raspberry Pis won't load their
firmware of a ESP partition type but will off VFAT even though they
are essentially the same thing.
