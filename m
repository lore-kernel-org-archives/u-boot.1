Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC7FF5106
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 15:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8C18404A;
	Tue,  7 Apr 2026 17:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iYlqs6XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3B1840AB; Tue,  7 Apr 2026 17:45:17 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2916283F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 17:45:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463f00cda04so2828844b6e.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775576714; x=1776181514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DpPr0r299qN5A0TrOB3sSd0zvcV29ENl9m336+na+bU=;
 b=iYlqs6XJhkhW83D2KpLVZftfMDSkpWHF+2DppdwC1SLCjXCM4s45ExPn/kQ5rPdW/4
 y2D6AmNSnijpSDczl2UxG9uPoy/Fr0sFTgTCbx9H3aFF3Z/xT3XjWKDQKM6DTqRgh4bk
 rhlS81UeJRQo1qBmXX6GtMX4hakQAZcPwUZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775576714; x=1776181514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpPr0r299qN5A0TrOB3sSd0zvcV29ENl9m336+na+bU=;
 b=fwrvkISMhFa/uyiik/zY5HiU2qLsjxxSvxFVe7EvairxPRN/Yz94ccdIHNqZ51vVIp
 VbyctQpLCfQfH+x0zrwBhnMxmtmk27R6nHhflXdx0KRrQMk9TRGjc+NQ4VAaFqVGcaWl
 5mLCZMp6gRtmTWvoGfh7n7b15kN9UgaoiAY+PtHoE6QTnC3i6RBoFW67TVKEJjdqKsRL
 dwOFrRzATG/TiHlBEJoSOFINxKZbY/yC2n9PxHk19sl3FzAPytgdZ/SB+wCVdSlfW01Q
 Pim5qyDTu5ebUxbjWCWiT1RkatumeBS4dC/dmj/TYEesDpFsIdDBUl2/nHLj17TbTqA4
 0fQQ==
X-Gm-Message-State: AOJu0YzexOyTBytfy/GyQV4RXddEfbXLtUe19PGTLiNxUZFtlgWQbCtU
 SugHEvrYf8pmXLB0iojE7fD+Ad1XEBPLJeQkghzk5WBygY+zCxQJ/wTLAaEexFVGwVcoY3CQ9Sc
 rFYmNjSQ=
X-Gm-Gg: AeBDiesrPabTfvgx9yuIt8pwAJ7WmK1D5Zua9GgrpHsL4yiWdO0gq82C4PXRnGI9svE
 oucD0MZIyq0hq+kj3KOvXxZA4O/6h6uHWwrlKwJBWGdL6kL2PLnAIHiydcqX7BvI6Uiw3E0rGY+
 YsBvFOh6uw+757Az5Ideqy2ML50pLxxKyfy18R4bztVjfqLszzHgZ2slnL8Ys7VxztD+h/6ffPu
 GTEeSC1Q8xOkK+2VWE44poOSuNGXqvC5i/lKFDj53LMzYdgu/TPicqt7V13tcZBzXFdzgKf5pft
 3mvs6hjlMIYyujqusVagdRoVjEoaFWdy/gaEbCJFq9pk2PYZ6PZqeRYicOPlyu+Mfhqan0xqkW+
 dBnBJiKyBfBS1obk6GxEIIxr3bG9UAHK+FrK9Lm3RmgrYS/5HUIq01bkB+XV21ZEYZ3D9MKiICG
 IPv+pCr8Ll1StVXi9ub7yf4vVsGYEsNsdsdo5doAP5NQ1M+wYMWgjRpLDuEmq4lsAyZ0ZbHsbkS
 iPV6UIvULIrsZXiB6Cg1IQ8EMKJU6TgvnVbtuv22cnqNi7G
X-Received: by 2002:a05:6808:1513:b0:467:1ad3:7ee with SMTP id
 5614622812f47-46ef8219742mr8768827b6e.40.1775576713689; 
 Tue, 07 Apr 2026 08:45:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-472813cdbe7sm3875292b6e.7.2026.04.07.08.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:45:12 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:45:11 -0600
