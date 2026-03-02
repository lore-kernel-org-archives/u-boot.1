Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA8EA4E2F
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 16:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A043183F4C;
	Mon,  2 Mar 2026 17:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Af5jQtXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB72383F4D; Mon,  2 Mar 2026 17:03:44 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BD383F4C
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 17:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d19d3c7208so3608199a34.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 08:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772467421; x=1773072221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KmYMC2ivhhBMRp3aR/8NY19xmXaIRUyjCpjH98NG5Yc=;
 b=Af5jQtXJEoSVDPg+zUB9CA1e/2qGcsDyt76szYDc+sqzfYUZ3XY2HJhg1Q8ZkoRHPo
 VxVh3dChCA53J9Pu09alCLG80V+QNb74ZsV0w1ZfGOGvaEuDeYJrdTIIXawjqRcWA8Jc
 dbIwIAsRoOO9XNGEf8G7zYnmr0o2Z6on3uaZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772467421; x=1773072221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmYMC2ivhhBMRp3aR/8NY19xmXaIRUyjCpjH98NG5Yc=;
 b=F0c2SMLqll0UkxzAav82rUEpLv9pJrodnetetE4MpnTkMKfHoEo2uTAZ1BItugYcWq
 O/Of6Q6h04Wni8ziWr5YeQxZy3jr0+paN5K7DCHQh0AIMrMnvWe+J6IbY3fMw8lXCfgv
 odE8NcVTIHIqxisju6Pauh7fQEwM5/Um4Ts5cvnSzpSAxwWmsiD3sKyiec3PO4w6oRWJ
 eL7/fhxENrMIec9R9qO3HIwxWN2C2CxPzYHVeRy2K+1tiKLI1rppgAWlA7b1QpLnVbF6
 qbL9x5pIGQGmg6JFCHxOObqlZjuK8GUXt3vkH3SwumtvCpKCf5UWHt77BV7ffcwYAO9x
 GgSw==
X-Gm-Message-State: AOJu0YxuGnm+nGFWMsLfNdSdhHhWnYwYcNHYhDYJafXc8lu6qiQtTc6S
 /KdzEC6tPDTcGWKshQFin1YJ7wfRZVM6zE18/iD0YIX8TfcTyNIv8l980unU12GCfCg=
X-Gm-Gg: ATEYQzzcVGI/ieq+ZJtvbJU1+1ctUbLO4BxBG11bWYLQMn4GpQ3wiGGhrnu++8zExJa
 6yI11y+YRCcgpL8u7y9RV7ounZx76kzpKiNIhonaUxTIJfWvN3qAipnMfx0FmPwAVwwJBi5Legz
 V67QdKPNXFSRsLwHdghCjc93WHT/c0ncANfOXNlW7CoIDc/27rxcWqQrktOlbwlF9IZKQs9AGMV
 JVURm+F8/0ANPbDBOnDnXt7jtnZjsA09Tod555Ax9HmgwbF8Qiuvk9KAsH79Vgv8J7p3UOSYp2Z
 7+oKd5V0afX17YqAPAp5sSTQwD/PUtN1/rptZ+IyE4N1TaAZD7GX4ra5G7/CIin960vnVIPPLy/
 Se3SeRjc00Nh0jf5JvZz4sRGkJDakHeNFaLzGHvnkOObot4/f2baln2E/a5JuMGx2KF85kOfbV3
 vUn8tcO+bXGe43dgExNP7lTT/8yjvNp8iYptcKAoZade72nwslKFK/+RJEN/9CvxeG66KlByjee
 Atse/WqdL9wKH4JasxYsN4AnOZRYvxf3VubO/4359AxNVLrmXA=
X-Received: by 2002:a05:6830:81ce:b0:7c7:60aa:6496 with SMTP id
 46e09a7af769-7d591b1ae1dmr7508909a34.4.1772467421443; 
 Mon, 02 Mar 2026 08:03:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586226d14sm11098387a34.0.2026.03.02.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 08:03:40 -0800 (PST)
Date: Mon, 2 Mar 2026 10:03:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 2/7] test: fs_helper: Add a quiet flag to mk_fs()
Message-ID: <20260302160338.GD1388590@bill-the-cat>
References: <20260228182304.3728735-1-sjg@chromium.org>
 <20260228182304.3728735-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ky7IILvY7ToD9/4p"
Content-Disposition: inline
In-Reply-To: <20260228182304.3728735-3-sjg@chromium.org>
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


--Ky7IILvY7ToD9/4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 11:22:42AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> In many cases callers only want to see warnings and errors from the
> filesystem-creation tools, not their normal output.
>=20
> Add a quiet parameter to mk_fs() that suppresses the output of mkfs
> and switches mcopy from verbose to quiet mode.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Ky7IILvY7ToD9/4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaW02gAKCRAr4qD1Cr/k
CkMuAP4pB9CODf4kpfYxmVQQdjyd0baHWPTRy5ohCskFjLA2yAD/TO1R0OvuRTra
fk63SNld/yPngZXnm5hvk3WroADuMgs=
=adbB
-----END PGP SIGNATURE-----

--Ky7IILvY7ToD9/4p--
