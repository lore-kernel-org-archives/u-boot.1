Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDA4CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627C480107;
	Mon, 20 Oct 2025 16:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KfL+bfGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1FA82C84; Mon, 20 Oct 2025 16:15:55 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F115C800B6
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c28c21aba1so1711484a34.0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760969751; x=1761574551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BkU9Gu7XprTYgL1Q6frjJc//xdgVYFbZ35HcGBSkmFo=;
 b=KfL+bfGwPbZNmKfX2dBxBrqDfj1VzC2Vu1KMJcWGZ/G6xPZAFT5s1TlUPxmpms+Nfr
 VJZ2oIC/bG/6tKnDE6f4h+2oTNUcRdGhc0F7hM3QAcypoMJNxS118L4fsxGLKrWxzPBc
 ziXtxwVnpfsHUeWyTzWOuiJLj/RM7fR7R1Ct8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969751; x=1761574551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkU9Gu7XprTYgL1Q6frjJc//xdgVYFbZ35HcGBSkmFo=;
 b=iYu2BKLaU50An8Wj1IgRAcEDuALPPssNrNJdXxpf2HrZw+eYuc+ewld3KCnNcKMGzz
 yKO0ZRj00Iua17SvcSyHyl2GUBUeS43ijCeM+rOME2/3KEKKVFveAhnLxI8M5z0Rr1Fo
 YmNRJIXwZHeRwV/frijkhfN76dHRiWJ5f1quGsRbxqiLDa2QOeiJ2WVnCq/zll+DPLsY
 t3FGyJY/IYKY7fbxQXVV6OXsLmdq+MJDsafTq+gZtwKCW8UzyGgJ/ssXCeR9zTUD0gJU
 QPIqZRpmVndw528d71/+ZhJcGAtyJpjKfbnUxeXzrbTcF9n2Je6BiYmA0fYVE+Iqfe0l
 wF8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD22QB6QY8ySifbf0YK3mg7k0UhZIAaEPR5hUlbJNa+aRxH6OEZbR5lloBXevIYHyGCskZ3eg=@lists.denx.de
X-Gm-Message-State: AOJu0YzWfwTsTJcFDJmdzm6YmqevdlH9or3TCJ21ia4d9U6YY1B789fv
 t8/aRPGYhcde51bl75fjV33rC092n9rVBbQvwBjdcmP1gOuKK03RUFNVJi/3HkqaTMc=
X-Gm-Gg: ASbGncuimzCBjJ5QeQ0Qv10e2ibBq8TW+Zt5bH2mVFoHsBKd+JXlYwgVlV5vJZ7j0tU
 ZTiXGvE6tEsz063iduwAhEkHvV7Ku3vRcv5SwnnJOoBCjZ9C0mLNheGtUpdkwCc8IdI0Kox+Yel
 jnyBh6QNQMTopyGTbG42DnFOggfF2Ruc8BE7Wl7LhjxDDdXcVYYZkAJzLd3inRNReHtj1K0CEix
 Pl2csWdTWj49twKrwVFcJhYU/RRRwJCBE23MH6tMU33CpZL7t10XWG/yQR6wJB+cODuWvVWi74R
 HhcNoMzvIKXNAKMooh3n/z+dcMtMJ1DX+y6WmgREw4JvuEOYzl0wCeSdT3tgQmUSAZRE9PdIPXk
 yUO4Cf/ZnbHH0JX3I3ZUHQ+a8HPrtZwMDJw2McRslR9ov+QsaELoHibMrCGepmpcjGCye7536ID
 t0SQ3yeaN1mkrKH2qaEKVpMC8U2EyLyqyAWzAw6Tc=
X-Google-Smtp-Source: AGHT+IGMlWvYmFKGX53m/wQco/lLFPXEiaheVOIwaadqd/KPpFF5wV86ExBwtO4l0QnU7VPLsSiSNg==
X-Received: by 2002:a05:6808:6a83:b0:43f:648b:dcaa with SMTP id
 5614622812f47-443a2ec9ed9mr6304929b6e.7.1760969751574; 
 Mon, 20 Oct 2025 07:15:51 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4dafd6sm1877374b6e.5.2025.10.20.07.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 07:15:50 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:15:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251020141548.GS6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RUh6DJhrbaz7fsNp"
Content-Disposition: inline
In-Reply-To: <20251020115009.532a1a99@kmaincent-XPS-13-7390>
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


--RUh6DJhrbaz7fsNp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote:
> On Sun, 19 Oct 2025 10:48:37 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:
> > > Hi Kory,
> > >=20
> > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > <kory.maincent@bootlin.com> wrote: =20
> > > >
> > > > This series converts the extension board framework to use UCLASS as
> > > > requested by Simon Glass, then adds extension support to pxe_utils
> > > > and bootmeth_efi (not tested) to enable extension boards devicetree=
 load
> > > > in the standard boot process.
> > > >
> > > > I can't test the imx8 extension scan enabled by the
> > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > I also can't test the efi bootmeth change as I don't have such boar=
d. =20
> > >=20
> > > You can test this with sandbox, using one of the bootmeth tests,
> > > perhaps. Let me know if you need help with this. =20
> >=20
> > But the question is, does the real hardware platform work before/after
> > this, not does the sandbox test still work before/after this.
>=20
> It seems the bootlflow scan is not working on the sandbox on next branch.
> Is this issue known?

Is it fine on master? The next branch will be out of date until it
re-opens with -rc2 being released (2 weeks from today).

--=20
Tom

--RUh6DJhrbaz7fsNp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZEEAAKCRAr4qD1Cr/k
Cg0NAP98S7msiTEt5Cv7ghyiYrb/D7/Csk7vIbzW8IHNE/dhOgEAsPpjLgj/ToX6
p3r4kmM76k3DfRlPnjOovJjt2u07tQ8=
=5Je4
-----END PGP SIGNATURE-----

--RUh6DJhrbaz7fsNp--
