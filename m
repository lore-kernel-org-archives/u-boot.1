Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72CCC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB80868BF;
	Wed,  6 Dec 2023 13:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Yb/fry/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1D687708; Wed,  6 Dec 2023 13:24:15 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C21980788
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso56860967b3.0
 for <u-boot@lists.denx.de>; Wed, 06 Dec 2023 04:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701865451; x=1702470251;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sixgFnuIb/tg4kurf3OcXPktwU3kUTMOE3HCwg9fsdQ=;
 b=Yb/fry/lT2WV6u8bdUlRgntoy9xr4qQ3wigADp845IhXg+kYSQc/d/R4LvItR6so0u
 XGfeRr5npz3DMvNVqJv14piZDuoenyLiNP2K/4rm4Vl/jNUaFTGh1ALKQ1JqDOj1nckS
 9xCarCjrrsQWrIEo7xnOQl3jWmHorG1kq+xzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701865451; x=1702470251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sixgFnuIb/tg4kurf3OcXPktwU3kUTMOE3HCwg9fsdQ=;
 b=EX5fHd7qkNcb1zHD+6kD0Pp0BuvuZPSMhcsG5Hg4/MQIKCJ9uQvx8AvviA4+Bd8mDt
 kfz1e2ca5ChFf9blFTArkze5wC5wm5c/4AGa/+BiTyRHVyU+djRNzZKaHh0mIPo0Ak9L
 IjegKiw6x2a9FzHbLidRHCnfEBVO2NTQ34ol5aaSJeoO4ZW4hsi4dWQdGWNiFGFQWn7X
 egmaqEJHjayb8eM5vohUwkG+kpWjmviARwEGs5PdGwQVwKI3tQzTAJ8ZstVsr06123s6
 kesh4vdxB6nGZOy1R1475OpQ918LPDv967dAgiOjt7LzA657zyYi2PpXe8Q/V3jWqiUZ
 rwvQ==
X-Gm-Message-State: AOJu0YyOpTGDyElcjPU7ZIhXU38ZLT23ik/QscdgxDqZ9fj2fCURKS9o
 lM5H0V6WGRswIhUpvFV/TdC75qVow2U2asyMbeJs/Q==
X-Google-Smtp-Source: AGHT+IHk8woDdxA/KSAlOoY6iJotPZQmeR2HQR3gkkJ2Qb9MpwVl9r79R0Ze2DPFCF6SqI1E0M6bKq79VccOKBrTJmM=
X-Received: by 2002:a81:8b42:0:b0:5d6:9814:c87 with SMTP id
 e2-20020a818b42000000b005d698140c87mr536129ywk.1.1701865451667; Wed, 06 Dec
 2023 04:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 6 Dec 2023 17:54:00 +0530
Message-ID: <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
To: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, michal.simek@amd.com, 
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

On Fri, Aug 18, 2023 at 9:51=E2=80=AFAM Ashok Reddy Soma
<ashok.reddy.soma@amd.com> wrote:
>
> This series adds support for Xilinx qspi parallel and stacked memeories.
>
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly
> between both the flashes so, both the flashes that are connected in
> parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
>
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical
>
> Spi-nor will pass on the appropriate flash select flag to low level
> driver, and it will select pass all the data to that particular flash.
>
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling
> the address space each operation is performed at addr/2 flash offset,
> where addr is the address specified by the user.
>
> Similarly for read and erase operations it will read from both flashes,
> so size and offset are divided by 2 and send to flash.
>
>
>
> Ashok Reddy Soma (7):
>   dm: core: support reading a single indexed u64 value
>   mtd: spi-nor: Add parallel and stacked memories support
>   mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>   mtd: spi-nor: Add parallel and stacked memories support in read_bar
>     and write_bar
>   spi: spi-uclass: Read chipselect and restrict capabilities
>   spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>   spi: zynq_qspi: Add parallel memories support in QSPI driver

This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
and let Linux approve the parallel and stacked otherwise it is very
difficult to maintain.

Thanks,
Jagan,
