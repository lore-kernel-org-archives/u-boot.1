Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B688D3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10485891E3;
	Tue, 29 Oct 2024 16:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=xry111.site header.i=@xry111.site header.b="THAJWVmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9848912E; Tue, 29 Oct 2024 13:52:59 +0100 (CET)
Received: from xry111.site (xry111.site [89.208.246.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DED28912B
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 13:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xry111@xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
 s=default; t=1730206375;
 bh=2c8Vtu35HNC/3kwMq8yxR9mfWEOmECpwBxWDWlkQDYQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=THAJWVmHwy2reb4MJts6lzzws5xKXMO/elbkw9gDGZIGrytePA6wL6w7mxh8VbK0C
 e8i4ZSWX3tG1OvipAgwVOw2322TosQCMAcMB3AFmNQmt7MntdfQlKcpqLhyCDoTROG
 fTaXag00SB185Re28n++65NGOAS4g045PfG5YlW4=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1)
 server-digest SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@xry111.site)
 by xry111.site (Postfix) with ESMTPSA id 9BB8B1A3F67;
 Tue, 29 Oct 2024 08:52:54 -0400 (EDT)
Message-ID: <fc3dcef2676252484cfa427ad0197cd9aa697420.camel@xry111.site>
Subject: Re: [PATCH] libfdt: Fix build with swig 4.3.0
From: Xi Ruoyao <xry111@xry111.site>
To: Rudi Heitbaum <rudi@heitbaum.com>, u-boot@lists.denx.de
Cc: devicetree-compiler@vger.kernel.org
Date: Tue, 29 Oct 2024 20:52:52 +0800
In-Reply-To: <Zxzh0ODFyZnav5JE@74d70d9af7e3>
References: <Zxzh0ODFyZnav5JE@74d70d9af7e3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Oct 2024 16:18:23 +0100
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

On Sat, 2024-10-26 at 12:34 +0000, Rudi Heitbaum wrote:
> Call SWIG_AppendOutput instead of SWIG_Python_AppendOutput so that
> is_void is handled within swig.
>=20
> Link: https://github.com/swig/swig/commit/cd39cf132c96a0887be07c826b80804=
d7677a701
>=20
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>

Dtc is a separate project at
https://git.kernel.org/pub/scm/utils/dtc/dtc.git, so the patch should be
rebased against it and sent to devicetree-compiler@vger.kernel.org.

> ---
> =C2=A0scripts/dtc/pylibfdt/libfdt.i_shipped | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt=
/libfdt.i_shipped
> index 56cc5d48f4..e4659489a9 100644
> --- a/scripts/dtc/pylibfdt/libfdt.i_shipped
> +++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
> @@ -1037,7 +1037,7 @@ typedef uint32_t fdt32_t;
> =C2=A0			fdt_string(fdt1, fdt32_to_cpu($1->nameoff)));
> =C2=A0		buff =3D PyByteArray_FromStringAndSize(
> =C2=A0			(const char *)($1 + 1), fdt32_to_cpu($1->len));
> -		resultobj =3D SWIG_Python_AppendOutput(resultobj, buff);
> +		resultobj =3D SWIG_AppendOutput(resultobj, buff);
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -1076,7 +1076,7 @@ typedef uint32_t fdt32_t;
> =C2=A0
> =C2=A0%typemap(argout) int *depth {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PyObject *val =3D Py_Bui=
ldValue("i", *arg$argnum);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resultobj =3D SWIG_Python_App=
endOutput(resultobj, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resultobj =3D SWIG_AppendOutp=
ut(resultobj, val);
> =C2=A0}
> =C2=A0
> =C2=A0%apply int *depth { int *depth };
> @@ -1092,7 +1092,7 @@ typedef uint32_t fdt32_t;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (Py=
Tuple_GET_SIZE(resultobj) =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 resultobj =3D val;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 resultobj =3D SWIG_Python_AppendOutput(resultobj, val);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 resultobj =3D SWIG_AppendOutput(resultobj, val);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
