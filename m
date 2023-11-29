Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19016C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 397FB8773A;
	Wed, 29 Nov 2023 19:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHNUSXKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56CE6877BA; Wed, 29 Nov 2023 19:16:04 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAA6870AB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-280b06206f7so12124a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281760; x=1701886560; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyQtoGFwokMPYMikCyrIhg6eML1EFp1OwYEnR2a6H1Q=;
 b=hHNUSXKuHegmnehhQ+X9aGgQUkbfUqCxfKdcUfvEF/t0OBxycouAE8ZrmRtWda/JKS
 ZoX+itX5Z5AR5LJZacOxkUqvuO+gnlIMMJrIius9zRDrb2aTyHWxH/hdsNMtzN/Xx8Em
 2r8Y4lSqmduVZNG+RpJSlb+3fL09ThTheXKImGw0k9WlQ776c6WniRpWLVcu1yhmnGK9
 IbB9TDr3rTiRkYnXepJbLDZJ9wWZEV8kZvKhd+aZBLsJgJXkumQ0auoDzTf0MAmNvVa8
 2wl/qJagMLTOZcBYe83dhGxGxHBkT92TcdN6qC0xxHxhY0ZLtSjJ0Bp4Cbc+CmB4F4o3
 4J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281760; x=1701886560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyQtoGFwokMPYMikCyrIhg6eML1EFp1OwYEnR2a6H1Q=;
 b=sQVlZrtMFU1UeAgeiv0UoddrZyFwA7STaNzKvBPFHdrX0fkNACqrMuf2XpHVBU1KU/
 h+n2RDLVKP9Y4kI1Kuog72DsymqVfbC44EildrUXUIrJllBvh89Nv+jWF/iSjywe6FQ/
 AZzZqY4983Q05zC8pOXVSsIRH8DY668MhNmbLuLkt5HBTYdFwPEYoxxiNhoUh7VB0K7u
 svWRYdeCgVCRN7Gu0BVpydk2EsD2uk+QvVwPZ8CDDa3cOk+PmrZQNFN2q8FYb4EPftZe
 cimgiF20FCviN8E2OQd6AVVyjImFm+10g9v1Ty0TQW3bXpEWqcv3CBZST9HYUHTkYgsr
 aoJw==
X-Gm-Message-State: AOJu0Yy2gdKfzB54dQReI+TZBM20dRL1AwGQDEK3aTcyoZg9N4LoXbCi
 CN7VMH3nKGpIh8PcTDO+b7nBogx9bLcM028Mp+ptfVzGnO0=
X-Google-Smtp-Source: AGHT+IElZ1atXG/5j7od0w4FhcKcMqM0q+hmDvYhRIkiDUHx+nO8J2SkVK1eOjydo3tF+EC/W4R2YyGgHfR3d5u5Bj4=
X-Received: by 2002:a17:90a:f695:b0:27d:2762:2728 with SMTP id
 cl21-20020a17090af69500b0027d27622728mr19337425pjb.0.1701281759816; Wed, 29
 Nov 2023 10:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20231105000440.273177-1-marex@denx.de>
In-Reply-To: <20231105000440.273177-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:15:49 -0300
Message-ID: <CAOMZO5CU+fSAtLB18c-3ECeTES9zDdgp8XAosc44Oi0Otfrn=w@mail.gmail.com>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>
