Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C83C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 00:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2757A87668;
	Sat, 28 Oct 2023 02:51:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c9D432fQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5400487668; Sat, 28 Oct 2023 02:50:59 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518988763A
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778711ee748so205280685a.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 17:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698454256; x=1699059056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oQe/t1SgrcRQZbrpZNA5i7SUxWpK92HqUO8aVnqevBI=;
 b=c9D432fQuEltKpGAKCFINertSNRa0EWjP9TZ2cK5nYesf+P31aDyugLzZasWWtzW+a
 kNZjckMBFuF7+S8vi+LpywXPbreLvOn9RQQCYKpjjVbXEsllREFKhJyE9QpuhErYOP0a
 pzeNxzyY6x8UIVAFMCmAEUoWwWzDDFc9jCRis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698454256; x=1699059056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQe/t1SgrcRQZbrpZNA5i7SUxWpK92HqUO8aVnqevBI=;
 b=BkuL5MxRMlY6Ljpe4SnuiJvMVVi12dDmPPvM8UrQoSbwHm90VWKs7Sgd3+ZtZqQonW
 p55IBSyG5pqfalMArfyLuIFDe+7ZaE3UYbVzLEI8TXBd881rzCoxLyLRg7OIUFP8+hoD
 KRjxT8jBsZyzE/QmKmGUun12tuvS5imIGZK7aOTa4DL8zOMbrCLf2VrIceveFW3XDz2Q
 9Dn/8RuCevf1oVo/TEXxM4kw8nSoqU8+D8j+GcAdQcyPTMf6ZgdO5hc+mkdPjobgDV2K
 61xl2Bx7se1bmlii95nrmcdZzFwBJtoJaGGgs9AdbJRh/KGUd5CHE1bTFPE44KATT1fh
 SuJg==
X-Gm-Message-State: AOJu0YysHIj6ZAJFwughG3r/Rj5BbWMk9Eby9zwMSE29+FjxsK0G3bWB
 0aSuivJhabalZCQ7lIeNoY8RdNYSn2arBWxfCSFPvQ==
X-Google-Smtp-Source: AGHT+IGCFKYqPWMwFEdUvc7bOnVfm9VIWIreKs6NMiRqwfdjslSc5X/4We/4ZrhaS4DQo049mInGSA==
X-Received: by 2002:a05:620a:9007:b0:774:1ac2:79be with SMTP id
 rk7-20020a05620a900700b007741ac279bemr3569036qkn.53.1698454255950; 
 Fri, 27 Oct 2023 17:50:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 pj36-20020a05620a1da400b00772662b7804sm1047814qkn.100.2023.10.27.17.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 17:50:55 -0700 (PDT)
Date: Fri, 27 Oct 2023 20:50:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20231028005053.GD496310@bill-the-cat>
References: <2b17b19e-b6e4-4a38-b569-36a72b05ad59@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AQCASR7GlVGhRD53"
Content-Disposition: inline
In-Reply-To: <2b17b19e-b6e4-4a38-b569-36a72b05ad59@denx.de>
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


--AQCASR7GlVGhRD53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 08:51:26AM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--AQCASR7GlVGhRD53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU8WuoACgkQFHw5/5Y0
tyxmmwwAs46IP/zl5bAXPlRDQD3xdtBHTyG4p2PqKd+ine+JtisXDyljMQoz5xmI
oXV0qR2TvSCSR/0Y/Hg4jCt00kJ9Vy+L+x37YS6ikL3mC63bhVbPP+IqzUt7EtM8
fxZaoeYZ/aYaAktUxtxdj/o3bA1lXT/ugk3T2A8olkr2HkEf7UC/txVqdIkTIUDM
sNySMuALOYQk1gEK5IHqlCpymMNrWNubj48+aLnGpjWhgH8CuXzz72ZZ7+1ANpBY
Sz0lCfh9JEnZDpAR8b9995aM9rI0IZa/AAjzezosEUYgd61cdrL/txAePNgTN50Z
rnHZ4IfA3tO4n8nGT4Sf5fJEoJFhaTVhfdi+FCJvt4cBm1G92JkinZt5q9UfE7TL
rubojHns7XNQfZmIaPgQUbaA1HyJ7/rvJIutk5MjlPEeqcb7Q+uRPu9KT3oZ1inu
HOHoCZySBnHy/5g+u//6LNhELChuQgfmf92xd2es2dktrXK85VywHJolrDDGlER3
u7I0JKfa
=Nczf
-----END PGP SIGNATURE-----

--AQCASR7GlVGhRD53--
