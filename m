Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86BECD8CA4
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 19:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D54F8405A;
	Mon,  8 Jun 2026 21:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uGAQZOEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740778407D; Mon,  8 Jun 2026 21:04:45 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513F3807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 21:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-486d0e175e9so767804b6e.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780945482; x=1781550282; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lvqP/Olq1Fzr9MfEgYy9q2wyJ5y9wxBnLr5ZT/naL0Y=;
 b=uGAQZOEMgs7XI2I1CJGNjCpaSHwiMnO8CESF5RqJ8yPbSi1JTQ6e+mYXK6MraWUGBX
 SNqL43Ksa9h7+0e4lP/3fv+/RJ0ZidktV0d7Z0Nj5g0YzNlJHy6pcBsESyWSHCAc/7Tv
 eae79CVWsXG4oN3aKS4FAiGo28bzItS21OOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945482; x=1781550282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvqP/Olq1Fzr9MfEgYy9q2wyJ5y9wxBnLr5ZT/naL0Y=;
 b=q723uLD1AkM3Ph4SviiRTAFRynQx7KPXAYVhhqWwl+j6K05xf8elmOLqBefp8XPG0k
 X8wNL8g25NogNVnycMeraVs/A70wtN0htj7VPusfTVxEr/7NFZ2phoay6NeM/nSfqnoW
 ZZK3TncAdOBWdwMYp82I19fqQmF0NeoXn17I721Z/aPemIM53nGYBg1HAE9uNmn85gf3
 NKcHel5D7fZZh9EH4RmKkNzBffVTaNkG1IXa+ZEsYmvV3cHXEPfRvymwU5gIgNfY/hSs
 HxuG7/tNQUgHQenIJTPkuGjUMwncqrAOl2UcvZuOYPIDtDPh/WTSyhtiPdq6IhVhk8Us
 pZ3Q==
X-Gm-Message-State: AOJu0Yyl13DK2pNH43YuMBNtvsIIO42q+YQnYJu9h0PFsw8xNpoPUeAH
 ElxD29fZd0XA0rsNLyePl+jBB0Km2BPFDApxOabpXQ8cTqwfQteHQvacEHUCGAFLX3nw7fTBFJB
 XeSzydpQ=
X-Gm-Gg: Acq92OFiNzvEHivnFrBu+rV4GMtcX7RbHTnhTUUn1r/EVM0nLQws4BZhsaf3S2j/jZS
 D6xQn/kUjHHHqqh9rw0E9juhWjUn3/AqZ8Q+7Ne/BcTUkplbJcQm5i9eavPD2jx4aXDtO695vum
 3RHRPZ5R7SJR6wAJZ+/kdK7TW5JyfYjzzw6htMkLujZLTdvnxwbLkzlJfCTLZHgk0wUYUduz5Ak
 gvmigbe1Uthg/N9TNWi7LmHXsvsnk3nMhEeCijfV4C9CD4ul+6098V7xgeiOSZ9qQnc/uXTpdN1
 h1W58A4wBTCC3wM/4zDU397+1WANeZgud19NX10o0bBn41Q9sqInP60iQGeKVI0e/xMX5VGnfNj
 Z1BH6rauomOzy4Vcgn4Ft47eFrOHMBQeNWoLXDTXJ+drsSF3h15mVmN3pDPjkgYTxg/Q2wKREKk
 U6X6JS8u/bX8Ae/6JT4idfmONVa787tRNVt/Nma2voyYjTty2RuICVmxCpFuyJuwpoeFuAJXDqe
 /UMc7D3dIxKcAvff9HWwtU3vjQ4bduCFoZsEvPrFJf0yaY0VTT4nSLRvgUFlQ==
X-Received: by 2002:a05:6808:1185:b0:463:faa3:8dda with SMTP id
 5614622812f47-4868dc61f04mr9949806b6e.13.1780945482066; 
 Mon, 08 Jun 2026 12:04:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e7923af1sm12946610a34.20.2026.06.08.12.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:04:41 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:04:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v3 1/5] ufs: Expose selected UFS functions
Message-ID: <20260608190438.GN382693@bill-the-cat>
References: <20260608-ufs_tool2-v3-0-a9f181e86229@mobileye.com>
 <20260608-ufs_tool2-v3-1-a9f181e86229@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SJ+SbLS27OORaIdz"
Content-Disposition: inline
In-Reply-To: <20260608-ufs_tool2-v3-1-a9f181e86229@mobileye.com>
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


--SJ+SbLS27OORaIdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 01:33:25PM +0300, Raz Ben Yehuda wrote:
> Remove static qualifier from selected functios to allow
> future use
>=20
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>  drivers/ufs/ufs-uclass.c | 18 +++++++++---------
>  drivers/ufs/ufs.h        | 13 +++++++++++++
>  2 files changed, 22 insertions(+), 9 deletions(-)

Making these functions public means that the kernel-doc portions need to
moved too, and put in include/ufs.h. This fixes the problem of having to
get drivers/ufs/ufs.h included by cmd/ufs.c in a later patch.

--=20
Tom

--SJ+SbLS27OORaIdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaicSQwAKCRAr4qD1Cr/k
Cma9AQDln1d5EPfZw5Y6pmX2PhKbf9KYWLi7XOJYz+BVMyT4NQD9Gu69a+6nobY4
SaukBrrLsfoF8L4OtJjrNMXVJb+c3gQ=
=VM+4
-----END PGP SIGNATURE-----

--SJ+SbLS27OORaIdz--
