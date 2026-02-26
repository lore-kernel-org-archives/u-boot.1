Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C73FC5915
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F02EC83AA9;
	Thu, 26 Feb 2026 13:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iV3xOkx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CF5083D1A; Thu, 26 Feb 2026 13:04:55 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F9D83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59e699310a8so1665879e87.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 04:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772107492; cv=none;
 d=google.com; s=arc-20240605;
 b=hz+haXG3T2xfl7NS05wC4Dw5SnySWCHjr6DT5vcMUsEc7C8yt7+o1ZNpMwSbh2hfgy
 Ypkmh5g18IJf3uJSXhR4kaPkmmRALPrVxQln+aib0nrW9quJFdZoaGAN0OyznBZRppUU
 Dq07zazrZ3+nPnsol+EVgjp2IZ3P5Cr6UrUYzzuJEutuf5B7nuoOY61bdvsUJ103TH2u
 qi53r2HCVypZ1XxGk+tELjTWJgdWnyvbvm3lyyholWyh40Z7WaLbigbfVFx3OU32gXVa
 2Rz5cFUzjxv8SALIi8rZ2grQOajRgHbGS52SRm1e7dVvjZJBjce6PQZNC/cANGEOT7Xe
 WZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+d0iNnVsuBj4DA4xWjdSBkIYL9OBmjB+QcyrM8FaUMY=;
 fh=4C7vH+lyZekVWs/KSk8PB/mFj8vbSIc5d3O7ppszboc=;
 b=QFA6b0KOu59FNVhxUw0Yf1Z2Tk73i4IHktugJtZY+bCl/3yUhEq93JD+x/Ix3v4Cw3
 vjr0taRe4S+QelK4lYeqmyHL3sIl4Om2a4EJTTuQqZavz9OQwD/Ee27woMwyyGcUScTN
 lnNZj4YbSuEmGvVJBPjz5O0fgV/Rey7pP1AURXuA5h3fpBel0YWWAkHUusHvk27zF1Eg
 B0NDlA4weSze7uDvtmp+bBlgiwknRY9WeJ22M/JWpN/09i+RAWqbPe+zOsic16uAvx7x
 qZZoJKkAFZiGsyNCiwQ/alSKMm0MjHETFsjdRtgSWdFK1AJbI+4dP4Q91o4GQbOeud/5
 zvBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772107492; x=1772712292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d0iNnVsuBj4DA4xWjdSBkIYL9OBmjB+QcyrM8FaUMY=;
 b=iV3xOkx21HsxAHPW2tGRaxTW4JviTKljTuSPGccA8iDaKRiwsg8lYlo38pCrLYPWTV
 /mo/ncoG+aAVcsJDXFjH8Tsf1Pm4cWpDDK8AuB80QAzvjFYRl9e9taGa1IPUNYPkMO1U
 oyC60HLtwxQoHHYFHn+vZeVukbH/9oD/+ieUF03JyQwp33fI8Q5jtplbneTOQJNxufM3
 Oyuseq0W6Vh1QxaD66HzMjURllRkLSCWMOSvKjW9cRqUoYleZoLmwmGNwDuLCzgywaMA
 D2Ti1ew81I6KD2uerpB065UneuDBNOqh4DVXrstYzgRBmcbdhMAv3q/m+7btU5OdxFXU
 M7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772107492; x=1772712292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+d0iNnVsuBj4DA4xWjdSBkIYL9OBmjB+QcyrM8FaUMY=;
 b=SQ2Ww/wUBB8ErsjNmW3Ci9Ef/brMLnLtNcKWP8PEjP/c6uwTjUJqmNOQhi05VSKpmc
 EN0DYPbdSvMWnne9QD8fg7+FZvvJvJ0V4nV3wKeqdQrhpn6h+W8V5FOgHH/SgFxd4adU
 PlbMh/4ruluKBAsEf9WMEVKzwQkZOlUTFyIGlBGZNiHCkmA2qjErE7YpjJMOpUn2YvKn
 CRxN3EGDX/96JBmONceDCVrGoGLKVav7i/nysQTw2imUuQ/KF8ZtchMOW6tsq2aXv6Ev
 LuA9gg2sG+gPypJuxKkSJpfNdaFVWDs19awBTR/aaa7yHSM/oU92hZDdEOno6ftWiSFm
 6+qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhhkmFB3McuV5O4fqIoVbOupXFp77zjwPTxnmBH/oftHkgv5Zkom0ILlfG0VHGwqDByASFrjA=@lists.denx.de
