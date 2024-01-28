Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08610C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 17:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49478879BB;
	Sun, 28 Jan 2024 18:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Bnssj/KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B81B87B6B; Sun, 28 Jan 2024 18:17:13 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736A087866
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5ffe7e7b7b3so18113307b3.3
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706462230; x=1707067030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ci9RH1PrO47nv+P3R4EnhkXvUXDYHcxomi7p+5U/vSY=;
 b=Bnssj/KAt3kaOm+ZErMiCyF2yz7NT26HkxmCPQq9WgSJqP1R4RSPPlU7lvs53GOvmM
 bg0a60aPj1PiLfhr6v/hbHXc+8AoFS3gmCjEqy1Iq2leMzHj34x2yjutEmq0YuWWaeGz
 q9A/uuZF2wKXeWNw63YOsHxEwLRzToJxkKqMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706462230; x=1707067030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ci9RH1PrO47nv+P3R4EnhkXvUXDYHcxomi7p+5U/vSY=;
 b=PqtcAPyI8NnMjaCffL3ZC9a6FwazjOCN7nCExJl/yO8GXV2++GLgorabxA2xIcdmve
 gmgvT0CA+Cc2/uF+2R/xfYODugMcurBZrj+OCwscuA/r+m5k33rYEBF1w/a6CfU0D1Ng
 no+lhQOD6KPtyIYO0+D9a8vwDDRddK6NX8HerHCxv3xteFSgBxEBI7sl2Zhb1SpD4Cc8
 lzUIJu/465HkpP6GHl5KWNlxfPCJ+F65dyREcfFGov2oDPh6HYvsNWztlOYdPXnGEQ0A
 6QonALVfiV6Jkq+pp7mpLCnBRKRhtQnVopwRpG1PTOo9RBJ4tZ1meyxmkNKcBZ3M1lBh
 yMOA==
X-Gm-Message-State: AOJu0YwVp6VEak2zzQsS3NxVebYZKk0ymSmc5iSQNu2s9fvW70uo/+Hz
 2JmPpNEX55IypFxC0TjoKA273RvG+mDEdkgQNuRQd7ZmXipmexFnwgyM6AI2plk=
X-Google-Smtp-Source: AGHT+IG1Mq/5PhHM6td/mnVTnc+M4yjOYD7GZjATfwLddrIijn7B6As2mBotEFMtZoPisevp25SnZA==
X-Received: by 2002:a0d:cd06:0:b0:5ff:9305:133f with SMTP id
 p6-20020a0dcd06000000b005ff9305133fmr2281168ywd.94.1706462230103; 
 Sun, 28 Jan 2024 09:17:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fv8-20020a05690c370800b005ff9264e841sm1848987ywb.6.2024.01.28.09.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 09:17:09 -0800 (PST)
Date: Sun, 28 Jan 2024 12:17:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] riscv: conflicting SPDX license linker scripts
Message-ID: <20240128171706.GE785631@bill-the-cat>
References: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
 <20240125083815.12623-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="conK0FBp+r/IikQW"
Content-Disposition: inline
In-Reply-To: <20240125083815.12623-2-heinrich.schuchardt@canonical.com>
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


--conK0FBp+r/IikQW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 09:38:13AM +0100, Heinrich Schuchardt wrote:

> Fix conflicting SPDX license information in linker scripts introduced by
> commit 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel
> style").
>=20
> Fixes: 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel s=
tyle")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--conK0FBp+r/IikQW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW2jA8ACgkQFHw5/5Y0
tyzRZgv8DnlQO5dG8YUZDxxbmJG3beXLde+ddXgXLbArhd/d+brUChgoi8AMM/xn
BGPfjfM50TwF4kYTHx7KBmsiHHwChJC9v21KwXgq810+rnzt82eebLnTC8KXw5jE
iga4S7kxURbGA8nP79C3ZV4c1OmkyAsOGIAnd5IwBWHmes0uk8I0leZegZlOBHpn
D+u6TTuqJKGXPf2faBmMB+szn5zAUIW7tbBp7s23ziP+4ezNzPfdtGF+h4ICTRsw
Bn0xn/BKZ9B7ERPK/g8zVr6FMUTzDrYfCGG2nODqtobkQBRz8MNznjRg2XEhtQtE
9PGbi0oCO/ItuVnSg/TrIv91HFGdNjAopvzV0fLTXo9w/4XsRdl6B6efvpPvenoE
23dmKca24rxuevXXS6623NchuATZ8RMvI1qaB/8scrPIv1vM/yWApnvVnRm1M2Kl
IFYYyG4hBEQBjBatoJU25yc8VrVBOx45L7uqkIrf5IXnSSBtwtjGM+VfoIYPv7To
psZWFKux
=CX02
-----END PGP SIGNATURE-----

--conK0FBp+r/IikQW--
