Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D7DC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 21:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9DA800B3;
	Mon,  3 Feb 2025 22:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n2Yudnjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D0F800CF; Mon,  3 Feb 2025 22:17:28 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA5780087
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 22:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b702c3c021so469535185a.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738617444; x=1739222244; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sF2g7nCC6N07un4reWPIw0egRuYVPgkmrc5trtANeqo=;
 b=n2YudnjsT/NBIDqCeN3FqNp7hXVlgqKi3Lss64O7J75Fau6UrZVDHz/2QQt2p3oviR
 t0qGWJt0TqPTeOFLKZLrSvVHAGzlDfWUTwibVln8zujURgPMt2UM67PP6vydFedaHzVm
 krJd4BW0krgi+9dCRp+oz5pcKiupcgkGp7/Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738617444; x=1739222244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF2g7nCC6N07un4reWPIw0egRuYVPgkmrc5trtANeqo=;
 b=dg7iuLyXiiQrR7oKYEgwF9Hf/b+23lXklqxxnQ9gSlCtuMFXKMStSD28CG3DKMi3Nu
 lzVQpo3gJTdaYlF5P/snJt5fiLKn3xDoekVCciCKxxchF0ZIcK+p0XmJKK7SjL4R54CK
 viyCdQOlLMtN4gmjwvUpw60qOUqw8GF1BI3kfxPMCagiRm8eGUZ+DDqg95o+Bl1vOPEK
 4+FgwqFc81G0Mw/KkFzpOzSDRa20Cw3sUAGMBh95yAZ8ywcSX2DnEdQrXQK8GtMTLz+a
 7Pv45vYQpbRYeXf8ySg3hdAHVOq+QfbglL6mbVmIu5Jxj+raq14WNfvkXU6xzkRyeeSU
 eZ+g==
X-Gm-Message-State: AOJu0YztR9ISStFMtWz8pfR/q9ozh+6xPjjcPLoqh11nys2lPbK4uXq4
 Wazwj/kYV26ZMYf3NxjMUuKOnXC6RG7DVHMuPyV9GrFYn79tlZ7d7e6ZnV6P3V8=
X-Gm-Gg: ASbGncsoGeNHF4Bwi4A7Lqz56SMar5jSmr82Vo6i7GF+iiHCBrJkO1tY3dmsga5mZqx
 T2Sw67swHoBlQ32CAEup7lR4x+CKsb6AKyjFpbryKa1uP1J0Evri7vkyLffjUi03xgpxedTwx59
 nrtUdxjV8vOrAAlyxEm/ckRz41erw5LlMKPNtT70EPtWYRYrhqcIusK/imS6xczVDjLEoDn5NGo
 TWizXXQ6+C5AqlzA+IOqHsKbGUMqXW5n1/Mj+nASo5++hYSYA9xbWLetPmDA1k6ePESU1vpwcrL
 8jUZumnPkthqwm4=
X-Google-Smtp-Source: AGHT+IFML25XEx9nNZtim/7vSr79EDNpyHEnPmJZjXJ6ALcjXorZhrMs+PWaF+sAx1yPhmipFuzvrg==
X-Received: by 2002:a05:620a:439b:b0:7b6:df08:367a with SMTP id
 af79cd13be357-7bffcce57a3mr3760272885a.23.1738617444675; 
 Mon, 03 Feb 2025 13:17:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90571csm567172585a.83.2025.02.03.13.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 13:17:23 -0800 (PST)
Date: Mon, 3 Feb 2025 15:17:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: u-boot@lists.denx.de, Manuel.Traut@mt.com, burak@gerz.io,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 0/4] FAT file renaming
Message-ID: <20250203211719.GX1233568@bill-the-cat>
References: <20250203102501.35750-1-Daniel.Venzin@mt.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y4XzwFAT8ianxl+P"
Content-Disposition: inline
In-Reply-To: <20250203102501.35750-1-Daniel.Venzin@mt.com>
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


--Y4XzwFAT8ianxl+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:24:47AM +0000, Daniel Venzin wrote:

>=20
> Rework of v1 posted by Burak Gerz [1].
>=20
> [1] https://lore.kernel.org/u-boot/20241212221427.GM1505244@bill-the-cat/
>=20
> Changes in v2:
> - Adapt variable names for better consistency
> - Add missing rename hooks
> - Use EFI_ACCESS_DENIED for unsuccessful renames
> - Avoid using of "=3D=3D 0"
> - Move the call to set_blk_dev earlier in the sequence
> - Refactor delete_dentry_long for improved reusability
> - Separate the rename implementation from changes in the filesystem layer
> - Eliminate code duplication with delete_dentry_long(..)
> - Ensure that the source file exists, but not the destination file
> - Free the fatbuf if it has been reinitialized with fat_itr_root
> - Delete orphaned FAT entry after copying file metadata

This is looking good. We just need some tests now. Ideally something
like adding test/py/tests/test_fs/test_rename.py and updating
test/py/tests/test_fs/conftest.py to have supported_fs_rename, in the
style of how symlink is handled via supported_fs_symlink and
test/py/tests/test_fs/test_symlink.py, thanks!

--=20
Tom

--Y4XzwFAT8ianxl+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehMlwACgkQFHw5/5Y0
tyxQJgv+ML9XUA2BRgyuXEixtmjzob6UqpaUt5bkrggHElOqMunJ+WVJyf53dyDR
UfM8YSPPfMNHDGV2m3kjZg8wNv/v+eE/eiV9hRBL9QJShU23DslIJ9YMGtn778jt
yTJOLYp+0UYL7alj2nw+QCRv5HEN8DJkHnbiJ7WFsp2eWd/JDzc1FHQ8SYagV4qp
+G9wNtINi//RMKWRklmPzIib+fHz2XYdgi9C5KlB42DtfiERc04iZInYQuTYCh1+
20tW/xhwcgQdtEg7XybWTZ4tctkBOMtSn4bFs8a0Obf1lZ05w+8egrw9xmcZFXIN
3dqWAiSEVBUC6fP0Jha8a+kx88DCL1rM/OyGtW7fFx/KqGxmQQUJSG2Uw4lwFnDg
rsCatxG0Y+awrmE7r/eKn+z9yd9PMzbCcWmdg0j8JqqgkgGcmDfmThoju8TyaWXK
IS4FyeLYyEefgugUSDpwXq/dfAoYm6YsqPey6HJYDE/4FcGLSfRXGqJB54C4kGBh
ZQmENPLD
=THa+
-----END PGP SIGNATURE-----

--Y4XzwFAT8ianxl+P--
