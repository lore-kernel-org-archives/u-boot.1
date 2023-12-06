Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49153C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729C78764D;
	Wed,  6 Dec 2023 13:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="GxpVTpTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31BA876E9; Wed,  6 Dec 2023 13:01:00 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82EAC86D10
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1561701c-942f-11ee-abd3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1561701c-942f-11ee-abd3-005056999439;
 Wed, 06 Dec 2023 13:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=nZDv99rf/o17aX+xufUWD04ugbZN/Z7nvv1/OtDKrRY=;
 b=GxpVTpTJ9osYTRx9ZDSzns3uY5S1pMl7uopivPy0uvE7E6ttHXVqk7jYCfv/i1lcB3omVuAhU+1cg
 QLns6PyMc1nzKaIfJPY55hmRUU2+kxzGOStOkbHM+d3l1YPZTmvaEw1MQLm7vbRTypr4ma+vwOYGnZ
 OxyFLMW2UAMfumjRrRMJq2uJSzbmyu7QJTUAgU7w0N/BkAdpXHHmHUHRcpgbo/qirTnzmpgYVbO8bY
 D5/ZBZPA698ShxOnSj2NgJs0Xh8OdFwPrviEzCQCJin1dmzixDMoVvgn68/Hbw3yjbegjNsd0DUT9e
 8OtLquWMHIbuZj8CI3zFFjSFOkYMwJA==
X-KPN-MID: 33|BmZZllsbR763YTr8ADXjp3oinAr24+JfIlOoWOsxbdkRBWUXNJn9UFjfox/32tP
 3w//7CyYx1lR66YuIT74R1A5CmqgttHKlZUdBCom3K2A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fbKvAiHXtuNT1W0kQvkbJFmIgz5Q0fEPJbmbs5TedXt5lI/zRtuNAhx2v1cxELb
 shY8Rs3ZS7vWX3tThojrFxw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1cf7b6b6-942f-11ee-acaa-00505699d6e5;
 Wed, 06 Dec 2023 13:00:57 +0100 (CET)
Date: Wed, 06 Dec 2023 13:00:56 +0100
Message-Id: <878r678rrb.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: heinrich.schuchardt@canonical.com, masahisa.kojima@linaro.org,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
In-Reply-To: <CALeDE9O_7ndGQeEoErVQQcpvSWVVpw5dg+tygvyYi_s4Ta5Wtg@mail.gmail.com>
 (message from Peter Robinson on Wed, 6 Dec 2023 10:44:59 +0000)
Subject: Re: [PATCH 1/1] efi_loader: boot options should relate to the ESP
References: <20231205023751.61679-1-heinrich.schuchardt@canonical.com>
 <CADQ0-X9Euv7UwVS49N=DvQxN+O_+6fq_jJw=Jiqauau6TyLpUg@mail.gmail.com>
 <35373146-3e24-461f-88b7-58eb01be1c45@canonical.com>
 <CALeDE9O_7ndGQeEoErVQQcpvSWVVpw5dg+tygvyYi_s4Ta5Wtg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Peter Robinson <pbrobinson@gmail.com>
