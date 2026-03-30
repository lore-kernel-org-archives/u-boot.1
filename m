Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFB81061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C0884035;
	Tue, 31 Mar 2026 01:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oslmu1RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B885D84056; Tue, 31 Mar 2026 01:08:04 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5656283F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45f053b7b90so2745884b6e.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774912081; x=1775516881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eALwx3htOzDcv3zQL2lzKAJLPOonGA88/6RTOljh8f4=;
 b=oslmu1RO0RTi78hmr2hnMRmld3fbc467i23d0pelHuLd9OaXqvfQz7J7a9dEAM9Kwn
 Ne7Hgdy6axp1ovnqX3j/FeNrWkMI5vpfnq4A9Pnx9gNNk7TJm5Q1QAqL3dokepoWYoQW
 L7z3ee0YQgdaOfhEDyHYg2jo4xRfLr3PwTCqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774912081; x=1775516881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eALwx3htOzDcv3zQL2lzKAJLPOonGA88/6RTOljh8f4=;
 b=ZTjoGA7qtj8RfFQgPL8wqVZJ9p77b2uSlie0RzdWqbGHEm3CMXVuMNyfnVv1iQbce0
 51tLSBpYDfNuqXjsOfPSSZhpa16LztqxQmaYKTLyYHFACn1T1+SxZB4my43LU/4fQXYO
 lr9x1Dm/p2ntkClD76DIcBnASQBRSqrJKwAtnj/lCn3R9nXlges5NnvAsZ50XZO13zms
 zcYQH31gWJuzZZUEbYSs9v+RcUaft3zfqzDuQAd6fDxt6nQU3AN2028+Jz1KlYzU0abb
 dSDDkBxMqAPdGB9F67cS7EweqnlfUoiGBEui+Fv5wr6iL9o26dASukycRpLWl1RZWiFW
 twjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSmtyhAWRaRkcvpYcZtg77ERuvt+YdgP0E6lMkr+C+BnecobPYAF+tPQRPq4PFBuPuJmz2YPo=@lists.denx.de
X-Gm-Message-State: AOJu0YzlpvBX/L0444jb8/Cf4yhhEUlVl48BdUry7HI0gpIRmGtm18R8
 Jeoj/cJc+rHq5NF/C3OsxHcsOOCUBCrbQ+qqmE28I8Skal3eRiOwuCulqnUEJvxnjNQ=
X-Gm-Gg: ATEYQzwH1URDE/xP7520Ck4ki54EgeaMZblkG6ZuS6qZVMjfseqYuix94GQIkPvu7J6
 I6k//mhRdxF2F5VSaNv3gwSlCxjm7Qve8P11YtpKSKMvri3fZTrEGBHsSHrqRwq7wTCqVo4RPS4
 hWULRxCGf3/b62kzqdaI2icnYVUPasAsWPzAgy9Gcl1hdZ9iO2jyhhLS/KNleGzqN8aGg11QrFV
 4zijqv/z0VVXfSjxYjTbxcXlvirCrTno4PtBKcKA7xAE/EqGO+WTFQ7LbrhpyjiWf8XufQkiE9t
 6zQwsEUEgpLpXjBLOChQRXSL5UQA06oZ5gE3CHYE9F3/uo3x9un2jDpcQ30dXYmxDOXzF8dM80T
 UAesgD7GtMCgsVG0AkQBv7nudOpEMjSXSEfQhA3Z6ySGgdhNpXW4YnJpUalFszouk01j6RqP/Uy
 FfzD9Jqsi8nPxF1Qngn8j2ksTm8Aw8b1GeKO/WrNrVSb7b+LxdPZukIGYVjUoBCaiCDuVI4Wfii
 J4g+wzVYcQ9UYclRnTmjGL1d2N9mXvNWkBN0qGNNZrlJAX8
X-Received: by 2002:a05:6808:338c:b0:467:254:ba8 with SMTP id
 5614622812f47-46a8a3f2e5fmr7216403b6e.11.1774912080942; 
 Mon, 30 Mar 2026 16:08:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a9fcb28d4sm5566578b6e.0.2026.03.30.16.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:08:00 -0700 (PDT)
Date: Mon, 30 Mar 2026 17:07:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peng Fan <peng.fan@nxp.com>, Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/5] misc: fs_loader: reorg and split to FS and FW
 loader + FIP loader
Message-ID: <20260330230757.GA1030901@bill-the-cat>
References: <20260317153614.18409-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QlE/wDJxKa2s9Y33"
Content-Disposition: inline
In-Reply-To: <20260317153614.18409-1-ansuelsmth@gmail.com>
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


--QlE/wDJxKa2s9Y33
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:36:04PM +0100, Christian Marangi wrote:

> This series mainly rework the FS loader to permit reading firmware from
> container that are not exactly a readable filesystem.
>=20
> One scenario is when a firmware is shipped in a FIP container as
> a generic blob with an UUID.
>=20
> FIP are mostly used on ARM in the context of ATF.
> In such context U-Boot is loaded as BL31 and the PHY firmware
> can't be stored in the FIT image for the kernel as U-Boot should
> not depend on the presence of the kernel to correctly enable PHY
> for Ethernet port.
>=20
> To handle such case the PHY firmware is stored in FIP with a
> predictable UUID.
>=20
> One example is with Airoha 8811H firmware where the FIP can
> have a blob with UUID "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2".
> (generated from command "uuidgen -n @dns --md5 --name en8811h.bin")
>=20
> With these example DTS entry:
>=20
> fs_loader0: fip-loader {
> 	bootph-all;
> 	compatible =3D "u-boot,fip-loader";
> 	phandlepart =3D <&mmc0 0>;
> 	partoffset =3D <0x100>;
> };
>=20
> mdio {
>   en8811: ethernet-phy@f {
>     reg =3D <0xf>;
>     firmware-name =3D "d39d2cf2-9bd0-3ca7-93e9-e71b4f9250b2";
>     firmware-loader =3D <&fs_loader0>;
>   };
> };
>=20
> And PHY driver using the get_fw_loader_from_node() and the
> common request_firmware_into_buf() it's possible to
> load the PHY firmware transparently by just declaring
> the required entry in the DTS.
>=20
> get_fw_loader_from_node() is implemented to actual get the
> loader from DT. This was something that was already in mind
> from when the FS loader was implemented but then it was
> never implemented in favor of a single loader per device.
>=20
> The first patch is a minor fixup for something that probably
> won't ever happen.
>=20
> The second one is a good reworking of the FS and FW loader
> moving the internal struct to a dedicated header. (this is
> really to enforce what drivers should use and what
> driver should not mess with)
>=20
> Then there is the request_firmware_size() new OP to get only
> the size of the firmware. Useful for case where the firmware
> size is not always the same and change across different version.
> (the patter might be get size -> alloc buffer -> get firmware).
>=20
> Then the FIP loader as a basic parser of FIP. This only
> read the FIP header, loop all the entry and search for a
> matching UUID. If nothing is found then no firmware blob.
> Very simple implementation.
>=20
> This is being CI tested on [0]

Both "git am" and "b4 shazam" fail to apply the second patch here, can
you please rebase on top of current next and repost? Thanks.

--=20
Tom

--QlE/wDJxKa2s9Y33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacsCSgAKCRAr4qD1Cr/k
CgmAAP4wahtlpo4Sdra8+cB/NnV967cHyJEoG0XLdjn6taxihQD+O0yLhfUE144j
YBnULjldoeQLbwzW4HVtFY1EC2L4yw4=
=kmwb
-----END PGP SIGNATURE-----

--QlE/wDJxKa2s9Y33--
