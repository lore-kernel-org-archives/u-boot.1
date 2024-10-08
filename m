Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD2CED263
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 03:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B970388770;
	Tue,  8 Oct 2024 05:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tyvwd24E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76540881E7; Tue,  8 Oct 2024 05:47:53 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE31388A24
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 05:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so521393685a.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 20:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728359267; x=1728964067; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VD0fzoI/300VFNNUb746sHShmwu2qT/37oGTQl4LmBs=;
 b=Tyvwd24EublSHtX5Id3FCUrrl4rL1sSQMGI3pLVd8vL9DFtnqVVDarD+w1Wt7pg7rL
 o/LmbICYFPaR3l04OE5ayqZTwPOgrVL9NerRJA5Mt0dDqF8qShxG7dqCgXmFjHg0lC+b
 UQpAoYGNo0B7Fl6/hdUdKpDoLea4ky6/wQ7FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728359267; x=1728964067;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VD0fzoI/300VFNNUb746sHShmwu2qT/37oGTQl4LmBs=;
 b=Ni0Oc+2hCylWI/uR38O4/HzZIP3c2owZ3VjocjgZ5iRtHk5E30LS0xj4Ci8aePDB2b
 gINtPVh0yKJGhhKnM8cjeyAz52dk2rVSjgeoj0tKr69NIbkLRQi9Ru+ji9zu6zjYccwj
 cJOl/ahVOu6C8ATu2L57F46/CrMz14WsWfNUO8AXac64VzO6LeYGuXiwZ+AiDMFcpwqE
 e54q1mj/noFxKFaRuxZekHKXfzZ4gZOeZ3MjU3AV9KVJ1NY8v+EMcA3rHzv6S1IKELCv
 x6U0pcoFFt1hAkN33oAjf/ZwS21Xe7U5u5o+tpFkP+HjgEH0bEUjgafVrlRDWcaCrxaU
 Rd0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmC0qheFMo1292WQCJaZSAuIbQ6h2bOBz3JIDi3y5yNhE2lSpEQ9xbKl6jmOPT1FEh5Glmbwc=@lists.denx.de
X-Gm-Message-State: AOJu0YzkbJX6CdviH3hDqaM9Ghr/lVwok6SdMFaY0QvNcSKjN8KNZs6Z
 lcfEhCpD1C+k6lWZ2FMX4Y9XgjoLwEKue6FbFp9IKIwBUskYgZm15tfbOKT2p8A=
X-Google-Smtp-Source: AGHT+IGS65Ihgx185yN8RYDABuIGWys8b06ht8NctitlcFo82u7HNdmQqWYOPBftaZTbUGbjo+eHVA==
X-Received: by 2002:a05:620a:4452:b0:7a9:bd68:462e with SMTP id
 af79cd13be357-7ae6f4412b4mr1896287485a.20.1728359267486; 
 Mon, 07 Oct 2024 20:47:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cd4fsm315332285a.50.2024.10.07.20.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 20:47:45 -0700 (PDT)
Date: Mon, 7 Oct 2024 21:47:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "lukma@denx.de" <lukma@denx.de>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 "etienne.carriere@foss.st.com" <etienne.carriere@foss.st.com>,
 "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH 4/4] clk: scmi: Add workaround for set_rate/enable/disable
Message-ID: <20241008034741.GA14210@bill-the-cat>
References: <20241006093825.2800013-1-alice.guo@oss.nxp.com>
 <20241006093825.2800013-4-alice.guo@oss.nxp.com>
 <20241007170244.GZ4737@bill-the-cat>
 <PAXPR04MB845968B949F7390C01400008887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u6LR0CZhG60Jk2aO"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845968B949F7390C01400008887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--u6LR0CZhG60Jk2aO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 03:02:13AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 4/4] clk: scmi: Add workaround for
> > set_rate/enable/disable
> >=20
> > On Sun, Oct 06, 2024 at 05:38:25PM +0800, alice.guo@oss.nxp.com
> > wrote:
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > Add workaround to set_rate/enable/disable to bus clock that SM will
> > > reply DENIED error.
> > >
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >=20
> > In general, please include a cover letter so it will be clearer what the
> > overall goal is, especially once merged.
> >=20
> > > ---
> > >  drivers/clk/clk_scmi.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c index
> > > a01292c479..a860a653ba 100644
> > > --- a/drivers/clk/clk_scmi.c
> > > +++ b/drivers/clk/clk_scmi.c
> > > @@ -73,7 +73,13 @@ static int scmi_clk_gate(struct clk *clk, int
> > enable)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	return scmi_to_linux_errno(out.status);
> > > +	ret =3D scmi_to_linux_errno(out.status);
> > > +	if (ret =3D=3D -EACCES) {
> > > +		debug("Ignore %s enable failure\n",
> > clk_hw_get_name(clk));
> > > +		ret =3D 0;
> > > +	}
> > > +
> > > +	return ret;
> > >  }
> >=20
> > This seems like a generic change being made globally and not a work-
> > around for a specific problem on (some?) iMX families.
>=20
> We have changed Linux upstream to this behavior, but better
> in firmware/clock.c as linux,
> https://elixir.bootlin.com/linux/v6.11.2/source/drivers/firmware/arm_scmi=
/clock.c#L761

Please mention stuff like that in the commit message, as well as the
cover letter overview of what you're changing / why, thanks.

--=20
Tom

--u6LR0CZhG60Jk2aO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcEq1oACgkQFHw5/5Y0
tyxd3AwAkaZa57ZvRA+GyfYCQAfGr7zfTB8RJpQ+vIduw34F7xpROpgwQv6eUTS3
Str5Zj3w5DdL902EZCdKuywJJ8Txdh9kzqa3WWix0FUOKH0eOfVNyS8O7Jrj2Syj
gOb/71iJ8AztlnHBQr3ofdhwD1TU8K1wjeBnzdr1iGQSLne1UkJhasZnQxnAJqQh
MdxrnWJCi2mir2zn1aQYeAzO2Mz2is4yx2S2393F5lFrY4YxFoSZefgcvBrhLH54
yvXcu50KwqbHIAfZ7A8xHtYmuXqqM3c7NjhVg52GDVmg3sBvX+w3w/j+FgpSU8Mt
0+pkuQ3lNiuTcqJsj1vH7TI14fePkW0J5WneQtym08S+WS+f+wQpMu3UPrFzOQiL
VimhkLvgPRn2+5iqRO5XksSPi7zMwfOnImhJ6l14uH+u/SN11xewTJ06b/BnPGQk
8EZjyFykJCjbspH57K/mMfxkJxyY3Utm3KF9aMK03+KX8JKHtkgF7LC2mk/mceWi
yRhjuK+G
=jCem
-----END PGP SIGNATURE-----

--u6LR0CZhG60Jk2aO--
