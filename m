Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC901606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hnUcxkLk;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k6pSJuM2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3140407C3;
	Mon, 16 Nov 2026 18:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMHSnmJcNjrj; Mon, 16 Nov 2026 18:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA320406E7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854290;
	b=L1Hk6zQvzscrmItHpcrsmS4hX2ZKpq22wIRjbF0TtNi3WE7nGMt9fOu30OKyrmfd9sfn
	 ajpz55dlkpRHSxVEPNlOoB2GCI2ZkDG66MJnAg7v6LEDEzQmZ2lcvW5DJqOxv0xM24Sxk
	 rTOTPt1TyqAmdK/f6f/egS/FJAhXgPpWJ3hHgkhGGtB5ePAD8GePio+l270KilgQxTFSw
	 bZQr90Hx89/bsbw8xny10Q+AW2xN9in+P2ci8be3wanpyg4W7zzG1eYCMYrSP4Dq6Toig
	 bmAyjW/lY0F65gXnOX7jTTNn02YTpIJhrA24HbW3ivyn02Sqx6TY9xlvXkHYXk1kNpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9nvygVrEckF1AQhCIApXxNrpOZhPXZwFavluERKaXJI=;
	b=lRjDMIO3XpY7pL7XcemsxLuIT2gVhfO+YVWtXHDmjt6fb98DGBFD+Zmealne7496ae2t
	 wkO/ilzmfjvpjBn+NfgikhvCuyu0O8+MwGBV0Xgs0Cz6UEBc9i8znZT7953+g5pAnoeJ0
	 qJyI9v1RBDtLEW49XVc96dzrfzn75bHcIGZQgj+9VNPXDI3S3WTGTWWR5W1UmPyEFAGNF
	 Q/Hd9xwxzyEvPVuWW0NRG3UuiMk3h6i7TwzdDqYK5nUxGBmeieQP5L5DSks+CiL9jytcS
	 n7D1uBEqm/IcPIZBS8omeMuHH5T2K9O+ZT02p/ic1vIXjE+xIN9Eg4icb3WRHFDMRkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k6pSJuM2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854290;
	bh=9nvygVrEckF1AQhCIApXxNrpOZhPXZwFavluERKaXJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hnUcxkLk4hlSJfa2agCkTne8sjGVt47PuLJ3eKMqy+EdyqaAL2Mqu5qrT7Tr8SCQZ
	 UnWSS2gc4MINqymN/sA4Z2uP4qk2JTT58I6tuKdggryRtREmWVzzazmXmQhYOSnq17
	 j/x90Uc1akx58dF6VQwhXgrwO2KokdL3RBn7fzCERZUDcEDL+7Pc4XVha1ALabdDw6
	 ry1fraymIJfPiOJWwsRupqNX3a9KpCT6BFOuyG+M+wrIktBM31nhxb8PWiCuznssa2
	 2yWlYE4VYZAB3lTDJGQHxjFHqnkCSpOdH/h+8CBXXZTZfH4+Z624e8DdkOnqlRpm0X
	 2mrYVj1hyLDaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA320406E7;
	Mon, 16 Nov 2026 18:38:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F09F70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60A2B406E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:38:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kdss7hW3ae2H for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:38:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B514C406B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=k6pSJuM2
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B514C406B9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:38:08 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-71ac798b8bbso1820445eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794854287; x=1795459087;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9nvygVrEckF1AQhCIApXxNrpOZhPXZwFavluERKaXJI=;
 b=k6pSJuM2DWoZ/fGr+3SV2PIl0HeWJGYLk422i+FXexyn3Q21+r/AOVX0x1B9Vs6W/z
 6h8IUy6myJkemeLz6GZrl5eE4tciNUIpmIkXZ9QIhodFhuh1D4nCHJs7Df+HQwiHRZS/
 PDet3xYLgFQUi+MGSxprmfUQV4wiPspeuil2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854287; x=1795459087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9nvygVrEckF1AQhCIApXxNrpOZhPXZwFavluERKaXJI=;
 b=MgaFcPLGYsABDAu86JIsaFsvJeN+VHYprTEXP2+0FmeDlhNok8sD0jwjF6Ybn7nJhN
 eRmN3LC1DTGGG/NQPzJLUW3QfG3g9oUHdbAXq+TGlP8PPV4E6UKMtdxM5qEDTzzka4Vt
 yQVVbI+P4k15FFspew2dRoV06bJrzR43gJwwxNz0DHXzP/5nmWCK5U0zV4ImvTNyHDLH
 2McyvRp4s3VD7TlSg0JGoDGnfeTtAzQ3BIAtPn1OJvFN9vqed+z3R4L1g/uyY6muSwGj
 p0jaLazVfWXxrAEOetX9fvNdHl2anLHRjwNyGLBTwX/cXPID+GDjpW31cIN8hqCOHdjk
 hN3Q==
