Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C42C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 01:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E05C87B05;
	Fri, 15 Dec 2023 02:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sx0rpNp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC4987B14; Fri, 15 Dec 2023 02:16:51 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CC587AA9
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 02:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c68b988f3eso43598a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702603007; x=1703207807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFupTeusl+qsgqjQ04q0hthalTtnBUUF7ZVzvuri0ZA=;
 b=Sx0rpNp+MNVqfx83NALrN04VJmTieqZyzUj8C+8xIbwsWRvv5UQY1swQLKrgWJ3cIt
 ynaakQteBV/m4yoSc90re07lw0a5w3GB57rSsucrxnQXUMAFzebWIT96Ef4PZAs8ZCyE
 8KRNUv9XbKWJVRXOKYCI9KRRWnq2xQfpAeaJLUdCZyF90Z1bzHcA1Ju9OxzY3qdbKoeR
 akCWtUNHv4a4VhXlqG0rQDevWgefCa7TgmUX9kaczNp5rX89g7PfzbGEcGTuNOXJ3zEM
 GEtLKK7x7HMtvm872pivdAFhnVisotJDwifpw/ilbr6a3rR7ui3Sg1/ptQ7OEl7Hewsb
 JRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702603007; x=1703207807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFupTeusl+qsgqjQ04q0hthalTtnBUUF7ZVzvuri0ZA=;
 b=M8cN0tWEvuLRwiBkSI4RiAhv5nAMY8bAYXNxwJiBamNr7MR4YNE+u8zXEHTNFzSbvK
 dEOsDEwYeOVx/4qjuOuxaL9dxo2q6D6piebk58uZnu7x/cJx8KzgpOPYL8EY+pjkU8Pl
 spHRG1U044JIMvQT7y8zTYeewW012NupAHobtARASw5aeAmO/dKsD1DpnTEK30AD7OHs
 /amKkoefumSQaTCGY6h4zes+eoxsA7YjRaFnREnsXm8R3m+7evE9nP0t0ZMJg0GGF2PV
 10DGN4l5QEPn9OduzPSNRIwvYLHK0k9U6BenyfymhFY+PhJ/1YG1hc0v94tVDmgiD3LL
 jniA==
X-Gm-Message-State: AOJu0Yx9hTmGvuKjUOZxaKiDJdSD1vzrfgRoEcql8Rvantk0PrcSGAhX
 JCzu5eULnAw4PDfyCeZcfcgKHHLtrbRAVldizw1PI6h1VVU=
X-Google-Smtp-Source: AGHT+IFJZPWuDgmRa6SCGbxtfgl5jLECDdfuUEoljq1MgC/H9ROJrtzk3dLSnETKOAAsivzmLKp5Mghr7jUXvd8R7DI=
X-Received: by 2002:a17:90a:664f:b0:28a:e87c:257 with SMTP id
 f15-20020a17090a664f00b0028ae87c0257mr6039189pjm.1.1702603007508; Thu, 14 Dec
 2023 17:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20231105000440.273177-1-marex@denx.de>
In-Reply-To: <20231105000440.273177-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 22:16:35 -0300
Message-ID: <CAOMZO5Bbdavp0unoKBqrxG2jPO-8mTkDskgzFpssQAB9LLN12A@mail.gmail.com>
Subject: Re: [PATCH] arm64: imx8mp: Inhibit DTC warning on DH i.MX8MP DHCOM
 rev.100 DTO
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Nov 4, 2023 at 9:04=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Inhibit DTC warning in imx8mp-dhcom-pdk3-overlay-rev100.dts:
> "
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (reg_format):=
 /fragment@0/__overlay__:reg: property has invalid length (4 bytes) (#addre=
ss-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_defaul=
t_addr_size): /fragment@0/__overlay__: Relying on default #address-cells va=
lue
> arch/arm/dts/imx8mp-dhcom-pdk3-overlay-rev100.dtbo: Warning (avoid_defaul=
t_addr_size): /fragment@0/__overlay__: Relying on default #size-cells value
> "
>
> The DTO overwrites the 'reg' property of an ethernet PHY and is only
> used on specific combination of old prototype SoM and old prototype
> PDK3 carrier board, which had incorrectly placed pull resistor, which
> made the PHY change its MDIO address in that specific combination and
> which is already fixed on production hardware.
>
> The DTO is implemented in this simple manner because if it contained a
> full MDIO bus node reference to define #address-cells and #size-cells,
> it would also require a full new copy of the PHY node, i.e.
> ethernet-phy@5 { ... reg =3D <5>; ... }, to avoid DTC warnings about
> mismatch between node unit and reg value. The node unit in SoM DT is
> ethernet-phy@7 { ... }; .
>
> This simpler approach avoids unnecessary duplication without adverse
> side effects.
>
> Reported-by: Fabio Estevam <festevam@denx.de>
> Reported-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx master, thanks.
