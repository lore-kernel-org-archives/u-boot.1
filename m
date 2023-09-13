Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19766CA5539
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 16:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88EAD86AD0;
	Wed, 13 Sep 2023 18:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LlB5uouX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A09867D2; Wed, 13 Sep 2023 18:20:16 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909A086B9A
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 18:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7f0a60a159so22574276.0
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694622012; x=1695226812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y1hD4y3CVw2ElD8CmEvD37pxHwNDk1FSo3GuF1v6Mo0=;
 b=LlB5uouXApFG/MpdKr09BmCwgeI05lNGX3/Y8wRiWDfWlpkmmnznHTAA97vj/uzeKN
 8oX8ceReWAe6BzB+cAnTsRFCZNecxPGCwnuVU57m+7e6y7sT6j3egGiMl7XeNGffDIdJ
 TloCXwX3fBPvHCnLF1BRsH4YLLbwFIUwVRKzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694622012; x=1695226812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1hD4y3CVw2ElD8CmEvD37pxHwNDk1FSo3GuF1v6Mo0=;
 b=vtG/3lH291rfOYOAmeSbn1Jhk79EHGFskE2Zm7/d/9bd1ki98jQ1sk5IwrRkr49gHv
 Q4Y4NYCm7IQYFlToSdb9PBo+VQPIGDaIU4AL+YuQtTVBUNO15Ux5r95tWWy1OKb/rA7v
 bn6j1BDLxt2++L6VwogcsIdCVA6oD34G2gd6Mhf5XmYWD6C+YEQAlDm6M7cHKHhjxcmC
 y1aEgfz9YhjgUoVZimXZf9QdTCf8Nl0fIY6Co1d5DQFsUQMdsOwsEmQemLqBGCcbVwe+
 HllsaKO9kpJv6Hv9UR/vydzOGstSvzMT5RCwjtOnY0CKegp8Qd3mhLKRcYKtyd4Z/PO+
 qxgg==
X-Gm-Message-State: AOJu0YxC1f8lUJBhKa5743zsxnVoGhixrRyV98KhaEPMF7HgSSYqXl82
 g8afSI/+tIIvtsHP8hJFNIgfUQ==
X-Google-Smtp-Source: AGHT+IF7VIZ/qVTrTyIr8zMrxR2ERecpBqfY7i48JyJvpHl6mTH3iG0DQwF45niBGwwtQGY1Ks9p1w==
X-Received: by 2002:a5b:9c8:0:b0:d4b:ab7b:17ed with SMTP id
 y8-20020a5b09c8000000b00d4bab7b17edmr2710991ybq.4.1694622012380; 
 Wed, 13 Sep 2023 09:20:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 j62-20020a252341000000b00d1b86efc0ffsm2832749ybj.6.2023.09.13.09.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 09:20:11 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:20:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v2] CI: allow jobs to be run in merge requests
Message-ID: <20230913162010.GM305624@bill-the-cat>
References: <20230913141536.109844-1-andrejs.cainikovs@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FGCnekYLVuk2RPcd"
Content-Disposition: inline
In-Reply-To: <20230913141536.109844-1-andrejs.cainikovs@gmail.com>
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


--FGCnekYLVuk2RPcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 04:15:36PM +0200, Andrejs Cainikovs wrote:

> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
>=20
> Out-of-tree users could run an out-of-tree CI with limited coverage,
> however it is convenient to be able to run the upstream CI from time
> to time. To enable that we would need to change job rules to be able
> to run on any GitLab event. Excerpt from GitLab documentation:
>=20
> > Jobs with no rules default to except: merge_requests
>=20
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--FGCnekYLVuk2RPcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUB4TkACgkQFHw5/5Y0
tyxcfQv9HLyj8SO3qCdYPGKpWOrHlu45bOUcRnw9UKTHKjJjpJUdWWl9NyKZFtqj
VZvYtsLIcIj8+PpGvhxBABxbK3NvopLJi0flo+qx85dXqck0csBiY1GEdY8YhF1H
TezkvWflzVgfsDGFBcqMOhTqlU9Vqv3pQ3EeHlI3j/VrH5Ed86dC6gkP93iTubnM
wEdLeCgXcY7x4AFigtqzHfX2regel6dwoQ+ltrg9GM5ODi7QNGmbnMoGLLdIBsQE
NAzOYiIbwKa+66xEEXOexZXBYceZgNPp3ZSvSwAlsu3v1mM0LOpgDLoSAF873bz6
55Sk3KcYzXDBdoaNuHbM9Tdt1b59d11KQD62IZ48S2OMHS6vhHgExmheooH4gntq
6h3gBMwRjBYTGEIisF0HT7xBjV6bzuIfyq9bPOy2VLIZElYsMWtFtvatCv8IQqwl
0+UYwg8kOkjm3bq+2qMc8yQngaicjs6+eAATpVPKe9r8GGPJZt2lapi+zslhqOAF
+wxWmSWt
=n/47
-----END PGP SIGNATURE-----

--FGCnekYLVuk2RPcd--
