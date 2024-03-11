Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E122BC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11C887E1E;
	Mon, 11 Mar 2024 15:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kzktq3tP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA4687E50; Mon, 11 Mar 2024 15:39:44 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A589A87D0A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42a35c720b8so19906811cf.3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710167981; x=1710772781; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mUC44CYzP6mQDiHwrritv5zFtYs/1BbH/QCe+zHHQ7o=;
 b=kzktq3tPV+4S9yL8PGWCJFWZDcXYGW4dAH2ej84krveMVscF0M/r0TO6fzxLEQSxFk
 UYL/kIho20ZcqAQJXzd9NkdTv9lmviTHpAMmZV2GylJ2kX+NZ4lNBDCN08TQTUnJ1VwR
 JCHobzg2lflD2Y2fqIwR5PQox0H3S/7U7sVGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710167981; x=1710772781;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUC44CYzP6mQDiHwrritv5zFtYs/1BbH/QCe+zHHQ7o=;
 b=f/eFHd2TOUp2xE3FdT4ktvZYFCuSZyEMOFBRyp2vlnJk0O0EHOygWYzZEyEebAC/qD
 86rlEd/aFzbQ3DRwKmrABZKK2skM0FqNK8Swc0rVSDsUqdNo4ETF8LN4PSr/lyfucb++
 OtsnkN3+Er8Qb/RWIkQkBWEDyi9GaHIEmxGInwByDgqx96E03980JEpFMbwPtXXo2/LE
 lNF0YIAPxYJGRPju+yVQd0jCE5oQaAsVDNEET1lsbeab9iNTnNbBnSOAASM2QxMKU+t/
 eSPQwtlx2nIDESHogshJdYOj9c7LZGKC9373yK3k45TDdgdWGsN9h9wT2r4dneZ6gJq4
 YOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFAejCxzrULBAJ30RiBaAIpLH7u1tQMZs8sMqLGWX5odZ8sHIsbQp7/CqhwFbi5j4WjK4J454jPcRlI/IsxJPyoZEcww==
X-Gm-Message-State: AOJu0YxnpPNTu/GrZkdjoAQ0g7GMBIB2rBqXViORXgPGCeSnCHzy/XCu
 5MAA4LSbarlK6VlE+z3gAUhnsexCHciVx7RMh8/3hRClGdf9pLjCKB5lmFwRF7c=
X-Google-Smtp-Source: AGHT+IHUoBF6lkgHTRvQr54En17iB6sj2R/UYTbu/kSl3Fe/khtbhAKhzyDIJmo4/kncVrFv/gJL9w==
X-Received: by 2002:a05:622a:1115:b0:42e:f036:d9d1 with SMTP id
 e21-20020a05622a111500b0042ef036d9d1mr634015qty.12.1710167981440; 
 Mon, 11 Mar 2024 07:39:41 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 h24-20020ac85058000000b0042f370d120fsm2609423qtm.88.2024.03.11.07.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 07:39:41 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:39:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Message-ID: <20240311143938.GV1523872@bill-the-cat>
References: <20240302151813.GA1652651@bill-the-cat>
 <bd0b13b0-0554-b280-a40a-17056a1e2c5e@kernel-space.org>
 <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
 <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qFQcEoU3mwGYJOAX"
Content-Disposition: inline
In-Reply-To: <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
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


--qFQcEoU3mwGYJOAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 02:40:59PM +0530, Love Kumar wrote:
> Hi,
>=20
> On 11/03/24 2:11 pm, Angelo Dureghello wrote:
> > Hi,
> >=20
> > jfyi,
> >=20
> > reset support added in qemu
> > merged as commit d3c79c3974.
> >=20
> > Regards,
> > angelo
> >=20
> The other issue was with echo commands:
> =3D> echo $modeboot
> $modeboot
>=20
> =3D> echo $?
> $?
>=20
> Does HUSH shell is enabled by default for this?

It is not, so at least the saveenv test needs to depend on HUSH_PARSER
too.

--=20
Tom

--qFQcEoU3mwGYJOAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXvF6EACgkQFHw5/5Y0
tyxdVwv9F/GFcafsa6PpAxX4d/jXvnxk+zweeA7ZnzlAsR2BRovj/AJNoA1IXGWA
2pyvvZhd9i11l/aL3CqkzIapGq5SpOCRBabT0dxPcWFp4csGG43eVCldaorvnZSO
cJU1cbIchm47uCQM0NqTXPRh8Db1JQ8WwKDBdLVKTvhaTtkxsvpdQvooUEzjoV31
C8YUsbr2gRK8XHaDCpaHNHFZlKlrqx6pa4QAh5Io8nNsbwA5C9wBAPOeEVUTAPU5
uz+Ybr7K8Xjqdd6N2dScfI/IF5KNLSfNTT93MiyO7Ik/pm3/XhWQQbit89IN8esz
lfsbjcEgrD5kyvf4+z+3JHlmKMGNoYg6BsjM6GN92bISyVj/UfVro3gwhVOQnUsQ
9FoEMYFbSQncMqQ0HBU5WfKcFad3qlT/n8L0Pb6MKJrEcRJoMNYDNETugij4T80r
O8stBGt0rzWHyMqDvYHxkcYdy50rvwTb7KyC3TEdj8aXyNXLwt2PD06As0NhmYIW
zgbBc2v8
=DKUA
-----END PGP SIGNATURE-----

--qFQcEoU3mwGYJOAX--
