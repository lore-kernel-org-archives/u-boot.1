Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2329DCD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 17:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D148983C51;
	Mon, 11 May 2026 19:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JoItNMSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C408341A; Mon, 11 May 2026 19:41:23 +0200 (CEST)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F259803C6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 19:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso3793203a34.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778521280; x=1779126080; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gxV1mwwk9AxBOMeB9x+zoSHmyGn5XEWceowh04OquWA=;
 b=JoItNMSJy31gSbnPfA9DOSKLphJk+URKoCszKd+A5oPy3uS1Ys3Mb46E/1HidpGOn6
 vAHqFO7c9Zp+L+iAmwozgdWT7D3Nn/Wsgp4EgIjJ3GYbfRnMlMWgl0qKBRzOHQkFaTeK
 BQgcH+Q2g0OkPJj/LWA6qXz6oFUNkyGxPuO5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778521280; x=1779126080;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxV1mwwk9AxBOMeB9x+zoSHmyGn5XEWceowh04OquWA=;
 b=Xx5kKX+X1BQ0YalaRHLJQOv9BpIdkvenbjvvUtcE931/Eh4F65rvm0cVfuLPJ4/6VE
 n68+KdrZaW6LSZHfcl0QovnFTa2RvCPTjf2DJTAje1v+t+yGGKuBO0o34E1cTf/mRY8H
 zlulQ9pUfI3X4E9YVaV7wo2PROFl4H8c/bkPwTC1m6+RY5Hz9z7RhNxHH5eDHjTiV9cZ
 +UeGJAE3ttg7zzGIpxngqqum0gX4biFqUXEXkwVaVvNfmsoWOn7O/oBWDyda3zbF2b3M
 6eORIBQ6/0IgQTX9DwbSvP4JNHPDdAd0amMAVNfyecPk+nyEJGD2vBmnKq4NpRBCPeka
 1m8w==
X-Gm-Message-State: AOJu0YzuPPxtz1gcpwNP4/azNTvN/yR/c5nrrxWPnw+WbJmyALCsz16y
 0d3/PN9tbG1/RS/RdwNdHVXlhxQGZOIAn7IUrNmj3MG7Mx3/qkLU52qVh4dJSrHEsk1LMKbBSpR
 tLm84ADfYkOiFibE=
X-Gm-Gg: Acq92OG+z/VqZkr5llTBOM7WmkSfmk6Aq6/s75BV0RGDGe+t/6o8oYKr8Oee4+X811C
 aJd5QPTGY2DGkp9Mv/YwrMD/SgIgxOc4Y7Dzzrvxh1eBMwKn2p7rEW8HYUD2ORT9QzxE4hwVgeo
 vy3M/QrovoG2ihy1vV1ydGk2x5cuCb45wJXJI+QpMAWolz477cYMtPNM8/n+92KIA9+Muhob/17
 AhEu0BuWQJIGM0q5EhH5RDMWPw6XByPtNB/qA5d/03efwtZlhusa/uUYpQFzKFfMC6lWOOHpid2
 jxip4WzfvdglwFnbQF9NuteGgK5nRDQPXpF13WH8p/X5xa2LJ5OqhqBxWMWyVq21QFVfEU5Hx+1
 F3WotPEF87M0yrlBsYZBJz9YrQeZNbNSYixmKePrlzD2z1Ib0Dlhj0SmM9YlBmeZMplSrl399XN
 9r2gU5CKhqelh5Vc9ke3JOeDtRlGRGiNwHk+92SScoGm0TF+oKGx6KW+l0QxG4eHp8qfsjvv4Hn
 l/yFlz0jvEAu9qy7FZf7p0NbowS+c6r9gkd58hkHTp8gpzC4JE=
X-Received: by 2002:a05:6830:3806:b0:7dc:cd0b:58be with SMTP id
 46e09a7af769-7e3661b0384mr8952909a34.8.1778521279703; 
 Mon, 11 May 2026 10:41:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367a18481sm7268253a34.0.2026.05.11.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:41:19 -0700 (PDT)
Date: Mon, 11 May 2026 11:41:16 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot Project infrastructure update
Message-ID: <20260511174116.GJ1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kQcJeO7e8b6eWFCG"
Content-Disposition: inline
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


--kQcJeO7e8b6eWFCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As it's now been made public, DENX the company is retiring. So I want to
start by thanking them for all of the years of support they've provided
both engineering time as well as running all of the project
infrastructure. We could not be here today without all of their time,
effort and investment. Thank you!

Which brings us to the next topic. We don't have to move everything
right away, but we do have to move. After looking around and talking
with a few groups, we'll be heading over to OSU OSL for help hosting
(https://www.osuosl.org/) our mailing lists, Gitlab and FTP site. With
this change we'll also be having the project be visible under
u-boot-project.org, as we do not yet control u-boot.org.

I'm announcing this change now, but there's a lot of work to get done
behind the scenes and nothing is going live, today. I'll have more
updates as things progress.

--=20
Tom

--kQcJeO7e8b6eWFCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagIUuQAKCRAr4qD1Cr/k
CmMtAQCgrIJ3a6W7M8ucnLKrtqrSeTuhUa3AZHr+t1VXRxCyxQEAoEaWWCYLjS+m
5NiMI0APEScUQXIpdBQczvamk5O+FwY=
=+akl
-----END PGP SIGNATURE-----

--kQcJeO7e8b6eWFCG--
