Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3058BD2C55E
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 14:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F95788599;
	Tue, 22 Oct 2024 16:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iof5jPE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A77088F8E; Tue, 22 Oct 2024 16:20:01 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5CA88599
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 16:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b15eadee87so262042585a.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729606798; x=1730211598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QrGnuDqbCTsJJZhykIiWGxxLWS9cjlQMSEuCUdKzw0s=;
 b=iof5jPE6Kv1or9YfyBDo03AcnDcyNzH8sjcHuvw04wCQZRbW9EMSzLiv0jLN/iltRy
 Dnd6RjyBreRHfHkovavoy2d4a0nn1yHdSKAq/8tGNn258Hu1OBk2JBHAGNdUslFZjE80
 ZtoQzOKy2XzuH3UmhckMmcBUM1PItJgbNgG/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729606798; x=1730211598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrGnuDqbCTsJJZhykIiWGxxLWS9cjlQMSEuCUdKzw0s=;
 b=ke+t7yrsTdngj7XhiijIIUUbiC2KDcrK2NI//+y5YCMoCjNyS3S1Td9p420NNMMkPb
 N/LSgYS4U5UB3dtm0xgAqphrBL8Io66fuY9NA8BkBR15R9OXwKpAJF3E3+oUcpyrV10C
 QP74TSl+nEGoeDW2aOpMQJN79ifRT5aZxVkgofk5Xe/AfCeBLS5jWLASi2y3lhK+ls8o
 p7Yzb1dDwb3ksZGKnErrJ8OnNXIkBLTWbMrZN/8Vx66Tbqkqez2z1qKISij6Ytt31Osc
 Dz/eAPXZW80WGglHZB4n/TUbRJGTfq7E2ez3EI/EHwDfdG60VURPpJAj2IHl/bLaNTij
 LK9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9GUUOwossCDd0ZHVdw1F7dbbmzeiCV0AG2iBflPrtY5G4jKUDtrSaC5ot9XVGbfshNa4FHVs=@lists.denx.de
X-Gm-Message-State: AOJu0YxKzjWL2iEnAcZ3t5AXm/APuBdEJLpL+k4/zRFPupL34TkfNWLp
 nRbq3Ba+sfbUB2Wa+tWqrgSG/FDaR8ZtcT6PqiyThnhTLEvK7Uh7Ht/bxU6JjcU=
X-Google-Smtp-Source: AGHT+IEtiKWde2XLWmHy1Y/6OdUPx6sgw/BU6fCv1BcQ5KREKw8yKHjAuLUTJKPxjjDao725uo2e3w==
X-Received: by 2002:a05:6214:16f:b0:6ce:23fb:ee5b with SMTP id
 6a1803df08f44-6ce23fbef31mr32265896d6.30.1729606797741; 
 Tue, 22 Oct 2024 07:19:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009dd217sm29284626d6.110.2024.10.22.07.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:19:56 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:19:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/3] dwc3: gadget: properly fix cache operations
Message-ID: <20241022141953.GC4959@bill-the-cat>
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <172955350574.3031532.4179642258271087474.b4-ty@konsulko.com>
 <87h694wlj0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6znTGy0RpZsVyGzd"
Content-Disposition: inline
In-Reply-To: <87h694wlj0.fsf@baylibre.com>
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


--6znTGy0RpZsVyGzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:10:27AM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On lun., oct. 21, 2024 at 17:31, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Fri, 11 Oct 2024 16:38:23 +0200, Neil Armstrong wrote:
> >
> >> We experience huge problems with cache handling on Qualcomm
> >> systems, and it appears the dcache handling in the DWC3 gadget
> >> code is quite wrong and causes operational issues.
> >>=20
> >> This serie fixes the dcache operations on unaligned data,
> >> and properly invalidate buffers when reading back data from
> >> hardware.
> >>=20
> >> [...]
> >
> > Applied to u-boot/master, thanks!
>=20
> I think you already pulled this via:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/87iktr2l9t.fsf@baylibre.=
com/

Ah, hunh. OK. So, I should try and run the script to update patchwork
status based on patch hashes more often. And I think b4 applied it to
the original merge base, then merged to master as a no-op.

--=20
Tom

--6znTGy0RpZsVyGzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcXtIIACgkQFHw5/5Y0
tyywjgv+MJd5S0EB+HB9+QcZMvkTXyuUsxTNJvqf9Q0YTY5PXZmBXrcGBFN6tXuV
3W7pDTNKqdlO24O+5+l+mQMFzSbXk79h3OQERtB4FVPwhbqGnviKNUOfC0DqMlQY
nCwfJ8lCUZXWc+/nlkyR1YB2OjF0/tW/iw/BHeKlWviO9JvTPZW0CKEAMa0lN5IJ
9f64YZw4a+mjpvP7gQHEygpgLTUvWUmqjWVjypDuJdKLeDTYRBZ4aIiNV4WoJEi8
piTh5+phiyn/bIRwb2sHFPrpsg7JN0S2kjGBc5ifQeaOyvO+xBe8jbVjhsoLb0vw
EBBguRELgd+uTdRYKnugK0lXPmZUxe6CXF6B4UrdFvPCbN7peQTSna3qcHSUc/mb
xeHLlfyemmYpim14ZU1dnyGTjXSg0x6kiRXAJBItGg53r87QAyGsas8Q6imdnAuZ
ILmXm/H1hijj7/nxBf6J/cw4CCeGYTczUq7y+VJuZC/FaY/zgsfgV7wUiM02/bfB
AoacYNJJ
=TwRF
-----END PGP SIGNATURE-----

--6znTGy0RpZsVyGzd--
