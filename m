Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A72CC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FBA8780E;
	Tue, 12 Mar 2024 19:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZRfEZ592";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332DA87B2A; Tue, 12 Mar 2024 19:52:21 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED4D871A5
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 19:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-781753f52afso413511085a.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710269537; x=1710874337; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PxenfmqMHY/f5F4bTNzZSWwGYh3TnJYuAGb9+eBGoBI=;
 b=ZRfEZ592DnvWjgZ+P8CB5ptstON2jibFsFR480GDBwD7vhMmrYfMfQHAeXurbfJ4DN
 aKpdirWj2Lgy+6QBJ2XhGgY6L0WxiJe5Spu3YXzRrH7GMjMWFANOG+R3xECVMVy8O044
 Myzu4TTagH9DtY3XQs5+vCrnMSRolctPGULyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710269537; x=1710874337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxenfmqMHY/f5F4bTNzZSWwGYh3TnJYuAGb9+eBGoBI=;
 b=BtmzTTbTDYgzvtwMtbz/erzpUNlHXbTUrkoq55G/I7S2z+sE3yqR0g4wYtpKpga6Zj
 3BSyARWOx6aEWXaWcGZPNv2W6ayQTb/sgdz7DTs0spUkRj5TipdvZXOANd9yhqzv7WoQ
 vrzyuiq70MzS8FQhshnlu288s4imzKFbkOT7WgLT+B0d6ANwWfbWYyZt5KmjjP2O/vaz
 dEGxD7+aKSFgUqJLDuFskloSHwjMSJk7a4p0SE0pZ3WKys4EY9RivSO3RKDjEMXakQIs
 7yc2izPVOrn2no/5GZ5o5DaYeVyNNhxmChDbvICsoPQwYiina5+dFJMeqb26CAZrIaVm
 Fqiw==
X-Gm-Message-State: AOJu0YwPsFt8fwuimtpRK5lsLoeRv8PMl2u4675/8QdFf58SWQ0HAwW9
 3e+0SWQxTM+gFKmS9RdtkHREeasBxQ7CP73WCx8G5VfDnDKwBP997NgaSXb7j+zzdYz0Vie9g7p
 d
X-Google-Smtp-Source: AGHT+IG5yMUb2q3VUXNilvpxkFYE9nMqiBDzr3kGE1guw3ixt3YcoGPXzD4v5rzImsqF9s+uiojo0Q==
X-Received: by 2002:a05:620a:38e:b0:788:f9c:8cb7 with SMTP id
 q14-20020a05620a038e00b007880f9c8cb7mr11514450qkm.35.1710269537499; 
 Tue, 12 Mar 2024 11:52:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1003.res6.spectrum.com.
 [2603:6081:7b00:7f::1003]) by smtp.gmail.com with ESMTPSA id
 y9-20020ae9f409000000b007885e3275e9sm3733091qkl.132.2024.03.12.11.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:52:17 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:52:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240312185215.GE1523872@bill-the-cat>
References: <ZfAXpj_WS-QxCHuC@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pqMF8M1577yWGlIs"
Content-Disposition: inline
In-Reply-To: <ZfAXpj_WS-QxCHuC@swlinux02>
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


--pqMF8M1577yWGlIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 04:51:50PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc=
2d:
>=20
>   Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 544af8207c69829b1697f3aa5dd682a299a6dea4:
>=20
>   board: starfive: maintainer: Add visionfive2 PCIe driver (2024-03-12 14=
:36:13 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/19910

Applied to u-boot/master, thanks!

--=20
Tom

--pqMF8M1577yWGlIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXwpFoACgkQFHw5/5Y0
tywhxAv/dVcbhO+KBFzNjM6NiukXIyI8YyB2v1Axz+fj9/MsFaHk9/k/PTSvDYyD
VZqBaO0Pzi5ElrcINOE/C7X6X+w54HSsssP0ijxRHFxURp48Ps4qcRMbaXEXtvjG
4Wzo9oFvNqZp+HF2gEQ1Pt0pEq9of27+fKUFLlwXQP/lRR1pOzYV6joEt7ZhZVx/
NuTXlSgvlMHvhgdscG+eV0tot9xppKjVRbbmQHXuMVpN035GTcHxcWAS78wRHouw
uav1x7UELgKCyFknANSMQHmS+G5NEzePCIMzY0rEHrHoEcc2oCdOmUAszXcBclXj
nLWPhNbI3GjwQbNMYjt4ptIho800ufqi0dvVtqhEhRfC20XLWtbprHx5aM7Hf2O4
ZgP78jj0YP7TVL0dlW40imLV5CJnjwTdK3oiTI0sqXje3jlB3MTdODw1XZU2fZjk
cV6f9M+GMmUDE7qVmkzCcoVjz0BRK1bwJDMLAh/DKTkEc7405qmTbXUQYz+Oyvm/
NeSxekyx
=YqWK
-----END PGP SIGNATURE-----

--pqMF8M1577yWGlIs--
