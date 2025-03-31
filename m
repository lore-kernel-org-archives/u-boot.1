Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF8EC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 18:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA1281DE3;
	Mon, 31 Mar 2025 20:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kEUAg6yC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2FB81E5B; Mon, 31 Mar 2025 20:31:25 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF2D8129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 20:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so2783600b6e.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743445882; x=1744050682; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mhSni07Vt5Y3jnFXxf13JT5ce9BejCKgjQdVjrZKFvQ=;
 b=kEUAg6yCsPsnQZFGT3vYPG9wsqwaGt+SYe7niz5CRMl7jqj2KHOaYKHEy+4gBjw2tl
 N7U9+mua1WM9R0p1BifTykm1sWK44GhuJBLWcqP+NmrmjFdLRrTYnQhun388cWScuTtm
 3Dcw6qlRF1YShQbQSHx/ToBLSBkWqSxoQLcF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743445882; x=1744050682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhSni07Vt5Y3jnFXxf13JT5ce9BejCKgjQdVjrZKFvQ=;
 b=KzC5RL+hsmkHyeKmze/QRLzTz195BIw22oWdzByQskryKnsX14XSle/jT3505OePGS
 dJDPbYAm5xhjFJZg91GoH7M/6mm2BO9EQ7V0rAjtCNwuabNEsrfIbZlnlF2ilmKnO+wp
 lWpxpotVtUumZJ2QVW714QB+bCd6DC/2BI/An1OisydECpxQsUblriEBLBL9hITGGHIc
 PZ5F/jIE/E4iKxzARDxWEAUQ/XQ4zW6n+Qvt9FOPYVGAwSp+iRVmFzlRNByxykOmhCsv
 q7a2P2MfrCfvlQxDWfwZh7abGb4XrQU9ofzUtxzO/jGwqeoiU59fvgboFFEbeFkJ/lb/
 rtTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTMgT9DW/0vvn34dYqKQbZJ2Z+QzJQigLib7xcNjXxrVieOwnLsk/IVH29QAubTWaZkbUI8VI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2EfekkoOwIUVQUsvouhwT1Pa0Au8vjFxu1YdX/1+GTnSE/WsB
 Q7Ayi0zT5wrACWzfSFQlAvAx6pnxZDeKYHZoAyLx8fDmBx7+PC3o1rFFMCtLD0w=
X-Gm-Gg: ASbGncsnexet+QXLKi6Wr31UM0IABYw7PenhWzUebt33rwvuWptIDR57eNpApkX4N3O
 I/z5JiznfjuHE6y+d3Df3aPvLx5TJW1UsjUZXrHtGe/v1fGH7/v7IIaDY3hf8vlxhiTy9yhMAXb
 qVDlBXagYtjcIqojly4ZS72E9xteY0kpVZ6nTOXaGhshBMG70cm1R12XRAGt7pKBge2W6Wyme/n
 S1eTgD1XgD/iZZZNGU09/rl64OiLSHzDrV/tr3WMuLpK5/shKU29zzmqL299Uob8mhU9kA5Caoz
 V06WmS7df5LwfWl/wR/qNvGiU43EvEY9UyZWe0MthAekNw7My2VrCiBkSRadGhffvoxii8sjkD/
 zqBP+aYS4QBs/OcZm
X-Google-Smtp-Source: AGHT+IHEjT764m4R0HyGYbO2VsMKQsA+t2RkToMUeTz6r1GNNuuqsc156KXfaGq38fGmMDrzIQTEiA==
X-Received: by 2002:a05:6808:199f:b0:3fb:46cc:e07 with SMTP id
 5614622812f47-3ff0f4e2361mr5308894b6e.6.1743445882188; 
 Mon, 31 Mar 2025 11:31:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05278deesm1638007b6e.39.2025.03.31.11.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:31:21 -0700 (PDT)
Date: Mon, 31 Mar 2025 12:31:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Leonard Anderweit <L.Anderweit@phytec.de>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "brian.ruley@gehealthcare.com" <brian.ruley@gehealthcare.com>,
 "marex@denx.de" <marex@denx.de>, "ravi@prevas.dk" <ravi@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
Message-ID: <20250331183118.GL93000@bill-the-cat>
References: <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
 <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
 <CAOMZO5BtELcioQPygHGx6rsRmFvxeStn-PFf3B22BeXkgUbepw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aaY7H3dWAsf7/16l"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BtELcioQPygHGx6rsRmFvxeStn-PFf3B22BeXkgUbepw@mail.gmail.com>
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


--aaY7H3dWAsf7/16l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 03:18:12PM -0300, Fabio Estevam wrote:
> Hi Leonard,
>=20
> On Mon, Mar 31, 2025 at 11:43=E2=80=AFAM Leonard Anderweit
> <L.Anderweit@phytec.de> wrote:
>=20
> > The error looks like binman is never building the missing tools.
> > Run something like:
> > ./tools/binman/binman tool -f missing
> > before the binman tests.
> >
> > This test setup uses .gitlab-ci.yml, right?
>=20
> Yes, I think so.
>=20
> Care to submit a patch that fixes this CI problem?

And make similar changes to .azure-pipelines.yml as well please.

--=20
Tom

--aaY7H3dWAsf7/16l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq32oACgkQFHw5/5Y0
tyyhUgv/XQZLteM2UxmMFdJ1CTJ3nQpORqtr/YRXnHdNpg6n0EhAtk4IWVSRsfDn
hu9HubNyQ87vE8f85RzuUMh3A2obwEhHrzpj3qUokGnm61rSENc31lDipCe8zfDO
4X0x2f148hxMTruVo1Ba/dvyn+uIrwjUR+G7qxsJXGe+UkfhlmH0G7N8YFC6vF9B
UMneR9FL9pKMZmv4PSnUf8YMZmhIBDH2ZMs98uJr8nqSkwtSedhqPIsU5rN/oe+j
b+uHAIFQ14ZbcPL7/yG7lpq6ieekZ/L1sLQYcHndTh1GR2hgs/w4QU62octce3Kt
hTIdDwD4Q2DRF1KBMjCj49Pc4c6/J6DTo/ZRKxKrKNdEXYE3XCRLvz1SiP2erIsB
JP3Xza3spt0Ynh4V1qQxbGRX5+r+TQgDRoOU5kDwM90r6iq0idDU7AA35WxsKlDo
1rWq8nm5QPcULV71fMjgb/jCAWEyQP+r0s+4etsGrKKT4JX4/EOvqX2CMWDU7SoZ
FvmC+HjQ
=xiaF
-----END PGP SIGNATURE-----

--aaY7H3dWAsf7/16l--
