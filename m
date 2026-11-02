Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F8606A90D
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GGJDxUMq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CjH/vy30
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 524A9607EC;
	Mon,  2 Nov 2026 16:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-4yXQgyKf9B; Mon,  2 Nov 2026 16:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F62A607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636762;
	b=KdXugSLkyk+ZPprX++XMob3I+tudFfUnFqJv1DD7DxCxxa7tRtnRI6ox3BxZHtWaWz/B
	 jx9RgKbWewiF7SUqzypKJqpkvqccasFRjlcqCD0sZiHdDtbWm8BhR0X1cE6sr10dGEaId
	 UGwOA7imnUUl8/OZVi+HXwCA6XOUpD4OsYOx2M94dL7kgFsvO9jO4bTpQHafJVtgAkCOe
	 ZfFZOZ8gWZrPLdAKB9v7ffR6pfspUltDf4sF06l/TezinZUe/mCaNi/YeLxeHEWN/VHNI
	 VhIGGNPjpwD4MXYWQIUaPUN9sSMSPDY3WKvO4zC3+5lVic60a/KhZTMRm8N+OYP7S1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9y6HLWn+nxHq1otGSgN/rC7KBpCkrhSmFf9mxGAXZDQ=;
	b=ZXeb5YqBUNGbTn5VirlejadvadEOx14g9Drh78d3/OCUAnGxrD1szvq0WsaCqdXqzkau
	 gjq6QlnlpZ6ShUXnGaTPQJg68rwgG9CkUwcGxIZAfwWLCjp4Xz7q3wyFsaPqNrdktSTV0
	 /1+RUlj9XeaS3VHQ4Dx5p4J6goHIPFhAedrwSqMElqY1Vv5iPDuVeFKeBPlOC/jsWdtNE
	 uPhVc/dQMYFk2DQb/pGxZ4gFtiIoMm+5fsQXlKLvoYTyGkmzucwMOekR8oJSeS9GB/Bof
	 8fmjFUCbvCc1NCfTSMexFP85PLMRZSdYHMc1z+D9PJiFxYgFw4YBZ8vw2X6DAJg+udw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636762;
	bh=9y6HLWn+nxHq1otGSgN/rC7KBpCkrhSmFf9mxGAXZDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGJDxUMqBN4h5bJOFCQLRJ+hcEVkatb1gUfILfKBeS9EFJgmqOLD1y2dnDYFYGa6c
	 p8TAt3ETOPYdzHq31GGUOY1PboMH0yM0NdAKxKMgsn7SIvZN8h2srdQ27KucaHt752
	 TJ879UhOouGkCqBU33O9QjbQ9Q9NwvlJON/or3T3F+n0CMin4Y5GSzx2oHkqUI5X9S
	 dwI41kYT2PCT+sLDR72dwoWqt2Ry2r/+X9D5paFXj0hpsB9V6vFBVIlZwgG4CvpUCE
	 rXv0BwU/3HKZmQJTYT+Asuy6L68azKGa5AnkSv9KzKzP7jGP68OOrnIjuVsQHH6aWe
	 xRmWe7A0/T0eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F62A607F5;
	Mon,  2 Nov 2026 16:26:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC631120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9E544009E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYcryb0qgtSI for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:26:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 33E364007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636761;
 b=d1bh8gHY63Dckw8dnIwVwi6/BHJZnaSg0kzdevrsY6BzJJM2dG4Vk4vWkN0gah4N/YJE
 LGGPovQXhNWpRkMa4aGj5OuOluY5wOY2jl6YvYljpRNpzZolHLLDa92OKm/MsnN+Tl+Cp
 q+PY3/MXb+V793XrZGS3xH/kBEXyQZ+5Q29MMTEB13YEnp1vE+6+gCMxjZTRRvKAVPjGV
 2n0pIkFbYyXAtPdzO+66Q1E0qiO7r5DIx0d2rlyuxzNvQ+VSbwSUyRJ9SzJ6f+G7HyJzG
 wRpeib58peBFLApvc4pmlVbeFWA4ACI8BvBsYB9IHf6DB2wzvSCNOAinNup3PTPdJrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=9y6HLWn+nxHq1otGSgN/rC7KBpCkrhSmFf9mxGAXZDQ=;
 b=aSxv7E7Xj7qpzG2hhGzQGx5TkM5HCyn9ptsmDaRGoQdKGWEtaD2UGLOzVSp9U1B1ywIZ
 vNalBvYd/dZwhpcYIF7ltmsyj+3NWrVPXoRX6KmYhFymlQqiY2OHTndXInWaNElJUL2g+
 +/VTWT1ohsHjCdnn2wwgpP4c6iwx6vg0Ly8aKAcNZK14kQL6YbDU7MguDY7vDtDth3dbd
 5gQvUEoY/XlGTwRLio0sAO4chXW0i2Qx+P1Op4+NeseJYOKCGrto7fEsHLWtTr6ddFMSH
 CAzFwOBTZvjn4IYCbkP7n+c11s/+jnWSKd7rnHS6fv3pOGzwpc04TfDBmO7gNbf3EqA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="CjH/vy30"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CjH/vy30
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 33E364007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:26:00 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6e560e00a86so2264633eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793636760; x=1794241560;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9y6HLWn+nxHq1otGSgN/rC7KBpCkrhSmFf9mxGAXZDQ=;
 b=CjH/vy30wNZ4364OYVc0DENWdqCv0PCRYZyk76FMd3cw4A2C19R/Ua+/DIRwSFdf0z
 qJ2yKZnueS9GF4At/HwLqae/Cprl69XOqkQTNRKtkjpK5EMi1FLa5jfYz9nzDE9pEE4x
 QFgRB/LqE5yE/BeLUfkxe4x6Zw6X4fp++58S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636760; x=1794241560;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9y6HLWn+nxHq1otGSgN/rC7KBpCkrhSmFf9mxGAXZDQ=;
 b=mWu+MdjCC2Fpd9FmTpOtNW9kRT/+7C0J/COWhoOmeLU1/Ys11+gEb+xSRXTqdvG5s8
 Tb30fKi/+Yrup/PI5juu0rU/70HdeM6qVVGC9zeBV/YUWm2ZD7y+5MvRS5EzxjwMTUML
 FHFJ3RvrG62RN+UaFSUiVGs+u4SUn32S3csqoj0hpDtlLdpMaZPlKrDHv2UvzijyEnRQ
 eb+UItPDmiQfa0Sb0lr/X+hIeTZgnVOr6sFqvtPRXUbftpQqPNgYGj0KHUov0s4wsVKQ
 Dsxnp950bsOm8ahcs/hWblMLoG3UQUvguTWQnFpv9/1X8x/tcvvmy2hO4pBNhYpDvEdB
 0tXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByc95ZdbnS4m7lQimB+2uhoT2dPmue9QmnxaZ0T2+cZxTnvY113mOPht4pOxz2uiINrMNcX+o4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK0oEQ/iU7VZBGpQwc+OCTZyqaZ36LeNIovELQLwLNKeLno443C
 +jmL8AECnS2HDaXy4quWivoxM5Y7wpg0+C0zXyT1r9aASqejfAtkcsrFi8wM5CIPcsc=
