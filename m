Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C361FD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD75B83D0F;
	Mon,  1 Dec 2025 18:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOJlJD7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4C683D39; Mon,  1 Dec 2025 18:51:08 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 598C583D07
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c75178c05fso1178367a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764611462; x=1765216262; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kqZqbYzLenr/HyaoacV8TcATRN4Xi+tcu1OScZDgwI=;
 b=jOJlJD7VI6ahnCdX/kB4RoLpBeUN+9gGsGzmB6o84GJ6hIsGivowA7pYC0KZo1i0JZ
 zHfPG0tuHLh7auYOpIOiW7n+RVa4s43u/MEKLY8m9GrhqntlmkcIhNDxwVqVJaP5Khp4
 t4++3ZEV0Y/ra91sCydadbVwOzg1hmpimKYx9Le8P8w9CRMDkKksTGWEuwbICHltTd3U
 7uNAsJT66zcs8qA8ag2jOb1+EcoEV22YAP/nP+ymOTb2hjPo0or8a/bHv3doXWh1326V
 H4M326TbzzfEvHJQKETWF4Ra0DOARtaUwRZDNxkt7L9L7MJ8ZdYsWkm0JboBqKdeG6wO
 sBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611462; x=1765216262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2kqZqbYzLenr/HyaoacV8TcATRN4Xi+tcu1OScZDgwI=;
 b=OlJkCRCaMLeAyMxHicyz0d2f+4jQSePBrj4w+95BiwjR77Lwsgw8uZLbA6YFLKhfib
 o/KhyHrWnnFfc0VimQSvqgRjMCNh3cnnKd3YWy5/1ktHhFokBjTYv6xUJ08doFSrG9kx
 McLZDnbzxUwAYRYrf3fhJw1AZ7K9KDK4P9dqUn+I2HIWcpMZr5CIPZirKhOmemdExzAA
 VtRNsIEDYz9NU/mvuUTPVYoWLLqioGlVNEu/ILMH4pek4gS3uzlk7WHFxUDCfS9P0rdp
 M4WeLXevhoMEj9T+stRkAOWlmEQJIxM60MWDNn7lMI2hWfFag+n/xdkQONnMag5UzkI4
 9eFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXctOiFIEcuV59f8lfcE/mA9ovuE9hY2Y6zX+R8zzaPF/LWQG0Px0r6XERWGsiEjG59wC6htK8=@lists.denx.de
X-Gm-Message-State: AOJu0YzNDZBnAe4kkJ6RCBWooFvL8Q//LXpxpbWbXKjr8QPH6/WbJ/2P
 Wvw1v/quAGKkPATqkOQCfh/DLiR/fCQaJzO/UC5mr7CigsGsd7KCS58pDF/TTUy8Mi4cPYetE0H
 SWqbiORs0wQRJjxo5ggs1hyZfa3M2Nhg=
X-Gm-Gg: ASbGncs2TrAyd6m+rJnQVMpx7JHiDx1PctRjB1F3RLEwU2SsRdsV6w4dUJ8X6OEXr+e
 vkxfV9xATRB22cToHCU14nLJi92fMvr1/cM+eiOe+4geFI9qYR/GtC5EFDtxavnRAw467Tw3nKS
 3zRSxDkcVAEzdoujwNEdBtOkjebGPBwLUfOWYcQ7TlXcrv8iFGcDNfil46Dky6MCoWEru860YIk
 kge/wHUKQ3XAfvCtLUmeBwKER7HrYmHaHBdC4WLAKpk3wL5/1mhZxJZs024mJ6NonAe4EF9
X-Google-Smtp-Source: AGHT+IHLTm1JNcqF+/ZFh4OUfhQZR4WiFFzwRSacaefwdIMi0g5mse5hd6liXDUqI4PE8i59b2c6tVkwzw9UFe2O+Tk=
X-Received: by 2002:a05:6830:4126:b0:7c7:1c87:4f95 with SMTP id
 46e09a7af769-7c798ac919dmr19332458a34.4.1764611462024; Mon, 01 Dec 2025
 09:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20251129064818.1587-1-briansune@gmail.com>
 <20251201165122.GH303283@bill-the-cat>
 <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
 <20251201170534.GK303283@bill-the-cat>
 <CAN7C2SBn6pq9DBO2GezyWcUVB6iZb-wQgmFyJF2ph7hV4WmiQQ@mail.gmail.com>
 <20251201174700.GM303283@bill-the-cat>
