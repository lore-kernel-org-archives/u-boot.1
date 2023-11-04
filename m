Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB711C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5478718A;
	Sat,  4 Nov 2023 20:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bF/fc+Y4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B88187163; Sat,  4 Nov 2023 20:44:14 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447A986EEE
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so45095511fa.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127043; x=1699731843; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meGqjiO934B+9nP7qFMan9HgGw4ApSouuNG/KdpAkag=;
 b=bF/fc+Y4byL9EkmNHFYuP6HpRUSGK0Mja2iGmbuxqvmO5g2V520wswS2DbHpRotEWL
 JQgyKmSqtBnprl2qAGfiOGNrhC4FPtwfRXGlSgbGAFzCgmLsedfPH7qrcGLd+IoBweBU
 hhQK6jUQknaAmGREHBTrLfkJ0/Xi7UJzqI0+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127043; x=1699731843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meGqjiO934B+9nP7qFMan9HgGw4ApSouuNG/KdpAkag=;
 b=XyCn4mLX2YgjpaUw14NU2PpQdXkTAnycyNfHn24TyX7RHQTbPKDrUdeWMKlrzzNLpp
 T+J075rlKqEHa1tsOeRMS5ZdLM1QO/MrC7ep/OZ2CVaEBZ79Ga4TDf/xrt17Zgo/8Qhf
 mlYgyaRXmnmyDWZ9mxc+jtV+bG3y7S2DBuDAGagtQL0bogwqsjhKTDVKeuib9oVrc0J0
 xQRObskF1sFLVYVuQx6Pig6V8Xd8+15aiv1kYfa9wZO4BQWjk311kZomo/izQ9jIWBZS
 9ZjyCPFxcgD1xlUJpROpmYCw4cTB9Fsasrxt0JH7f54e/nhdeJBMLhkJBOQlEH2M+Dxs
 PFZw==
X-Gm-Message-State: AOJu0YzwPreDge+62u3A/NGz2QjAhA3R7v/uBl5DMryeA+F5Hgi+8AZR
 8MgEc697pWtpP0ev6MmOIEWe5t9KahwpRTjIljBToA==
X-Google-Smtp-Source: AGHT+IFwPgiX9UQ7teSns8Syt3qwK67TuS3GnjgCmhMQqPGR7xqB1RJSBAcyUYkgeGFC85y6LyYGWCKpoMElfj+v5Fc=
X-Received: by 2002:a19:f613:0:b0:509:47c0:5454 with SMTP id
 x19-20020a19f613000000b0050947c05454mr6740117lfe.12.1699127043363; Sat, 04
 Nov 2023 12:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867669CC8B5EB411BDEF45348CA5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB867669CC8B5EB411BDEF45348CA5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:43:52 +0000
Message-ID: <CAPnjgZ1r60UomKz5DkH-POvsj0jKq1rNENniwZpAn3AWHk94EA@mail.gmail.com>
Subject: Re: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk is
 gone in next scsi scan
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Richard,

+Heinrich as I think this is an EFI bug.

On Thu, 2 Nov 2023 at 19:37, Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
>
> Hi Simon:
> I found that the EFI complained that the disk install path is not updated=
 for the second disk.
> The install path is =E2=80=9CEFI: installed device path '/VenHw(e61d73b9-=
a384-4acc-aeab-82e828f3628b)/Scsi(0,0)'=E2=80=9D
>
> when first disk is added.
>
> But the path is same when the second or later disks are added, and EFI re=
pors that the path had been installed already.
> EFI: Path /VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b)/Scsi(0,0) already =
installed
>
>
>
> That=E2=80=99s why the below error when run efi_disk_create_raw() functio=
n.
>
> Adding disk for ahci_scsi.id0lun0 failed (err=3D-9223372036854775788/0x80=
00000000000014)
>
>
>
> Do you have any clues about this?
>
> Thanks in advanced.
>
> Best Regards
>
> Richard Zhu
>
>
>
> From: Hongxing Zhu
> Sent: 2023=E5=B9=B411=E6=9C=881=E6=97=A5 10:57
> To: sjg@chromium.org
> Cc: u-boot@lists.denx.de
> Subject: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk i=
s gone in next scsi scan
>
>
>
> Hi Simon:
> Nice to meet you.
> The u-boot I used is based on v2023.04 tagged version.
> Layerscape LX2160A RDB board has four SATA controllers.
> Based on LX2160A RDB board and two or more SATA disks connected.
> I encounter one =E2=80=9Cscsi scan=E2=80=9D problem.
>
>
> After the first SATA disk is detected and probed properly in the first =
=E2=80=9Cscsi scan=E2=80=9D.
> The other disks would complain that =E2=80=9CEFI_NOT_FOUND=E2=80=9D error=
 listed below,