> Date: Wed, 6 Dec 2023 10:44:59 +0000
> 
> On Wed, Dec 6, 2023 at 9:31 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 05.12.23 07:23, Masahisa Kojima wrote:
> > > Hi Heinrich,
> > >
> > > On Tue, 5 Dec 2023 at 11:38, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> * Only generate removable media entries for EFI system partitions.
> > >> * Only offer EFI system partitions for boot options in the eficonfig
> > >>    command.
> > >>
> > >> Fixes: c416f1c0bcab ("bootmenu: add removable media entries")
> > >> Fixes: 87d791423ac6 ("eficonfig: menu-driven addition of UEFI boot option")
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >> ---
> > >>   cmd/eficonfig.c              | 6 ++++--
> > >>   lib/efi_loader/efi_bootmgr.c | 3 ++-
> > >>   2 files changed, 6 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> > >> index 34a59cb15d..c066b28b6b 100644
> > >> --- a/cmd/eficonfig.c
> > >> +++ b/cmd/eficonfig.c
> > >> @@ -626,8 +626,10 @@ static efi_status_t eficonfig_select_volume(struct eficonfig_select_file_info *f
> > >>          efi_handle_t *volume_handles = NULL;
> > >>          struct efi_simple_file_system_protocol *v;
> > >>
> > >> -       ret = efi_locate_handle_buffer_int(BY_PROTOCOL, &efi_simple_file_system_protocol_guid,
> > >> -                                          NULL, &count, (efi_handle_t **)&volume_handles);
> > >> +       /* Find all EFI system partitions */
> > >> +       ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> > >> +                                          &efi_system_partition_guid,
> > >> +                                          NULL, &count, &volume_handles);
> > >
> > > UEFI specification v2.10 section '3.5 Boot Mechanisms' says
> > > "EFI can boot from a device using the EFI_SIMPLE_FILE_SYSTEM_PROTOCOL or the
> > > EFI_LOAD_FILE_PROTOCOL."
> > >
> > > So in my understanding of the UEFI spec, I think
> > > efi_simple_file_system_protocol_guid
> > > is correct here.
> > >
> > >>          if (ret != EFI_SUCCESS) {
> > >>                  eficonfig_print_msg("No block device found!");
> > >>                  return ret;
> > >> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > >> index 48153bd5ff..9e84391186 100644
> > >> --- a/lib/efi_loader/efi_bootmgr.c
> > >> +++ b/lib/efi_loader/efi_bootmgr.c
> > >> @@ -1047,8 +1047,9 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> > >>          efi_handle_t *volume_handles = NULL;
> > >>          struct eficonfig_media_boot_option *opt = NULL;
> > >>
> > >> +       /* Find all EFI system partitions */
> > >>          ret = efi_locate_handle_buffer_int(BY_PROTOCOL,
> > >> -                                          &efi_simple_file_system_protocol_guid,
> > >> +                                          &efi_system_partition_guid,
> > >
> > > In EDK II reference implementation[0], it enumerates all
> > > block_io_protocol devices
> > > and eliminates logical partitions.
> > > Should we do the same? If yes, I can prepare the patch on this.
> >
> > This is what the boot options look like on an EDK II system:
> >
> > $ efibootmgr -v
> > BootCurrent: 000D
> > Timeout: 3 seconds
> > BootOrder:
> > 000D,000B,000C,0003,0004,0005,0006,0007,0008,0009,000A,0000,0001,0002
> > Boot0000* UiApp
> > FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(462caa21-7614-4503-836e-8ab6f4662331)
> > Boot0001* helloworld
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,65535,0)/HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c9f,0x2000,0x200000)/File(\helloworld.efi)h.e.l.l.o.
> > .w.o.r.l.d...
> > Boot0002* UEFI Crucial_CT128M550SSD1 14270C7CFEFE
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f20000000000)/Sata(1,65535,0)N.....YM....R,Y.
> > Boot0003* UEFI eMMC Device
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x0)N.....YM....R,Y.
> > Boot0004* UEFI eMMC Device 2
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x1)N.....YM....R,Y.
> > Boot0005* UEFI eMMC Device 3
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,00006ef00000000000)/eMMC(0)/Ctrl(0x2)N.....YM....R,Y.
> > Boot0006* UEFI PXEv4 (MAC:000000000001)
> > MAC(000000000001,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> > Boot0007* UEFI PXEv4 (MAC:000000000002)
> > MAC(000000000002,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> > Boot0008* UEFI PXEv4 (MAC:000000000003)
> > MAC(000000000003,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> > Boot0009* UEFI PXEv4 (MAC:000000000004)
> > MAC(000000000004,1)/IPv4(0.0.0.00.0.0.0,0,0)N.....YM....R,Y.
> > Boot000A* UEFI Shell
> > FvVol(5eda4200-2c5f-43cb-9da3-0baf74b1b30c)/FvFile(7c04a583-9e3e-4f1c-ad65-e05268d0b4d1)
> > Boot000B* UEFI HL-DT-ST DVDRAM GTC0N
> > VenHw(0d51905b-b77e-452a-a2c0-eca0cc8d514a,000054f40000000000)/Sata(1,65535,0)N.....YM....R,Y.
> > Boot000C* ubuntu
> > HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\ubuntu\grubaa64.efi)
> > Boot000D* grub
> > HD(1,GPT,5a1ba4fc-f9b4-4da2-b5e1-065e9cd10e3a,0x800,0x100000)/File(\EFI\grub\shimaa64.efi)
> > Boot1001* helloworld
> > HD(1,GPT,40c323d0-6b76-47c4-bc82-e05bf5d23c8f,0x2000,0x200000)/File(helloworld.efi)
> >
> > As you described autogenerated boot options are on block device level
> > irrespective of the existence of an ESP.
> >
> > EDK II does not to care if /EFI/BOOT/BOOT<ARCH>.EFI is on a partition
> > with the ESP partition type.
> >
> > We should try to mimic the EDK II behavior.
> 
> I believe the UEFI spec allows VFAT partition type as well ESP
> partition type. For example a lot of Raspberry Pis won't load their
> firmware of a ESP partition type but will off VFAT even though they
> are essentially the same thing.

Right.  And therefore OpenBSD/arm64 uses partition type 0x0C; this
works with all EFI implementations that we have tested so far
(including EDK II and some proprietary implementations).
