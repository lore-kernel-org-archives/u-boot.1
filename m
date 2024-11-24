Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D920FD10C10
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 16:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CAE489546;
	Sun, 24 Nov 2024 17:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nR29zlJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55B889564; Sun, 24 Nov 2024 17:50:05 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E3C889517
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 17:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b667348bd0so33147985a.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732466997; x=1733071797; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X+VvmEwSKo0WlqoqIBfmTCMKcc5o91Yea2H8E9ijPaU=;
 b=nR29zlJk6U/iMLbkJWzYqgrqtLNcy6Ti4Lli3HTnDSicwHLIlhEjAJAzGQHi1fzgQN
 M6uJgsbcwC1qXOmdQdOF7dp046cKP4VibpogyWtfvvB4y9zs0kGAmRNKpCN9TUiQsUP4
 TPrze27/xUxAjAUHirEhYMqAW5xR+FM4MU0lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732466997; x=1733071797;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+VvmEwSKo0WlqoqIBfmTCMKcc5o91Yea2H8E9ijPaU=;
 b=rJS3QqwkrvcL26yJ592OgFPzzCWN71YJ1po0eBWLSOIMoqt92ZBUMEnOjuI9MEfXSU
 wuh2B7mqDk724+aBeMBTuCaNSmriJDggghkFKiIppnW92b0xLWC/1xKuvp9X0Ax93uCk
 ukrUqcyR9bKsFrVrQNOhnafOQnTj0BqgRdc1npS55BHtsQBm19FzanLg+30hntF2mfY4
 vwqgqjMS0WIk+oIzJfupCn5l3i24pmx2q+MTBps6nr9aBBAS01Fi+374T0SeuoBXvFyg
 kvjiGrH+2iCdrotUBcU6QyrXo1yjcdtAl2jaYaGA7QrbEVZdU0PSbjRYeAOQ4NWWHeUI
 1OJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFhN4yiZzlf7i9aUyMIfJE1HuXB7nqc30PORcznvo07r6/fvCEdvR6xIvYl8kbU+fP3hTmKRk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzg0RH0cVRk+twbKSRMMAbGU3IFBNVIa8OoDDnMPQQo7KKgcXZU
 pGAT8LgTtFfaGbr0vglc9gGYe/aLO+Gf2fklhPjv95eANDoYJ47l8qxJHaurwUg=
X-Gm-Gg: ASbGncuFKaXRL+WGSlCk5OcDmK9ElKKqcdYT2EYNqTFBaK1sV6NTMNSfGhNrgiA/C6f
 gQeozOYOwdebIH7urElQuj0+y3P1rIQpy7ZmgXWw2HG8v0C2KGobywxHoLIgCn8mwzqzAsrfVo0
 Edd8gNetquELxEG1brAkC+IwSIYWqVYn1IMzbAW/JkRpdx+iCWE2nMZEpT+IOOBiis8oh7MmYoU
 vZI3S/l+nwVxPi6ZTYVY/EdsF9FZzsccbdo/W4+fbaRlCFJwg==
X-Google-Smtp-Source: AGHT+IFic8qpUpbpMIFn2l51iynBsCAPNGzYQj3jQYgqiTTh69T3RXgG2zvcTCTf3OuC8H8hhfPDUA==
X-Received: by 2002:ad4:5cee:0:b0:6d4:2242:b91c with SMTP id
 6a1803df08f44-6d450eb57ffmr169671986d6.11.1732466997176; 
 Sun, 24 Nov 2024 08:49:57 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4ab48sm33096426d6.108.2024.11.24.08.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 08:49:56 -0800 (PST)
Date: Sun, 24 Nov 2024 10:49:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/6] configs: sandbox_deconfig: remove
 CONFIG_AMIGA_PARTITION
