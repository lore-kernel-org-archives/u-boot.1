Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEBCCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA64382C84;
	Mon, 20 Oct 2025 19:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ewDCJEkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F317A82E34; Mon, 20 Oct 2025 19:10:15 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504E1807C0
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 19:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-651d3204fe8so1313369eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760980212; x=1761585012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J1eBzUD8C//dCMQPGML8YsKjNrzpKfxCPVCab8XRWZc=;
 b=ewDCJEkbFAbhRPsuolMwEQrRyUQDjRKhEAn8zRwCzYy1nV863fVNDHYMjKLKkCrkpv
 qR8+IpWFy3a8HufWBw0LGISqijRkmsLIdv3C5MlNdOoZ7agsewv5r5KXNnUqOWAPPF46
 oVzutzLnU/tsjYK+iY5Y/31oytgWDikZHWrL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760980212; x=1761585012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1eBzUD8C//dCMQPGML8YsKjNrzpKfxCPVCab8XRWZc=;
 b=TJ7mJcNl7Kseo670eoE8d6GCi/cpCfhefyhMDebVI5CadZmq4htF0TmiICEUtD4vUL
 bs3hXArM8mtgPX0iGHTUqSjIoSPCYSacwJxZUVWSbozduPzE0vdI3skKsfrmSFAche+G
 900489KfTD/a8GMjwq3UNHiMrmRGQDb8cTRT6VEh+WriWq5cnTedwzhI1OWbMb0p8A+w
 hmcZgO6kKxuo0RL0CRFP/p28q156iejI78ooeEy2sdHmlE/y9yuza37Xyd6OKuEdcNt4
 LXDAsEIzhJ3hlHLlRXy7BzR4WlsMhaq8YkLzQMK/j5zeEaaZBY6nynOIC8MD/SK3HgFA
 Axsg==
X-Gm-Message-State: AOJu0Yz0a7N0eOEF3M3rjE4h+rTqtxBfgSHkxCkg4SVWMwac5+DTtZOT
 ddRI5rW81lVGjbYc3X80JQA8QlnzRta8vsLxBT5uyQ6wp8bqzhrscxS3QrKAVaKoDuA=
X-Gm-Gg: ASbGnculLV2kq/L3WYt5MH1fQP+wbVT4M3YE+Olr+p6QWs/FyUv/jhCa8Gw3SolFa1/
 DEa4P8cLpHEdxT6/JIcwKkfFy4akX2msqr1iZDyi2gpZ6Rq1hCHHx2G3ekiXqQC8LAGfa4n3/j3
 tUieqvFPKGdAX5e7B8IOOeUbC3jZmIPTgaDWrTOkme4Ns9gZCxAawWv5lfpoF4nrpdCHIWNMaVj
 keln6P+uq7X4ovhbRnOZEi4uRkdNbYYvfk7cx7e6Lq9nXzQPNYITzoaJUYdO0l3rZhQREkJEvou
 1Hg4paF/yEFn9GVX6Q5RMmKbGafQ45cITL16MQuQb1MfyX64s0r6J4tyst+VXdyn00xfBaz2EMX
 7lZu0LdPzy4eV7K4fMx5SXaqFjdeEE5r0NeJEpaf4PV5+8xH8byA5VxyC8rpsJR44yN6zNEGasQ
 YYx4scYVdVvnMxapLOoGb+VW2MArPGAeJq9G8sILY=
X-Google-Smtp-Source: AGHT+IE1B3UvPO6jZ1/lt/HhjXGFN5Og1CwLJOTUVgmz6voAVXwC2Y7mk3UrCBkgY9DbxqVE7WVXpg==
X-Received: by 2002:a05:6808:159b:b0:441:c8af:2922 with SMTP id
 5614622812f47-443a30afa8fmr5052007b6e.37.1760980211926; 
 Mon, 20 Oct 2025 10:10:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d38ff5d3sm2077413eaf.0.2025.10.20.10.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 10:10:10 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:10:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Github testing stalled?
Message-ID: <20251020171008.GZ6688@bill-the-cat>
References: <d3f247e8-099e-42ca-bc7d-d66ef30d2f3c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7Lr6j3mDI/vii5e4"
Content-Disposition: inline
In-Reply-To: <d3f247e8-099e-42ca-bc7d-d66ef30d2f3c@linaro.org>
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


--7Lr6j3mDI/vii5e4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 05:09:24PM +0100, Andrew Goodbody wrote:

> I created a PR on github in order to run the CI on Azure. It seems to have
> stalled?
>=20
> https://github.com/u-boot/u-boot/pull/820
>=20
> Can anyone see what the problem is please?

Just in general, CI runs triggered by pull requests on GitHub are all on
a shared pipeline of 10 concurrent jobs at once, and also shared by my
account as well. However, as documented at
https://docs.u-boot.org/en/latest/develop/ci_testing.html#azure-pipelines
(and updates to make it clearer are welcome of course) individuals can
sign up for their own Azure account and trigger runs that way. That will
not be bottlenecked by the 10 concurrent job limit on "u-boot" (but
instead be limited by your own accounts 10 concurrent job limit).

--=20
Tom

--7Lr6j3mDI/vii5e4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZs6AAKCRAr4qD1Cr/k
CiJ8AQCpfR7ult0jWrBnHVFItvv40Rj5eF7W7OszAH5XDY6m5AD/THJM9qdUaYg/
EMBFLdsI/f6s9QQQoOcJe4XOIXDqOwA=
=y0Ag
-----END PGP SIGNATURE-----

--7Lr6j3mDI/vii5e4--
