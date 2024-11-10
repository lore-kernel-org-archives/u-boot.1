Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48DAD12D49
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 17:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB4368914D;
	Sun, 10 Nov 2024 18:22:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GCeo1TTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B98E789182; Sun, 10 Nov 2024 18:22:02 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 851078911A
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 18:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7f3f1849849so2571743a12.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731259319; x=1731864119; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6nllbcA81WsLNxrLnejSftwZZ+xVmp3F0/u6bz6iK0=;
 b=GCeo1TTYNt1aG0s7hgOvCWzT7cLPKwbJ4AIzLmeKsnKwRqUg5nWR9kIRjgSEJp7Jpt
 bUS5czbo2x8LokSs+OJ39VYKFzF4nO/0+hLz1Weci9OWNPbveksiX6PTSk3HsIUUXfZx
 o9xlJN1TY+hJ5T66stInswLq3/xrN6J/7wiTXq4TKyFNoW6CTnEQRIrdadqzrxQVw1YP
 TVyYhZ2fnTHSnt71njeBvfYJFuRFSBTeAjEjdA8oGsqGimXemCm3wPZKMSdRUtfw9iuC
 LdtDInaLsoTc/cKjcZwZpxzpMqI71/nkzvDh237rdqjNvUyJ8rNp3cJInPMrBIojL+Zr
 za7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731259319; x=1731864119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6nllbcA81WsLNxrLnejSftwZZ+xVmp3F0/u6bz6iK0=;
 b=snUedxFh10z/gkBlPL9RR71tL2FtVzl/Dz1ed0vXJQB+hKAJ8btfcIRClJmxt5mXVu
 C0pUVZTaKSMaUfwcIewFU/c5vV3kFeMgC2zGA6mBy9kMpZTpLZLOphzheL6HkpO2zcAw
 x4t8LBoYmVsTxYFeOIgH9EdUgq7p2Tcp0KfekbkvZ/mkntne/AocCcVT0AMIpznXM1Pv
 h3DxfYvC0X1tQ2GMhDgOo2n+Evhz75rpaYFPuqn4GOuLD3Y0ot41Yot7LY6UC9Ia/paX
 z/3442b4bSR4eg936E89/n7gcbO9z2Vvq3Hdx+30B6oV92VePRBe3BoAs2gKFwtRxY/7
 MGmg==
X-Gm-Message-State: AOJu0YxwvgplNYVEvZRrlIHCOFi56odQ849JkxRQS2sQMSAY9mWaE2Rq
 t/QyJufnwqWhc0HPEiNp2leuC47laaZ5P6iCSzQMQswg66eYeH+UZEdkXIRLxtBNBD8upPvslnd
 E3gK7zLsn5fzMl5S/86mPm7rIkzY=
X-Google-Smtp-Source: AGHT+IH5EAPVbW4BO5IXFfLoMCrUmFbxfDS3oRODiIwQmSoDVGXcbptR9Qq/n7ICcjDEQaJlAFgt/CF5qk35iHmxZEo=
X-Received: by 2002:a17:90a:d450:b0:2d3:da6d:8330 with SMTP id
 98e67ed59e1d1-2e9b16556edmr14666888a91.4.1731259318785; Sun, 10 Nov 2024
 09:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
 <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
 <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
In-Reply-To: <187dd32c-642e-4595-a90f-4213fd68f6cc@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 10 Nov 2024 11:21:47 -0600
Message-ID: <CAHCN7xL1Cp0kkmo3bTPRsKPaqbQFqTXu7spgY2LjOYU0FS3heg@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: imx8mn: Fix FSPI booting
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, lukma@denx.de, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Sun, Nov 10, 2024 at 10:42=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 11/10/24 2:15 PM, Adam Ford wrote:
> > On Sat, Nov 9, 2024 at 7:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
> >>
> >> On 11/9/24 9:06 PM, Adam Ford wrote:
> >>> When FSPI_CONF_HEADER is set, the binary needs to be built such
> >>> that there is a configuration file located at 0x400 and the start
> >>> of the file that would normally be flash.bin starts at 0x1000.
> >>> This used to be done properly until the device tree was converted to
> >>> nxp_imx8mimage.
> >>>
> >>> Building these with the offsets built into the binman device tree
> >>> changes impacts how the actual image is built and the locations
> >>> of the various blobs aren't fetched properly and booting fails.
> >>>
> >>> Fix this by building a standard image as if it were to boot from
> >>> eMMC or SD, then use that image as the input for a second image
> >>
> >> This seems like a workaround for some broken offset calculation in bin=
man ?
> >
> > This used to work until it was migrated to nxp_imx8mimage.
> > The blobs appear to be at the proper offsets, but the contents of
> > what's stored at those offsets are not the same.
>
> I know, this is what Lukasz reported too.
>
> > If you're going to claim there is a bug somewhere, I would argue that
> > it's somewhere i nxp_imx8mimage
>
> I agree with that claim. Well, by extension, the problem might also be
> in binman itself.
>
> >.  However, if you look at this series,
> > the added benefit is the ability for Nano to be able to build both a
> > SD/eMMC image and FSPI images with one config which allows for the
> > elimination of extra defconfig files.  I am guessing Plus would have a
> > similar benefit since they have similar bootloaders.
> This I do not agree with. If the intent is to generate two images, then
> there should be two full binman descriptors, one for each image (one for
> flash-plain.bin and one for flash-fspi.bin or some such naming).
>
> Can you try and fix the FSPI generation first, so an FSPI compatible

I am not a python programmer, and I couldn't determine what was going on.

> flash.bin can be generated using binman only, without the dependency on
> processing non-FSPI compatible flash.bin ? I think the intention of
> binman was to replace all that ad-hoc pre/postprocessing of blobs.
