Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15CFC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BAF88414;
	Tue, 16 Apr 2024 21:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4uW5EAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB5F48843A; Tue, 16 Apr 2024 21:23:46 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C1C88390
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-437274f3bd4so874561cf.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713295424; x=1713900224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EgoYimd/tM2/h/SYasYN3JzzzO0GGqRB0wLrH3AwHBM=;
 b=j4uW5EAHy5PHMF/4vpamtjKtscrw1F0/x0Y58ffQF6qDH+W8I1db89JfbBcUUFf91w
 IGfMuFGOIm5Ua6B9Oco9p0mA6EpmD2dV1c4bOquKzoaGPtw84tC+vrKrwyIhJYz9q0ZJ
 MQssJyIg1ZFrC6tjelJitgpnboZL7j/qMBzR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713295424; x=1713900224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgoYimd/tM2/h/SYasYN3JzzzO0GGqRB0wLrH3AwHBM=;
 b=hBhSczdFcAQIv/BpICt/dCbYu4bDTWCKOU2HWHqTVvbNqlIxawq+JXPYauyEDexUH3
 CrxaWmk8Pet+MHf6R+OJAxKwwMGAtKddiAHU9zSWFbVWLIPkTg5lpOjMRmfC8QqP2O8D
 6n0cUtPJ0fPdhfKG0FRxs3DCv1QCtlyxTZXXA2iZYbT0WrynPbrHDx1168Po8SAMT9o+
 z9nNa2tInD7NrDiCXIIMJsZJpVXPNWdTR0wlmzUPCAr+TCVZbaGcQa/PMuFIJfuPnc62
 Ie2iMD0v/gQpGJxkKfuW0GxKKuQI9T0QKePrhAtuYP8u/k35vwT0UrnPjNE8hoJlV5jV
 G8/w==
X-Gm-Message-State: AOJu0YwYKkwSR1PfI44yGXXHchoHihbr+q6I5XIuKCr+8aUQ8NLixrdB
 yE6UCiSbXwJ9oRJ8WKc7WG1VLCqBAl+lPYlZNGZdem9ibGlxRiKCK+9OraLHVns=
X-Google-Smtp-Source: AGHT+IGKx3n/eY4DV9DhnCPmucVOEd7TEmSX3/A4XdNz9nyDBx5hoLTqRAsFs472hUv+MoJdLpKTYQ==
X-Received: by 2002:a05:622a:1a85:b0:436:8f23:f18d with SMTP id
 s5-20020a05622a1a8500b004368f23f18dmr5300727qtc.30.1713295423709; 
 Tue, 16 Apr 2024 12:23:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05622a035300b004370602ce47sm2840169qtw.85.2024.04.16.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:23:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:23:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Subject: Re: [PATCH 00/23] [RFC] Integrate MbedTLS v3.6 LTS with U-Boot
Message-ID: <20240416192340.GX1054907@bill-the-cat>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e3E1pXUMgs+YI/Fg"
Content-Disposition: inline
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
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


--e3E1pXUMgs+YI/Fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:59:56AM -0700, Raymond Mao wrote:

> Integrate MbedTLS v3.6 LTS (currently v3.6.0-RC1) with U-Boot.
>=20
> Patch 01 and 02 are for introducing MbedTLS release package.
> I have to split it into 2 parts due to the size limitation of Gmail.

So to be clear, for v2 you need to switch this to subtrees, like we do
for upstream dts files now. And a script to automate the "merge a new
release" should be done as well. Thanks!

--=20
Tom

--e3E1pXUMgs+YI/Fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYe0DwACgkQFHw5/5Y0
tyx8PAv8DHJzBKssPR6Jp6wWzrK/KaoH67ZJht+r3huQjxtM8VxPqdLZCVbQZ13F
WL+iFecd54siO7HI8P/slWt1Siri3dVaTpfK561XSH3Ld/rC7hXZckiKkk1ViNKa
Zsqc5iW+KCYal0RlSTC+5z3YHlc9WeU/QiwUV/1mAfJJJ9rekxPRe6rFtqXXdkcO
nqg1OJHcSMF4uRL75wBfc9F09hNi74H2WUJxTuTDd5q5RsEhyAXwzovlBQ/dei08
pZmWo3yef+oW5YJamE6krOS/eZN/pc0l8G5A9MIc99mRHbcK9sQSSMMqXGhIHB3O
Y6htpVTc5PNRBkt/4NVSLEP1zT8cjEt0E21NyvAsyHETTOin+mPlk9zgpePOKf7v
+u9VJGBZ6233Ldp5q2RbYpyvhadZQSxiddO/b15cKHAHwgjSpybE4aO+iuUMQ7KQ
l14iRrUK1kvVvv7dSXHYr+JAGcMYc1oEEKtLn4oP885fVwQbOMDHTZ9xy4tLlXlL
kTbnv7aH
=sK2M
-----END PGP SIGNATURE-----

--e3E1pXUMgs+YI/Fg--
