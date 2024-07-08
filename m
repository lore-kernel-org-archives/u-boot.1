Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79FDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2B788768;
	Mon,  8 Jul 2024 16:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gPY2DGwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE668875B; Mon,  8 Jul 2024 16:11:50 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E95F8875B
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5c229aa4d35so1952484eaf.3
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720447907; x=1721052707; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jEvgMOliL3QlcC+i0eA3P3nz41qpeOhfATfaeHW/XUA=;
 b=gPY2DGwaJR+vST2C5izEGUIGvkwqG+9CjbLcJhAFBIVOht3wDVDzlKGKVzLgOuAPvn
 tkVaecBPxeob4PMwHfWG0Mfq4a4xsLm0jVq6kG2c8Ss/caIXON1ibpkyQuGoeAjt5/vR
 zr/u5JW9iW7OSk+wicFxAJ6YO4n8WsD1sHgmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720447907; x=1721052707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEvgMOliL3QlcC+i0eA3P3nz41qpeOhfATfaeHW/XUA=;
 b=Wnbsxfs1FLfqwvd4iyPtQx18EnGgawoy2BBc7bUjG175lFDXdd8aW8OV8Y3n1fBgz9
 p8QYW7QY4PM6+gDf4laRID0SXKgpjsqQ5AzvhYVpN1wD4ESK1MV/HnZZ0UZJ0IlD0NFu
 HkoMInBdHRXVSDD89EMWWgtDV2UGrMdDknpMCwdWX+OntmK1Z3UbPLhYRRq8aqneSeP2
 pw01SEGjE+zfbixNQ0zY5oG7gZCEB5LcVucWU/bCp2Ot1Lp9VYBqvAos8162QqbQJPZc
 98yBSTtY7rHmDn/86IXoAUu44Su0daSnLAO7/hD623q1sgVYxNy/EKOIhuETHAUmoXpE
 XNPA==
X-Gm-Message-State: AOJu0YwLzF7Ef8zptd+0RhVkQIl/8+Zzyt4XsiOu48fQvT1Fgt1phuwO
 XJPAnoOQHGHjz2B3CZjZ+qf8cjTxiMkLa265cZm45CjBzD++1tnIuRT0PZ0tbtY=
X-Google-Smtp-Source: AGHT+IHf6+FiNj2S1oKsZ/k0+095VI8kUcmPmWVYQqt7LCXHdDSgKE+LMUxfTZtAjUqBQNJGFGATfQ==
X-Received: by 2002:a05:6870:5ba7:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-25e2b8cee7amr10332745fac.12.1720447906916; 
 Mon, 08 Jul 2024 07:11:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25ea9fe85bdsm8076fac.15.2024.07.08.07.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 07:11:46 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:11:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 18/48] lmb: introduce a function to add memory to
 the lmb memory map
Message-ID: <20240708141142.GB38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-19-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YxCx89w9/NqkQGco"
Content-Disposition: inline
In-Reply-To: <20240704073544.670249-19-sughosh.ganu@linaro.org>
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


--YxCx89w9/NqkQGco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 01:05:14PM +0530, Sughosh Ganu wrote:

> Introduce a function lmb_add_memory() to add available memory to the
> LMB memory map. Call this function during board init once the LMB data
> structures have been initialised.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Add memory only till ram_top to the LMB memory map, instead of all
>   enumerated memory.
>=20
>  include/lmb.h | 11 +++++++++++
>  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)

Checkpatch:
ERROR: space prohibited before that close parenthesis ')'
#78: FILE: lib/lmb.c:274:
+                       if (rgn_top > ram_top )

--=20
Tom

--YxCx89w9/NqkQGco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaL854ACgkQFHw5/5Y0
tyxgdwv+INGFGUP+Z9SzLZrh/I+K1KsGSUEHsL86ZwRzNsvYlUnQm6iKOiAlze0v
C1Qjxz6UAueB2PQWie//aKFiUG+kss0cX+pd8sMKo0Z81kwctOMP7SfJaTM3SniJ
GxZABQIFTC5QqsvBft1sGQ5fIUuwRDcOJWDsoQjQBokiAVFG/Zz13jHGzGB24hC6
daeFzp+BQAmct7KFzkivV2no8ClSshsrdNBT1hTC3JSfjXBXG94JSafNMplOG7aT
du+20pW4jD5YVsQtXa20budrYisrXQKfBK9bkgjdI4/xQtK1TGSTTFBuEzQhnPIk
WAzieJwJ0YfAbq31zoPuHDgyeWuMYYHmQZuEK8EuXuB7I7783PSzt9hjOjQ5kkyS
UGCL6J6Wbi2CMw6jT7kw98NoBmBdohNErUinxNloCQO7KtEaZmesMfX9wBJEcubK
/O83vtif5XRcMUjFRjdNKYeA/8WqqBBFLxNNlEjIq3vZFM4W7PKtAc5DwiOtwGHf
vCTCdKCz
=MWed
-----END PGP SIGNATURE-----

--YxCx89w9/NqkQGco--
