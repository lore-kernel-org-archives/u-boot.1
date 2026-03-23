Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599D9F46126
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCBEA84154;
	Mon, 23 Mar 2026 15:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="O6EgTGjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E7884154; Mon, 23 Mar 2026 15:07:53 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7871684099
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64937edbc9eso2601280d50.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774274869; cv=none;
 d=google.com; s=arc-20240605;
 b=T2kckM5VbiEgLaGBjckKXtGHeECS3mkCStoUlMMptBj7thQo3W+qDpTADA7XFeog06
 aTXh7OxURrKVkZxv2EzW4Ga94G2PcGFXWmSml5fuf8ndOWWPa2C5PXs5r1szGkw3+Bhb
 jg3icW1UerffLkxi0WMGVq9d/Js88eGsDmBm+e9lwY5zrIv3zKYnGQdgdm3tTPjH5MRz
 QWuTcPzpMEJ/979o4TzVbnR+guZFoZBarpq7VGTncHx5OaELPjsgvIwchXsWTYDMO03R
 GX1dkpXfJKauWhuvF7BNZKIifI3XazppQGf5ngcqeyJymVx4+ZtecIWRstGoGkASrmUD
 3q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BSPcbjWelXgCmNhJxM91ioDOInOXx9uA0EUpTUweQuI=;
 fh=/KN9hdoQy9CA3T5HcjvmoQFbaoBuKwo+oDcI5oS1IgI=;
 b=ilLCnX91L1XtQXgytzA/gW8RY0nD2rCyADrukQxsUtr94K/UzZNc3AnRWODjeJe4Pc
 0IbfCqSRiFcAFTqfaKg5DpFlB0C9PKMmLmMZh+c0TRNknWzbXINkS/cQ4uLNkGM+vJD3
 qbBHJaW4jV21jjzmfguuEG0JxTKS5/1m9wQUHpm7UQJLGTzCI2AgeRBYJBcbp0w5I7ha
 ZixGyoy7nFMzTQoAhIOm7JpSx8tIYrOTL2VBelfiODaqmtNKOL9vLO4XdM3ou4l3d2OE
 H5h5J4asP1ezSl3PONZdM7orl4bRa6Zxpctery0v6XeKX8gjLSRPoe/CdqoLR5+9hxP3
 ua1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1774274869; x=1774879669;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSPcbjWelXgCmNhJxM91ioDOInOXx9uA0EUpTUweQuI=;
 b=O6EgTGjyAESgwuDdQtCctpCPMefiZlRY8ZULvU8ePKOm76M5yZua2gz2HXmiAGC/aO
 +DtkJKXLYA1FbDLJm+ceIebr6NFFfdZuVSs2UazYRD3gFilUzwnofDFQRcTYxzev0tZj
 OF/Ye5+4ukGYTTlfB3i2Tl4WA9LPQxKS4HlW+FbXXcmwyc2+WMz7knzosWLiay/fGW6Z
 b2W5jl+MW3w/SADNamqkX4sJj9m2jwrMNHqOlcHpeigF0O7OLsfxq3hYAmZ9bol18b2d
 n29iaB070XiX5EJXdJwzmgLDc7BEKtX1mvJOJ/APH26hqqqyczdTbBx+vE4+xTleBucO
 VRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774274869; x=1774879669;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BSPcbjWelXgCmNhJxM91ioDOInOXx9uA0EUpTUweQuI=;
 b=HA5wTwjon3p9LYY/APaBZf5zY0cb95n76XrrkIleX+i6+Bski2VTshn1gl+ILVnwBy
 b3McHGx9eXb414HcVlEE3Q6B012th5HBjLLjo0Y7z2lC6hs/a/rcuAENLr8e7n4Onjz/
 XJF6eT4nvuFBuQVh6ihF9s2mlgc+4EsoGcHqpJtYogmWoaTqXoHl4dBW6L+qgS5YTn5y
 sZO1GWBBB5j4v2GAdgKsx6iYq1NgbhVYdhhYlbcXBuo0nSXrZqhpmLrhLbkmFuYdXI/r
 m7zCgz6EVRe9fEk9nty50w8YbPMXBkdf3ZZ1iskDxlwSKTlBQI9sggro5nPyBWD1iPHV
 lfDw==
X-Gm-Message-State: AOJu0Yxily6/3lFzjFnsn4fWos6hAPko+IX9cb62NrD1x5LAw5fPz3xR
 VyaRqZKUsTzLhe/yQlucnc+ZuWQFGdlhs+gNFbXztRIzHip+WRCZ6Fv8QJmHHycnHnS+XbBL78M
 8jIiTEX9xgSThCr3O5ZvdtVSu0Oh3qpMKEzD3H/VezSyJHqkhYgFTHg==
