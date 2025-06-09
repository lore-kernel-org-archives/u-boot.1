Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8008EC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 21:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9317082B18;
	Mon,  9 Jun 2025 23:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWomhVq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9CC82B45; Mon,  9 Jun 2025 23:55:43 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4DB82B0F
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 23:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735a9e65471so2909849a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749506139; x=1750110939; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ePScpWBPslkvlvk8erzRYfXikkgSWwHF5Ac2xRumQ+U=;
 b=qWomhVq3lt5sYwPsYvi2WfD36sos6bg5DsTV765g9XSOPt4QqF6lWvmoroGZoZelxC
 EcEGTBat7zJusKEFeCTqtRB6mdsjPeVEp5py4kL7Vt6cqPZFaCRVTyA8OHwMN55WpZIR
 83iIgrNreAtDKTkPHm4dfHroYw0oJdxLTGFmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749506139; x=1750110939;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ePScpWBPslkvlvk8erzRYfXikkgSWwHF5Ac2xRumQ+U=;
 b=YNOAej/aI784Ptv1fLoN7i1v5ehFiSKekJnPekSR4RK2gAiP3D0oGJr6FVCVmXVFXc
 AhexrbJeU22rcZhwi4cZP9kBMrBOLI0E9EXolH/j1u1qlqPCZMqN5tshoYQv+5qYHA1q
 X7IxVTiitxRC7HGFEuGfU1OOk26751alXQEMC8tmiMnGJHKZ3aOv0lcVWycABQ7m2qZ3
 YRExRoEbVpzDdbkLSQrwxRa11dbu5+TDQ+OWrROjeIyXEDPeuOsQ29nlvaC/jw62kdVK
 GrG6uT2scOZZjed5Al+2IxuKcYLmmePmOXjGORumB7ww7h8BgDy1HMDi7THguevIM79N
 Vtow==
X-Gm-Message-State: AOJu0Yz7j1aWIqCCJAwKSx6BJB5LH6YRIO8sbRX6n0GkenLW17+6Xsc1
 Y9U/HqoQdbcbsnBkLQ4M5+PR+mVnZInaV9hmK9hFwph2tVPGqGui2Wm2ew1yFSjO8bCNYCM3r4x
 KI3fdsyw=
X-Gm-Gg: ASbGncuFJ6N1z6mt5TTY//W3wRLeYDBSG/PjuOMj3SBh4fuSoCN7GpgH5T1tbHnt2aO
 Xxl3WK4SI68TK7tLfVNT7HJAmAAai1LRE+cTKbEuhEYq1vjRyco6MRolQT9QNad7Od49DFfygBD
 KtdXG69e5N4mDEhFKemTn4C211hzAJ3cQo9UuEi8PSqK0lirp0fjXBrzyX1bQU75OUzLoB9kBSa
 d4TEqsCPAsC/RFm1Q6Mln9RP+p8tNCOh3JqalmReQM1VCTtyaavEOHTrRKrGsC5dWRJ1tms9Z6c
 KgTpdg8NPaE8JVaVX2+R8sJJj4rsfrbYB0a45m8/NNJyxeQS4pJQnB9+IPtpTt8/CEWkatqcNPB
 kZS/2lfhgGmgELK5U9XGm26A=
X-Google-Smtp-Source: AGHT+IG057OLqV08+E0HhbBdAUFKwVhocn39uG1Y/3vwMngcKwmPlyqiG07Ka0Rsmohx52iRexRSkQ==
X-Received: by 2002:a05:6871:522b:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2ea7d0a285bmr153031fac.12.1749506139316; 
 Mon, 09 Jun 2025 14:55:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea070f1cc0sm2046408fac.20.2025.06.09.14.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 14:55:38 -0700 (PDT)
Date: Mon, 9 Jun 2025 15:55:36 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07-rc4 released
Message-ID: <20250609215536.GX1382132@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rn2W2aWx2Mmlw5Sw"
Content-Disposition: inline
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


--Rn2W2aWx2Mmlw5Sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and first I see that I put the wrong subject in for
the last release. We had done -rc3 and now today, really, is -rc4. I
have now tagged and pushed out -rc4 and will be syncing that to the next
branch shortly. At this point, really, we should be looking at
regression fixes or otherwise important bug fixes. New platforms and so
forth can go to -next. In that vein, I am currently looking at:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D460155&state=3D*
as patch two fixes something we introduced in this cycle.

What I really want to call attention to however is this post I made:
https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/
Where in short, I think for the overall health of the community and the
project I need some help from others in the community, on not strictly
technical matters.

We're continuing with a community meeting following the release and is
the same time as the previous meeting. The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
June 10th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a changelog, roughly:
- Documentation updates
- Revert two different fixes that caused other issues instead.
- Revert some RISC-V changes that had introduced an incompatibility with
  previous userspace tooling.
- Rockchip, Qualcom and TI platform fixes
- Assorted other general fixes

At this point we have one more rc two weeks from now and then the final
release will be 07 July 2025.

Thanks all!

--=20
Tom

--Rn2W2aWx2Mmlw5Sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhHWFgACgkQFHw5/5Y0
tyzrPQv/Y1bZB4UaqM1SAV75sEk8enmHSGfXxJEtEP7TzZ5A+v0Y6MuxKEo3bYcL
LuAE+LVfPapbVUbQzMGvKAPoBf//6PIevLkHlmJHo0sJOmFTi93mNcH3pI0J//4/
zvuPgpYPQ1PZ8H9D/uPZq9euynbqrTXgDw1O1feuIxLxubyna7ZQPVozRx+7EdI9
e2LTrGiQxIjMEDamrBFc0JOPw/kUqKrNl3q1RPPgH1W/Zr9//xtxE221phzC60pn
6oqU8J3oxHpAZ/keDFhrYnaWtoJOorj1KR/RINe8WW4+MP3cTwt3Xin2cGH0No+Q
e0Ngq+KvjXNv08EgKoJlg4KnvXS8tEGFIDceaTfyOftZR/5kj3F7GojYlUUFlBRx
VGtjjOCg/8jj0A6FtstUi2N/c0CHs541m8l+Lxit+UyqZeP24Lec1rhs5qQs7Om5
+sSlfJpO2o2DRLIf6iA96VI6k/Fc2Q77wNGTQgUEZBUFdJP8m+0+fJ3apyeaVTGY
+KKyU6DP
=S/7e
-----END PGP SIGNATURE-----

--Rn2W2aWx2Mmlw5Sw--
