Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE05D1D898
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 18:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C35E889E9;
	Tue, 15 Oct 2024 20:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FZmNPdFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE86889FC; Tue, 15 Oct 2024 20:31:48 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1D58897F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 20:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2884e6ed0daso2143358fac.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729017105; x=1729621905; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCuiLNHGl44f/z3P6VVSmjvJxoS2n3q771c39SMmJ+I=;
 b=FZmNPdFaxzJ2rzL78QXqM/03RHYWB2u+M89LzYYA5VUg6Z0aXAKShS5uFKEzm429Ln
 wE6C5hwMGr//94+SRXjq5GRUyr8OJFOLiBDxpzBfVXdF6ghYzpeZFMCCjIMpX9hwLGyf
 icg63tUaOZQMDEw6h01gmDyWIViei+sYz0WEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729017105; x=1729621905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCuiLNHGl44f/z3P6VVSmjvJxoS2n3q771c39SMmJ+I=;
 b=jeKIMx/TimZsiqqwVE7s5RLJE5JnuW6oSvNSQUQk55TRqiT2DwPZVGb/2in0/eIZ4s
 9IuFmjRyg5Lw0tYpXL3aC5kMM1J8sR2qaS6NIlM5nd+GB/4dxP8J9qOPoSQAoReoWE7x
 rU1mIYjzSUWRV42ceV4cwZ+Xd/pjCyNR+HqK5uzAiQl8t6dIMt6rrH0cnxd/waJxdJwm
 vmBOT2vhIqnTtXtYKGZ/0ra7ADdVeBUXPHH6hVAJwxpsY872QBi+0i72pO6CKHLRaIF5
 /nejvAUVBeRw6Tj9gHBhO9PTo6hcI5VtunEk+mbDS2+UVn8ynJnPy2fIriaws4S71E3Q
 h1yg==
X-Gm-Message-State: AOJu0Yx1i4MuNLMyhkzbKSwcysMcOlxseCzugJm1mJK5a7sBQIZKevyd
 MV/7BPx0xUqc37d4SRgJqXcv5tg+xYTxhWHJxiTRCkrjPLGi8R4EVANKSg9BUCY=
X-Google-Smtp-Source: AGHT+IE7wcDXlc67nxLa//4Y52w+qh4WZAtpF93kyw7aug3y/ONo3v4esYyIovTpBWTB70kU1382MQ==
X-Received: by 2002:a05:6870:d38c:b0:260:f50e:923f with SMTP id
 586e51a60fabf-288ee01e681mr1405544fac.42.1729017105674; 
 Tue, 15 Oct 2024 11:31:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1361726cfsm99609385a.47.2024.10.15.11.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 11:31:44 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:31:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: risc-v - efi_free_pool: illegal free
Message-ID: <20241015183142.GQ53053@bill-the-cat>
References: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h5AKNueKW9y2/UX/"
Content-Disposition: inline
In-Reply-To: <CANAwSgRJO1=w40ybTHkq-BD78rPyf13JdWp_yL1qpu=xmO2V8Q@mail.gmail.com>
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


--h5AKNueKW9y2/UX/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 12:00:01AM +0530, Anand Moon wrote:

> Hi All,
>=20
> I am trying to create a RISC-V Archlinux image for the StarFive
> VisionFive 2 v1.3B SBC.
> Everything worked well initially, and I successfully until I upgraded
> OpenSBI and U-Boot
> to the latest versions.

Sorry for the problems, this is known and will be fixed shortly.

--=20
Tom

--h5AKNueKW9y2/UX/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOtQMACgkQFHw5/5Y0
tyzJEwwAlfALhcO07dzBCRhTkjrvUfoMHtsp7+cCAnro4ncd44VnFLnN9ZeQMKRx
LtRtKmvpBxaTqhsFu26Py3xWhnLc2r9EXiOBtiXOOjUwgCorWgiJ7+ywy++K998f
SVcKeEkxayO9Puj0XywLqiTm5L4EOCMp+PF/J0hmVI2LYVD1tfxtUTICkT6ZLWuH
F/XYqg1YyRV31eVPwNGTImHETmSC/h5+T5OBpuDLavnlUyXO14XDgd2GRVxFgX9a
fbKP0znglcM17kVJzTQxP6dN1yA1jSnYCahmlEvL5Ko3XPtUmbZPqw52KIy6FAzS
CwVHQBD9C5uTgZ1Wr118xm1EKsjnSpZ+eBO8XDSeZoJ/b4zakOfg/w1hells2q66
/OBBd/PGzNLBpCsvjfqbH9Z+RAw5rwxc41qVoY/du9MgZqc0LjZE0YirPdZZeVZN
b+Ek8uiszViNRiL7H5PZR8zMWV7JLj8hc3VVa+Od9RPVVxCYMd8O2NQy6VbCLql/
f8P1EPJI
=4Fsb
-----END PGP SIGNATURE-----

--h5AKNueKW9y2/UX/--