X-Gm-Message-State: APuU4Z9LvG6Nh6RVgMy0sfUoFMewppPTmYgsRkwGqOvIy8QRX0vCM2me
 4lWk6E/SHJQGAtbSmuYDQJbobKdzuikJ3lHgr0wJG73VrGA3P6zPXU40IZMrYF+nMVfNMR4Jo0I
 /GwhdIugfNg==
X-Gm-Gg: AYBFou0R13E4Nb5gkFazO9YTAgbILLup6L0OnF7amjKGzCT7Hb/FqGZzNV7rMBmn1bt
 vRdwtOTwYafRXjUy+8jH8VoudJ+sx7L7qDdG8OCVg7fsMKlzcbmGXRyJiNnadtwnlDrWrcLvV4M
 9mdrr0GPuIH0LEDK4ZcIt6ngPfekeo7Cfpiz6Mf5LQIRi0N/VF84lBbEvkLn+yFdlHvhX+5wlGj
 528ikQukN3dccRkU/PFnoju1/FtfknwfUpHSGA3rhv25zfsMAnOFL2UsUoBnFxiXoNYmKLp//Ui
 rcawDJEVRFEs0LVBbbxqy4h4jyR3VOqzK7UZYTKLpMaLHbUAqIH1JTUjV9S9CZBGUto9Ca2CFUX
 Dc7vyeOJGOagDK7b2+ZUUouH7C46SjnAGbC26TYjJsmUpuryIzIArIPe+b+Zg4h6peEwy7c8MsN
 oFDw8LoLH/0Uy1i//Q7prLmfDIIvwFZp8ACiZAclm/wJE0INvcEwgr03H2gSUVcdghlo2DF7L/6
 8Q2QSKBT7b1abtMS89M64lSew2UV+QJwLhORTYDawc2sNcCSDFNgbl4mpedeNBLddYRHf74wpu5
 lhcBKJE795kYnv7Baa2/5ov8kdlfFoUOgnYMuyJRwX+e9It6jlVgvtOAlaabAWgfLQ+NFFcJPvN
 xIvOxLIHUgLK6bnKY+JkwlCoGT8/dgsPGeLNSjRqXMq2UZGhM6oOqUQ8Vkrgis/PP7R6w76qtQZ
 EnHxJO1BXOF/qR9cRah2ASniLEr7mR5RE=
X-Received: by 2002:a05:6820:60e:b0:71a:ee31:7b87 with SMTP id
 006d021491bc7-71aee318071mr3168560eaf.32.1794854287272; 
 Mon, 16 Nov 2026 10:38:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628812e44esm11620988a34.15.2026.11.16.10.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:38:06 -0800 (PST)
Date: Mon, 16 Nov 2026 12:38:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Denis Mukhin <dmukhin@ford.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Alexey Charkov <alchark@flipper.net>,
 Carlo Caione <ccaione@baylibre.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Fiona Klute <fiona.klute@gmx.de>
Subject: Re: [PATCH v5 7/8] configs: Enable partition type GUID for
 QCS9100/QCM6490 boards
Message-ID: <20261116183804.GF554944@bill-the-cat>
References: <20261115-type-v5-0-79e76209457b@oss.qualcomm.com>
 <20261115-type-v5-7-79e76209457b@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+xLF/etSUL0KiEKn"
Content-Disposition: inline
In-Reply-To: <20261115-type-v5-7-79e76209457b@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--+xLF/etSUL0KiEKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 11:56:09AM +0530, Balaji Selvanathan wrote:

> Locate the SCSI environment partition on QCS9100 and QCM6490 by its
> GPT type GUID instead of a per-device unique UUID. The type GUID is
> that of the logfs partition.
>=20
> QCM6490 did not store its environment before, so also enable
> ENV_IS_IN_SCSI there.
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

We should be putting these defaults in to the Kconfig file instead.

--=20
Tom

--+xLF/etSUL0KiEKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavtNjAAKCRAr4qD1Cr/k
CjgsAPwObwanyO0ADNm6s7XHGpUECv1htZzaK5eyevT4q5N5NAD/Q3txzv3YkaEA
zYurgmaXMen3bFgSVocfoDiqj+5aHwg=
=4vok
-----END PGP SIGNATURE-----

--+xLF/etSUL0KiEKn--
