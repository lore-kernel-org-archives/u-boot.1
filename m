Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728A9C4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC47B87B1A;
	Thu, 14 Dec 2023 18:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JMX35Gz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878D787B53; Thu, 14 Dec 2023 18:55:23 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064D587B1A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e2be6dde31so11333857b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576519; x=1703181319; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A4jozJ3fL3uHrL7dR1rL++gS0eG22X/36eZ+ovqek3Q=;
 b=JMX35Gz3oI/iS9Au1CuGqr56JvBd+xVoqdOfUkWVmkWPvLvVp8oY26cjBih/qJF3ix
 KQBzPnkKW6mpQXsBM4wLeLc3dWDDQBwOvlJn5KuPhsmKxuNTRZqMAfYwvVCH2uZNji7u
 +OuidSwDHrzU44KRClQJ1DOhVt+q0fFxEHNuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576519; x=1703181319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4jozJ3fL3uHrL7dR1rL++gS0eG22X/36eZ+ovqek3Q=;
 b=e3LZyFsGlHWD+yHovYnyslNvCudaKsCIPVsd59XCSgeVePLk184whumuu+a5ueR4rq
 oGRfCXXvZ4AYWNzz/ycAB6oaAxB6/r1MMEDQQ/njzBoPJncydWzOPmE1WdgfMC3XksgF
 R6z1PqY+3FzzM4c1xBlYGTrG1wKWWVRwqP02JoVgQ3tuayWOuR00fyeJqWHZvlyDQPuF
 Ia+nB1uDo/Ul4PPtVonTVLjxm4lvtF2J805Su5VmgGPaW2nRNPKpgcDylF0n9DgGKrP5
 4xV2twrJZJUbWwS7UOP5YHAGfMayJUcVjtK/vbITGaUMIzjH7jnDvAuYzFQPUqvluhBu
 U2uw==
X-Gm-Message-State: AOJu0YxGYHFsiNi7Mtn0QEHw8G+9iB/VLnmBSTLFm8OWfbx6AKzS0tab
 4n2kiXmwndUboGvDI3AfOA+sBA==
X-Google-Smtp-Source: AGHT+IE27NJkFNtTjxBrjWP+bHZnNv00Y+GR7oFQ10dYE4AHbscxhZ7wM5HafS5f0tr3Lw2r/4Jizg==
X-Received: by 2002:a81:4e90:0:b0:5e3:6f66:bedc with SMTP id
 c138-20020a814e90000000b005e36f66bedcmr811393ywb.50.1702576518737; 
 Thu, 14 Dec 2023 09:55:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a0de205000000b005d37278f973sm5659867ywe.36.2023.12.14.09.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:55:18 -0800 (PST)
Date: Thu, 14 Dec 2023 12:55:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Roese <sr@denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Fix error message on stuck busy
 state
Message-ID: <20231214175516.GO2513409@bill-the-cat>
References: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
 <2f42b8da-118e-45f2-a76a-813bd034e693@denx.de>
 <826603ed-9cb5-4c24-b63e-34dceeeaf4eb@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qc6HUeIChM7Bm2s0"
Content-Disposition: inline
In-Reply-To: <826603ed-9cb5-4c24-b63e-34dceeeaf4eb@siemens.com>
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


--qc6HUeIChM7Bm2s0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 06:36:37PM +0100, Jan Kiszka wrote:
> On 31.10.23 08:14, Stefan Roese wrote:
> > On 10/30/23 17:20, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> We are not iterating CQSPI_REG_RETRY, we are waiting 'timeout' ms, sin=
ce
> >> day 1.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >=20
> > Reviewed-by: Stefan Roese <sr@denx.de>
> >=20
> > Thanks,
> > Stefan
> >=20
> >> ---
> >>
> >> We are unfortunately seeing that message right now, rarely but then
> >> prominently...
> >>
> >> =A0 drivers/spi/cadence_qspi_apb.c | 3 +--
> >> =A0 1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/spi/cadence_qspi_apb.c
> >> b/drivers/spi/cadence_qspi_apb.c
> >> index 9ce2c0f254f..d033184aa46 100644
> >> --- a/drivers/spi/cadence_qspi_apb.c
> >> +++ b/drivers/spi/cadence_qspi_apb.c
> >> @@ -171,8 +171,7 @@ static unsigned int cadence_qspi_wait_idle(void
> >> *reg_base)
> >> =A0=A0=A0=A0=A0 }
> >> =A0 =A0=A0=A0=A0=A0 /* Timeout, still in busy mode. */
> >> -=A0=A0=A0 printf("QSPI: QSPI is still busy after poll for %d times.\n=
",
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CQSPI_REG_RETRY);
> >> +=A0=A0=A0 printf("QSPI: QSPI is still busy after poll for %d ms.\n", =
timeout);
> >> =A0=A0=A0=A0=A0 return 0;
> >> =A0 }
> >> =A0=20
> >=20
> > Viele Gr=FC=DFe,
> > Stefan Roese
> >=20
>=20
> Ping.

Added to my dont-forget bundle.

--=20
Tom

--qc6HUeIChM7Bm2s0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QYQACgkQFHw5/5Y0
tyyVgAv9FaayTuO/NAxYHyW7D/v7ao2wjte4iwqxdFR+OA01ikV9uLLHEzF8/Kab
ov1daVqb2XueICeOza4sWjM6lqk32Z6oDT/2YA0dPJuCD5LvLZUKGky6NlcztKge
PPurvvA0pAIa67IAjGb7SD9pTZQp3ArQaglKytlhnnrYevlzq2Cx5vsPU7lYyk9y
sdp4VWw/5v/7R/55Xq8VD1YsxArYosLsiVgawXmo4E7o/hdBzCP/k0cQtlAOqjG+
7QscpuqIy4NBSU7xxOu8GXZNqKuq9fQA0f6kBfpCdzq6pTQz2Xduxvzku3kYRWNA
AuUxgK32SBjgjLyClPznOwmCAPLqBsgnze1iH6YaW9zfQGt0pnY2Pe0RIZNM5Zow
ErUicFnjLb+TL5Jf3WjkThuYlU1xIfjrUo6NdApNFQLOWEafvJ6+AEVOzWCHhn7p
Ou8AO1A9bSWPJppdMqn5vW+dR1oo7ocGXHxrFqVipKl5yAIRWkDUw4R1musLcTDk
9l6RRcoT
=6rRa
-----END PGP SIGNATURE-----

--qc6HUeIChM7Bm2s0--
