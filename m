Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A99C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 21:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C07388872;
	Thu, 22 Aug 2024 23:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MRTancQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8ED688651; Thu, 22 Aug 2024 23:54:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2997885F5
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 23:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-709485aca4bso922895a34.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724363666; x=1724968466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=henVfi/Ei6U9tAVdctjiTZC54c+ykQ5FgN4sshsGL7s=;
 b=MRTancQGVrhLLaiUwO29zvVku67volz6tLlz5jIPxbIFqAaOzy7DjrVZAM9a0NBucN
 LCCkG7ESCinI9EBoaggHvdtwBMdZMX0EFGD8e+qlicaBYg3uBCShG7fR46+NHn2wZ5Fu
 G6LfHYBW/1UWW7w7AMPCcZlqmCoZ7YTecX+4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724363666; x=1724968466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=henVfi/Ei6U9tAVdctjiTZC54c+ykQ5FgN4sshsGL7s=;
 b=Ka0Uv/SUpDYN1Ox7V/Ji6mVQnaYjzaW7OcTb53shxq6Z38B5iGWAKyLO+upFQVexYp
 rEIKUcWpV4t4Yw92Rwzlez2XYEYGHhHDNczXVIRc/4O4nBu44le9UTstPgpX5cGqKR93
 Km6sbYCVBphy3qdCPw4ybLwzWV1mMcD8Z8XBDAywS3PANCD+A+GZwJbeJvCo0bSqjmqD
 OYblyr80ayJiGAIxMBjcM6J1VXejb0CW293tCkxG1L2iTqbFc4J3tZlN2v6NqX6f5OhX
 gVIlo9X9+vveuRlbRl8ULnhM9vchVJwT6b05j3RPICKS/2axWSjq1E12P6RS3yBywkdz
 0xRw==
X-Gm-Message-State: AOJu0YzAIGaN5uvtwyLSVayBVl2wVOybnGwpXzH62Cs91ol+eecgIhRw
 qVsRPXbdIShbxwGyPVYpEGzoZ7jw1BW4lxi8A4ckRWBNKfmZslCtchvAu+45tfU=
X-Google-Smtp-Source: AGHT+IGXf7QON/mSR+2L6pTSEZKnUKjFILo9ukOT1k5Jh6os1BIY6lbordN2f5HwqsOq/PWaozRFLw==
X-Received: by 2002:a05:6808:170a:b0:3d9:3649:9087 with SMTP id
 5614622812f47-3de2a8b93ccmr225167b6e.41.1724363666428; 
 Thu, 22 Aug 2024 14:54:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de2252d3c5sm454527b6e.10.2024.08.22.14.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 14:54:25 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:54:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michael Walle <mwalle@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240822
Message-ID: <20240822215423.GW1626301@bill-the-cat>
References: <87h6bcdag7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dC5tbWzZs7O5Up6w"
Content-Disposition: inline
In-Reply-To: <87h6bcdag7.fsf@baylibre.com>
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


--dC5tbWzZs7O5Up6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 02:11:04PM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some fixes for master:
>=20
> - Fix crash in BCB on invalid block device (reported by coverity)
> - Fix booting Android kernel without a ramdisk using fastboot
> - Fix ux500 gadget driver ops based on CONFIG_USB_MUSB_HOST
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22076
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 0b06e052fb153958d470209dab237f12796cb0=
da:
>=20
>   CI: Update to latest Dockerfile (2024-08-21 09:41:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240822
>=20
> for you to fetch changes up to e49eeb6575152cac4241f3c87471934a726970e9:
>=20
>   usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set (20=
24-08-22 09:23:33 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dC5tbWzZs7O5Up6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHs4wACgkQFHw5/5Y0
tyytTgv9EbfjlCcVeyDuon+kGZO6nGr+ByiAxCRzi18PNbcwCDKng5u1bYV/TPpt
RGwlau0SbLVS1TppyyxUmzKpxr2YkMObLnxlRwoykfXb7Xblj/GDNr5RUp+n1i+O
xjZ74Q62Sp/Uee0hU+aOnEK6I4emKQRMdferLgz2VcUfhiT+uViNFOk5bWVTs7Dm
S4btjjb9fLhMxPSq9ChxS5VIYmx1V5pRUe3R8HEVzFSyDOFw5NBrb5293Fkh73ON
pg1SHd4Qt9wUefjjRyztQBA/rrONPEqEjWV2FuKRH8dolu2X/qrdqo0TXLiLJbW5
oreV4HpAIy6/CrpQJ0k0Z9WHWPvtZJwjJCehyT0BPOgH1RT+KGYYHssLJMzhZ1HB
ZsF9o/teWJb5KuaFZbnkWc9Ja+ML3IuRNP+KniBLu0adCkvnd7qIu1zC4C9BLKLb
dgByHx9o7sy5UJBmS2P2RTiFg5S2izIK4P3lU2RricnZ26tBpBX6Ir9jhPC2SoIs
QHTik1IT
=eor2
-----END PGP SIGNATURE-----

--dC5tbWzZs7O5Up6w--
