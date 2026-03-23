Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7163F483F3
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573AE80325;
	Mon, 23 Mar 2026 21:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TL8khelo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99EC838BB; Mon, 23 Mar 2026 21:33:40 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B8880212
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:33:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso3075346a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774298017; x=1774902817; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/yOyKq73MMeo7h0EU+xmenhW6TiHHT9BG+K+DrCAuAY=;
 b=TL8khelosswdmreC+4Lak5Lc9lPuXRxkRXH7YQpL1m793r95YgXkWyIPOVv9Es0MtL
 RgtUd0aLI2xPtXHK1fiR5ER0acN3a/F6u5hgl5oT5dkzl7toTWU3O2U6nkkSSktKiU8D
 PpMSRjk22odizGfY8k9jScoxznrUDm6Si+5HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774298017; x=1774902817;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yOyKq73MMeo7h0EU+xmenhW6TiHHT9BG+K+DrCAuAY=;
 b=QUGc8zH1yRSJWBbM2dpc0BqwxvH1Ggb1xnxDlZNKaNRbEgO2W25+ZEnuEeJFdNZKQ0
 TTbyeKm7Azjz0BoAvgBdpEfOUEFMNI+BWR9S6/d5d7Qm+RVRBwywoJ7f/GMG8AcpN/bE
 Ttw1/NESSb37DuwNVOD+R+Mpvh7GzmkeQ+FAft+lnJUoZBp+Wx2j7jhbMnUlvdJ8Bdcd
 mOVP0sbVK/a+UecElmgNhBbaMSyIr/GKrOufJoFohP+9dgKyIpG2E4ssW2Uee1eTH2lW
 VBK2hyByfvsRy6vasteHtFl0QpVsTCIG9ZROzGYSqa+pSetIBWHA7pL8isPwGLBh288/
 jFLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqWpKsH7gOdiHSPy79sy6c5phZK/FcwdxeOz4b6ExdUXsZgLhEhjRP5ns/tcQ6dMx5yRpnr6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxz6olmuEH9rkuW41hQzZ2QEG8gYz8IPdjh/OFjt09Cpf4XZ3im
 IqKbhnWQMz9fuXIgZts2cVWJN/zqHr9JtmTHJr5Kw+Drj6f3EMBEseeAxK5gqOrdacM=
X-Gm-Gg: ATEYQzzxHZ+nSFaFN/tqz5id+JWk78N4EzH04le+aj/Y1Nw+E+iUSwHVOpq2JA57gPE
 TpZfnaiWDZvTuaWcduJd2VLSEYiMBmd1KFZx+FP7zkVDMQ4Moy8k13tFiILBEHoiUGxNUfo7Jix
 9gkKmTtVfa2cl9mm/7cGa8YcuKF5VarMClLjMHW3y5p+tEI/hkMflYTFgeVuTgaNlOvW+Bi2Cje
 l1yTVaDQCcNqeASXrEZO3hz6hHc95WZd9h73RYynLAm9Vk+49h9IdhHvKoQc70rifLThj14iyuk
 QoLQZ+GjtDjFIWSbhmmWmS/OKP5iegDLUYKoBK+qmT8IAqeNTMzmpJDYyrB1e/dQ7i9iqKD42ZJ
 AQianK06cBDX3GbnSbYBeuA+ljHk45e56wYJy+Z5jThs6rRF/BFFw92HBagFd6LCYL14+p63gzB
 qyqR3by8QRC+9XmGsbtZfyjrzfpMYMQvhxYWKN9ELLb4YTxlNNDIYVlfPT3rOpqVzawj6cdsJ2H
 mp66xh21OfpEXlKM92mNaPsid8zdoKMgdRfEZhpRcyxlk+uYsRqP3Qc6Ag=
X-Received: by 2002:a05:6830:3144:b0:7d7:4fc9:5204 with SMTP id
 46e09a7af769-7d7eae2563emr10156533a34.2.1774298017100; 
 Mon, 23 Mar 2026 13:33:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadfc678sm10086755a34.19.2026.03.23.13.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:33:36 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:33:33 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/6] clk: mediatek: mt8189: add some VLP clocks
Message-ID: <20260323203333.GN502704@bill-the-cat>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-1-19dd92f4543f@baylibre.com>
 <20260323202358.GM502704@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bSj3xTMogacbwU0P"
Content-Disposition: inline
In-Reply-To: <20260323202358.GM502704@bill-the-cat>
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


--bSj3xTMogacbwU0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 02:23:58PM -0600, Tom Rini wrote:
> On Mon, Mar 23, 2026 at 03:16:52PM -0500, David Lechner wrote:
>=20
> > Add some VLP clocks needed by the PMIC on MT8189 and similar SoCs.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8189.c | 289 ++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 289 insertions(+)
>=20
> I'm working on a series now to fix this globally, and it's not a
> MediaTek only problem, but:
>=20
> > @@ -1733,6 +2012,16 @@ U_BOOT_DRIVER(mtk_clk_topckgen) =3D {
> >  	.flags =3D DM_FLAG_PRE_RELOC,
> >  };
> > =20
> > +U_BOOT_DRIVER(mtk_clk_vlpckgen) =3D {
>=20
> This is a bad name to use. I bet in other parts of the series you re-use
> it. These names need to be unique within a binary, and while today they
> will be I bet (since all the other examples are fine), someday we'd like
> to be able to compile test (and so static analyize) more code, and it
> will clash and fail to link. A better one would be
> "mt8189_clk_vlpckgen".

Ugh, and I just hit the build problem where I see these re-used names
are important. So, thinking about things harder now.

--=20
Tom

--bSj3xTMogacbwU0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGjnQAKCRAr4qD1Cr/k
Cq+oAP0THhH2PSZMje637TDtnZzK9dtnDuygQgBuu8dLJ4+wiAD/bezVlJEcRI++
lvwbYevnN1O6BTuUNJ0hsieh3EyhkQc=
=JESN
-----END PGP SIGNATURE-----

--bSj3xTMogacbwU0P--
