Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4C4C25B75
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 00:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29299883E5;
	Tue,  4 Jun 2024 02:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gwfu3PtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7CE883E8; Tue,  4 Jun 2024 02:35:56 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CE0883DB
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 02:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f8f024a75cso270919a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 17:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717461353; x=1718066153; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbtVO0hk6dLVEgMDUtNUiLRynxL5LOi/V/TK12vBLX4=;
 b=Gwfu3PtN7fBKyyZ2wzFVofvR3OJYMwbb0vAC+vDk2ct//27ElrxnQvctjSm97RV1WS
 w4Dnd8bqzaKAm+/zGS1tVGR8xVGT7X+q271rFcAXs1Hy9RhIMwIMstBVJTokbpzhiqFt
 RlhJZEOTZqCJa+97NZOfATNcZ5WhiET9nL3yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461353; x=1718066153;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbtVO0hk6dLVEgMDUtNUiLRynxL5LOi/V/TK12vBLX4=;
 b=D1nmRZa76axsLLCGsMbTBf1U2CVognv9BsmOuNGEoDIGcqLqVCFmeqqk+R1R+oj1HA
 tXmsOgWX1ejQAPofO94MFb2D3/NEpM14dWCq2F5/x0vtBmeYPamw195ibhkQyYJgHDaq
 FqwoDpFU+1T8LuuBqB9YqCPrATCVbag5GYX4BTVtgiSfPMZ4XV3dzd3P+j2hQxBCgYyE
 jRIdFVdJn5uoJEH8rrhPWEtjdTrP9p+bV50OITfEXdIJquh+s8XLMJAbbtEDqjTlYp4V
 yaoZS/i+EU23/2vFUnmDb/k2VtzXA0usrWZkQ9l0PJqjpAoMZPeMG2Nd6iKe05cfIDMa
 GHoA==
X-Gm-Message-State: AOJu0YzEK4tUmWIu/kL6g4SS30udruaKL76uCUStXFz3cOqGEsrRfL2c
 Foxq9vAU78YEa1xS3nVntLrLuUAr4jJoU43nCszEeiM2v+B+6c3tsJRTNo1zrrmjYgmCrt4BtX+
 p
X-Google-Smtp-Source: AGHT+IEtwQhbzYtUh9RXFurvDPHUqr/jWcJ6dWFGeKCV/2OrAbTrZQyxoXut9fogFxY55zyicUNXog==
X-Received: by 2002:a9d:5606:0:b0:6f0:e28c:afe0 with SMTP id
 46e09a7af769-6f911fb5037mr11686400a34.30.1717461353310; 
 Mon, 03 Jun 2024 17:35:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f91054ee19sm1716306a34.34.2024.06.03.17.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 17:35:51 -0700 (PDT)
Date: Mon, 3 Jun 2024 18:35:49 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.07-rc4 released
Message-ID: <20240604003549.GI68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W2DcYxa9rLnck9Sd"
Content-Disposition: inline
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


--W2DcYxa9rLnck9Sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc4. To reiterate what I said last
release, this really is the time for bug fixes (which includes
documentation corrections) only at this point. Pretty much anything else
should be for -next.

In terms of a changelog,=20
git log --merges v2024.07-rc3..v2024.07-rc4
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday, July 1st, 2024. Thanks
all!

--=20
Tom

--W2DcYxa9rLnck9Sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeYWUACgkQFHw5/5Y0
tyzo6gv+KEeJ8bvJbyVWU3iipUtovBPGUqqSYlEJz4tH+PGSCxsE3gwHUnY/LudN
Ut2Bn5ZLjcMOPOn769u2CMdml7j+N55wKYC9o+58VmBaEWttxiEAS1QxoYu5kR1v
5K5I7Nkzp0NMnmk/aG2d0yeyXDcNlnQAbr+PyCKxGr+X1NbdaYnJ3bjGEJ7jUcLY
TCmRkKB5gh+AcuF485vOE78fDXc/k4vDgA6KoMWSjujEXURQ5iWOSvfHUtecqlFD
LC1ytqUNIRyrcOpATWxSU1rsT1pL3d9ZHjdmK5AqSzDEio70cssoQPNhyyrHCd67
HOd3BOkLonLlRjV7nQbBAzZKTdKHKPqLRfQC/R8OgrwjH/8fGG1zbt7j9Ba00Ahy
0xOJuXugHdW+hLEa9RBuPv1fUPZclUQvUI86afFP1aBt/p/Q388y+tBQ7DfY5K2T
vXPz7kb1m0MpQdWxpQ1GpdDuDkfltHzQg6DsqvfJV8US/NSNBF7APYPTrhFZkf7r
d/sf1kcy
=RZNM
-----END PGP SIGNATURE-----

--W2DcYxa9rLnck9Sd--