X-Gm-Message-State: AOJu0YzV2cGUoAHfIup4Vh4sjFpzcmL7MuYK81zER9UL0V6Woq5fjq8P
 YIdOA3Y89bnaoumS9eQ70AJzdVvE/qlaKeqLqiMETbmoAWVnb0+AOfP2t2bCuvSch3vcM6eaaIP
 o3RKXTWCCj9Qai1ZLUr59V0QleQa0t+c=
X-Gm-Gg: ATEYQzxR7OSG/IXwf0yNjFgmwrvtu9uW4vxUtEuKm3+hu/NQRScJE5KxCUn97/v4p2I
 EMzX0HcXZoOOvQylJ8C2XQ/XwXAB/7QrBmciy1ScLS9pVPa2OarHL1BMZF7+jWRpt+iZ9wetkx2
 BVs20lBURc+GBpHvNmETF6shhck0/YbHrEoD9pg0BqdAUpsFeK2fTDyAMMHH6T/1AAb/KfES2q2
 6JHb578FeQiymW4Qekut2Pqx7qjiuSGIs2MAZZSyF/2Q/nZZoa6dVq/wRWxn6Kf8J6H2e9kOF+7
 GnPgKofUvJ+ioAUipys5UhabcwaXza/oJJzURXGZ+D8G2OhsDYe3uawlR5vhA8Qe5Uj+2sw=
X-Received: by 2002:a05:6512:3ca6:b0:5a1:54a:ceda with SMTP id
 2adb3069b0e04-5a108aa8045mr804513e87.22.1772107492058; Thu, 26 Feb 2026
 04:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20260220031232.1254728-1-festevam@gmail.com>
 <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
 <82b70e8b-3adb-5c0e-cf98-d5f501e0bc48@gmail.com>
 <CAOMZO5C9BwWosjdgJFPX8XMsrqo_rQLeTn9PLFi9JRoLw+-yag@mail.gmail.com>
 <1a128389-fe86-5ba5-1e01-4f2d932908f2@gmail.com>
 <9399843b-4d2f-499b-87cb-ff22eae2b78d@altera.com>
In-Reply-To: <9399843b-4d2f-499b-87cb-ff22eae2b78d@altera.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Feb 2026 09:04:40 -0300
X-Gm-Features: AaiRm521a18Z7KAiHarJR_m5MeGRg7IFsFOCKjHxmy-aenrejoHvfXqX-G1uBQc
Message-ID: <CAOMZO5BCW1j+Tr490Ue0-JOpw96OZu04oPBPb22Gc3CoFKeVOQ@mail.gmail.com>
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Cc: Sean Anderson <seanga2@gmail.com>, michael@amarulasolutions.com,
 u-boot@lists.denx.de, 
 trini@konsulko.com, a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se, 
 Fabio Estevam <festevam@nabladev.com>
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

Sean, Dinesh, Anurag,

On Thu, Feb 26, 2026 at 2:35=E2=80=AFAM Maniyam, Dinesh
<dinesh.maniyam@altera.com> wrote:

> I can try, but I can't promise I'll be done with it in any particular tim=
eframe.
>
> But TBH I don't think a spi_nand.c-style loader is the right way to do th=
ings when UBI exists.
> Maybe Dinesh can comment, but I don't really see the point except if e.g.=
 you are really short
> on space in SPL, but not so much that you can't fit in MTD.
>
> --Sean
>
> Based on our current design, we rely on the existing NAND framework with =
only a minimal set
> of additional helper functions provided by the controller, which keeps th=
e SPL implementation simple and NAND-specific.
>
> The SPI-NAND SPL loader expects a broader set of common SPL helpers which=
 lead to compilation failures.
> Adapting to that model would require significant refactoring and extensiv=
e testing,
> so for now we plan to continue using and extending the existing nand_spl_=
loaders.c,
> which aligns better with the current SPL design and our constraints.

Should we focus on getting separate SPI NAND SPL and NAND SPL loaders
for now, and then later work on a generic MTD implementation?
