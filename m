Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E61C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 21:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2C188164;
	Fri,  1 Mar 2024 22:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rza+huSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6770A88165; Fri,  1 Mar 2024 22:35:21 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BFAD88160
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 22:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6087d1355fcso17967817b3.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 13:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709328918; x=1709933718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U49Y+CTnk2ywspeOc5aITMlAC41OA8/6whwerMKCrXg=;
 b=rza+huSqummJwPxQoFIXFxPNeqstzBuJzaQx4rjgC7/2hekbxCLG9trcuGFsck0fQx
 qCITwkxGlWaticcj019oHyiSgWlmnEwU6RgYkCeq213tWtPyNQkGstZ5OpG4iMdWRKAW
 8SWiTPwmnMCBIJ1LRQrAxpG1SmF6EXoI9cqSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709328918; x=1709933718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U49Y+CTnk2ywspeOc5aITMlAC41OA8/6whwerMKCrXg=;
 b=sYK+cP2YLsHx3JH/drVPtDsYlHy+yr0/eYJ54eOBrQzIslZwZ3eXuJKIP9EekgVGuy
 oiazhw7ovZnanWkr1vH1j+Ce2v6wEpwiPVUOC2+VI9aVfIOvgMaJURAUfmCn7umqQ57O
 TPrmMRXkxTISoBOP3A5HDFC+6A1c6uX+DTuzmiphZKkB2biWvvnJHh7HKM+8sFWO/rp4
 2XFrEMphMdftNeC5+o3zBcAhZCqTnMrYjfQ4gUxhV4E0ZAfP+UfPMRq1cco+1hGeOTNz
 urfIY1XRfWnL1gs+HsMwpPgXuEulatdEpkeYYASdJNTcCHoHaTIHWg88/QnIujOmgud2
 A9Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgzc8lw4RedFyOEZ5S1hc/iHQoq19GChOifrW1/06/MjwpQ4/glHkWydvERkgZk8NbjUx2y8NhutytfG8JijDIPdR9wg==
X-Gm-Message-State: AOJu0YwcaKqM5BbdTl7QDWrxQNAQfylaKSwbNXr8O6pof8KPezYwQchq
 c7udMjVfveOQL/xacLkA1LxfqwuuNb0xQLbGbkRUpea5aLKozDkv34huMDGCUIxyOwZn0DGFBdj
 k
X-Google-Smtp-Source: AGHT+IFdvEnWGvPVWjNvqPamRpf72It12fTjR0vZ+qu6KjxAtNm9NRZ94MfsbKET7dnMmcDasvLUmQ==
X-Received: by 2002:a0d:df96:0:b0:609:86ef:200d with SMTP id
 i144-20020a0ddf96000000b0060986ef200dmr2451498ywe.9.1709328917948; 
 Fri, 01 Mar 2024 13:35:17 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 y127-20020a0def85000000b00609613c968asm1164020ywe.84.2024.03.01.13.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 13:35:17 -0800 (PST)
Date: Fri, 1 Mar 2024 16:35:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-next
Message-ID: <20240301213515.GI3040305@bill-the-cat>
References: <20240301155815.49606-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GcNu+YH3ZjdNgVsd"
Content-Disposition: inline
In-Reply-To: <20240301155815.49606-1-caleb.connolly@linaro.org>
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


--GcNu+YH3ZjdNgVsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 03:45:21PM +0000, Caleb Connolly wrote:

> Hi Tom,
>=20
> I know Sumits dt-rebasing series just landed, so the timing isn't fantast=
ic with
> this series importing a bunch of DT stuff from Linux. However we've had t=
wo new
> contributors this week adding new Qualcomm boards - I'd really like to get
> this rework in so those folks aren't blocked on it and we can get out of =
this
> limbo state.
>=20
> I'll follow this up with a switch to OF_UPSTREAM asap!
>=20
> Thanks and regards,
> // Caleb
>=20
> The following changes since commit 5b825032957c2613ef2f8f639e949ae02cb5bd=
ff:
>=20
>   Merge patch series "An effort to bring DT bindings compliance within U-=
Boot" (2024-02-29 22:24:23 -0500)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git HEAD
>=20
> for you to fetch changes up to cbf3152f6afff25c25aa69ae06488671ca0aa765:
>=20
>   clk/qcom: apq8016: allow apq8016_clk_init_uart() to be called externall=
y (2024-03-01 15:08:59 +0000)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--GcNu+YH3ZjdNgVsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiSg8ACgkQFHw5/5Y0
tyxfaAwAsp0sUDpHlmZrysgjl63Z3ZBBkCdl8iVrHd+KQNU8QgZxN0x3cNg66OZs
i4QeOPsTVZ3ki7p3MRUp1svLBtkGmgP4WxodH5Xdd5JFwJ66m+jz01z6CDXCbeB3
uLFZPoVx1MJRcEmzYUsmAeNdgaqa28Z49xXL0kVQwKnhElRWKLCc6ZWGi4cQESQy
/+SzYXC+/VhF4dHPsgScBvUVLDrTv+0t1RtXnDDr8Ahq5251TRAhWP43x1auzOCO
Fs8G87rkOq1ClBfD83seE7xbsIWUqqjyJBzPrJZvjH1emcmFGV5icSYpBv6NZHxW
VC3prkbgDsjGA5sG43avVHIyPpeD9N9V3hb27kSKOqwY6tlFRQlj5h1EgJr6HSuR
RSrRj5iS264FtDsVf51o59xdisv5aPiPLxl9R3W6WCeEu5bY17urOT+xjnh+n90l
uNUa6OLjvjfxZa0SMbbKkmTb7O6RfHbjWl8q5zRDrZR9/cm964d3fPddjl/TxWOP
qa1cdvw5
=BhFN
-----END PGP SIGNATURE-----

--GcNu+YH3ZjdNgVsd--
