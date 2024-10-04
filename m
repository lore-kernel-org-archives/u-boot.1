Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68671CF854E
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 02:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DE588DD0;
	Fri,  4 Oct 2024 04:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U3CMi3oJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 270CB88AE8; Fri,  4 Oct 2024 04:40:53 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5EBD88B2D
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 04:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so10888236d6.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728009649; x=1728614449; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b/WBudBNj4xXoiMBWwk/yCAXE9KhJba8xFX1CGm6dRI=;
 b=U3CMi3oJT1ce0SAv2bdlyuwXqg1sXWMybXhFBqxgpgx/sma7gtYvE89y4R1IZNpu98
 OsDtvLd+DNv9x7k9bGMSQZNLF+5tHr12nRRrOZMHECyZ9ZayXtcWbtvx5iAO6/PNTub7
 IS+zKlCmeeuHifqW3UsPdxmJLBOisdLfMBocM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728009649; x=1728614449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/WBudBNj4xXoiMBWwk/yCAXE9KhJba8xFX1CGm6dRI=;
 b=ufYx2Bfphf+lV2LKwNPXlHSAv5yjMHWJohveyyO2u8SR1xZOKoJefzbu7H8FEh0N+M
 bYluHLn3A7AK3le8sObj4QY/Ziw/5lY/kqVG7f+QHB6VSgU7vfq2hewPNjvdQ3aINFtj
 Q+hD0+95//bpmFW1h/E+8R3vdfhXqGSzq1ACvehfmshxdsWPl0fieHVAGtDL5kYBLaOa
 zJVWMZkqMBxJ8MWGHU/IBR0FsO/yYvziWUP5Kd9yisS6NOpwdCePb/IdaUQYMN4aYYrx
 dI3ObvpCl8Gjh98ECWFZAlB1Qn7T17rWBNuKwpUBBBCWSB1Ayrxm6zeWcd1J6nj3F1sE
 6Upg==
X-Gm-Message-State: AOJu0YyhQMKhACECzZUoCGIlR1Kps0Zy5vaWfj53OME8zVgqRygzkQrm
 uDwYS6o5OSyAPBCTliWcuyIo2e8KuGmzHxNj3FzeChCWv9pq3teequKkSSzuWas=
X-Google-Smtp-Source: AGHT+IHzyHoGsOxvBbzRnbG9DkpmOGTsMuY/zYirM2Wsv70Y5zR366/pibZA2+SZoXIYmY8YwBU40g==
X-Received: by 2002:a05:6214:2f13:b0:6cb:52b3:c112 with SMTP id
 6a1803df08f44-6cb9a33090dmr18950536d6.11.1728009648806; 
 Thu, 03 Oct 2024 19:40:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb937d3529sm11674136d6.97.2024.10.03.19.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 19:40:48 -0700 (PDT)
Date: Thu, 3 Oct 2024 20:40:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Heinrich Schuchardt <xypron.glkp@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20241003
Message-ID: <20241004024045.GZ4737@bill-the-cat>
References: <87iku9xepp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4HrtdGe200xlmgAY"
Content-Disposition: inline
In-Reply-To: <87iku9xepp.fsf@baylibre.com>
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


--4HrtdGe200xlmgAY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 07:45:38PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some new developments for next:
>=20
> DFU:
> - Reinitialize only if dfu_alt_info changed
>=20
> USB Gadget:
> - New usb gadget driver for Renesas USBHS
> - Simplify kconfig deps for CMD_USB_MASS_STORAGE
>=20
> Android:
> - Provide bootloader version to android via kernel commandline
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22516
>=20
> Regards,
> Mattijs
>=20
> The following changes since commit 3a0b829efc35227b1079a444f00e0729502197=
ad:
>=20
>   Merge tag 'v2024.10-rc6' into next (2024-09-30 17:48:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20241003
>=20
> for you to fetch changes up to c74758ccc091402b558b9aa7eaf1c50171d2f49f:
>=20
>   cmd: simplify CONFIG_CMD_USB_MASS_STORAGE dependencies (2024-10-03 10:0=
1:35 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--4HrtdGe200xlmgAY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/VakACgkQFHw5/5Y0
tywH3wv7BP6poiQ53yuzUfvQ4UPCVqErqx0aMqRQ74XvH3GCsySRX5JFHUoQYCI2
IO9XMcC/FuKMfjTVv1j/XoCPf4B9VRSxO6dbS0CmSMuCFTHYim1MXZYamJErojzb
nKh/QIzfy/KqzcRkiU0//rFNpaj10OPgDn50v3Vh4sRYRqbQJpRTN+kLJ9Ygl+FY
57rss7Kb3lQpQS/l1C0BZCtis7mkY4LF96ANNvw2vPz0Lln+7164MJ9c9yA0pKzU
p+Un53YGqwiyVyuPBW5qR0fZSFiqYAlu5oRZBq21qcbn9papIFLERZFY5OdqBmlz
LW15yI7mnU/ZEOrRLLjDgCo/DcTk9gyzISAklDF5rFYs2lF4xKIFXayBt6HGwkIw
JHXmIF6VFkoa0v3rWQR254Aqw+V8CtxPllWe6xN2yycvK9H++wLsBzqcVqhs1E4g
/OjYu3BO5Dm9eJBBIKc2C+Nk/xYFcg3POFwDEa5JMdvbO6Gw6KlirUgOMReKoo8A
N6RR7/3M
=6vUB
-----END PGP SIGNATURE-----

--4HrtdGe200xlmgAY--