Message-ID: <20241124164952.GE3600562@bill-the-cat>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-3-heinrich.schuchardt@canonical.com>
 <20241124161741.GD3600562@bill-the-cat>
 <CAM=mAOkN5BGL6OJG23kW3iE_rpOiri-p5pp66qnD-s3BVE1fkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="29xdwirhlBIXX33L"
Content-Disposition: inline
In-Reply-To: <CAM=mAOkN5BGL6OJG23kW3iE_rpOiri-p5pp66qnD-s3BVE1fkQ@mail.gmail.com>
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


--29xdwirhlBIXX33L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 05:35:31PM +0100, Heinrich Schuchardt wrote:
> Tom Rini <trini@konsulko.com> schrieb am So., 24. Nov. 2024, 17:17:
>=20
> > On Sat, Nov 23, 2024 at 10:45:50PM +0100, Heinrich Schuchardt wrote:
> >
> > > We do not actually test the code.
> > > Scanning for Amiga partitions of the sandbox is extremely slow,
> > > especially on the partially implemented USB device.
> > >
> > > For build testing the other sandbox defconfigs are good enough.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v2:
> > >       new patch
> > > ---
> > >  configs/sandbox_defconfig | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > > index 718e4a8283c..683888f238f 100644
> > > --- a/configs/sandbox_defconfig
> > > +++ b/configs/sandbox_defconfig
> > > @@ -142,7 +142,6 @@ CONFIG_CMD_SQUASHFS=3Dy
> > >  CONFIG_CMD_MTDPARTS=3Dy
> > >  CONFIG_CMD_STACKPROTECTOR_TEST=3Dy
> > >  CONFIG_MAC_PARTITION=3Dy
> > > -CONFIG_AMIGA_PARTITION=3Dy
> > >  CONFIG_OF_CONTROL=3Dy
> > >  CONFIG_OF_LIVE=3Dy
> > >  CONFIG_ENV_IS_NOWHERE=3Dy
> >
> > This means we don't do static analysis on the code anymore either, which
> > isn't good, in theory. In specifics, this is fine since the code rarely
> > changes. But I wonder instead if we're timing out too quickly now? Or if
> > we should have but weren't timing out before, but that's now been fixed?
> >
>=20
> There are still enough other sandbox defconfigs which build with
> AMIGA_PRTITION.

Yes, but only "sandbox_defconfig" gets Coverity scan.

> As we don't have any real boards using it, should the Amiga partition
> support be removed?

There's two real platforms enabling it, but that could be by mistake. So
no, I don't object to getting those platforms to ack removal and then
removing it.

--=20
Tom

--29xdwirhlBIXX33L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdDWSUACgkQFHw5/5Y0
tyxqmgv+PyBzosRMeD+I6e8bw00gsMQ9t7tKe0Z6o3oS3KRidl2/CMvU2Y5tlx6r
6okb6gn3dXWRi3VyzrcKSuKO6X4xOmZRA01G12OYVjKb0ZW6sYpT4yuRr01a9Sq6
7WEtbPliKwKLWiQAUA5Inl/haZJQBbeskagD5zT4cp/loz1NFdklanSFFa2tmMJR
HsXhxcBF7i/OtOlBJBpdDWuZ118LUqeLXEMOcadVMkIp+kudKq7MNQWXIXMnYxLu
Ngf3CUQkerKbDpiJjKBkX2cqmUx09VALKHQDwi+OvJahJeM57IxyT7SvB+qaJYw3
P3SeklHCDzOaP7oUsRsELuZByUXPLyjOp19PIrH1pNo3bmt6+EEjqk9wkPZj/EkR
PWe+nC1Vzh8kkxxgrOiTcDFeLni6Qf/J7vdcHd3YJYMyuL1CIYB3q8NleiZWz81+
UWCuS5JrkxUpFp3OEICGJHb1JnZvIK5t8Pw0LzMuUnLw+1/cBIrHnYJcYqHYPUgF
5j2MysHV
=RghI
-----END PGP SIGNATURE-----

--29xdwirhlBIXX33L--
