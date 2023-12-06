Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93910C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 14:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083D0874BA;
	Wed,  6 Dec 2023 15:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ASq50Obd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3330A87457; Wed,  6 Dec 2023 15:44:14 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65ED87654
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 15:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db54ec0c7b8so883062276.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701873850; x=1702478650;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOJ33Ho1p1JbdFvm2mQishT3oCoHNM9ofaH9j3eBE48=;
 b=ASq50ObdbR0mzmElzmhd7iraArgPz4bleUn7E8MGPB5wY9alqKYQQOVibbx6GTH9C+
 wwAzkZTtvj++Jxaq/9lUj0MJeaqcQ7JhcDCfSixfd8RICvFFUVfl4zzKnRii671AbKSA
 aBcMI720y0V7k+yGdJ1qMG9ZYXrzquRYwbb2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701873850; x=1702478650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOJ33Ho1p1JbdFvm2mQishT3oCoHNM9ofaH9j3eBE48=;
 b=wei22jcMyHXa6hGtudi+ESUjxORLz3CyT6iJRQJ0kmG1YQsMsC8yDD9oMEsP7tGSm1
 /rkQKkuaNOWs2TOk7BUEGFBg7ssL6bmQ7EnsR3bFlxG2YLOqQR8tdD2mpmPCHt+7zrCB
 2dAYIxq7qoGUuEA4h4sqrqm+36IYeM7deO13/MhRtMsiVPs5zNPy8MMtG2E0NrPfy/dA
 huSSia3oQ9YDKC05hIKHLDciQ/SUa/s0IO0QYT+JVVDr4OU7lUoU1AVZ9M2aQOKB36U5
 FFSfsbIH6wCutQoAgEg5J19HBwz0vmk7v2H8xXU5B/sqW1vYZ0SAb2C8uUxKTG4czlDt
 q+lg==
X-Gm-Message-State: AOJu0Ywkx5GDEli0LaoS8vCrWxItVrN9i+YErDbkAYt9GB0DySQbK1t6
 VnOdjHpFboPMUxiHb64y34NxGFBp5QwYL9OshW3lEg==
X-Google-Smtp-Source: AGHT+IGNHCKbIET1jyyltWaCbROvQmNZuFMXT4VhkEJfFpn4X9blm5kd/Z5v/VxnuFmvgMCwIRZX8hCXmuzK4qqo6F8=
X-Received: by 2002:a25:d058:0:b0:db5:4013:3e22 with SMTP id
 h85-20020a25d058000000b00db540133e22mr2606788ybg.8.1701873850271; Wed, 06 Dec
 2023 06:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
 <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
 <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
 <d7471910-b1cd-4aeb-9d7e-165659394314@amd.com>
In-Reply-To: <d7471910-b1cd-4aeb-9d7e-165659394314@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 20:13:59 +0530
Message-ID: <CAMty3ZB3T63EK8W0qviVmevYTMhdnf+L8eTq9_tZgqoDB_U4ww@mail.gmail.com>
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, vigneshr@ti.com, 
 sjg@chromium.org, git@amd.com
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

On Wed, Dec 6, 2023 at 7:12=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 12/6/23 14:28, Jagan Teki wrote:
> > On Wed, Dec 6, 2023 at 6:11=E2=80=AFPM Michal Simek <michal.simek@amd.c=
om> wrote:
> >>
> >>
> >>
> >> On 12/6/23 13:24, Jagan Teki wrote:
> >>> On Fri, Aug 18, 2023 at 9:51=E2=80=AFAM Ashok Reddy Soma
> >>> <ashok.reddy.soma@amd.com> wrote:
> >>>>
> >>>> This series adds support for Xilinx qspi parallel and stacked memeor=
ies.
> >>>>
> >>>> In parallel mode, the current implementation assumes that a maximum =
of
> >>>> two flashes are connected. The QSPI controller splits the data evenl=
y
> >>>> between both the flashes so, both the flashes that are connected in
> >>>> parallel mode should be identical.
> >>>> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1=
 in
> >>>> nor->flags.
> >>>>
> >>>> In stacked mode the current implementation assumes that a maximum of=
 two
> >>>> flashes are connected and both the flashes are of same make but can
> >>>> differ in sizes. So, except the sizes all other flash parameters of =
both
> >>>> the flashes are identical
> >>>>
> >>>> Spi-nor will pass on the appropriate flash select flag to low level
> >>>> driver, and it will select pass all the data to that particular flas=
h.
> >>>>
> >>>> Write operation in parallel mode are performed in page size * 2 chun=
ks as
> >>>> each write operation results in writing both the flashes. For doubli=
ng
> >>>> the address space each operation is performed at addr/2 flash offset=
,
> >>>> where addr is the address specified by the user.
> >>>>
> >>>> Similarly for read and erase operations it will read from both flash=
es,
> >>>> so size and offset are divided by 2 and send to flash.
> >>>>
> >>>>
> >>>>
> >>>> Ashok Reddy Soma (7):
> >>>>     dm: core: support reading a single indexed u64 value
> >>>>     mtd: spi-nor: Add parallel and stacked memories support
> >>>>     mtd: spi-nor: Add parallel memories support for read_sr and read=
_fsr
> >>>>     mtd: spi-nor: Add parallel and stacked memories support in read_=
bar
> >>>>       and write_bar
> >>>>     spi: spi-uclass: Read chipselect and restrict capabilities
> >>>>     spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> >>>>     spi: zynq_qspi: Add parallel memories support in QSPI driver
> >>>
> >>> This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
> >>> and let Linux approve the parallel and stacked otherwise it is very
> >>> difficult to maintain.
> >>
> >> Linux thread is here and it is pretty close to be merged.
> >> https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra=
@amd.com/
> >>
> >> DT binding is already approved but have no clue how big effort is to s=
ynchronize
> >> it. When was it synchronized last time?
> >
> > It wasn't. U-Boot spinor has its own and makes changes accordingly. It
> > would be better to sync the Linux. This is what I'm referring to here.
>
> Wasn't this the style which barebox guys wanted to do long time ago in U-=
Boot
> and the reason why barebox was born?
> I don't think that this can happen over night and also I don't think make=
 sense
> to pretty much close spi framework for new changes till this happen.

Don't understand barebox theory here. I'm talking about code
maintenance in u-boot spinor becoming meaningful if the core area gets
synced with Linux.

Jagan.