In-Reply-To: <20251201174700.GM303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 01:50:48 +0800
X-Gm-Features: AWmQ_bk4iJqaVKGtssA28cTxLffJuhGpSTtD_uQmy1xPQdpgpY7Fh9XErBijUgk
Message-ID: <CAN7C2SCDboW-=L_n9oZxercKyRKqO-1+d70dhjOo0WrMn384cA@mail.gmail.com>
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Tom Rini <trini@konsulko.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=A5=
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 02, 2025 at 01:14:43AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Dec 02, 2025 at 01:01:48AM +0800, Sune Brian wrote:
> > > > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=
=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:
> > > > >
> > > > > > Thanks to Jan Kiszka had provided info on
> > > > > > u-boot is not able to boot by u-boot-with-spl.sfp.
> > > > > >
> > > > > > All three TYPE, NUM, OFFSET mode methods
> > > > > > are nonfunctional on combined raw boot.
> > > > > >
> > > > > > The major cause is spl+u-boot structure is
> > > > > > defined as 4x[spl+zero_pad] + u-boot.img.
> > > > > > Deal to this configuration since GEN5 is used,
> > > > > > the spl would require to seek by an offset
> > > > > > on top of the spl offset. This means for
> > > > > > each spl=3D0x10000 the offset is 0x40000.
> > > > > >
> > > > > > However latest u-boot do not consider this
> > > > > > major structure on GEN5 socfpga.
> > > > > > Meanwhile, the default include file as Jan
> > > > > > pointed out is completely wrong syntax and
> > > > > > caused issue.
> > > > > >
> > > > > > Combining both concepts, the minimum fix
> > > > > > patch is provide as follows.
> > > > > >
> > > > > > 1) Offset is control and default set to a
> > > > > > proper offset under:
> > > > > > SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> > > > > >
> > > > > > 2) Only GEN5 socfpga will be affected and
> > > > > > minimized contamination on other devices.
> > > > > >
> > > > > > 3) Only one compuatation adjustment is made
> > > > > > on spl_mmc_load. And simply introduce the
> > > > > > offset adding by the kconfig offset control.
> > > > > > It should be 0 by default and gate as well.
> > > > > > So no possible harm should be done.
> > > > >
> > > > > This sounds like a tricky problem to solve in a "nice" looking wa=
y.
> > > > >
> > > > > The first thing that's unclear to me is, which of
> > > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
> > > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
> > > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > > Hi Tom.
> > > >
> > > > This issue all happened due to the old "u-boot-with-spl.sfp" struct=
ure.
> > > > The old auto generated u-boot-with-spl.sfp that file itself has spl=
 x4 and
> > > > zero padding. then it inserts u-boot.img.
> > > >
> > > > All are user dependent and have no restriction from the beginning.
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR any sector with A2 type.
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION any partition with A2 type.
> > > > All are completely dependent on the user SD MMC setup.
> > > > So users can even use the last sector aka the most end of the SD MM=
C.
> > > >
> > > > That's why it is so tedious. And users even allow to simply use u-b=
oot-spl.sfp
> > > > Then manually use dd  command to an offset that is in the A2 partit=
ion and
> > > > load the u-boot.img
> > > >
> > > > I didn't even like this idea and that's why I changed to the FAT bo=
ot method
> > > > after 2025.07.
> > > > I simply bypassed the inherent issue that Jan was faced with.
> > > >
> > > > So long story short either completely drop this old compatible boot=
 flow or
> > > > do it in a very tedious way aka spl offset on top of u-boot.img off=
set.
> > >
> > > Well, wait, this doesn't make sense. The first thing is you pick whic=
h
> > > of the three I asked about as to how to find everything else at boot.=
 We
> >
> > But I am afraid that is the case. You can actually use any one of three=
 options
> > to boot. The requirements on Altera Cyclone V or Arria V GEN5 socfpga r=
equire
> > a A2 partition to seek the SPL. So this involved "TYPE" and "PAR NUM".
> > Then for the complete RAW setup it simply just uses the sector offset.
> >
> > > don't need to support all three, we need to support one of them. I
> > > suspect the first thing is we need a default one-of-those if SYMBOL.
> > > This is what we do for MVEBU platforms which have, I suspect at least=
, a
> > > similar odd constraint.
> > >
> > > --
> > > Tom
> >
> > That's why I don't even like to count debugging from first place after =
 2025.07.
> > SPL on A2 partition u-boot.img on FAT32 boot very fine and no issue.
> > You don't even need to consider the u-boot.img offset on top of SPL off=
set.
> > Very clean.
> > Jan proposed to fix the RAW backward support on the old combined
> > u-boot-with-spl.sfp boot method, which is completely not a must.
> >
> > Hope this clears up some confusion.
>
> Yes, thanks. And I think I prefer the way Jan has handled these problems
> in his series, rather than this approach.
>
> --
> Tom

No worries. I did not propose this fix from the beginning.
Just drop this patch.

Thanks,
Brian
