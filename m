Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AF7C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 638F487B8A;
	Wed, 17 Jan 2024 15:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MKOj82Xh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6749187B66; Wed, 17 Jan 2024 15:26:35 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E2687B7D
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ff5c00e3b4so14577117b3.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501592; x=1706106392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fF0IAw4h5HXV5OQjroICIZaGUN1jDoeYyiqgEWfQFxE=;
 b=MKOj82Xhukd7+MjsouZcGu1BP9MEOaVOAe660KKmJG3r6LmXVeXtQ14P0SI/eCNxcX
 ATZkFhUySPZg06MWdI6CLU/hhYxOHg4Yujt5CnZgFjn/f09YOpk56qh53VvzPrwdLCDo
 HU2m+wRtzQ67LqV04Au3piOQIPsAJDl67HSjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501592; x=1706106392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fF0IAw4h5HXV5OQjroICIZaGUN1jDoeYyiqgEWfQFxE=;
 b=kUYsecVr9XfNNe7OQBq1QXuv6T3a2sUBCUC+NE1OWgENBQFMgWlE21F9zxQrkjhymD
 bSTgdhM+QoQcB0Nv/ewZ0eKdtun8iokSqlGb22HDUOTBFok8CCxzlBh2zfn2R6jnxEFj
 Hz3F/lwWshEqYPboZXRHB37qha7q6KcbSuACZYNNiBCccjci9XuRV9whrL/oX8HR120t
 2astiRRrN1pXfvreNjb2MUlFbiblQNBOABLI51XqxkL8q2tkxpcruCj4f4mnv+W+wJwh
 laq1PjyYYX2+jtzzqxr2679wwPryF0WWvUm9XYfhNIRHCE2ve5vubVGMq8VnlSaj6BNN
 EomA==
X-Gm-Message-State: AOJu0YxekcMlAXbi7e4jOxadzdlp1TIQi0XhL3iQGnAZG06hqyy/AiDW
 6MlrQBAj8CorT/OyEwQ5sqZD6hCL1yDbGGExlzbcSi+FSjk=
X-Google-Smtp-Source: AGHT+IHROkghWZRGi0n9GhjKn3vhCsc2XebMkmElh/TdiljwpVkQyx4TG750r+ATGRZirR3/8tBtGw==
X-Received: by 2002:a81:d208:0:b0:5ed:a4e8:510 with SMTP id
 x8-20020a81d208000000b005eda4e80510mr6236457ywi.14.1705501591816; 
 Wed, 17 Jan 2024 06:26:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 p189-20020a815bc6000000b005ff6c19a15csm423432ywb.98.2024.01.17.06.26.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:31 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:29 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] test.py: Update pycryptodomex to address CVE-2023-52323
Message-ID: <20240117142629.GM12635@bill-the-cat>
References: <20240105194343.1832287-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fNhHj3OiYT8/SIQ8"
Content-Disposition: inline
In-Reply-To: <20240105194343.1832287-1-trini@konsulko.com>
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


--fNhHj3OiYT8/SIQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 02:43:43PM -0500, Tom Rini wrote:

> The version of pycryptodomex that we use is vulnerable to this CVE.
> While not likely an issue for us, let us upgrade to be on the safe side.
>=20
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--fNhHj3OiYT8/SIQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn45UACgkQFHw5/5Y0
tyx/8Qv/WgRL6mhsCETRVPOt+vIFswMRiFpb+1YgFrinGNPwGWkVoMhvpNR3Iy6n
ACBqnIO2CxVvsF+tHI+VKMqCgantSgpg417T5aRKSlvz2U9FClhAGmycZWijX8I+
bMOH0iDTUavwsv7D6rygYjXYdZDNlxi2eva16SUx8PQeEzXmaIPexgCa/didmxZs
OEsBWgXtzorhcffNRRoK5cm0yEFnUEFjjYAqzpKS7oCpP+i+DCQcl1EAMqdAnVHK
aZoGLtgQFeKj9eqQKH8SEXrXNfVMT6wn6x6x4ge2OxMnjfzq613hOoh97OhbLfLd
pw0sTqM2y1J5JJej9YWwIQOzAMSzk6ATxEY5LAIzio7/fqzk82/j8pBbHlsjfcXA
zKT77PmtDUsLVsrX7+TVv9DR/zgXMSOSwWfeBUbICOEKAEEI4KZbqtnHaDcvhoj9
5Z1fqmXdEUlbqhFxfcqS4fzC0Z7bNgBP1T34CRanv9b8BfZ3zHuFHX+3agkJP9rr
kxgwzcog
=MOjY
-----END PGP SIGNATURE-----

--fNhHj3OiYT8/SIQ8--
