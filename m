Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2CFD3C52A
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 17:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BC288E32;
	Thu, 17 Oct 2024 19:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fq+2EWLb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB1988CC1; Thu, 17 Oct 2024 19:54:12 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D5588E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 19:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5e5a0519d00so546658eaf.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729187645; x=1729792445; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0or38wa2Tr2n7ngCHB9JkATqkXau76ulfiLFhkNPwys=;
 b=fq+2EWLbCilH7DvdfPXn5aTrnWVk4KwjoNlSZ7+s3u1Rm+IuUDPnlsBa4bQqApvK7Z
 tSu3fqUl641juGELAHRt8XcUEnbQkCJnNCAm4yD6C4YBDpI2XkgtPIaEHy+fmuNCM1RU
 M2Rc/u0umG48xljl7xGvZ7KEprDPwFbfdyrUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729187645; x=1729792445;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0or38wa2Tr2n7ngCHB9JkATqkXau76ulfiLFhkNPwys=;
 b=UWa0+rRSvUXdXaEdqpI6UVcQEG4r+kDHInLMs5PSSEMa4QeEeNGyJLeWI4+e/k1zQE
 D4ahzhjUUrnv6w61ihN1MVyI5YI0FZU/Y0fkVOTHpY+NVXILaASzss4WnHaXBn4q58h2
 gBhIdAK66EDXce6KnMGxNMyWDzlW1pABicB6EmdKrrbUGUDLb+/NgMfGQEwu7cN2Wuvx
 4FC6wWkHTzpti8+ecffd+QF4zBKf9EvlLbY8yujFMznqvdpe/FpT82wcUoFbLmmhbONb
 go6/pxqkIgha65y30vyw5oRBXP61AxGKpH5Vt61YhKhCeTOXBwG7w2/h17tAE60YyOoE
 3KIw==
X-Gm-Message-State: AOJu0YzXU3EDUholS2RMxf1sylApyVh+CdnHZhZKPXx9v0KxxLKlEgql
 iU65D9/o9r+qb1Iel4XOdhugFcSovJDqBTSy8lv4WCvH7wLAqcm3qETQCzPs3a8=
X-Google-Smtp-Source: AGHT+IFOYAOYYQXExvvS0ASb22nT/FYKzUUzu+9GzY/y1lPKSkbAuWTAVQ47vInBBNgJAbwPXoxmsA==
X-Received: by 2002:a05:6358:93a8:b0:1bc:9960:9f0e with SMTP id
 e5c5f4694b2df-1c340d1aa20mr502609255d.11.1729187644933; 
 Thu, 17 Oct 2024 10:54:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290fe4dsm30480426d6.19.2024.10.17.10.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:54:04 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:54:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20241017
Message-ID: <20241017175401.GM4959@bill-the-cat>
References: <87iktr2l9t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gCxSbalayAN7uXU1"
Content-Disposition: inline
In-Reply-To: <87iktr2l9t.fsf@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--gCxSbalayAN7uXU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 10:20:30AM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
>=20
> Usb Gadget:
> - Fix cdns3 endpoint configuration by setting maxpacket
> - Fix dwc3 cache handling when using DMA
>=20
> Fastboot:
> - Make AVB_VERIFY depends on FASTBOOT
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22742
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit a404065479be2c1fe1167c3c91367e8194a69d=
1b:
>=20
>   power: pmic: pca9450: Add missing newline (2024-10-10 12:17:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20241017
>=20
> for you to fetch changes up to 3e47302dd71267b85e5ec65c5b6d881c23cce6cb:
>=20
>   usb: dwc3: invalidate dcache on buffer used in interrupt handling (2024=
-10-15 11:03:57 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--gCxSbalayAN7uXU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcRTzUACgkQFHw5/5Y0
tyzjNwv+JDSe9Ky8MaBrrrSVAR+StqLkFxQxFSihqKIWMapqJjPY/QrQLAipdu5H
f9+RmaxX6xi3pHyj7cashv6GtJidWFr2krOsdYOuXLTPB2+Uy4x1U/efG+G1jsd0
Nafec+GoindYWe4fVx4k6ZX0HxOhkO8J4cMD6RURhHr25KI7fX4NfhaIfFIeuLLJ
GFHMRfdx5vj+kJ/UjlBBHDHyLc7+gDVvB5tVoBeT8XYM3e6NyEKkAirq24D6vnEe
y2ybaraOxDxFRsXyt6sbji04FBwPioSSPl4zH2Qz/20cGbT1RnwAMO5/xzdlJbtf
HQcIZ2R+rrLi6QXHtnrTv86tCT+hayofknE0ShtWlM9qT7bMeRwbsMM9kpI5xdH1
k6Rsgv9remEIMjjaPWXMPu8y/XnDU5Tw4GubFDzl5uRxh9B0TqsjTzUUd6GypOC/
2uajSkFGqCUggce66Xa9HMsDU1C+AwOxli7pQ7SJANqlOx4Co96MjercOhh9ebXr
OIq0ZuHE
=ejtC
-----END PGP SIGNATURE-----

--gCxSbalayAN7uXU1--
