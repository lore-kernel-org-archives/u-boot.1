Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76318C49EA1
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 14:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D42A888C45;
	Sat,  3 Aug 2024 16:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AgVOXri6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C3488C50; Sat,  3 Aug 2024 16:16:23 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A6388BFF
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 16:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-70968db52d0so3339762a34.3
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722694580; x=1723299380; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r0ZLFpUYIdbnC6F5KEAOtF4bVV6WoKNX6cnsa2LRvXc=;
 b=AgVOXri61/2+v2eWVP/gpjoZq45wy9N7ZucossANgh3jc/fo4UTMrfEOfoNXMgm45K
 6xOEMPS9P69HECcjo7ZKeTLcdseM7/szLxD58/penEUVy/3vfzDzzH4YI4ePLwEcf7O5
 WwRI9zBrwyv+VS7iDYHrE//qQupFU9jasfTQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722694580; x=1723299380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0ZLFpUYIdbnC6F5KEAOtF4bVV6WoKNX6cnsa2LRvXc=;
 b=sZqK4EWB+rovbXy2kuaWQAHMZxQfkgSEFr0M110gmO7IjyOFRZ8iSnNZyIcl3ZQc9H
 OmzLGLrhLCSNBB8G8BhNlBDVkqW6XDv05CTbQ0AdWd7CmCDPnp0LA/FIyR4iS2O+Nnp/
 TMAF4T1a5GCoCfzgTWHvSpNn2z7l6eSFNVDCwc2w7oa+dx7tgW5M4MLuPH0YvGCiillx
 5OT/4la68TgPF2tNLvh/dyZhJc1IPa9m4JDRK9VqtTq1SJC9NlG+MfkhW7loRTCbdVgA
 pyLFJRFMsBJEAKgTh7ih2k1oN2bFo3oNYN0WUQ4jsh6igTgl/FA0uwEhEK4huULyfKH1
 IdUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpp5pMy4F+a/Lkq32bBDVEprlo7yRrCYw9P53Re+VJASDlq/d656dcRHgXuf7Q4Mff8zOvZ6/LJN2n5Sz3LCQHKlKDwQ==
X-Gm-Message-State: AOJu0YxNkcjRqHC4dgXG3x9ymnkGXfq5/8f0hbUMvHSwtahvl7RVnbD2
 KgKsIqW39KCMs9BLSujEwc1UHGNVp7eHazCoNPpLVSfVpWee/YLSfB/5aChcj8c=
X-Google-Smtp-Source: AGHT+IEfc9Zzw2+M/X16mCNJwtxk8oPYdj9Dm1GRZXIg4bXkNwvHmWoEA/xAM26c2qicRzQxvUOpjw==
X-Received: by 2002:a05:6830:6dc6:b0:703:651b:382f with SMTP id
 46e09a7af769-709ad38d052mr9343072a34.3.1722694580236; 
 Sat, 03 Aug 2024 07:16:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a3a7511a5sm1398973a34.49.2024.08.03.07.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Aug 2024 07:16:19 -0700 (PDT)
Date: Sat, 3 Aug 2024 08:16:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] bootstage: Fix unstash of records from SPL
Message-ID: <20240803141616.GT3794063@bill-the-cat>
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A6SMxTioGXfd1I1y"
Content-Disposition: inline
In-Reply-To: <20240803124149.2916030-2-jonas@kwiboo.se>
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


--A6SMxTioGXfd1I1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 12:41:44PM +0000, Jonas Karlman wrote:

> The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
> for all") changed a bootstage unstash call to bootstage stash, this
> has resulted in bootstage records stashed in SPL no longer get unstaged
> in U-Boot proper. Fix this by changing back to a unstage call.
>=20
> Fixes: b81e31a1e6c5 ("bootstash: Do not provide a default address for all=
")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Whoops, thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--A6SMxTioGXfd1I1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmauO60ACgkQFHw5/5Y0
tyzMxQv9FczU5g2woBtRmZFKKVQViAF3589rydn337I9I0mVIjpcwmKs6CrL2pum
Jo6m+jge2t/Kt2sdkS7qEDI7+45T6Uchu/PgPEoDkGEXSFDZRGCK9Cd4Ua8Xrh1a
rUYxc7H7deQIL0dkR8tRobEk4uJibzTnOSZ0nn/q8MCT0Sp/qooh4IUHM5ZF2vC/
c9Rp06koHeEN6C17w3ETLL+CUyhx0CnD36OsClK0VOX2urTxgUf3RUmbVmKvZAhQ
VjC32NLoMAP9CCTi1D/HdFx1YrcZbj5XWe4GDv1yTI7hLW8v69bKu5v7oFZdL+dQ
TVKeRqVR4kDYJImM2NyeGFulBaGGiJSaf5Rcstww+VDNTQYULf+eOUaF6etOKK1o
crkPrbDK3IMNENgHmtYa5bxoPj3n6EBw5OnFjK4HYRpzRS7fS5oqZrKZAg+hg/XH
5Wj76B4CFw0EelgIl8BncOIgxOxtxAYxeXKQd4FjfFMilDZoILNOKSMM4057uypO
wZb4mW2c
=mNWR
-----END PGP SIGNATURE-----

--A6SMxTioGXfd1I1y--
