Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F0CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 16:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99BC0808AF;
	Tue,  4 Nov 2025 17:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mqGRVNK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62728144A; Tue,  4 Nov 2025 17:06:37 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C29808003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 17:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c284d4867eso1589135a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 08:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762272394; x=1762877194; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjkOc8pM8RQwkgHnE/Xsue/WUBJa0UstuUcB3fzHt9Q=;
 b=mqGRVNK/7HglQnM1iVYaW1aoCIPrqCPY6Wwdj/MF4cd1L9t0Qq8a9n48lWqXdHxG4t
 5/2iomgLAWQTaRfj2EZxsK6ENef2j/HGQju1YD1deJdKRIviV9pEe4a7davqAp3IgMBl
 EuewEi/E5XIc/7GQeOrbgFXFNm4eYXHJK2hFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272394; x=1762877194;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjkOc8pM8RQwkgHnE/Xsue/WUBJa0UstuUcB3fzHt9Q=;
 b=mBId0j79zOaLKL3mxJc+8bDWLPxinVrDc6DqRMyC1T4/jJonKBSLSyl42wXPtiOFCv
 U169JdMZsv+VWW948N6k1SiJqIlCaJoEaF/S8N9PC8wxXehGa7hvD3YuzGyhFEh5zoDL
 tzJGybUVmTeHW5ToNvgH94Mp9Wk48yo4kSPNnVVb3Pqu1U5gqM7OJ8tVrnB/u0TIospp
 pQp/qRDwjnpledlUse3/KhIW7effG7mPYIqZ8i+asXqO+DKsMeivWvhlv/PnSjEHcFGS
 zrNxUssbTlWXwkDsnOzQOBkpEiktVqmSM828Shcsm+ZrAlPJ2VvK29SpI9Sz6zmp5XIE
 G6eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhZFO16lSobTwtDqOnVkb+e3K7QxVBrt9RE1fP/jwgHaxwWWyp4Z19hV9jcQOD337Js0EznbU=@lists.denx.de
X-Gm-Message-State: AOJu0YzBDws8k0BVv/xv5iPqV4DB2dQN9HyDm5+TVgs8Fwl5Cy2kwT3z
 kmG0TXUQjGGtxzLc7nXNWiSbBVwzACspkX3xO+UdJ9DlqwPZbSCdjNACbcBnrh3bcfA=
X-Gm-Gg: ASbGncs2FGk6To1IJYT+HvWZAxEhZaQOx16Q3KbMWxd/aPCY6BFrsm2GVa/vVG1igVt
 nZ2d/czT6mPiCPI7BmYgdTo61R7Vwk15ZoSGy0c9EWK5xJFfG65GbDue5WY6WIWUpNlMyQs7I7W
 XtReaDuLh0erO8y/D1HUYN/WMzHFqZgPmlYPVOkcv6Ee2P4ZwqJVSJp8BuZpq9IoIrWaOd1CJAd
 riAp3pjoZ96S2YLXTj+CSHjl7p1eXCcZJ98gvK/J5qzRDY0xVyPxNQICOkM9d4k+jcyfryrMsyz
 DzSRe8bz7OAJYCZ/yDsdkDqoNJ7bf3offtlnzY/zSBl5riKP5VS7wSCvUKrUutCeMdrn9ID67GB
 qVBHEynwW9AztKupWpi932e5ZmPqpE8SyJ/N1qxN8818+Kcb84C9qf5fZUa4oNHtwW8P0JnSSSe
 H2gFeOAscz9vnZLWHO5gktY3BdA4r0/oGRhqhFuiY=
X-Google-Smtp-Source: AGHT+IH/T4hoQDhx7ieML2X+cFZPZTBjEcgoUl6tnTciQ48YfaOmQAQF3X63FNPfJtOGGboPtUY62Q==
X-Received: by 2002:a05:6830:63cb:b0:79e:69fa:6bcb with SMTP id
 46e09a7af769-7c6d140f2e0mr80112a34.13.1762272394497; 
 Tue, 04 Nov 2025 08:06:34 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656b6f61a93sm207329eaf.9.2025.11.04.08.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:06:33 -0800 (PST)
Date: Tue, 4 Nov 2025 10:06:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Message-ID: <20251104160631.GY6688@bill-the-cat>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T72iVuyfQt0NfwDI"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--T72iVuyfQt0NfwDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 08:05:53AM +0000, Peng Fan wrote:
> Hi Marek, Tom,
>=20
> > Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance
> > data
>=20
> I just see this patchset was delegated to me in patchwork. But
> there is no scmi repo, could I use the u-boot-fsl-qoriq.git repo
> for managing the scmi patches?

It's a question for you as well. I'm fine with a PR from that
repository, but if you want I can make a u-boot-scmi repository fairly
easily and add you to that.

--=20
Tom

--T72iVuyfQt0NfwDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQokgAAKCRAr4qD1Cr/k
CpLKAP9fgStnT77IRhhPDpy6+vJEjO5UGNY34XVZuyEms3u41AEAip40Zb93pjXU
6K/V1rwXHSrEqsiNonGYGUg5vOpJ1gc=
=LbCM
-----END PGP SIGNATURE-----

--T72iVuyfQt0NfwDI--
