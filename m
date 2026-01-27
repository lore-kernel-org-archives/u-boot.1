Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC02D25953
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E9E983F53;
	Tue, 27 Jan 2026 07:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cDcTKIem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2789983F64; Tue, 27 Jan 2026 07:54:47 +0100 (CET)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6E283F3F
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1233b953bebso13310454c88.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 22:54:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769496883; cv=none;
 d=google.com; s=arc-20240605;
 b=jMQxOGjd0rW5gRWDPD50NUD33tznGM0OEiv3J01Hyzp4gm/xFVDzJ/fsgPOh3oWsHp
 DrWCADNx+VUvUc4jhfmtI2YDXyYsMAC5jQ2RHFYp3iM9mKp52Nk4Dy/aa9OfCwShj7W2
 MspO2lJFYM5Fp0ppDQJ5RbRhDOp/lS+i+w0M3E3rX9xyZHKgy0MJf5XRNlzegYZAiOVG
 QXvHhqPWeYvGtkefkMuMpZiOIUH561hvQOlqebRAKZFSBDuJggTo4hTE4Tr4xtWcgNKA
 K6TUPJDsKnmXLE87+y1I1RzEAKzP/RKT9OslKFpVV4DiJ4DMpCzcYwyH8gO4eCvwHrcC
 sn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PWdOG2ngK34fciheZCZjRLpYsMU7H9bZyTKjIWtMxl8=;
 fh=GpFMhgVxaag1JGsdicoPZImg0niy86xX71QW6zIkQqU=;
 b=cPtD1Um9FhnQnCVB8Eb5x0mSEIcBUH0zM+N9F5x6+0WSq2KuWRtyTuWF0gn2cnJ+As
 toISyOOc4CuwuM9WydK0NKtbtcro5vGp4t89yKeP85wN8P3dp+kzoOh1xUl5CREXie6W
 xF/NEVTBLpwVJtloHPjP6W6+wRZrL3aP6BQ0eZcUoEkOH3GYQepRpJkN10YKjZNM2qYo
 AbYWeI8DvuqEPq1+T5QRdBEqXwz3El1LsTj/SfHI9mnv+mL/M4s+cSKNvlIpNZLinIz8
 Ij3Uf/JpGFEbPPxg7ovRHobqqzwVQ2fFqXhiBH9cjYRNBU7sG/+sf769gx8qr3hnXgL/
 L+YQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769496883; x=1770101683; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWdOG2ngK34fciheZCZjRLpYsMU7H9bZyTKjIWtMxl8=;
 b=cDcTKIemxNs98GQKPBqW8jo75jfF2qd6OjOhDTZVpcF+jOY0VCEHAjylAdueTrdRjl
 jjDXu2bZUbxn5/3QmmwKq41CgzCRFbzRH2ukz99XHgM+WCBZilfhEgGZVyM5FXLNJvcm
 J7WKAskzyq3FJN/F2tCrH7o/sfmMOhBR9Y0ofj8TvfYKsvMjOAvrYou9bI4weaVUbC/e
 YGwLGhwiZ3ue/eTT+pRzTMKR07ApIKSnCP4PV/xH70/sJv/SCLWpuyYac4RH4ZdXzQEB
 iic5RryLGYwI0trYCxRl1N5hw0rCMV/OplcEO+k+A+9TmGxKpUKeNQKpsiknKRyfN5lN
 O/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769496883; x=1770101683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PWdOG2ngK34fciheZCZjRLpYsMU7H9bZyTKjIWtMxl8=;
 b=D23jp/hWchaxciVkep+BHx2/RuXNKAjie0MDAsvP3V0smDq0LuEJIu6swmzLvjYcAG
 914fRdIIVzlCIDn0OMX6QRPvu/PNdEsREmfxphlX+TKCHV19yXSuUy4r0Gbv/v8c8bkh
 fEYRynhoPrYJXxwC1Kjgx5p+4dg3HD6UDbc1qq1ugn4EZe9u92lklXkNwmxzyDbb/Rt3
 PY/4TEbF4G/Tz++A9SJeMELeNHNzKnefOJNDK4ZfJJ6t+1v0e6TWnWImDNmwPe2BaFcQ
 gJuZ2r08cUfaIyA7C/8ofD7FTRcU1pgndhm9Inl44FnpxqxDEH5ebgPaD0BcJcA7+R5F
 mMDw==
