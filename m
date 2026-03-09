Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF6F417F3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF9383FEC;
	Mon,  9 Mar 2026 16:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QKNmxXms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E449283A8C; Mon,  9 Mar 2026 16:26:31 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D1F783FBC
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d743ba241aso888583a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773069986; x=1773674786; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AHW9CajAVwZ6OpiBcKV1r9Ul64P9B8us8ooOQZj5qp8=;
 b=QKNmxXms6Y/0jBYq4A1ZgxcCELD2/hZ2hV+Dmxc4sRmDZEo44QdDxEEsncXrAYirRX
 XrkK1jGtuANxQlKE8802DDJLQt9CZ3trTmySlKPvloVnyxA/gTRU3O38os5na5ellT2J
 zz0/jlezaOQhiFDu70OV95OhsBP4O3HDgdP1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069986; x=1773674786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHW9CajAVwZ6OpiBcKV1r9Ul64P9B8us8ooOQZj5qp8=;
 b=J4hhHsAapp24nHO2U9vyuxQXM+zDmYevTYJkozm/IDGjuXoiGUOwDjkryLiEwW35SP
 4MB63gJZLi6GXKLwBOrryScWQoYLTjwf+Y4kV9UmdUUjjhed3t6gh2B0EerS6rBQFru8
 LroFgiTE+INsZ5j4eYsfQjivEEhJqxyDAN2DCKSMzU+Ve6wPXVWUZ6F5xgzkI+FKmXxL
 l4Q+uOwmdLZF7gxbsgfurUiI7PAI1QyPwXZ4jUMU/RocxFPeWfL2fC5pX/XgJ0XzF7AL
 YYhihNKamsRcF1JktVYfzLpOl7ePFPNR7Y7ax061Ubsvyk9aO8G3OWIHYeGnIRIipsVo
 9/Ig==
X-Gm-Message-State: AOJu0YxrTRtSaraSLuyOcbG9dCwZYiDIvOYR8Ca9arEiJlmlT7LM3mGm
 tsftnXt80Z4OrfbdLGJVIGkU6W+dUiA46xY9kI2rc7wSE0GeQLGScjBGjhMJbG7NmzI=
X-Gm-Gg: ATEYQzxcAMkEtYZrH+qwNcmJ4uV5OE2DEdHUE/gvYR8UM1YxwAwFicPx+8gTCeprHNf
 eEkryrjnFn3fXD8xrcbTe69YNMVMVO0ovhKGvV/E72B06S+DxCV4hEf8++fkdI5vJbOULoaZCq9
 LpVqbgZGp01oWP220YWK5p+bqAFxMIT1sQ/869/dyeU7WN7h/ZyPld8elDXRYXYhCzy4QCt6xQ1
 g/IAqUcxbaGwwzG+cVOer6ojR5SyBTbQavwQn9xUNbBJB2EftM24c+LaoORc/ej4GEHnW3WfYBW
 Ee1zay07PQJFfQi8DwKPawW+tB0IPtVzldstafUy6zc+h1vlRVgUtJ0p/HNX5WVbH2PS7DBB9IH
 nyHY9D9vyTJ6JJPhJxO2kgBDsA5BP4UFKLn5t9xGIc2meRzIxMyVG50Zb90lpBk9GWAaju34beo
 AJAD02DJOuokGI9wwEgM/GH9kAdxo8ey1rQV7ilKxtrVY5RLDmc4QJAgD0aO08tBVDK/7wUCNZr
 7szEAhWlSMYXPQw6mv10eFJmDCjdgKPvk717cWOA5Cb/g==
X-Received: by 2002:a05:6830:718e:b0:7c7:5d8e:8b40 with SMTP id
 46e09a7af769-7d726ef1816mr6851295a34.5.1773069986237; 
 Mon, 09 Mar 2026 08:26:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d74062da77sm3625941a34.18.2026.03.09.08.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:26:25 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:26:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 0/5] Provide a class for building filesystem images
Message-ID: <20260309152623.GB1388590@bill-the-cat>
References: <20260309151307.831537-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WOsum4TokkugqPxn"
Content-Disposition: inline
In-Reply-To: <20260309151307.831537-1-sjg@chromium.org>
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


--WOsum4TokkugqPxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2026 at 09:12:59AM -0600, Simon Glass wrote:

> Create a class around mk_fs() to handle the common tasks of image
> creation, such as managing scratch directories and cleaning up.
>=20
> Start with a few small cleanups to mk_fs(), then convert the helper
> to use a class.

Thanks for working through all this. To be clear, per the usual rule of
thumb, this can go in the next branch in about 2 weeks, to give time for
others to give feedback as well.

--=20
Tom

--WOsum4TokkugqPxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaa7mnwAKCRAr4qD1Cr/k
CiXfAP4owgmhm/VhIMfq031EM+sLNyTocLAcOS80/rxjS98hvwEAnh8d6gxSFitQ
fNihMgJydJCdOvKGp5GLz/YP86Q4QAU=
=w9ev
-----END PGP SIGNATURE-----

--WOsum4TokkugqPxn--
