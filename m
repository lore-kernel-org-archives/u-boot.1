Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D47D5E123
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 13:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797E089003;
	Sun, 10 Nov 2024 14:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VyXIKQ2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64776890D1; Sun, 10 Nov 2024 14:15:22 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B4888FAF
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 14:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso3746732b3a.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 05:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731244519; x=1731849319; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWSwVldVBNWd1seV4qgP64okJSeGPQIjpNc7LukBUcY=;
 b=VyXIKQ2ldnJWfcXrU3aO1Nk9rWes9hoqqEkc1oSaUmM70c6stbXnRxO73dSqQeapGn
 AWHuCuOWfM2pmGjFT6j3A3VwSFlzkYQq3Ur2/A9ovBIPmaOdAk6K/+DfR5n8Wj2WPl0s
 T4HpFmWk2FUTMRPLbvBwd46h4S7qcLVsNIFIVSj/csYvY3ui5tteWwTgUG9YXZ3PA2cW
 16jOn4ynO4i+IUG/SR1m+FevWziGZD68nrg6SfEa3jOiK2qqNoNDbRQLs8YDkKtp+D5b
 BnGplbL7p36RxLlMy64gTrwX1CQRFq/tDjrq5+YZj+WerJst9dTFBgT3XWGgCQNEA2nI
 qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731244519; x=1731849319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWSwVldVBNWd1seV4qgP64okJSeGPQIjpNc7LukBUcY=;
 b=kYc0McJfpfNVeqVqSxB9l2WPdva6PKAXyQcL6QkLrhCND2rZQuzcHw4OOv9F8Cnxxc
 umRG1YFNrY0LlH69cZBZiTNcEQAI6y2KjBjWETgkcEhJs0rnbUl8+UMtbkCC5KbLENvL
 ozJL6SPSoxGTQKnj3Lmk4dHZ/+OSwzQiHSLqkdW2NAYX9PQoMf5iJRVL/ZWzCcyb3YAK
 VpsIUi3w55zpaPo0IeQ+JK4m/DyeBN3g+dxLHVoYUaDmIXAzBQQr0wD66WYccEvy+2P1
 KFA4YIq+gMLYdj9JeZfAymXklqoqD3PkO4AghvIPdM7XrnNe4DLigSkmHUnYihm8evHu
 q0Tw==
X-Gm-Message-State: AOJu0YyX7RvicFWPXVdVr1Y8BrrT15TScWYI0rv6WyOtZLR5kIfvke2t
 MrDhXiZtdXSDarvZ6yCF9O58wEgRUujvBFIIjUHryLZbjDDFIniM2E5CnXi/wkLIWTynFS9ENzY
 dKJYRQzFab2V3TWlH5XQRG0fiSXM=
X-Google-Smtp-Source: AGHT+IFjFsnFoDKYC/sQo/tObSDpP1QGwBGpJ50fCZeP/qpl5GUnsBNlaGbZsNV9cUOYDHcQSzrSAt4Ykm9mb9d9mqw=
X-Received: by 2002:a17:90b:4b42:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2e9b166b6bdmr13413192a91.4.1731244518556; Sun, 10 Nov 2024
 05:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20241109200610.1615430-1-aford173@gmail.com>
 <20241109200610.1615430-2-aford173@gmail.com>
 <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
In-Reply-To: <690f6e55-ac68-4ef6-aeda-1f36a36e9a32@denx.de>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 10 Nov 2024 07:15:07 -0600
Message-ID: <CAHCN7xL84i08BhBVBEPZgwPtaj9QFirNpb1k5HpmTwnMttV9LA@mail.gmail.com>
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

On Sat, Nov 9, 2024 at 7:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/9/24 9:06 PM, Adam Ford wrote:
> > When FSPI_CONF_HEADER is set, the binary needs to be built such
> > that there is a configuration file located at 0x400 and the start
> > of the file that would normally be flash.bin starts at 0x1000.
> > This used to be done properly until the device tree was converted to
> > nxp_imx8mimage.
> >
> > Building these with the offsets built into the binman device tree
> > changes impacts how the actual image is built and the locations
> > of the various blobs aren't fetched properly and booting fails.
> >
> > Fix this by building a standard image as if it were to boot from
> > eMMC or SD, then use that image as the input for a second image
>
> This seems like a workaround for some broken offset calculation in binman=
 ?

This used to work until it was migrated to nxp_imx8mimage.
The blobs appear to be at the proper offsets, but the contents of
what's stored at those offsets are not the same.

If you're going to claim there is a bug somewhere, I would argue that
it's somewhere i nxp_imx8mimage.  However, if you look at this series,
the added benefit is the ability for Nano to be able to build both a
SD/eMMC image and FSPI images with one config which allows for the
elimination of extra defconfig files.  I am guessing Plus would have a
similar benefit since they have similar bootloaders.

adam
