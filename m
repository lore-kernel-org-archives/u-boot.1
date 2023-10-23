Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD6FC25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 910C98790B;
	Mon, 23 Oct 2023 18:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qg50W++u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81A9A87933; Mon, 23 Oct 2023 18:58:50 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16258878EC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7dafb659cso35443247b3.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080327; x=1698685127; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9ko9XlvHFPJxlI2L65YuIoQ3aajd/bROWlOYAR4wWKA=;
 b=qg50W++uxtN/sAALQ133M6UDljDr5dQ66XKWzdyDM2LQgKvowZf3SSO6J6GQ25FoBO
 eNz3EwEaKSuYRp6sCAsee6M3l80FwO4PSWrTzNGmKA1cDi+Y66B19Zrne1kZhO5Q+MmR
 sJs/saY4g8TuTnLXIIzwbt1Sgec79Swq2GxbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080327; x=1698685127;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ko9XlvHFPJxlI2L65YuIoQ3aajd/bROWlOYAR4wWKA=;
 b=Czzi5/WbFJoBx9QcbhyN2PqChkEFBs3OrwOOYPdKT0NP3vYUqvnAJxhqC1HZcbyoRv
 1UjB71cJ8Sl1xy+OTFUqv4LmbNLvywOHoWQQqbb0Sz6bMVu10oxPTY/WjPTBkwFXEJ6u
 6xMasnP5GI7Jyc+XgfFfIVQ+SpJm7h7kWLzSYiQvoKmhvJoaXSqDnz9/v2qhXB22EjB3
 nJrNo+//2YsJ092IkSgBz0PzWNJdyMSsbiYDARo3FoPqUubUd4Sw29NIed2l1m7Rc+MG
 NURo5wjRRSskEd9+sf2b8MHEDs4hoFkGokEcPpzGvFtlUcCWQc0Llko7+GSeYbmGIkZe
 CCUQ==
X-Gm-Message-State: AOJu0YxxDQQQI9BbcHUJFVktYO5GyNIh2CsjCJL0SsBmotjXxeA4I/Dv
 VO36v7i8tWKvF2U4SVOJu9+Bhg==
X-Google-Smtp-Source: AGHT+IGDk2joj8IXWQ7mckJidp1ddDNrjz3TcGUzt84nsLFsLdqzUEzg22llA2N4G2xrILzx3q9oOQ==
X-Received: by 2002:a0d:d54d:0:b0:583:b186:d817 with SMTP id
 x74-20020a0dd54d000000b00583b186d817mr10719003ywd.27.1698080326786; 
 Mon, 23 Oct 2023 09:58:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a0dff02000000b005a7a4e3816esm3291194ywf.89.2023.10.23.09.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:58:46 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:58:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20231023
Message-ID: <20231023165844.GN496310@bill-the-cat>
References: <42fa4e61-93ea-4b99-a5a3-1ffc3ab36cd9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QsT3wwQ9b13GXT3E"
Content-Disposition: inline
In-Reply-To: <42fa4e61-93ea-4b99-a5a3-1ffc3ab36cd9@linaro.org>
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


--QsT3wwQ9b13GXT3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 11:02:30AM +0200, Neil Armstrong wrote:

> Hi Tom,
>=20
> An important fix for USB Gadget on G12/SM1 boards and a welcome DT sync f=
or the Amlogic A1 DT.
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/=
pipelines/18256
>=20
> Thanks,
> Neil
>=20
> The following changes since commit e65b5d35c9116485366bb08138043d51220551=
da:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-sh (2023-10-17 09:15:56 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot=
-amlogic-20231023
>=20
> for you to fetch changes up to 14a21f1a80afc58d52dc72e35f27d3a47d36c082:
>=20
>   arm: meson-a1: dts: Sync DT with Linux (2023-10-18 09:46:01 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--QsT3wwQ9b13GXT3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pkQACgkQFHw5/5Y0
tyz4igwAs5F4pJqW9pMLaoD39YaJZ13BMDMG4a9qSOy+D/n0+baWgaOaWHCxcInN
KAF3fUvc2E8UGsJogRH/g3CSwt83tOhZGa0U1k8YG4UFWtJCn3Nxw13jz58vJeQ3
mRsRG97lq3B/7smxP3FTkmZylxPfYf7gDHAtuTaeTqivFD76iBkt2VmTGqsA0uSC
0JatAn7cWWBHRUtYOK6GeJVgzXzd6z7euM7RD74Wh5KuVjpQVPZ2m+VOhVf8I16M
e8fj/En4qMYX9BfFLfOx5t6fmDMUMO3gWuww5gYRDq+mUlFSJVgS8xBRXtZyEFyL
1rR+EpJcDZBOmRZ0+fR3Du08ME7SufyKtYqYs0WB+ERwZiOCoVVYNVwMECLtckvz
cB/1sPmyeQ+pZt0EzLS6xz1WZ+7F5rPti5bc5lyGYqtC6Otzhap8KZWteWEkJiKs
SmVIpNrwjKYJrEKWAPhWcDmmSGrsCVRgd/YYvlPqafzAowPo1DEiVwGqeuFeCZEY
jmkSXBMa
=TJeW
-----END PGP SIGNATURE-----

--QsT3wwQ9b13GXT3E--
