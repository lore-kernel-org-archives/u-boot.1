Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896FFC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604E988018;
	Mon,  4 Mar 2024 16:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k6DmspRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BE787FEF; Mon,  4 Mar 2024 16:27:33 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1445588018
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-690105304b4so26657006d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566050; x=1710170850; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ot+kQufeUStF680gxBNGvciReiOtXQFextQaF8EZfRU=;
 b=k6DmspRNcBUrzZ9BUFNxbYVcIBSA9tjXtQsCgEltW2fI3hFUkl2KGd6lhI7kRZ2kMG
 ToVKsEDdNhcVVxTLWPjGNPFTdbyltjFlduQRPWHp6alruo/KwGr6DCMLByfQUaEOhlDu
 vPsKa2uNiVAErH5uQSzfd1o+aAPsKaBbEY93w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566050; x=1710170850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ot+kQufeUStF680gxBNGvciReiOtXQFextQaF8EZfRU=;
 b=CsFSJZ7j0kH2ZL2wciQaqmGADd6V/XA1TSvSNH+jUJuI3ecXdrK2niSJcN7+eoSgDz
 59LjeZjZxZ29ejMvjYj859KwnB6OFqVQSifgGLy+3LQc/t1k5Y0mFkF0IFrSVQNhKv6K
 Hig74H9E+LYjkdJh9WQt870FRtOfk6fObknFRzBPEj35qnFir0Ms5ohpUPDnWEn0t22r
 BfQDEa0M0arCupKrexsqfCXpul0yhtpyxk0ZbHqtDzw/xO9EJCmK1rcc7b6ne7kdPhMq
 nruxgKjMZCcrezUfdrCsYnJMCNJfy1UheOagLhkqPipbglDTAF97O1Pl9Yfm97TrxKGP
 7BlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSRJFX1Y3l9ZsfI6YUAaNqZel+HMBJM+fhQaDVApHx7yWql3W/6TU7avd5Q1piSfki15sTXKjy9BRsaIPLGskHbcxEg==
X-Gm-Message-State: AOJu0Yw13Ij4T1xnBgunABzReMZ3IWdZW/9rigs45utGzjtpCtbNO28V
 JwF5JtEhHYd5bA7hfuIv7y0hbgKvhOhkzyNlCLd6HtwFscaRmd8/q+ziTvW3WYk=
X-Google-Smtp-Source: AGHT+IH9Vj+LZHvyWS1UvZCceQh9UilC+F+78XfGFSlcE1K4uzdVkDe9LK0eQ62pL6QS5NEGwej0Lg==
X-Received: by 2002:a0c:e888:0:b0:690:7084:9ee2 with SMTP id
 b8-20020a0ce888000000b0069070849ee2mr3545501qvo.64.1709566049932; 
 Mon, 04 Mar 2024 07:27:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 ol17-20020a0562143d1100b006904e2c9e36sm4703061qvb.116.2024.03.04.07.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:29 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] bootdev: drop unnecessary assert on bootflow->bdev
Message-ID: <20240304152727.GS1523872@bill-the-cat>
References: <20240212-bootdev-assert-v1-1-0249ca369bad@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+M9Li7l3VWp3wsa5"
Content-Disposition: inline
In-Reply-To: <20240212-bootdev-assert-v1-1-0249ca369bad@linutronix.de>
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


--+M9Li7l3VWp3wsa5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:35:12AM +0100, Thomas Wei=DFschuh wrote:

> Not all flows have a device and the function already contains logic to
> handle this case.
>=20
> Fixes: eccb25cd5922 ("bootstd: Allow the bootdev to be optional in bootfl=
ows")
> Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>

Applied to u-boot/next, thanks!

--=20
Tom

--+M9Li7l3VWp3wsa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6F8ACgkQFHw5/5Y0
tyxEYgv9G8lZjuzCwDeLWVFHAkOuAXwgNQ2ymApMabo6iU6bt4BHl9NhgtO3iJas
b7FZCGOMpf+Ev8UXxjUDDZVEHf1xVwJTWGZzRMRueiZ3RS1VAlbyApxvIrupCjsf
FlQSH/dSV+WdXYiP+pNeHh69sGMj6/NttQfUiCpMIqriObQHTcADa5XWrGiaLy43
PB2ofr8rZk5czue6kmFXLxa5UX2HZM86KZrLbfTjFGvqAgKFy/5diOZxBw6c+W1U
F9YIrem2aeEksCDIDNk1OmQndiXd+Z7bMYYW+B+iLBEYZxVs5VcUpL8+gGPr24FU
ZApGIrx4X+chsEBu4PSnnN7zF2wKAYflk35BENEhagZUdqn8xveD30ybr9mlye0D
RJXGTbu62U3F7uarMmDgLRanvs3j3KIOBSIPR9Vh5imMD8UedYqksdICrjzKZfUz
iEiF+h8YleyLeLPgsmQ7V5JVA29hMX1mr9Vmu4phiiDSHCCcO7RP71TxfZkq+WkJ
PRKxMZpQ
=I9zs
-----END PGP SIGNATURE-----

--+M9Li7l3VWp3wsa5--
