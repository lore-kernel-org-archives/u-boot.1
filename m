Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D789DFD8770
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589508433B;
	Tue, 17 Mar 2026 15:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nY23uMy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5D084347; Tue, 17 Mar 2026 15:08:02 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CD184337
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d55b97f358so4028981a34.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773756479; x=1774361279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RTmiXsIKoIu5sLhkmRIgmfC+TcKOaibaRqinFWl+n14=;
 b=nY23uMy2GVa/RZBTE7hwDUsv7zhzikFL2+QBGj0sedJ7KXfJxV0eW373JmiEJS++NF
 YJAubK7/Kw4x2RD6ECi7QkPy579ArwR/UaDSO0LTv95X36qPBa8II+eDPwMxFt9IGq+E
 JIVtLrndwuCKw1M/N7WLOz5pgfVfshIDj2tX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756479; x=1774361279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTmiXsIKoIu5sLhkmRIgmfC+TcKOaibaRqinFWl+n14=;
 b=UTd6hv5EQpRIK4tm8QqwIjehpqIVLGmXfDvDrxa1udxMTcXj7+OoDU/QeaZh6VHhLD
 JiW3/eQPHtngIHIpMaoQQ+5bjT4rJI5WSdBJlhbHaCjpmiT24ZKuqh3xUXvJvOvNKp93
 11vs/bTReHQds0T6vkrj1Tsrvfq0MVmVSriVwR0lKNcr8lbYFeMcsS9ohi4/oVdd0xWh
 fCP53ps6pIC3/iVbqapvfWpQ0tsNDHdl8+lEEL6jPnDv50c6AQaVdCFE5kO74cuRmnyl
 ZEi++I2RPxclHHP+gUid7pzWrw5aehV2rsWiWSIuRX5Cl2YV/O46+wSkqiMbdRq1sMJ7
 wR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY+nFys3EGB9rFrgiiDuB1gSoffSajM1ul2KLjhazfVOYH650rdZ/yFa3JmTdWNcuJOKCzKqE=@lists.denx.de
X-Gm-Message-State: AOJu0YxndLmf6qY9Y1zPBlhGdoySyxplTYece5bnxgWDsWdigtyUJS4Y
 Ee43Kk1uXM5cMDg44DIHuq0SQT90a1Fl3uIe9jtYbXGh7BXcIa+V52w3PcfYSfT6ybk=
X-Gm-Gg: ATEYQzzqgBkLikret0vOXyNKlPi7W15M8127MGKEyEdyVFthNP9RRQeMl+IatRs6zHS
 zQl7MomUBFOReHGW62j4zwDPInalDCiSI4pO5X6rGKo5p3EvR948ThwjtmlyzvBEC5b68BOquaR
 XBl/iLF5BLlNpW3NjF7JPF81pkUwIe6YHN+xPXVf3L7r+6lqv0qYayEl1KWZFZGodR+q1WjGM2C
 GYLZrM364VGdtFz4DJh9WxZhxyOCoFLXHX6xFJ5m2v/bdAKBSVJmz3kxXvcfZP3qptuPG4w4y1N
 p3XngBwefnmNvD3kCoqTCkgi8dLTJgdHqCIYSWPCZixe07MH4fLUwDCFu/bNdWsALu/+AlHANcw
 ON9ujrhPLFfNn/0Xh3IBxv6JoVWv61kRfNyTKQ0Gl7ivnyJJ4GE5BexVB8ocEQuI285yYluWQaH
 1zvfBDYkhfoa8JLGuvhQOpJCH7uKvjyIg20P7GA9vIm9XgoyRJeNOyplCunoDq/Rsq/52fmnc1v
 YLQPLG/K9D9at3xMxADE8pf1Zote/cnyvCVK/7WyBVYTHr/6UJD36zIq2A=
X-Received: by 2002:a05:6830:81d2:b0:7d1:4f21:ff79 with SMTP id
 46e09a7af769-7d78251bf33mr10781630a34.22.1773756478781; 
 Tue, 17 Mar 2026 07:07:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7ba4aa1c9sm2489401a34.25.2026.03.17.07.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:07:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:07:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Shiva Tripathi <s-tripathi1@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 praneeth@ti.com, kamlesh@ti.com, vishalm@ti.com,
 k-malarvizhi@ti.com, afd@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260317140755.GY502704@bill-the-cat>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <177317553318.23044.13643896894203476698.b4-ty@konsulko.com>
 <5e6a045c-5d5d-46e2-a7a1-1fd89ae64e3b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6IfvNIa1v8p2f+ZD"
Content-Disposition: inline
In-Reply-To: <5e6a045c-5d5d-46e2-a7a1-1fd89ae64e3b@ti.com>
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


--6IfvNIa1v8p2f+ZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 05:04:29PM +0530, Shiva Tripathi wrote:
>=20
>=20
> On 3/11/26 02:15, Tom Rini wrote:
> > On Wed, 25 Feb 2026 16:54:38 +0530, Shiva Tripathi wrote:
> >=20
> >> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
> >> MMC hardware. This provides TPM 2.0 functionality through
> >> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
> >> using eMMC RPMB as persistent storage.
> >>
> >> fTPM support in U-Boot provides the foundation for measured boot
> >> and disk encryption use cases.
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
>=20
> Hi Tom,
>=20
> Thanks for applying the patch. Following are the steps to test these
> (I'll soon update the relevant docs for this):
>=20
> a. First step is to generate fTPM TA binary using ms-tpm-20-ref [1] and
> optee_ftpm [2]. I have been using yocto to generate this fTPM TA Binary,
> for reference, the binary I used [3].
>=20
> b. Second step is to use above fTPM TA and build optee-os with RPMB and
> early TA enabled:
>   make -j$(nproc) \
>        CROSS_COMPILE=3Darm-linux-gnueabihf- \
>        CROSS_COMPILE64=3Daarch64-linux-gnu- \
>        PLATFORM=3Dk3 \
>        PLATFORM_FLAVOR=3Dam62x \
>        CFG_ARM64_core=3Dy \
>        CFG_RPMB_FS=3Dy \
>        CFG_REE_FS=3Dn \
>        CFG_EARLY_TA=3Dy \
>        CFG_RPMB_ANNOUNCE_PROBE_CAP=3Dn \
>=20
> EARLY_TA_PATHS=3D/path/to/bc50d971-d4c9-42c4-82cb-343fb7f37896.stripped.e=
lf
>=20
> c. The optee binary can then be used to built final u-boot images,
> testing logs for reference [4]
>=20
> [1]: https://github.com/microsoft/ms-tpm-20-ref.git
> [2]: https://github.com/OP-TEE/optee_ftpm.git
> [3]:
> https://github.com/shiva-ti/ftpm-binaries/blob/main/bc50d971-d4c9-42c4-82=
cb-343fb7f37896.stripped.elf
> [4]: https://gist.github.com/shiva-ti/8ac6aded2bf0a3c9bd99627a45b50f6b

I will try this manually when I have a chance, thanks. Please update the
generic TI K3 documents to include this as well, too.

--=20
Tom

--6IfvNIa1v8p2f+ZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablgOwAKCRAr4qD1Cr/k
CuZDAQCozlJ75Ixa6JzpioNw7JvqO74RFyyMjRzPhGDyTBsJJwD/bxJxvieEmzCZ
hXvlsJnLDUzswdhifh930Gr0D7unPAw=
=dUPk
-----END PGP SIGNATURE-----

--6IfvNIa1v8p2f+ZD--
