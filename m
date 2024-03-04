Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8D3C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF67D87FD2;
	Mon,  4 Mar 2024 16:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VPFzkxox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75EED86FCE; Mon,  4 Mar 2024 16:26:48 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AC087FED
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42e323a2e39so39492721cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566004; x=1710170804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dt50bPQgOuLDMKpqy2wChyU8TKyOWTuR+8EcNRAGl0M=;
 b=VPFzkxoxJWpAQQeWACcCuvLMgNcx1Aw3s99B/zpjS1snbzYI4BN9+Cp1PAqu9e8xdn
 YyQvQFlk8BG5h1IyqQjUCndWzkSh7IvIdJ2/IqXKhPg+iw756UUDz6iq6W6I06pOswq3
 1jER5zqlQuwUAn9lodfejCmt6xhM0n/Fdm+Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566004; x=1710170804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dt50bPQgOuLDMKpqy2wChyU8TKyOWTuR+8EcNRAGl0M=;
 b=dy4mBOZxzNwLqxeky7vaXaZ/Qy1IRQfHJsiO8DCMwQFPP/Eej3KDd0DznEFWv4S+2a
 +4AXKfqeVvzyQ9jmM0GyK9srVphnUAj82ZsVNMBfBHMdKbvT52iEwgyuGlH3Q4ii+v9e
 XNK393zPMbqQ7hOceKGGWcsudfF226Y9/k4u/WeJoLyeRkxuCfk8n9FUWIrFvMBZMXYF
 rJTrbojPazL3KZQT4QKk2cCLNflGglL9un9vRKEU/YP2pZ40/m6cbTfAE1XpEziS5AAf
 r/MxsPK2L98JwVwOXkwlGqMpCRv0mDJKDzB/LvPd47Jb+j2yRX2eTazOczGD7PbBEM+g
 1TAw==
X-Gm-Message-State: AOJu0YxLS+qxSaTSuAD3ONfGwE9uHhs/D/vZD2jC8otEUBwj/WKi+zWJ
 qZm4vLYpShBSHAhiIWwTxnPvq7IZHTxxisBpcYQl8nEKyimmid+AHzXdzR5J7Ao=
X-Google-Smtp-Source: AGHT+IH+zxI5SSPOAGSNMJcg+J1dViyLMf7Q5YHW8I5tMONklmbEC1YthlhsB26nvfrhTivH4p9bOg==
X-Received: by 2002:a05:622a:170e:b0:42e:db75:3cf9 with SMTP id
 h14-20020a05622a170e00b0042edb753cf9mr11680637qtk.27.1709566004150; 
 Mon, 04 Mar 2024 07:26:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 h24-20020ac85058000000b0042ee02f7b92sm2080992qtm.89.2024.03.04.07.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:43 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: Re: [PATCH 02/60] net: mediatek: add support for adjusting MDIO clock
Message-ID: <20240304152641.GJ1523872@bill-the-cat>
References: <20240122020811.143358-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MJE7Dt8HaagTd7fJ"
Content-Disposition: inline
In-Reply-To: <20240122020811.143358-1-weijie.gao@mediatek.com>
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


--MJE7Dt8HaagTd7fJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:08:11AM +0800, Weijie Gao wrote:

> User can assign a specific MDC speed to the eth node as follow:
>=20
> &eth {
> 	...
> 	phy-mode =3D "usxgmii";
> 	phy-handle =3D <&phy8>;
>=20
> 	mdio {
> 		clock-frequency =3D <10500000>;
> 	};
>=20
> 	phy8: eth-phy@8 {
> 	      compatible =3D "ethernet-phy-id31c3.1c12";
> 	...
> };
>=20
> Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Applied to u-boot/next, thanks!

--=20
Tom

--MJE7Dt8HaagTd7fJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6DEACgkQFHw5/5Y0
tywkrwv/RBDRKo1uPkEVDUHtersf5+MmG3J4Xw7Ae3LlZKP/RcV3fcMcjr4ND4nD
yaqOYmngufOrw4TrZb06dnsDafYw+Q3xMMUAR73G59XExydDjqx5B9wTiffvgjy2
r0s6Qo31dUdCMgO3+xIUlQX2xiDe86kuWxPMo8hZOC0c0gfjPwkNLsVIyloyKr/c
ejTPv6MF80lsFATq023Kl8YbBE3lZFGCrA3Y/5O09tATEyWr5Upy6s+pCm59YAEN
x2OxUHujTLvB4Yz5CatpuiG6YN0WT4mBmGcj2you1DNHgk4or3Uox9dzmMrbCdWG
uHAc9tHg9i6GvVo8WIGvmtJef/1iVZXrkFgHSJHsX60+dtkbXRkDWrTrjWlFuD1w
6PPhy1xB8Mvbbhi3Lt3fscr0ZaVakVhNzzeshQGG/Rftz6ZIUR6UERJqSFUKQ3fc
A+mNq6lb4ryddBt7lU1fQkcGU324QCaj+OnlL/sW269K7XUWQfw2/0WXBeO4OPzn
UhsRJbOC
=iVL1
-----END PGP SIGNATURE-----

--MJE7Dt8HaagTd7fJ--
