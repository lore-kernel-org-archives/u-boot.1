Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F4BC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B4187F1F;
	Mon, 18 Mar 2024 13:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/oVbD4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F2587D83; Mon, 18 Mar 2024 13:27:24 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE5787F22
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:27:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-690fed6816fso29770596d6.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710764840; x=1711369640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vrmVeBItCn+6gDw0TxtrfWBtzpUhxJmiiDEdMtt3fSQ=;
 b=G/oVbD4mZj8KDlKFNd600uS41Wb4SSpWmkU8KSwp+lOdoVcFi6dTgcRY0Vw1rbhBAc
 gobr/R0OqsL6LqpqWFNtFR+ac3tGKB0t/BjpOB1G31sNI5TofqW6bIPZ7fsIa6uwUPtL
 wltQeb5HnXXJtInL+m5it7K3yqzguAAXpFDIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710764840; x=1711369640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrmVeBItCn+6gDw0TxtrfWBtzpUhxJmiiDEdMtt3fSQ=;
 b=Ag0T3H1CtxwIaxJG+EDGxk1yCfnL/2P1pq7/lSDEDaK4tO9dc8z1jneo9lRUd9H+Bt
 i7cVFIZEDtoDM9xkT844AqLr/mgO6H/NlQuasvTXCS5WtO5fzUly9Q6jSozdwbFRkyBf
 IcFoksVoqQ4t9ag4wKKnvXZw92QrOLY6lkUgRvI/ALUEwvp/OAJAsb9BP2lJBjS5GBK6
 /iMpeHA5OMQGVcRaAzG47u3hvfxQ8IDYhI9aX0mjE2OZNLidmmTmwjmu2vgTxIWaVltz
 m+B6pp1saGwrRdLd+eIOvX57gxdeF6UD9D8ieQ6PF/byUSHc5oG0wadgUoY7mKWgR2Qe
 aAAw==
X-Gm-Message-State: AOJu0YwKfm5hVJWzZqG8mguHlqVmauapec+mhTU1IDRwtv3r2uiZKIWA
 baLhUudie0UjtQDUcqkzfN0LpemIbOn/ug954/uKTVjfigkbYbSQlDMT5eg6afg=
X-Google-Smtp-Source: AGHT+IGjtvMoLDExiqGp95zZETDELL5ss9+Sas75Ut6jfElQebtHPn71PoH+RL/oiU8keNZ9XodA4Q==
X-Received: by 2002:a0c:9c02:0:b0:690:f50d:7f14 with SMTP id
 v2-20020a0c9c02000000b00690f50d7f14mr13337551qve.20.1710764840587; 
 Mon, 18 Mar 2024 05:27:20 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jp10-20020ad45f8a000000b00690c5ec348bsm5190695qvb.119.2024.03.18.05.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 05:27:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:27:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20240317
Message-ID: <20240318122717.GA3442575@bill-the-cat>
References: <20240317235015.333272-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BvWFXBq50rsTv7nW"
Content-Disposition: inline
In-Reply-To: <20240317235015.333272-1-festevam@gmail.com>
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


--BvWFXBq50rsTv7nW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 08:50:15PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this material for next from u-boot-imx, thank
>=20
> The following changes since commit 099c94b7613bb10d97936447f5136f3a366943=
25:
>=20
>   Merge tag 'u-boot-rockchip-20240315' of https://source.denx.de/u-boot/c=
ustodians/u-boot-rockchip into next (2024-03-15 09:15:31 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20240317
>=20
> for you to fetch changes up to 86b79cf131b64eadae023a127921893d30503093:
>=20
>   imx8m*_venice: move venice to OF_UPSTREAM (2024-03-17 18:39:54 -0300)
>=20
> u-boot-imx-next-20240317

Applied to u-boot/next, thanks!

--=20
Tom

--BvWFXBq50rsTv7nW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX4MyUACgkQFHw5/5Y0
tyy5Twv/XR2N8cr+ZxL6I93X6nfG0gVUPnR3uiUQ/YkxPf6nl/XkM2uTHDYgooxN
v8uU1Z6gsO5MpvT7bSvnl5JUS9FW3UC73dcl/HYQVwWvW7XrckxHDhgc5UrUgv6r
i/goYKlpWVhVlsxvoRu7yifmUd0HLEp17TWJ2DeyF1vQceZPKkMUQ/8nbeIrGOJ2
opVg8yLJR3Aa8ZPkM+ztMQFOX3OYnA88Ld4FbzjXyDq9VyC3JMSdgUXcI0TANtk/
x68e+WNtlxFzwGz94s2ZvUMkANGTxpDqhGpMpKekqZOjeEs9tn3YLkiHn47jlDsk
ODMcn6e5KrMPBBc/dWDakSnvSA9TOMLmqZ0zCp244Dl1mJucnkqc10ubHdAiz3DN
//By1w5CLIDJ+x1uov0oncTP2BLcDuGmUSgtvhnIIR+GfPsEvDag6mwGaqAbfYqZ
4l6gZ5IsT+0Pu1YBBGC6vWXQQrQ30p29Dd3FGZ24DESTsOhBo4ZKuZ3gtKR+/e17
/uUhCGhe
=1W7z
-----END PGP SIGNATURE-----

--BvWFXBq50rsTv7nW--