X-Gm-Message-State: AOJu0Yyexl9EF5MUAVGotQNYzcUAAptCA8E9UQXGZ7IcksTs7KcnmN29
 4SFHcarF2q5R7A+uh77LDszEj2HuUvsiiwYygmWSTDHJjRPeeQgNriJ0hv065pSsLKXzweROT9j
 Q1Voth9in8QhvoGqRIqsLXav3UibEBg==
X-Gm-Gg: AZuq6aJQqeY7MiOIS6n1LSzHrjNDl6h53FLGzfGsWSfE/Abj8Hs9lqXVJGeI8ycDldT
 ACsF21a4YkL8manSIB0mOYa/7l/jetsmZVEALIaW4GrECPz4OlFioPOFMtNbVhzeIIKFsZYScwb
 L23OFrKJFn5QboeA8ClXpKJ7YBHpQrDN2DZrNNBdpCaA8FoHeuDCEsNdtyGZ/j+39NqNaDXhnxz
 aenVUcuvDQ05M0hfmzvOQxkZ/xrPp5UVBrhknzF1l4PgrBS8WEp8A4ACCNjq0G5jKqwXJpcpfV0
 uS8jHzjnUZAF43jrz+hAE8TgsNU=
X-Received: by 2002:a05:7022:1284:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-124a00781f9mr426693c88.13.1769496883035; Mon, 26 Jan 2026
 22:54:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1769439596.git.ozan.durgut@analog.com>
In-Reply-To: <cover.1769439596.git.ozan.durgut@analog.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Tue, 27 Jan 2026 01:54:16 -0500
X-Gm-Features: AZwV_QiqAn8aLlhaWQyUwKc1gBbJdlNK1U1C5eINjiTaWXU8d7pM63KiErdLJWY
Message-ID: <CABdDSeXfEaFcwrj2z7C4LR6p=radifR_Etfx5o604+PzWAnY_w@mail.gmail.com>
Subject: Re: [PATCH 0/5] arm: dts: sc5xx: device tree updates and fixes
To: ozndrgt@gmail.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, linux@analog.com, 
 Ozan Durgut <ozan.durgut@analog.com>
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

Hi Ozan and Tom,

On Mon, Jan 26, 2026 at 11:15=E2=80=AFAM <ozndrgt@gmail.com> wrote:
>
> From: Ozan Durgut <ozan.durgut@analog.com>
>
> This series introduces updates for Analog Devices SC5xx boards.
>
> It cleans up device trees by renaming GPIO expanders and removing
> incorrect SPI flash definitions from the common include file.
>
> For the SC598, this series updates the EZLITE board to the latest
> Revision E hardware. It also adds missing GPIO hogs and enables
> additional commands for the EZKIT configuration.
>
> Ozan Durgut (4):
>   configs: sc598-ezkit: enable additional commands
>   arm: dts: sc598: add missing GPIO hogs for Rev D
>   arm: dts: adi: rename GPIO expanders
>   arm: dts: sc598: update EZLITE to latest revision
>
> Philip Molloy (1):
>   arm: dts: sc5xx: drop SPI flash from common dtsi
>
>  arch/arm/dts/sc573-ezkit.dts          |  4 ++--
>  arch/arm/dts/sc584-ezkit.dts          |  4 ++--
>  arch/arm/dts/sc589-ezkit.dts          |  4 ++--
>  arch/arm/dts/sc594-som-ezkit.dts      |  2 +-
>  arch/arm/dts/sc594-som-ezlite.dts     |  2 +-
>  arch/arm/dts/sc598-som-ezkit.dts      |  2 +-
>  arch/arm/dts/sc598-som-ezlite.dts     |  4 ++--
>  arch/arm/dts/sc598-som-revD.dtsi      | 32 +++++++++++++++++++++++++++
>  arch/arm/dts/sc5xx.dtsi               | 11 ---------
>  configs/sc598-som-ezkit-spl_defconfig |  4 ++++
>  10 files changed, 47 insertions(+), 22 deletions(-)
>
> --
> 2.43.0
>

I tried this series on top of 2026.04-rc1 and ran my usual tests
against an sc573 ezkit and an sc598 rev D som + ezkit carrier board.
Note that to test the rev D board I have to omit dtsi switch to rev E,
but other than that everything looks good to me functionality-wise.
Some commit messages could be expanded (such as adding info about why
wget/fat/gpt/mtd are being enabled), but I don't see a need to
resubmit just for that.

For the series,
Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
