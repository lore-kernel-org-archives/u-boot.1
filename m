Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10085D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67B4283C6E;
	Mon,  1 Dec 2025 18:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EBsENiQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3D483C64; Mon,  1 Dec 2025 18:02:03 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138D883C39
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c75178c05fso1154135a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764608520; x=1765213320; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICvQjsvLoGamxSXLAH0Hu4Zh7n/1MviYMrkvBKkBoco=;
 b=EBsENiQxo8pPOlWT4Ix4U1pWOwep+3tX0BFaVaYf+TzHUmJDKEw+jtC1XxxkMu+ugH
 IywrRSllLbxIBgPh+jXm++OPDdhy4BgC/x90oNvB/SQ42mrfXs5SM++CaNL917kzUxMk
 8Nk3ma70oblvI3fzDnCnIHqY8XfxqLRmP3kFww7QjmrILLDZwZW9Nhsp0IzhL51SFjZH
 JswV9XTESoEAnVR4sJKp9E1vTy6FFq0dIItvjkJAaRbT1SrEl67yQ6VeBl8ayriRGMI/
 X1hS8eObac8gmsT5t+y0t+hWZVzAp7WPrwC1OumOoFXvHnh65VlbTVH9hcoYGoLe2KxV
 nIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764608520; x=1765213320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICvQjsvLoGamxSXLAH0Hu4Zh7n/1MviYMrkvBKkBoco=;
 b=vqbXxpXY5Rb2Mjvkr/7Nk938BCgjBDx8PSvMKYlQxjhro9gOEHw0pxlKS2K0pSiFK6
 oT4oOitTkDaVgTzT5Dmfkm7eX/kqXaVTO7ADptjVSf9uBYqyTLuvfXtktRJeyTsPrG12
 AJ3GGzwoff2Q5tnFmhILgzxi4wmzbTQrGCR87MRwTkqoo2hK6YoJzewzzJd1b/VExGxt
 LtLumO+tfRm2CF2kmosNppNJAdlIHqtShX9HIVflpwiM0P4+z7F+fl1qJCnB2iTmvTXr
 6tN84MdT05v65jPPrq7SGWUMxB4OCHgBshyD+/PXw27LY+qIkCmJ3n519QsZQiL5AU56
 8bDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZSZtyHbDilM7wA8bJtLLJ7q1HKXUkK7IFfmwlasr61iAur158KopvhvHuxGpk8D5f8/TreSw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0AOUR3OKpmXtRC1gtAuCALhXPrrCYgnAXl4K16KtoO2D5HKZa
 2AI5OAggdlsNsWi/lmZwvqKjeKlgNeXKklS08JNAq4CiMK3fEIM47RI+tsQLU18fgdw/n6Sgo2j
 PcGjrJTzwmMsCDHFAzmVv2r1oFkwLaY4=
X-Gm-Gg: ASbGncsFakULXq73xec1h0VtkicB0XADYdgwyYEb8zfSRp2DvAV11SOGNtn8TWa48f3
 VmgZoUrzgbHFWh/dX1TLEt75VtQuyjwi0GrSEEJ95AfVNH/98PzP/XfumPtdHZ8upf0MaHAvU7q
 BtVelSgLTWZ3kFL0bX/a7BkRVgfhfmqLnaS5kfjjt9LZ596Zhh4v8vT1JpGSHvJQXkVio4fdthU
 4YcVK7NRLoQxMqKShsAyJb48W5yAVskrSDyOMcaatRpmrB1kpmRbibpCGTVNTFeUZZs797L
X-Google-Smtp-Source: AGHT+IE5Egb0AbHThCmSDXpEQuMObhi2wTvKpMmUirlbtGLzYKtkI5hpahQ2wfLusWPWcsPYV81Ph9uaHoMEyKOsAHM=
X-Received: by 2002:a05:6830:6e05:b0:756:a322:311 with SMTP id
 46e09a7af769-7c798b03853mr21839298a34.10.1764608519453; Mon, 01 Dec 2025
 09:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20251129064818.1587-1-briansune@gmail.com>
 <20251201165122.GH303283@bill-the-cat>
In-Reply-To: <20251201165122.GH303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 01:01:48 +0800
X-Gm-Features: AWmQ_bmIQWzyRdbrJbpsATZFXd5dpzWnX6Llx5wL5e9T45OVO9cB2xcgjl6ZsOo
Message-ID: <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
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
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:
>
> > Thanks to Jan Kiszka had provided info on
> > u-boot is not able to boot by u-boot-with-spl.sfp.
> >
> > All three TYPE, NUM, OFFSET mode methods
> > are nonfunctional on combined raw boot.
> >
> > The major cause is spl+u-boot structure is
> > defined as 4x[spl+zero_pad] + u-boot.img.
> > Deal to this configuration since GEN5 is used,
> > the spl would require to seek by an offset
> > on top of the spl offset. This means for
> > each spl=3D0x10000 the offset is 0x40000.
> >
> > However latest u-boot do not consider this
> > major structure on GEN5 socfpga.
> > Meanwhile, the default include file as Jan
> > pointed out is completely wrong syntax and
> > caused issue.
> >
> > Combining both concepts, the minimum fix
> > patch is provide as follows.
> >
> > 1) Offset is control and default set to a
> > proper offset under:
> > SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> >
> > 2) Only GEN5 socfpga will be affected and
> > minimized contamination on other devices.
> >
> > 3) Only one compuatation adjustment is made
> > on spl_mmc_load. And simply introduce the
> > offset adding by the kconfig offset control.
> > It should be 0 by default and gate as well.
> > So no possible harm should be done.
>
> This sounds like a tricky problem to solve in a "nice" looking way.
>
> The first thing that's unclear to me is, which of
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?
>
> --
> Tom

Hi Tom.

This issue all happened due to the old "u-boot-with-spl.sfp" structure.
The old auto generated u-boot-with-spl.sfp that file itself has spl x4 and
zero padding. then it inserts u-boot.img.

All are user dependent and have no restriction from the beginning.
SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR any sector with A2 type.
SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION any partition with A2 type.
All are completely dependent on the user SD MMC setup.
So users can even use the last sector aka the most end of the SD MMC.

That's why it is so tedious. And users even allow to simply use u-boot-spl.=
sfp
Then manually use dd  command to an offset that is in the A2 partition and
load the u-boot.img

I didn't even like this idea and that's why I changed to the FAT boot metho=
d
after 2025.07.
I simply bypassed the inherent issue that Jan was faced with.

So long story short either completely drop this old compatible boot flow or
do it in a very tedious way aka spl offset on top of u-boot.img offset.

Thanks,
Brian
