Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D696EE7AD71
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 15:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0684986E54;
	Tue,  3 Oct 2023 17:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hA11WOT0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84C786E60; Tue,  3 Oct 2023 17:10:39 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC81786E31
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 17:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57bab8676f9so595114eaf.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696345836; x=1696950636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YaRMC4EMqVcBtLlEG2eRqEsykPCAmn8CQBEGpYnSSzA=;
 b=hA11WOT0wUYspr/ah8a4Zreuldqw7t8c5iHxrfOuQKAf8K7vSR6VvFiU6gKFv8XhDD
 2+BecoyMN1Y65EFnIo39UegpN7GwcqL2YdzHNUQk1eJd+V/MY1qRyYVFRomCXJ7He63s
 bZ9HEaSP6Bk9sN6lxyDo8bcmLkkVuC+7Y2YPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696345836; x=1696950636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaRMC4EMqVcBtLlEG2eRqEsykPCAmn8CQBEGpYnSSzA=;
 b=GDD5rcgM/hjhikdWi8lq2w21gJI5vvVQuXAXOOLMx1utNl1seaRF+Ov6aq0db21get
 8VKDObRgDDld/WVAYAQMtTcOAQJ062rISN/u5IFiZxhcbEQ1w4DMjFYKAR+eW/lUJyJT
 SFau1c9JbNulQMLVqeqaexRBlDYb7lgAogZuBIMYbGp5TF2El3MFDMjOQcKhyURN2ADQ
 GwdAowEmps9FQmExQ/abEy0jv30jjCnl0M6F+AnQgibAHKWv/LX0YOzzewmMjNG0NjGF
 HwriNdmvGNtfgWKdlaDHjLdDVS9PQyHBdhJiqhzu1WHyWJzvLEFNALcO11UB6Fgwa/a9
 Ueag==
X-Gm-Message-State: AOJu0Yzrc73qi/yudSHUE7OjpyQZMIT9IiMxNptxEBqiJ0w0dvUEhovr
 WSOlw55enU58S8lQNxdkRELz3w==
X-Google-Smtp-Source: AGHT+IH1LFH2Ih36UFmJ4PNFuBLyIQOCHTj6qdsaFjZ7+R0LlE79HoDtixFlg4xEO2e8i0en+a2hkQ==
X-Received: by 2002:a05:6358:9486:b0:13c:fd78:bb43 with SMTP id
 i6-20020a056358948600b0013cfd78bb43mr15081511rwb.27.1696345836174; 
 Tue, 03 Oct 2023 08:10:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1bd6-f13c-2029-607c.res6.spectrum.com.
 [2603:6081:7b00:6400:1bd6:f13c:2029:607c])
 by smtp.gmail.com with ESMTPSA id
 i71-20020a81914a000000b005a1cc37aff1sm436724ywg.20.2023.10.03.08.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 08:10:35 -0700 (PDT)
Date: Tue, 3 Oct 2023 11:10:33 -0400
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, u-boot@lists.denx.de, n-francis@ti.com,
 vigneshr@ti.com
Subject: Re: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization
 for J7200
Message-ID: <20231003151033.GD8465@bill-the-cat>
References: <20231003081038.24299-1-j-keerthy@ti.com>
 <20231003081038.24299-11-j-keerthy@ti.com>
 <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SMWQf22jmJdRpKBv"
Content-Disposition: inline
In-Reply-To: <838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com>
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


--SMWQf22jmJdRpKBv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 07:57:04PM +0530, Kumar, Udit wrote:
>=20
> On 10/3/2023 1:40 PM, Keerthy wrote:
> > Enable ESM initialization for J7200
> >=20
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > ---
> >   board/ti/j721e/evm.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> > index 42fa94b7a5..070b28326f 100644
> > --- a/board/ti/j721e/evm.c
> > +++ b/board/ti/j721e/evm.c
> > @@ -543,7 +543,8 @@ void spl_board_init(void)
> >   	}
> >   #ifdef CONFIG_ESM_K3
> > -	if (board_ti_k3_is("J721EX-PM2-SOM")) {
> > +	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
> > +	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
>=20
>=20
> Could we align on one kind of check,=A0 For J721E check is done against
> board-id, whereas for J7200 checking

We should look at figuring out how to split this file in two.  One for
"generic J721E systems" and one for "TI EVMs", as I've mentioned in
other threads, so that it's easier for custom platforms to drop code
they don' require.

--=20
Tom

--SMWQf22jmJdRpKBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUcLuMACgkQFHw5/5Y0
tyzyYAwAhcWY3avH/D16B1VllfLpBNC0pJBkmVgnjAWN9/wWmzYgqxT3TeyrBpTs
0QKNYtJGiHjnuAc9AOLae9dy0CzomGzFuE/Lv+Yv8JWpp62odbEgGa9GLlg4AIFP
A93Hytg9C7XSSEpAFfmees8lWEGEiSONswTXoOxPSodG/u6q26tPWut70xi85wJS
naTylqFKrNTT1weAM2Q/72mmOQmTU2Cu6c4cAuGLvrcfoIffwJFsmSQizVgGYmuT
x6C3PsdydFC8b576T75AwEpG/zKY33R8MIn578cRqRVYBZdlXFbCsoONC02/reqM
yumyTKJuvlWGUi+eb8hJjIHIba+FLTTVKi5rqGp+qLhu1cDqzX9mWYr5qmexyI5d
HMjUCbqUIp5A6QfMLmqgESvbWGBg5ldB+RAM7MAVLV+a9bYWYppa88T2QaVoL39b
NpdzeJW+mOnUGXOEKGM2XyQYH1YISkZM3tNqKTQMICANYWnYSHRDecaQ+84yNLa9
PX/+Ld0q
=WzRo
-----END PGP SIGNATURE-----

--SMWQf22jmJdRpKBv--