From: Tom Rini <trini@konsulko.com>
To: "Viguera, Javier" <Javier.Viguera@digi.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] rtc: rv3028: fix PORF flag not being cleared
Message-ID: <20260407154511.GZ41863@bill-the-cat>
References: <20260310122033.2037427-1-javier.viguera@digi.com>
 <BLAPR10MB5156AD27BEA53C46BB17EE08E05AA@BLAPR10MB5156.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0bv0x9xbQNX/Mb/B"
Content-Disposition: inline
In-Reply-To: <BLAPR10MB5156AD27BEA53C46BB17EE08E05AA@BLAPR10MB5156.namprd10.prod.outlook.com>
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


--0bv0x9xbQNX/Mb/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 01:15:49PM +0000, Viguera, Javier wrote:

> Hi Tom,
>=20
> Any comment for this patch?

Thanks for the ping. I had mis-identified it as a rockchip patch (for
clearly wrong now reasons). I'll take a look soon.

>=20
> --
> Regards,
> Javier Viguera
> ________________________________
> From: Viguera, Javier
> Sent: Tuesday, March 10, 2026 13:20
> To: trini@konsulko.com <trini@konsulko.com>; u-boot@lists.denx.de <u-boot=
@lists.denx.de>
> Subject: [PATCH] rtc: rv3028: fix PORF flag not being cleared
>=20
> The current code sets RV3028_STATUS_PORF instead of clearing it, so the
> flag remains asserted. Use dm_i2c_reg_clrset() to clear the bit.
>=20
> Signed-off-by: Javier Viguera <javier.viguera@digi.com>
> ---
>  drivers/rtc/rv3028.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> Based on Linux driver:
> https://elixir.bootlin.com/linux/v6.19.6/source/drivers/rtc/rtc-rv3028.c#=
L338
>=20
> diff --git a/drivers/rtc/rv3028.c b/drivers/rtc/rv3028.c
> index b14d2a246ffc..4e05ef8de2a2 100644
> --- a/drivers/rtc/rv3028.c
> +++ b/drivers/rtc/rv3028.c
> @@ -130,7 +130,6 @@ static int rv3028_rtc_get(struct udevice *dev, struct=
 rtc_time *tm)
>  static int rv3028_rtc_set(struct udevice *dev, const struct rtc_time *tm)
>  {
>          u8 regs[RTC_RV3028_LEN];
> -       u8 status;
>          int ret;
>=20
>          debug("%s: %4d-%02d-%02d (wday=3D%d( %2d:%02d:%02d\n",
> @@ -157,13 +156,7 @@ static int rv3028_rtc_set(struct udevice *dev, const=
 struct rtc_time *tm)
>                  return ret;
>          }
>=20
> -       ret =3D dm_i2c_read(dev, RV3028_STATUS, &status, 1);
> -       if (ret < 0) {
> -               printf("%s: error reading RTC status: %x\n", __func__, re=
t);
> -               return -EIO;
> -       }
> -       status |=3D RV3028_STATUS_PORF;
> -       return dm_i2c_write(dev, RV3028_STATUS, &status, 1);
> +       return dm_i2c_reg_clrset(dev, RV3028_STATUS, RV3028_STATUS_PORF, =
0);
>  }
>=20
>  static int rv3028_rtc_reset(struct udevice *dev)

--=20
Tom

--0bv0x9xbQNX/Mb/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadUmgwAKCRAr4qD1Cr/k
CsPkAQCJtnw8386IuZWhg+m7CQcxRtq9zBdGdrGAwBtuZ/Ky1AEAgSV9TSsaq/1W
iwnPeBwU5tANAirViCPIC8vNuJxcJQc=
=vrdO
-----END PGP SIGNATURE-----

--0bv0x9xbQNX/Mb/B--