X-Gm-Gg: ATEYQzyqL5EqRk8mkrgzj9OwSSVfHUnl3debhUrOTi5sID1KjeZiwlvU9KWti/M4Bv9
 FAsU359SLObsoBWGj615kifYKakZd0jhZeRzhBXciFlxumOHTma0Yw37B08Av/i6QlB6Ij2KqiV
 /csX1mEt7ILkh9WMKw935Fzn5ADO/3s4uJfQHU0g1zJu4CnZtHp+Cy44uwKmUvjuaucUMjH1LOY
 ghOQI2CJlNbmMSP8pv4vZyT2mHlEBjW6ZZ0O1dYxKnAHH9rchktXzijZUz6aMSs6CGa5aSCway5
 GIzepAmvNJmunt7lwtI=
X-Received: by 2002:a53:ee5e:0:b0:64a:f1ac:7bc with SMTP id
 956f58d0204a3-64eaa8b764bmr9371356d50.79.1774274869030; Mon, 23 Mar 2026
 07:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251028000426.90860-1-vlim@gigadevice.com>
 <20251028000426.90860-2-vlim@gigadevice.com>
In-Reply-To: <20251028000426.90860-2-vlim@gigadevice.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 23 Mar 2026 15:07:38 +0100
X-Gm-Features: AQROBzAR5UVx4RZhiwjTcmWzTcAyMY-mFlP2yBAKfS1tUa8BZvHdbGpQ-PxLNfI
Message-ID: <CAHTX3dLyOw8Zbz47OWk+MYBZca1HCNiH7UvVoYN6-K0qi856Yw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mtd/spi: add new part numbers
To: Victor <vlim@gigadevice.com>
Cc: u-boot@lists.denx.de, git@amd.com, jagan@amarulasolutions.com, 
 vigneshr@ti.com, tudor.ambarus@linaro.org, trini@konsulko.com, 
 Takahiro.Kuwano@infineon.com, venkatesh.abbarapu@amd.com, 
 marek.vasut+renesas@mailbox.org, havish.mutya@amd.com
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

=C3=BAt 28. 10. 2025 v 1:05 odes=C3=ADlatel Victor <vlim@gigadevice.com> na=
psal:
>
> GD25B512: ID C8401A, 3V 512Mbit
> https://download.gigadevice.com/Datasheet/DS-00649-GD25B512ME-Rev1.6.pdf
>
> GD55B01G: ID C8401B, 3V 1Gbit
> https://download.gigadevice.com/Datasheet/DS-00979-GD55B01GF-Rev1.1.pdf
>
> GD55B02G: ID C8401C, 3V 2Gbit
> https://download.gigadevice.com/Datasheet/DS-00980-GD55B02GF-Rev1.2.pdf
>
> GD55F01G: ID C8431B, 3V 1Gbit high performance
> I can send the datasheet via email
>
> GD55F02G: ID C8431C, 3V 2Gbit high performance
> I can send the datasheet via email.
>
> These parts are tested on Digilent Atry Z7 board and Xilinx Vitis.
>
> Signed-off-by: Victor <vlim@gigadevice.com>

Same comment as before. Full name and fix subject.

M

> ---
>  drivers/mtd/spi/spi-nor-ids.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index 666203c8485..5c6fc8a5155 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -123,6 +123,10 @@ const struct flash_info spi_nor_ids[] =3D {
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)  },
>         {INFO("gd25b512", 0xc8401A, 0, 64 * 1024, 1024, SECT_4K |       S=
PI_NOR_HAS_TB |
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
> +       {INFO("gd55b01g", 0xc8401B, 0, 64 * 1024, 2048, SECT_4K |       S=
PI_NOR_HAS_TB |
> +       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
> +       {INFO("gd55b02g", 0xc8401C, 0, 64 * 1024, 4096, SECT_4K |       S=
PI_NOR_HAS_TB |
> +       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
>         {INFO("gd25b512", 0xc8471A, 0, 64 * 1024, 1024, SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd55b01g", 0xc8471B, 0, 64 * 1024, 2048, SECT_4K |
> @@ -137,6 +141,10 @@ const struct flash_info spi_nor_ids[] =3D {
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
>         {INFO("gd55f512", 0xc8431A, 0, 64 * 1024, 1024, SECT_4K |
>         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
> +       {INFO("gd55f01g", 0xc8431B, 0, 64 * 1024, 2048, SECT_4K |
> +       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
> +       {INFO("gd55f02g", 0xc8431C, 0, 64 * 1024, 4096, SECT_4K |
> +       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NO=
R_4B_OPCODES)},
>         {INFO("gd25t512", 0xc8461A, 0, 64 * 1024, 1024, SECT_4K |
>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>         {INFO("gd55t01g", 0xc8461B, 0, 64 * 1024, 2048, SECT_4K |
> --
> 2.34.1
>


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
