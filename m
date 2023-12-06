Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434D2C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA173871D7;
	Wed,  6 Dec 2023 14:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SDvPE/ZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1294C807E4; Wed,  6 Dec 2023 14:28:30 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F1AF871D7
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 14:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db539ab8e02so5521604276.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 05:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701869306; x=1702474106;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZHy/05eo5mRfy9PHI2oLC1HSUA4sjV6HKxnFlP3/Pk=;
 b=SDvPE/ZQKFPMWbWY+xfgoBKv+EY0LGljvk/NJRYLjpqdTdm+7/na3gkN+HZ9b7EvP9
 QXzH4m+BUL1bAtmgml0if4qeu15Mfx3UPMIKuL4zhLWZrSxLrfj2RmtJO5h+UbD/UWry
 oG2ax/VggdrbPz2T44H83SwnUdvlQgUbCcAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701869306; x=1702474106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZHy/05eo5mRfy9PHI2oLC1HSUA4sjV6HKxnFlP3/Pk=;
 b=Op7HDLhoO5sdHFyDma902pvZuBOcye6GkXUDjQpSxb4SbcHUKZ4agCTQvh0IgqTzfm
 cyH5d+W6IC4PD9owzcxGJ/Ygz2P8DCsccoqiWzAWOwf9JCsQT1mRX++EXCMXZNkMFciO
 vdc+/8pgcY0/iSOkvsA7/SKrNmgkiQ5cZGBDp2/byopVp9oxNvj9viP2wdweSAQwA45z
 SDn9bwn4DVbkN6wyRZk3knVk47nWNXwNILJkIS3trEJ/PJUrVn71Os2iTQ2cAW2Wbjfe
 7HOobF0mUFgg5JAXcBxR7YQp+jLy/k/Mu8/sTmNRXgfotLfGdgLaMIutd/e6/cNIUrnF
 bOvw==
X-Gm-Message-State: AOJu0YyClzE1jD+P1VQkgEZOK4FoQ6sfo0mACwQEeGh6g/vlaNKgfGLX
 MybIvzHAb777BNsmOBRoPCvRc+7GfJr1PVt6PffLDuKXezjW7E9W5UM=
X-Google-Smtp-Source: AGHT+IG5x2+VXXB+at7Y4n0mzmVTXia7Hsiho5bxw6rK72/f6R9S14kJe+HixWEuHe6V2JFwFYjoKPvpu9kCD6X8C1Q=
X-Received: by 2002:a05:6902:1007:b0:db5:3fef:ae02 with SMTP id
 w7-20020a056902100700b00db53fefae02mr765137ybt.10.1701869306051; Wed, 06 Dec
 2023 05:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
 <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
In-Reply-To: <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 18:58:14 +0530
Message-ID: <CAMty3ZDfaiTKMv4od52Czmha8=10V44iROx-PA=Mh3L6OeB7SQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, sjg@chromium.org, git@amd.com
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

On Wed, Dec 6, 2023 at 6:11=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 12/6/23 13:24, Jagan Teki wrote:
> > On Fri, Aug 18, 2023 at 9:51=E2=80=AFAM Ashok Reddy Soma
> > <ashok.reddy.soma@amd.com> wrote:
> >>
> >> This series adds support for Xilinx qspi parallel and stacked memeorie=
s.
> >>
> >> In parallel mode, the current implementation assumes that a maximum of
> >> two flashes are connected. The QSPI controller splits the data evenly
> >> between both the flashes so, both the flashes that are connected in
> >> parallel mode should be identical.
> >> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 i=
n
> >> nor->flags.
> >>
> >> In stacked mode the current implementation assumes that a maximum of t=
wo
> >> flashes are connected and both the flashes are of same make but can
> >> differ in sizes. So, except the sizes all other flash parameters of bo=
th
> >> the flashes are identical
> >>
> >> Spi-nor will pass on the appropriate flash select flag to low level
> >> driver, and it will select pass all the data to that particular flash.
> >>
> >> Write operation in parallel mode are performed in page size * 2 chunks=
 as
> >> each write operation results in writing both the flashes. For doubling
> >> the address space each operation is performed at addr/2 flash offset,
> >> where addr is the address specified by the user.
> >>
> >> Similarly for read and erase operations it will read from both flashes=
,
> >> so size and offset are divided by 2 and send to flash.
> >>
> >>
> >>
> >> Ashok Reddy Soma (7):
> >>    dm: core: support reading a single indexed u64 value
> >>    mtd: spi-nor: Add parallel and stacked memories support
> >>    mtd: spi-nor: Add parallel memories support for read_sr and read_fs=
r
> >>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
> >>      and write_bar
> >>    spi: spi-uclass: Read chipselect and restrict capabilities
> >>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
> >>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> >
> > This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
> > and let Linux approve the parallel and stacked otherwise it is very
> > difficult to maintain.
>
> Linux thread is here and it is pretty close to be merged.
> https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra@am=
d.com/
>
> DT binding is already approved but have no clue how big effort is to sync=
hronize
> it. When was it synchronized last time?

It wasn't. U-Boot spinor has its own and makes changes accordingly. It
would be better to sync the Linux. This is what I'm referring to here.

Jagan.