X-Gm-Gg: AYBFou0n8kJGu1W36qt2x806hpDR30JvyLWOFqlzF/KBJJH52syGXKP8paOPfyJDiJD
 gD2FwzUPBM0A8FegRQHOgVJxXWFUb964LbM+pvSKpGHc5ANUUlBB9tf/Eopaux6tUDkMZbeai03
 xJu/QCPvMz/OgcGgJznf1S3ce0WkKQaUlaAcGEOvQ55E/TALkAM98EmB7XokOxw8ozSv+lYddud
 7/Cx+8VoqJOqLtE7BtYmT5gTXsHSA8uYcT4pGXQgVb3I2OuUhYsIIDFVPO7tuKKp3PhGftoQ4A6
 Dx3tKC0xEcOw9t3EzcnQgaLWScmOSaOBlixrW5Gh9hdpessBbZg15v8Pfo9U6uQbCH4Dg21R/eI
 G1/0ur3ff2JKHpAbgvUPHlIBa4Dr+sIKCTFR6cbSn8R0gzL6GFkhCcenhyAvfj431QUdXT57BJk
 /4oOjXHiBXsq9tx5SQqBl06X36TBX86pgDtUkLa6TcYofzW1iS2h82KDVGFqZnHR/GjUoCTPyWf
 KjMGLL8uYyerGUIXkLLkQBBJmVvHVDQsgYT+2lK2ahAEeC+eUI8X/dP7KJnAzbJA6bVqa9BjO0E
 PdynQ6CXM9HeEA3/T/RC5zhaJR0VmTj47EY4hq6HlLKtKkNCFY4vOL2w7dKO70ouSysD0wltPBW
 RCdEhQb1tWdM9Q6GXuX+DhbI1WliseVBnwsb5aVbJf95g66r2oID0tFIFLq6JV9xv4HJ8wTHWGF
 2kPjNQT1udFU3EzavLjIpbEVNdVfxEDA==
X-Received: by 2002:a05:6820:1505:b0:70b:a287:72b5 with SMTP id
 006d021491bc7-714f23fc465mr5675575eaf.20.1793636759753; 
 Mon, 02 Nov 2026 08:25:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d355201f7sm9189029a34.23.2026.11.02.08.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:25:59 -0800 (PST)
Date: Mon, 2 Nov 2026 10:25:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Lukasz Majewski <lukma@denx.de>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH RESEND v10 03/15] mach-snapdragon: Add PBL shared data
 defines
Message-ID: <20261102162555.GW3309461@bill-the-cat>
References: <20261102-spl-v10-0-224d421c6201@oss.qualcomm.com>
 <20261102-spl-v10-3-224d421c6201@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FxcirhK3Np7Q0LSG"
Content-Disposition: inline
In-Reply-To: <20261102-spl-v10-3-224d421c6201@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--FxcirhK3Np7Q0LSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:18:35AM +0530, Varadarajan Narayanan wrote:

> Add structure and enum definitions to be able to parse the information
> that is passed from PBL. This will be used to identify the boot medium.
>=20
> Since the PBL shared data defines are private, move spl_boot_device() from
> board_spl.c to pbl-shared-data.c to parse the shared data and identify the
> boot medium
>=20
> Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
> ---
>  arch/arm/mach-snapdragon/Makefile          |   1 +
>  arch/arm/mach-snapdragon/board_spl.c       |   9 +--
>  arch/arm/mach-snapdragon/pbl-shared-data.c | 125 +++++++++++++++++++++++=
++++++
>  3 files changed, 127 insertions(+), 8 deletions(-)

And this "PBL" doesn't / can't speak some existing format to pass this
information along?

--=20
Tom

--FxcirhK3Np7Q0LSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaui5kAAKCRAr4qD1Cr/k
CmClAP9EcdfwLl2HSS5ErryVOXj4Hr/yAjsUUCPifuKrkGTl/wEAzUtlf5wb+BFN
BSLvemW5lyFcE8zI3J6wAGB0nC9jugg=
=0TlW
-----END PGP SIGNATURE-----

--FxcirhK3Np7Q0LSG--