> when run the first =E2=80=9Cscsi scan=E2=80=9D command in uboot environme=
nt.
>
> Does this error matter?
> BTW, =E2=80=9Cscsi info=E2=80=9D says that all disk info can be dumped, a=
nd all disks are works well,
>
> after the first =E2=80=9Cscsi scan=E2=80=9D
>
> In the consecutive rescan operations issued by =E2=80=9Cscsi reset=E2=80=
=9D or =E2=80=9Cscsi scan=E2=80=9D commends,
> the disks would report =E2=80=9Cunable to unbind devices (-1E)=E2=80=9D e=
rror.
> The first disk is disappeared at all after the next =E2=80=9Cscsi scan=E2=
=80=9D operations is finished.
>
>
> Did you used to encounter such kind of issue?
>
> Any suggestions and guidance are very appreciated.
>
> Logs:
> =3D> scsi scan
>
> scanning bus for devices...
>
> Target spinup took 0 ms.
>
> AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>
> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>
>   Device 0: (0:0) Vendor: ATA Prod.: ST1000DM010-2EP1 Rev: CC43
>
>             Type: Hard Disk
>
>             Capacity: 953869.7 MB =3D 931.5 GB (1953525168 x 512)
>
> Target spinup took 0 ms.
>
> AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>
> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>
> Adding disk for ahci_scsi.id0lun0 failed (err=3D-9223372036854775788/0x80=
00000000000014)
>
> SATA link 0 timeout.
>
> AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>
> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
>
> SATA link 0 timeout.
>
> AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
>
> flags: 64bit ncq pm clo only pmp fbss pio slum part ccc apst
> =3D> scsi info
>
> Device 0: (0:0) Vendor: ATA Prod.: ST1000DM010-2EP1 Rev: CC43
>
>             Type: Hard Disk
>
>             Capacity: 953869.7 MB =3D 931.5 GB (1953525168 x 512)
>
> Device 1: (0:0) Vendor: ATA Prod.: ST500DM002-1BD14 Rev: KC45
>
>             Type: Hard Disk
>
>             Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)
>
> =3D> ls scsi 0:1
>
> <DIR>       4096 .
>
> <DIR>       4096 ..
>
> <DIR>      16384 lost+found
>
> <snip>
>
> <DIR>       4096 var
>
> <SYM>         12 linuxrc
>
> =3D> ls scsi 1:1
>
> <DIR>       4096 .
>
> <DIR>       4096 ..
>
> <DIR>      16384 lost+found
>
> <snip>
>
> <DIR>       4096 usr
>
> <DIR>       4096 var
>
>
>
> =3D> scsi reset
>
>
>
> Reset SCSI
>
> scanning bus for devices...
>
> unable to unbind devices (-1E)
> =3D> ls scsi 0:1
>
> ** Bad device specification scsi 0 **
>
> Couldn't find partition scsi 0:1
>
> =3D> ls scsi 1:1
>
> <DIR>       4096 .
>
> <DIR>       4096 ..
>
> <DIR>      16384 lost+found
>
> <snip>
>
> <DIR>       4096 var
>
>
> =3D> scsi info
>
> Device 1: (0:0) Vendor: ATA Prod.: ST500DM002-1BD14 Rev: KC45
>
>             Type: Hard Disk
>
>             Capacity: 476940.0 MB =3D 465.7 GB (976773168 x 512)
>
>
>
> Best Regards
>
> Richard Zhu
>
>

Regards,
Simon
